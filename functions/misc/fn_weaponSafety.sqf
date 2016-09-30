/*
* Author: JohnnyShootos
* Modified: 4/09/2016
*
* Removes projectiles of fired weapons 
*
* Arguments:
* 0: State of weapons ("SAFE","FIRE") default = "SAFE" <STRING>
* 1: Condition Variable to switch on (default = true)  <BOOL>
* 
* Return Value:
* Nil
*
* Example:
* ["SAFE", myVar] call TFD_fnc_weaponSafety
*
* Public: No
*
*/


_case = param [0, "SAFE", ["FIRE"]];

_case = toUpper(_case);
switch (_case) do {

	case "SAFE": {
		TFD_WEAPONS_HOLD = player addEventHandler ["Fired", {
			deleteVehicle (_this select 6);
		}];
	};

	case "FIRE": {
		player removeEventHandler ["Fired", TFD_WEAPONS_HOLD];
	};
};