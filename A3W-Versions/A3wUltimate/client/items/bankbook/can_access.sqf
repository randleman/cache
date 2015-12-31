#define ERR_IN_VEHICLE "Can't do that while in a vehicle"
#define ERR_TOO_FAR "You are too far away"


private ["_bankbook", "_error"];
_bankbook = objNull;
if (count _this > 0) then {
	_bankbook = _this select 0;
} else {
	_bankbook = [] call mf_items_bankbook_nearest;
};

_error = "failed";
switch (true) do {
	case (player distance _bankbook > 5): {_error = ERR_TOO_FAR};
	case (!alive player): {}; // caller is dead, no need for error message
	case (vehicle player != player): {_error = ERR_IN_VEHICLE};
	default {_error = ""};
};
_error
