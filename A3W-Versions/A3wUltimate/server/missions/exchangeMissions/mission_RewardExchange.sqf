// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_RewardExchange.sqf
//	@file Author: [K-TTT] Randleman


if (!isServer) exitwith {};
#include "exchangeMissionDefines.sqf";

private ["_exObj"];

_setupVars =
{
	_missionType = "Exchange Device";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	
	_exObj = createVehicle ["Land_Device_assembled_F", _missionPos, [], 5, "None"];
	_exObj setDir random 360;

	
	_missionHintText = format ["The<br/><t color='%1'>Reward Exchange Device</t><br/>has dropped at the marker", exchangeMissionColor]
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;
_ignoreAiDeaths = true;

_failedExec =
{
	// Mission failed
	deleteVehicle _exObj;
	_failedHintMessage = " The exchange device got picked up to refill money! <br/>It will be dropped soon as possible again!";
};

_successExec =
{
	// Mission complete
	//this mission never get succeed , it should just spawn sometimes the missionreward exchange device :P
};

_this call exchangeMissionProcessor;
