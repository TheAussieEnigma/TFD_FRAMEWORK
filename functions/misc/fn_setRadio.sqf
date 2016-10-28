/*
 * Author: Jam Toast
 * Modified: 02/10/2016
 *
 * Handles automatic TFAR channel settings
 *
 * Arguments:
 * 0: The variable containing the orbat for the mission <ARRAY>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [ myVar ] call TFD_fnc_setRadio;
 *
 */


private _TFD_ORBAT = param [0, [], [[]]];
private _name = str player;

{
	if (_name in _x) then {

		_channel = (_x select 1);
		waitUntil {[] call TFAR_fnc_haveSWRadio};

		// Channels are 0 indexed so must be _channel - 1
		[(call TFAR_fnc_activeSwRadio), _channel - 1] call TFAR_fnc_setSwChannel;
		[(call TFAR_fnc_activeSwRadio), 7] call TFAR_fnc_setAdditionalSwChannel;

	};
}  forEach _TFD_ORBAT;