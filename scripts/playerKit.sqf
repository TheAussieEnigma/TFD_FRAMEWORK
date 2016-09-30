_type = typeOf player;

// Clothing Selection
	_uniform = "rhs_uniform_cu_ocp";
	
	_headgear = [ 
		"rhsusf_ach_helmet_headset_ess_ocp" , 
		"rhsusf_ach_bare_tan" , 
		"rhsusf_ach_bare_tan_headset" , 
		"rhsusf_ach_bare_tan_ess" , 
		"rhsusf_ach_bare_tan_headset_ess" , 
		"rhsusf_ach_helmet_ocp" , 
		"rhsusf_ach_helmet_ESS_ocp" , 
		"rhsusf_ach_helmet_headset_ocp" ,
		"rhsusf_ach_helmet_headset_ess_ocp" 
	] call BIS_fnc_selectRandom;
	
	_vest = [ 
		"rhsusf_iotv_ocp_Repair" ,
		"rhsusf_iotv_ocp_Rifleman" , 
		"rhsusf_iotv_ocp_Squadleader" , 
		"rhsusf_iotv_ocp_Teamleader" 
	] call BIS_fnc_selectRandom;
	
	_bagS = "rhsusf_assault_eagleaiii_ocp";
	_bagL = "B_Kitbag_cbr";

// Weapons
	_rifle = "rhs_weap_m4a1_carryhandle";
	_rifleA = "rhs_mag_30Rnd_556x45_Mk318_Stanag";
	_rifleB = "rhsusf_acc_grip2";
	
	_rifleVar = "rhs_weap_m16a4_carryhandle";
	
	_rifleGL = "rhs_weap_m4a1_carryhandle_m203S";
	_uglA = "1Rnd_HE_Grenade_shell";
	
	_lmg = "rhs_weap_m249_pip_S_para";
	_lmgA = "rhs_200rnd_556x45_M_SAW";
	_lmgB = "";
	
	_mmg = "rhs_weap_m240B";
	_mmgA = "rhsusf_100Rnd_762x51";
	_mmgB = "bipod_02_F_blk";
	
	_sRail = "acc_flashlight";
	_tRail = "";
	
	_sidearm = "rhsusf_weap_m9";
	_sidearmA = "rhsusf_mag_15Rnd_9x19_JHP";
	
	_mat = "rhs_weap_smaw";
	_matA = "rhs_mag_smaw_HEDP";

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

