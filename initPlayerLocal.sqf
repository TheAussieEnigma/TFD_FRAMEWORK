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
// if you intend to use this you need an object which is called MedTentBase at base 
if (BodyBagRespawn call BIS_fnc_getParamValue == 1) && !(isNull MedTentBase) then{
	_loadout = getUnitLoadout player;
	_delay = 3 // seconds
	["ace_placedInBodyBag", {
    params ["_unit", "_BodyBag"];
    if (_unit != player) exitWith {};
	[{_this call CBA_fnc_getDistance < 10;} //condition
	,{player setPlayerRespawnTime 1;  //statement / code
	//waits _delay seconds then set loadout to same as Mission start
	[{
       player setUnitLoadout _loadout;
    }, [], _delay] call CBA_fnc_waitAndExecute;
	}, [_BodyBag,MedTentBase]] call CBA_fnc_waitUntilAndExecute;
	}] call CBA_fnc_addEventHandler;
};




