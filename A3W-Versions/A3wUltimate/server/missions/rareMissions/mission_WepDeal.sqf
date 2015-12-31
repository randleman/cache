// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_WepDeal.sqf 
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev, [K-TTT] Randleman
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "rareMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2", "_box3", "_box4", "_box5", "_box6", "_cash"];

_setupVars =
{
	_missionType = "Weapon Deal";
	_locationsArray = MissionSpawnMarkers;
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_box1 = createVehicle ["Box_NATO_Wps_F", [(_missionPos select 0) + 10, (_missionPos select 1) + 2, 0], [], 5, "None"];
	_box1 setDir random 360;
	[_box1, "mission_USSpecial"] call fn_refillbox;

	_box2 = createVehicle ["Box_East_Wps_F", [(_missionPos select 0) + 10, (_missionPos select 1) + 4, 0], [], 5, "None"];
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call fn_refillbox;

	_box3 = createVehicle ["Box_East_Wps_F", [(_missionPos select 0) + 10, (_missionPos select 1) + 6, 0], [], 5, "None"];
	_box3 setDir random 360;
	[_box3, "mission_Main_A3snipers"] call fn_refillbox;
	
	_box4 = createVehicle ["Box_NATO_Wps_F", [(_missionPos select 0) - 10, (_missionPos select 1) - 2, 0], [], 5, "None"];
	_box4 setDir random 360;
	[_box4, "mission_USSpecial"] call fn_refillbox;

	_box5 = createVehicle ["Box_East_Wps_F", [(_missionPos select 0) - 10, (_missionPos select 1) - 4, 0], [], 5, "None"];
	_box5 setDir random 360;
	[_box5, "mission_USLaunchers"] call fn_refillbox;

	_box6 = createVehicle ["Box_East_Wps_F", [(_missionPos select 0) - 10, (_missionPos select 1) - 6, 0], [], 5, "None"];
	_box6 setDir random 360;
	[_box6, "mission_Main_A3snipers"] call fn_refillbox;
	
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2, _box3, _box4, _box5, _box6];

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits] call createCustomGroup;

	_missionHintText = "A weapon deal has been spotted near the marker. Take out all security and the content is yours.";
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _box3, _box4, _box5, _box6];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3, _box4, _box5, _box6];
	
		for "_i" from 1 to 12 do
	{
		_cash = createVehicle ["Land_Money_F", _missionPos, [], 5, "None"];
		_cash setPos ([_missionPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", 48000 / 12, true];
		_cash setVariable ["owner", "world", true];
	};

	_successHintMessage = "Deal cancelled, well done! <br/>The weapon crates an Money are yours.";
};

_this call rareMissionProcessor;
