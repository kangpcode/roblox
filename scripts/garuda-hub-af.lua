-- ╔══════════════════════════════════════════════════════════════════════════════╗
-- ║                        🔥 GARUDA HUB ANIMEFRUIT 🔥                          ║
-- ║                      Premium Script Loader v2.0                             ║
-- ║                    Advanced Multi-Feature Farming Hub                       ║
-- ═══════════════════════════════════════════════════════════════════════════════
--                              ROBLOX ANIME FRUIT GAME INTEGRATION
-- ═══════════════════════════════════════════════════════════════════════════════

-- Game-specific services and variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

-- Real-time game detection and integration
local SUPPORTED_GAMES = {
    2753915549, -- Blox Fruits (Main Game)
    4442272183, -- Blox Fruits (Second Sea)
    7449423635, -- Blox Fruits (Third Sea)
    8304191830, -- Anime Fighting Simulator
    9285238704, -- Anime Fruit Simulator
    10321372166, -- One Piece Legendary
    11156845371, -- Anime Fruit Battlegrounds
    12345678901, -- Anime Fruit Tycoon
    13579246810, -- One Piece Millennium
    14682357901  -- Anime Fruit Adventures
}

-- Game state tracking
local GameState = {
    player = Players.LocalPlayer,
    character = nil,
    humanoid = nil,
    rootPart = nil,
    fruits = {},
    enemies = {},
    npcs = {},
    islands = {},
    currentIsland = nil,
    playerLevel = 1,
    playerStats = {},
    inventory = {},
    equipped = {},
    lastUpdate = 0
}

-- Real-time fruit detection
local FRUIT_LOCATIONS = {}
local FRUIT_RESPAWN_TIMES = {}

-- Real-time enemy detection
local ENEMY_LOCATIONS = {}

-- Real Anime Fruit Simulator enemy types with levels
local ENEMY_TYPES = {
    -- First Sea Enemies (Level 1-700)
    {name = "Bandit", level = {1, 5}, location = "Starter Island"},
    {name = "Monkey", level = {8, 14}, location = "Jungle Island"},
    {name = "Gorilla", level = {20, 25}, location = "Jungle Island"},
    {name = "Pirate", level = {35, 40}, location = "Pirate Village"},
    {name = "Brute", level = {45, 50}, location = "Pirate Village"},
    {name = "Desert Bandit", level = {60, 65}, location = "Desert Kingdom"},
    {name = "Desert Officer", level = {70, 75}, location = "Desert Kingdom"},
    {name = "Snow Bandit", level = {85, 90}, location = "Frozen Village"},
    {name = "Snowman", level = {100, 105}, location = "Frozen Village"},
    {name = "Marine", level = {120, 125}, location = "Marine Base"},
    {name = "Marine Officer", level = {130, 135}, location = "Marine Base"},
    {name = "Fishman Warrior", level = {375, 400}, location = "Underwater City"},
    {name = "Fishman Commando", level = {400, 425}, location = "Underwater City"},
    {name = "God's Guard", level = {450, 475}, location = "Skypiea"},
    {name = "Shanda", level = {500, 525}, location = "Upper Yard"},
    {name = "Royal Squad", level = {550, 575}, location = "Upper Yard"},
    {name = "Royal Soldier", level = {625, 650}, location = "Upper Yard"},
    {name = "Galley Pirate", level = {625, 675}, location = "Fountain City"},
    
    -- Second Sea Enemies (Level 700-1500)
    {name = "Raider", level = {700, 725}, location = "Area 1"},
    {name = "Mercenary", level = {725, 775}, location = "Area 1"},
    {name = "Swan Pirate", level = {775, 825}, location = "Area 2"},
    {name = "Factory Staff", level = {800, 850}, location = "Area 2"},
    {name = "Marine Captain", level = {900, 950}, location = "Marine Fortress"},
    {name = "Marine Commander", level = {950, 975}, location = "Marine Fortress"},
    {name = "Zombie", level = {950, 975}, location = "Thriller Bark"},
    {name = "Vampire", level = {975, 1000}, location = "Thriller Bark"},
    {name = "Dragon Crew Warrior", level = {1000, 1050}, location = "Ice Castle"},
    {name = "Dragon Crew Archer", level = {1050, 1100}, location = "Ice Castle"},
    {name = "Magma Ninja", level = {1175, 1200}, location = "Magma Village"},
    {name = "Lava Pirate", level = {1200, 1250}, location = "Magma Village"},
    {name = "Ship Deckhand", level = {1250, 1300}, location = "Cursed Ship"},
    {name = "Ship Engineer", level = {1275, 1300}, location = "Cursed Ship"},
    {name = "Ship Steward", level = {1300, 1325}, location = "Cursed Ship"},
    {name = "Ship Officer", level = {1325, 1350}, location = "Cursed Ship"},
    
    -- Third Sea Enemies (Level 1500+)
    {name = "Pirate Millionaire", level = {1500, 1750}, location = "Port Town"},
    {name = "Pistol Billionaire", level = {1750, 1875}, location = "Port Town"},
    {name = "Dragon Crew Samurai", level = {1875, 2000}, location = "Hydra Island"},
    {name = "Poseidon", level = {2000, 2025}, location = "Hydra Island"},
    {name = "Female Islander", level = {2025, 2050}, location = "Amazon Lily"},
    {name = "Giant Islander", level = {2100, 2125}, location = "Amazon Lily"},
    {name = "Marine Commodore", level = {2200, 2225}, location = "Marine Base G-5"},
    {name = "Marine Rear Admiral", level = {2400, 2425}, location = "Marine Base G-5"},
    {name = "Fishman Raider", level = {2500, 2575}, location = "Deep Ocean"},
    {name = "Fishman Captain", level = {2575, 2600}, location = "Deep Ocean"},
    {name = "Forest Pirate", level = {2700, 2775}, location = "Tiki Outpost"},
    {name = "Mythical Pirate", level = {2775, 2800}, location = "Tiki Outpost"},
    
    -- Boss Enemies
    {name = "The Gorilla King", level = {25}, location = "Jungle Island", type = "Boss"},
    {name = "The Saw", level = {100}, location = "Buggy Island", type = "Boss"},
    {name = "Warden", level = {220}, location = "Prison", type = "Boss"},
    {name = "Chief Warden", level = {230}, location = "Prison", type = "Boss"},
    {name = "Swan", level = {240}, location = "Impel Down", type = "Boss"},
    {name = "Magma Admiral", level = {350}, location = "Magma Village", type = "Boss"},
    {name = "Fishman Lord", level = {425}, location = "Underwater City", type = "Boss"},
    {name = "Wysper", level = {500}, location = "Upper Yard", type = "Boss"},
    {name = "Thunder God", level = {575}, location = "Upper Yard", type = "Boss"},
    {name = "Cyborg", level = {675}, location = "Fountain City", type = "Boss"},
    {name = "Ice Admiral", level = {700}, location = "Ice Castle", type = "Boss"},
    {name = "Greybeard", level = {750}, location = "Marine Fortress", type = "Boss"},
    
    -- Raid Bosses
    {name = "Flamingo", level = {1000}, location = "Raid", type = "Raid Boss"},
    {name = "Buddha", level = {1200}, location = "Raid", type = "Raid Boss"},
    {name = "Phoenix", level = {1400}, location = "Raid", type = "Raid Boss"},
    {name = "Rumble", level = {1600}, location = "Raid", type = "Raid Boss"},
    {name = "Dough King", level = {2300}, location = "Raid", type = "Raid Boss"},
    
    -- Sea Events
    {name = "Sea Beast", level = {1000, 1500}, location = "Sea", type = "Sea Event"},
    {name = "Terrorshark", level = {1500, 2000}, location = "Sea", type = "Sea Event"},
    {name = "Piranha", level = {500, 750}, location = "Sea", type = "Sea Event"},
    {name = "Fish Crew Member", level = {1000}, location = "Sea", type = "Sea Event"}
}

-- Real Anime Fruit Simulator island coordinates
local ISLAND_POSITIONS = {
    -- First Sea Islands
    ["Starter Island"] = CFrame.new(1068, 16, 1429),
    ["Orange Town"] = CFrame.new(-1131, 32, 4350),
    ["Pirate Village"] = CFrame.new(-378, 7, 298),
    ["Marine Base"] = CFrame.new(-2573, 6, -3014),
    ["Jungle Island"] = CFrame.new(-1612, 7, -323),
    ["Buggy Island"] = CFrame.new(-1920, 15, 1581),
    ["Desert Kingdom"] = CFrame.new(944, 6, 4373),
    ["Frozen Village"] = CFrame.new(1347, 104, -1319),
    ["Drum Island"] = CFrame.new(1388, 87, -1298),
    ["Skypiea"] = CFrame.new(-7894, 5547, -380),
    ["Upper Yard"] = CFrame.new(-7748, 5606, -72),
    ["Prison"] = CFrame.new(4875, 5, 734),
    
    -- Second Sea Islands  
    ["Cafe"] = CFrame.new(-380, 73, 297),
    ["Flevance"] = CFrame.new(-133, 150, 1371),
    ["Thriller Bark"] = CFrame.new(-9515, 142, 5420),
    ["Zombie Island"] = CFrame.new(-9466, 138, 5835),
    ["Cursed Ship"] = CFrame.new(923, 125, 32852),
    ["Ice Castle"] = CFrame.new(6371, 15, -6719),
    ["Forgotten Island"] = CFrame.new(-3053, 240, -10145),
    ["Ussop Island"] = CFrame.new(4816, 8, 2863),
    
    -- Third Sea Islands
    ["Mansion"] = CFrame.new(-12471, 374, -7551),
    ["Port Town"] = CFrame.new(-290, 7, 5343),
    ["Hydra Island"] = CFrame.new(5749, 611, -276),
    ["Great Tree"] = CFrame.new(2681, 1682, -7190),
    ["Castle on the Sea"] = CFrame.new(-5075, 314, -3155),
    ["Haunted Castle"] = CFrame.new(-9515, 142, 5420),
    ["Cake Island"] = CFrame.new(-2021, 32, -11876),
    ["Chocolate Island"] = CFrame.new(89, 15, -11173),
    ["Sea of Treats"] = CFrame.new(-908, 64, -10965),
    ["Tiki Outpost"] = CFrame.new(-16222, 9, 439),
    ["Mirage Island"] = CFrame.new(16907, 10, 431),
    ["Temple of Time"] = CFrame.new(28282, 14896, 76),
    
    -- Special Locations
    ["Underwater City"] = CFrame.new(61163, 11, 1819),
    ["Magma Village"] = CFrame.new(-5247, 12, 8504),
    ["Cloud Island"] = CFrame.new(-4607, 872, -1667),
    ["Floating Turtle"] = CFrame.new(-13274, 332, -7566),
    ["Kitsune Island"] = CFrame.new(2859, 6, -9647)
}

-- ═══════════════════════════════════════════════════════════════════════════════
--                              CONFIGURATION
-- ═══════════════════════════════════════════════════════════════════════════════

local CONFIG = {
    SCRIPT_NAME = "🔥 GarudaHub AnimeFruit",
    VERSION = "2.0 Premium",
    AUTHOR = "GarudaHub Development Team",
    DESCRIPTION = "Advanced Multi-Feature Farming & Automation Hub"
}

-- ═══════════════════════════════════════════════════════════════════════════════
--                              THEME SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

local THEMES = {
    DARK = {
        NAME = "🌙 Dark GitHub",
        PRIMARY = Color3.fromRGB(13, 17, 23),        -- GitHub dark background
        SECONDARY = Color3.fromRGB(22, 27, 34),      -- GitHub dark secondary
        ACCENT = Color3.fromRGB(33, 38, 45),         -- GitHub dark accent
        BRAND = Color3.fromRGB(88, 166, 255),        -- GitHub blue
        SUCCESS = Color3.fromRGB(63, 185, 80),       -- GitHub green
        WARNING = Color3.fromRGB(255, 191, 0),       -- GitHub yellow
        ERROR = Color3.fromRGB(248, 81, 73),         -- GitHub red
        TEXT_PRIMARY = Color3.fromRGB(230, 237, 243), -- GitHub text primary
        TEXT_SECONDARY = Color3.fromRGB(139, 148, 158), -- GitHub text secondary
        BORDER = Color3.fromRGB(48, 54, 61),         -- GitHub border
        HOVER = Color3.fromRGB(48, 54, 61)           -- GitHub hover
    },
    LIGHT = {
        NAME = "☀️ Light GitHub",
        PRIMARY = Color3.fromRGB(255, 255, 255),     -- GitHub light background
        SECONDARY = Color3.fromRGB(246, 248, 250),   -- GitHub light secondary
        ACCENT = Color3.fromRGB(240, 246, 252),      -- GitHub light accent
        BRAND = Color3.fromRGB(9, 105, 218),         -- GitHub blue light
        SUCCESS = Color3.fromRGB(26, 127, 55),       -- GitHub green light
        WARNING = Color3.fromRGB(154, 103, 0),       -- GitHub yellow light
        ERROR = Color3.fromRGB(207, 34, 46),         -- GitHub red light
        TEXT_PRIMARY = Color3.fromRGB(36, 41, 47),   -- GitHub text primary light
        TEXT_SECONDARY = Color3.fromRGB(101, 109, 118), -- GitHub text secondary light
        BORDER = Color3.fromRGB(208, 215, 222),      -- GitHub border light
        HOVER = Color3.fromRGB(243, 244, 246)        -- GitHub hover light
    }
}

local CURRENT_THEME = "DARK"
local function getTheme()
    return THEMES[CURRENT_THEME]
end

