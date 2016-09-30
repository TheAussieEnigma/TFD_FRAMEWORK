/*
 * Author: JohnnyShootos
 * Modified: 16/08/2016
 *
 * Sets group names based on the TFD_ORBAT array.
 *
 * Arguments:
 * 	NONE
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] spawn TFD_fnc_assignGroup;
 *
 * Public: No
 *
 */

_p = str player;
{
		
	if (_p in _x) then {
		(group player) setGroupIdGlobal [(_x select 0)];
	};

} forEach TFD_ORBAT;

