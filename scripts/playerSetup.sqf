// Nothing in here needs to be changed unless you want to give someone specific access to the admin panel.
// Give Admins the Panel of Doom:
waitUntil {(!isNil "TFD_ADMINS") && (getClientStateNumber > 9)};

if !(getPlayerUID player in TFD_ADMINS) exitWith {};

nul = execVM "adminpanelmk2\fn_adminPanelInit.sqf";

(findDisplay 46) displayAddEventHandler ["keyDown",
{
    _ctrl = _this select 0; 
    _dikCode = _this select 1; 
    _shift = _this select 2; 
    _ctrlKey = _this select 3;
    _alt = _this select 4;
    _yourKey = 0xC5; // Pause Break -- https://community.bistudio.com/wiki/DIK_KeyCodes
	
	if ( getPlayerUID player == "76561198046408605" ) then {  _yourKey = 0x23 };
    
    if (_dikCode == _yourKey && (dialog)) then { 
           closeDialog 6969;
           true
     } else {
        if (_dikCode == _yourKey && !(dialog)) then { 
               createDialog "TFD_AdminPanel"; 
            true 
          };
      };
}];

//Add Start mission action to persons listed in the admin list
player addAction ["START MISSION", {[[], {missionNameSpace setVariable ["startMission", true, true]}] remoteExec ["call", 0, true]}, [], -999, false, true, "", "!(missionNameSpace getVariable ['startMission', false])"];