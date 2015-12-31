// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: moneyMissionController.sqf
//	@file Author: His_Shadow
//	@file Created: 07/09/2013 15:19

#define moneyMissionColor "#CDCD00"
#define failMissionColor "#CC0000"
#define successMissionColor "#00CD00"
#define subTextColor "#E1E1E1"

#define AI_GROUP_SMALL 12
#define AI_GROUP_MEDIUM 24
#define AI_GROUP_LARGE 36

#define missionDifficultyHard (["A3W_missionsDifficulty", 0] call getPublicVar >= 1)
