return {
	corvipe = {
		acceleration = 0,
		brakerate = 0,
		buildangle = 8192,
		buildcostenergy = 14016,
		buildcostmetal = 730,
		buildinggrounddecaldecayspeed = 30,
		buildinggrounddecalsizex = 5,
		buildinggrounddecalsizey = 5,
		buildinggrounddecaltype = "corvipe_aoplane.dds",
		buildpic = "CORVIPE.DDS",
		buildtime = 15035,
		category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE",
		corpse = "DEAD",
		damagemodifier = 0.5,
		description = "Pop-up Sabot Battery",
		explodeas = "mediumBuildingExplosionGenericRed",
		footprintx = 3,
		footprintz = 3,
		icontype = "building",
		idleautoheal = 5,
		idletime = 1800,
		maxdamage = 2719,
		maxslope = 10,
		maxwaterdepth = 0,
		name = "Viper",
		nochasecategory = "MOBILE",
		objectname = "CORVIPE",
		seismicsignature = 0,
		selfdestructas = "mediumBuildingExplosionGenericRed",
		sightdistance = 546,
		usebuildinggrounddecal = true,
		usepiececollisionvolumes = 1,
		yardmap = "ooooooooo",
		customparams = {
			death_sounds = "generic",
		},
		featuredefs = {
			dead = {
				blocking = true,
				category = "corpses",
				collisionvolumeoffsets = "-2.7282333374 -4.31274414048e-05 -3.87004852295",
				collisionvolumescales = "42.4275054932 38.4097137451 38.8498077393",
				collisionvolumetype = "Box",
				damage = 1631,
				description = "Viper Wreckage",
				energy = 0,
				featuredead = "HEAP",
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 20,
				hitdensity = 100,
				metal = 380,
				object = "CORVIPE_DEAD",
				reclaimable = true,
				seqnamereclamate = "TREE1RECLAMATE",
				world = "All Worlds",
			},
			heap = {
				blocking = false,
				category = "heaps",
				damage = 408,
				description = "Viper Heap",
				energy = 0,
				featurereclamate = "SMUDGE01",
				footprintx = 2,
				footprintz = 2,
				height = 4,
				hitdensity = 100,
				metal = 61,
				object = "2X2F",
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
				"deathceg3",
				"deathceg4",
			},
		},
		sounds = {
			canceldestruct = "cancel2",
			cloak = "kloak2",
			uncloak = "kloak2un",
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
				[1] = "servmed1",
			},
			select = {
				[1] = "servmed1",
			},
		},
		weapondefs = {
			vipersabot = {
				areaofeffect = 24,
				avoidfeature = false,
				burnblow = true,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				cegTag = "missiletrailmedium",
				explosiongenerator = "custom:genericshellexplosion-large",
				firestarter = 70,
				impulseboost = 0.123,
				impulsefactor = 0.123,
				model = "missile",
				name = "Sabot",
				noselfdamage = true,
				range = 730,
				reloadtime = 2,
				smoketrail = false,
				soundhit = "SabotHit",
				soundhitwet = "splshbig",
				soundhitwetvolume = 0.5,
				soundstart = "SabotFire",
				startvelocity = 300,
				targetmoveerror = 0.2,
				texture2 = "coresmoketrail",
				tolerance = 8000,
				tracks = true,
				turnrate = 4000,
				turret = true,
				weaponacceleration = 300,
				weapontimer = 0.1,
				weapontype = "MissileLauncher",
				weaponvelocity = 850,
				damage = {
					bombers = 26,
					default = 825,
					fighters = 26,
					subs = 5,
					vtol = 26,
				},
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "VTOL GROUNDSCOUT",
				def = "VIPERSABOT",
				onlytargetcategory = "SURFACE",
			},
		},
	},
}
