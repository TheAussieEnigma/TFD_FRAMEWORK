_spacer = parseText "<br/><t size='2'>--------------------------</t><br/>";
_text = parseText "<t color='#ff0000'>
	The briefing is in progress.<br/><br/>
	Please be patient.<br/><br/>
	Group leaders to the briefing area.
	</t>";
_hint = composeText [ _spacer , _text , _spacer ];

waitUntil { 
	hintSilent _hint;
	startMission 
};

[ "FIRE" ] call TFD_fnc_weaponSafety; 

_text = parseText "<t color='#ffff00'>
	The briefing phase is now over. <br/><br/>
	Your weapons are now unrestricted. <br/><br/>
	Good Luck, Have Fun.
</t>";

_hint = composeText [ _spacer , _text , _spacer ];
hint "";
[_hint,0,0,4,0.25,0] spawn BIS_fnc_dynamicText;