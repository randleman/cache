/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// this is a edited version of "va_functions.sqf" by micovery, including only the basics for Vehicle-Information ////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (!isNil "va_actions_functions_defined") exitWith {};
diag_log format["Loading vehicle actions functions ..."];

#include "defines.h"

#define cameraDirDist(x) ([(positionCameraToWorld [0,0,0]), (positionCameraToWorld [0,0,x])] call BIS_fnc_vectorDiff)
#define insideAVehicle(x) ((vehicle x) != x)

//display the "Vehicle Information" action
cfg_va_info_action_on = true;

vector_add = {
  ARGVX3(0,_v1,[]);
  ARGVX3(1,_v2,[]);
  
  ([((_v1 select 0) + (_v2 select 0)), ((_v1 select 1) + (_v2 select 1)), ((_v1 select 2) + (_v2 select 2))])
};

//place-holder in case people want to modify this condition
va_information_action_available = { 
  if (not(cfg_va_info_action_on)) exitWith {false};
  
  ARGVX4(0,_player,objNull,false);
  ARGVX4(1,_vehicle,objNull,false);
  
  //put your custom logic here, if you want to restrict who can see the vehicle information
  
  true
};

va_get_owner_name = {
  ARGVX4(0,_vehicle,objNull,"None");
  
  def(_name);
  _name = _vehicle getVariable "ownerN";
  if (isSTRING(_name)) exitWith {_name};
  
  _name = _vehicle getVariable "ownerName";
  if (isSTRING(_name)) exitWith {_name};
  
  def(_uid1);
  def(_uid2);
  def(_uid3);
  def(_uid4);
  
  //I know, it's ugly, but got to try all these
  _uid1 = _vehicle getVariable ["uid", ""];
  _uid2 = _vehicle getVariable ["owner", ""];
  _uid3 = _vehicle getVariable ["ownerUID", ""];
  _uid4 = _vehicle getVariable ["UID", ""];
  
  if (_uid1 == "" && { _uid2 == "" && { _uid3 == "" && { _uid4 == ""}}}) exitWith {"None"};
  
  def(_uid);
  def(_player);
  
  {if (true) then {
    if (!isPlayer _x) exitWith {};
    _uid = getPlayerUID _x;
    if (_uid == "") exitWith {};
    
    if (_uid == _uid1 || {
        _uid == _uid2 || {
        _uid == _uid3 || {
        _uid == _uid4}}}) exitWith {
      _player = _x;
    }
  };} forEach playableUnits;
  
  if (!isOBJECT(_player)) exitWith {"Not in game"};
  
  (name _player)
};


va_information_action = {
  ARGVX3(3,_this,[]);
  ARGVX3(0,_player,objNull);
  ARGVX3(1,_vehicle,objNull);
  
  def(_class);
  def(_driver);
  def(_picture);
  def(_display_name);
  _class = typeOf _vehicle;
  _driver = driver _vehicle;
  _driver = if (isNull _driver) then {"None"} else {(name _driver)};
  _picture = [_class] call generic_picture_path;
  _display_name = [_class] call generic_display_name;

  def(_owner);
  _owner = [_vehicle] call va_get_owner_name;
    
  def(_text);
  def(_label);
  def(_value);
  _text = "";
  {
    _label = _x select 0;
    _value = _x  select 1;
    _text = _text + "<t align='left' font='PuristaMedium' size='1'>" + _label + "</t><t align='left' font='PuristaMedium'>" + _value + "</t><br />";
  }
  forEach(
    [["   Direction:  ", str(round(getdir _vehicle)) + toString [176]],
     ["   Grid:       ", mapGridPosition _vehicle],
     ["   Altitude:   ", str(round(getposASL _vehicle select 2)) + " meter(s) ASL"],
     ["   Driver:     ", ([_driver,17] call str_truncate)],
     ["   Seats:     ", str((_vehicle emptyPositions "cargo")+(_vehicle emptyPositions "driver")) + " seat(s)"],
     ["   Size:       ", str(round((sizeOf _class)*10)/10) + " meter(s)"],
     ["   Owner:     ",  ([_owner,17] call str_truncate)]

      
    ]);
  
  _text = format["<t align='center' font='PuristaMedium' size='1.4' >Vehicle Information</t><br /><img image='%1' size='2.8'   /><br /><t  align='center'>(%2)</t>", _picture, ([_display_name,25] call str_truncate)] + "<br /><br />" + _text;
  hint parseText _text;
};

