TF_give_personal_radio_to_regular_soldier = true;
publicVariable "TF_give_personal_radio_to_regular_soldier";

tf_same_sw_frequencies_for_side = true;
publicVariable "tf_same_sw_frequencies_for_side";

//Set SW frequencies for West
_settingsSwest = false call TFAR_fnc_generateSwSettings;
_settingsSwest set [2, ["311","312","313","314","315","316","317","318"]];
tf_freq_west = _settingsSWest;
publicVariable "tf_freq_west";
//Set LR frequencies for West
_settingsLRwest = false call TFAR_fnc_generateLRSettings;
_settingsLRwest set [2, ["50","51","52","53","54","55","56","57","58"]]; 
tf_freq_west_lr = _settingsLRwest; 
publicVariable "tf_freq_west_lr";

//Set SW frequencies for East
_settingsSweast = false call TFAR_fnc_generateSwSettings;
_settingsSweast set [2, ["311","312","313","314","315","316","317","318"]];
tf_freq_east = _settingsSwEast;
publicVariable "tf_freq_east";
//Set LR frequencies for East
_settingsLReast = false call TFAR_fnc_generateLRSettings;
_settingsLReast set [2, ["50","51","52","53","54","55","56","57","58"]]; 
tf_freq_east_lr = _settingsLReast;
publicVariable "tf_freq_east_lr";

//Set SW frequencies for Independent
_settingsSwguer = false call TFAR_fnc_generateSwSettings;
_settingsSwguer set [2, ["311","312","313","314","315","316","317","318"]];
tf_freq_guer = _settingsSwguer;
publicVariable "tf_freq_guer";
//Set LR frequencies for Independent
_settingsLRguer = false call TFAR_fnc_generateLRSettings;
_settingsLRguer set [2, ["50","51","52","53","54","55","56","57","58"]];
tf_freq_guer_lr = _settingsLRguer;
publicVariable "tf_freq_guer_lr";