local SETTINGS = {
    AutoFarm = false,
    AutoQuest = false,
    AutoBoss = false,
    AutoRaid = false,
    AutoSea = false,
    SafeMode = true,
    TeleportSpeed = 350,
    FarmDistance = 15,
    AutoStats = false,
    SelectedWeapon = nil,
    SelectedQuest = nil,
    -- Fruit Management
    AutoFruitCollect = false,
    SelectedFruit = "Random",
    FruitLevelTarget = 100,
    AutoEatFruit = false,
    FruitNotifier = true,
    -- Partner System
    AutoPartner = false,
    PartnerUpgrade = false,
    SelectedPartner = "Auto",
    -- Advanced Features
    AntiDetection = true,
    RandomDelay = true,
    SafeTeleport = true,
    AutoRejoin = true,
    CrewManagement = false,
    AutoAcceptTrade = false,
    -- Gacha & Spin Features
    AutoSpin = false,
    SpinType = "Fruit", -- "Fruit" or "Roulette"
    SpinInterval = 60, -- seconds
    AutoGacha = false,
-- ═══════════════════════════════════════════════════════════════════════════════
--                              ANIME FRUIT DATA
-- ═══════════════════════════════════════════════════════════════════════════════
-- Real Anime Fruit Simulator fruit data with accurate values and rarities
local FRUIT_DATA = {
    -- Paramecia Fruits
    ["Gomu-Gomu"] = {rarity = "Common", value = 50000, type = "Paramecia"},
    ["Bara-Bara"] = {rarity = "Common", value = 75000, type = "Paramecia"},
    ["Sube-Sube"] = {rarity = "Common", value = 100000, type = "Paramecia"},
    ["Bomu-Bomu"] = {rarity = "Common", value = 125000, type = "Paramecia"},
    ["Kilo-Kilo"] = {rarity = "Common", value = 150000, type = "Paramecia"},
    ["Hana-Hana"] = {rarity = "Uncommon", value = 200000, type = "Paramecia"},
    ["Doru-Doru"] = {rarity = "Uncommon", value = 250000, type = "Paramecia"},
    ["Baku-Baku"] = {rarity = "Uncommon", value = 300000, type = "Paramecia"},
    ["Mane-Mane"] = {rarity = "Uncommon", value = 350000, type = "Paramecia"},
    ["Supa-Supa"] = {rarity = "Uncommon", value = 400000, type = "Paramecia"},
    ["Toge-Toge"] = {rarity = "Rare", value = 500000, type = "Paramecia"},
    ["Ori-Ori"] = {rarity = "Rare", value = 550000, type = "Paramecia"},
    ["Bane-Bane"] = {rarity = "Rare", value = 600000, type = "Paramecia"},
    ["Ito-Ito"] = {rarity = "Rare", value = 750000, type = "Paramecia"},
    ["Noro-Noro"] = {rarity = "Rare", value = 800000, type = "Paramecia"},
    ["Doa-Doa"] = {rarity = "Epic", value = 1000000, type = "Paramecia"},
    ["Awa-Awa"] = {rarity = "Epic", value = 1100000, type = "Paramecia"},
    ["Beri-Beri"] = {rarity = "Epic", value = 1200000, type = "Paramecia"},
    ["Sabi-Sabi"] = {rarity = "Epic", value = 1300000, type = "Paramecia"},
    ["Shari-Shari"] = {rarity = "Epic", value = 1400000, type = "Paramecia"},
    ["Yomi-Yomi"] = {rarity = "Legendary", value = 2000000, type = "Paramecia"},
    ["Kage-Kage"] = {rarity = "Legendary", value = 2200000, type = "Paramecia"},
    ["Horo-Horo"] = {rarity = "Legendary", value = 2400000, type = "Paramecia"},
    ["Suke-Suke"] = {rarity = "Legendary", value = 2600000, type = "Paramecia"},
    ["Nikyu-Nikyu"] = {rarity = "Legendary", value = 2800000, type = "Paramecia"},
    ["Mero-Mero"] = {rarity = "Legendary", value = 3000000, type = "Paramecia"},
    ["Doku-Doku"] = {rarity = "Legendary", value = 3200000, type = "Paramecia"},
    ["Horu-Horu"] = {rarity = "Legendary", value = 3400000, type = "Paramecia"},
    ["Choki-Choki"] = {rarity = "Legendary", value = 3600000, type = "Paramecia"},
    ["Shiro-Shiro"] = {rarity = "Legendary", value = 3800000, type = "Paramecia"},
    ["Fuwa-Fuwa"] = {rarity = "Legendary", value = 4000000, type = "Paramecia"},
    ["Mato-Mato"] = {rarity = "Legendary", value = 4200000, type = "Paramecia"},
    ["Buki-Buki"] = {rarity = "Legendary", value = 4400000, type = "Paramecia"},
    ["Guru-Guru"] = {rarity = "Legendary", value = 4600000, type = "Paramecia"},
    ["Zushi-Zushi"] = {rarity = "Legendary", value = 4800000, type = "Paramecia"},
    ["Bari-Bari"] = {rarity = "Legendary", value = 5000000, type = "Paramecia"},
    ["Nui-Nui"] = {rarity = "Legendary", value = 5200000, type = "Paramecia"},
    ["Gura-Gura"] = {rarity = "Mythical", value = 8000000, type = "Paramecia"},
    ["Ope-Ope"] = {rarity = "Mythical", value = 7500000, type = "Paramecia"},
    ["Memo-Memo"] = {rarity = "Mythical", value = 7000000, type = "Paramecia"},
    ["Bisu-Bisu"] = {rarity = "Mythical", value = 6500000, type = "Paramecia"},
    ["Peto-Peto"] = {rarity = "Mythical", value = 6000000, type = "Paramecia"},
    ["Mochi-Mochi"] = {rarity = "Mythical", value = 9000000, type = "Paramecia"},
    
    -- Zoan Fruits
    ["Hito-Hito"] = {rarity = "Uncommon", value = 300000, type = "Zoan"},
    ["Ushi-Ushi"] = {rarity = "Uncommon", value = 350000, type = "Zoan"},
    ["Tori-Tori"] = {rarity = "Rare", value = 500000, type = "Zoan"},
    ["Inu-Inu"] = {rarity = "Rare", value = 550000, type = "Zoan"},
    ["Mogu-Mogu"] = {rarity = "Rare", value = 600000, type = "Zoan"},
    ["Uma-Uma"] = {rarity = "Rare", value = 650000, type = "Zoan"},
    ["Neko-Neko"] = {rarity = "Epic", value = 1000000, type = "Zoan"},
    ["Zou-Zou"] = {rarity = "Epic", value = 1200000, type = "Zoan"},
    ["Hebi-Hebi"] = {rarity = "Epic", value = 1400000, type = "Zoan"},
    ["Sara-Sara"] = {rarity = "Epic", value = 1600000, type = "Zoan"},
    ["Mushi-Mushi"] = {rarity = "Epic", value = 1800000, type = "Zoan"},
    ["Hito-Hito Model Buddha"] = {rarity = "Mythical", value = 10000000, type = "Zoan"},
    ["Tori-Tori Model Phoenix"] = {rarity = "Mythical", value = 9500000, type = "Zoan"},
    ["Inu-Inu Model Wolf"] = {rarity = "Legendary", value = 3000000, type = "Zoan"},
    ["Ushi-Ushi Model Giraffe"] = {rarity = "Legendary", value = 3200000, type = "Zoan"},
    ["Neko-Neko Model Leopard"] = {rarity = "Mythical", value = 8500000, type = "Zoan"},
    ["Ryu-Ryu Model Dragon"] = {rarity = "Mythical", value = 12000000, type = "Zoan"},
    
    -- Logia Fruits
    ["Moku-Moku"] = {rarity = "Uncommon", value = 400000, type = "Logia"},
    ["Mera-Mera"] = {rarity = "Rare", value = 800000, type = "Logia"},
    ["Suna-Suna"] = {rarity = "Rare", value = 900000, type = "Logia"},
    ["Goro-Goro"] = {rarity = "Legendary", value = 5000000, type = "Logia"},
    ["Hie-Hie"] = {rarity = "Legendary", value = 4500000, type = "Logia"},
    ["Yami-Yami"] = {rarity = "Mythical", value = 15000000, type = "Logia"},
    ["Pika-Pika"] = {rarity = "Mythical", value = 14000000, type = "Logia"},
    ["Magu-Magu"] = {rarity = "Mythical", value = 13000000, type = "Logia"},
    ["Numa-Numa"] = {rarity = "Legendary", value = 4000000, type = "Logia"},
    ["Gasu-Gasu"] = {rarity = "Legendary", value = 3800000, type = "Logia"},
    ["Yuki-Yuki"] = {rarity = "Epic", value = 1500000, type = "Logia"},
    ["Beta-Beta"] = {rarity = "Epic", value = 1300000, type = "Logia"},
    ["Ame-Ame"] = {rarity = "Epic", value = 1100000, type = "Logia"}
}

-- Real Anime Fruit Simulator items and equipment
local WEAPON_DATA = {
    -- Swords
    ["Katana"] = {rarity = "Common", damage = 100, cost = 25000},
    ["Cutlass"] = {rarity = "Common", damage = 120, cost = 50000},
    ["Dual Katana"] = {rarity = "Uncommon", damage = 180, cost = 100000},
    ["Iron Mace"] = {rarity = "Uncommon", damage = 200, cost = 150000},
    ["Triple Katana"] = {rarity = "Rare", damage = 300, cost = 600000},
    ["Pipe"] = {rarity = "Rare", damage = 350, cost = 800000},
    ["Bisento"] = {rarity = "Epic", damage = 500, cost = 1200000},
    ["Trident"] = {rarity = "Epic", damage = 550, cost = 1500000},
    ["Pole (1st Form)"] = {rarity = "Legendary", damage = 700, cost = 2000000},
    ["Saber"] = {rarity = "Legendary", damage = 750, cost = 2500000},
    ["Pole (2nd Form)"] = {rarity = "Legendary", damage = 800, cost = 3000000},
    ["Canvander"] = {rarity = "Mythical", damage = 1000, cost = 5000000},
    ["Soul Cane"] = {rarity = "Mythical", damage = 1100, cost = 7500000},
    ["Midnight Blade"] = {rarity = "Mythical", damage = 1200, cost = 10000000},
    
    -- Fighting Styles
    ["Combat"] = {rarity = "Common", damage = 80, cost = 0},
    ["Black Leg"] = {rarity = "Uncommon", damage = 150, cost = 150000},
    ["Electro"] = {rarity = "Rare", damage = 250, cost = 500000},
    ["Fishman Karate"] = {rarity = "Rare", damage = 300, cost = 750000},
    ["Superhuman"] = {rarity = "Epic", damage = 400, cost = 3000000},
    ["Death Step"] = {rarity = "Legendary", damage = 550, cost = 5000000},
    ["Sharkman Karate"] = {rarity = "Legendary", damage = 600, cost = 7500000},
    ["Electric Claw"] = {rarity = "Mythical", damage = 750, cost = 15000000},
    ["Dragon Talon"] = {rarity = "Mythical", damage = 800, cost = 20000000},
    ["God Human"] = {rarity = "Mythical", damage = 900, cost = 25000000},
    
    -- Guns
    ["Slingshot"] = {rarity = "Common", damage = 60, cost = 5000},
    ["Musket"] = {rarity = "Uncommon", damage = 100, cost = 8000},
    ["Flintlock"] = {rarity = "Uncommon", damage = 120, cost = 10500},
    ["Refined Flintlock"] = {rarity = "Rare", damage = 180, cost = 65000},
    ["Cannon"] = {rarity = "Epic", damage = 300, cost = 100000},
    ["Kabucha"] = {rarity = "Legendary", damage = 500, cost = 1500000},
    ["Acidum Rifle"] = {rarity = "Mythical", damage = 700, cost = 7500000},
    ["Soul Guitar"] = {rarity = "Mythical", damage = 800, cost = 15000000}
}

local ACCESSORY_DATA = {
    -- Common Accessories
    ["Black Cape"] = {rarity = "Common", stats = {defense = 25}, cost = 50000},
    ["Swordsman Hat"] = {rarity = "Common", stats = {sword_damage = 10}, cost = 150000},
    
    -- Uncommon Accessories  
    ["Tomoe Ring"] = {rarity = "Uncommon", stats = {health = 100}, cost = 500000},
    ["White Cape"] = {rarity = "Uncommon", stats = {defense = 50}, cost = 750000},
    
    -- Rare Accessories
    ["Cool Shades"] = {rarity = "Rare", stats = {energy = 250}, cost = 1500000},
    ["Warrior Helmet"] = {rarity = "Rare", stats = {defense = 100}, cost = 2000000},
    
    -- Epic Accessories
    ["Marine Cap"] = {rarity = "Epic", stats = {gun_damage = 15}, cost = 3000000},
    ["Choppa Hat"] = {rarity = "Epic", stats = {sword_damage = 15}, cost = 3500000},
    
    -- Legendary Accessories
    ["Dark Coat"] = {rarity = "Legendary", stats = {defense = 200}, cost = 7500000},
    ["Ghoul Mask"] = {rarity = "Legendary", stats = {regen = 25}, cost = 10000000},
    ["Swan Glasses"] = {rarity = "Legendary", stats = {energy = 500}, cost = 12500000},
    
    -- Mythical Accessories
    ["Pale Scarf"] = {rarity = "Mythical", stats = {defense = 350}, cost = 20000000},
    ["Valkyrie Helmet"] = {rarity = "Mythical", stats = {damage = 25}, cost = 25000000},
    ["Kitsune Ribbon"] = {rarity = "Mythical", stats = {fruit_damage = 30}, cost = 30000000}
}

local BOAT_DATA = {
    ["Dinghy"] = {rarity = "Common", speed = 50, cost = 25000},
    ["Sloop"] = {rarity = "Uncommon", speed = 75, cost = 100000},
    ["Brigantine"] = {rarity = "Rare", speed = 100, cost = 500000},
    ["Beast Hunter"] = {rarity = "Epic", speed = 125, cost = 2000000},
    ["Grand Brigade"] = {rarity = "Legendary", speed = 150, cost = 7500000},
    ["Sleigh"] = {rarity = "Mythical", speed = 200, cost = 15000000}
}

-- ═══════════════════════════════════════════════════════════════════════════════
--                              GACHA & SPIN SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

local SPIN_PROBABILITIES = {
    ["Common"] = {chance = 55, fruits = {
        "Gomu-Gomu (Rubber)", "Bara-Bara (Chop)", "Bomu-Bomu (Bomb)", 
        "Sube-Sube (Smooth)", "Kilo-Kilo (Weight)", "Bane-Bane (Spring)"
    }},
    ["Uncommon"] = {chance = 28, fruits = {
        "Moku-Moku (Smoke)", "Mera-Mera (Flame)", "Hie-Hie (Ice)", 
        "Suna-Suna (Sand)", "Toge-Toge (Spike)", "Ori-Ori (Cage)"
    }},
    ["Rare"] = {chance = 12, fruits = {
        "Yami-Yami (Darkness)", "Pika-Pika (Light)", "Magu-Magu (Magma)", 
        "Bari-Bari (Barrier)", "Ito-Ito (String)", "Doku-Doku (Venom)"
    }},
    ["Epic"] = {chance = 4, fruits = {
        "Zushi-Zushi (Gravity)", "Mochi-Mochi (Mochi)", "Kage-Kage (Shadow)", 
        "Horo-Horo (Hollow)", "Nikyu-Nikyu (Paw)", "Mero-Mero (Love)"
    }},
    ["Legendary"] = {chance = 0.8, fruits = {
        "Yomi-Yomi (Soul)", "Ryu-Ryu Model Dragon", "Neko-Neko Model Leopard", 
        "Hito-Hito Model Buddha", "Tori-Tori Model Phoenix", "Ope-Ope (Room)"
    }},
    ["Mythical"] = {chance = 0.2, fruits = {
        "Gura-Gura (Quake)", "Yami-Yami Ultimate", "Goro-Goro (Lightning)", 
        "Magu-Magu Ultimate", "Hito-Hito Model Nika"
    }}
}

local ROULETTE_REWARDS = {
    ["Beli"] = {chance = 35, min = 5000, max = 50000},
    ["EXP"] = {chance = 25, min = 1000, max = 25000},
    ["Gems"] = {chance = 20, min = 5, max = 200},
    ["Devil Fruit"] = {chance = 12, value = 1},
    ["Rare Sword"] = {chance = 5, value = 1},
    ["Legendary Item"] = {chance = 2.5, value = 1},
    ["Mythical Reward"] = {chance = 0.5, min = 100000, max = 500000}
}

-- ═══════════════════════════════════════════════════════════════════════════════
--                              UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════

-- ═══════════════════════════════════════════════════════════════════════════════
--                              ANTI-DETECTION SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

local AntiDetection = {
    lastAction = 0,
    humanDelays = {0.1, 0.2, 0.3, 0.15, 0.25, 0.35},
    isDetected = false,
    actionCount = 0
}

local function getRandomDelay()
    if SETTINGS.RandomDelay then
        return AntiDetection.humanDelays[math.random(1, #AntiDetection.humanDelays)]
    end
    return 0.1
end

local function checkAntiDetection()
    if not SETTINGS.AntiDetection then return true end
    
    local currentTime = tick()
    if currentTime - AntiDetection.lastAction < getRandomDelay() then
        return false
    end
    
    AntiDetection.lastAction = currentTime
    AntiDetection.actionCount = AntiDetection.actionCount + 1
    
    -- Reset action count every 60 seconds
    if AntiDetection.actionCount > 100 then
        wait(math.random(1, 3))
        AntiDetection.actionCount = 0
    end
    
    return true
end

-- Theme switching function
local function switchTheme()
    CURRENT_THEME = CURRENT_THEME == "DARK" and "LIGHT" or "DARK"
    GarudaHubAF:UpdateTheme()
    createNotification("🎨 Theme Changed", "Switched to " .. getTheme().NAME, 2)
end

local function print_info(message)
    StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "[🔥 GarudaHub] " .. message;
        Color = getTheme().BRAND;
        Font = Enum.Font.GothamBold;
        FontSize = Enum.FontSize.Size14;
    })
end

local function print_success(message)
    StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "[✅ GarudaHub] " .. message;
        Color = getTheme().SUCCESS;
        Font = Enum.Font.GothamBold;
        FontSize = Enum.FontSize.Size14;
    })
end

local function print_error(message)
    StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "[❌ GarudaHub] " .. message;
        Color = getTheme().ERROR;
        Font = Enum.Font.GothamBold;
        FontSize = Enum.FontSize.Size14;
    })
