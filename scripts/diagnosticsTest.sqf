//Diagnostics
params [
	["_interval", 60, [123]]
];

"debug_console" callExtension (format ["Mission Name - %1", missionName] + "~0001");
"debug_console" callExtension ("CSV Format - Time,ServerFPS,hcFPS(0 if not present),# players, # AI, # spawn scripts, # execVM'd, #exec'd, # fsm" + "~0001");

waitUntil {time > _interval};

while {getClientStateNumber == 10} do {

	if (HCPresent) then {
		[[],{HC_FRAMES = (floor diag_fps); publicVariable "HC_FRAMES";}] remoteExec ["spawn", TFD_HC];
	};

	[] call {
		_arr = [];
		
		//Get Time
		_upTime =_arr pushBack (floor time);
		
		//Get ServerFrames
		_sFPS = _arr pushBack (floor diag_fps);
				
		//Get HC Frames
		_hcFPS = 0;
		if (HCPresent) then {
			_hcFPS = HC_FRAMES;	
		};
		_arr pushBack _hcFPS;

		//Get Player Number
		_noPlayers = _arr pushBack (count (allPlayers - entities "HeadlessClient_F"));
		
		//Get Active AI number
		_noAI = _arr pushBack  ({!isPlayer _x} count allUnits);

		//Get Active Scripts - spawn
		_spawnScripts = _arr pushBack (diag_activeScripts select 0);
		
		//Get Active Scripts - execVM
		_execVMScripts = _arr pushBack (diag_activeScripts select 1);
		
		//Get Active Scripts - exec
		_execScripts = _arr pushBack (diag_activeScripts select 2);
		
		//Get Active Scripts - fsm
		_FSMScripts = _arr pushBack (diag_activeScripts select 3);
		
		//Format into csv type syntax
		_str = format ["%1,%2,%3,%4,%5,%6,%7,%8,%9", 
			(_arr select 0),
			(_arr select 1),
			(_arr select 2),
			(_arr select 3),
			(_arr select 4),
			(_arr select 5),
			(_arr select 6),
			(_arr select 7),
			(_arr select 8)
		];

		//Write to File
		"debug_console" callExtension (_str + "~0000");
	};
	uiSleep _interval;
};
//Close console window after mission is over
"debug_console" callExtension ("X");