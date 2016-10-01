#include "missionSettings.hpp"

//Close the spectator if the player respawned during the mission
["Terminate"] call BIS_fnc_EGSpectator;

//Weapon Saftey switch
if !(startMission) then {

	[ "SAFE" ] call TFD_fnc_weaponSafety;
	
	nul = [] execVM "scripts\briefingInProgress.sqf";
	
};

//Execute Player Setup sqf
_handle = [] execVM "scripts\playerSetup.sqf";
waitUntil { scriptDone _handle };

//Assign player to group
[ TFD_ORBAT ] call TFD_fnc_assignGroup;

//Roster
[ TFD_ORBAT ] call TFD_fnc_unitRoster;

//Kit out the player
if (scriptedPlayerKit) then {
	_nul = [] execVM "scripts\playerKit.sqf";
};