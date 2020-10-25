//Super Mario Pandemonium - Any%
//You can uncheck levels in Livesplit layout settings but it's not really useful

state("smp") {
	string255 levelstate: 0x2801E; //String of the loaded stage or menu
	byte endbyte: 0x2787C; //A byte that changes when you hit an interrogation block to end a level (Hit = 0 (00),  Not hit = 255 (FF))
}

startup {
	refreshRate = 60;

	settings.Add("level1", true, "Mushroom Kingdom");
	settings.Add("level2", true, "Forbidden Passageway");
	settings.Add("level3", true, "Ice Mountain Madness");
	settings.Add("level4", true, "Midnight Chaos");
	settings.Add("level5", true, "Bowser's Clone Factory");
}

update {
	//Booleans for levelstate, to check if a new stage is loaded
	
	//Stage 1 Intro is named "Stage 2 Intro" for some reason
	vars.ls1 = (old.levelstate == "Stage 2 Intro" && current.levelstate == "Stage 1");
	
	vars.ls2 = (old.levelstate == "Forbidden Passageway Intro" && current.levelstate == "Stage 2");
	
	vars.ls3 = (old.levelstate == "Level 3 Intro" && current.levelstate == "Level 3");
	
	vars.ls4 = (old.levelstate == "Level 4 Intro" && current.levelstate == "Level 4");
	
	//Level 5 is "Untitled"
	vars.ls5 = (old.levelstate == "Level 5 Intro" && current.levelstate == "Untitled");
	
	vars.end = (current.levelstate == "Untitled" && old.endbyte == 255 && current.endbyte == 0);
}

start {
	if (settings["level1"]) {
		return vars.ls1;
	}
	else if (settings["level2"]) {
		return vars.ls2;
	}
	else if (settings["level3"]) {
		return vars.ls3;
	}
	else if (settings["level4"]) {
		return vars.ls4;
	}
	else if (settings["level5"]) {
		return vars.ls5;
	}
}

split {
	return (settings["level1"] && vars.ls2)
		|| (settings["level2"] && vars.ls3)
		|| (settings["level3"] && vars.ls4)
		|| (settings["level4"] && vars.ls5)
		|| (settings["level5"] && vars.end);
}

reset {
	return (current.levelstate == "Title Screen");
}
