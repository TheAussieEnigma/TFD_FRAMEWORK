#include "missionSettings.hpp"

// Saving disabled without autosave.
enableSaving [false,false];

//Disable AI radio calls
enableSentences false;

// Briefing
nul = [] execVM "scripts\briefing.sqf";