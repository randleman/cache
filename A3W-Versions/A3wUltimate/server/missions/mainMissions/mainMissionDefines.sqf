// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mainMissionDefines.sqf
//	@file Author: [404] Deadbeat, AgentRev
//	@file Created: 08/12/2012 15:19

// Main Mission Color = #52bf90 - Light blue
// Fail Mission Color = #FF1717 - Light red
// Success Mission Color = #17FF41 - Light green

#define mainMissionColor "#00ABCD"
#define failMissionColor "#CC0000"
#define successMissionColor "#00CD00"
#define subTextColor "#E1E1E1"

#define AI_GROUP_SMALL 12
#define AI_GROUP_MEDIUM 24
#define AI_GROUP_LARGE 36

#define missionDifficultyHard (["A3W_missionsDifficulty", 0] call getPublicVar >= 1)
