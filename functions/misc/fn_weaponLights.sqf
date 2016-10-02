/*
 * Author: Jam Toast 
 * Modified: 16/08/2016
 *
 * Force the AI to use lights. Can add flashlights and remove NVGs.
 *
 * Arguments:
 * 0: accessory to be added <STRING>
 * 1: remove NVG <BOOL>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [ "acc_flashlight" , true ] spawn TFD_fnc_weaponLights;
 *
 * Public: No
 */

_accessory = _this select 0;
_removeNVG = _this select 1;

while { true } do {

	{

		if (!isPlayer _x) then {

			if ( _accessory in primaryWeaponItems _x) then { _x enableGunLights "forceOn";} else {
				
				removeAllPrimaryWeaponItems _x;
				
				_x addPrimaryWeaponItem _accessory;
				
				_x enableGunLights "forceOn";
			};
			
			if ( _removeNVG ) then { _x unlinkItem ( hmd _x ) };
			
		};

	} forEach allUnits;

	sleep 30;

};