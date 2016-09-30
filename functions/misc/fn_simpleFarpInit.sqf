/*
* 
* Simple FARP Script - 
* 
* Author: JohnnyShootos
* Last modified 09/09/16
* 
* This script will turn any vehicle into a farp though for aethetics it is recommended to use a HEMTT Repair.
* Note this is a VERY simplified script and will not function for more than 1 vehicle due to the use of static named global vars.
* I could probably make it a more robust script, with error handling, and no bugs, but this is what you get for 45mins of work :)
* 
* Arguments:
* 	0: The FARP vehicle <OBJECT>
* 	1: The side using the FARP <SIDE>
* 	2: The time it takes to packup/deploy the FARP <SCALAR>
* 	3: The time it takes to repair/rearm a vehicle <SCALAR>
* 
* 
* Usage:
* 
* Use this in the objects init field OR execute this on the server on the fly.
* 
* [myFarp,west,15,15] call TFD_fnc_simpleFarpInit
*/
///////////////////////////////////////USER VARS///////////////////////////////////////////
_farpVehicle = param [0, objNull, [objNull]];
_FACTION_USING_THE_FARP = param [1, west, [west]];
_UNDEPLOY_TIME = param [2, 15, [123]];
_REPAIR_REARM_TIME = param [3, 15, [123]];
////////////////////////////////DONT TOUCH BELOW THIS LINE/////////////////////////////////
if !(isServer) exitWith {};

_farpType = typeOf _farpVehicle;
_farpVehicle setVariable ["JSH_farpDeployed", false, true];

_deployedObjs = [
	["VR_Area_01_square_4x4_yellow_F",[0.747925,-0.0351563,0],0,1,0,[0,0],"JSH_farpTarget","",true,false], 
	["Land_GasTank_01_yellow_F",[-3.32703,1.42822,2.67029e-005],359.404,1,0,[-0.012153,-0.0138035],"","",true,false], 
	["Land_CanisterOil_F",[-3.49011,-1.10938,0.910244],196.001,1,0,[0.0017834,0.0812148],"","",true,false], 
	["Land_DataTerminal_01_F",[-3.69373,-0.0834961,0.684714],269.678,1,0,[-0.00215353,0.35191],"JSH_farpTerminal","[this, 3] call BIS_fnc_DataTerminalAnimate",true,false], 
	["Land_BagFence_01_short_green_F",[-3.73157,0.010498,-0.000999928],91.1527,1,0,[0,-0],"","",true,false], 
	["Land_ToolTrolley_02_F",[-3.49084,-1.43823,-7.62939e-006],179.551,1,0,[-0.00209232,0.00419096],"","",true,false], 
	["Land_ButaneTorch_F",[-3.35583,-1.74878,0.910079],20.987,1,0,[0.291781,-0.401443],"","",true,false], 
	["Land_DrillAku_F",[-3.5603,-1.47241,0.910146],311.84,1,0,[-0.0968061,0.317171],"","",true,false], 
	["Land_GasTank_01_khaki_F",[-3.73511,1.39258,2.67029e-005],359.418,1,0,[-0.0106979,-0.0165405],"","",true,false], 
	["Land_GasTank_01_blue_F",[-3.63,1.84741,4.24385e-005],359.001,1,0,[-0.026691,-0.00449248],"","",true,false], 
	["Land_GasTank_02_F",[-3.44739,-2.20947,0.000234127],359.038,1,0,[0.0569409,0.11709],"","",true,false], 
	["Land_Cargo20_military_green_F",[5.30505,-0.161377,1.43051e-006],269.572,1,0,[4.02836e-005,-1.22921e-005],"","",true,false], 
	["Land_CanisterPlastic_F",[-3.55151,2.44775,0],0.199863,1,0,[0.00894868,-0.00275456],"","",true,false], 
	["Land_WeldingTrolley_01_F",[-3.50085,-3.04932,1.09673e-005],86.716,1,0,[0.00167459,-0.0014547],"","",true,false], 
	["Land_CanisterFuel_F",[-3.62537,3.02368,5.29289e-005],359.412,1,0,[0.0476832,0.00367039],"","",true,false], 
	["Land_CanisterFuel_F",[-3.55103,3.35352,5.29289e-005],359.503,1,0,[0.0475554,0.00369264],"","",true,false], 
	["B_Truck_01_mover_F",[-5.23376,0.408203,-0.105468],359.689,0.999796,0,[-0.388786,-0.000493071],"JSH_farpVehicleDeployed","",true,false], 
	["Land_GuardRailing_01_F",[-3.37354,-4.39038,0],0,1,0,[0,0],"","",true,false], 
	["Land_GuardRailing_01_F",[-3.45374,5.41187,0],0,1,0,[0,0],"","",true,false], 
	["Land_GuardRailing_01_F",[-5.03198,-4.40088,0],0,1,0,[0,0],"","",true,false], 
	["Land_GuardRailing_01_F",[-5.27368,5.48193,0],0,1,0,[0,0],"","",true,false],
	["Land_GuardRailing_01_F",[-2.69641,-0.0883789,0],89.1821,1,0,[0,0],"","",true,false], 
	["Land_GuardRailing_01_F",[-2.66516,-1.80664,0],89.1821,1,0,[0,0],"","",true,false], 
	["Land_GuardRailing_01_F",[-2.72351,1.78052,0],89.1821,1,0,[0,0],"","",true,false], 
	["Land_GuardRailing_01_F",[-2.66077,-3.40259,0],89.1821,1,0,[0,0],"","",true,false],
	["Land_GuardRailing_01_F",[-2.76477,3.81812,0],89.1821,1,0,[0,0],"","",true,false]
];

