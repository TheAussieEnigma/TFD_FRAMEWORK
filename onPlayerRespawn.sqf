#include "missionSettings.hpp"

//Kit out the player
if (scriptedPlayerKit) then {
	_nul = [] execVM "scripts\playerKit.sqf";
};

//Weapon Saftey switch
if !(startMission) then {
	["SAFE", true] call TFD_fnc_weaponSafety;
};

//Close the spectator if the player respawned during the mission
["Terminate"] call BIS_fnc_EGSpectator;

//Execute Player Setup sqf
_handle = [] execVM "scripts\playerSetup.sqf";
waitUntil { scriptDone _handle };

//Assign player to group
[] call TFD_fnc_assignGroup;

//Roster
[] call TFD_fnc_unitRoster;



