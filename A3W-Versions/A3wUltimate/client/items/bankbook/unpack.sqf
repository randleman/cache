//@file Version: 1.0
//@file Name: unpack.sqf
//@file Author: MercyfulFate (modified by [KTTT] Randleman)
//@file Description: Unpack a Bankbook from your inventory

#define ANIM "AinvPknlMstpSlayWrflDnon_medic"
#define DURATION 3
#define ERR_NO_BB "Unpacking Bankbook Failed. You have not Bankbook to unpack"
#define ERR_IN_VEHICLE "Unpacking Bankbook Failed. You can't do this in a vehicle."
#define ERR_CANCELLED "Unpacking Bankbook Cancelled"

private ["_bankbookgrab", "_error", "_hasFailed", "_success", "_pos"];

if (MF_ITEMS_BANKBOOK call mf_inventory_count <= 0) exitWith {
    [ERR_NO_BB,5] call mf_notify_client;
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
		case (MF_ITEMS_BANKBOOK call mf_inventory_count <= 0): {_text = ERR_NO_BB};
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED};
		default {
			_text = format["Bankbook %1%2 Unpacked", round(_progress*100), "%"];
			_failed = false;
        };
    };
    [_failed, _text];
};

_success = [DURATION, ANIM, _hasFailed, [getPosATL player]] call a3w_actions_start;

if (_success) then {
	_bankbookgrab = createVehicle [MF_ITEMS_BANKBOOK_TYPE, [player, [0,1.5,0]] call relativePos, [], 0, "CAN_COLLIDE"];
	_bankbookgrab setDir (getDir player + 180);
    ["You successfully unpacked the Bankbook", 5] call mf_notify_client;
};
_success


