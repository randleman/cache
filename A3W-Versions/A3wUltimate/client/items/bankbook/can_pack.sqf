//@file Version: 1.0
//@file Name: can_pack.sqf
//@file Author: MercyfulFate (modified by [KTTT] Randleman)
//@file Description: Check if you can pack the Bankbook
//@file Argument: [_bankbookgrab] the (object that is a) Bankbook to check if its packable
//@file Argument: [] automatically find the closest Bankbook to check.

#define ERR_NO_TARGET "You are not close enough to any Bankbook"
#define ERR_TOO_FAR_AWAY "You are too far away from the Bankbook"
#define ERR_ALREADY_HAVE "You can not carry any more Bankbooks"
private ["_bankbookgrab", "_error"];
_bankbookgrab = objNull;

if (count _this == 0) then {
	_bankbookgrab = [] call mf_items_bankbook_nearest;
} else {
	_bankbookgrab = _this select 0;
};

_error = "";
switch (true) do {
	case (!alive player): {_error = " "}; // Player is dead, no need for a error message
	case (player distance _bankbookgrab > 5): {_error = ERR_TOO_FAR_AWAY};
	case (MF_ITEMS_BANKBOOK call mf_inventory_is_full): {_error = ERR_ALREADY_HAVE};
};
_error;