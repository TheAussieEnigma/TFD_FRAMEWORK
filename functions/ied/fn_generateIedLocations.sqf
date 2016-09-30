//THIS SCRIPT WILL TAKE A LONG TIME TO FINISH - BE PATIENT IF YOU DO NOT IMMEDIATELY SEE RESULTS
_trigger = _this select 0;
_center = position _trigger;
_radius = (triggerArea _trigger) select 0;
_number = 50;

//Delete the trigger because we no longer need it
//deleteVehicle _trigger;

//Setup output arrays
_smallLocs 	= [];
_largeLocs 	= [];
_carLocs 	= [];

//Generate ied locations
{
	for "i" from 1 to _number do {
		_pos = [_center, 0, _radius, 3, 1, 2, 0] call BIS_fnc_findSafePos;
		_x pushBackUnique _pos;
	};
} forEach [_smallLocs,_largeLocs,_carLocs];

//combine output arrays
_return = [_smallLocs,_largeLocs,_carLocs];

//return the output
_return