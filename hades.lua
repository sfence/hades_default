
local S = default.translator

local function add_metamorphosis_report(node_name, report)
  local def = minetest.registered_nodes[node_name]
  if def._metamorphosis_report then
    report = def._metamorphosis_report.."\n\n"..report
  end
  minetest.override_item(node_name, {
      _metamorphosis_report = report
    })
end

function half_time_calc(interval, chance, treshold)
  local steps = math.log(0.5)/math.log((chance-1)/chance)
  -- 1.41 like calculation error compensation for param_treshold 15
  return math.floor(1.41*(treshold+1)*steps*interval/360+0.5)/10
end

local param_treshold = 15

-- sand
-- from gravel
minetest.register_abm({
  label = "Create sand",
  nodenames = {"hades_core:gravel"},
	neighbors = {"hades_core:water_flowing"},
	interval = 359,
	chance = 83,
  action = function(pos, node)
    if (minetest.find_node_near(pos, 1, {"group:lava"}) == nil) then
			node.param1 = node.param1 + 1
			if (node.param1>param_treshold) then
				minetest.set_node(pos, {name="hades_default:sand"})
			else
				minetest.swap_node(pos, node)
			end
		end
	end,
})

add_metamorphosis_report("hades_core:gravel",
    string.format(S("Gravel metamorphoses into sand. It requires contact with flowing water and without lava. Half-metamorphose time is %i hours."),half_time_calc(359, 83, param_treshold+1))
  )

add_metamorphosis_report("hades_default:sand", 
    S("Sand arise by metamorphosis from gravel.")
  )

-- desert sand
-- from volcanic gravel
minetest.register_abm({
  label = "Create desert sand",
  nodenames = {"hades_core:gravel_volcanic"},
	neighbors = {"hades_core:water_flowing"},
	interval = 353,
	chance = 79,
  action = function(pos, node)
    if (minetest.find_node_near(pos, 2, {"group:lava"}) == nil) then
			node.param1 = node.param1 + 1
			if (node.param1>param_treshold) then
				minetest.set_node(pos, {name="hades_default:desert_sand"})
			else
				minetest.swap_node(pos, node)
			end
		end
	end,
})

add_metamorphosis_report("hades_core:gravel_volcanic",
    string.format(S("Volcanic gravel metamorphoses into desert sand. It requires contact with water and without lava near (up to 2 nodes). Half-metamorphose time is %i hours."),half_time_calc(353, 79, param_treshold+1))
  )

add_metamorphosis_report("hades_default:desert_sand", 
    S("Desert sand arise by metamorphosis from volcanic gravel.")
  )

-- silver sand
-- from volcanic gravel
local marble_param_treshold = 32
minetest.register_abm({
  label = "Create silver sand",
  nodenames = {"hades_core:marble"},
	neighbors = {"hades_core:water_flowing"},
	interval = 347,
	chance = 89,
  action = function(pos, node)
    if (minetest.find_node_near(pos, 2, {"group:lava"}) == nil) then
			node.param1 = node.param1 + 1
			if (node.param1>marble_param_treshold) then
				minetest.set_node(pos, {name="hades_default:silver_sand"})
			else
				minetest.swap_node(pos, node)
			end
		end
	end,
})

add_metamorphosis_report("hades_core:marble",
    string.format(S("Marble metamorphoses into silver sand. It requires contact with flowing water without lava near (up to 2 nodes). Half-metamorphose time is %i hours."),half_time_calc(347, 89, marble_param_treshold+1))
  )

add_metamorphosis_report("hades_default:silver_sand", 
    S("Silver sand arise by metamorphosis from marble.")
  )

