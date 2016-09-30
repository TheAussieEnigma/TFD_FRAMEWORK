//////////////////////////////
//    Dynamic-AI-Creator    //
//    Version 3.1b - 2014   //
//--------------------------//
//    DAC_Config_Creator    //
//--------------------------//
//    Script by Silola      //
//    silola@freenet.de     //
//////////////////////////////

_scr = [] spawn (compile preprocessFile "DAC\Scripts\DAC_Preprocess.sqf");
waituntil { scriptdone _scr };

scalar = "any"; DAC_Init_Camps = 0;

waituntil { time > 0.3 };

if (isServer || (name player == HCName)) then {if(local player) then { DAC_Code = 1 } else { DAC_Code = 0 } } else { if (isnull player) then { DAC_Code = 3 } else { DAC_Code = 2 } };

//===============|
// DAC_Settings	 |
//===============|=============================================================================================|

	if(isNil "DAC_STRPlayers")		then {		DAC_STRPlayers			= ["s1","s2","s3","s4","s5","s6","s7","s8","s9","s10","s11","s12","s13","s14","s15","s16","s17","s18","s19","s20","s21","s22","s23","s24","s25","s26","s27","s28","s29","s30","s31","s32","s33","s34","s35","s36","s37","s38","s39","s40","s41","s42","s43","s44","s45","s46","s47","s48","s49","s50","s51","s52","s53","s54","s55","s56","s57","s58","59","s60"]};
	if(isNil "DAC_AI_Count_Level")	then {		DAC_AI_Count_Level  	= [[1,3],[3,6],[4,8],[10,12],[1,0]]		};
	if(isNil "DAC_Dyn_Weather") 	then {		DAC_Dyn_Weather			= [0, 0, 0, [0,0,0], 0]					};
	if(isNil "DAC_Reduce_Value") 	then {		DAC_Reduce_Value		= [800, 850, 0.3]						};
	if(isNil "DAC_AI_Spawn") 		then {		DAC_AI_Spawn			= [[10,5,5],[10,5,15],0,120,250,0]		};
	if(isNil "DAC_Delete_Value") 	then {		DAC_Delete_Value		= [[180,150],[180,150],6000]			};
	if(isNil "DAC_Del_PlayerBody") 	then {		DAC_Del_PlayerBody		= [0,0]									};
	if(isNil "DAC_Com_Values") 		then {		DAC_Com_Values			= [1,2,0,0]								}; //Set to 0,0,0,0 to turn on Dac Init overlay
	if(isNil "DAC_AI_AddOn") 		then {		DAC_AI_AddOn			= 1										};
	if(isNil "DAC_AI_Level") 		then {		DAC_AI_Level			= 4										};
	if(isNil "DAC_Res_Side") 		then {		DAC_Res_Side			= 0										};
	if(isNil "DAC_Marker") 			then {		DAC_Marker				= 0										}; //Set to 0 to turn off Dac Markers
	if(isNil "DAC_WP_Speed") 		then {		DAC_WP_Speed			= 0.025									};
	if(isNil "DAC_Join_Action")		then {		DAC_Join_Action			= false									};
	if(isNil "DAC_Fast_Init") 		then {		DAC_Fast_Init			= false									};
	if(isNil "DAC_Player_Marker")	then {		DAC_Player_Marker		= false									};
	if(isNil "DAC_Direct_Start")	then {		DAC_Direct_Start		= false									};
	if(isNil "DAC_Activate_Sound")	then {		DAC_Activate_Sound		= false									};
	if(isNil "DAC_Auto_UnitCount")	then {		DAC_Auto_UnitCount		= [14,3]								};
	if(isNil "DAC_Player_Support")	then {		DAC_Player_Support		= [10,[4,2000,3,1000]]					};
	if(isNil "DAC_SaveDistance")	then {		DAC_SaveDistance		= [500,["DAC_Save_Pos"]]				};
	if(isNil "DAC_Radio_Max")		then {		DAC_Radio_Max			= DAC_AI_Level						};
		
	DAC_BadBuildings 		= 	[];
	DAC_GunNotAllowed		= 	[];
	DAC_VehNotAllowed		= 	[];
	DAC_Locked_Veh		=	[];
	DAC_SP_Soldiers     	=   ["B_soldier_AR_F", "B_HeavyGunner_F", "B_G_Soldier_AR_F", "rhsusf_army_ucp_autorifleman", "rhsusf_army_ocp_autorifleman", "susf_usmc_marpat_wd_autorifleman_m249", "susf_usmc_marpat_d_autorifleman_m249", "LOP_AA_Infantry_MG", "LOP_AA_Police_MG", "LOP_CDF_Infantry_MG", "LOP_IA_Infantry_MG", "O_Soldier_AR_F", "O_HeavyGunner_F", "O_G_Soldier_AR_F", "rhs_vdv_machinegunner", "rhs_vdv_flora_machinegunner", "rhs_vdv_mflora_machinegunner", "LOP_ChDKZ_Infantry_MG", "LOP_SLA_Infantry_MG", "LOP_US_Infantry_MG", "I_Soldier_AR_F", "I_G_Soldier_AR_F", "LOP_PMC_Infantry_MG", "rhs_g_Soldier_AR_F", "LOP_AFR_Infantry_AR", "LOP_AM_Infantry_AR", "LOP_ISTS_Infantry_AR", "LOP_RACS_Infantry_MG", "LOP_UA_Infantry_MG", "LOP_NAPA_Infantry_AR", "LOP_UN_Infantry_MG", "LOP_TKA_Infantry_MG"];
	DAC_Data_Array 		= 	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,[]];
	DAC_Marker_Val		= 	[];
	DAC_Zones				=	[];

	//=============================================================================================================|
	
	_scr = [] spawn (compile preprocessFile "DAC\Scripts\DAC_Start_Creator.sqf");
	waituntil { scriptdone _scr };
	sleep 0.1;
	
if (DAC_Code < 2) then
{
	//===========================================|
	// StartScriptOnServer                       |
	//===========================================|
	//player sidechat "ServerStart"
	//[] execVM "myServerScript.sqf";
	//onMapSingleClick "_fun = [_pos,_shift]execVM ""Action.sqf""";
}
else
{
	if (DAC_Code == 3) then
	{
		//===========================================|
		// StartScriptOnJipClient                    |
		//===========================================|
		//player sidechat "JipClientStart"
		//[] execVM "myJipClientScript.sqf";
	}
	else
	{
		//===========================================|
		// StartScriptOnClient                       |
		//===========================================|
		//player sidechat "ClientStart"
		//[] execVM "myClientScript.sqf";
		//onMapSingleClick "_fun = [_pos,_shift]execVM ""Action.sqf""";
	};
};