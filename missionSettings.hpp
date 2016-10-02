/* 
*
* TFD_ORBAT is used to assign group names and radio channels.
*
* Usage - [ "groupName" , SW Channel , "name" , "name" ]
* Add one new array per group. Ensure all arrays except the final one are followed by a comma (,)
*
*/

TFD_ORBAT = [
	["COY HQ",	9,	"s1","s2"],
	["1 PL HQ",	1,	"s3","s4"],
	["A SQD",	2,	"s5","s6","s7","s8","s9","s10"],
	["B SQD",	3,	"s11","s12","s13","s14","s15","s16"],
	["C SQD",	4,	"s17","s18","s19","s20","s21","s22"],
	["MMG 1",	1,	"s23","s24"],
	["MAT 1",	1,	"s25","s26"]
];

/*
*
* startMission is used by the game logic to define the briefing phase from the play phase.
* For a 'hot start' mission set this to true.
*
*/

startMission = false;

/*
*
* scriptedPlayerKit is used to check if you are using the "playerKit.sqf" script to assign player equipment.
* set to true if you are using the script.
*
*/

scriptedPlayerKit = false;