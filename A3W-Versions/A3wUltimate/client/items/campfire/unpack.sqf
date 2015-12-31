//@file Version: 1.0
//@file Name: unpack.sqf
//@file Author: MercyfulFate (modified by [KTTT] Randleman)
//@file Description: Unpack a Campfire from your inventory

#define ANIM "AinvPknlMstpSlayWrflDnon_medic"
#define DURATION 5
#define ERR_NO_CF "Unpacking Campfire Failed. You have no Campfire to unpack"
#define ERR_IN_VEHICLE "Unpacking Campfire Failed. You can't do this in a vehicle."
#define ERR_CANCELLED "Unpacking Campfire Cancelled"

private ["_campfiregrab", "_error", "_hasFailed", "_success", "_pos"];

if (MF_ITEMS_CAMP_FIRE call mf_inventory_count <= 0) exitWith {
    [ERR_NO_CF,5] call mf_notify_client;
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
		case (MF_ITEMS_CAMP_FIRE call mf_inventory_count <= 0): {_text = ERR_NO_CF};
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED};
		default {
			_text = format["Campfire %1%2 Unpacked", round(_progress*100), "%"];
			_failed = false;
        };
    };
    [_failed, _text];
};

_success =  [DURATION, ANIM, _hasFailed, []] call a3w_actions_start;
    
if (_success) then {
	_pos = getPosATL player;
	_campfiregrab = MF_ITEMS_CAMP_FIRE_TYPE createVehicle _pos;
    _campfiregrab setPosATL _pos;
    ["You successfully unpacked the Campfire", 5] call mf_notify_client;
};
_success