// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: exchangeMissionProcessor.sqf
//	@file Author: AgentRev

#define MISSION_PROC_TYPE_NAME "Exchange"
#define MISSION_PROC_TIMEOUT (["A3W_exchangeMissionTimeout", 60*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE exchangeMissionColor

#include "exchangeMissions\exchangeMissionDefines.sqf"
#include "missionProcessor.sqf";
