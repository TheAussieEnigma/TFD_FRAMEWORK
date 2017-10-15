_ORBAT = _this select 0;

//Setup channel blocks - the below configuration could easily support up to 200+ players in 8 man squads. look in initServer.sqf for freqs

_settingsSW = false call TFAR_fnc_generateSwSettings;
_settingsLR = tf_freq_west_lr;
//Assign Correct SW Channel block to variable - you will need to specify which channel block they are in by entering it in as a number after the channel number but before the unit names in TFD_ORBAT. i.e. ["Alpha", 1, 1, "s_1"]. the value must correspond to the array index in TFD_CHANNEL_BLOCK above.
{
	if ((str player) in _x && typeName (_x select 2) == "SCALAR") exitWith {
		_settingsSW set [2, TFD_CHANNEL_BLOCKS select (_x select 2)];
		CurrentRadioBlock = (_x select 2);
	};
	CurrentRadioBlock = -1; //disables ace interaction menu radio block switching
} forEach _ORBAT;

waitUntil {[] call TFAR_fnc_haveSWRadio};

//Setup the SW channels
[(call TFAR_fnc_activeSwRadio), _settingsSW] call TFAR_fnc_setSwSettings;

//Setup Long Range Channels
if (call TFAR_fnc_haveLRRadio) then {
	[(call TFAR_fnc_activeLrRadio) select 0, (call TFAR_fnc_activeLrRadio) select 1, _settingsLR] call TFAR_fnc_setLrSettings;
};

//Set players Default channel and additional channel
{
	if ((str player) in _x) exitWith {
		// Channels are 0 indexed so must be _channel - 1
		_channel = (_x select 1);
		[(call TFAR_fnc_activeSwRadio), _channel - 1] call TFAR_fnc_setSwChannel;
		if ((leader group player == player) && GroupLeaderAlternateChannel) then {
		[(call TFAR_fnc_activeSwRadio), 7] call TFAR_fnc_setAdditionalSwChannel;
		};
	};
} forEach _ORBAT;
//aussie stuff
if (CurrentRadioBlock == -1) exitwith {};
_Action = ["Radio","Radio","",{a=a+1;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _Action] call ace_interact_menu_fnc_addActionToObject;
count_b = (count TFD_CHANNEL_BLOCKS) - 1;
_conditionUp = {
   !(CurrentRadioBlock >= count_b);
};
_statementUp = {
	Hint "test up";
	CurrentRadioBlock = 1 + CurrentRadioBlock;
    _setting = (call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwSettings;
	_setting set [2, TFD_CHANNEL_BLOCKS select CurrentRadioBlock];
	[(call TFAR_fnc_activeSwRadio), _setting] call TFAR_fnc_setSwSettings;
};
_ActionUp = ["radio block up","Move a radio block up","",_statementUp,_conditionUp] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "Radio"], _ActionUp] call ace_interact_menu_fnc_addActionToObject;
_conditionDown = {
   !(CurrentRadioBlock <= 1);
};
_statementDown = {
	Hint "test down";
	CurrentRadioBlock = CurrentRadioBlock - 1;
    _setting = (call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwSettings;
	_setting set [2, TFD_CHANNEL_BLOCKS select CurrentRadioBlock];
	[(call TFAR_fnc_activeSwRadio), _setting] call TFAR_fnc_setSwSettings;
};
_ActionDown = ["radio block down","Move a radio block down","",_statementDown,_conditionDown] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "Radio"], _ActionDown] call ace_interact_menu_fnc_addActionToObject;