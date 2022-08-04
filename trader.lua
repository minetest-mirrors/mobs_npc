
local S = mobs_npc.S

-- define table containing names for use and shop items for sale

mobs.human = {

	names = {
		"Bob", "Duncan", "Bill", "Tom", "James", "Ian", "Lenny",
		"Dylan", "Ethan"
	},

	items = {
		--{item for sale, price, chance of appearing in trader's inventory}
		{"default:apple 10", "default:gold_ingot 2", 10},
		{"farming:bread 10", "default:gold_ingot 4", 5},
		{"default:clay 10", "default:gold_ingot 2", 12},
		{"default:brick 10", "default:gold_ingot 4", 17},
		{"default:glass 10", "default:gold_ingot 4", 17},
		{"default:obsidian 10", "default:gold_ingot 15", 50},
		{"default:diamond 1", "default:gold_ingot 5", 40},
		{"farming:wheat 10", "default:gold_ingot 2", 17},
		{"default:tree 5", "default:gold_ingot 4", 20},
		{"default:stone 10", "default:gold_ingot 8", 17},
		{"default:desert_stone 10", "default:gold_ingot 8", 27},
		{"default:sapling 1", "default:gold_ingot 1", 7},
		{"default:pick_steel 1", "default:gold_ingot 2", 7},
		{"default:sword_steel 1", "default:gold_ingot 2", 17},
		{"default:shovel_steel 1", "default:gold_ingot 1", 17},
		{"default:cactus 2", "default:gold_ingot 2", 40},
		{"default:papyrus 2", "default:gold_ingot 2", 40},
		{"default:mese_crystal_fragment 1", "default:dirt_with_grass 10", 90},
		{"default:mese_crystal_fragment 1", "default:gold_ingot 5", 90}
	}
}

-- Trader (same as NPC but with right-click shop)

mobs:register_mob("mobs_npc:trader", {
	type = "npc",
	passive = false,
	damage = 3,
	attack_type = "dogfight",
	attacks_monsters = true,
	attack_animals = false,
	attack_npcs = false,
	pathfinding = false,
	hp_min = 10,
	hp_max = 20,
	armor = 100,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "mobs_character.b3d",
	textures = {
		{"mobs_trader.png"}, -- by Frerin
		{"mobs_trader2.png"},
		{"mobs_trader3.png"}
	},
	makes_footstep_sound = true,
	sounds = {},
	walk_velocity = 2,
	run_velocity = 3,
	jump = false,
	drops = {},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	follow = {"default:diamond"},
	view_range = 15,
	owner = "",
	order = "stand",
	fear_height = 3,
	animation = {
		speed_normal = 30,
		speed_run = 30,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 200,
		punch_end = 219
	},

	-- stop attacking on right-click and open shop
	on_rightclick = function(self, clicker)
		self.attack = nil
		mobs_npc.shop_trade(self, clicker, mobs.human)
	end,

	-- show that npc is a trader once spawned
	on_spawn = function(self)

		self.nametag = S("Trader")

		self.object:set_properties({
			nametag = self.nametag,
			nametag_color = "#FFFFFF"
		})

		return true -- return true so on_spawn is run once only
	end
})


-- add spawn egg
mobs:register_egg("mobs_npc:trader", S("Trader"), "default_sandstone.png", 1)


-- this is only required for servers that used the old mobs mod
mobs:alias_mob("mobs:trader", "mobs_npc:trader")


-- spawn trader in world
if not mobs.custom_spawn_npc then
mobs:spawn({
	name = "mobs_npc:trader",
	nodes = {"default:diamondblock"},
	neighbors = {"default:brick"},
	min_light = 10,
	chance = 10000,
	active_object_count = 1,
	min_height = 0,
	day_toggle = true,
})
end
