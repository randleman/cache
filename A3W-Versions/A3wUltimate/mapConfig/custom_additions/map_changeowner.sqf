systemChat format["Adding Licensing offices..."];
//*******************************************WEST
//MARKER ICON
_pos = [5698.92,16221.1,0];
_marker = createMarker ["LicensingOffice1", _pos];
_marker setMarkerShape "ICON";
_marker setMarkerType "c_car";
_marker setMarkerText "";
_marker setMarkerColor "ColorOPFOR";

//MARKER TRIGGER AREA
_pos = [5698.92,16221.1,0];
_marker = createMarker ["LICENSE_OFFICE_WEST", _pos];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerBrush "Border";
_marker setMarkerSize [25, 35];
_marker setMarkerDir 105.026;
_marker setMarkerColor "ColorOPFOR";

//LARGE LIGHTS
_pos = [5660.0537109,16206.350586,-0.00063324];
_object = createVehicle ["Land_LampHalogen_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 160.744;
_object setPosATL _pos;
_object allowDamage false;

_pos = [5726.249023,16189.591797,-0.000244141];
_object = createVehicle ["Land_LampHalogen_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 75.6346;
_object setPosATL _pos;
_object allowDamage false;

////*******************************************SOUTHEAST
//MARKER ICON
_pos = [17039.8, 11362.3,0];
_marker = createMarker ["LicensingOffice2", _pos];
_marker setMarkerShape "ICON";
_marker setMarkerType "c_car";
_marker setMarkerText "";
_marker setMarkerColor "ColorOPFOR";

//MARKER TRIGGER AREA
_pos = [17039.8, 11362.3,0];
_marker = createMarker ["LICENSE_OFFICE_SOUTHEAST", _pos];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerBrush "Border";
_marker setMarkerSize [35, 15];
_marker setMarkerColor "ColorOPFOR";

//LARGE LIGHTS
_pos = [16999.255859,11382.28418,-0.000198364];
_object = createVehicle ["Land_LampHalogen_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 220.747;
_object setPosATL _pos;
_object allowDamage false;

_pos = [17036.912109,11379.902344,-0.000333786];
_object = createVehicle ["Land_LampHalogen_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 286.355;
_object setPosATL _pos;
_object allowDamage false;

_pos = [17073.759766,11374.725586,0.000169754];
_object = createVehicle ["Land_LampHalogen_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 321.859;
_object setPosATL _pos;
_object allowDamage false;

////*******************************************NORTHEAST
//MARKER ICON
_pos = [26698.8, 23005.3,0];
_marker = createMarker ["LicensingOffice3", _pos];
_marker setMarkerShape "ICON";
_marker setMarkerType "c_car";
_marker setMarkerText "";
_marker setMarkerColor "ColorOPFOR";

//MARKER TRIGGER AREA
_pos = [26698.8, 23005.3,0];
_marker = createMarker ["LICENSE_OFFICE_NORTHEAST", _pos];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerBrush "Border";
_marker setMarkerSize [32, 19];
_marker setMarkerDir 36.7348;
_marker setMarkerColor "ColorOPFOR";

//LARGE LIGHTS
_pos = [26684.417969,23043.71875,0.000135422];
_object = createVehicle ["Land_LampHalogen_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 262.717;
_object setPosATL _pos;
_object allowDamage false;

_pos = [26656.232422,23010.710938,0.000108719];
_object = createVehicle ["Land_LampHalogen_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 185.723;
_object setPosATL _pos;
_object allowDamage false;

_pos = [26684.417969,23043.71875,0.000135422];
_object = createVehicle ["Land_LampHalogen_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 262.717;
_object setPosATL _pos;
_object allowDamage false;
