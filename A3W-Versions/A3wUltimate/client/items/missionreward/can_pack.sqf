//@file Version: 1.0
//@file Name: can_pack.sqf
//@file Author: MercyfulFate (modified by [KTTT] Randleman)
//@file Description: Check if you can pack the Missionreward
//@file Argument: [_missionrewardgrab] the (object that is a) Missionreward to check if its packable
//@file Argument: [] automatically find the closest Missionreward to check.

#define ERR_NO_TARGET "You are not close enough to any Missionreward"
#define ERR_TOO_FAR_AWAY "You are too far away from the Missionreward"
#define ERR_ALREADY_HAVE "You can not carry any more Missionrewards"
private ["_missionrewardgrab", "_error"];
_missionrewardgrab = objNull;

if (count _this == 0) then {
	_missionrewardgrab = [] call mf_items_mission_reward_nearest;
} else {
	_missionrewardgrab = _this select 0;
};

_error = "";
switch (true) do {
	case (!alive player): {_error = " "}; // Player is dead, no need for a error message
	case (player distance _missionrewardgrab > 5): {_error = ERR_TOO_FAR_AWAY};
	case (MF_ITEMS_MISSION_REWARD call mf_inventory_is_full): {_error = ERR_ALREADY_HAVE};
};
_error;