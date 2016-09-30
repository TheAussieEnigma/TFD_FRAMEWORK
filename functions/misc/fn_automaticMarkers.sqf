/*
 * Author: Jam Toast 
 * Modified: 07/09/2016
 *
 * Automatically handles the dynamicMarkers function using a naming convention.
 *
 * Arguments:
 * 0: Zoom level <NUMBER>
 * 1: fade speed <NUMBER>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * Place large markers on the map named as "large_1" , "large_2" , etc
 * Place small markers on the map named as "small_1" , "small_2" , etc
 * [ 0.15 , 0.05 ] call TFD_fnc_automaticMarkers;
 *
 * Public: No
 *
 */
 
 _zoom = _this select 0;
 _speed = _this select 1;
 
_smallArray = [];
_largeArray = [];

{

	if ((_x find "small") > -1) then {
		_smallArray pushBackUnique _x
	};
	
	if ((_x find "large") > -1) then {
		_largeArray pushBackUnique _x
	};
	
} forEach allMapMarkers;

// Spawn function
[ _largeArray , _smallArray , _speed , 0 , _zoom ] spawn TFD_fnc_dynamicMarkers;