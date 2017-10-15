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

_nul = [] spawn {
	tf_same_lr_frequencies_for_side = true;
	publicVariable "tf_same_lr_frequencies_for_side";

	//Set LR frequencies                        
	tf_freq_west_lr set [2, ["50","51","52","53","54","55","56","57","58"]]; 
	publicVariable "tf_freq_west_lr";
    
	tf_freq_east_lr set [2, ["50","51","52","53","54","55","56","57","58"]]; 
	publicVariable "tf_freq_east_lr";

	tf_freq_guer_lr set [2, ["50","51","52","53","54","55","56","57","58"]]; 
	publicVariable "tf_freq_guer_lr";
	
	TFD_CHANNEL_BLOCKS = [
		[], //Leave this blank so people dont have to worry about zero point indexing when organising the orbat
		["311","312","313","314","315","316","317","318"],
		["321","322","323","324","325","326","327","328"],
		["331","332","333","334","335","336","337","338"],
		["341","342","343","344","345","346","347","348"]
	];
};
GroupLeaderAlternateChannel = false;
publicVariable "GroupLeaderAlternateChannel";

_diagnostics = ("RunDiagnostics" call BIS_fnc_getParamValue);
if ( _diagnostics > 0) then {
	[_diagnostics] execVM "scripts\diagnosticsTest.sqf";
};