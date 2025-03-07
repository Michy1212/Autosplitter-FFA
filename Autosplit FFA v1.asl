// Autosplit for Final Fantasy Adventure
// Version 1
// Written by Michy1212 from Le Retroscope

state("bgb") {}
state("bgb64") {}
state("gambatte") {}
state("gambatte_qt") {}
state("gambatte_qt_nonpsr") {}
state("gambatte_speedrun") {}
state("gambatte_speedrun_other") {}
state("emuhawk") {}

startup {
    settings.Add("event",     true, "Event");
    settings.Add("location",  true, "Location");
    settings.Add("magic",     false, "Magic spells");
    settings.Add("equipment", false, "Equipment");
    settings.Add("boss",      false, "Boss");
    settings.Add("any",      false, "Any%");

    settings.CurrentDefaultParent = "boss";
	settings.Add("cat1",         false,  "Defeat Cat 1");
    settings.Add("hydra",        false,  "Defeat Hydra");
    settings.Add("lee",          false,  "Defeat Mr. Lee");
    settings.Add("megapede",     false,  "Defeat Megapede");
    settings.Add("medusa",       false,  "Defeat Medusa");
    settings.Add("davias",       false,  "Defeat Davias");
    settings.Add("metal crab",   false,  "Defeat Metal Crab");
    settings.Add("cyclops",      false,  "Defeat Cyclops");
    settings.Add("golem",        false,  "Defeat Golem");
    settings.Add("chimera",      false,  "Defeat Chimera");
    // settings.Add("dark lord",    false,  "Defeat Dark Lord");
    settings.Add("kary",         false,  "Defeat Kary");
    settings.Add("kraken",       false,  "Defeat Kraken");
    settings.Add("iflyte",       false,  "Defeat Iflyte");
    settings.Add("lich",         false,  "Defeat Lich");
    settings.Add("mantis",       false,  "Defeat Mantis Ant");
    settings.Add("garuda",       false,  "Defeat Garuda");
    settings.Add("dragon",       false,  "Defeat Dragon");
    // settings.Add("red dragon",   false,  "Defeat Red Dragon");
    // settings.Add("dragon z",     false,  "Defeat Dragon Zombie");
    // settings.Add("julius 1",     false,  "Defeat Julius 1");
    settings.Add("julius 2",     false,  "Defeat Julius 2");

    settings.CurrentDefaultParent = "event";
	settings.Add("ketts",        true,  "Sleep at Kett's");
    settings.Add("fuji glaive",  false,  "Save Fuji at Glaive Castle");
    settings.Add("chocobot",     true,  "Get Chocobot");
    settings.Add("recover mana", true,  "Recover Mana");

    settings.CurrentDefaultParent = "location";
	settings.Add("marsh cave",         true,  "Exit Marsh Cave");
    settings.Add("ketts dungeon",      true,  "Exit Kett's Dungeon");
    settings.Add("silver mine",        false,  "Exit Silver Mine");
    settings.Add("gaia",               true,  "Exit Gaia");
    settings.Add("airship",            true,  "Exit Airship");
    settings.Add("medusa cave",        true,  "Exit Medusa cave");
    settings.Add("davias mansion",     true,  "Exit Davias' Mansion");
    settings.Add("mt rocks",           true,  "Exit Cave of Mt. Rocks");
    settings.Add("glaive castle",      false,  "Exit Glaive Castle");
    settings.Add("ice cavern",         true,  "Exit Ice Cavern");
    settings.Add("floatrocks",         true,  "Exit Cave of Floatrocks");
    settings.Add("palmy desert",       true,  "Exit Cave of Palmy Desert");
    settings.Add("dime tower",         true,  "Exit Dime Tower");
    settings.Add("temple of mana",     true,  "Exit Temple of Mana");
    settings.Add("access final fight", false,  "Access Final Fight");

    settings.CurrentDefaultParent = "magic";
	settings.Add("magic cure",    false,  "Cure");
    settings.Add("magic fire",    false,  "Fire");
    settings.Add("magic sleep",   false,  "Sleep");
    settings.Add("magic heal",    false,  "Heal");
    settings.Add("magic ice",     false,  "Ice");
    settings.Add("magic mute",    false,  "Mute");
    settings.Add("magic lit",     false,  "Lightning");
    settings.Add("magic nuke",    false,  "Nuke");

    settings.CurrentDefaultParent = "equipment";
    settings.Add("silver armor", false,  "Silver Armor");
	settings.Add("star",         false,  "Star");
    settings.Add("ice sword",    false,  "Ice sword");
    settings.Add("rusty sword",  false,  "Rusty sword");
    settings.Add("excalibur",    false,  "Excalibur");

    settings.CurrentDefaultParent = "any";
    settings.Add("axe shop",            false,  "Axe shop");
    settings.Add("zip ish",             false,  "Zip to Ish");
    settings.Add("snowmanless glaive",  false,  "Snowmanless to Glaive Castle");
    settings.Add("zip floatrocks",      false,  "Zip to Cave of Floatrocks");

    refreshRate = 0.5;

    vars.TryFindOffsets = (Func<Process, long, bool>)((proc, baseAddress) => {
        long wramOffset = 0;
        string state = proc.ProcessName.ToLower();
        if (state.Contains("gambatte")) {
            IntPtr scanOffset = vars.SigScan(proc, 0, "53 45 49 4B 45 4E 20 44 45 4E 53 45 54 53 55 00 00 00 00");
            print("[Debug] scanOffset: " + scanOffset.ToString("X8"));
            wramOffset = (long)scanOffset + 0x45ECC;
            print("[Debug] WRAM Offset trouvé : " + wramOffset.ToString("X8"));
        } else if (state == "emuhawk") {
            IntPtr scanOffset = vars.SigScan(proc, 0, "05 00 00 00 ?? 00 00 00 00 ?? ?? 00 ?? 40 ?? 00 00 ?? ?? 00 00 00 00 00 ?? 00 00 00 00 00 00 00 00 00 00 00 ?? ?? ?? 00 ?? 00 00 00 00 00 ?? 00 ?? 00 00 00 00 00 00 00 ?? ?? ?? ?? ?? ?? 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 F8 00 00 00");
            print("[Debug] scanOffset: " + scanOffset.ToString("X8"));
            wramOffset = (long)scanOffset - 0x40;
            print("[Debug] WRAM Offset trouvé : " + wramOffset.ToString("X8"));
        } else if (state == "bgb") {
            IntPtr scanOffset = vars.SigScan(proc, 12, "6D 61 69 6E 6C 6F 6F 70 83 C4 F4 A1 ?? ?? ?? ??");
            print("[Debug] scanOffset: " + scanOffset.ToString("X8"));
            wramOffset = new DeepPointer(scanOffset, 0, 0, 0x34).Deref<int>(proc) + 0x108;
            wramOffset = (wramOffset + 0xFFFF) & 0xFFFF0000;
            print("[Debug] WRAM Offset trouvé : " + wramOffset.ToString("X8"));
        } else if (state == "bgb64") {
            IntPtr scanOffset = vars.SigScan(proc, 20, "48 83 EC 28 48 8B 05 ?? ?? ?? ?? 48 83 38 00 74 1A 48 8B 05 ?? ?? ?? ?? 48 8B 00 80 B8 ?? ?? ?? ?? 00 74 07");
            print("[Debug] scanOffset: " + scanOffset.ToString("X8"));
            IntPtr baseOffset = scanOffset + proc.ReadValue<int>(scanOffset) + 4;
            wramOffset = new DeepPointer(baseOffset, 0, 0x44).Deref<int>(proc) + 0x190;
            print("[Debug] WRAM Offset trouvé : " + wramOffset.ToString("X8"));
        }

        if (wramOffset != 0) {
            vars.watchers = vars.GetWatcherList((int)(wramOffset - baseAddress));
            print("[Autosplitter] WRAM Pointer: " + wramOffset.ToString("X8"));
            
            return true;
        }

        return false;
    });

    vars.SigScan = (Func<Process, int, string, IntPtr>)((proc, offset, signature) => {
        var target = new SigScanTarget(offset, signature);
        IntPtr result = IntPtr.Zero;
        foreach (var page in proc.MemoryPages(true)) {
            var scanner = new SignatureScanner(proc, page.BaseAddress, (int)page.RegionSize);
            if ((result = scanner.Scan(target)) != IntPtr.Zero) {
                break;
            }
        }

        return result;
    });

    vars.Current = (Func<string, int, bool>)((name, value) => {
        return vars.watchers[name].Current == value;
    });

    vars.previousBossHP = 0;
    vars.previousGold = 0;
    vars.GoldIncrease = false;

    vars.GetWatcherList = (Func<int, MemoryWatcherList>)((wramOffset) => {
        return new MemoryWatcherList {
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x0021)) { Name = "x_heros"},
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x0020)) { Name = "y_heros"},
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x00A6)) { Name = "x_camera"},
			new MemoryWatcher<ushort>(new DeepPointer(wramOffset +  0x13F4)) { Name = "boss_HP" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x03FE)) { Name = "id_room_1" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x0401)) { Name = "id_room_2" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x17D0)) { Name = "partner" },
            new MemoryWatcher<ushort>(new DeepPointer(wramOffset +  0x17BE)) { Name = "gold" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x1865)) { Name = "ketts sleep" },
			new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x17A2)) { Name = "start" },

            // Magic
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16AB)) { Name = "cure" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16AC)) { Name = "fire" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16AD)) { Name = "sleep" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16AE)) { Name = "heal" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16AF)) { Name = "ice" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16B0)) { Name = "mute" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16B1)) { Name = "lightning" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16B2)) { Name = "nuke" },

            // Item location
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16C5)) { Name = "item 1" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16C6)) { Name = "item 2" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16C7)) { Name = "item 3" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16C8)) { Name = "item 4" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16C9)) { Name = "item 5" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16CA)) { Name = "item 6" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16CB)) { Name = "item 7" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16CC)) { Name = "item 8" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16CD)) { Name = "item 9" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16CE)) { Name = "item 10" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16CF)) { Name = "item 11" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16D0)) { Name = "item 12" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16D1)) { Name = "item 13" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16D2)) { Name = "item 14" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16D3)) { Name = "item 15" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16D4)) { Name = "item 16" },

            // Equip location 1
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16B3)) { Name = "equip 1 1" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16B4)) { Name = "equip 1 2" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16B5)) { Name = "equip 1 3" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16B6)) { Name = "equip 1 4" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16B7)) { Name = "equip 1 5" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16B8)) { Name = "equip 1 6" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16B9)) { Name = "equip 1 7" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16BA)) { Name = "equip 1 8" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16BB)) { Name = "equip 1 9" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16BC)) { Name = "equip 1 10" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16BD)) { Name = "equip 1 11" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16BE)) { Name = "equip 1 12" },

            // Equip location 2
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16DD)) { Name = "equip 2 1" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16DE)) { Name = "equip 2 2" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16DF)) { Name = "equip 2 3" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16E0)) { Name = "equip 2 4" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16E1)) { Name = "equip 2 5" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16E2)) { Name = "equip 2 6" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16E3)) { Name = "equip 2 7" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16E4)) { Name = "equip 2 8" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16E5)) { Name = "equip 2 9" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16E6)) { Name = "equip 2 10" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16E7)) { Name = "equip 2 11" },
            new MemoryWatcher<byte>(new DeepPointer(wramOffset +  0x16E8)) { Name = "equip 2 12" },
        };
    });

    vars.GetSplitList = (Func<Dictionary<string, bool>>)(() => {
        return new Dictionary<string, bool> {
			// Boss
            { 
                "cat1", 
                (vars.watchers["boss_HP"].Current == 0xFFFF &&
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0x19 && 
                vars.watchers["id_room_2"].Current == 0x47) 
            },
            { 
                "hydra", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0xC4 && 
                vars.watchers["id_room_2"].Current == 0x77) 
            },
            { 
                "lee", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0xE2 && 
                vars.watchers["id_room_2"].Current == 0x41) 
            },
            { 
                "megapede", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0x29 && 
                vars.watchers["id_room_2"].Current == 0x05) 
            },
            { 
                "medusa", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0xBB && 
                vars.watchers["id_room_2"].Current == 0x30) 
            },
            { 
                "davias", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0x1B && 
                vars.watchers["id_room_2"].Current == 0x15) 
            },
            { 
                "metal crab", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0x7F && 
                vars.watchers["id_room_2"].Current == 0x37) 
            },
            { 
                "cyclops", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0x07 && 
                vars.watchers["id_room_2"].Current == 0x44) 
            },
            { 
                "golem", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0x3C && 
                vars.watchers["id_room_2"].Current == 0x01) 
            },
            { 
                "chimera", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0x4A && 
                vars.watchers["id_room_2"].Current == 0x54) 
            },
            // { 
            //     "dark lord", 
            //     (vars.watchers["boss_HP"].Current == 0x0000 && 
            //     vars.previousBossHP != 0x0000 && 
            //     vars.watchers["id_room_1"].Current == 0x3B && 
            //     vars.watchers["id_room_2"].Current == 0x14) 
            // },
            { 
                "kary", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0x08 && 
                vars.watchers["id_room_2"].Current == 0x43) 
            },
            { 
                "kraken", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0x5F && 
                vars.watchers["id_room_2"].Current == 0x17) 
            },
            { 
                "iflyte", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0x87 && 
                vars.watchers["id_room_2"].Current == 0x02) 
            },
            { 
                "lich", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0x5F && 
                vars.watchers["id_room_2"].Current == 0x34) 
            },
            { 
                "mantis", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0x32 && 
                vars.watchers["id_room_2"].Current == 0x60) 
            },
            { 
                "garuda", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0xFB && 
                vars.watchers["id_room_2"].Current == 0x34) 
            },
            { 
                "dragon", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0x04 && 
                vars.watchers["id_room_2"].Current == 0x00) 
            },
            // { 
            //     "red dragon", 
            //     (vars.watchers["boss_HP"].Current == 0xFFFF && 
            //     vars.previousBossHP != 0xFFFF && 
            //     vars.watchers["id_room_1"].Current == 0x04 && 
            //     vars.watchers["id_room_2"].Current == 0x00) 
            // },
            // { 
            //     "dragon z", 
            //     (vars.watchers["boss_HP"].Current == 0xFFFF && 
            //     vars.previousBossHP != 0xFFFF && 
            //     vars.watchers["id_room_1"].Current == 0x04 && 
            //     vars.watchers["id_room_2"].Current == 0x00) 
            // },
            // { 
            //     "julius 1", 
            //     (vars.watchers["boss_HP"].Current == 0xFFFF && 
            //     vars.previousBossHP != 0xFFFF && 
            //     vars.watchers["id_room_1"].Current == 0x8F && 
            //     vars.watchers["id_room_2"].Current == 0x67) 
            // },
            { 
                "julius 2", 
                (vars.watchers["boss_HP"].Current == 0xFFFF && 
                vars.previousBossHP != 0xFFFF && 
                vars.watchers["id_room_1"].Current == 0x8F && 
                vars.watchers["id_room_2"].Current == 0x67) 
            },

            // Events
            { 
                "ketts", 
                (vars.watchers["ketts sleep"].Current == 0x01 && 
                vars.watchers["id_room_1"].Current == 0xB0 && 
                vars.watchers["id_room_2"].Current == 0x30) 
            },
            { 
                "fuji glaive", 
                (vars.watchers["id_room_1"].Current == 0xF3 && 
                vars.watchers["id_room_2"].Current == 0x72) 
            },
            { 
                "chocobot", 
                (vars.previousid_room_1 == 0x6A && 
                vars.previousid_room_2 == 0x01 && 
                vars.watchers["id_room_1"].Current == 0xF8 && 
                vars.watchers["id_room_2"].Current == 0x26) 
            },
            { 
                "recover mana", 
                (
                vars.watchers["id_room_1"].Current == 0x36 &&
                vars.watchers["id_room_2"].Current == 0x50 &&
                vars.watchers["boss_HP"].Current > 0xF000 &&
                vars.GoldIncrease == true)
            },


            // Locations
            { 
                "marsh cave", 
                (vars.HasItemValue(0x1F) == true && 
                vars.watchers["id_room_1"].Current == 0xF0 && 
                vars.watchers["id_room_2"].Current == 0xE8) 
            },
            { 
                "ketts dungeon", 
                (vars.watchers["sleep"].Current == 0x01 &&
                vars.watchers["partner"].Current == 0x40 &&
                vars.watchers["id_room_1"].Current == 0x99 && 
                vars.watchers["id_room_2"].Current == 0xA9) 
            },
            { 
                "silver mine", 
                (vars.watchers["partner"].Current == 0x10 && 
                vars.watchers["id_room_1"].Current == 0x57 && 
                vars.watchers["id_room_2"].Current == 0x9B) 
            },
            { 
                "gaia", 
                (vars.previousid_room_1 == 0xBF && 
                vars.previousid_room_2 == 0x05 && 
                vars.watchers["id_room_1"].Current == 0x37 && 
                vars.watchers["id_room_2"].Current == 0x8D) 
            },
            { 
                "airship", 
                (vars.watchers["id_room_1"].Current == 0xF6 && 
                vars.watchers["id_room_2"].Current == 0x53) 
            },
            { 
                "medusa cave", 
                (vars.HasItemValue(0x22) == true &&
                vars.watchers["id_room_1"].Current == 0x5A && 
                vars.watchers["id_room_2"].Current == 0x2C) 
            },
            { 
                "davias mansion", 
                (vars.watchers["partner"].Current == 0x02 && 
                vars.watchers["id_room_1"].Current == 0x93 && 
                vars.watchers["id_room_2"].Current == 0x04) 
            },
            { 
                "mt rocks", 
                (vars.watchers["lightning"].Current == 0x01 &&
                vars.watchers["id_room_1"].Current == 0xCB && 
                vars.watchers["id_room_2"].Current == 0x26) 
            },
            { 
                "glaive castle", 
                (vars.watchers["id_room_1"].Current == 0x53 && 
                vars.watchers["id_room_2"].Current == 0xFF) 
            },
            { 
                "ice cavern", 
                (vars.HasEquipValue(0x28, 0x0C) == true &&
                vars.watchers["id_room_1"].Current == 0x7F && 
                vars.watchers["id_room_2"].Current == 0xD3) 
            },
            { 
                "floatrocks", 
                (vars.HasEquipValue(0x14, 0x0E) == true &&
                vars.watchers["id_room_1"].Current == 0x07 && 
                vars.watchers["id_room_2"].Current == 0xF0) 
            },
            { 
                "palmy desert", 
                (vars.watchers["nuke"].Current == 0x01 &&
                vars.watchers["id_room_1"].Current == 0xC3 && 
                vars.watchers["id_room_2"].Current == 0x3E) 
            },
            { 
                "dime tower", 
                (vars.watchers["nuke"].Current == 0x01 &&
                vars.watchers["id_room_1"].Current == 0x76 && 
                vars.watchers["id_room_2"].Current == 0x14 &&
                vars.watchers["x_heros"].Current == 0x68 &&
                vars.watchers["y_heros"].Current == 0x50 &&
                vars.watchers["x_camera"].Current == 0xC0)
            },
            { 
                "temple of mana", 
                (vars.watchers["id_room_1"].Current == 0xF3 && 
                vars.watchers["id_room_2"].Current == 0x75) 
            },
            { 
                "access final fight", 
                (vars.watchers["id_room_1"].Current == 0x36 && 
                vars.watchers["id_room_2"].Current == 0x50) 
            },


            // Magic
            { 
                "magic cure", 
                (vars.watchers["cure"].Current == 0x01) 
            },
            { 
                "magic fire", 
                (vars.watchers["fire"].Current == 0x01) 
            },
            { 
                "magic sleep", 
                (vars.watchers["sleep"].Current == 0x01) 
            },
            { 
                "magic heal", 
                (vars.watchers["heal"].Current == 0x01) 
            },
            { 
                "magic ice", 
                (vars.watchers["ice"].Current == 0x01) 
            },
            { 
                "magic mute", 
                (vars.watchers["mute"].Current == 0x01) 
            },
            { 
                "magic lit", 
                (vars.watchers["lightning"].Current == 0x01) 
            },
            { 
                "magic nuke", 
                (vars.watchers["nuke"].Current == 0x01) 
            },

            // Equipment
            { 
                "silver armor", 
                (vars.HasEquipValue(0x0A, 0x13) == true) 
            },
            { 
                "star", 
                (vars.HasEquipValue(0x1E, 0x08) == true) 
            },
            { 
                "ice sword", 
                (vars.HasEquipValue(0x28, 0x0C) == true) 
            },
            { 
                "rusty sword", 
                (vars.HasEquipValue(0x14, 0x0E) == true) 
            },
            { 
                "excalibur", 
                (vars.HasEquipValue(0x55, 0x10) == true) 
            },

            // Any%
            { 
                "axe shop", 
                (vars.previousid_room_1 == 0x10 && 
                vars.previousid_room_2 == 0xC7 && 
                vars.watchers["id_room_1"].Current == 0xBB && 
                vars.watchers["id_room_2"].Current == 0x00) 
            },
            { 
                "zip ish", 
                (vars.previousid_room_1 == 0x72 && 
                vars.previousid_room_2 == 0x76 && 
                vars.watchers["id_room_1"].Current == 0xC6 && 
                vars.watchers["id_room_2"].Current == 0x61)
            },
            { 
                "snowmanless glaive", 
                (vars.previousid_room_1 == 0xA5 && 
                vars.previousid_room_2 == 0x37 && 
                vars.watchers["id_room_1"].Current == 0xAB && 
                vars.watchers["id_room_2"].Current == 0x30)
            },
            { 
                "zip floatrocks", 
                (vars.watchers["id_room_1"].Current == 0xC6 && 
                vars.watchers["id_room_2"].Current == 0x31)
            },
        };
    });

    vars.HasItemValue = (Func<int, bool>)((value) => {
        for (int i = 1; i <= 16; i++) {
            string itemName = "item " + i;
            if (vars.watchers[itemName].Current == value) {
                return true;
            }
        }
        return false;
    });
    
    vars.HasEquipValue = (Func<int, int, bool>)((value1, value2) => {
        for (int i = 1; i <= 12; i++) {
            string equip1 = "equip 1 " + i;
            string equip2 = "equip 2 " + i;

            // Vérification si les valeurs de location 1 et 2 correspondent aux valeurs spécifiées
            if (vars.watchers[equip1].Current == value1 && vars.watchers[equip2].Current == value2) {
                return true;
            }
        }
        return false;
    });
}

