TFD_ADMINS = [
	"76561198007514110",	//Atreus
	"76561197974803128",  	//Mortified
	"76561197996594471",	//Apex
	"76561198005613267",	//Imperator
	"76561198011140335",	//Tonny747
	"76561198052511971",	// Skillet
	"76561197987496729",	//JohnnyShootos		(for testing / debugging)
	"76561198046408605"		// Jam_Toast		(for testing / debugging)
]; publicVariable "TFD_ADMINS";

nul = execVM "adminpanelmk2\fn_adminPanelInit.sqf";


[] call TFD_fnc_setTFAR;