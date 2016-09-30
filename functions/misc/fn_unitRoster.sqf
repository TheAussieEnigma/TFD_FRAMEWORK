/*
* Author: Jam Toast
* Modified: 4/09/2016
*
* Creates hint and diary record for radio channel and squad role information.
* 
*
* Arguments:
*	NONE
*
* Return Value:
* Nil
*
* Example:
* [ TFD_ORBAT ] call TFD_fnc_unitRoster;
*
*/

sleep 20;

player createDiarySubject [ "roster" , "ORBAT & Signal" ];

_glist = [];
_gList = _glist + TFD_ORBAT;
reverse _gList;

player createDiaryRecord [ "roster" ,
							[ "LR Channels" ,
								"Platoon Net ~ Ch 1" ]];

{

	player createDiaryRecord [ "roster" ,
								[ "SR Channels" ,
									format[ "%1 ~ Ch %2" , (_x select 0) , (_x select 1) ]]];

} forEach _gList;

_ar = playableUnits;
reverse _ar;

{

_g = format[ "%1" , groupID group _x ];
_n = name _x;
_r =  roleDescription player;

if (player diarySubjectExists _g) then {

		player createDiaryRecord [ "roster" ,
			[ _g ,
					format["%1: <marker name=''>%2</marker><br/>", _n , _r ] 
			]];
			
		} else {
		
		player createDiarySubject [ "roster" , _g ];
		
		player createDiaryRecord [ "roster" ,
			[ _g ,
					format["%1: <marker name=''>%2</marker><br/>", _n , _r ] 
			]];
			
		};
} forEach _ar;