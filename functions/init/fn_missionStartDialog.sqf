waitUntil {[] call TFAR_fnc_haveSWRadio};
sleep 1;
_ORBAT = _this select 0;

//Return the player that is in the topmost slot as the mission commander
_missionCommander = [] call {
	_commander = objnull;
	_check = true;
	_itr = 1;
	while {_check} do {
		if !(isNil (format ["s_%1",_itr])) then {
		_commander = [] call compile format ["missionNamespace getVariable 's_%1'",_itr];
		_check = false;
		} else { 
			_itr = _itr + 1; //If no player found on this iteration increment iterator for next loop
		};
	};
	_commander
};

systemChat name _missionCommander;

{
	if (str player in _x) then {

		_channel = (_x select 1);
		_channelBlock = (_x select 2);

		"Mission Settings and Signals" hintC [
			if (_missionCommander == player) then {
				"You are the mission commander!"
			} else {
			format ["The Mission Commander is: %1", name _missionCommander];
			},
			format [ "You are in group %1." , (_x select 0)],
			if ( leader group player == player ) then {
				"You are the leader of your group, please report in for briefing.";
			} else {
				format[ "Your group leader is %1, please wait for briefing." , (name leader group player) ];
			},
			format [ "Your SW Channel Block is: Block %1", _channelBlock],
			format [ "SW Block %1 Freqs: %2", _channelBlock, ((call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwSettings) select 2 select [0,8]],
			format [ "Your squad's channel is: Channel %1. (3%2%1)" , _channel, _channelBlock],
			format [ "Your Platoon Net Alt channel is: Channel %3 (3%2%3)" , _channel, _channelBlock, 8],
			format [ "Company Command Net is LR channel 1. (%1)", (tf_freq_west_lr select 2) select 0] //Edit here if neccessary to define LR channels.
		];
	};
} forEach _ORBAT;

