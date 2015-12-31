// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: rareMissionController.sqf
//	@file Author: AgentRev

#define MISSION_CTRL_PVAR_LIST RareMissions
#define MISSION_CTRL_TYPE_NAME "Rare"
#define MISSION_CTRL_FOLDER "rareMissions"
#define MISSION_CTRL_DELAY (["A3W_rareMissionDelay", 45*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE rareMissionColor

#include "rareMissions\rareMissionDefines.sqf"
#include "missionController.sqf";