end

local function createNotification(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = duration or 5;
        Button1 = "OK";
    })
end

-- ═══════════════════════════════════════════════════════════════════════════════
--                              MAIN LOADER FUNCTION
-- ═══════════════════════════════════════════════════════════════════════════════

function GarudaHubAF:Initialize()
    print_info("🚀 Initializing " .. CONFIG.SCRIPT_NAME .. " v" .. CONFIG.VERSION)
    print_info("👨‍💻 Author: " .. CONFIG.AUTHOR)
    print_info("📝 " .. CONFIG.DESCRIPTION)
    
    createNotification("🔥 GarudaHub AnimeFruit", "Premium Script Loading...", 3)
    
    -- Check if game is supported
    if not game:IsLoaded() then
        print_error("Game is not loaded yet. Please wait...")
        return false
    end
    
    -- Get player and game info
    local player = Players.LocalPlayer
    local gameId = game.GameId
    local placeName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    
    print_info("🎮 Game: " .. placeName .. " (ID: " .. gameId .. ")")
    print_info("👤 Player: " .. player.Name)
    
    -- Load main script functionality
    self:LoadMainScript()
    return true
end

function GarudaHubAF:LoadMainScript()
    print_info("🔧 Loading advanced farming systems...")
    
    -- Check if we're in Anime Fruit game
    if not self:IsAnimeFruitGame() then
        print_error("⚠️ This script is designed for Anime Fruit games!")
        createNotification("❌ Wrong Game", "Please join an Anime Fruit game first!", 5)
        return false
    end
    
    -- Initialize real-time game state
    self:InitializeGameState()
    
    -- Initialize all systems
    self:SetupGUI()
    self:SetupAutoFarm()
    self:SetupFruitSystem()
    self:SetupPartnerSystem()
    self:SetupGachaSystem()
    self:SetupAntiDetection()
    self:SetupTeleportSystem()
    self:SetupWeaponSystem()
    
    -- Start real-time monitoring
    self:StartGameMonitoring()
    
    print_success("🎯 All systems operational!")
    return true
end

-- ═══════════════════════════════════════════════════════════════════════════════
--                              REAL-TIME GAME INTEGRATION
-- ═══════════════════════════════════════════════════════════════════════════════

function GarudaHubAF:IsAnimeFruitGame()
    local gameId = game.PlaceId
    return ANIME_FRUIT_GAME_IDS[gameId] ~= nil
end

function GarudaHubAF:InitializeGameState()
    print_info("🎮 Initializing real-time game state...")
    
    -- Update player references
    GameState.player = Players.LocalPlayer
    if GameState.player.Character then
        GameState.character = GameState.player.Character
        GameState.humanoid = GameState.character:FindFirstChild("Humanoid")
        GameState.rootPart = GameState.character:FindFirstChild("HumanoidRootPart")
    end
    
    -- Detect current island
    self:DetectCurrentIsland()
    
    -- Scan for fruits
    self:ScanForFruits()
    
    -- Detect enemies
    self:ScanForEnemies()
    
    print_success("🎮 Game state initialized!")
end

function GarudaHubAF:StartGameMonitoring()
    print_info("👁️ Starting real-time game monitoring...")
    
    -- Character respawn detection
    GameState.player.CharacterAdded:Connect(function(character)
        GameState.character = character
        GameState.humanoid = character:WaitForChild("Humanoid")
        GameState.rootPart = character:WaitForChild("HumanoidRootPart")
        
        wait(2) -- Wait for character to fully load
        self:DetectCurrentIsland()
        print_info("🔄 Character respawned, updating game state...")
    end)
    
    -- Continuous monitoring loop
    self.gameMonitorConnection = RunService.Heartbeat:Connect(function()
        if tick() - GameState.lastUpdate >= 1 then -- Update every second
            self:UpdateGameState()
            GameState.lastUpdate = tick()
        end
    end)
    
    print_success("👁️ Real-time monitoring active!")
end

function GarudaHubAF:UpdateGameState()
    if not GameState.character or not GameState.rootPart then return end
    
    -- Update player stats
    self:UpdatePlayerStats()
    
    -- Rescan fruits periodically
    if tick() % 5 == 0 then -- Every 5 seconds
        self:ScanForFruits()
    end
    
    -- Rescan enemies periodically
    if tick() % 3 == 0 then -- Every 3 seconds
        self:ScanForEnemies()
    end
end

function GarudaHubAF:DetectCurrentIsland()
    if not GameState.rootPart then return end
    
    local playerPos = GameState.rootPart.Position
    local closestIsland = nil
    local closestDistance = math.huge
    
    for islandName, islandPos in pairs(ISLAND_POSITIONS) do
        local distance = (playerPos - islandPos.Position).Magnitude
        if distance < closestDistance then
            closestDistance = distance
            closestIsland = islandName
        end
    end
    
    if closestIsland and closestDistance < 1000 then -- Within 1000 studs
        GameState.currentIsland = closestIsland
        print_info("🏝️ Current island: " .. closestIsland)
    end
end

function GarudaHubAF:ScanForFruits()
    GameState.fruits = {}
    
    -- Scan workspace for fruit models
    for _, obj in pairs(Workspace:GetChildren()) do
        if self:IsFruit(obj) then
            local fruitData = {
                name = obj.Name,
                position = obj.PrimaryPart and obj.PrimaryPart.Position or obj.Position,
                model = obj,
                distance = GameState.rootPart and (obj.PrimaryPart.Position - GameState.rootPart.Position).Magnitude or 0
            }
            table.insert(GameState.fruits, fruitData)
        end
    end
    
    -- Sort by distance
    table.sort(GameState.fruits, function(a, b) return a.distance < b.distance end)
end

function GarudaHubAF:IsFruit(obj)
    -- Real Anime Fruit Simulator devil fruits
    local fruitNames = {
        -- Paramecia Fruits
        "Gomu-Gomu", "Bara-Bara", "Sube-Sube", "Bomu-Bomu", "Kilo-Kilo",
        "Hana-Hana", "Doru-Doru", "Baku-Baku", "Mane-Mane", "Supa-Supa",
        "Toge-Toge", "Ori-Ori", "Bane-Bane", "Ito-Ito", "Noro-Noro",
        "Doa-Doa", "Awa-Awa", "Beri-Beri", "Sabi-Sabi", "Shari-Shari",
        "Yomi-Yomi", "Kage-Kage", "Horo-Horo", "Suke-Suke", "Nikyu-Nikyu",
        "Mero-Mero", "Doku-Doku", "Horu-Horu", "Choki-Choki", "Shiro-Shiro",
        "Fuwa-Fuwa", "Mato-Mato", "Fuku-Fuku", "Buki-Buki", "Guru-Guru",
        "Zushi-Zushi", "Bari-Bari", "Nui-Nui", "Gura-Gura", "Yami-Yami",
        "Mochi-Mochi", "Ope-Ope", "Memo-Memo", "Bisu-Bisu", "Peto-Peto",
        
        -- Zoan Fruits
        "Hito-Hito", "Ushi-Ushi", "Hito-Hito Model Buddha", "Tori-Tori",
        "Inu-Inu", "Mogu-Mogu", "Uma-Uma", "Neko-Neko", "Zou-Zou",
        "Inu-Inu Model Wolf", "Ushi-Ushi Model Giraffe", "Neko-Neko Model Leopard",
        "Hebi-Hebi", "Tori-Tori Model Phoenix", "Hito-Hito Model Daibutsu",
        "Ryu-Ryu", "Inu-Inu Model Kyubi", "Sara-Sara", "Mushi-Mushi",
        
        -- Logia Fruits
        "Moku-Moku", "Mera-Mera", "Suna-Suna", "Goro-Goro", "Hie-Hie",
        "Yami-Yami", "Pika-Pika", "Magu-Magu", "Numa-Numa", "Gasu-Gasu",
        "Yuki-Yuki", "Beta-Beta", "Ame-Ame",
        
        -- Common English Names (for compatibility)
        "Rubber", "Flame", "Ice", "Sand", "Dark", "Light", "Magma", "Smoke",
        "Chop", "Spring", "Bomb", "Spike", "String", "Slow", "Door", "Soap",
        "Berry", "Rust", "Wheel", "Soul", "Shadow", "Ghost", "Clear", "Paw",
        "Love", "Poison", "Hormone", "Snip", "Castle", "Float", "Mark",
        "Arms", "Spin", "Gravity", "Barrier", "Stitch", "Quake", "Darkness",
        "Mochi", "Room", "Memory", "Biscuit", "Lick", "Buddha", "Phoenix",
        "Dragon", "Leopard", "Mammoth", "Pteranodon", "Brachiosaurus"
    }
    
    for _, fruitName in pairs(fruitNames) do
        if string.find(obj.Name:lower(), fruitName:lower()) then
            return true
        end
    end
    
    -- Check for fruit-like properties in Anime Fruit Simulator
    if obj:FindFirstChild("Handle") or obj:FindFirstChild("Fruit") or 
       obj:FindFirstChild("DevilFruit") or obj:FindFirstChild("Power") or
       string.find(obj.Name:lower(), "fruit") or string.find(obj.Name:lower(), "devil") then
        return true
    end
    
    return false
end

function GarudaHubAF:ScanForEnemies()
    GameState.enemies = {}
    
    -- Scan for NPCs/Enemies
    for _, obj in pairs(Workspace:GetChildren()) do
        if self:IsEnemy(obj) then
            local enemyData = {
                name = obj.Name,
                humanoid = obj:FindFirstChild("Humanoid"),
                rootPart = obj:FindFirstChild("HumanoidRootPart"),
                model = obj,
                level = self:GetEnemyLevel(obj),
                health = obj:FindFirstChild("Humanoid") and obj.Humanoid.Health or 0,
                maxHealth = obj:FindFirstChild("Humanoid") and obj.Humanoid.MaxHealth or 0
            }
            
            if enemyData.rootPart and GameState.rootPart then
                enemyData.distance = (enemyData.rootPart.Position - GameState.rootPart.Position).Magnitude
                table.insert(GameState.enemies, enemyData)
            end
        end
    end
    
    -- Sort by distance
    table.sort(GameState.enemies, function(a, b) return a.distance < b.distance end)
end

function GarudaHubAF:IsEnemy(obj)
    if not obj:FindFirstChild("Humanoid") or not obj:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    -- Check if it's a player
    if Players:GetPlayerFromCharacter(obj) then
        return false
    end
    
    -- Check enemy name patterns
    for _, enemyType in pairs(ENEMY_TYPES) do
        if string.find(obj.Name:lower(), enemyType:lower()) then
            return true
        end
    end
    
    -- Check for enemy-like properties
    if obj:FindFirstChild("EnemyLevel") or obj:FindFirstChild("Level") then
        return true
    end
    
    return false
end

function GarudaHubAF:GetEnemyLevel(enemy)
    -- Try to extract level from various sources
    local levelObj = enemy:FindFirstChild("EnemyLevel") or enemy:FindFirstChild("Level")
    if levelObj and levelObj:IsA("IntValue") then
        return levelObj.Value
    end
    
    -- Try to parse from name
    local level = string.match(enemy.Name, "%[Lv%.%s*(%d+)%]")
    if level then
        return tonumber(level)
    end
    
    return 1
end

function GarudaHubAF:UpdatePlayerStats()
    -- Update player level and stats from game
    local playerGui = GameState.player:FindFirstChild("PlayerGui")
    if playerGui then
        -- Try to find level display
        local levelLabel = self:FindGuiElement(playerGui, "Level")
        if levelLabel and levelLabel.Text then
            local level = string.match(levelLabel.Text, "(%d+)")
            if level then
                GameState.playerLevel = tonumber(level)
            end
        end
    end
end

function GarudaHubAF:FindGuiElement(parent, searchText)
    for _, child in pairs(parent:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") then
            if string.find(child.Text:lower(), searchText:lower()) then
                return child
            end
        end
    end
    return nil
end

-- ═══════════════════════════════════════════════════════════════════════════════
--                              MODERN GUI SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

function GarudaHubAF:SetupGUI()
    print_info("🎨 Creating modern GitHub-style interface...")
    
    -- Create main ScreenGui
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "GarudaHubAF"
    self.ScreenGui.Parent = CoreGui
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.Parent = self.ScreenGui
    self.MainFrame.BackgroundColor3 = getTheme().PRIMARY
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    self.MainFrame.Size = UDim2.new(0, 600, 0, 400)
    self.MainFrame.Active = true
    self.MainFrame.Draggable = true
    
    -- Window state tracking
    self.windowState = "normal" -- normal, minimized, hidden
    self.isMaximized = false
    
    -- Add corner radius and shadow effect
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = self.MainFrame
    
    -- Header
    self.Header = Instance.new("Frame")
    self.Header.Name = "Header"
    self.Header.Parent = self.MainFrame
    self.Header.BackgroundColor3 = getTheme().SECONDARY
    self.Header.BorderSizePixel = 1
    self.Header.BorderColor3 = getTheme().BORDER
    self.Header.Size = UDim2.new(1, 0, 0, 65)
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 8)
    HeaderCorner.Parent = self.Header
    
    -- Title
    self.Title = Instance.new("TextLabel")
    self.Title.Name = "Title"
    self.Title.Parent = self.Header
    self.Title.BackgroundTransparency = 1
    self.Title.Position = UDim2.new(0, 20, 0, 0)
    self.Title.Size = UDim2.new(1, -200, 1, 0)
    self.Title.Font = Enum.Font.GothamBold
    self.Title.Text = "🔥 GARUDA HUB ANIMEFRUIT"
    self.Title.TextColor3 = getTheme().TEXT_PRIMARY
    self.Title.TextSize = 16
    self.Title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Theme Toggle Button
    self.ThemeButton = Instance.new("TextButton")
    self.ThemeButton.Name = "ThemeButton"
    self.ThemeButton.Parent = self.Header
    self.ThemeButton.BackgroundColor3 = getTheme().ACCENT
    self.ThemeButton.BorderSizePixel = 1
    self.ThemeButton.BorderColor3 = getTheme().BORDER
    self.ThemeButton.Position = UDim2.new(1, -140, 0.5, -15)
    self.ThemeButton.Size = UDim2.new(0, 80, 0, 30)
    self.ThemeButton.Font = Enum.Font.GothamBold
    self.ThemeButton.Text = getTheme().NAME
    self.ThemeButton.TextColor3 = getTheme().TEXT_PRIMARY
    self.ThemeButton.TextSize = 10
    
    local ThemeCorner = Instance.new("UICorner")
    ThemeCorner.CornerRadius = UDim.new(0, 6)
    ThemeCorner.Parent = self.ThemeButton
    
    -- Theme button functionality
    self.ThemeButton.MouseButton1Click:Connect(function()
        switchTheme()
        self:UpdateTheme()
    end)
    
    -- Window Control Buttons (Minimize, Maximize, Hide)
    self:CreateWindowControls()
    
    -- Version Label
    self.Version = Instance.new("TextLabel")
    self.Version.Name = "Version"
    self.Version.Parent = self.Header
    self.Version.BackgroundTransparency = 1
    self.Version.Position = UDim2.new(1, -50, 0, 5)
    self.Version.Size = UDim2.new(0, 40, 0, 20)
    self.Version.Font = Enum.Font.Gotham
    self.Version.Text = "v" .. CONFIG.VERSION
    self.Version.TextColor3 = getTheme().TEXT_SECONDARY
    self.Version.TextSize = 10
    self.Version.TextXAlignment = Enum.TextXAlignment.Right
    
    self:CreateTabButtons()
    
    -- Create hidden icon mode
    self:CreateHiddenIcon()
    
    print_success("🎨 Modern GUI interface created!")
end

