// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.5
//	@file Name: VehUnsecure.sqf
//	@file Author: [K-TTT] Randleman thanks the whole COMMUNITY especially AgentRev, Micovery
//	@file Created: 09/02/2015

#define ANIM  "AinvPknlMstpSlayWrflDnon_medic" //"AinvPknlMstpSlayWrflDnon_medic"  Animation
#define DURATION 5 //delay duration in seconds
#define ERR_IN_VEHICLE "Unocking failed. You can't do this in a vehicle."
#define ERR_CANCELLED "Vehicle unlocking cancelled"

private ["_vehicle","_nearvehicle", "_unlockdelay", "_hasFailed"];
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
			_text = format["Open up vehicle %1%2", round(_progress*100), "%"];
			_failed = false;
        };
    };
    [_failed, _text];
};

_unlockdelay = [DURATION, ANIM, _hasFailed, [getPosATL player]] call a3w_actions_start;

if (_unlockdelay) then {

	if (local _vehicle) then
	{
	_vehicle lock 1;
	_vehicle allowDamage true;
	}
	else
	{
	[[netId _vehicle, 1], "A3W_fnc_VehSecureStatus", _vehicle] call A3W_fnc_MP; // Unlock
	[[netId _vehicle, true], "A3W_fnc_VehBulproofStatus", _vehicle] call A3W_fnc_MP;
	};

_vehicle setVariable ["VehSecured", false, true];	
_vehicle setVariable ["R3F_LOG_disabled",false,true];

_vehicle say3D "carsecuresound";
player action ["lightOn", _vehicle];
sleep 0.2;
player action ["lightOff", _vehicle];
sleep 0.1;
player action ["lightOn", _vehicle];
sleep 0.2;
player action ["lightOff", _vehicle];
titleText ["Vehicle Opened!","PLAIN DOWN"]; titleFadeOut 2;
}