/*
 * Author: Jam_Toast
 * Modified: 19/09/2016
 *
 * Handles the velocity of a vehicle over a period of time, eg. slow an AI helicopter down for a smoother landing.
 *
 * Arguments:
 * 0: The vehicle you want to slow down <OBJECT>
 * 1: Factor to change velocity by per loop ( use decimals to divide ) <NUMBER>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [ vehicle , 2 ] spawn TFD_fnc_handleVelocity;
 *
 */

_veh	= param [ 0 , objNull , [ objNull ] ];
_factor	= param [ 1 , 0.5 , [ 123 ] ];

for "_i" from 0 to 10 step 1 do {

	_change = [ 
		( velocity _veh select 0 ) * _factor , 
		( velocity _veh select 1 ) * _factor , 
		( velocity _veh select 2 ) * _factor 
	]; 

	_veh setVelocity _change;

	sleep 1;

};