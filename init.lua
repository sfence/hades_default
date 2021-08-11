
default = {
  translator = minetest.get_translator("default"),
}

local modpath = minetest.get_modpath(minetest.get_current_modname())

dofile(modpath.."/functions.lua")
dofile(modpath.."/nodes.lua")
dofile(modpath.."/crafting.lua")