switch (_type) do {

	case "B_officer_F":
		{
			
			for "_i" from 1 to 10 do { player addItemToVest _rifleA; };
			
			player addWeapon _rifle;
			player addPrimaryWeaponItem _rifleB;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			
			player addWeapon "Binocular";
			
			for "_i" from 1 to 2 do { player addItemToVest _sidearmA; };
			player addWeapon _sidearm;
			
			player addBackpack _bagS;
		
		};
	case "B_Soldier_SL_F":
		{
			
			for "_i" from 1 to 9 do { player addItemToVest _rifleA; };
			for "_i" from 1 to 8 do { player addItemToVest _uglA; };
			
			player addWeapon _rifleGL;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			
			player addWeapon "Binocular";
			
			for "_i" from 1 to 2 do { player addItemToVest _sidearmA; };
			player addWeapon _sidearm;
			
			player addBackpack _bagS;
			
		};
	case "B_Soldier_TL_F":
		{
			
			for "_i" from 1 to 9 do { player addItemToVest _rifleA; };
			for "_i" from 1 to 8 do { player addItemToVest _uglA; };
			
			player addWeapon _rifleGL;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			
			player addWeapon "Binocular";
			
			for "_i" from 1 to 2 do { player addItemToVest _sidearmA; };
			player addWeapon _sidearm;
			
			player addBackpack _bagS;
			
		};
	case "B_soldier_AR_F":
		{
			
			for "_i" from 1 to 3 do { player addItemToVest _lmgA; };
			
			player addWeapon _lmg;
			player addPrimaryWeaponItem _lmgB;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			
			player addItemToVest _lmgA;
			
			player addBackpack _bagS;
			
		};
	case "B_soldier_AAR_F":
		{
			
			for "_i" from 1 to 8 do { player addItemToVest _rifleA; };
			
			player addWeapon _rifle;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			
			for "_i" from 1 to 2 do { player addItemToVest _sidearmA; };
			player addWeapon _sidearm;
			
			player addWeapon "Binocular";
			
			player addBackpack _bagS;
			for "_i" from 1 to 5 do { player addItemToBackpack _lmgA; };
			
			
		};
	case "B_HeavyGunner_F":
		{
			
			for "_i" from 1 to 4 do { player addItemToVest _mmgA; };
			
			player addWeapon _mmg;
			player addPrimaryWeaponItem _mmgB;
			player addPrimaryWeaponItem _sRail;
			
			player addItemToVest _mmgA;
			
			player addBackpack _bagS;
			
		};
	case "B_support_AMG_F":
		{
			
			for "_i" from 1 to 8 do { player addItemToVest _rifleA; };
			
			player addWeapon _rifle;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			
			for "_i" from 1 to 2 do { player addItemToVest _sidearmA; };
			player addWeapon _sidearm;
			
			player addWeapon "Binocular";
			
			player addBackpack _bagS;
			for "_i" from 1 to 3 do { player addItemToBackpack _mmgA; };
			
			
			
		};
	case "B_medic_F":
		{
				
			for "_i" from 1 to 8 do { player addItemToVest _rifleA; };
			
			player addWeapon _rifle;
			player addPrimaryWeaponItem _rifleB;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			
			for "_i" from 1 to 2 do { player addItemToVest _sidearmA; };
			player addWeapon _sidearm;
			
			player addBackpack _bagS;	
			for "_i" from 1 to 40 do {player addItemToBackpack "ACE_fieldDressing";};
			for "_i" from 1 to 12 do {player addItemToBackpack "ACE_epinephrine";};
			for "_i" from 1 to 18 do {player addItemToBackpack "ACE_morphine";};
		
		};
	case "B_Soldier_A_F":
		{
				
			for "_i" from 1 to 10 do { player addItemToVest _rifleA; };
			
			player addWeapon _rifle;
			player addPrimaryWeaponItem _rifleB;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			
			for "_i" from 1 to 2 do { player addItemToVest _sidearmA; };
			player addWeapon _sidearm;
			
			player addBackpack _bagL;
			for "_i" from 1 to 2 do {player addItemToBackpack _matA;};
		
		};
	case "B_soldier_LAT_F":
		{
				
			for "_i" from 1 to 8 do { player addItemToVest _rifleA; };
			
			player addBackpack _bagS;
			player addItemToBackpack _matA;
			
			player addWeapon _rifle;
			player addPrimaryWeaponItem _rifleB;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			player addWeapon _mat;
			
			for "_i" from 1 to 2 do { player addItemToVest _sidearmA; };
			player addWeapon _sidearm;
			
			player addBackpack _bagL;
			
			player addItemToBackpack _matA;
		
		};
	case "B_Soldier_F":
		{
			
			for "_i" from 1 to 10 do { player addItemToVest _rifleA; };
			
			player addWeapon _rifleVar;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			player addPrimaryWeaponItem _rifleB;
			
			for "_i" from 1 to 2 do { player addItemToVest _sidearmA; };
			player addWeapon _sidearm;
			
			player addBackpack _bagL;
			player addItemToBackpack "ACE_Clacker";
			player addItemToBackpack "SatchelCharge_Remote_Mag";
		};
	default
		{
			
			for "_i" from 1 to 14 do { player addItemToVest _rifleA; };
			player addWeapon _rifle;
			player addPrimaryWeaponItem _sRail;
			player addPrimaryWeaponItem _tRail;
			player addPrimaryWeaponItem _rifleB;
			
			player addWeapon _sidearm;
			for "_i" from 1 to 2 do { player addItemToVest _sidearmA; };
			
			player addBackpack _bagS;
			for "_i" from 1 to 6 do {player addItemToBackpack _rifleA;};
			
			player addBackpack _bagS;
		
		};
};

player addGoggles _glasses;