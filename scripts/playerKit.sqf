_type = typeOf player;

// Clothing Selection
	_uniform = "U_O_T_Soldier_F";
	
	_headgear = "H_HelmetSpecO_ghex_F";
	
	_vest = "V_Chestrig_khk";
	
	_bagS = [ "B_ViperHarness_khk_F" , "B_ViperLightHarness_khk_F" ] call BIS_fnc_selectRandom;
	_bagL = [ "B_ViperHarness_khk_F" , "B_ViperLightHarness_khk_F" ] call BIS_fnc_selectRandom;
	_LRRadio = "tf_bussole";

// Weapons
	_rifle = "arifle_CTAR_ghex_F";
	_rifleA = "30Rnd_580x42_Mag_F";
	_rifleB = "";
	
	_rifleVar = "srifle_DMR_07_ghex_F";
	_rifleVarA = "20Rnd_650x39_Cased_Mag_F";
	
	_rifleSL = "arifle_ARX_ghex_F";
	_rifleSLA = "30Rnd_65x39_caseless_green";
	_rifleSLUA = "10Rnd_50BW_Mag_F";
	
	_rifleGL = "arifle_CTAR_GL_ghex_F";
	_uglA = "1Rnd_HE_Grenade_shell";
	
	_lmg = "arifle_CTARS_ghex_F";
	_lmgA = "100Rnd_580x42_Mag_F";
	_lmgB = "";
	
	_mmg = "MMG_01_tan_F";
	_mmgA = "150Rnd_93x64_Mag";
	_mmgB = "bipod_02_F_tan";
	
	_sRail = "";
	_tRail = "rhs_acc_rakursPM";
	
	_side = "hgun_Rook40_F";
	_sideA = "16Rnd_9x21_Mag";
	_sideAtt = "muzzle_snds_L";
	
	_mat = "";
	_matA = "";

	_glasses = goggles player;
	
// Strip
	removeAllWeapons player;
	removeAllItems player;
	removeUniform player;
	removeVest player;
	removeBackpack player;
	removeHeadgear player;

// Basic Assign
	player forceAddUniform _uniform;
	player addVest _vest;
	player addHeadgear _headgear;
	
_assignedItems = [ "ItemMap" , "ItemCompass" , "ItemWatch" , "ItemRadio" ];
	
{
	
	if ( _x in _assignedItems ) then { } else { player unlinkItem _x; };
	
} forEach assignedItems player;

{
	
	if ( _x in assignedItems player ) then { } else { player linkItem _x; };
	
} forEach _assignedItems;
	
	player addItemToUniform "ACE_MapTools";
	player addItemToUniform "ACE_morphine";
	for "_i" from 1 to 3 do { player addItemToUniform "ACE_fieldDressing"; };
	for "_i" from 1 to 2 do { player addItemToUniform "SmokeShell"; };
	for "_i" from 1 to 3 do { player addItemToUniform "HandGrenade"; };
	for "_i" from 1 to 3 do { player addItemToUniform "Chemlight_blue"; };

[player] call ace_hearing_fnc_putInEarplugs;

player addGoggles _glasses;

