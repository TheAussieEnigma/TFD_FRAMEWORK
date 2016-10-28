/* 
*
* TFD_ORBAT is used to assign group names and radio channels.
*
* Usage - [ "groupName" , SW Channel , "name" , "name" ]
* Add one new array per group. Ensure all arrays except the final one are followed by a comma (,)
*
*/

TFD_ORBAT = [
	//groupName - sw - (ch block) - units in the group -- Channel block is optional and can be omitted
	["HQ",		8,	1,	"PLTCOMMAND",	"s_25","s_26"],
	["ALPHA",	1,	1,	"ALPHA",		"s_1","s_2","s_3","s_4","s_5","s_6"],
	["BRAVO", 	2,	1,	"BRAVO",		"s_7","s_8","s_9","s_10","s_11","s_12"],
	["CHARLIE",	3,	1,	"CHARLIE",		"s_13","s_14","s_15","s_16","s_17","s_18"],
	["DELTA",	4,	1,	"DELTA",		"s_19","s_20","s_21","s_22","s_23","s_24"]
];

/*
*
* startMission is used by the game logic to define the briefing phase from the play phase.
* For a 'hot start' mission set this to true.
*
*/

startMission = missionNameSpace getVariable ["startMission", false];

/*
*
* scriptedPlayerKit is used to check if you are using the "playerKit.sqf" script to assign player equipment.
* set to true if you are using the script.
*
*/

scriptedPlayerKit = false;