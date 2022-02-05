
local S = default.translator

if minetest.get_modpath("hades_moreblocks") then
  local names = {
    "sandstone",
    "silver_sandstone",
    "desert_sandstone",
    "sandstonebrick",
    "silver_sandstone_brick",
    "desert_sandstone_brick",
  }
  local mod = minetest.get_current_modname()
  for _,name in pairs(names) do
    local nodename = mod..":"..name
	  local ndef = table.copy(minetest.registered_nodes[nodename])
    ndef.paramtype = "light"
	  stairsplus:register_all(mod, name, nodename, ndef)
  end
end

