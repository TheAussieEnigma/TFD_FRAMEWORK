#include "missionSettings.hpp"
[ TFD_ORBAT ] call TFD_fnc_assignGroup;

// Saving disabled without autosave.
enableSaving [false,false];

//Disable AI radio calls
enableSentences false;

// Briefing
nul = [] execVM "scripts\briefing.sqf";

//[ 0.1 , 0.05 ] call TFD_fnc_automaticMarkers;

//[ 0.75 , 0.75 ] call TFD_fnc_customUnitTraits;

//Hacky way of handling setting TFAR radio channels in empty vehicles for now
player addEventHandler ["GetInMan", { 
	{ 
		_setString = _x + "_radio_settings"; 
		(_this select 2) setVariable [_setString, tf_freq_west_lr, true];
	} forEach ["driver","commander","gunner"]; 
}];
if (BodyBagRespawn call BIS_fnc_getParamValue == 1) then{
	_loadout = getUnitLoadout player;
	["ace_placedInBodyBag", {
    params ["_unit", "_BodyBag"];
    if (_unit != player) exitWith {};
	[{[_this select 0,_this select 1] call CBA_fnc_getDistance < 10;},{(_this select 3) setPlayerRespawnTime 1;}, [_BodyBag,MedTentBase,player]] call CBA_fnc_waitUntilAndExecute;
	[{
       player setUnitLoadout _loadout;
    }, [], 3] call CBA_fnc_waitAndExecute;
	}] call CBA_fnc_addEventHandler;
};




