////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// this is a edited version of "functions.sqf" by micovery, including only the basics for Vehicle-Information //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
{
  call compile preprocessFileLineNumbers format["addons\kttt\VehicleInfo\%1_functions.sqf", _x];
} forEach ["misc", "va"];