switch (_type) do {

	case "O_officer_F":
		{
			
			player addBackpack _LRRadio;
		
			for "_i" from 1 to 13 do { player addItemToVest _rifleSLA; };
			for "_i" from 1 to 3 do { player addItemToBackpack _rifleSLUA; };
			player addItemToBackpack "SmokeShellPurple";
			
			player addWeapon _rifleSL;
			player addPrimaryWeaponItem _rifleB;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			
			player addWeapon "Binocular";
			
			for "_i" from 1 to 2 do { player addItemToVest _sideA; };
			player addWeapon _side;
			player addHandgunItem _sideAtt;
			
		};
	case "O_Soldier_SL_F":
		{
			
			player addBackpack _LRRadio;
			
			for "_i" from 1 to 13 do { player addItemToVest _rifleSLA; };
			for "_i" from 1 to 3 do { player addItemToBackpack _rifleSLUA; };
			player addItemToBackpack "SmokeShellPurple";
			
			player addWeapon _rifleSL;
			player addPrimaryWeaponItem _rifleB;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			
			player addWeapon "Binocular";
			
			for "_i" from 1 to 2 do { player addItemToVest _sideA; };
			player addWeapon _side; 
			player addHandgunItem _sideAtt;
			
		};
	case "O_Soldier_TL_F":
		{
			
			for "_i" from 1 to 12 do { player addItemToVest _rifleA; };
			for "_i" from 1 to 10 do { player addItemToVest _uglA; };
			
			player addWeapon _rifleGL;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			
			player addWeapon "Binocular";
			
			for "_i" from 1 to 2 do { player addItemToVest _sideA; };
			player addWeapon _side; 
			player addHandgunItem _sideAtt;
			
			player addBackpack _bagS;
			
		};
	case "O_Soldier_AR_F":
		{
			
			for "_i" from 1 to 5 do { player addItemToVest _lmgA; };
			
			player addWeapon _lmg;
			player addPrimaryWeaponItem _lmgB;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			
			player addItemToVest _lmgA;
			
			player addBackpack _bagS;
			
		};
	case "O_Soldier_AAR_F":
		{
			
			for "_i" from 1 to 12 do { player addItemToVest _rifleA; };
			
			player addWeapon _rifle;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			
			for "_i" from 1 to 2 do { player addItemToVest _sideA; };
			player addWeapon _side; 
			player addHandgunItem _sideAtt;
			
			player addWeapon "Binocular";
			
			player addBackpack _bagS;
			for "_i" from 1 to 6 do { player addItemToBackpack _lmgA; };
			
			
		};
	case "O_HeavyGunner_F":
		{
			
			for "_i" from 1 to 5 do { player addItemToVest _mmgA; };
			
			player addWeapon _mmg;
			player addPrimaryWeaponItem _mmgB;
			player addPrimaryWeaponItem _sRail;
			
			player addItemToVest _mmgA;
			
			player addBackpack _LRRadio;
			
		};
	case "O_support_AMG_F":
		{
			
			for "_i" from 1 to 12 do { player addItemToVest _rifleA; };
			
			player addWeapon _rifle;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			
			for "_i" from 1 to 2 do { player addItemToVest _sideA; };
			player addWeapon _side; 
			player addHandgunItem _sideAtt;
			
			player addWeapon "Binocular";
			
			player addBackpack _bagS;
			for "_i" from 1 to 4 do { player addItemToBackpack _mmgA; };
			
			
			
		};
	case "O_medic_F":
		{
				
			for "_i" from 1 to 12 do { player addItemToVest _rifleA; };
			
			player addWeapon _rifle;
			player addPrimaryWeaponItem _rifleB;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			
			for "_i" from 1 to 2 do { player addItemToVest _sideA; };
			player addWeapon _side; 
			player addHandgunItem _sideAtt;
			
			player addBackpack _bagS;	
			for "_i" from 1 to 40 do {player addItemToBackpack "ACE_fieldDressing";};
			for "_i" from 1 to 12 do {player addItemToBackpack "ACE_epinephrine";};
			for "_i" from 1 to 18 do {player addItemToBackpack "ACE_morphine";};
		
		};
	case "B_Soldier_A_F":
		{
				
			for "_i" from 1 to 12 do { player addItemToVest _rifleA; };
			
			player addWeapon _rifle;
			player addPrimaryWeaponItem _rifleB;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			
			for "_i" from 1 to 2 do { player addItemToVest _sideA; };
			player addWeapon _side; 
			player addHandgunItem _sideAtt;
			
			player addBackpack _bagL;
			for "_i" from 1 to 2 do {player addItemToBackpack _matA;};
		
		};
	case "B_soldier_LAT_F":
		{

			for "_i" from 1 to 12 do { player addItemToVest _rifleA; };
			
			player addBackpack _bagS;
			player addItemToBackpack _matA;
			
			player addWeapon _rifle;
			player addPrimaryWeaponItem _rifleB;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			player addWeapon _mat;

			for "_i" from 1 to 2 do { player addItemToVest _sideA; };
			player addWeapon _side; 
			player addHandgunItem _sideAtt;

			player addBackpack _bagL;

			player addItemToBackpack _matA;

		};
	case "O_soldier_exp_F":
		{
			
			for "_i" from 1 to 12 do { player addItemToVest _rifleA; };
			
			player addWeapon _rifle;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			player addPrimaryWeaponItem _rifleB;
			
			for "_i" from 1 to 2 do { player addItemToVest _sideA; };
			player addWeapon _side; 
			player addHandgunItem _sideAtt;
			
			player addBackpack _bagL;
			player addItemToBackpack "ACE_Clacker";
			player addItemToBackpack "ACE_DefusalKit";
			for "_i" from 1 to 2 do { player addItemToBackpack "SatchelCharge_Remote_Mag"; };
		};
	case "O_support_Mort_F":
		{
			
			for "_i" from 1 to 12 do { player addItemToVest _rifleA; };
			
			player addWeapon _rifle;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			player addPrimaryWeaponItem _rifleB;
			
			for "_i" from 1 to 2 do { player addItemToVest _sideA; };
			player addWeapon _side; 
			player addHandgunItem _sideAtt;
			
			player addBackpack "O_Mortar_01_weapon_F";
		};
	case "O_support_AMort_F":
		{
			
			for "_i" from 1 to 12 do { player addItemToVest _rifleA; };
			
			player addWeapon _rifle;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			player addPrimaryWeaponItem _rifleB;
			
			for "_i" from 1 to 2 do { player addItemToVest _sideA; };
			player addWeapon _side; 
			player addHandgunItem _sideAtt;
			
			player addBackpack "O_Mortar_01_support_F";
		};
	default
		{
			
			for "_i" from 1 to 12 do { player addItemToVest _rifleVarA; };
			player addWeapon _rifleVar;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			player addPrimaryWeaponItem _rifleB;
			
			player addWeapon _side; 
			player addHandgunItem _sideAtt;
			for "_i" from 1 to 2 do { player addItemToVest _sideA; };
			
			player addBackpack _bagS;
			for "_i" from 1 to 6 do {player addItemToBackpack _rifleA;};
			for "_i" from 1 to 6 do {player addItemToBackpack _rifleVarA;};
			
		};
};