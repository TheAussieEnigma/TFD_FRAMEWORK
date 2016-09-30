//ST Test

//ST Test 2
execVM "scripts\markerInit.sqf";
////////////////////////////////////////////////// DO NOT EDIT BELOW THIS LINE //////////////////////////////////////////////////
// Get mission parameter to see if HeadlessClient is present and assign its name
if ("HeadlessClient" call BIS_fnc_getParamValue == 1) then {
	
	if (isServer) then {
		HCPresent = true;
		publicVariable "HCPresent";
	};
	
	if (!hasInterface && !isServer) then {
		HCName = name player; 
		publicVariable "HCName";
	};

	} else {
	
	if (isServer) then {
		HCPresent = false;
		HCName = "NOONE";
		publicVariable "HCPresent";
		publicVariable "HCName";
	};
};

// Execute DAC on HC if present, otherwise on Server
if (HCPresent) then {

	if (!hasInterface && !isServer) then {
		waitUntil{time > 1};
		
		systemChat "Trying to Launch ConfigCreator";
		DAC_HANDLE = [] spawn (compile preprocessFileLineNumbers "dac\dac_config_creator.sqf"); sleep 1;
		
		
		systemChat "Launching InitZones";
		DAC_HANDLE = [] spawn (compile preprocessFileLineNumbers "dac\initZones.sqf");
		waitUntil {scriptDone DAC_HANDLE};
		
		"DAC initialised on headless client" remoteExec ["systemChat", 0];
	};
} else {
	if (isServer) then {
		waitUntil{time > 1};
		
		systemChat "Trying to Launch ConfigCreator";
		DAC_HANDLE = [] spawn (compile preprocessFileLineNumbers "dac\dac_config_creator.sqf"); sleep 1;
		
		systemChat "Launching InitZones";
		DAC_HANDLE = [] spawn (compile preprocessFileLineNumbers "dac\initZones.sqf");
		waitUntil {scriptDone DAC_HANDLE};

		"DAC initialised on server" remoteExec ["systemChat", 0];
	};
};

////////////////////////////////////////////////// DO NOT EDIT ABOVE THIS LINE //////////////////////////////////////////////////
