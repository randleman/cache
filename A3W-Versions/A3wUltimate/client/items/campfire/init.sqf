//@file Version: 1.1
//@file Name: init.sqf
//@file Author: MercyfulFate (modified by [KTTT] Randleman)
//@file Description: Initialize Campfire
//@file Argument: the path to the directory holding this file.
private ["_path","_ground_type", "_icon", "_unpack", "_pack"];
_path = _this;

MF_ITEMS_CAMP_FIRE = "campfire";
MF_ITEMS_CAMP_FIRE_TYPE = "Land_Campfire_F";
_ground_type = "Land_SuitCase_F";
_icon = "client\icons\take.paa";

_pack = [_path, "pack.sqf"] call mf_compile;
_unpack = [_path, "unpack.sqf"] call mf_compile;
mf_items_camp_fire_can_pack = [_path, "can_pack.sqf"] call mf_compile;
mf_items_camp_fire_nearest = {
    _campfire = objNull;
    _campfires = nearestObjects [player, [MF_ITEMS_CAMP_FIRE_TYPE], 3];
    if (count _campfires > 0) then {
        _campfire = _campfires select 0;
    };
    _campfire;
} call mf_compile;

[MF_ITEMS_CAMP_FIRE, "Campfire", _unpack, _ground_type, _icon, 1] call mf_inventory_create;

private ["_label", "_condition", "_action"];
_label = format["<img image='%1' /> Pack up Campfire", _icon];
_condition = "'' == [] call mf_items_camp_fire_can_pack;";
_action = [_label, _pack, [], 1, true, false, "", _condition];
["campfire-pack", _action] call mf_player_actions_set; 