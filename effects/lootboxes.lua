-- lootbox beacons

return {
  ["LootboxBeaconGold"] = {
    -- beaconheat = {
    --   class = [[CHeatCloudProjectile]],
    --   air = true,
    --   water = true,
    --   ground = true,
    --   unit = true,
    --   count = 2,
    --   properties = {
    --     alwaysVisible = true,
    --     heat = 30,
    --     texture = [[glow2]],
    --     maxheat = 30,
    --     heatFalloff = 1.2,
    --     size = [[15.0 r0.4]],
    --     sizeGrowth = [[0.01 r0.02]],
    --     sizemod = 0,
    --     sizemodmod = 0,
    --     speed = [[0.05 r-0.05, 0.05 r-0.05, 0.05 r-0.05]],
    --     pos = [[0, 0.0, 0]],
    --     --useAirLos = false,
    --   },  
    -- },
    groundflash_large = {
            class              = [[CSimpleGroundFlash]],
            count              = 1,
            air                = true,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                colormap           = [[1 0.7 0.3 0.9   1 0.7 0.3 0.7   0 0 0 0.01]],
                size               = 24,
                ttl                = 28,
                sizegrowth         = 0.4,
                texture            = [[seismic]],
                alwaysvisible      = true,
            },
        },
    -- beaconsphere = {
    --   class              = [[CSpherePartSpawner]],
    --   count              = 1,
    --   ground             = true,
    --   water              = true,
    --   underwater         = true,
    --   air                = true,
    --   properties = {
    --     alwaysVisible    = true,
    --     alpha            = 0.5,
    --     ttl              = 30,
    --     expansionSpeed   = 2,
    --     color            = [[0.8, 0.65, 0.1]],
    --     useairlos        = false,
    --   },
    -- },
  },
}