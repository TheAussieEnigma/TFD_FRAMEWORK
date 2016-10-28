private _farpVehicle = _this select 3 select 0;
private _deployedObjs = _this select 3 select 1;
private _UNDEPLOY_TIME = _this select 3 select 2;
private _DEPLOYABLE_NAME = _this select 3 select 3;
private _FACTION = _this select 3 select 4;
private _REARM_POINT = _this select 3 select 5;
private _REARM_TIME = _this select 3 select 6;
private _REMOVE_VEHICLE = _this select 3 select 7;
private _REMOVE_FUEL = _this select 3 select 8;



{moveOut _x} forEach crew _farpVehicle;
waitUntil {count crew _farpVehicle == 0};
sleep 2;

_farpVehicle setVariable ["vehicleDeployed", true, true];
_pos = position _farpVehicle;
_dir = direction _farpVehicle;
if (_REMOVE_VEHICLE) then {
	[_farpVehicle, {
		if (isServer) then {
			_this hideObjectGlobal true;
			_this enableSimulationGlobal false;
			[_this, 20] call BIS_fnc_setHeight;
		};
	}] remoteExec ["call", 0];
} else {_farpVehicle setVariable ["ignoreCollisionForPackUp", true, true]};
if (_REMOVE_FUEL) then {[_farpVehicle,{_this setVariable ["fuelStateOnDeploy", fuel _this, true]; _this setFuel 0}] remoteExec ["call", _farpVehicle]};


//Create Composition Objects
_composition_objects = [_pos, _dir, _deployedObjs] call TFD_fnc_objectMapper;
{
	_x setVectorUp surfaceNormal position _x;
	_x allowDamage false;
} forEach _composition_objects;

//Setup Composition Light Params
_light = nearestObject [_pos, "#lightpoint"];

_light setLightAttenuation [0,4,4,4];
_light setLightIntensity 2000;
_light setLightAmbient [0.2, 0.2, 0.2];
_light setLightColor [0.2, 0.2, 0.2];
_lightNameString = "FOB: Freedom" splitString ":-=;.,/\& "; 
_lightNameString = _lightNameString joinString "_"; 
 
_light call compile format ["light_%1 = _this; publicVariable str light_%1", _lightNameString];

//Define the composition terminal (for player interaction)
_terminal = nearestObject [_pos, "Land_DataTerminal_01_F"];
sleep 1;
//Animate the terminal - open
[_terminal, 3] call BIS_fnc_DataTerminalAnimate;
_terminal setVariable ['mutex', false, true];

//Add action to farp terminal to repair and rearm vehicle (requires vehicle empty)
if (_REARM_POINT) then {
	[[_REARM_TIME, _terminal,_pos,_dir], {
		
		_terminal = _this select 1;
		_terminal addAction ["Repair Vehicle", {
			_terminal = _this select 0;
			_pause = _this select 3 select 0;
			_pos = _this select 3 select 2;
			_dir = _this select 3 select 3;
						
			_terminal setVariable ["mutex", true, true];
			_veh = (nearestObjects[(_pos getPos [6, (_dir + 90)]),["Car","Tank", "Air"],6]) select 0;
			{moveOut _x} forEach crew _veh;

			_string = format ["%1 is being repaired and rearmed. ETA Approx %2 minutes", getText(configFile >> "CfgVehicles" >> typeOf _veh >> "displayName" ),_pause];
			_string remoteExec ["hint", side (_this select 1)];
			
			[_veh, {_this setFuel 0; _this setVehicleAmmoDef 0;}] remoteExec ["call", _veh];
			
			_veh lock 2;
			sleep (_pause*60);
			
			if (damage _veh > 0.25) then {_veh setDamage 0.25};
			
			[_veh, {_this setFuel 1; _this setVehicleAmmoDef 1;}] remoteExec ["call", _veh];

			_string = format ["%1 has been field repaired and fully rearmed.", getText(configFile >> "CfgVehicles" >> typeOf _veh >> "displayName" )];
			_string remoteExec ["hint", side (_this select 1)];
			
			_veh lock 0;
			_terminal setVariable ["mutex", false, true];
			
		}, _this, 999, false, true, "", "count (nearestObjects[(_target getRelPos [8, 180]),['Car','Tank', 'Air'],6]) == 1 && !(_target getVariable ['mutex', true])", 3, false];
	}] remoteExec ["call", 0, _terminal];
};
//Add action to composition terminal for the packup action.
[[_farpVehicle,_UNDEPLOY_TIME,_terminal,_composition_objects,_DEPLOYABLE_NAME,_FACTION,_REMOVE_VEHICLE,_REMOVE_FUEL], {

	_terminal = _this select 2;
	_DEPLOYABLE_NAME = _this select 4;
	_terminal addAction [format ["Pack Up %1", _DEPLOYABLE_NAME], {
		
		
		private _farpVehicle = _this select 3 select 0;
		private _pause = _this select 3 select 1;
		private _terminal = _this select 3 select 2;
		private _composition_objects = _this select 3 select 3;
		private _DEPLOYABLE_NAME = _this select 3 select 4;
		private _FACTION = _this select 3 select 5;
		private _REMOVE_VEHICLE = _this select 3 select 6;
		private _REMOVE_FUEL = _this select 3 select 7;

		format["ATTENTION ... %1 is being packed up",_DEPLOYABLE_NAME] remoteExec ["hint", side (_this select 1)];
		[_terminal, 0] call BIS_fnc_DataTerminalAnimate;
		_terminal setVariable ['mutex', true, true];
		sleep _pause;

		{deleteVehicle _x} forEach _composition_objects;
		if (_REMOVE_VEHICLE) then {
			[_farpVehicle, {
				if (isServer) then {
					[_this, 0.1] call BIS_fnc_setHeight;
					_this enableSimulationGlobal true;
					_this hideObjectGlobal false;
				};
				_this lock false;
			}] remoteExec ["call", 0];
		};
		format["%1 is ready to move.",_DEPLOYABLE_NAME] remoteExec ["hint", side (_this select 1)];
		_farpVehicle setVariable ["vehicleDeployed", false, true];
		
		if (_REMOVE_FUEL) then {[_farpVehicle,{_this setFuel (_this getVariable ["fuelStateOnDeploy",1])}] remoteExec ["call", _farpVehicle]};
		
	}, _this, 998, false, true, "", "{!(_x getVariable ['ignoreCollisionForPackUp', false])} count (nearestObjects[(_target getRelPos [8, 180]),['Car','Tank', 'Air'],6]) == 0 && !(_target getVariable 'mutex')", 3, false]

}] remoteExec ["call", 0, _terminal];