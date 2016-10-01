[] spawn {
waitUntil { startMission };
systemChat "weapons enabled";
[ "FIRE" ] call TFD_fnc_weaponSafety; 
};

_spacer = parseText "<br/><t size='2'>--------------------------</t><br/>";
_text = parseText "
	The briefing is in progress.<br/><br/>
	Please be patient.<br/><br/>
	Group leaders to the briefing area.
	";
_hint = composeText [ _spacer , _text , _spacer ];

while { !( startMission ) } do { 

	hintSilent _hint;
	sleep 300;
	
};

