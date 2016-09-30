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
				
				removeAllPrimaryWeaponItems _x; // <-- do we need to remove all their attachments? Leagacy thing from when people were taking ACO's from dead enemy TLs, 50/50 on still necessary or not // oh yeah... people were dicks.
				_x addPrimaryWeaponItem _accessory; //this line replaces the light accessory if it currently occupied by a laser for example
				_x enableGunLights "forceOn";
			};
			
			if ( _removeNVG ) then { _x unlinkItem ( hmd _x ) };
			
		};

	} forEach allUnits;

	sleep 30;

};