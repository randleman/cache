//@file Version: 1.1
//@file Name: pack.sqf
//@file Author: MercyfulFate (modified by [KTTT] Randleman)
//@file Description: Pack the nearest Bankbook
//@file Argument: [player, player, _action, []] the standard "called by an action" values

#include "mutex.sqf"
#define ANIM "AinvPknlMstpSlayWrflDnon_medic"
#define DURATION 3
#define ERR_TOO_FAR_AWAY "Packing Bankbook Failed. You moved too far away"
#define ERR_ALREADY_TAKEN "Packing Bankbook Failed. Someone else beat you to it."
#define ERR_IN_VEHICLE "Packing Bankbook Failed. You can't do this in a vehicle."
#define ERR_CANCELLED "Packing Bankbook Cancelled"

private ["_error", "_hasFailed", "_success"];
_bankbookgrab = [] call mf_items_bankbook_nearest;
_error = [_bankbookgrab] call mf_items_bankbook_can_pack;
if (_error != "") exitWith {[_error, 5] call mf_notify_client};

_hasFailed = {
	private ["_progress", "_bankbookgrab", "_caller", "_failed", "_text"];
	_progress = _this select 0;
	_bankbookgrab = _this select 1;
	_text = "";
	_failed = true;
	switch (true) do {
		case (!alive player): {}; // player dead, no error msg needed
        case (isNull _bankbookgrab): {_text = ERR_ALREADY_TAKEN}; //someone has already taken it.
		case (vehicle player != player): {_text = ERR_IN_VEHICLE};
		case (player distance _bankbookgrab > 5): {_text = ERR_TOO_FAR_AWAY};
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED};
		default {
			_text = format["Bankbook %1%2 Packed", round(_progress*100), "%"];
			_failed = false;
        };
    };
    [_failed, _text];
};

MUTEX_LOCK_OR_FAIL;
_success =  [DURATION, ANIM, _hasFailed, [_bankbookgrab]] call a3w_actions_start;
MUTEX_UNLOCK;
    
if (_success) then {
    deleteVehicle _bankbookgrab;
	[MF_ITEMS_BANKBOOK, 1] call mf_inventory_add;
    ["You successfully packed the Bankbook", 5] call mf_notify_client;
};