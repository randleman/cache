// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.2
//	@file Name: playerActions.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, [GoT] JoSchaap, AgentRev
//	@file Created: 20/11/2012 05:19

{ [player, _x] call fn_addManagedAction } forEach
[
	["Holster Weapon", { player action ["SwitchWeapon", player, player, 100] }, [], -11, false, false, "", "vehicle player == player && currentWeapon player != ''"],
	["Unholster Primary Weapon", { player action ["SwitchWeapon", player, player, 0] }, [], -11, false, false, "", "vehicle player == player && currentWeapon player == '' && primaryWeapon player != ''"],

	[format ["<img image='client\icons\playerMenu.paa' color='%1'/> <t color='%1'>[</t>Player Menu<t color='%1'>]</t>", "#FF8000"], "client\systems\playerMenu\init.sqf", [], -10, false], //, false, "", ""],

	["<img image='client\icons\money.paa'/> Pickup Money", "client\actions\pickupMoney.sqf", [], 1, false, false, "", "{_x getVariable ['owner', ''] != 'mission'} count (player nearEntities ['Land_Money_F', 5]) > 0"],

	["<img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa'/> <t color='#FFFFFF'>Cancel Action</t>", { doCancelAction = true }, [], 1, false, false, "", "mutexScriptInProgress"],

	["<img image='client\icons\repair.paa'/> Salvage", "client\actions\salvage.sqf", [], 1.1, false, false, "", "!isNull cursorTarget && !alive cursorTarget && {cursorTarget isKindOf 'AllVehicles' && !(cursorTarget isKindOf 'Man') && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 2}"],
	
	["<img image='client\icons\VehUnsecure.paa'/> Open up Vehicle", "client\actions\VehUnsecure.sqf", [cursorTarget], 1,false,false,"","!isNull cursorTarget && alive cursorTarget && vehicle player == player && {{ cursorTarget isKindOf _x } count ['LandVehicle', 'Ship', 'Air'] > 0 ;} && cursorTarget getVariable ['ownerUID',''] == getPlayerUID player && locked cursorTarget >= 2 && cursorTarget distance player < 7"],
	["<img image='client\icons\VehSecure.paa'/> Secure Vehicle", "client\actions\VehSecure.sqf", [cursorTarget], 1,false,false,"","!isNull cursorTarget && alive cursorTarget && vehicle player == player && {{ cursorTarget isKindOf _x } count ['LandVehicle', 'Ship', 'Air'] > 0 ;} && {{ cursorTarget isKindOf _x } count ['StaticWeapon'] == 0 ;} && cursorTarget getVariable ['ownerUID',''] == getPlayerUID player && locked cursorTarget < 2 && cursorTarget distance player < 7"],
	
	["<t color='#B80000'>Register Ownership</t>", "addons\kttt\changeowner.sqf", [], 51, false, false, "", "(['LICENSE_OFFICE_WEST', getpos player] call BIS_fnc_inTrigger || ['LICENSE_OFFICE_NORTHEAST', getpos player] call BIS_fnc_inTrigger || ['LICENSE_OFFICE_SOUTHEAST', getpos player] call BIS_fnc_inTrigger) && !(vehicle player == player) && ((vehicle player) isKindOf 'Air' ||( vehicle player) isKindOf 'LandVehicle' || (vehicle player) isKindOf 'Ship')"],
	
	["<t color='#B80000'>Chop Vehicle</t>", "addons\kttt\chopshop.sqf", [], 51, false, false, "", "(['CHOPSHOP_MARKER', getpos player] call BIS_fnc_inTrigger) && !(vehicle player == player) && ((vehicle player) isKindOf 'Air' ||( vehicle player) isKindOf 'LandVehicle' || (vehicle player) isKindOf 'Ship')"],
	
	["<t color='#009EEC'>Catch Animal</t>", "client\functions\checkAnimal.sqf", [], 61,false,false,"","count nearestObjects[getPos player,['Animal_Base_F'],3] > 0"],
	
	["<img image='client\icons\fireextinguisher.paa'/> <t color='#FF0D00'>Extinguish</t>", "addons\kttt\firefight.sqf", [], 41, false, false, "", "!isNull cursorTarget && !alive cursorTarget && {cursorTarget isKindOf 'AllVehicles' && !(cursorTarget isKindOf 'Man') && !(MF_ITEMS_FIRE_EXTINGUISHER call mf_inventory_count <= 0)}"],
	
	["[0]"] call getPushPlaneAction,
	["Push vehicle", "server\functions\pushVehicle.sqf", [2.5, true], 1, false, false, "", "[2.5] call canPushVehicleOnFoot"],
	["Push vehicle forward", "server\functions\pushVehicle.sqf", [2.5], 1, false, false, "", "[2.5] call canPushWatercraft"],
	["Push vehicle backward", "server\functions\pushVehicle.sqf", [-2.5], 1, false, false, "", "[-2.5] call canPushWatercraft"],

	["<t color='#FF0000'>Emergency eject</t>",  { [[], fn_emergencyEject] execFSM "call.fsm" }, [], -9, false, true, "", "(vehicle player) isKindOf 'Air' && !((vehicle player) isKindOf 'ParachuteBase')"],
	["<t color='#FF00FF'>Open magic parachute</t>", { [[], fn_openParachute] execFSM "call.fsm" }, [], 20, true, true, "", "vehicle player == player && (getPos player) select 2 > 2.5"]
];


// Hehehe...
if !(288520 in getDLCs 1) then
{
	[player, ["<t color='#00FFFF'>Get in as Driver</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "cursorTarget isKindOf 'Kart_01_Base_F' && player distance cursorTarget < 3.4 && isNull driver cursorTarget"]] call fn_addManagedAction;
};

if (["A3W_savingMethod", "profile"] call getPublicVar == "extDB" && {["A3W_purchasedVehicleSaving"] call isConfigOn || ["A3W_missionVehicleSaving"] call isConfigOn}) then
{
	[player, ["<img image='client\icons\save.paa'/> Force Save Vehicle", { pvar_manualVehicleSave = netId cursorTarget; publicVariableServer "pvar_manualVehicleSave" }, [], -9.5, false, true, "", "call canForceSaveVehicle"]] call fn_addManagedAction;
};
