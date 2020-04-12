return {
	minioncan = {
		acceleration = 0.45,
		brakerate = 1,
		buildcostenergy = 9300,
		buildcostmetal = 560,
		buildpic = "CORCAN.PNG",
		buildtime = 11734,
		canmove = true,
		category = "KBOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE EMPABLE",
		collisionvolumeoffsets = "0.0 0.0 0.0",
		collisionvolumescales = "28.0 27.0 25.0",
		collisionvolumetype = "box",
		corpse = "",
		description = "Armored Assault Kbot",
		energymake = 7.5,
		energystorage = 25,
		explodeas = "mediumexplosiongeneric",
		footprintx = 2,
		footprintz = 2,
		idleautoheal = 5,
		idletime = 1800,
		maxdamage = 4850,
		maxslope = 17,
		maxvelocity = 1,
		maxwaterdepth = 25,
		movementclass = "KBOT3",
		name = "Can",
		nochasecategory = "VTOL",
		objectname = "Units/CORCAN.s3o",
		script = "Units/CORCAN.cob",
		seismicsignature = 0,
		selfdestructas = "mediumExplosionGenericSelfd",
		sightdistance = 350,
		turninplace = true,
		turninplaceanglelimit = 90,
		turninplacespeedlimit = 1.9,
		turnrate = 1400,
		upright = true,
		customparams = {
			model_author = "FireStorm",
			normaltex = "unittextures/Core_normal.dds",
			subfolder = "other/minions/land/t2",
			techlevel = 2,
		},
		featuredefs = {
			dead = {
				blocking = true,
				category = "corpses",
				collisionvolumeoffsets = "0.220962524414 -3.57609763184 -0.162803649902",
				collisionvolumescales = "39.2589111328 21.1636047363 24.3341522217",
				collisionvolumetype = "Box",
				damage = 3500,
				description = "Can Wreckage",
				energy = 0,
				featuredead = "HEAP",
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 20,
				hitdensity = 100,
				metal = 339,
				object = "Units/corcan_dead.s3o",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
			heap = {
				blocking = false,
				category = "heaps",
				collisionvolumescales = "35.0 4.0 6.0",
				collisionvolumetype = "cylY",
				damage = 2500,
				description = "Can Heap",
				energy = 0,
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 4,
				hitdensity = 100,
				metal = 136,
				object = "Units/cor2X2F.s3o",
				reclaimable = true,
				resurrectable = 0,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
		},
		sfxtypes = {
			pieceexplosiongenerators = {
				[1] = "deathceg2",
				[2] = "deathceg3",
				[3] = "deathceg4",
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
			core_canlaser = {
				areaofeffect = 8,
				avoidfeature = false,
				beamtime = 0.15,
				corethickness = 0.2,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.15,
				energypershot = 75,
				explosiongenerator = "custom:laserhit-medium-green",
				firestarter = 90,
				impactonly = 1,
				impulseboost = 0,
				impulsefactor = 0,
				laserflaresize = 7.7,
				name = "HighEnergyLaser",
				noselfdamage = true,
				range = 275,
				reloadtime = 0.8,
				rgbcolor = "0 1 0",
				soundhitdry = "",
				soundhitwet = "sizzle",
				soundstart = "lasrhvy3",
				soundtrigger = 1,
				targetmoveerror = 0.2,
				thickness = 2.7,
				tolerance = 10000,
				turret = true,
				weapontype = "BeamLaser",
				weaponvelocity = 700,
				damage = {
					bombers = 5,
					default = 275,
					fighters = 5,
					subs = 5,
					vtol = 5,
				},
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "VTOL",
				def = "CORE_CANLASER",
				onlytargetcategory = "NOTSUB",
			},
		},
	},
}