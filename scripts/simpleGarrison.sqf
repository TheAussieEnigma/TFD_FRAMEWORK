//usage: in trigger activation field -->  _nul = [thisTrigger, 0.25] execVM "johnnyGarrison.sqf"; for a 25% chance to spawn a dude at a building position 


_trigger = _this select 0;
_probability = _this select 1;
_triggerData = triggerArea _trigger;
_triggerAxis = _triggerData select 0;
////////////////////////////////////////
//Faction Setup
_enemySide = east;
_enemyUnits = ["O_Soldier_F"];
////////////////////////////////////////

//Find all building of particular type(s); put different class types in the array
_houses = nearestObjects [_trigger,["House"], _triggerAxis];
systemChat format ["HOUSES FOUND: %1", str _houses];
sleep 3;
{
	//collect buidling posiitons
	_buildingPositions = _x buildingPos -1;
	if (count _buildingPositions > 0) then {
		_grp = creategroup _enemySide;
		{
			_roll = random 1;
			if (_roll < _probability) then {
				//Create an enemy unit at the building position
				_unt = _enemyUnits call BIS_fnc_selectRandom;
				_gar = _grp createUnit [_unt, [0,0,0], [], 0, "NONE"];
				_gar disableAI "PATH";
				_gar setPos _x;
				systemChat format ["Unit created at: %1", str _x];
			};
		} forEach _buildingPositions;
	};
} forEach _houses;
//////


