#include "missionSettings.hpp"
[ TFD_ORBAT ] call TFD_fnc_assignGroup;

// Saving disabled without autosave.
enableSaving [false,false];

//Disable AI radio calls
enableSentences false;

// Briefing
nul = [] execVM "scripts\briefing.sqf";

//[ 0.1 , 0.05 ] call TFD_fnc_automaticMarkers;

//[ 0.75 , 0.75 ] call TFD_fnc_customUnitTraits;