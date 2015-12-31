//@file Version: 1.2
//@file Name: init.sqf
//@file Author: MercyfulFate (modified by [KTTT] Randleman)
//@file Description: Initialize Bankbook
//@file Argument: the path to the directory holding this file.

private ["_path","_ground_type", "_icon", "_unpack", "_pack", "_access"];
_path = _this;

MF_ITEMS_BANKBOOK = "bankbook";
MF_ITEMS_BANKBOOK_TYPE = "Land_Laptop_unfolded_F";
_ground_type = "Land_Laptop_F";
_icon = "client\icons\take.paa";
_icon_bank = "client\icons\suatmm_icon.paa";

_pack = [_path, "pack.sqf"] call mf_compile;
_unpack = [_path, "unpack.sqf"] call mf_compile;
_access = [_path, "access.sqf"] call mf_compile;

mf_items_bankbook_can_pack = [_path, "can_pack.sqf"] call mf_compile;
mf_items_bankbook_can_access = [_path, "can_access.sqf"] call mf_compile;
mf_items_bankbook_nearest = {
    _bankbook = objNull;
    _bankbooks = nearestObjects [player, [MF_ITEMS_BANKBOOK_TYPE], 3];
    if (count _bankbooks > 0) then {
        _bankbook = _bankbooks select 0;
    };
    _bankbook;
} call mf_compile;

[MF_ITEMS_BANKBOOK, "Bankbook", _unpack, _ground_type, _icon, 1] call mf_inventory_create;

private ["_label", "_condition", "_action"];
_label = format["<img image='%1' /> Pack up Bankbook", _icon];
_condition = "'' == [] call mf_items_bankbook_can_pack;";
_action = [_label, _pack, [], 1, true, false, "", _condition];
["bankbook-pack", _action] call mf_player_actions_set; 

private ["_label2", "_condition2", "_action2"];
_label2 = format["<img image='%1' /> Connect ATM", _icon_bank];
_condition2 = "'' == [] call mf_items_bankbook_can_access;";
_action2 = [_label2, _access, [], 1, true, false, "", _condition2];
["bankbook-access", _action2] call mf_player_actions_set;

