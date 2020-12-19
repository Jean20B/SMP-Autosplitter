//Super Mario: Mushroom Chaos - Any%

state("smmc") {
	string255 levelstate: 0x2801E; //String of the loaded stage or menu
	ushort camX: 0x27828; //Camera position (horizontal)
	ushort camY: 0x2782A; //Camera position (vertical)
	byte freezemario: 0x2787C; //Byte that prevents Mario to move, used after completing a stage (0 means he can't move, and 255 means he can move)
}

startup {
	refreshRate = 60;

	settings.Add("level1", true, "Green Plains");
	settings.Add("level2", true, "Green Plains - Boss");
	settings.Add("level3", true, "Desert Panic");
	settings.Add("level4", true, "Ice Mountain");
	settings.Add("level5", true, "Late Night At The Kingdom");
	settings.Add("level6", true, "Bowser's Castle");
	
	vars.ls2check = false;
	vars.ls3check = false;
	vars.ls4check = false;
	vars.ls5check = false;
	vars.ls6check = false;
	vars.ls2done = false;
	vars.ls3done = false;
	vars.ls4done = false;
	vars.ls5done = false;
	vars.ls6done = false;
}

update {
	//Boolean for the starting position of the camera
	vars.camstart = ((old.camX == 0) && (old.camY == 0) && (current.camX == 0) && (current.camY == 800));
	
	//Timer starts after pressing "Start Game" on the title screen
	if (old.levelstate == "Title Screen" && current.levelstate == "Level Introduction") {
		vars.ls1 = true;
	}
	else vars.ls1 = false;
	
	//Booleans using levelstate and camstart, to check if a new stage is loaded
	
	//Stage 2 is the boss fight
	if (old.levelstate == "Stage 1" && current.levelstate == "Stage 2") {
		vars.ls2check = true;
	}
	
	if (old.levelstate == "Level Introduction" && current.levelstate == "Stage 3") {
		vars.ls3check = true;
	}
	
	if (old.levelstate == "Level Introduction" && current.levelstate == "Stage 4") {
		vars.ls4check = true;
	}

	if (old.levelstate == "Level Introduction" && current.levelstate == "Stage 5") {
		vars.ls5check = true;
	}
	
	if (old.levelstate == "Level Introduction" && current.levelstate == "Stage 6") {
		vars.ls6check = true;
	}

	
	//lsXdone prevents to split again after it's done
	
	//Stage 1 Boss (aka "Stage 2") doesn't use the camera position, so no vars.camstart here
	if (vars.ls2check && !vars.ls2done) {
		vars.ls2 = true;
		vars.ls2done = true;
	}
	else vars.ls2 = false;
	
	if (vars.ls3check && vars.camstart && !vars.ls3done) {
		vars.ls3 = true;
		vars.ls3done = true;
	}
	else vars.ls3 = false;
	
	if (vars.ls4check && vars.camstart && !vars.ls4done) {
		vars.ls4 = true;
		vars.ls4done = true;
	}
	else vars.ls4 = false;
	
	if (vars.ls5check && vars.camstart && !vars.ls5done) {
		vars.ls5 = true;
		vars.ls5done = true;
	}
	else vars.ls5 = false;
	
	if (vars.ls6check && vars.camstart && !vars.ls6done) {
		vars.ls6 = true;
		vars.ls6done = true;
	}
	else vars.ls6 = false;
	
	vars.end = ((current.levelstate == "Stage 6" && current.freezemario == 0) && current.camX > 6600);
}

start {
	return vars.ls1;
}

split {
	return vars.ls2 || vars.ls3 || vars.ls4 || vars.ls5 || vars.ls6 || vars.end;
}

reset {
	return (current.levelstate == "Nightchaser Games");
}
