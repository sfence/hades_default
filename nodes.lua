
local S = default.translator

minetest.register_node("hades_default:sand", {
	description = S("Sand"),
	tiles = {"default_sand.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = hades_sounds.node_sound_sand_defaults(),
})

minetest.register_node("hades_default:desert_sand", {
	description = S("Desert Sand"),
	tiles = {"default_desert_sand.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = hades_sounds.node_sound_sand_defaults(),
})

-- this is used in Hades Revisited like limestone sand
minetest.register_node("hades_default:silver_sand", {
	description = S("Silver Sand"),
	tiles = {"default_silver_sand.png"},
	groups = {crumbly = 3, falling_node = 1, limestone_sand = 1},
	sounds = hades_sounds.node_sound_sand_defaults(),
})

minetest.register_node("hades_default:sandstone", {
	description = S("Sandstone"),
	tiles = {"default_orig_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = hades_sounds.node_sound_stone_defaults(),
})

minetest.register_node("hades_default:sandstonebrick", {
	description = S("Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_orig_sandstone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = hades_sounds.node_sound_stone_defaults(),
})

minetest.register_node("hades_default:sandstone_block", {
	description = S("Sandstone Block"),
	tiles = {"default_orig_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = hades_sounds.node_sound_stone_defaults(),
})

minetest.register_node("hades_default:desert_sandstone", {
	description = S("Desert Sandstone"),
	tiles = {"default_desert_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = hades_sounds.node_sound_stone_defaults(),
})

minetest.register_node("hades_default:desert_sandstone_brick", {
	description = S("Desert Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_desert_sandstone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = hades_sounds.node_sound_stone_defaults(),
})

minetest.register_node("hades_default:desert_sandstone_block", {
	description = S("Desert Sandstone Block"),
	tiles = {"default_desert_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = hades_sounds.node_sound_stone_defaults(),
})

minetest.register_node("hades_default:silver_sandstone", {
	description = S("Silver Sandstone"),
	tiles = {"default_silver_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = hades_sounds.node_sound_stone_defaults(),
})

minetest.register_node("hades_default:silver_sandstone_brick", {
	description = S("Silver Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_silver_sandstone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = hades_sounds.node_sound_stone_defaults(),
})

minetest.register_node("hades_default:silver_sandstone_block", {
	description = S("Silver Sandstone Block"),
	tiles = {"default_silver_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = hades_sounds.node_sound_stone_defaults(),
})