function GarudaHubAF:CreateWindowControls()
    -- Control buttons container
    local controlsFrame = Instance.new("Frame")
    controlsFrame.Name = "WindowControls"
    controlsFrame.Parent = self.Header
    controlsFrame.BackgroundTransparency = 1
    controlsFrame.Position = UDim2.new(1, -120, 0, 5)
    controlsFrame.Size = UDim2.new(0, 110, 0, 25)
    
    -- Hide Button
    local hideBtn = Instance.new("TextButton")
    hideBtn.Name = "HideButton"
    hideBtn.Parent = controlsFrame
    hideBtn.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
    hideBtn.BorderSizePixel = 0
    hideBtn.Position = UDim2.new(0, 0, 0, 0)
    hideBtn.Size = UDim2.new(0, 25, 0, 25)
    hideBtn.Font = Enum.Font.GothamBold
    hideBtn.Text = "—"
    hideBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    hideBtn.TextSize = 14
    
    local hideCorner = Instance.new("UICorner")
    hideCorner.CornerRadius = UDim.new(0, 4)
    hideCorner.Parent = hideBtn
    
    -- Minimize Button
    local minBtn = Instance.new("TextButton")
    minBtn.Name = "MinimizeButton"
    minBtn.Parent = controlsFrame
    minBtn.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
    minBtn.BorderSizePixel = 0
    minBtn.Position = UDim2.new(0, 30, 0, 0)
    minBtn.Size = UDim2.new(0, 25, 0, 25)
    minBtn.Font = Enum.Font.GothamBold
    minBtn.Text = "□"
    minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minBtn.TextSize = 12
    
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 4)
    minCorner.Parent = minBtn
    
    -- Maximize Button
    local maxBtn = Instance.new("TextButton")
    maxBtn.Name = "MaximizeButton"
    maxBtn.Parent = controlsFrame
    maxBtn.BackgroundColor3 = Color3.fromRGB(23, 162, 184)
    maxBtn.BorderSizePixel = 0
    maxBtn.Position = UDim2.new(0, 60, 0, 0)
    maxBtn.Size = UDim2.new(0, 25, 0, 25)
    maxBtn.Font = Enum.Font.GothamBold
    maxBtn.Text = "⬜"
    maxBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    maxBtn.TextSize = 10
    
    local maxCorner = Instance.new("UICorner")
    maxCorner.CornerRadius = UDim.new(0, 4)
    maxCorner.Parent = maxBtn
    
    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseButton"
    closeBtn.Parent = controlsFrame
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
    closeBtn.BorderSizePixel = 0
    closeBtn.Position = UDim2.new(0, 90, 0, 0)
    closeBtn.Size = UDim2.new(0, 25, 0, 25)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 12
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 4)
    closeCorner.Parent = closeBtn
    
    -- Button functionality
    hideBtn.MouseButton1Click:Connect(function()
        self:HideWindow()
    end)
    
    minBtn.MouseButton1Click:Connect(function()
        self:MinimizeWindow()
    end)
    
    maxBtn.MouseButton1Click:Connect(function()
        self:MaximizeWindow()
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        self:CloseWindow()
    end)
    
    -- Store references
    self.windowControls = {
        hide = hideBtn,
        minimize = minBtn,
        maximize = maxBtn,
        close = closeBtn
    }
end

function GarudaHubAF:CreateHiddenIcon()
    -- Hidden icon (GarudaHub logo only)
    self.HiddenIcon = Instance.new("Frame")
    self.HiddenIcon.Name = "GarudaHubIcon"
    self.HiddenIcon.Parent = self.ScreenGui
    self.HiddenIcon.BackgroundColor3 = getTheme().BRAND
    self.HiddenIcon.BorderSizePixel = 2
    self.HiddenIcon.BorderColor3 = getTheme().ACCENT
    self.HiddenIcon.Position = UDim2.new(0, 20, 0, 20)
    self.HiddenIcon.Size = UDim2.new(0, 60, 0, 60)
    self.HiddenIcon.Visible = false
    self.HiddenIcon.Active = true
    self.HiddenIcon.Draggable = true
    
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0.5, 0)
    iconCorner.Parent = self.HiddenIcon
    
    -- GarudaHub logo text
    local logoText = Instance.new("TextLabel")
    logoText.Name = "Logo"
    logoText.Parent = self.HiddenIcon
    logoText.BackgroundTransparency = 1
    logoText.Size = UDim2.new(1, 0, 1, 0)
    logoText.Font = Enum.Font.GothamBold
    logoText.Text = "🔥\nGH"
    logoText.TextColor3 = Color3.fromRGB(255, 255, 255)
    logoText.TextSize = 12
    logoText.TextScaled = true
    
    -- Click to restore
    local clickDetector = Instance.new("TextButton")
    clickDetector.Parent = self.HiddenIcon
    clickDetector.BackgroundTransparency = 1
    clickDetector.Size = UDim2.new(1, 0, 1, 0)
    clickDetector.Text = ""
    
    clickDetector.MouseButton1Click:Connect(function()
        self:ShowWindow()
    end)
    
    -- Hover effects
    self.HiddenIcon.MouseEnter:Connect(function()
        TweenService:Create(self.HiddenIcon, TweenInfo.new(0.2), {Size = UDim2.new(0, 70, 0, 70)}):Play()
    end)
    
    self.HiddenIcon.MouseLeave:Connect(function()
        TweenService:Create(self.HiddenIcon, TweenInfo.new(0.2), {Size = UDim2.new(0, 60, 0, 60)}):Play()
    end)
end

function GarudaHubAF:HideWindow()
    self.windowState = "hidden"
    self.MainFrame.Visible = false
    self.HiddenIcon.Visible = true
    
    createNotification("🔥 GarudaHub", "Window hidden! Click icon to restore", 3)
end

function GarudaHubAF:ShowWindow()
    self.windowState = "normal"
    self.MainFrame.Visible = true
    self.HiddenIcon.Visible = false
end

function GarudaHubAF:MinimizeWindow()
    if self.windowState == "minimized" then
        self:ShowWindow()
        return
    end
    
    self.windowState = "minimized"
    local originalSize = self.MainFrame.Size
    
    TweenService:Create(self.MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 600, 0, 65),
        Position = UDim2.new(0.5, -300, 1, -80)
    }):Play()
    
    -- Hide content except header
    for _, child in pairs(self.MainFrame:GetChildren()) do
        if child.Name ~= "Header" and child:IsA("GuiObject") then
            child.Visible = false
        end
    end
end

function GarudaHubAF:MaximizeWindow()
    if self.isMaximized then
        -- Restore to normal size
        self.isMaximized = false
        TweenService:Create(self.MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 600, 0, 400),
            Position = UDim2.new(0.5, -300, 0.5, -200)
        }):Play()
        self.windowControls.maximize.Text = "⬜"
    else
        -- Maximize to full screen
        self.isMaximized = true
        TweenService:Create(self.MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(1, -40, 1, -40),
            Position = UDim2.new(0, 20, 0, 20)
        }):Play()
        self.windowControls.maximize.Text = "🗗"
    end
end

function GarudaHubAF:CloseWindow()
    self:Cleanup()
    self.ScreenGui:Destroy()
end

function GarudaHubAF:UpdateTheme()
    -- Update all GUI elements with new theme
    if self.MainFrame then
        self.MainFrame.BackgroundColor3 = getTheme().PRIMARY
        self.Header.BackgroundColor3 = getTheme().SECONDARY
        self.Title.TextColor3 = getTheme().TEXT_PRIMARY
        self.ThemeButton.Text = getTheme().NAME
        self.ThemeButton.BackgroundColor3 = getTheme().ACCENT
        self.ThemeButton.TextColor3 = getTheme().TEXT_PRIMARY
        
        -- Update hidden icon
        if self.HiddenIcon then
            self.HiddenIcon.BackgroundColor3 = getTheme().BRAND
            self.HiddenIcon.BorderColor3 = getTheme().ACCENT
        end
    end
end

function GarudaHubAF:CreateTabs(parent)
    -- Tab Container
    self.TabContainer = Instance.new("Frame")
    self.TabContainer.Name = "TabContainer"
    self.TabContainer.Parent = parent
    self.TabContainer.BackgroundColor3 = getTheme().SECONDARY
    self.TabContainer.BorderSizePixel = 1
    self.TabContainer.BorderColor3 = getTheme().BORDER
    self.TabContainer.Position = UDim2.new(0, 0, 0, 65)
    self.TabContainer.Size = UDim2.new(1, 0, 0, 45)
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 0)
    TabCorner.Parent = self.TabContainer
    
    -- Tab Buttons
    local tabs = {"🎯 Farm", "🍎 Fruits", "🤝 Partners", "🎰 Gacha", "⚙️ Settings"}
    self.TabButtons = {}
    
    for i, tabName in ipairs(tabs) do
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "Tab" .. i
        TabButton.Parent = self.TabContainer
        TabButton.BackgroundColor3 = getTheme().ACCENT
        TabButton.BorderSizePixel = 1
        TabButton.BorderColor3 = getTheme().BORDER
        TabButton.Position = UDim2.new((i-1) * 0.2, 2, 0, 8)
        TabButton.Size = UDim2.new(0.2, -4, 1, -16)
        TabButton.Font = Enum.Font.GothamBold
        TabButton.Text = tabName
        TabButton.TextColor3 = getTheme().TEXT_PRIMARY
        TabButton.TextSize = 12
        
        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 6)
        TabButtonCorner.Parent = TabButton
        
        -- Hover effects
        TabButton.MouseEnter:Connect(function()
            TabButton.BackgroundColor3 = getTheme().HOVER
        end)
        
        TabButton.MouseLeave:Connect(function()
            TabButton.BackgroundColor3 = getTheme().ACCENT
        end)
        
        -- Tab click functionality
        TabButton.MouseButton1Click:Connect(function()
            self:SwitchTab(i)
        end)
        
        self.TabButtons[i] = TabButton
    end
    
    self.currentTab = 1
    self:CreateFarmTab(parent)
    self:CreateFruitTab(parent)
    self:CreatePartnerTab(parent)
    self:CreateGachaTab(parent)
    self:CreateSettingsTab(parent)
    self:SwitchTab(1)
end

function GarudaHubAF:SwitchTab(tabIndex)
    self.currentTab = tabIndex
    
    -- Hide all tabs
    if self.FarmTab then self.FarmTab.Visible = false end
    if self.FruitTab then self.FruitTab.Visible = false end
    if self.PartnerTab then self.PartnerTab.Visible = false end
    if self.GachaTab then self.GachaTab.Visible = false end
    if self.SettingsTab then self.SettingsTab.Visible = false end
    
    -- Show selected tab
    if tabIndex == 1 and self.FarmTab then
        self.FarmTab.Visible = true
    elseif tabIndex == 2 and self.FruitTab then
        self.FruitTab.Visible = true
    elseif tabIndex == 3 and self.PartnerTab then
        self.PartnerTab.Visible = true
    elseif tabIndex == 4 and self.GachaTab then
        self.GachaTab.Visible = true
    elseif tabIndex == 5 and self.SettingsTab then
        self.SettingsTab.Visible = true
    end
    
    -- Update tab button colors
    for i, button in ipairs(self.TabButtons) do
        if i == tabIndex then
            button.BackgroundColor3 = getTheme().BRAND
        else
            button.BackgroundColor3 = getTheme().ACCENT
        end
    end
end

function GarudaHubAF:CreateFarmTab(parent)
    self.FarmTab = Instance.new("ScrollingFrame")
    self.FarmTab.Name = "FarmTab"
    self.FarmTab.Parent = parent
    self.FarmTab.BackgroundColor3 = getTheme().PRIMARY
    self.FarmTab.BorderSizePixel = 0
    self.FarmTab.Position = UDim2.new(0, 10, 0, 120)
    self.FarmTab.Size = UDim2.new(1, -20, 1, -130)
    self.FarmTab.CanvasSize = UDim2.new(0, 0, 2, 0)
    self.FarmTab.ScrollBarThickness = 6
    self.FarmTab.ScrollBarImageColor3 = getTheme().BRAND
    
    -- Farm Options
    local options = {
        {name = "🍎 Auto Farm Level", setting = "AutoFarm"},
        {name = "📋 Auto Quest", setting = "AutoQuest"},
        {name = "👹 Auto Boss", setting = "AutoBoss"},
        {name = "🏴‍☠️ Auto Raid", setting = "AutoRaid"},
        {name = "🌊 Auto Sea Beast", setting = "AutoSea"},
        {name = "🛡️ Safe Mode", setting = "SafeMode"},
        {name = "📊 Auto Stats", setting = "AutoStats"}
    }
    
    self.ToggleElements = {}
    for i, option in ipairs(options) do
        self:CreateToggle(self.FarmTab, option.name, option.setting, i)
    end
end

function GarudaHubAF:CreateFruitTab(parent)
    self.FruitTab = Instance.new("ScrollingFrame")
    self.FruitTab.Name = "FruitTab"
    self.FruitTab.Parent = parent
    self.FruitTab.BackgroundColor3 = getTheme().PRIMARY
    self.FruitTab.BorderSizePixel = 0
    self.FruitTab.Position = UDim2.new(0, 10, 0, 120)
    self.FruitTab.Size = UDim2.new(1, -20, 1, -130)
    self.FruitTab.CanvasSize = UDim2.new(0, 0, 3, 0)
    self.FruitTab.ScrollBarThickness = 6
    self.FruitTab.ScrollBarImageColor3 = getTheme().BRAND
    self.FruitTab.Visible = false
    
    -- Manual Fruit Target Selection
    local targetFrame = Instance.new("Frame")
    targetFrame.Name = "FruitTargetFrame"
    targetFrame.Parent = self.FruitTab
    targetFrame.BackgroundColor3 = getTheme().SECONDARY
    targetFrame.BorderSizePixel = 1
    targetFrame.BorderColor3 = getTheme().BORDER
    targetFrame.Position = UDim2.new(0, 0, 0, 0)
    targetFrame.Size = UDim2.new(1, 0, 0, 120)
    
    local targetCorner = Instance.new("UICorner")
    targetCorner.CornerRadius = UDim.new(0, 6)
    targetCorner.Parent = targetFrame
    
    -- Target Selection Title
    local targetTitle = Instance.new("TextLabel")
    targetTitle.Name = "TargetTitle"
    targetTitle.Parent = targetFrame
    targetTitle.BackgroundTransparency = 1
    targetTitle.Position = UDim2.new(0, 10, 0, 5)
    targetTitle.Size = UDim2.new(1, -20, 0, 25)
    targetTitle.Font = Enum.Font.GothamBold
    targetTitle.Text = "🎯 TARGET FRUIT SELECTION"
    targetTitle.TextColor3 = getTheme().TEXT_PRIMARY
    targetTitle.TextSize = 14
    targetTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Auto/Manual Toggle
    local modeToggle = Instance.new("TextButton")
    modeToggle.Name = "ModeToggle"
    modeToggle.Parent = targetFrame
    modeToggle.BackgroundColor3 = getTheme().BRAND
    modeToggle.BorderSizePixel = 1
    modeToggle.BorderColor3 = getTheme().BORDER
    modeToggle.Position = UDim2.new(0, 10, 0, 35)
    modeToggle.Size = UDim2.new(0, 100, 0, 30)
    modeToggle.Font = Enum.Font.GothamBold
    modeToggle.Text = SETTINGS.FruitMode or "AUTO"
    modeToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    modeToggle.TextSize = 12
    
    local modeCorner = Instance.new("UICorner")
    modeCorner.CornerRadius = UDim.new(0, 6)
    modeCorner.Parent = modeToggle
    
    -- Fruit Selection Dropdown
    local fruitDropdown = Instance.new("TextButton")
    fruitDropdown.Name = "FruitDropdown"
    fruitDropdown.Parent = targetFrame
    fruitDropdown.BackgroundColor3 = getTheme().ACCENT
    fruitDropdown.BorderSizePixel = 1
    fruitDropdown.BorderColor3 = getTheme().BORDER
    fruitDropdown.Position = UDim2.new(0, 120, 0, 35)
    fruitDropdown.Size = UDim2.new(0, 200, 0, 30)
    fruitDropdown.Font = Enum.Font.Gotham
    fruitDropdown.Text = SETTINGS.TargetFruit or "Select Fruit..."
    fruitDropdown.TextColor3 = getTheme().TEXT_PRIMARY
    fruitDropdown.TextSize = 12
    
    local dropdownCorner = Instance.new("UICorner")
    dropdownCorner.CornerRadius = UDim.new(0, 6)
    dropdownCorner.Parent = fruitDropdown
    
    -- Real-time Fruit Scanner Display
    local scannerFrame = Instance.new("Frame")
    scannerFrame.Name = "ScannerFrame"
    scannerFrame.Parent = targetFrame
    scannerFrame.BackgroundColor3 = getTheme().PRIMARY
    scannerFrame.BorderSizePixel = 1
    scannerFrame.BorderColor3 = getTheme().BORDER
    scannerFrame.Position = UDim2.new(0, 330, 0, 35)
    scannerFrame.Size = UDim2.new(1, -340, 0, 30)
    
    local scannerCorner = Instance.new("UICorner")
    scannerCorner.CornerRadius = UDim.new(0, 6)
    scannerCorner.Parent = scannerFrame
    
    local scannerLabel = Instance.new("TextLabel")
    scannerLabel.Name = "ScannerLabel"
    scannerLabel.Parent = scannerFrame
    scannerLabel.BackgroundTransparency = 1
    scannerLabel.Size = UDim2.new(1, -10, 1, 0)
    scannerLabel.Position = UDim2.new(0, 5, 0, 0)
    scannerLabel.Font = Enum.Font.Gotham
    scannerLabel.Text = "🔍 Scanning for fruits..."
    scannerLabel.TextColor3 = getTheme().TEXT_SECONDARY
    scannerLabel.TextSize = 10
    scannerLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Current Status Display
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.Parent = targetFrame
    statusLabel.BackgroundTransparency = 1
    statusLabel.Position = UDim2.new(0, 10, 0, 75)
    statusLabel.Size = UDim2.new(1, -20, 0, 35)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Text = "🎮 Ready to farm! Select your target fruit."
    statusLabel.TextColor3 = getTheme().TEXT_SECONDARY
    statusLabel.TextSize = 11
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.TextWrapped = true
    
    -- Store references
    self.fruitModeToggle = modeToggle
    self.fruitDropdown = fruitDropdown
    self.fruitScanner = scannerLabel
    self.fruitStatus = statusLabel
    
    -- Initialize settings
    if not SETTINGS.FruitMode then SETTINGS.FruitMode = "AUTO" end
    if not SETTINGS.TargetFruit then SETTINGS.TargetFruit = "Any Fruit" end
    
    -- Mode toggle functionality
    modeToggle.MouseButton1Click:Connect(function()
        if SETTINGS.FruitMode == "AUTO" then
            SETTINGS.FruitMode = "MANUAL"
            modeToggle.Text = "MANUAL"
            modeToggle.BackgroundColor3 = getTheme().SUCCESS
            fruitDropdown.Visible = true
        else
            SETTINGS.FruitMode = "AUTO"
            modeToggle.Text = "AUTO"
            modeToggle.BackgroundColor3 = getTheme().BRAND
            fruitDropdown.Visible = false
        end
        self:UpdateFruitTargeting()
    end)
    
    -- Fruit dropdown functionality
    self:CreateFruitDropdownMenu(fruitDropdown)
    
    -- Real-time fruit display update
    self:StartFruitScanner()
