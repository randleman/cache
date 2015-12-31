//@file Version: 1.1
//@file Name: init.sqf
//@file Author: MercyfulFate (modified by [KTTT] Randleman)
//@file Description: Initialize Missionreward
//@file Argument: the path to the directory holding this file.
private ["_path","_ground_type", "_icon", "_unpack", "_pack"];
_path = _this;

MF_ITEMS_MISSION_REWARD = "missionreward";
MF_ITEMS_MISSION_REWARD_TYPE = "Land_File2_F";
_ground_type = "Land_File2_F";
_icon = "client\icons\take.paa";

_pack = [_path, "pack.sqf"] call mf_compile;
_unpack = [_path, "unpack.sqf"] call mf_compile;
mf_items_mission_reward_can_pack = [_path, "can_pack.sqf"] call mf_compile;
mf_items_mission_reward_nearest = {
    _missionreward = objNull;
    _missionrewards = nearestObjects [player, [MF_ITEMS_MISSION_REWARD_TYPE], 3];
    if (count _missionrewards > 0) then {
        _missionreward = _missionrewards select 0;
    };
    _missionreward;
} call mf_compile;

[MF_ITEMS_MISSION_REWARD, "Missionreward", _unpack, _ground_type, _icon, 3] call mf_inventory_create;

private ["_label", "_condition", "_action"];
_label = format["<img image='%1' /> Pack up Missionreward", _icon];
_condition = "'' == [] call mf_items_mission_reward_can_pack;";
_action = [_label, _pack, [], 5, true, false, "", _condition];
["missionreward-pack", _action] call mf_player_actions_set; 