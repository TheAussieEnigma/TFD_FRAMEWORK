/*
 * Author: Jam Toast 
 * Modified: 15/10/2016
 *
 * Enemy intel markers for Dark Business.
 *
 * Arguments:
 * 0: array of players to check <ARRAY>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [ ] call TFD_fnc_intelMarkers;
 *
 */

private _array param [ 0 , allPlayers , [ [] ] ];

{
	waitUntil { (getClientStateNumber > 9) };

	if ( side _x == EAST || side _x == GUER && leader group _x ) then {

	private _markerName = "small_" + str _x;

	private _marker = createMarker [ _markerName , position _x ];
	_marker setMarkerShape "ICON";
	_marker setMarkerColor "ColorRed";
	_marker setMarkerSize [ 0.2 , 0.2 ];
	_marker setMarkerType "mil_dot";

		while ( alive player ) do {

		_marker setMarkerPos position _x;
		private _t = random [ 300 , 450 , 600 ];
		sleep _t;

		}; 

		waitUntil { !alive _x };

		deleteMarker _marker;

		[ units group player ] spawn TFD_fnc_intelMarkers;

		exitWith { true };

	};

} forEach _array;