init {
    vars.pastSplits = new HashSet<string>();

    if (!vars.TryFindOffsets(game, (long)modules.First().BaseAddress)) {
        throw new Exception("[Autosplitter] Emulated memory not yet initialized.");
    } else {
        refreshRate = 200/3.0;
    }
}

update {
    int currentBossHP = vars.watchers["boss_HP"].Current;
    int currentGold = vars.watchers["gold"].Current;
    int currentid_room_1 = vars.watchers["id_room_1"].Current;
    int currentid_room_2 = vars.watchers["id_room_2"].Current;
    bool HasGoldIncrease = false;
    // Vérifier si l'or a augmenté par rapport à la valeur précédente
    if (vars.previousGold < currentGold) {
        HasGoldIncrease = true;
        vars.GoldIncrease = HasGoldIncrease;
    } else {
        HasGoldIncrease = false;
        vars.GoldIncrease = HasGoldIncrease;
    }
    vars.watchers.UpdateAll(game);
    vars.previousBossHP = currentBossHP;
    vars.previousGold = currentGold;
    vars.previousid_room_1 = currentid_room_1;
    vars.previousid_room_2 = currentid_room_2;

    // Ajouter un print pour vérifier la valeur de "start" et "boss_HP" à chaque mise à jour
    // byte cat1Value = vars.watchers["boss_HP"].Current;
    
    // print("[Debug] Valeur brute lue pour boss_HP : " + vars.watchers["boss_HP"].Current.ToString("X2"));
    // if (vars.watchers["boss_HP"] == null) {
    //     print("[Erreur] Le watcher boss_HP n'a pas été correctement initialisé !");
    //  }
}

start {
    return vars.watchers["start"].Current != 0x00 && vars.watchers["start"].Current != 0xFF;
}

split {
    var splits = vars.GetSplitList();
    var toSplit = new List<string>();
    foreach (var split in splits) {
        if (settings[split.Key] && split.Value && !vars.pastSplits.Contains(split.Key)) {
            print("[Debug] Split déclenché pour: " + split.Key);  // Affiche le split qui va être effectué
            vars.pastSplits.Add(split.Key);
            print("[Debug] Ajout du split à pastSplits : " + split.Key);  // Vérifie que le split est ajouté
            toSplit.Add(split.Key);
            return true;
        }
    }
}

onReset {
    vars.pastSplits.Clear();
}

exit {
    refreshRate = 0.5;
}
