#include "ied.hpp"

_obj = _this select 0;
_rnd = _this select 1;
_ppe = _this select 2;
_target = objNull;
_obj setVariable ["current_targets", [], true];
_obj setVariable ["ied_armed", true, true];

//Add defuse action
[ 
	_obj, 
	"Defuse IED",ICONPATH("interact"),ICONPATH("repair"), 
	"(_this distance _target <= 2)", 
	"_caller distance _target <= 2", 
	{}, 
	{
		_obj = _this select 0;
		_rnd = _this select 3 select 0;

		if (random 1 <= _rnd) then {
			_obj setVariable ["ied_ready", false, true];
		};
	}, 
	{
		_obj = _this select 0;
		_obj setVariable ["ied_armed", false, true];
		sleep 1;
		_obj setVariable ["ied_ready", false, true];
		systemChat "IED Defused Successfully"
	}, 
	{}, 
	[_rnd], 
	24, 
	999, 
	false 
] remoteExec ["bis_fnc_holdActionAdd", 0];

//Start Detection logic
while {_obj getVariable "ied_ready"} do {
	sleep 1;
	_target = nearestObjects[_obj,["Man"],10];
	
	{if !(isPlayer _x) then {_target = _target - [_x]}} forEach _target;

	if (count _target > 0) then {
		
		{
			_currentTargets = (_obj getVariable "current_targets");
			
			if !(_x in _currentTargets) then {
				[[_obj],{_this execFSM "ied\triggerLogic.fsm"}] remoteExec ["spawn", _x];
			};

			_currentTargets pushBackUnique _x;

			_obj setVariable ["current_targets", _currentTargets, true];

		} forEach _target;
	};
	sleep 1;
};

//Start Detonation - if still armed
if (_obj getVariable "ied_armed") then {
	_chargeType = CHARGETYPE;
	_bomb = _chargeType createVehicle (position _obj);
	deleteVehicle _obj;
	_bomb setDamage 1;
	if (_ppe) then {
		[_bomb] call TFD_fnc_IED_PPeffect; //TODO - create the post process effects function.
	};
};