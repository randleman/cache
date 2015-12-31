// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: can_access.sqf
//	@file Author: AgentRev, [K-TTT] Randleman
//	@file Function: mf_items_missionrewardexchange_can_access

#define ERR_IN_VEHICLE "Can't do that while in a vehicle"
#define ERR_TOO_FAR "You are too far away"

private ["_missionrewardexchangePlace", "_error"];

_missionrewardexchangePlace = call mf_items_missionrewardexchange_nearest;
_error = "failed";

switch (true) do
{
	case (isNull _missionrewardexchangePlace): {};
	case (!alive player): {};

	case (player distance _missionrewardexchangePlace > 10): {_error = ERR_TOO_FAR};
	case (vehicle player != player): {_error = ERR_IN_VEHICLE};

	default {_error = ""};
};

_error
