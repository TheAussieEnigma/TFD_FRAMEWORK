/*
 * Author: JohnnyShootos
 * Modified: 19/09/2016
 *
 * Sets group names based on the TFD_ORBAT array.
 *
 * Arguments:
 * 	0: The variable containing the orbat for the mission <ARRAY>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [myVar] spawn TFD_fnc_assignGroup;
 *
 * Public: No
 *
 */


private _TFD_ORBAT = param [0, [], [[]]];

{
	_n = str _x;
	_p = _x;
	
	{
		
		if (_n in _x) then {
		
			(group _p) setGroupIdGlobal [(_x select 0)];
		};

	} forEach _TFD_ORBAT;

} forEach playableUnits;