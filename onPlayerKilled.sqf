/*
End Game Spectator cam is best spectator cam.

params = 	the player, 
			whitelisted sides (ALL if empty), 
			allow spectating AI, 
			enable free camera, 
			enable 3PP camera
*/
["Initialize", [player,[],true,true,true]] call BIS_fnc_EGSpectator;