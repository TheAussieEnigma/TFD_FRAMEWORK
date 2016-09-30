_num = _this select 0;
_objArray = _this select 1; 
_posArray = _this select 2;
_chanceIed = _this select 3;
_return = [];

while {_num > 0} do {
	_pos = _posArray call BIS_fnc_selectRandom;
	_obj = _objArray call BIS_fnc_selectRandom;
		
	//Add some more RNG to the position
	_posFinal = [_pos, 0, 10, 3, 1, 2, 0] call BIS_fnc_findSafePos;

	//Create the object
	_ied = _obj createVehicle _posFinal;
	_ied setDir (random 360);

	if ((random 1) <= _chanceIed) then {
		//Decrement the number of IED's by one becaue we have placed one
		_num = _num - 1;
		//Setup the attached variable(s)
		_ied setVariable ["ied_ready", true, true];
		_ied setVariable ["ied_armed", false, true];
		//If the ied is an ammobox setup a boobytrap
		if (_ied isKindOf "ReammoBox_F") then {
			_ied addEventHandler ["ContainerOpened",{
				_ied = _this select 0;

				_ied setVariable ["ied_armed", true, true];
				_ied setVariable ["ied_ready", false, true];
			}];
		};
		//Add ied to return variable
		_return pushBackUnique _ied;

	} else {
		//If the object is not chosen as an IED then disable its simulation
		_ied enableSimulationGlobal false;
	};
};

_return

