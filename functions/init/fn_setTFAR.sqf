_ORBAT = _this select 0;

//Setup channel blocks - the below configuration could easily support up to 200+ players in 8 man squads
_TFD_CHANNEL_BLOCKS = [
	[], //Leave this blank so people dont have to worry about zero point indexing when organising the orbat
	["311","312","313","314","315","316","317","318"],
	["321","322","323","324","325","326","327","328"],
	["331","332","333","334","335","336","337","338"],
	["341","342","343","344","345","346","347","348"]
];

//Set SW frequencies
_settingsSW = false call TFAR_fnc_generateSwSettings;
_settingsSW set [2, _TFD_CHANNEL_BLOCKS select 1];
tf_freq_west = _settingsSW;
//Set LR frequencies
_settingsLR = false call TFAR_fnc_generateLRSettings;
_settingsLR set [2, ["50","51","52","53","54","55","56","57","58"]]; 
tf_freq_west_lr = _settingsLR;

//Assign Correct SW Channel block to variable - you will need to specify which channel block they are in by entering it in as a number after the channel number but before the unit names in TFD_ORBAT. i.e. ["Alpha", 1, 1, "s_1"]. the value must correspond to the array index in TFD_CHANNEL_BLOCK above.
{
	if ((str player) in _x && typeName (_x select 2) == "SCALAR") then {
		_settingsSW set [2, _TFD_CHANNEL_BLOCKS select (_x select 2)];
	};
	
} forEach _ORBAT;

waitUntil {[] call TFAR_fnc_haveSWRadio};

//Setup the SW channels
for "_i" from 1 to 8 do {
	_freq = _i - 1;
	[(call TFAR_fnc_activeSwRadio), _i, (_settingsSW select 2 select _freq)] call TFAR_fnc_SetChannelFrequency;
};

//Setup Long Range Channels
if (call TFAR_fnc_haveLRRadio) then {
	for "_i" from 1 to 8 do {
		_freq = _i - 1;
		[(call TFAR_fnc_activeLrRadio), _i, (_settingsLR select 2 select _freq)] call TFAR_fnc_SetChannelFrequency;
	};
};

//Set players Default channel and additional channel
{
	if ((str player) in _x) then {
		// Channels are 0 indexed so must be _channel - 1
		_channel = (_x select 1);
		[(call TFAR_fnc_activeSwRadio), _channel - 1] call TFAR_fnc_setSwChannel;
		[(call TFAR_fnc_activeSwRadio), 7] call TFAR_fnc_setAdditionalSwChannel;
	};
} forEach _ORBAT;