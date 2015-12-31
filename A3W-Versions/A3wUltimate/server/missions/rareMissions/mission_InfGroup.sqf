// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_InfGroup.sqf
//	@file Author: AgentRev, [K-TTT] Randleman
//	@file Created: 22/01/2015 23:19

if (!isServer) exitwith {};
#include "rareMissionDefines.sqf";

private ["_InfantryGroup", "_moneyAmount", "_groupsAmount", "_cash", "_nbUnits", "_moneyText"];

_setupVars =
{
	_locationsArray = MissionSpawnMarkers;
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	
};

_setupObjects =
{
	_InfantryGroup =
	[
		// Small
		[
			"Small Infantry Group", // Marker text
			24000, // Money
			(_nbUnits) - 30
		],
		// Medium
		[
			"Medium Infantry Group", // Marker text
			48000, // Money
			(_nbUnits) - 20
		],
		// Large
		[
			"Large Infantry Group", // Marker text
			72000, // Money
			(_nbUnits) - 10
		],
		// Heavy
		[
			"Heavy Infantry Group", // Marker text
			96000, // Money
			_nbUnits
		]
	]
	call BIS_fnc_selectRandom;

	_missionType = _InfantryGroup select 0;
	_moneyAmount = _InfantryGroup select 1;
	_groupsAmount = _InfantryGroup select 2;

	_moneyText = format ["$%1", [_moneyAmount] call fn_numbersText];
	
	_missionPos = markerPos _missionLocation;
	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _groupsAmount] call createCustomGroup;

	_missionHintText = format ["Take out %3 Infantry soldiers to earn <t color='%1'>%2</t>!", rareMissionColor, _moneyText, _groupsAmount];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	
};

_successExec =
{
	// Mission completed

	for "_i" from 1 to 12 do
	{
		_cash = createVehicle ["Land_Money_F", _lastPos, [], 5, "None"];
		_cash setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", _moneyAmount / 12, true];
		_cash setVariable ["owner", "world", true];
	};

	_successHintMessage = "Well done, the money is yours.";
};

_this call rareMissionProcessor;
