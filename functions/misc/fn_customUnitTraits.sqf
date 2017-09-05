/*
 * Author: Jam Toast 
 * Modified: 10/09/2016
 *
 * Changes the characteristics of the units
 *
 * Arguments:
 * 0: Visibility Factor		<FLOAT> ( How easy it is for the AI to notice players. 0 = No Visibility , 1 = full visiblity )
 * 1: Audible Factor		<FLOAT> ( How easy it is for AI to hear players. 0 = No Audibility , 1 = full Audibility )
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [ 0.75 , 0.75 ] spawn TFD_fnc_customUnitTraits;
 *
 */

waitUntil {!isNull player && player == player};

_vis	= param [ 0, 1.00,	[123] ];
_audio	= param [ 1, 1.00,	[123] ];

player setUnitTrait ["camouflageCoef" , _vis];
player setUnitTrait ["audibleCoef" , _audio];

true