local name, OJMD_TV = ...


OJMD_TV.Data = {}

OJMD_TV.Data.RaceIcons = {
    FEMALE = {
        HUMAN = 130904,
        DWARF = 130902,
        NIGHTELF = 130905,
        GNOME = 130903,
        Orc = 130906,
        Troll = 130909,
        Tauren = 130908,
        Untoter = 130907
    },
    MALE = {
        HUMAN = 130914,
        DWARF = 130912,
        NIGHTELF = 130915,
        GNOME = 130913,
        Orc = 130916,
        Troll = 130919,
        Tauren = 130918,
        Untoter = 130917
    }
}

OJMD_TV.Data.RaceIconsAlt = {
    FEMALE = {
        HUMAN = 236447,
        DWARF = 236443,
        NIGHTELF = 236449,
        GNOME = 236445,
        Orc = 236451,
        Troll = 236455,
        Tauren = 236453,
        Untoter = 236457
    },
    MALE = {
        HUMAN = 236448,
        DWARF = 236444,
        NIGHTELF = 236450,
        GNOME = 236446,
        Orc = 236452,
        Troll = 236456,
        Tauren = 236454,
        Untoter = 236458
    }
}

OJMD_TV.Data.ClassIDs = { 'WARRIOR', 'DRUID', 'PALADIN', 'PRIEST', 'SHAMAN', 'HUNTER', 'MAGE', 'ROGUE', 'WARLOCK' }

OJMD_TV.Data.SpecIcons = {
	DRUID = { Balance = 'Interface\\Icons\\Spell_Nature_Starfall', Feral = 132276, Restoration = 'Interface\\Icons\\Spell_Nature_HealingTouch' },
	DEATHKNIGHT = { Frost = '', Blood = '', Unholy = ''},
	HUNTER = { BeastMastery = 132164, Marksmanship = 132222, Survival = 132215},
	ROGUE = { Assassination = 132292, Combat = 132090, Subtlety = 132089},
	MAGE = { Frost = '', Fire = '', Arcane = ''},
	PRIEST = { Holy = '', Discipline = '', Shadow = ''},
	SHAMAN = { Elemental = 'Interface\\Icons\\Spell_Nature_Lightning', Enhancement = 'Interface\\Icons\\Spell_Nature_LightningShield', Restoration = 'Interface\\Icons\\Spell_Nature_MagicImmunity' },
	WARLOCK = { Demonology = '', Affliction = 'Interface\\Icons\\Spell_Shadow_DeathCoil', Destruction = ''},
	WARRIOR = { Arms = 132292, Fury = 132347, Protection = 132341},
	PALADIN = { Retribution = 135873, Holy = 135920, Protection = 135893},
}

OJMD_TV.Data.ClassColours = {
	DEATHKNIGHT = { r = 0.77, g = 0.12, b = 0.23, fs = '|cffC41F3B' }, -- ready for wrath :)
	DRUID = { r = 1.00, g = 0.49, b = 0.04, fs = '|cffFF7D0A' },
	HUNTER = { r = 0.67, g = 0.83, b = 0.45, fs = '|cffABD473' },
	MAGE = { r = 0.25, g = 0.78, b = 0.92, fs = '|cff40C7EB' },
	PALADIN = { r = 0.96, g = 0.55, b = 0.73, fs = '|cffF58CBA' },
	PRIEST = { r = 1.00, g = 1.00, b = 1.00, fs = '|cffFFFFFF' },
	ROGUE = { r = 1.00, g = 0.96, b = 0.41, fs = '|cffFFF569' },
	SHAMAN = { r = 0.00, g = 0.44, b = 0.87, fs = '|cff0070DE' },
	WARLOCK = { r = 0.53, g = 0.53, b =	0.93, fs = '|cff8787ED' },
	WARRIOR = { r = 0.78, g = 0.61, b = 0.43, fs = '|cffC79C6E' },
	Total = { r = 1, g = 1, b = 1 }
}

OJMD_TV.Data.ProfessionsID = {
	{ Id = 1, Name = 'Alchemy' },
	{ Id = 2, Name = 'Blacksmithing' },
	{ Id = 3, Name = 'Enchanting' },
	{ Id = 4, Name = 'Engineering' },
	{ Id = 5, Name = 'Inscription' },
	{ Id = 6, Name = 'Jewelcrafting' },
	{ Id = 7, Name = 'Leatherworking' },
	{ Id = 8, Name = 'Tailoring' },
	{ Id = 9, Name = 'Herbalism' },
	{ Id = 10, Name = 'Skinning' },
	{ Id = 11, Name = 'Mining' },
}

OJMD_TV.Data.ProfessionIcons = {
	Alchimie = 'Interface\\Icons\\Trade_Alchemy' ,
	Schmiedekunst = 'Interface\\Icons\\Trade_Blacksmithing' ,
	Verzauberkunst = 'Interface\\Icons\\Trade_Engraving' ,
	Ingenieurskunst = 'Interface\\Icons\\Trade_Engineering' ,
	Inscription = 'Interface\\Icons\\INV_Inscription_Tradeskill01' ,
	Jewelcrafting = 'Interface\\Icons\\INV_MISC_GEM_01' ,
	Lederverarbeitung = 'Interface\\Icons\\INV_Misc_ArmorKit_17' ,
	Schneiderei = 'Interface\\Icons\\Trade_Tailoring' ,
	Kraeuterkunde = 'Interface\\Icons\\INV_Misc_Flower_02' ,
	Kuerschnerei = 'Interface\\Icons\\INV_Misc_Pelt_Wolf_01' ,
	Bergbau = 'Interface\\Icons\\Spell_Fire_FlameBlades' ,
	Cooking = 135805, --'Interface\\Icons\\Trade_Cooking_2' ,
	Fishing = 136245, --'Interface\\Icons\\Trade_Fishing' ,
	FirstAid = 'Interface\\Icons\\Spell_Holy_SealOfSacrifice'
}

--[[
0 Poor ff9d9d9d
1 Common ffffffff
2 Uncommon ff1eff00
3 Rare ff0070dd
4 Epic ffa335ee
5 Legendary ffff8000
6 Artifact ffe6cc80
7 Heirloom ffe6cc80
8 WoW Token ff00ccff



]]