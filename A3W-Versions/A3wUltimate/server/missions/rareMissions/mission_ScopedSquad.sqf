// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_ScopedSquad.sqf
//	@file Author: [K-TTT] Randleman
//	@file Created: 06/02/2015 12:19

if (!isServer) exitwith {};
#include "rareMissionDefines.sqf";

private ["_ScopedSquad", "_moneyAmount", "_groupsAmount", "_cash", "_nbUnits", "_moneyText"];

_setupVars =
{
	_locationsArray = ScopedMissionMarkers;
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	
};

_setupObjects =
{
	_ScopedSquad =
	[
		// Small
		[
			"Small Sniper Squad", // Marker text
			24000, // Money
			(_nbUnits) - 12
		],
		// Medium
		[
			"Medium Sniper Squad", // Marker text
			48000, // Money
			(_nbUnits) - 12
		],
		// Large
		[
			"Large Sniper Squad", // Marker text
			72000, // Money
			(_nbUnits) - 12
		],
		// Heavy
		[
			"Heavy Sniper Squad", // Marker text
			96000, // Money
			(_nbUnits) - 12
		]
	]
	call BIS_fnc_selectRandom;

	_missionType = _ScopedSquad select 0;
	_moneyAmount = _ScopedSquad select 1;
	_groupsAmount = _ScopedSquad select 2;

	_moneyText = format ["$%1", [_moneyAmount] call fn_numbersText];
	
	_missionPos = markerPos _missionLocation;
	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _groupsAmount] call createScopedGroup;

	_missionHintText = format ["Take out <t color='%1'>%3</t> Snipers to earn <t color='%1'>%2</t>!", rareMissionColor, _moneyText, _groupsAmount];
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