va_outside_actions = OR(va_outside_actions,[]);

va_outside_remove_actions = {
  if (count va_outside_actions == 0) exitWith {};
  //player groupChat format["va_outside_remove_actions %1", _this];
  
  ARGVX3(0,_player,objNull);
  if (not(isPlayer _player)) exitWith {};
  
  {
    private["_action_id"];
    _action_id = _x;
    _player removeAction _action_id;
  } forEach va_outside_actions;
  va_outside_actions = [];
};

va_outside_add_actions = {
  if (count va_outside_actions > 0) exitWith {};
  //player groupChat format["va_outside_add_actions %1", _this];
  ARGVX3(0,_player,objNull);
  ARGVX3(1,_vehicle,objNull);

  if (not(isPlayer _player)) exitWith {};
  
  def(_display_name);
  _display_name = [typeOf _vehicle] call generic_display_name;
  
  //Add view vehicle information action
  _action_id = player addaction [format["<img image='addons\kttt\VehicleInfo\icons\info.paa'/> %1 info", _display_name], {_this call va_information_action;}, [_player, _vehicle],-90,false,false,"",
  format["([objectFromNetId %1, objectFromNetId %2] call va_information_action_available)", str(netId _player), str(netId _vehicle)]];
  va_outside_actions = va_outside_actions + [_action_id];
  
};


va_outside_target = {
  ARGVX3(0,_player,objNull);
  ARGVX3(1,_distance,0);
  if (!isPlayer _player) exitWith {};
  

  def(_target);
  if (surfaceIsWater (position _player)) then {
   //line intersect does not work well when vehicle is in water
    _target = cursorTarget;
  }
  else {
    def(_pos1);
    def(_pos2);
    _pos1 = (eyePos player);
    _pos2 = ([_pos1, cameraDirDist(_distance)] call vector_add);
	_objects = (lineIntersectsWith [_pos1,_pos2,objNull,objNull,true]);
	if (!isARRAY(_objects) || {count _objects == 0}) exitWith {};
	_target = _objects select 0;
  };

  if (isNil "_target") exitWith {};

  if (({_target isKindOf _x } count ["Helicopter", "Plane", "Ship_F", "Car", "Motorcycle", "Tank"]) == 0) exitWith {};
  
  _target
};

va_check_outside_actions = {
  //player groupChat format["va_check_outside_actions"];
  init(_player,player);
  

  _target_vehicle = [_player, 3.5] call va_outside_target;
  //player groupChat format["_target_vehicle = %1",_target_vehicle];
  if (!isOBJECT(_target_vehicle) || {insideAVehicle(_player) || {not(alive _player)}}) exitWith {
    [_player] call va_outside_remove_actions;
  };
  
  [_player, _target_vehicle] call va_outside_add_actions;
};


va_client_loop_stop = false;
va_client_loop = {
  if (not(isClient)) exitWith {};
  private ["_va_client_loop_i"];
  _va_client_loop_i = 0;

  while {_va_client_loop_i < 5000 && {not(va_client_loop_stop)}} do {
    call va_check_outside_actions;
    //call va_check_inside_actions;

    sleep 0.5;
    _va_client_loop_i = _va_client_loop_i + 1;
  };
  [] spawn va_client_loop;
};

[] spawn va_client_loop;

diag_log format["Loading vehicle actions functions complete"];

va_actions_functions_defined = true;