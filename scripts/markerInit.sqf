//Marker Setup
["marker_1", z1] call BIS_fnc_markerToTrigger;
["marker_2", z2] call BIS_fnc_markerToTrigger;
["marker_3", z3] call BIS_fnc_markerToTrigger;

{
	_x setMarkerBrush "DIAGGRID";
	_x setMarkerAlpha 0.5;
} forEach ["marker_1", "marker_2", "marker_3"];

//Trigger setup
_trg1 = [objNull, "marker_1"] call BIS_fnc_triggerToMarker;
_trg2 = [objNull, "marker_2"] call BIS_fnc_triggerToMarker;
_trg3 = [objNull, "marker_3"] call BIS_fnc_triggerToMarker;

//Zone indicator Trigger
//_trg1 setTriggerStatements ["this", "'marker_1' setMarkerColor 'ColorRed'; ZONE_1 = false;", "'marker_1' setMarkerColor 'ColorBlue'; ZONE_1 = true;"];
//_trg2 setTriggerStatements ["this", "'marker_2' setMarkerColor 'ColorRed'; ZONE_2 = false;", "'marker_2' setMarkerColor 'ColorBlue'; ZONE_2 = true;"];
//_trg3 setTriggerStatements ["this", "'marker_3' setMarkerColor 'ColorRed'; ZONE_3 = false;", "'marker_3' setMarkerColor 'ColorBlue'; ZONE_3 = true;"];

{
	_x setTriggerActivation ["GUER", "PRESENT", true];

	_i = _forEachIndex + 1;
	_actString = format ["'marker_%1' setMarkerColor 'ColorRed'; ZONE_%1 = false; systemChat 'Enemy Detected in Zone %1'", _i];
	_deactString = format ["'marker_%1' setMarkerColor 'ColorBlue'; ZONE_%1 = true; systemChat 'Zone %1 is clear'; hint 'Zone %1 is clear';", _i];

	_x setTriggerStatements ["this", _actString, _deactString];
} forEach [_trg1,_trg2,_trg3];

//Mission End Trigger
_endTrigger = createTrigger["EmptyDetector", [0,0,0]];
_endTrigger setTriggerActivation ["LOGIC", "PRESENT", false];
_endTrigger setTriggerStatements ["(time > 60) && (ZONE_1 && ZONE_2 && ZONE_3)", "'Won' remoteExecCall ['BIS_fnc_endMissionServer', 2]", ""];