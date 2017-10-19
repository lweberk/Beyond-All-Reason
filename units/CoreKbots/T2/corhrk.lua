return {
	corhrk = {
		acceleration = 0.11,
		brakerate = 0.564,
		buildcostenergy = 5800,
		buildcostmetal = 600,
		buildpic = "CORHRK.DDS",
		buildtime = 6600,
		canmove = true,
		category = "KBOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE",
		collisionvolumeoffsets = "0 1 -1",
		collisionvolumescales = "26 31 33",
		collisionvolumetype = "Box",
		corpse = "DEAD",
		description = "Heavy Rocket Kbot",
		energymake = 0.6,
		energyuse = 0.6,
		explodeas = "mediumexplosiongeneric",
		footprintx = 2,
		footprintz = 2,
		idleautoheal = 5,
		idletime = 1800,
		maxdamage = 550,
		maxslope = 14,
		maxvelocity = 1.8,
		maxwaterdepth = 21,
		movementclass = "KBOT2",
		name = "Dominator",
		nochasecategory = "VTOL",
		objectname = "CORHRK",
		seismicsignature = 0,
		selfdestructas = "mediumExplosionGenericSelfd",
		sightdistance = 370.5,
		turninplaceanglelimit = 140,
		turninplacespeedlimit = 1.188,
		turnrate = 1103,
		upright = true,
		customparams = {
			
		},
		featuredefs = {
			dead = {
				blocking = true,
				category = "corpses",
				collisionvolumeoffsets = "0.59033203125 -0.11500802002 -0.125",
				collisionvolumescales = "31.73046875 27.05418396 31.9737854004",
				collisionvolumetype = "Box",
				damage = 450,
				description = "Dominator Wreckage",
				energy = 0,
				featuredead = "HEAP",
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 20,
				hitdensity = 100,
				metal = 194,
				object = "CORHRK_DEAD",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
			heap = {
				blocking = false,
				category = "heaps",
				damage = 350,
				description = "Dominator Heap",
				energy = 0,
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 4,
				hitdensity = 100,
				metal = 78,
				object = "2X2B",
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
				[1] = "kbcormov",
			},
			select = {
				[1] = "kbcorsel",
			},
		},
		weapondefs = {
			corhrk_rocket = {
				areaofeffect = 70,
				avoidfeature = false,
				craterareaofeffect = 70,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.46,
				cegTag = "missiletrailmedium",
				explosiongenerator = "custom:genericshellexplosion-large",
				firestarter = 100,
				flighttime = 6.6,
				impulseboost = 0.123,
				impulsefactor = 0.123,
				metalpershot = 0,
				model = "corkbmissl1",
				name = "HeavyRockets",
				noselfdamage = true,
				range = 1210,
				reloadtime = 8,
				soundhit = "xplomed4",
				soundhitwet = "splssml",
				soundhitwetvolume = 0.5,
				soundstart = "Rockhvy1",
				smoketrail = false,
                texture1 = "trans",
				texture2 = "null",
				texture3 = "null",
				turnrate = 28384,
				weaponacceleration = 100,
				weapontimer = 3,
				weapontype = "StarburstLauncher",
				weaponvelocity = 800,
				damage = {
					default = 800,
					--subs = 5,
				},
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "MOBILE",
				def = "CORHRK_ROCKET",
				onlytargetcategory = "SURFACE",
			},
		},
	},
}