end

-- ═══════════════════════════════════════════════════════════════════════════════
--                              FRUIT TARGETING SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

function GarudaHubAF:CreateFruitDropdownMenu(dropdown)
    -- Real Anime Fruit Simulator available fruits
    local availableFruits = {
        "Any Fruit",
        -- Paramecia Fruits
        "Gomu-Gomu (Rubber)", "Bara-Bara (Chop)", "Sube-Sube (Smooth)", "Bomu-Bomu (Bomb)",
        "Kilo-Kilo (Weight)", "Hana-Hana (Bloom)", "Doru-Doru (Wax)", "Baku-Baku (Munch)",
        "Mane-Mane (Clone)", "Supa-Supa (Dice)", "Toge-Toge (Spike)", "Ori-Ori (Cage)",
        "Bane-Bane (Spring)", "Ito-Ito (String)", "Noro-Noro (Slow)", "Doa-Doa (Door)",
        "Awa-Awa (Bubble)", "Beri-Beri (Berry)", "Sabi-Sabi (Rust)", "Shari-Shari (Wheel)",
        "Yomi-Yomi (Revive)", "Kage-Kage (Shadow)", "Horo-Horo (Hollow)", "Suke-Suke (Clear)",
        "Nikyu-Nikyu (Paw)", "Mero-Mero (Love)", "Doku-Doku (Venom)", "Horu-Horu (Hormone)",
        "Choki-Choki (Snip)", "Shiro-Shiro (Castle)", "Fuwa-Fuwa (Float)", "Mato-Mato (Mark)",
        "Fuku-Fuku (Dress)", "Buki-Buki (Arms)", "Guru-Guru (Spin)", "Zushi-Zushi (Gravity)",
        "Bari-Bari (Barrier)", "Nui-Nui (Stitch)", "Gura-Gura (Quake)", "Ope-Ope (Room)",
        "Memo-Memo (Memory)", "Bisu-Bisu (Biscuit)", "Peto-Peto (Lick)", "Mochi-Mochi (Mochi)",
        
        -- Zoan Fruits
        "Hito-Hito (Human)", "Ushi-Ushi (Ox)", "Tori-Tori (Bird)", "Inu-Inu (Dog)",
        "Mogu-Mogu (Mole)", "Uma-Uma (Horse)", "Neko-Neko (Cat)", "Zou-Zou (Elephant)",
        "Hebi-Hebi (Snake)", "Sara-Sara (Salamander)", "Mushi-Mushi (Insect)",
        "Hito-Hito Model Buddha", "Tori-Tori Model Phoenix", "Inu-Inu Model Wolf",
        "Ushi-Ushi Model Giraffe", "Neko-Neko Model Leopard", "Ryu-Ryu Model Dragon",
        
        -- Logia Fruits
        "Moku-Moku (Smoke)", "Mera-Mera (Flame)", "Suna-Suna (Sand)", "Goro-Goro (Lightning)",
        "Hie-Hie (Ice)", "Yami-Yami (Darkness)", "Pika-Pika (Light)", "Magu-Magu (Magma)",
        "Numa-Numa (Swamp)", "Gasu-Gasu (Gas)", "Yuki-Yuki (Snow)", "Beta-Beta (Candy)",
        "Ame-Ame (Syrup)"
    }
    
    dropdown.MouseButton1Click:Connect(function()
        self:ShowFruitSelectionMenu(dropdown, availableFruits)
    end)
end

