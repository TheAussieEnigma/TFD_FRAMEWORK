/*
* Author: JohnnyShootos 
* Modified: 06/09/2016
*
* IED script
*
* Arguments: (ALL arguments are optional except the trigger)
* 0: Trigger that encapsulates the area for the IED's to be placed <OBJECT>
* 	If no trigger is supplied then the worlds center and radius are used to define the area.
* 1: Number of small IED's <SCALAR>
* 2: Number of large IED's <SCALAR>
* 3: Number of carbomb IED's <SCALAR>
* 4: Chance a spawned object is an IED (0 -> 100) <SCALAR>
* 5: Defuse failure chance (Note there are 24 checks per defuse attempt so keep this small. Like 5 is huge) <SCALAR>
* 6: Use the postProcess visual / audio effect <BOOL>
* 7: Small ied types <ARRAY of STRINGS (CfgVehicles classnames)>
* 8: Large ied types <ARRAY of STRINGS (CfgVehicles classnames)>
* 9: Car bomb ied types <ARRAY of STRINGS (CfgVehicles classnames)>
*
* Return Value:
* Nil
*
* Examples:
* [trg_1,10,10,10,25,5,false] spawn TFD_fnc_iedInit - all values (except classnames) specified. Best Usage.
* [trg_1] spawn TFD_fnc_iedInit - spawns default number of IED's within trigger, using default probabilities and default IED types
* [] spawn TFD_fnc_iedInit - spawns default number of IEDS over whole map
*
* Public: No
*
* NOTE: There is no 'documentation' within the child functions as they are not intended to be called from outside this script.
*
* TODO 	- PP effect,
* 		- add functionality to disable certain types of Ied's. (At the moment will place at least 1 one of each type)
* 		- add criteria for being able to defuse (Minedetector + toolkit?)
* 		- add logic in location finder to find positions around map Locations to facilitate whole map IED creation that does not need a trigger
* 		- add an "interrupt" logic that penalises the defuser with a higher detonation chance on future attempts if they interrupt the defuse attempt
* */

#include "ied.hpp" //This file contains the macros and default lists used in this function

// User Input Vars from _this
_TriggerObject = param [0, objNull, [objNull]];
_NumberOfSmallBombs = param [1, 1, [123]];
_NumberOfLargeBombs = param [2, 1, [123]];
_NumberOfCarBombs = param [3, 1, [123]];
_ChanceObjectIsABomb = param [4, 20, [123]];
_DefuseFailureChance = param [5, 2, [123]];
_UsePPeffect = param [6, true, [true]];
_IedSmallObjects = param [7, [], [[]]];
_IedLargeObjects = param [8, [], [[]]];
_IedCarObjects = param [9, [], [[]]];

//Parse Input Vars / correct for errors

//turn integer inputs into float (0 -> 1). Really i just wanted to use a macro lol.
PERCENTIFY(_DefuseFailureChance);
PERCENTIFY(_ChanceObjectIsABomb);

//Load default IED model lists if there are none provided in _this.
if (count _IedSmallObjects == 0) then {
	_IedSmallObjects = _IedSmallObjectsDefault;
};

if (count _IedLargeObjects == 0) then {
	_IedLargeObjects = _IedLargeObjectsDefault;
};

if (count _IedCarObjects == 0) then {
	_IedCarObjects = _IedCarObjectsDefault;
};

//Handle negative number input and make it positive.
{
	if (_x < 0) then {
		_x = abs(_x);
	};
} forEach [
	_NumberOfSmallBombs,
	_NumberOfLargeBombs,
	_NumberOfCarBombs,
	_ChanceObjectIsABomb,
	_DefuseFailureChance
];

/*Search for Placement Locations 
*
* NOTE THIS WILL TAKE TIME WHICH IS WHY THIS PARENT FUNCTION SHOULD ONLY *EVER* BE SPAWNED UNLESS YOU DONT MIND CRASHING THE GAME
*
* Very rudimentary at the moment, need to work some math magic to have the objects spawn in more intelligent locations
*/
_ied_location_arrays = [_TriggerObject] call TFD_fnc_generateIedLocations; 

sleep 5;

_ied_locations_small = _ied_location_arrays select 0;
_ied_locations_large = _ied_location_arrays select 1;
_ied_locations_car = _ied_location_arrays select 2;




/*Create IED's
*
* General Logic Flow
*
* Select random location from input array's
* Place Object whose type is chosen at random from input array 
* Decide using input probability if placed object is an IED
* If it is an IED then add it to the return array
* If it is not an IED then disable its simulation and DO NOT add it to the return array
*
*/
TFD_SMALL_IED = [_NumberOfSmallBombs, _IedSmallObjects, _ied_locations_small, _ChanceObjectIsABomb] call TFD_fnc_placeIedObjects;
TFD_LARGE_IED = [_NumberOfLargeBombs, _IedLargeObjects, _ied_locations_large, _ChanceObjectIsABomb] call TFD_fnc_placeIedObjects;	
TFD_CAR_IED = [_NumberOfCarBombs, _IedCarObjects, _ied_locations_car, _ChanceObjectIsABomb] call TFD_fnc_placeIedObjects;
	
/* Assign Logics to IED 
* 
* General Logic Flow
* 
* Add defuse action (holdAction) to IED's (should have a visibility radius of no greater than 1m)
* Add radius check (should be an interval not each frame sp as not to overload every frame)
* 'Wakes' every 2 seconds to check radius
* If there is a player in the radius initiates the detonation trigger logic (FSM) on THEIR machine.
* Bomb is set to an armed state - exiting this main logic without disarming = boom.
* Bomb is always seraching for new trigger targets. until defused or tripped
*
*/
{
	_arr = _x;
	{
		sleep 0.05; //Doing this to stagger the initiation of the logic loop of each IED across as many frames as possible
		[_x, _DefuseFailureChance,_UsePPeffect] spawn TFD_fnc_IED_mainLogic; 
	} forEach _arr;
} forEach [TFD_SMALL_IED,TFD_LARGE_IED,TFD_CAR_IED];