/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// this is a edited version of "misc_functions.sqf" by micovery, including only the basics for Vehicle-Information //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (!isNil "va_misc_functions_loaded") exitWith {};
diag_log format["Loading vehicle misc functions ..."];

#include "defines.h"

generic_picture_path = {
  ARGVX3(0,_id,"");
  ([_id, "picture"] call generic_config_text)
};

generic_display_name = {
  ARGVX3(0,_id,"");
  ([_id, "displayName"] call generic_config_text)
};

generic_icon_path = {
  ARGVX3(0,_id,"");
  ([_id, "icon"] call generic_config_text)
};

generic_config_text = {
  ARGVX3(0,_id,"");
  ARGVX3(1,_field,"");

  if (_id == "" || {_field == ""}) exitWith {""};

  if (isClass(configFile >> "CfgWeapons" >> _id)) exitWith {
    (getText(configFile >> "CfgWeapons" >> _id >> _field))
  };

  if (isClass(configFile >> "CfgVehicles" >> _id)) exitWith {
    (getText(configFile >> "CfgVehicles" >> _id >> _field))
  };

  if (isClass(configFile >> "CfgMagazines" >> _id)) exitWith {
    (getText(configFile >> "CfgMagazines" >> _id >> _field))
  };

  if (isClass(configFile >> "CfgAmmos" >> _id)) exitWith {
    (getText(configFile >> "CfgAmmos" >> _id >> _field))
  };

  if (isClass(configFile >> "CfgGlasses" >> _id)) exitWith {
    (getText(configFile >> "CfgGlasses" >> _id >> _field))
  };

  ""
};

str_truncate = {
  ARGVX4(0,_str,"","...");
  ARGVX4(1,_max,0,"...");
  
 _str = if ((count _str) > _max) then { (_str select [0, _max - 3]) + "..."} else {_str};
 (_str)
};

va_misc_functions_loaded = true;

diag_log format["Loading vehicle misc functions complete"];


