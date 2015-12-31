//@file Version: 1.0
//@file Name: pack.sqf
//@file Author: MercyfulFate (modified by [KTTT] Randleman)
//@file Description: Pack the nearest missionreward
//@file Argument: [player, player, _action, []] the standard "called by an action" values

#include "mutex.sqf"
#define ANIM "AmovMstpDnon_AinvMstpDnon"//"AinvPknlMstpSlayWrflDnon_medic"
#define DURATION 1
#define ERR_TOO_FAR_AWAY "Packing Missionreward Failed. You moved too far away"
#define ERR_ALREADY_TAKEN "Packing Missionreward Failed. Someone else beat you to it."
#define ERR_IN_VEHICLE "Packing Missionreward Failed. You can't do this in a vehicle."
#define ERR_CANCELLED "Packing Missionreward Cancelled"

private ["_beacon", "_error", "_hasFailed", "_success"];
_missionrewardgrab = [] call mf_items_mission_reward_nearest;
_error = [_missionrewardgrab] call mf_items_mission_reward_can_pack;
if (_error != "") exitWith {[_error, 5] call mf_notify_client};

_hasFailed = {
	private ["_progress", "_missionrewardgrab", "_caller", "_failed", "_text"];
	_progress = _this select 0;
	_missionrewardgrab = _this select 1;
	_text = "";
	_failed = true;
	switch (true) do {
		case (!alive player): {}; // player dead, no error msg needed
        case (isNull _missionrewardgrab): {_text = ERR_ALREADY_TAKEN}; //someone has already taken it.
		case (vehicle player != player): {_text = ERR_IN_VEHICLE};
		case (player distance _missionrewardgrab > 5): {_text = ERR_TOO_FAR_AWAY};
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED};
		default {
			_text = format["Missionreward %1%2 Packed", round(_progress*100), "%"];
			_failed = false;
        };
    };
    [_failed, _text];
};

MUTEX_LOCK_OR_FAIL;
_success =  [DURATION, ANIM, _hasFailed, [_missionrewardgrab]] call a3w_actions_start;
MUTEX_UNLOCK;
    
if (_success) then {
    deleteVehicle _missionrewardgrab;
	[MF_ITEMS_MISSION_REWARD, 1] call mf_inventory_add;
    ["You successfully packed the missionreward", 5] call mf_notify_client;
};