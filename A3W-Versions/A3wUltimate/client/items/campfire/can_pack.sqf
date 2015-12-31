//@file Version: 1.0
//@file Name: can_pack.sqf
//@file Author: MercyfulFate (modified by [KTTT] Randleman)
//@file Description: Check if you can pack the Campfire
//@file Argument: [_campfiregrab] the (object that is a) Campfire to check if its packable
//@file Argument: [] automatically find the closest Campfire to check.

#define ERR_NO_TARGET "You are not close enough to any Campfire"
#define ERR_TOO_FAR_AWAY "You are too far away from the Campfire"
#define ERR_ALREADY_HAVE "You can not carry any more Campfires"
private ["_campfiregrab", "_error"];
_campfiregrab = objNull;

if (count _this == 0) then {
	_campfiregrab = [] call mf_items_camp_fire_nearest;
} else {
	_campfiregrab = _this select 0;
};

_error = "";
switch (true) do {
	case (!alive player): {_error = " "}; // Player is dead, no need for a error message
	case (player distance _campfiregrab > 5): {_error = ERR_TOO_FAR_AWAY};
	case (MF_ITEMS_CAMP_FIRE call mf_inventory_is_full): {_error = ERR_ALREADY_HAVE};
};
_error;