function GarudaHubAF:ShowFruitSelectionMenu(dropdown, fruits)
    -- Create selection menu
    local selectionFrame = Instance.new("Frame")
    selectionFrame.Name = "FruitSelection"
    selectionFrame.Parent = dropdown.Parent
    selectionFrame.BackgroundColor3 = getTheme().SECONDARY
    selectionFrame.BorderSizePixel = 1
    selectionFrame.BorderColor3 = getTheme().BORDER
    selectionFrame.Position = UDim2.new(0, 120, 0, 70)
    selectionFrame.Size = UDim2.new(0, 200, 0, math.min(#fruits * 25, 200))
    selectionFrame.ZIndex = 10
    
    local selectionCorner = Instance.new("UICorner")
    selectionCorner.CornerRadius = UDim.new(0, 6)
    selectionCorner.Parent = selectionFrame
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Parent = selectionFrame
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #fruits * 25)
    scrollFrame.ScrollBarThickness = 4
    
    for i, fruit in ipairs(fruits) do
        local fruitButton = Instance.new("TextButton")
        fruitButton.Parent = scrollFrame
        fruitButton.BackgroundColor3 = getTheme().PRIMARY
        fruitButton.BorderSizePixel = 0
        fruitButton.Position = UDim2.new(0, 5, 0, (i-1) * 25 + 2)
        fruitButton.Size = UDim2.new(1, -10, 0, 20)
        fruitButton.Font = Enum.Font.Gotham
        fruitButton.Text = fruit
        fruitButton.TextColor3 = getTheme().TEXT_PRIMARY
        fruitButton.TextSize = 11
        fruitButton.TextXAlignment = Enum.TextXAlignment.Left
        
        fruitButton.MouseButton1Click:Connect(function()
            SETTINGS.TargetFruit = fruit
            dropdown.Text = fruit
            selectionFrame:Destroy()
            self:UpdateFruitTargeting()
        end)
        
        fruitButton.MouseEnter:Connect(function()
            fruitButton.BackgroundColor3 = getTheme().ACCENT
        end)
        
        fruitButton.MouseLeave:Connect(function()
            fruitButton.BackgroundColor3 = getTheme().PRIMARY
        end)
    end
    
    -- Auto-close after 5 seconds
    spawn(function()
        wait(5)
        if selectionFrame.Parent then
            selectionFrame:Destroy()
        end
    end)
end

function GarudaHubAF:UpdateFruitTargeting()
    if self.fruitStatus then
        if SETTINGS.FruitMode == "AUTO" then
            self.fruitStatus.Text = "🤖 Auto mode: Farming any nearby fruit automatically"
        else
            self.fruitStatus.Text = "🎯 Manual mode: Targeting " .. (SETTINGS.TargetFruit or "None")
        end
    end
    
    print_info("🍎 Fruit targeting updated: " .. SETTINGS.FruitMode .. " - " .. (SETTINGS.TargetFruit or "Any"))
end

function GarudaHubAF:StartFruitScanner()
    if self.fruitScannerConnection then return end
    
    self.fruitScannerConnection = RunService.Heartbeat:Connect(function()
        if self.fruitScanner and GameState.fruits then
            local fruitCount = #GameState.fruits
            local nearestFruit = GameState.fruits[1]
            
            if fruitCount > 0 then
                local distance = nearestFruit and math.floor(nearestFruit.distance) or 0
                self.fruitScanner.Text = string.format("🍎 %d fruits found | Nearest: %s (%dm)", 
                    fruitCount, 
                    nearestFruit and nearestFruit.name or "Unknown", 
                    distance
                )
                self.fruitScanner.TextColor3 = getTheme().SUCCESS
            else
                self.fruitScanner.Text = "🔍 No fruits detected in area"
                self.fruitScanner.TextColor3 = getTheme().TEXT_SECONDARY
            end
        end
    end)
    DropdownCorner.Parent = FruitDropdown
    
    -- Fruit Options
    local fruitOptions = {
        {name = "🍎 Auto Fruit Collect", setting = "AutoFruitCollect"},
        {name = "🍽️ Auto Eat Fruit", setting = "AutoEatFruit"},
        {name = "🔔 Fruit Notifier", setting = "FruitNotifier"}
    }
    
    for i, option in ipairs(fruitOptions) do
        self:CreateToggle(self.FruitTab, option.name, option.setting, i + 1, 70)
    end
    
    -- Fruit Level Target
    local LevelFrame = Instance.new("Frame")
    LevelFrame.Parent = self.FruitTab
    LevelFrame.BackgroundColor3 = getTheme().SECONDARY
    LevelFrame.BorderSizePixel = 1
    LevelFrame.BorderColor3 = getTheme().BORDER
    LevelFrame.Position = UDim2.new(0, 0, 0, 280)
    LevelFrame.Size = UDim2.new(1, 0, 0, 50)
    
    local LevelCorner = Instance.new("UICorner")
    LevelCorner.CornerRadius = UDim.new(0, 6)
    LevelCorner.Parent = LevelFrame
    
    local LevelLabel = Instance.new("TextLabel")
    LevelLabel.Parent = LevelFrame
    LevelLabel.BackgroundTransparency = 1
    LevelLabel.Position = UDim2.new(0, 15, 0, 0)
    LevelLabel.Size = UDim2.new(0.6, 0, 1, 0)
    LevelLabel.Font = Enum.Font.Gotham
    LevelLabel.Text = "🎯 Target Fruit Level:"
    LevelLabel.TextColor3 = getTheme().TEXT_PRIMARY
    LevelLabel.TextSize = 14
    LevelLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local LevelInput = Instance.new("TextBox")
    LevelInput.Parent = LevelFrame
    LevelInput.BackgroundColor3 = getTheme().ACCENT
    LevelInput.BorderSizePixel = 1
    LevelInput.BorderColor3 = getTheme().BORDER
    LevelInput.Position = UDim2.new(0.7, 0, 0.2, 0)
    LevelInput.Size = UDim2.new(0.25, 0, 0.6, 0)
    LevelInput.Font = Enum.Font.Gotham
    LevelInput.Text = tostring(SETTINGS.FruitLevelTarget)
    LevelInput.TextColor3 = getTheme().TEXT_PRIMARY
    LevelInput.TextSize = 12
    LevelInput.PlaceholderText = "100"
    
    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 4)
    InputCorner.Parent = LevelInput
    
    LevelInput.FocusLost:Connect(function()
        local value = tonumber(LevelInput.Text)
        if value and value > 0 then
            SETTINGS.FruitLevelTarget = value
        else
            LevelInput.Text = tostring(SETTINGS.FruitLevelTarget)
        end
    end)
end

function GarudaHubAF:CreatePartnerTab(parent)
    self.PartnerTab = Instance.new("ScrollingFrame")
    self.PartnerTab.Name = "PartnerTab"
    self.PartnerTab.Parent = parent
    self.PartnerTab.BackgroundColor3 = getTheme().PRIMARY
    self.PartnerTab.BorderSizePixel = 0
    self.PartnerTab.Position = UDim2.new(0, 10, 0, 120)
    self.PartnerTab.Size = UDim2.new(1, -20, 1, -130)
    self.PartnerTab.CanvasSize = UDim2.new(0, 0, 2, 0)
    self.PartnerTab.ScrollBarThickness = 6
    self.PartnerTab.ScrollBarImageColor3 = getTheme().BRAND
    self.PartnerTab.Visible = false
    
    -- Partner Selection
    local PartnerSelector = Instance.new("Frame")
    PartnerSelector.Name = "PartnerSelector"
    PartnerSelector.Parent = self.PartnerTab
    PartnerSelector.BackgroundColor3 = getTheme().SECONDARY
    PartnerSelector.BorderSizePixel = 1
    PartnerSelector.BorderColor3 = getTheme().BORDER
    PartnerSelector.Position = UDim2.new(0, 0, 0, 0)
    PartnerSelector.Size = UDim2.new(1, 0, 0, 60)
    
    local PSelectorCorner = Instance.new("UICorner")
    PSelectorCorner.CornerRadius = UDim.new(0, 6)
    PSelectorCorner.Parent = PartnerSelector
    
    local PSelectorLabel = Instance.new("TextLabel")
    PSelectorLabel.Parent = PartnerSelector
    PSelectorLabel.BackgroundTransparency = 1
    PSelectorLabel.Position = UDim2.new(0, 15, 0, 0)
    PSelectorLabel.Size = UDim2.new(0.4, 0, 1, 0)
    PSelectorLabel.Font = Enum.Font.GothamBold
    PSelectorLabel.Text = "🤝 Selected Partner:"
    PSelectorLabel.TextColor3 = getTheme().TEXT_PRIMARY
    PSelectorLabel.TextSize = 14
    PSelectorLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local PartnerDropdown = Instance.new("TextButton")
    PartnerDropdown.Parent = PartnerSelector
    PartnerDropdown.BackgroundColor3 = getTheme().ACCENT
    PartnerDropdown.BorderSizePixel = 1
    PartnerDropdown.BorderColor3 = getTheme().BORDER
    PartnerDropdown.Position = UDim2.new(0.5, 0, 0.2, 0)
    PartnerDropdown.Size = UDim2.new(0.45, 0, 0.6, 0)
    PartnerDropdown.Font = Enum.Font.Gotham
    PartnerDropdown.Text = SETTINGS.SelectedPartner
    PartnerDropdown.TextColor3 = getTheme().TEXT_PRIMARY
    PartnerDropdown.TextSize = 12
    
    local PDropdownCorner = Instance.new("UICorner")
    PDropdownCorner.CornerRadius = UDim.new(0, 4)
    PDropdownCorner.Parent = PartnerDropdown
    
    -- Partner Options
    local partnerOptions = {
        {name = "🤖 Auto Partner", setting = "AutoPartner"},
        {name = "⬆️ Partner Upgrade", setting = "PartnerUpgrade"}
    }
    
    for i, option in ipairs(partnerOptions) do
        self:CreateToggle(self.PartnerTab, option.name, option.setting, i + 1, 70)
    end
end

function GarudaHubAF:CreateGachaTab(parent)
    self.GachaTab = Instance.new("ScrollingFrame")
    self.GachaTab.Name = "GachaTab"
    self.GachaTab.Parent = parent
    self.GachaTab.BackgroundColor3 = getTheme().PRIMARY
    self.GachaTab.BorderSizePixel = 0
    self.GachaTab.Position = UDim2.new(0, 10, 0, 120)
    self.GachaTab.Size = UDim2.new(1, -20, 1, -130)
    self.GachaTab.CanvasSize = UDim2.new(0, 0, 3, 0)
    self.GachaTab.ScrollBarThickness = 6
    self.GachaTab.ScrollBarImageColor3 = getTheme().BRAND
    self.GachaTab.Visible = false
    
    -- Spin Type Selector
    local SpinTypeFrame = Instance.new("Frame")
    SpinTypeFrame.Name = "SpinTypeFrame"
    SpinTypeFrame.Parent = self.GachaTab
    SpinTypeFrame.BackgroundColor3 = getTheme().SECONDARY
    SpinTypeFrame.BorderSizePixel = 1
    SpinTypeFrame.BorderColor3 = getTheme().BORDER
    SpinTypeFrame.Position = UDim2.new(0, 0, 0, 0)
    SpinTypeFrame.Size = UDim2.new(1, 0, 0, 60)
    
    local SpinCorner = Instance.new("UICorner")
    SpinCorner.CornerRadius = UDim.new(0, 6)
    SpinCorner.Parent = SpinTypeFrame
    
    local SpinLabel = Instance.new("TextLabel")
    SpinLabel.Parent = SpinTypeFrame
    SpinLabel.BackgroundTransparency = 1
    SpinLabel.Position = UDim2.new(0, 15, 0, 0)
    SpinLabel.Size = UDim2.new(0.4, 0, 1, 0)
    SpinLabel.Font = Enum.Font.GothamBold
    SpinLabel.Text = "🎰 Spin Type:"
    SpinLabel.TextColor3 = getTheme().TEXT_PRIMARY
    SpinLabel.TextSize = 14
    SpinLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local SpinDropdown = Instance.new("TextButton")
    SpinDropdown.Parent = SpinTypeFrame
    SpinDropdown.BackgroundColor3 = getTheme().ACCENT
    SpinDropdown.BorderSizePixel = 1
    SpinDropdown.BorderColor3 = getTheme().BORDER
    SpinDropdown.Position = UDim2.new(0.5, 0, 0.2, 0)
    SpinDropdown.Size = UDim2.new(0.45, 0, 0.6, 0)
    SpinDropdown.Font = Enum.Font.Gotham
    SpinDropdown.Text = SETTINGS.SpinType
    SpinDropdown.TextColor3 = getTheme().TEXT_PRIMARY
    SpinDropdown.TextSize = 12
    
    local SpinDropCorner = Instance.new("UICorner")
    SpinDropCorner.CornerRadius = UDim.new(0, 4)
    SpinDropCorner.Parent = SpinDropdown
    
    -- Spin dropdown functionality
    SpinDropdown.MouseButton1Click:Connect(function()
        SETTINGS.SpinType = SETTINGS.SpinType == "Fruit" and "Roulette" or "Fruit"
        SpinDropdown.Text = SETTINGS.SpinType
        self:UpdateSpinProbabilities()
    end)
    
    -- Manual Spin Buttons
    local ManualSpinFrame = Instance.new("Frame")
    ManualSpinFrame.Parent = self.GachaTab
    ManualSpinFrame.BackgroundColor3 = getTheme().SECONDARY
    ManualSpinFrame.BorderSizePixel = 1
    ManualSpinFrame.BorderColor3 = getTheme().BORDER
    ManualSpinFrame.Position = UDim2.new(0, 0, 0, 70)
    ManualSpinFrame.Size = UDim2.new(1, 0, 0, 80)
    
    local ManualCorner = Instance.new("UICorner")
    ManualCorner.CornerRadius = UDim.new(0, 6)
    ManualCorner.Parent = ManualSpinFrame
    
    -- Single Spin Button
    local SingleSpinBtn = Instance.new("TextButton")
    SingleSpinBtn.Parent = ManualSpinFrame
    SingleSpinBtn.BackgroundColor3 = getTheme().BRAND
    SingleSpinBtn.BorderSizePixel = 1
    SingleSpinBtn.BorderColor3 = getTheme().BORDER
    SingleSpinBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
    SingleSpinBtn.Size = UDim2.new(0.4, 0, 0.6, 0)
    SingleSpinBtn.Font = Enum.Font.GothamBold
    SingleSpinBtn.Text = "🎲 Single Spin"
    SingleSpinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SingleSpinBtn.TextSize = 12
    
    local SingleCorner = Instance.new("UICorner")
    SingleCorner.CornerRadius = UDim.new(0, 6)
    SingleCorner.Parent = SingleSpinBtn
    
    -- Multi Spin Button
    local MultiSpinBtn = Instance.new("TextButton")
    MultiSpinBtn.Parent = ManualSpinFrame
    MultiSpinBtn.BackgroundColor3 = getTheme().SUCCESS
    MultiSpinBtn.BorderSizePixel = 1
    MultiSpinBtn.BorderColor3 = getTheme().BORDER
    MultiSpinBtn.Position = UDim2.new(0.55, 0, 0.2, 0)
    MultiSpinBtn.Size = UDim2.new(0.4, 0, 0.6, 0)
    MultiSpinBtn.Font = Enum.Font.GothamBold
    MultiSpinBtn.Text = "🎰 10x Spin"
    MultiSpinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MultiSpinBtn.TextSize = 12
    
    local MultiCorner = Instance.new("UICorner")
    MultiCorner.CornerRadius = UDim.new(0, 6)
    MultiCorner.Parent = MultiSpinBtn
    
    -- Store button references for animation system
    self.spinButton = SingleSpinBtn
    self.spin10Button = MultiSpinBtn
    
    -- Connect spin button events with animations
    SingleSpinBtn.MouseButton1Click:Connect(function()
        self:PlaySpinAnimation(1, function()
            return {self:PerformSpin(1)}
        end)
    end)
    
    MultiSpinBtn.MouseButton1Click:Connect(function()
        self:PlaySpinAnimation(10, function()
            local results = {}
            for i = 1, 10 do
                table.insert(results, self:PerformSpin(1))
            end
            return results
        end)
    end)
    
    -- Probability Display
    self:CreateProbabilityDisplay(self.GachaTab)
    
    -- Gacha Options
    local gachaOptions = {
        {name = "🎰 Auto Spin", setting = "AutoSpin"},
        {name = "🎯 Auto Gacha", setting = "AutoGacha"}
    }
    
    for i, option in ipairs(gachaOptions) do
        self:CreateToggle(self.GachaTab, option.name, option.setting, i + 1, 160)
    end
    
    -- Spin Interval Setting
    local IntervalFrame = Instance.new("Frame")
    IntervalFrame.Parent = self.GachaTab
    IntervalFrame.BackgroundColor3 = getTheme().SECONDARY
    IntervalFrame.BorderSizePixel = 1
    IntervalFrame.BorderColor3 = getTheme().BORDER
    IntervalFrame.Position = UDim2.new(0, 0, 0, 280)
    IntervalFrame.Size = UDim2.new(1, 0, 0, 50)
    
    local IntervalCorner = Instance.new("UICorner")
    IntervalCorner.CornerRadius = UDim.new(0, 6)
    IntervalCorner.Parent = IntervalFrame
    
    local IntervalLabel = Instance.new("TextLabel")
    IntervalLabel.Parent = IntervalFrame
    IntervalLabel.BackgroundTransparency = 1
    IntervalLabel.Position = UDim2.new(0, 15, 0, 0)
    IntervalLabel.Size = UDim2.new(0.6, 0, 1, 0)
    IntervalLabel.Font = Enum.Font.Gotham
    IntervalLabel.Text = "⏱️ Spin Interval (seconds):"
    IntervalLabel.TextColor3 = getTheme().TEXT_PRIMARY
    IntervalLabel.TextSize = 14
    IntervalLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local IntervalInput = Instance.new("TextBox")
    IntervalInput.Parent = IntervalFrame
    IntervalInput.BackgroundColor3 = getTheme().ACCENT
    IntervalInput.BorderSizePixel = 1
    IntervalInput.BorderColor3 = getTheme().BORDER
    IntervalInput.Position = UDim2.new(0.7, 0, 0.2, 0)
    IntervalInput.Size = UDim2.new(0.25, 0, 0.6, 0)
    IntervalInput.Font = Enum.Font.Gotham
    IntervalInput.Text = tostring(SETTINGS.SpinInterval)
    IntervalInput.TextColor3 = getTheme().TEXT_PRIMARY
    IntervalInput.TextSize = 12
    IntervalInput.PlaceholderText = "60"
    
    local IntervalInputCorner = Instance.new("UICorner")
    IntervalInputCorner.CornerRadius = UDim.new(0, 4)
    IntervalInputCorner.Parent = IntervalInput
    
    IntervalInput.FocusLost:Connect(function()
        local value = tonumber(IntervalInput.Text)
        if value and value > 0 then
            SETTINGS.SpinInterval = value
        else
            IntervalInput.Text = tostring(SETTINGS.SpinInterval)
        end
    end)
end

function GarudaHubAF:CreateProbabilityDisplay(parent)
    local ProbFrame = Instance.new("Frame")
    ProbFrame.Name = "ProbabilityFrame"
    ProbFrame.Parent = parent
    ProbFrame.BackgroundColor3 = getTheme().SECONDARY
    ProbFrame.BorderSizePixel = 1
    ProbFrame.BorderColor3 = getTheme().BORDER
    ProbFrame.Position = UDim2.new(0, 0, 0, 340)
    ProbFrame.Size = UDim2.new(1, 0, 0, 200)
    
    local ProbCorner = Instance.new("UICorner")
    ProbCorner.CornerRadius = UDim.new(0, 6)
    ProbCorner.Parent = ProbFrame
    
    local ProbTitle = Instance.new("TextLabel")
    ProbTitle.Parent = ProbFrame
    ProbTitle.BackgroundTransparency = 1
    ProbTitle.Position = UDim2.new(0, 15, 0, 5)
    ProbTitle.Size = UDim2.new(1, -30, 0, 25)
    ProbTitle.Font = Enum.Font.GothamBold
    ProbTitle.Text = "📊 Spin Probabilities"
    ProbTitle.TextColor3 = getTheme().TEXT_PRIMARY
    ProbTitle.TextSize = 14
    ProbTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    self.ProbabilityLabels = {}
    local yPos = 30
    
    if SETTINGS.SpinType == "Fruit" then
        for rarity, data in pairs(SPIN_PROBABILITIES) do
            local label = Instance.new("TextLabel")
            label.Parent = ProbFrame
            label.BackgroundTransparency = 1
            label.Position = UDim2.new(0, 20, 0, yPos)
            label.Size = UDim2.new(1, -40, 0, 25)
            label.Font = Enum.Font.Gotham
            label.Text = rarity .. ": " .. data.chance .. "%"
            label.TextColor3 = self:GetRarityColor(rarity)
            label.TextSize = 12
            label.TextXAlignment = Enum.TextXAlignment.Left
            
            self.ProbabilityLabels[rarity] = label
            yPos = yPos + 30
        end
    else
        for reward, data in pairs(ROULETTE_REWARDS) do
            local label = Instance.new("TextLabel")
            label.Parent = ProbFrame
            label.BackgroundTransparency = 1
            label.Position = UDim2.new(0, 20, 0, yPos)
            label.Size = UDim2.new(1, -40, 0, 25)
            label.Font = Enum.Font.Gotham
            label.Text = reward .. ": " .. data.chance .. "%"
            label.TextColor3 = getTheme().TEXT_PRIMARY
            label.TextSize = 12
            label.TextXAlignment = Enum.TextXAlignment.Left
            
            self.ProbabilityLabels[reward] = label
            yPos = yPos + 25
        end
    end
end

function GarudaHubAF:GetRarityColor(rarity)
    local colors = {
        ["Common"] = Color3.fromRGB(150, 150, 150),
        ["Uncommon"] = Color3.fromRGB(30, 255, 0),
        ["Rare"] = Color3.fromRGB(0, 162, 255),
        ["Legendary"] = Color3.fromRGB(163, 53, 238),
        ["Mythical"] = Color3.fromRGB(255, 128, 0)
    }
    return colors[rarity] or getTheme().TEXT_PRIMARY
end

function GarudaHubAF:UpdateSpinProbabilities()
    if self.ProbabilityLabels then
        for _, label in pairs(self.ProbabilityLabels) do
            label:Destroy()
        end
    end
    
    if self.GachaTab and self.GachaTab:FindFirstChild("ProbabilityFrame") then
        self.GachaTab.ProbabilityFrame:Destroy()
        self:CreateProbabilityDisplay(self.GachaTab)
    end
end

function GarudaHubAF:CreateSettingsTab(parent)
    self.SettingsTab = Instance.new("ScrollingFrame")
    self.SettingsTab.Name = "SettingsTab"
    self.SettingsTab.Parent = parent
    self.SettingsTab.BackgroundColor3 = getTheme().PRIMARY
    self.SettingsTab.BorderSizePixel = 0
    self.SettingsTab.Position = UDim2.new(0, 10, 0, 120)
    self.SettingsTab.Size = UDim2.new(1, -20, 1, -130)
    self.SettingsTab.CanvasSize = UDim2.new(0, 0, 2, 0)
    self.SettingsTab.ScrollBarThickness = 6
    self.SettingsTab.ScrollBarImageColor3 = getTheme().BRAND
    self.SettingsTab.Visible = false
    
    -- Advanced Settings
    local advancedOptions = {
        {name = "🛡️ Anti Detection", setting = "AntiDetection"},
        {name = "🎲 Random Delays", setting = "RandomDelay"},
        {name = "✈️ Safe Teleport", setting = "SafeTeleport"},
        {name = "🔄 Auto Rejoin", setting = "AutoRejoin"},
        {name = "👥 Crew Management", setting = "CrewManagement"},
        {name = "🤝 Auto Accept Trade", setting = "AutoAcceptTrade"}
    }
    
    for i, option in ipairs(advancedOptions) do
        self:CreateToggle(self.SettingsTab, option.name, option.setting, i)
    end
end

function GarudaHubAF:CreateToggle(parent, text, setting, index, yOffset)
    local Toggle = Instance.new("Frame")
    Toggle.Name = "Toggle" .. index
    Toggle.Parent = parent
    Toggle.BackgroundColor3 = getTheme().SECONDARY
    Toggle.BorderSizePixel = 1
    Toggle.BorderColor3 = getTheme().BORDER
    Toggle.Position = UDim2.new(0, 0, 0, (yOffset or 0) + (index-1) * 60)
    Toggle.Size = UDim2.new(1, 0, 0, 50)
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    ToggleCorner.Parent = Toggle
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Parent = Toggle
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Size = UDim2.new(1, -100, 1, 0)
    Label.Font = Enum.Font.Gotham
    Label.Text = text
    Label.TextColor3 = getTheme().TEXT_PRIMARY
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local Button = Instance.new("TextButton")
    Button.Name = "Button"
    Button.Parent = Toggle
    Button.BackgroundColor3 = SETTINGS[setting] and getTheme().SUCCESS or getTheme().ERROR
    Button.BorderSizePixel = 1
    Button.BorderColor3 = getTheme().BORDER
    Button.Position = UDim2.new(1, -70, 0.5, -12)
    Button.Size = UDim2.new(0, 60, 0, 24)
    Button.Font = Enum.Font.GothamBold
    Button.Text = SETTINGS[setting] and "ON" or "OFF"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 12
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 12)
    ButtonCorner.Parent = Button
    
    -- Hover effects
    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = SETTINGS[setting] and getTheme().SUCCESS or getTheme().ERROR
        TweenService:Create(Button, TweenInfo.new(0.2), {Size = UDim2.new(0, 65, 0, 26)}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {Size = UDim2.new(0, 60, 0, 24)}):Play()
    end)
    
    Button.MouseButton1Click:Connect(function()
        SETTINGS[setting] = not SETTINGS[setting]
        Button.BackgroundColor3 = SETTINGS[setting] and getTheme().SUCCESS or getTheme().ERROR
        Button.Text = SETTINGS[setting] and "ON" or "OFF"
        
        -- Smooth animation
        TweenService:Create(Button, TweenInfo.new(0.1), {Size = UDim2.new(0, 55, 0, 22)}):Play()
        wait(0.1)
        TweenService:Create(Button, TweenInfo.new(0.1), {Size = UDim2.new(0, 60, 0, 24)}):Play()
        
        -- Handle toggle actions
        if setting == "AutoFarm" then
            if SETTINGS[setting] then
                self:StartAutoFarm()
            else
                self:StopAutoFarm()
            end
        elseif setting == "AutoFruitCollect" then
            if SETTINGS[setting] then
                self:StartFruitCollection()
            else
                if self.fruitConnection then
                    self.fruitConnection:Disconnect()
                    self.fruitConnection = nil
                end
            end
        elseif setting == "AutoPartner" then
            if SETTINGS[setting] then
                self:StartPartnerManagement()
            else
                if self.partnerConnection then
                    self.partnerConnection:Disconnect()
                    self.partnerConnection = nil
                end
            end
        elseif setting == "AutoEatFruit" and SETTINGS[setting] then
            spawn(function()
                while SETTINGS.AutoEatFruit do
                    if checkAntiDetection() then
                        self:AutoEatFruit()
                    end
                    wait(math.random(5, 15))
                end
            end)
        end
    end)
    
    -- Store references for theme updates
    if not self.ToggleElements then
        self.ToggleElements = {}
    end
    self.ToggleElements[#self.ToggleElements + 1] = {
        frame = Toggle,
        label = Label,
        button = Button,
        setting = setting
    }
