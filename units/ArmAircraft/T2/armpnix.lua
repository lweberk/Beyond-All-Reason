return {
	armpnix = {
		acceleration = 0.20,
		brakerate = 0.1,
		buildcostenergy = 12500,
		buildcostmetal = 230,
		buildpic = "ARMPNIX.DDS",
		buildtime = 21000,
		canfly = true,
		canmove = true,
		category = "ALL NOTLAND MOBILE WEAPON NOTSUB ANTIFLAME ANTIEMG ANTILASER VTOL NOTSHIP NOTHOVER",
		collide = true,
		cruisealt = 220,
		description = "Strategic Bomber",
		energymake = 1.8,
		energyuse = 1.8,
		explodeas = "largeexplosiongeneric",
		footprintx = 3,
		footprintz = 3,
		icontype = "air",
		idleautoheal = 5,
		idletime = 1800,
		maxdamage = 1020,
		maxslope = 10,
		maxvelocity = 8.6,
		maxwaterdepth = 0,
		name = "Phoenix",
		noautofire = true,
		nochasecategory = "VTOL",
		objectname = "ARMPNIX",
		seismicsignature = 0,
		selfdestructas = "largeExplosionGenericSelfd",
		sightdistance = 260,
		turnrate = 600,
		blocking = false,
		customparams = {
		wingsurface = 0.65,
		},
		sfxtypes = { 
 			pieceExplosionGenerators = { 
				"deathceg3",
				"deathceg4",
				"deathceg2",
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
				[1] = "vtolarmv",
			},
			select = {
				[1] = "vtolarac",
			},
		},
		weapondefs = {
			armadvbomb = {
				areaofeffect = 168,
				avoidfeature = false,
				burst = 5,
				burstrate = 0.2,
				collidefriendly = false,
				commandfire = false,
				craterareaofeffect = 168,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.7,
				explosiongenerator = "custom:genericshellexplosion-large-dirty",
				gravityaffected = "true",
				impulseboost = 0.123,
				impulsefactor = 0.123,
				model = "bomb2",
				mygravity = 0.4,
				name = "AdvancedBombs",
				noselfdamage = true,
				range = 1280,
				reloadtime = 7,
				soundhit = "xplomed2",
				soundhitwet = "splslrg",
				soundhitwetvolume = 0.5,
				soundstart = "bombrel",
				weapontype = "AircraftBomb",
				damage = {
					antibomber = 100,
					default = 266,
					l1bombers = 5,
					--subs = 5,
				},
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "MOBILE",
				def = "ARMADVBOMB",
				onlytargetcategory = "",
			},
		},
	},
}
