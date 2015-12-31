// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.1
//	@file Name: mission_Artillery.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev, [K-TTT] Randleman
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "rareMissionDefines.sqf"

private ["_nbUnits", "_vehicleClass", "_vehicle"];

_setupVars =
{
	_missionType = "Artillery Tank";
	_locationsArray = MissionSpawnMarkers;
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_vehicleClass =
	[
		"B_MBT_01_arty_F",
		"O_MBT_02_arty_F"
	] call BIS_fnc_selectRandom;

	// Class, Position, Fuel, Ammo, Damage, Special
	_vehicle = [_vehicleClass, _missionPos] call createMissionVehicle;
	_vehicle allowDamage true;

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, [(_missionPos select 0) + 50, (_missionPos select 1),0], _nbUnits] call createCustomGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "displayName");

	_missionHintText = format ["A <t color='%2'>%1</t> has been spotted with huge amount of security, try to get it for your team.", _vehicleName, rareMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {!alive _vehicle};

_failedExec =
{
	// Mission failed
	deleteVehicle _vehicle;
};

_successExec =
{
	// Mission completed
	_vehicle lock 1;
	_vehicle setVariable ["R3F_LOG_disabled", false, true];
	
	for "_i" from 1 to 12 do
	{
		_cash = createVehicle ["Land_Money_F", _missionPos, [], 5, "None"];
		_cash setPos ([_missionPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", 1200 / 12, true];
		_cash setVariable ["owner", "world", true];
	};

	_successHintMessage = "The artillery tank has been captured, well done!";
};

_this call rareMissionProcessor;
