// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.5
//	@file Name: VehSecure.sqf
//	@file Author: [K-TTT] Randleman thanks the whole COMMUNITY
//	@file Created: 09/02/2015

#define ANIM  "AinvPknlMstpSlayWrflDnon_medic" // Animation
#define DURATION 60 //delay duration in seconds
#define ERR_IN_VEHICLE "Locking failed. You can't do this in a vehicle."
#define ERR_CANCELLED "Vehicle locking cancelled"

private ["_vehicle","_nearvehicle", "_lockdelay", "_hasFailed"];
_nearvehicle = nearestObjects [player, ["LandVehicle", "Ship", "Air"], 7];
_vehicle = _nearvehicle select 0;

_hasFailed = {
	private ["_progress", "_failed", "_text"];
	_progress = _this select 0;
	_text = "";
	_failed = true;
	switch (true) do {
		case (!alive player): {}; // player dead, no error msg needed
		case (vehicle player != player): {_text = ERR_IN_VEHICLE};
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED};
		default {
			_text = format["Protecting vehicle %1%2 ", round(_progress*100), "%"];
			_failed = false;
        };
    };
    [_failed, _text];
};

_lockdelay = [DURATION, ANIM, _hasFailed, [getPosATL player]] call a3w_actions_start;

if (_lockdelay) then {

	if (local _vehicle) then
	{
	_vehicle lock true;
	_vehicle allowDamage false;
	}
	else
	{
	[[netId _vehicle, 2], "A3W_fnc_VehSecureStatus", _vehicle] call A3W_fnc_MP; // Lock Vehicle
	[[netId _vehicle, false], "A3W_fnc_VehBulproofStatus", _vehicle] call A3W_fnc_MP;
	};

_vehicle setVariable ["VehSecured", true, true];
_vehicle setVariable ["R3F_LOG_disabled",true,true];

_vehicle say3D "carsecuresound";
_vehicle engineOn false;
player action ["lightOn", _vehicle];
sleep 1;
player action ["lightOff", _vehicle];

titleText ["Vehicle Secured!","PLAIN DOWN"]; titleFadeOut 2;
}
