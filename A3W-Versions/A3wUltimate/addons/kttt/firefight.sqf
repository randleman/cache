// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.1
//	@file Name: firefight.sqf
//	@file Author: [K-TTT] Randleman

#define GET_ONE_TENTH_PRICE(PRICE) ((ceil (((PRICE) / 10) / 5)) * 5) 

// Check if mutex lock is active.
if (mutexScriptInProgress) exitWith
{
["You are already performing another action.", 5] call mf_notify_client;
};

if (MF_ITEMS_FIRE_EXTINGUISHER call mf_inventory_count <= 0) exitWith {
["You can't extinguish without a fire-extinguisher!",5] call mf_notify_client;
playSound "FD_CP_Not_Clear_F";
};

if (vehicle player != player) exitWith {
["You can't extinguish while in a vehicle.",5] call mf_notify_client;
playSound "FD_CP_Not_Clear_F";
};

private ["_wreck", "_wreckPos", "_wreckClass", "_unit", "_money", "_time", "_waterParticleCircle", "_confirmMsg"];

_wreck = cursorTarget;
_wreckPos = getPos _wreck;
_wreckClass = typeOf _wreck;
_unit = player;

if (isNull _wreck) exitWith {};
mutexScriptInProgress = true;
// Salvage time and default money reward according to vehicle type
switch (true) do
{
	case (_wreckClass isKindOf "Plane_Base_F"): // Planes
	{
		_waterParticleCircle = [2.5, 2.5, 2.5];
		_time = 16;
		_money = 3000;
	};
	case (_wreckClass isKindOf "Tank"): // Tanks & IFVs
	{
		_waterParticleCircle = [2, 2, 2];
		_time = 16;
		_money = 2000;
	};
	case (_wreckClass isKindOf "Helicopter_Base_F"): // Helicopters
	{
		_waterParticleCircle = [2, 2, 2];
		_time = 14;
		_money = 1750;
	};
	case (_wreckClass isKindOf "Wheeled_APC_F"): // Wheeled APCs
	{
		_waterParticleCircle = [1.5, 1.5, 1.5];
		_time = 10;
		_money = 1500;
	};
	case (_wreckClass isKindOf "Truck_F" && !(_wreckClass isKindOf "Van_01_base_F")): // Trucks (except Vans)
	{
		_waterParticleCircle = [2, 2, 2.5];
		_time = 10;
		_money = 1000;
	};
	case ({_wreckClass isKindOf _x} count ["MRAP_01_base_F", "MRAP_02_base_F", "MRAP_03_base_F"] > 0): // MRAPs
	{
		_waterParticleCircle = [1.5, 1.5, 1.5];
		_time = 8;
		_money = 750;
	};
	case (_wreckClass isKindOf "Boat_Armed_01_base_F"): // Speedboats
	{
		_waterParticleCircle = [1.5, 1.5, 1.5];
		_time = 8;
		_money = 500;
	};
	case ({_wreckClass isKindOf _x} count ["Quadbike_01_base_F", "Kart_01_Base_F", "Rubber_duck_base_F"] > 0): // Quadbikes, karts, rubber boats
	{
		_waterParticleCircle = [0.3, 0.3, 0.3];
		_time = 4;
		_money = 50;
	};
	default // Everything else
	{
		_waterParticleCircle = [1, 1, 1];
		_time = 4;
		_money = 100;
	};
};
// Final money reward is decided from vehicle store price
{
	if (_x select 1 == _wreckClass) exitWith 
	{
		_money = GET_ONE_TENTH_PRICE(_x select 2);
	};
} forEach call allVehStoreVehicles;


// Add confirm message 
_confirmMsg = format ["Extinguishing and salvaging of<br/>%1<br/>will bring you $%2 ...", _wreckClass, _money];

// Display confirm message
if ([parseText _confirmMsg, "Fire Extinguisher", "EXTINGUISH", true] call BIS_fnc_guiMessage) then
	{
		EXTINGUISH_DONE = false;
		[_wreck, _wreckPos, _unit, _waterParticleCircle, _time, _money] call fn_extinguish;
		waitUntil {EXTINGUISH_DONE};
		mutexScriptInProgress = false;
	} else {
		mutexScriptInProgress = false;
	};