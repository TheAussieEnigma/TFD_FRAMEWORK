/*
 * Author: Jam Toast
 * Modified: 04/09/2016
 *
 * Creates a paradrop scenario using only markers on the map.
 *
 * Arguments:
 * 0: Vehicle type <STRING>
 * 1: Marker to spawn aircraft at <STRING>
 * 2: Height to spawn aircraft at (also flyInHeight value) <NUMBER>
 * 3: Direction to face on spawn <NUMBER>
 * 4: Marker to eject units at <STRING>
 * 5: Radius from marker to drop within <NUMBER>
 * 6: List of units to be moved into aircraft <ARRAY>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [ "RHS_C130J" , "flightMarker_1" , 1800 , 140 , "dropMarker_1" , 200 , [ s1 , s3 , s4 , s5  ] ] spawn TFD_fnc_paradrop;
 *
 * Public: No
 *
 */

_vehType = _this select 0; 

_spawnMarker = _this select 1;
_spawnHeight = _this select 2;
_spawnDir = _this select 3;

_dropMarker = _this select 4;
_dropRadius = _this select 5;
_unitArray = _this select 6;

// create aircraft

_spawn = [ 
	[ getMarkerPos _spawnMarker select 0, getMarkerPos _spawnMarker select 1, (getMarkerPos _spawnMarker select 2) + _spawnHeight ] , 
	_spawnDir ,
	_vehType ,
	WEST
] call BIS_fnc_spawnVehicle;

_veh = _spawn select 0;
_crew = _spawn select 1;
_group = _spawn select 2;

_veh flyInHeight _spawnHeight;

// set vehicle properties

_veh allowDamage false;
[ _veh ] call TFD_fnc_emptyVehicle;

// move player units in

cutText ["", "BLACK OUT", 5];

5 fadeSound 0;

sleep 5;

5 fadeSound 1;

titleCut ["", "BLACK IN", 5];

{ _x moveInCargo _veh; } forEach _unitArray;

_veh lockDriver  true;

// create waypoints

_waypoint1 = _group addWaypoint [ getMarkerPos _dropMarker , _dropRadius , 1];
_waypoint1 setWaypointSpeed "LIMITED";
_waypoint1 setWaypointStatements ["true", ""];

// wait until arrive

waitUntil { _veh distance2D ( getMarkerPos _dropMarker ) < _dropRadius };

_veh say3D [ "Alarm_BLUFOR" , 50 ];

sleep 3;

// eject units (staggered)

_crewArray = crew _veh;

_crewArray = _crewArray - _crew;

_cargoAmount = (count _crewArray) -1;

_offset = 0;
_angle = 180;

for "_i" from 0 to _cargoAmount do {
	_ejected = _crewArray select _i;
	moveOut _ejected;
	
	//[ _ejected , _ejected , [ "Chemlight_blue" ] ] call ace_attach_fnc_attach; // give this input from the spawn array to be either disabled and the item changed
	
	_dropPos = _veh getRelPos [ _offset , _angle ];
	_dropPos set [ 2 , ( getPos _veh select 2 ) ];
	
	_ejected setPos _dropPos;
	
	if ( _angle <= 180 ) then { _angle = (_angle ) + 5 } else { _angle = (_angle) - 10 };
	
	if ( _offset > 2 ) then { _offset = ( _offset ) - 2 } else { _offset = ( _offset ) + 2 };
	
	sleep 0.15;
};

waitUntil { _veh distance2D ( getMarkerPos _dropMarker ) < 20000 };

{ deleteVehicle _x } forEach _crew + [ _veh ];