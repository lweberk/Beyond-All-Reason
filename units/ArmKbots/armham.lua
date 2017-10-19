return {
	armham = {
		acceleration = 0.12,
		brakerate = 0.675,
		buildcostenergy = 1300,
		buildcostmetal = 130,
		buildpic = "ARMHAM.DDS",
		buildtime = 2210,
		canmove = true,
		category = "KBOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE",
		collisionvolumeoffsets = "0 -2 0",
		collisionvolumescales = "29 28 29",
		collisionvolumetype = "CylY",
		corpse = "DEAD",
		description = "Light Plasma Kbot",
		energymake = 0.6,
		energyuse = 0.6,
		explodeas = "smallexplosiongeneric",
		footprintx = 2,
		footprintz = 2,
		idleautoheal = 5,
		idletime = 1800,
		mass = 300,
		maxdamage = 810,
		maxslope = 14,
		maxvelocity = 1.54,
		maxwaterdepth = 12,
		movementclass = "KBOT2",
		name = "Hammer",
		nochasecategory = "VTOL",
		objectname = "ARMHAM",
		seismicsignature = 0,
		selfdestructas = "smallExplosionGenericSelfd",
		sightdistance = 380,
		turninplaceanglelimit = 140,
		turninplacespeedlimit = 1.0164,
		turnrate = 1094,
		upright = true,
		customparams = {
			description_long = "The Hammer is a plasma Kbot that can deal a sizeable damage with relatively low cost of building. It has a shorter range than rocket Kbots, but if you manage to reach them, it can easily eliminate them. It has slightly higher HP than rocket Kbots, hence it can be used in big numbers to destroy T1 defensive structures. Combine with resurrection Kbots (Rectors), for healing and resurrecting fallen units, to quickly push the frontline. Effective for defending mountain tops, as their range is longer when shooting downhill. Watch out for Heavy Laser Turrets",  
		},
		featuredefs = {
			dead = {
				blocking = true,
				category = "corpses",
				collisionvolumeoffsets = "1.85908508301 -3.40689422363 2.59911346436",
				collisionvolumescales = "31.0182495117 8.18759155273 36.3284454346",
				collisionvolumetype = "Box",
				damage = 586,
				description = "Hammer Wreckage",
				energy = 0,
				featuredead = "HEAP",
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 40,
				hitdensity = 100,
				metal = 79,
				object = "ARMHAM_DEAD",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
			heap = {
				blocking = false,
				category = "heaps",
				damage = 343,
				description = "Hammer Heap",
				energy = 0,
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 4,
				hitdensity = 100,
				metal = 32,
				object = "2X2E",
                collisionvolumescales = "35.0 4.0 6.0",
                collisionvolumetype = "cylY",
				reclaimable = true,
				resurrectable = 0,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
		},
		sfxtypes = { 
 			pieceExplosionGenerators = { 
				"deathceg2",
				"deathceg3",
				"deathceg4",
			},
			explosiongenerators = {
				[1] = "custom:barrelshot-small",
			},
		},
		sounds = {
			canceldestruct = "cancel2",
			underattack = "warning1",
			cant = {
				[1] = "cantdo4",
			},
			count = {
				[1] = "count6",
				[2] = "count5",
				[3] = "count4",
				[4] = "count3",
				[5] = "count2",
				[6] = "count1",
			},
			ok = {
				[1] = "kbarmmov",
			},
			select = {
				[1] = "kbarmsel",
			},
		},
		weapondefs = {
			arm_ham = {
				areaofeffect = 36,
				avoidfeature = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				explosiongenerator = "custom:genericshellexplosion-small",
				gravityaffected = "true",
				impulseboost = 0.123,
				impulsefactor = 0.123,
				name = "PlasmaCannon",
				noselfdamage = true,
				predictboost = 0.4,
				range = 380,
				reloadtime = 1.75,
				soundhit = "xplomed3",
				soundhitwet = "splshbig",
				soundhitwetvolume = 0.5,
				soundstart = "cannon1",
				turret = true,
				weapontype = "Cannon",
				weaponvelocity = 243,
				damage = {
					bombers = 21,
					default = 104,
					fighters = 21,
					--subs = 5,
					vtol = 21,
				},
			},
			arm_ham2 = {
				areaofeffect = 36,
				avoidfeature = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cylinderTargeting = 1,
				cratermult = 0,
				explosiongenerator = "custom:genericshellexplosion-small",
				gravityaffected = "true",
				impulseboost = 0.123,
				impulsefactor = 0.123,
				name = "PlasmaCannon",
				noselfdamage = true,
				predictboost = 0.4,
				range = 380*0.85,
				reloadtime = 1.75,
				soundhit = "xplomed3",
				hightrajectory = 1,
				soundhitwet = "splshbig",
				soundhitwetvolume = 0.5,
				soundstart = "cannon1",
				turret = true,
				weapontype = "Cannon",
				weaponvelocity = 243*0.85,
				damage = {
					bombers = 21,
					default = 104,
					fighters = 21,
					--subs = 5,
					vtol = 21,
				},
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "VTOL",
				def = "ARM_HAM",
				onlytargetcategory = "",
			},
			[2] = {
				badtargetcategory = "VTOL",
				def = "ARM_HAM2",
				slavedto = 1,
				onlytargetcategory = "",
			},
		},
	},
}
