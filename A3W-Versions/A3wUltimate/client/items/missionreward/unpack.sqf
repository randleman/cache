//@file Version: 1.0
//@file Name: unpack.sqf
//@file Author: MercyfulFate (modified by [KTTT] Randleman)
//@file Description: Unpack a Missionreward from your inventory

#define ANIM "AmovMstpDnon_AinvMstpDnon" //"AinvPknlMstpSlayWrflDnon_medic"
#define DURATION 1
#define ERR_NO_MR "Unpacking Missionreward Failed. You have no Missionreward to unpack"
#define ERR_IN_VEHICLE "Unpacking Missionreward Failed. You can't do this in a vehicle."
#define ERR_CANCELLED "Unpacking Missionreward Cancelled"

private ["_missionrewardgrab", "_error", "_hasFailed", "_success", "_pos"];

if (MF_ITEMS_MISSION_REWARD call mf_inventory_count <= 0) exitWith {
    [ERR_NO_MR,5] call mf_notify_client;
    false;
};

_hasFailed = {
	private ["_progress", "_failed", "_text"];
	_progress = _this select 0;
	_text = "";
	_failed = true;
	switch (true) do {
		case (!alive player): {}; // player dead, no error msg needed
		case (vehicle player != player): {_text = ERR_IN_VEHICLE};
		case (MF_ITEMS_MISSION_REWARD call mf_inventory_count <= 0): {_text = ERR_NO_MR};
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED};
		default {
			_text = format["Missionreward %1%2 Unpacked", round(_progress*100), "%"];
			_failed = false;
        };
    };
    [_failed, _text];
};

_success =  [DURATION, ANIM, _hasFailed, []] call a3w_actions_start;
    
if (_success) then {
	_pos = getPosATL player;
	_missionrewardgrab = MF_ITEMS_MISSION_REWARD_TYPE createVehicle _pos;
    _missionrewardgrab setPosATL _pos;
	_missionrewardgrab setVariable ["mf_item_id", "missionreward", true];
    ["You successfully unpacked the Missionreward", 5] call mf_notify_client;
};
_success