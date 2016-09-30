/* 
*
* TFD_ORBAT is used to assign group names and radio channels.
*
* Usage - [ "groupName" , SW Channel , "name" , "name" ]
* Add one new array per group. Ensure all arrays except the final one are followed by a comma (,)
*
*/

TFD_ORBAT = [
	["DARDY 1",	1, "s1","s2","s3","s4","s5","s6"],
	["DARDY 2", 2, "s7", "s8", "s9", "s10", "s11", "s12"]
];

/*
*
* startMission is used by the game logic to define the briefing phase from the play phase.
* For a 'hot start' mission set this to true.
*
*
*/

startMission = true;

/*
*
* scriptedPlayerKit is used to check if you are using the "playerKit.sqf" script to assign player equipment.
* set to true if you are using the script.
*
*/

scriptedPlayerKit = false;

/*
*
* scriptedVehicleKit is used to check if you are using the "vehicleKit.sqf" script to set vehicle inventory's.
* set to true if you are using the script.
*
*/

scriptedVehicleKit = false;