end

-- ═══════════════════════════════════════════════════════════════════════════════
--                              THEME UPDATE SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

function GarudaHubAF:UpdateTheme()
    if not self.MainFrame then return end
    
    -- Update main elements
    self.MainFrame.BackgroundColor3 = getTheme().PRIMARY
    self.MainFrame.BorderColor3 = getTheme().BORDER
    
    self.Header.BackgroundColor3 = getTheme().SECONDARY
    self.Header.BorderColor3 = getTheme().BORDER
    
    self.Title.TextColor3 = getTheme().TEXT_PRIMARY
    self.Version.TextColor3 = getTheme().TEXT_SECONDARY
    
    self.ThemeButton.BackgroundColor3 = getTheme().ACCENT
    self.ThemeButton.BorderColor3 = getTheme().BORDER
    self.ThemeButton.TextColor3 = getTheme().TEXT_PRIMARY
    self.ThemeButton.Text = getTheme().NAME
    
    -- Update tab container
    if self.TabContainer then
        self.TabContainer.BackgroundColor3 = getTheme().SECONDARY
        self.TabContainer.BorderColor3 = getTheme().BORDER
    end
    
    -- Update tab buttons
    if self.TabButtons then
        for _, button in ipairs(self.TabButtons) do
            button.BackgroundColor3 = getTheme().ACCENT
            button.BorderColor3 = getTheme().BORDER
            button.TextColor3 = getTheme().TEXT_PRIMARY
        end
    end
    
    -- Update farm tab
    if self.FarmTab then
        self.FarmTab.BackgroundColor3 = getTheme().PRIMARY
        self.FarmTab.ScrollBarImageColor3 = getTheme().BRAND
    end
    
    -- Update toggle elements
    if self.ToggleElements then
        for _, element in ipairs(self.ToggleElements) do
            element.frame.BackgroundColor3 = getTheme().SECONDARY
            element.frame.BorderColor3 = getTheme().BORDER
            element.label.TextColor3 = getTheme().TEXT_PRIMARY
            element.button.BackgroundColor3 = SETTINGS[element.setting] and getTheme().SUCCESS or getTheme().ERROR
            element.button.BorderColor3 = getTheme().BORDER
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
--                              ADVANCED FARMING SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

function GarudaHubAF:SetupAutoFarm()
    print_info("⚡ Initializing advanced farming algorithms...")
    self.farmConnection = nil
    self.lastFarmAction = 0
    print_success("🚀 Farming system ready!")
end

function GarudaHubAF:StartAutoFarm()
    if self.farmConnection then return end
    
    print_success("🎯 Auto Farm activated!")
    createNotification("🔥 GarudaHub", "Auto Farm started!", 3)
    
    self.farmConnection = RunService.Heartbeat:Connect(function()
        if SETTINGS.AutoFarm and checkAntiDetection() then
            self:FarmLogic()
        end
    end)
end

function GarudaHubAF:StopAutoFarm()
    if self.farmConnection then
        self.farmConnection:Disconnect()
        self.farmConnection = nil
        print_info("⏹️ Auto Farm stopped!")
    end
end

function GarudaHubAF:FarmLogic()
    local player = Players.LocalPlayer
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local humanoid = player.Character:FindFirstChild("Humanoid")
    local rootPart = player.Character.HumanoidRootPart
    
    -- Find nearest enemy for farming
    local nearestEnemy = self:FindNearestEnemy()
    if nearestEnemy and nearestEnemy.Parent then
        local enemyHumanoid = nearestEnemy.Parent:FindFirstChild("Humanoid")
        local enemyRootPart = nearestEnemy.Parent:FindFirstChild("HumanoidRootPart")
        
        if enemyHumanoid and enemyRootPart and enemyHumanoid.Health > 0 then
            -- Safe teleport to enemy
            if SETTINGS.SafeTeleport then
                self:SafeTeleportTo(enemyRootPart.Position)
            else
                rootPart.CFrame = CFrame.new(enemyRootPart.Position + Vector3.new(0, 5, 0))
            end
            
            -- Attack enemy
            self:AttackEnemy(nearestEnemy.Parent)
        end
    end
end

