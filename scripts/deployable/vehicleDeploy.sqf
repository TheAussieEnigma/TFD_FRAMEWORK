/*

Simple Deployable Script - by JohnnyShootos

This script will turn any vehicle into a deployable. (Field Hospital, FARP, FOB, MHQ)

You will need to save the composition array for your deployable from BIS_fnc_objectsGrabber into a header file 
and pass the path to this seperate file in as the 5th variable in the script call.

Arguments:
	0: <OBJECT> - The vehicle that is to be the deployable object
	1: <SIDE> - The side that is able to use the action
	2: <SCALAR> - The time in seconds it takes to pack up the deployable
	3: <STRING> - The name that is used in on screen hints and action texts. Can be something like "FARP" or "FOB: HoneyBadger" etc.
	4: <STRING> - The path to the header file containing the composition. Note the last line of this header file should. return the composition array.
	5: <BOOL> - Does the composition function as a rearm point for vehicles.
	6: <SCALAR> - Time in minutes it takes to rearm a vehicle (Default 1).
	7: <BOOL> - Whether the vehicle should be removed. (Default TRUE).
	8: <BOOL> - Whether the fuel should be removed on deployment (get readded on undeployment). Default FALSE

Usage:

put into vehicle init field: _nul = [this, west, 5, "FARP: Armadillo", "path\to\armadillo.hpp", true, 1] execVM "path\to\vehicleDeploy.sqf";

this script is JIP friendly - JIP players will still get the action to deploy/undeploy the vehicle
*/
///////////////////////////////////////USER VARS///////////////////////////////////////////
_this params [
	["_farpVehicle", objNull,[objNull]],
	["_FACTION", playerSide,[west]],
	["_UNDEPLOY_TIME", 10, [123]],
	["_DEPLOYABLE_NAME", "Your Deployable Vehicle", [""]],
	["_COMPOSITION_PATH", "", [""]],
	["_REARM_POINT", false, [true]],
	["_REARM_TIME", 1,[123]],
	["_REMOVE_VEHICLE", true, [true]],
	["_REMOVE_FUEL", false,[true]]
];

////////////////////////////////DONT TOUCH BELOW THIS LINE/////////////////////////////////
if !(isServer) exitWith {};
if (_COMPOSITION_PATH isEqualTo "") exitWith {systemChat "Error: No Composition path specified"};

_farpVehicle setVariable ["vehicleDeployed", false, true];

_deployedObjs = call compile preprocessFileLineNumbers _COMPOSITION_PATH;

[
	_farpVehicle,
	format["Deploy %1", _DEPLOYABLE_NAME],"\A3\ui_f\data\igui\cfg\simpleTasks\types\interact_ca.paa","\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa",
	"driver _target == _this && !(_target getVariable 'vehicleDeployed') && alive _target && ({_x != _target} count (nearestObjects [_target,['Air','Car','Motorcycle','Tank','House','HouseBase','Building','Static'], 20]) == 0)",
	"driver _target == _caller && alive _target",
	{},
	{},
	{
		_this remoteExec ["TFD_fnc_deployVehicle", 2];
	},
	{},
	[_farpVehicle,_deployedObjs,_UNDEPLOY_TIME,_DEPLOYABLE_NAME,_FACTION,_REARM_POINT,_REARM_TIME,_REMOVE_VEHICLE,_REMOVE_FUEL],
	6,
	-999,
	false
] remoteExec ["bis_fnc_holdActionAdd", _FACTION, true];
