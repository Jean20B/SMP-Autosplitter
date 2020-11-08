//Super Mario Pandemonium - Any%

state("smp") {
	string255 levelstate: 0x2801E; //String of the loaded stage or menu
	ushort camX: 0x27828; //Camera position (horizontal)
	ushort camY: 0x2782A; //Camera position (vertical)
}

startup {
	refreshRate = 60;

	settings.Add("level1", true, "Mushroom Kingdom");
	settings.Add("level2", true, "Forbidden Passageway");
	settings.Add("level3", true, "Ice Mountain Madness");
	settings.Add("level4", true, "Midnight Chaos");
	settings.Add("level5", true, "Bowser's Clone Factory");
	
	vars.ls1check = false;
	vars.ls2check = false;
	vars.ls3check = false;
	vars.ls4check = false;
	vars.ls5check = false;
	vars.ls2done = false;
	vars.ls3done = false;
	vars.ls4done = false;
	vars.ls5done = false;
}

update {
	//Boolean for the starting position of the camera
	vars.camstart = ((current.camX == 0) && (current.camY == 800));
	
	//Booleans using levelstate and camstart, to check if a new stage is loaded
	
	//Stage 1 Intro is named "Stage 2 Intro" for some reason
	if (old.levelstate == "Stage 2 Intro" && current.levelstate == "Stage 1") {
		vars.ls1check = true;
	}
	
	if (old.levelstate == "Forbidden Passageway Intro" && current.levelstate == "Stage 2") {
		vars.ls2check = true;
	}
	
	if (old.levelstate == "Level 3 Intro" && current.levelstate == "Level 3") {
		vars.ls3check = true;
	}
	
	if (old.levelstate == "Level 4 Intro" && current.levelstate == "Level 4") {
		vars.ls4check = true;
	}
	
	//Level 5 is "Untitled"
	if (old.levelstate == "Level 5 Intro" && current.levelstate == "Untitled") {
		vars.ls5check = true;
	}
	
	vars.ls1 = (vars.ls1check && vars.camstart);
	vars.ls2 = (vars.ls2check && vars.camstart);
	vars.ls3 = (vars.ls3check && vars.camstart);
	vars.ls4 = (vars.ls4check && vars.camstart);
	vars.ls5 = (vars.ls5check && vars.camstart);
	
	vars.end = (old.levelstate == "Untitled" && current.levelstate == "Ending");
	
	//Prevent to split again once it's done
	if (vars.ls2done) {vars.ls2 = false;}
	if (vars.ls2) {vars.ls2done = true;}
	
	if (vars.ls3done) {vars.ls3 = false;}
	if (vars.ls3) {vars.ls3done = true;}
	
	if (vars.ls4done) {vars.ls4 = false;}
	if (vars.ls4) {vars.ls4done = true;}
	
	if (vars.ls5done) {vars.ls5 = false;}
	if (vars.ls5) {vars.ls5done = true;}
}

start {
	return vars.ls1;
}

split {
	return vars.ls2 || vars.ls3 || vars.ls4 || vars.ls5 || vars.end;
}

reset {
	return (current.levelstate == "Title Screen");
}
