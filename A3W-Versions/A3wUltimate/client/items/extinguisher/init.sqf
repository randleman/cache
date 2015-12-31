// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.0
//@file Name: init.sqf
//@file Author: [K-TTT] Randleman

private ["_path", "_useAction"];
_path = _this;
_useAction = [_path, "unpack.sqf"] call mf_compile;

MF_ITEMS_FIRE_EXTINGUISHER = "extinguisher";
MF_ITEMS_FIRE_EXTINGUISHER_TYPE = "Land_FireExtinguisher_F";
MF_ITEMS_FIRE_EXTINGUISHER_ICON = "client\icons\fireextinguisher.paa";
[MF_ITEMS_FIRE_EXTINGUISHER, "Fire Extinguisher", _useAction, MF_ITEMS_FIRE_EXTINGUISHER_TYPE, MF_ITEMS_FIRE_EXTINGUISHER_ICON, 1] call mf_inventory_create;