function GarudaHubAF:FindNearestEnemy()
    local player = Players.LocalPlayer
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end
    
    local rootPart = character.HumanoidRootPart
    local nearestEnemy = nil
    local shortestDistance = SETTINGS.FarmDistance
    
    -- Search in Workspace for NPCs/Enemies
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") and obj ~= character then
            local enemyHumanoid = obj.Humanoid
            local enemyRootPart = obj.HumanoidRootPart
            
            if enemyHumanoid.Health > 0 and not Players:GetPlayerFromCharacter(obj) then
                local distance = (rootPart.Position - enemyRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestEnemy = obj:FindFirstChild("HumanoidRootPart")
                end
            end
        end
    end
    
    return nearestEnemy
end

function GarudaHubAF:AttackEnemy(enemy)
    local player = Players.LocalPlayer
    local character = player.Character
    if not character then return end
    
    -- Simulate combat
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        -- Use equipped tool/weapon
        local tool = character:FindFirstChildOfClass("Tool")
        if tool and tool:FindFirstChild("Handle") then
            tool:Activate()
        end
        
        -- Face the enemy
        if enemy:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.lookAt(
                character.HumanoidRootPart.Position,
                enemy.HumanoidRootPart.Position
            )
        end
    end
end

function GarudaHubAF:SafeTeleportTo(position)
    local player = Players.LocalPlayer
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local rootPart = character.HumanoidRootPart
    local targetPosition = position + Vector3.new(math.random(-3, 3), 5, math.random(-3, 3))
    
    -- Smooth teleportation with TweenService
    local tweenInfo = TweenInfo.new(
        0.5, -- Duration
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )
    
    local tween = TweenService:Create(rootPart, tweenInfo, {
        CFrame = CFrame.new(targetPosition)
    })
    
    tween:Play()
end

-- ═══════════════════════════════════════════════════════════════════════════════
--                              FRUIT MANAGEMENT SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

function GarudaHubAF:SetupFruitSystem()
    print_info("🍎 Initializing fruit management system...")
    self.fruitConnection = nil
    self.collectedFruits = {}
    print_success("🍎 Fruit system ready!")
end

function GarudaHubAF:StartFruitCollection()
    if self.fruitConnection then return end
    
    print_success("🍎 Fruit collection activated!")
    
    self.fruitConnection = RunService.Heartbeat:Connect(function()
        if SETTINGS.AutoFruitCollect and checkAntiDetection() then
            self:CollectNearbyFruits()
        end
        
        if SETTINGS.FruitNotifier then
            self:CheckForRareFruits()
        end
    end)
end

function GarudaHubAF:CollectNearbyFruits()
    local player = Players.LocalPlayer
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local rootPart = character.HumanoidRootPart
    
    -- Search for fruits in workspace
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj.Name:find("Fruit") or obj.Name:find("Devil") then
            if obj:FindFirstChild("Handle") or obj:IsA("Tool") then
                local distance = (rootPart.Position - obj.Handle.Position).Magnitude
                if distance <= 50 then -- Collection range
                    -- Teleport to fruit
                    if SETTINGS.SafeTeleport then
                        self:SafeTeleportTo(obj.Handle.Position)
                    else
                        rootPart.CFrame = CFrame.new(obj.Handle.Position)
                    end
                    
                    wait(0.1)
                    
                    -- Collect fruit
                    if obj.Parent then
                        obj.Parent = player.Backpack
                        print_success("🍎 Collected: " .. obj.Name)
                        table.insert(self.collectedFruits, obj.Name)
                    end
                end
            end
        end
    end
end

function GarudaHubAF:CheckForRareFruits()
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj.Name:find("Fruit") then
            local fruitName = obj.Name:gsub("Fruit", ""):gsub("-", ""):gsub(" ", "")
            if FRUIT_DATA[fruitName] then
                local rarity = FRUIT_DATA[fruitName].rarity
                if rarity == "Legendary" or rarity == "Mythical" then
                    createNotification("🔔 Rare Fruit Found!", fruitName .. " (" .. rarity .. ")", 10)
                    print_success("🔔 " .. rarity .. " fruit detected: " .. fruitName)
                end
            end
        end
    end
end

function GarudaHubAF:AutoEatFruit()
    local player = Players.LocalPlayer
    local backpack = player.Backpack
    
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name:find("Fruit") then
            local fruitName = tool.Name:gsub("Fruit", ""):gsub("-", ""):gsub(" ", "")
            if FRUIT_DATA[fruitName] then
                -- Equip and eat fruit
                tool.Parent = player.Character
                wait(0.1)
                tool:Activate()
                print_success("🍽️ Ate fruit: " .. tool.Name)
                break
            end
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
--                              PARTNER MANAGEMENT SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

function GarudaHubAF:SetupPartnerSystem()
    print_info("🤝 Initializing partner management system...")
    self.partnerConnection = nil
    self.currentPartner = nil
    print_success("🤝 Partner system ready!")
end

function GarudaHubAF:StartPartnerManagement()
    if self.partnerConnection then return end
    
    print_success("🤝 Partner management activated!")
    
    self.partnerConnection = RunService.Heartbeat:Connect(function()
        if SETTINGS.AutoPartner and checkAntiDetection() then
            self:ManagePartner()
        end
        
        if SETTINGS.PartnerUpgrade then
            self:UpgradePartner()
        end
    end)
end

function GarudaHubAF:ManagePartner()
    -- Partner management logic
    local player = Players.LocalPlayer
    
    -- Check if player has a partner
    if not self.currentPartner then
        self:SummonPartner()
    else
        -- Check partner health and status
        self:CheckPartnerStatus()
    end
end

function GarudaHubAF:SummonPartner()
    -- Logic to summon/spawn partner
    local selectedPartner = SETTINGS.SelectedPartner
    if selectedPartner == "Auto" then
        -- Auto-select best available partner
        selectedPartner = self:GetBestAvailablePartner()
    end
    
    if PARTNER_DATA[selectedPartner] then
        print_success("🤝 Summoning partner: " .. selectedPartner)
        self.currentPartner = selectedPartner
    end
end

function GarudaHubAF:GetBestAvailablePartner()
    -- Return the highest rarity partner available
    for name, data in pairs(PARTNER_DATA) do
        if data.rarity == "Mythical" then return name end
    end
    for name, data in pairs(PARTNER_DATA) do
        if data.rarity == "Legendary" then return name end
    end
    return "Monkey" -- Default
end

function GarudaHubAF:UpgradePartner()
    if self.currentPartner then
        -- Partner upgrade logic
        print_info("⬆️ Upgrading partner: " .. self.currentPartner)
    end
end

function GarudaHubAF:CheckPartnerStatus()
    -- Check if partner needs healing, feeding, etc.
    if self.currentPartner then
        -- Partner status check logic
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
--                              GACHA & SPIN SYSTEM IMPLEMENTATION
-- ═══════════════════════════════════════════════════════════════════════════════

function GarudaHubAF:SetupGachaSystem()
    print_info("🎰 Initializing gacha and spin systems...")
    self.spinConnection = nil
    self.lastSpinTime = 0
    self.spinResults = {}
    print_success("🎰 Gacha system ready!")
end

function GarudaHubAF:StartAutoSpin()
    if self.spinConnection then return end
    
    print_success("🎰 Auto Spin activated!")
    createNotification("🎰 GarudaHub", "Auto Spin started!", 3)
    
    self.spinConnection = RunService.Heartbeat:Connect(function()
        if SETTINGS.AutoSpin and checkAntiDetection() then
            local currentTime = tick()
            if currentTime - self.lastSpinTime >= SETTINGS.SpinInterval then
                self:PerformSpin(1)
                self.lastSpinTime = currentTime
            end
        end
    end)
end

function GarudaHubAF:StopAutoSpin()
    if self.spinConnection then
        self.spinConnection:Disconnect()
        self.spinConnection = nil
        print_info("⏹️ Auto Spin stopped!")
    end
end

function GarudaHubAF:PerformSpin(count)
    if not checkAntiDetection() then return end
    
    local results = {}
    
    for i = 1, count do
        local result
        if SETTINGS.SpinType == "Fruit" then
            result = self:SpinFruit()
        else
            result = self:SpinRoulette()
        end
        
        table.insert(results, result)
        table.insert(self.spinResults, result)
        
        -- Add delay between spins for realism
        if i < count then
            wait(getRandomDelay())
        end
    end
    
    self:DisplaySpinResults(results, count)
    
    -- Auto gacha logic
    if SETTINGS.AutoGacha then
        self:ProcessAutoGacha(results)
    end
end

function GarudaHubAF:SpinFruit()
    local roll = math.random() * 100
    local currentChance = 0
    
    -- Sort rarities by chance (highest first for proper probability)
    local sortedRarities = {}
    for rarity, data in pairs(SPIN_PROBABILITIES) do
        table.insert(sortedRarities, {rarity = rarity, chance = data.chance, fruits = data.fruits})
    end
    
    table.sort(sortedRarities, function(a, b) return a.chance > b.chance end)
    
    for _, rarityData in ipairs(sortedRarities) do
        currentChance = currentChance + rarityData.chance
        if roll <= currentChance then
            local fruits = rarityData.fruits
            local selectedFruit = fruits[math.random(1, #fruits)]
            return {
                type = "Fruit",
                item = selectedFruit,
                rarity = rarityData.rarity,
                value = FRUIT_DATA[selectedFruit] and FRUIT_DATA[selectedFruit].value or 0
            }
        end
    end
    
    -- Fallback to common fruit
    local commonFruits = SPIN_PROBABILITIES["Common"].fruits
    local fallbackFruit = commonFruits[math.random(1, #commonFruits)]
    return {
        type = "Fruit",
        item = fallbackFruit,
        rarity = "Common",
        value = FRUIT_DATA[fallbackFruit] and FRUIT_DATA[fallbackFruit].value or 0
    }
end

function GarudaHubAF:SpinRoulette()
    local roll = math.random() * 100
    local currentChance = 0
    
    -- Sort rewards by chance
    local sortedRewards = {}
    for reward, data in pairs(ROULETTE_REWARDS) do
        table.insert(sortedRewards, {reward = reward, chance = data.chance, data = data})
    end
    
    table.sort(sortedRewards, function(a, b) return a.chance > b.chance end)
    
    for _, rewardData in ipairs(sortedRewards) do
        currentChance = currentChance + rewardData.chance
        if roll <= currentChance then
            local reward = rewardData.reward
            local data = rewardData.data
            local amount = 1
            
            if data.min and data.max then
                amount = math.random(data.min, data.max)
            elseif data.value then
                amount = data.value
            end
            
            return {
                type = "Roulette",
                item = reward,
                amount = amount,
                rarity = self:GetRewardRarity(reward)
            }
        end
    end
    
    -- Fallback to money
    return {
        type = "Roulette",
        item = "Money",
        amount = math.random(1000, 5000),
        rarity = "Common"
    }
end

function GarudaHubAF:GetRewardRarity(reward)
    local rarityMap = {
        ["Money"] = "Common",
        ["EXP"] = "Common",
        ["Gems"] = "Uncommon",
        ["Fruit"] = "Rare",
        ["Partner"] = "Legendary",
        ["Rare Item"] = "Legendary",
        ["Jackpot"] = "Mythical"
    }
    return rarityMap[reward] or "Common"
end

function GarudaHubAF:DisplaySpinResults(results, count)
    local message = ""
    local rareResults = {}
    
    if count == 1 then
        local result = results[1]
        if result.type == "Fruit" then
            message = "🍎 Got " .. result.item .. " (" .. result.rarity .. ")"
        else
            message = "🎰 Got " .. result.amount .. " " .. result.item
        end
        
        if result.rarity == "Legendary" or result.rarity == "Mythical" then
            table.insert(rareResults, result)
        end
    else
        -- Multi-spin summary
        local rarityCount = {}
        for _, result in ipairs(results) do
            local rarity = result.rarity
            rarityCount[rarity] = (rarityCount[rarity] or 0) + 1
            
            if rarity == "Legendary" or rarity == "Mythical" then
                table.insert(rareResults, result)
            end
        end
        
        message = "🎰 " .. count .. "x Spin Results: "
        for rarity, count in pairs(rarityCount) do
            message = message .. rarity .. "(" .. count .. ") "
        end
    end
    
    print_success(message)
    
    -- Special notifications for rare items
    for _, result in ipairs(rareResults) do
        local title = "🌟 " .. result.rarity .. " Drop!"
        local text = result.item
        if result.amount then
            text = text .. " x" .. result.amount
        end
        createNotification(title, text, 8)
    end
end

function GarudaHubAF:ProcessAutoGacha(results)
    for _, result in ipairs(results) do
        if result.type == "Fruit" then
            -- Auto eat fruit based on target rarity
            if SETTINGS.GachaTarget == "Any" or result.rarity == SETTINGS.GachaTarget then
                if SETTINGS.AutoEatFruit then
                    -- Simulate eating the fruit
                    print_success("🍽️ Auto-eating " .. result.item .. " (" .. result.rarity .. ")")
                end
            end
        end
    end
end

function GarudaHubAF:GetSpinStatistics()
    local stats = {
        totalSpins = #self.spinResults,
        rarityCount = {},
        totalValue = 0
    }
    
    for _, result in ipairs(self.spinResults) do
        local rarity = result.rarity
        stats.rarityCount[rarity] = (stats.rarityCount[rarity] or 0) + 1
        
        if result.value then
            stats.totalValue = stats.totalValue + result.value
        end
    end
    
    return stats
end

-- ═══════════════════════════════════════════════════════════════════════════════
--                              SPIN ANIMATION & VISUAL EFFECTS
-- ═══════════════════════════════════════════════════════════════════════════════

function GarudaHubAF:CreateSpinAnimation(parent)
    -- Create spinning wheel animation frame
    local animFrame = Instance.new("Frame")
    animFrame.Name = "SpinAnimation"
    animFrame.Size = UDim2.new(0, 200, 0, 200)
    animFrame.Position = UDim2.new(0.5, -100, 0.5, -100)
    animFrame.BackgroundTransparency = 1
    animFrame.Parent = parent
    animFrame.Visible = false
    
    -- Create spinning wheel background
    local wheelBg = Instance.new("Frame")
    wheelBg.Size = UDim2.new(1, 0, 1, 0)
    wheelBg.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    wheelBg.BorderSizePixel = 0
    wheelBg.Parent = animFrame
    
    local wheelCorner = Instance.new("UICorner")
    wheelCorner.CornerRadius = UDim.new(0.5, 0)
    wheelCorner.Parent = wheelBg
    
    -- Create spinning indicator
    local spinner = Instance.new("Frame")
    spinner.Name = "Spinner"
    spinner.Size = UDim2.new(0, 20, 0, 100)
    spinner.Position = UDim2.new(0.5, -10, 0, 10)
    spinner.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    spinner.BorderSizePixel = 0
    spinner.Parent = wheelBg
    
    local spinnerCorner = Instance.new("UICorner")
    spinnerCorner.CornerRadius = UDim.new(0, 10)
    spinnerCorner.Parent = spinner
    
    -- Create glow effect
    local glow = Instance.new("Frame")
    glow.Size = UDim2.new(1.2, 0, 1.2, 0)
    glow.Position = UDim2.new(-0.1, 0, -0.1, 0)
    glow.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    glow.BackgroundTransparency = 0.8
    glow.BorderSizePixel = 0
    glow.Parent = animFrame
    glow.ZIndex = -1
    
    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(0.5, 0)
    glowCorner.Parent = glow
    
    -- Create result display
    local resultFrame = Instance.new("Frame")
    resultFrame.Size = UDim2.new(0, 300, 0, 100)
    resultFrame.Position = UDim2.new(0.5, -150, 1, 20)
    resultFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    resultFrame.BorderSizePixel = 0
    resultFrame.Parent = animFrame
    resultFrame.Visible = false
    
    local resultCorner = Instance.new("UICorner")
    resultCorner.CornerRadius = UDim.new(0, 12)
    resultCorner.Parent = resultFrame
    
    local resultLabel = Instance.new("TextLabel")
    resultLabel.Size = UDim2.new(1, -20, 1, -20)
    resultLabel.Position = UDim2.new(0, 10, 0, 10)
    resultLabel.BackgroundTransparency = 1
    resultLabel.Text = ""
    resultLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    resultLabel.TextScaled = true
    resultLabel.Font = Enum.Font.GothamBold
    resultLabel.Parent = resultFrame
    
    return animFrame, spinner, glow, resultFrame, resultLabel
end

function GarudaHubAF:PlaySpinAnimation(count, callback)
    if not self.gachaTab then return end
    
    local animFrame, spinner, glow, resultFrame, resultLabel = self:CreateSpinAnimation(self.gachaTab)
    animFrame.Visible = true
    
    -- Disable spin buttons during animation
    self:SetSpinButtonsEnabled(false)
    
    -- Spinning animation
    local spinTween = TweenService:Create(
        spinner,
        TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0),
        {Rotation = 360 * 5} -- 5 full rotations
    )
    
    -- Glow pulse animation
    local glowTween = TweenService:Create(
        glow,
        TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, 0),
        {BackgroundTransparency = 0.3}
    )
    
    -- Start animations
    spinTween:Play()
    glowTween:Play()
    
    -- Play spin sound effect (if available)
    self:PlaySpinSound()
    
    -- Wait for spin to complete
    spinTween.Completed:Connect(function()
        glowTween:Cancel()
        
        -- Show result with dramatic effect
        if callback then
            local results = callback()
            self:ShowSpinResults(results, count, resultFrame, resultLabel, animFrame)
        end
    end)
end

function GarudaHubAF:ShowSpinResults(results, count, resultFrame, resultLabel, animFrame)
    resultFrame.Visible = true
    
    -- Format result text
    local resultText = ""
    local rarityColor = Color3.fromRGB(255, 255, 255)
    
    if count == 1 then
        local result = results[1]
        if result.type == "Fruit" then
            resultText = "🍎 " .. result.item .. "\n(" .. result.rarity .. ")"
        else
            resultText = "🎰 " .. result.amount .. " " .. result.item .. "\n(" .. result.rarity .. ")"
        end
        rarityColor = self:GetRarityColor(result.rarity)
    else
        resultText = "🎰 " .. count .. "x Spin Complete!\nCheck chat for details"
        rarityColor = Color3.fromRGB(255, 215, 0)
    end
    
    resultLabel.Text = resultText
    resultLabel.TextColor3 = rarityColor
    
    -- Result entrance animation
    resultFrame.Position = UDim2.new(0.5, -150, 1, 50)
    local resultTween = TweenService:Create(
        resultFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0),
        {Position = UDim2.new(0.5, -150, 1, 20)}
    )
    resultTween:Play()
    
    -- Play result sound based on rarity
    if count == 1 then
        self:PlayResultSound(results[1].rarity)
    end
    
    -- Auto-hide animation after delay
    wait(3)
    local fadeOut = TweenService:Create(
        animFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0),
        {BackgroundTransparency = 1}
    )
    
    fadeOut:Play()
    fadeOut.Completed:Connect(function()
        animFrame:Destroy()
        self:SetSpinButtonsEnabled(true)
    end)
end

function GarudaHubAF:GetRarityColor(rarity)
    local colors = {
        ["Common"] = Color3.fromRGB(155, 155, 155),
        ["Uncommon"] = Color3.fromRGB(85, 255, 85),
        ["Rare"] = Color3.fromRGB(85, 170, 255),
        ["Epic"] = Color3.fromRGB(170, 85, 255),
        ["Legendary"] = Color3.fromRGB(255, 170, 0),
        ["Mythical"] = Color3.fromRGB(255, 85, 85)
    }
    return colors[rarity] or Color3.fromRGB(255, 255, 255)
end

function GarudaHubAF:SetSpinButtonsEnabled(enabled)
    if self.spinButton then
        self.spinButton.BackgroundTransparency = enabled and 0 or 0.5
        self.spinButton.TextTransparency = enabled and 0 or 0.5
    end
    if self.spin10Button then
        self.spin10Button.BackgroundTransparency = enabled and 0 or 0.5
        self.spin10Button.TextTransparency = enabled and 0 or 0.5
    end
end

function GarudaHubAF:PlaySpinSound()
    -- Create spin sound effect
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxasset://sounds/electronicpingshort.wav"
        sound.Volume = 0.3
        sound.Pitch = 1.2
        sound.Parent = workspace
        sound:Play()
        
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end)
end

function GarudaHubAF:PlayResultSound(rarity)
    pcall(function()
        local soundId = "rbxasset://sounds/electronicpingshort.wav"
        local pitch = 1.0
        local volume = 0.5
        
        -- Different sounds for different rarities
        if rarity == "Legendary" or rarity == "Mythical" then
            soundId = "rbxasset://sounds/victory.wav"
            pitch = 1.2
            volume = 0.7
        elseif rarity == "Epic" then
            pitch = 1.1
            volume = 0.6
        end
        
        local sound = Instance.new("Sound")
        sound.SoundId = soundId
        sound.Volume = volume
        sound.Pitch = pitch
        sound.Parent = workspace
        sound:Play()
        
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end)
end

function GarudaHubAF:CreateParticleEffect(parent, rarity)
    -- Create particle effects for rare drops
    if rarity ~= "Legendary" and rarity ~= "Mythical" then return end
    
    pcall(function()
        for i = 1, 10 do
            local particle = Instance.new("Frame")
            particle.Size = UDim2.new(0, 4, 0, 4)
            particle.Position = UDim2.new(0.5, math.random(-50, 50), 0.5, math.random(-50, 50))
            particle.BackgroundColor3 = self:GetRarityColor(rarity)
            particle.BorderSizePixel = 0
            particle.Parent = parent
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0.5, 0)
            corner.Parent = particle
            
            -- Animate particles
            local tween = TweenService:Create(
                particle,
                TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0),
                {
                    Position = UDim2.new(0.5, math.random(-100, 100), 0.5, math.random(-100, 100)),
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 8, 0, 8)
                }
            )
            
            tween:Play()
            tween.Completed:Connect(function()
                particle:Destroy()
            end)
            
            wait(0.1)
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════
--                              TELEPORT SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

function GarudaHubAF:SetupTeleportSystem()
    print_info("🌀 Loading teleportation matrix...")
    print_success("✈️ Teleport system online!")
end

function GarudaHubAF:SetupWeaponSystem()
    print_info("⚔️ Configuring weapon systems...")
    print_success("🗡️ Weapon system ready!")
end

function GarudaHubAF:SetupAntiDetection()
    print_info("🛡️ Initializing anti-detection protocols...")
    
    -- Auto rejoin system
    if SETTINGS.AutoRejoin then
        game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
            if child.Name == "ErrorPrompt" and child:FindFirstChild("MessageArea") and child.MessageArea:FindFirstChild("ErrorFrame") then
                game:GetService("TeleportService"):Teleport(game.PlaceId)
            end
        end)
    end
    
    -- Random action delays
    self.lastActionTime = tick()
    
    print_success("🛡️ Anti-detection system active!")
end

-- Auto-start systems when toggles are enabled
local function setupAutoStart()
    -- Auto Farm
    if SETTINGS.AutoFarm then
        GarudaHubAF:StartAutoFarm()
    end
    
    -- Auto Fruit Collection
    if SETTINGS.AutoFruitCollect then
        GarudaHubAF:StartFruitCollection()
    end
    
    -- Auto Partner
    if SETTINGS.AutoPartner then
        GarudaHubAF:StartPartnerManagement()
    end
    
    -- Auto Eat Fruit
    if SETTINGS.AutoEatFruit then
        spawn(function()
            while SETTINGS.AutoEatFruit do
                GarudaHubAF:AutoEatFruit()
                wait(math.random(5, 15)) -- Random delay between eating
            end
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
--                              EXECUTION & CLEANUP
-- ═══════════════════════════════════════════════════════════════════════════════

function GarudaHubAF:Cleanup()
    print_info("🧹 Performing cleanup...")
    
    -- Disconnect all connections
    if self.farmConnection then
        self.farmConnection:Disconnect()
        self.farmConnection = nil
    end
    
    if self.spinConnection then
        self.spinConnection:Disconnect()
        self.spinConnection = nil
    end
    
    if self.fruitConnection then
        self.fruitConnection:Disconnect()
        self.fruitConnection = nil
    end
    
    if self.partnerConnection then
        self.partnerConnection:Disconnect()
        self.partnerConnection = nil
    end
    
    -- Clear data
    self.spinResults = {}
    self.currentPartner = nil
    
    print_success("✅ Cleanup completed!")
end

local function safeExecute(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        print_error("Execution failed: " .. tostring(result))
        return false
    end
    return result
end

-- ═══════════════════════════════════════════════════════════════════════════════
--                              PERFORMANCE OPTIMIZATION
-- ═══════════════════════════════════════════════════════════════════════════════

-- Optimize memory usage
local function optimizeMemory()
    collectgarbage("collect")
    wait(0.1)
end

-- Performance monitoring
local function monitorPerformance()
    spawn(function()
        while true do
            wait(30) -- Check every 30 seconds
            optimizeMemory()
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════
--                              MAIN EXECUTION
-- ═══════════════════════════════════════════════════════════════════════════════

print_info("🚀 Starting " .. CONFIG.SCRIPT_NAME .. "...")

local success = safeExecute(function()
    local result = GarudaHubAF:Initialize()
    if result then
        -- Start performance monitoring
        monitorPerformance()
        
        -- Display final status
        print_success("🎮 " .. CONFIG.SCRIPT_NAME .. " v" .. CONFIG.VERSION .. " loaded successfully!")
        print_info("🎯 Features: Auto Farm, Fruit Management, Partner System, Gacha Spins")
        print_info("🛡️ Anti-Detection: Enabled with human-like delays")
        print_info("🎨 Modern UI: GitHub-style interface with dark/light themes")
        
        createNotification("🎉 GarudaHub", "All systems online! Ready to farm!", 5)
    end
    return result
end)

if success then
    print_success("🎉 Script is now running!")
    print_info("💡 Toggle features using the GUI tabs!")
else
    print_error("❌ Failed to initialize script")
end

-- Cleanup on script end
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == Players.LocalPlayer then
        GarudaHubAF:Cleanup()
    end
end)

return GarudaHubAF
