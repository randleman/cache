////////////////////////////////////////////////
// ChopShop Addition Script by [K-TTT] Randleman
////////////////////////////////////////////////

systemChat format["Adding Chop Shop to Map..."];

//MARKER ICON
_pos = [13958.929,15132.365,0];
_marker = createMarker ["ChopShop1", _pos];
_marker setMarkerShape "ICON";
_marker setMarkerType "respawn_unknown";
_marker setMarkerText "";
_marker setMarkerColor "ColorOPFOR";

//MARKER TRIGGER AREA
_pos = [13959.774,15134.331,0];
_marker = createMarker ["CHOPSHOP_MARKER", _pos];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerBrush "Border";
_marker setMarkerSize [18, 26];
_marker setMarkerColor "ColorOPFOR";
"CHOPSHOP_MARKER" setMarkerDir 205;

//LIGHTS
_pos = [13933.976,15138.206,0];
_object = createVehicle ["Land_LampHalogen_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 198.58398;
_object setPosATL _pos;
_object allowDamage false;

_pos = [13966.434,15160.95,0];
_object = createVehicle ["Land_LampHalogen_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 273.39822;
_object setPosATL _pos;
_object allowDamage false;

_pos = [13940.993,15119,0];
_object = createVehicle ["Land_LampHalogen_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 131.37808;
_object setPosATL _pos;
_object allowDamage false;

//OBJECTS
_pos = [13986.164,15147.345,0];
_object = createVehicle ["Land_UWreck_MV22_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -362.8172;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13961.618,15155.729,0];
_object = createVehicle ["Land_Wreck_Van_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 152.153;
_object setPosATL _pos;
////_object enableSimulation false;
_object allowDamage false;

_pos = [13946.846,15154.703,0];
_object = createVehicle ["Land_Wreck_BMP2_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 35.791477;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13961.207,15161.551,0];
_object = createVehicle ["Land_Wreck_UAZ_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 15.0939;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13957.956,15158.633,0];
_object = createVehicle ["Land_Wreck_Ural_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -182.27722;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13985.566,15125.007,0];
_object = createVehicle ["Land_Wreck_Traw_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 402.85489;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13967.971,15108.288,0];
_object = createVehicle ["Land_Wreck_Traw2_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 410.72678;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13933.856,15142.676,0];
_object = createVehicle ["Land_Wreck_Car2_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -338.95523;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13939.783,15141.734,0];
_object = createVehicle ["Land_Wreck_CarDismantled_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -303.707;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13938.528,15138.707,0];
_object = createVehicle ["Land_ToolTrolley_02_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -538.27362;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13963.411,15159.944,0];
_object = createVehicle ["Land_Tyres_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -248.22266;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13963.679,15157.966,0];
_object = createVehicle ["Land_Tyres_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -258.22266;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13943.735,15150.69,0];
_object = createVehicle ["Land_Tyres_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -284.53333;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13951.91,15156.828,0];
_object = createVehicle ["Land_Tyre_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -303.707;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13954.784,15157.61,0];
_object = createVehicle ["Land_Tyres_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -400.7478;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13937.273,15144.997,0];
_object = createVehicle ["Land_Tyre_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -303.707;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13944.646,15146.61,0];
_object = createVehicle ["Land_GarbagePallet_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -303.707;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13945.994,15144.813,0];
_object = createVehicle ["Land_GarbagePallet_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -470.5141;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13940.49,15146.234,0];
_object = createVehicle ["Land_JunkPile_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -412.25766;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13940.171,15136.462,0];
_object = createVehicle ["Land_Wreck_CarDismantled_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -437.80118;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13951.341,15145.745,0];
_object = createVehicle ["Land_WoodenTable_small_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -131.95;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13950.272,15144.839,0];
_object = createVehicle ["Land_ToolTrolley_01_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 397.2326;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13969.246,15154.737,0];
_object = createVehicle ["Land_Scrap_MRAP_01_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 113.774;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13973.172,15158.903,0];
_object = createVehicle ["Land_Wreck_BRDM2_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 81.750702;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13938.3,15132.021,0];
_object = createVehicle ["Land_Wreck_BRDM2_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 146.51036;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13941.829,15121.451,0];
_object = createVehicle ["Land_Wreck_Van_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 152.153;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13941.418,15127.273,0];
_object = createVehicle ["Land_Wreck_UAZ_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 15.0939;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13938.167,15124.355,0];
_object = createVehicle ["Land_Wreck_Ural_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -182.27722;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13943.622,15125.667,0];
_object = createVehicle ["Land_Tyres_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -248.22266;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13943.89,15123.688,0];
_object = createVehicle ["Land_Tyres_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -258.46936;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

_pos = [13934.995,15123.333,0];
_object = createVehicle ["Land_Tyres_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir -400.7478;
_object setPosATL _pos;
//_object enableSimulation false;
_object allowDamage false;

