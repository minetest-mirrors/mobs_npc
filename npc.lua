local S = mobs_npc.S

-- Npc by TenPlus1

mobs_npc.npc_drops = {
	{"default:pick_steel", 2}, "mobs:meat", {"default:sword_steel", 2},
	{"default:shovel_steel", 2}, "farming:bread", "bucket:bucket_water",
	"default:sapling", "default:tree", "mobs:leather", "default:coral_orange",
	{"default:mese_crystal_fragment", 3}, "default:clay", {"default:sign_wall", 2},
	"default:ladder", "default:copper_lump", "default:blueberries",
	"default:aspen_sapling", "default:permafrost_with_moss"
}


mobs:register_mob("mobs_npc:npc", {
	type = "npc",
	passive = false,
	damage = 3,
	attack_type = "dogfight",
	attacks_monsters = true,
	attack_npcs = false,
	owner_loyal = true,
	pathfinding = true,
	hp_min = 10,
	hp_max = 20,
	armor = 100,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "mobs_character.b3d",
	drawtype = "front",
	textures = {
		{"mobs_npc.png"},
		{"mobs_npc2.png"}, -- female by nuttmeg20
		{"mobs_npc3.png"}, -- male by swagman181818
		{"mobs_npc4.png"}, -- female by Sapphire16
		{"mobs_npc5.png"}, -- male by Astrobe
		{"mobs_npc6.png"} -- female by Astrobe
	},
	child_texture = {
		{"mobs_npc_baby.png"} -- derpy baby by AmirDerAssassine
	},
	makes_footstep_sound = true,
	sounds = {},
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	drops = {
		{name = "default:wood", chance = 1, min = 1, max = 3},
		{name = "default:apple", chance = 2, min = 1, max = 2},
		{name = "default:axe_stone", chance = 5, min = 1, max = 1}
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	follow = {"farming:bread", "mobs:meat", "default:diamond"},
	view_range = 15,
	owner = "",
	order = "wander",
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

	on_rightclick = function(self, clicker)

		-- feed to heal npc
		if mobs:feed_tame(self, clicker, 8, true, true) then return end

		-- capture npc with net or lasso
		if mobs:capture_mob(self, clicker, nil, 5, 80, false, nil) then return end

		-- protect npc with mobs:protector
		if mobs:protect(self, clicker) then return end

		local item = clicker:get_wielded_item()
		local name = clicker:get_player_name()

		-- right clicking with gold lump drops random item from list
		if 	mobs_npc.drop_trade(self, clicker, "default:gold_lump",
				self.npc_drops or mobs_npc.npc_drops) then
			return
		end

		-- owner can right-click with stick to show control formspec
		if item:get_name() == "default:stick"
		and (self.owner == name or
		minetest.check_player_privs(clicker, {protection_bypass = true}) )then

			minetest.show_formspec(name, "mobs_npc:controls",
					mobs_npc.get_controls_formspec(name, self))

			return
		end

		-- show simple dialog if enabled or idle chatter
		if mobs_npc.useDialogs == "Y" then
			simple_dialogs.show_dialog_formspec(name, self)
		else
			if self.state == "attack" then
				mobs_npc.npc_talk(self, clicker, {"Grr!"})
			else
				mobs_npc.npc_talk(self, clicker, {
					"Hello", "Hi there", "What a lovely day"})
			end
		end
	end
})


-- register spawn egg
mobs:register_egg("mobs_npc:npc", S("Npc"), "default_brick.png", 1)


-- this is only needed for servers that used the old mobs mod
mobs:alias_mob("mobs:npc", "mobs_npc:npc")


-- spawn NPC in world
if not mobs.custom_spawn_npc then

	mobs:spawn({
		name = "mobs_npc:npc",
		nodes = {"default:brick"},
		neighbors = {"default:grass_3"},
		min_light = 10,
		chance = 10000,
		active_object_count = 1,
		min_height = 0,
		day_toggle = true
	})
end
