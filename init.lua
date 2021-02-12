-- fake some functions


default = {}


default.gui_bg     = ""
default.gui_bg_img = ""
default.gui_slots  = ""

function default.get_hotbar_bg(x,y)
 local out = ""
 for i=0,7,1 do
  out = out .."image["..x+i..","..y..";1,1;gui_hb_bg.png]"
 end
 return out
end

default.gui_survival_form = "size[8,8.5]"..
   "list[current_player;main;0,4.25;8,1;]"..
   "list[current_player;main;0,5.5;8,3;8]"..
   "list[current_player;craft;1.75,0.5;3,3;]"..
   "list[current_player;craftpreview;5.75,1.5;1,1;]"..
   "image[4.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
   "listring[current_player;main]"..
   "listring[current_player;craft]"..
   default.get_hotbar_bg(0,4.25)

--
-- Optimized helper to put all items in an inventory into a drops list
--

function default.get_inventory_drops(pos, inventory, drops)
 local inv = minetest.get_meta(pos):get_inventory()
 local n = #drops
 for i = 1, inv:get_size(inventory) do
  local stack = inv:get_stack(inventory, i)
  if stack:get_count() > 0 then
   drops[n+1] = stack:to_table()
   n = n + 1
  end
 end
end

--
-- NOTICE: This method is not an official part of the API yet.
-- This method may change in future.
--

function default.can_interact_with_node(player, pos)
 if player and player:is_player() then
  return true
 else
  return false
 end
end

--
-- NOTICE: This method is not an official part of the API yet.
-- This method may change in future.
--

function default.can_interact_with_node(player, pos)
 if player and player:is_player() then
  if minetest.check_player_privs(player, "protection_bypass") then
   return true
  end
 else
  return false
 end

 local meta = minetest.get_meta(pos)
 local owner = meta:get_string("owner")

 if not owner or owner == "" or owner == player:get_player_name() then
  return true
 end
 
 -- no key support

 return false
end
--
-- Grow trees from saplings
--

-- 'can grow' function

function default.can_grow(pos)
	local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
	if not node_under then
		return false
	end
	if minetest.get_item_group(node_under.name, "soil") == 0 then
		return false
	end
	local light_level = minetest.get_node_light(pos)
	if not light_level or light_level < 13 then
		return false
	end
	return true
end

--
-- Sapling 'on place' function to check protection of node and resulting tree volume
--

function default.sapling_on_place(itemstack, placer, pointed_thing,
		sapling_name, minp_relative, maxp_relative, interval)
	-- Position of sapling
	local pos = pointed_thing.under
	local node = minetest.get_node_or_nil(pos)
	local pdef = node and minetest.registered_nodes[node.name]

	if pdef and pdef.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
		return pdef.on_rightclick(pos, node, placer, itemstack, pointed_thing)
	end

	if not pdef or not pdef.buildable_to then
		pos = pointed_thing.above
		node = minetest.get_node_or_nil(pos)
		pdef = node and minetest.registered_nodes[node.name]
		if not pdef or not pdef.buildable_to then
			return itemstack
		end
	end

	local player_name = placer and placer:get_player_name() or ""
	-- Check sapling position for protection
	if minetest.is_protected(pos, player_name) then
		minetest.record_protection_violation(pos, player_name)
		return itemstack
	end
	-- Check tree volume for protection
	if minetest.is_area_protected(
			vector.add(pos, minp_relative),
			vector.add(pos, maxp_relative),
			player_name,
			interval) then
		minetest.record_protection_violation(pos, player_name)
		-- Print extra information to explain
--		minetest.chat_send_player(player_name,
--			itemstack:get_definition().description .. " will intersect protection " ..
--			"on growth")
		minetest.chat_send_player(player_name,
		    S("@1 will intersect protection on growth.",
			itemstack:get_definition().description))
		return itemstack
	end

	minetest.log("action", player_name .. " places node "
			.. sapling_name .. " at " .. minetest.pos_to_string(pos))

	local take_item = not minetest.is_creative_enabled(player_name)
	local newnode = {name = sapling_name}
	local ndef = minetest.registered_nodes[sapling_name]
	minetest.set_node(pos, newnode)

	-- Run callback
	if ndef and ndef.after_place_node then
		-- Deepcopy place_to and pointed_thing because callback can modify it
		if ndef.after_place_node(table.copy(pos), placer,
				itemstack, table.copy(pointed_thing)) then
			take_item = false
		end
	end

	-- Run script hook
	for _, callback in ipairs(minetest.registered_on_placenodes) do
		-- Deepcopy pos, node and pointed_thing because callback can modify them
		if callback(table.copy(pos), table.copy(newnode),
				placer, table.copy(node or {}),
				itemstack, table.copy(pointed_thing)) then
			take_item = false
		end
	end

	if take_item then
		itemstack:take_item()
	end

	return itemstack
end

--
-- Dig upwards
--

function default.dig_up(pos, node, digger)
	if digger == nil then return end
	local np = {x = pos.x, y = pos.y + 1, z = pos.z}
	local nn = minetest.get_node(np)
	if nn.name == node.name then
		minetest.node_dig(np, nn, digger)
	end
end