[
	_farpVehicle,
	"Deploy FARP","\A3\ui_f\data\igui\cfg\simpleTasks\types\interact_ca.paa","\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa",
	"_this distance _target < 5 && !(_target getVariable 'JSH_farpDeployed') && alive _target",
	"_caller distance _target < 5 && alive _target",
	{},
	{},
	{
		private _farpVehicle = _this select 3 select 0;
		private _deployedObjs = _this select 3 select 1;
		private _farpType = _this select 3 select 2;
		private _UNDEPLOY_TIME = _this select 3 select 3;
		private _REPAIR_REARM_TIME = _this select 3 select 4;

		_farpVehicle setVariable ["JSH_farpDeployed", true, true];
		_pos = position _farpVehicle;
		_dir = direction _farpVehicle;
		deleteVehicle _farpVehicle;
		sleep 1;
		
		//Create FARP Objects
		FARP_OBJECTS = [_pos, _dir, _deployedObjs] call BIS_fnc_objectsMapper;
		{
			_x setVectorUp surfaceNormal position _x;
			_x allowDamage false;
		} forEach FARP_OBJECTS;
		JSH_farpVehicleDeployed lock 2;
		publicVariable "JSH_farpTerminal";
		JSH_farpTerminal setVariable ['mutex', false, true];
		//commit farp objects into global array for cleanup when packed up
		publicVariable "FARP_OBJECTS";

		//Add action to farp terminal to repair and rearm vehicle (requires vehicle empty)
		[[_REPAIR_REARM_TIME], {JSH_farpTerminal addAction ["Repair Vehicle", {
			_pause = _this select 3 select 0;
			_veh = (nearestObjects[position JSH_farpTarget,["Car","Tank"],5]) select 0;
			_string = format ["Vehicle is being repaired and rearmed. ETA Approx %1 minutes", ceil(_pause / 60)];
			_string remoteExec ["hint", side (_this select 1)];
			_veh setFuel 0;
			_veh setVehicleAmmoDef 0;
			{moveOut _x} forEach crew _veh;
			_veh lock 2;
			sleep _pause;
			if (damage _veh > 0.25) then {_veh setDamage 0.25};
			_veh setVehicleAmmoDef 1;
			_veh setFuel 1;
			"Vehicle is repaired and rearmed." remoteExec ["hint", side (_this select 1)];
			_veh lock 0;
		}, _this, 999, false, true, "", "count nearestObjects[position JSH_farpTarget,['Car','Tank'],5] == 1", 3, false]}] remoteExec ["call", 0, JSH_farpTerminal];
		
		//Add action to new farpvehicle for the packup action.
		[[_farpType,_UNDEPLOY_TIME], {JSH_farpTerminal addAction ["Undeploy FARP", {
			private _pos = position JSH_farpTarget;
			private _dir = direction JSH_farpTarget;
			_pause = _this select 3 select 1;

			"ATTENTION ... FARP is being packed up" remoteExec ["hint", side (_this select 1)];
			[JSH_farpTerminal, 0] call BIS_fnc_DataTerminalAnimate;
			JSH_farpTerminal setVariable ['mutex', true, true];
			sleep _pause;

			{deleteVehicle _x} forEach FARP_OBJECTS;

			_newFARP = createVehicle [(_this select 3 select 0), _pos, [], 0, "CAN_COLLIDE"];
			_newFARP setDir _dir;
			"FARP is ready to move." remoteExec ["hint", side (_this select 1)];
			[_newFARP,_FACTION_USING_THE_FARP,_UNDEPLOY_TIME,_REPAIR_REARM_TIME] call _fnc_scriptname;

		}, _this, 998, false, true, "", "count nearestObjects[position JSH_farpTarget,['Car','Tank'],5] == 0 && !(_target getVariable 'mutex')", 3, false]}] remoteExec ["call", 0, JSH_farpTerminal];
	},
	{},
	[_farpVehicle,_deployedObjs,_farpType,_UNDEPLOY_TIME,_REPAIR_REARM_TIME],
	6,
	999
] remoteExec ["bis_fnc_holdActionAdd", _FACTION_USING_THE_FARP, _farpVehicle];
