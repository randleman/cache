// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_ConFile.sqf
//	@file Author: AgentRev, [K-TTT] Randleman
//	@file Created: 22/01/2015 23:19

if (!isServer) exitwith {};
#include "rareMissionDefines.sqf";

private ["_ConFileMissionSpecs", "_moneyAmount", "_groupsAmount", "_reward", "_nbUnits", "_nbUnitStart", "_nbUnitFinal", "_moneyText", "_peGroup","_townName", "_missionPos", "_buildingRadius", "_putOnRoof", "_fillEvenly", "_dropPos"];

_setupVars =
{
	////////////////////////////////////// GET AMOUNT OF DEFENDING GROUP //////////////////////////////////////
	_nbUnits = AI_GROUP_LARGE;					//_nbUnits (AI_GROUP_LARGE) in RareMissionDefines = 55 Soldiers
	_nbUnitStart = (_nbUnits) - 31;				// 55-39=16 :D
	_nbUnitFinal = _nbUnitStart + round(random 16);	// 16+(something up to 16)= max.32
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	_locArray = ((call cityList) call BIS_fnc_selectRandom);
	_missionPos = markerPos (_locArray select 0);
	_buildingRadius = _locArray select 1;
	_townName = _locArray select 2;
	
	// reduce radius for larger towns. for example to avoid endless hide and seek in kavala ;)
	_buildingRadius = if (_buildingRadius > 201) then {(_buildingRadius*0.5)} else {_buildingRadius};
	_putOnRoof = false;
	_fillEvenly = true;
	
	_ConFileMissionSpecs =
	[
		"Confidential File", // Marker text
		12000, // money amount (just for hint)
		_nbUnitFinal
	];

	_missionType = _ConFileMissionSpecs select 0;
	_moneyAmount = _ConFileMissionSpecs select 1;
	_groupsAmount = _ConFileMissionSpecs select 2;

	_moneyText = format ["$%1", [_moneyAmount] call fn_numbersText];
	
};

_setupObjects =
{
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	_peGroup = createGroup CIVILIAN;															//this Group should defend _PubEnemy
	[_peGroup, _missionPos, _groupsAmount] call createCustomGroup;								
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
	_aiGroup = createGroup CIVILIAN;															//this "group" is the _PubEnemy only
	_PubEnemy = _aiGroup createUnit ["C_man_polo_1_F", _missionPos, [], 0, "None"];
		removeAllWeapons _PubEnemy;
		removeAllAssignedItems _PubEnemy;
		removeUniform _PubEnemy;
		removeVest _PubEnemy;
		removeBackpack _PubEnemy;
		removeHeadgear _PubEnemy;
		removeGoggles _PubEnemy;
		_PubEnemy addUniform "U_Rangemaster";  
		_PubEnemy addHeadgear "H_Beret_Colonel";
		_PubEnemy addVest "V_PlateCarrier1_blk";
		_PubEnemy addBackpack "B_FieldPack_blk";
		_PubEnemy setRank "COLONEL";
		_PubEnemy addWeapon "arifle_MXC_Holo_pointer_F";
		_PubEnemy addMagazine "30Rnd_65x39_caseless_mag";
		_PubEnemy addMagazine "30Rnd_65x39_caseless_mag";
		_PubEnemy addMagazine "30Rnd_65x39_caseless_mag";
		_PubEnemy addRating 1e11;
		_PubEnemy spawn refillPrimaryAmmo;
		_PubEnemy call setMissionSkill;
		_PubEnemy addEventHandler ["Killed", server_playerDied];
		
	_PubEnemy = leader _aiGroup;
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	_PubEnemy allowDamage false;																// safe until positioning
	[_aiGroup, _missionPos, _buildingRadius, _fillEvenly, _putOnRoof] call moveIntoBuildings;	// move _PubEnemy into a building
	_PubEnemy allowDamage true;																	// free to kill! :P
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	
	_peGroup setCombatMode "RED";
	_peGroup setBehaviour "COMBAT";
	_peGroup setFormation "DELTA";
	
	_dropPos = getPosATL _PubEnemy;
		
	//_missionHintText = format ["Take down the colonel!<br/>He holds a <t color='%1'>document wich is worth %2</t> at the exchangedevice. But aware! The colonel is guarding by %3 soldiers!", rareMissionColor, _moneyText, _groupsAmount];
	_missionHintText = format ["<br/>Find the Colonel in<br/><t size='1.35' color='%1'>%2</t><br/><br/>He holds a<br/><t color='%1'>file wich is worth %4</t><br/>at the exchangedevice.<br/>Be aware!<br/>The colonel is guarding by<br/>about <t color='%1'>%3 enemies</t>.", rareMissionColor, _townName, _groupsAmount, _moneyText];
};

_waitUntilMarkerPos = nil; //{getPosATL _PubEnemy};
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach units _peGroup;
	deleteGroup _peGroup;
};

_successExec =
{
	// Mission completed
	
	//spawn MissionRward
		_reward = createVehicle ["Land_File2_F", _dropPos, [], 5, "None"];
		_reward setPos ([_dropPos, [[0.1 + random 0.5,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_reward setDir random 360;
		_reward setVariable ["mf_item_id", "missionreward", true];
		
	for "_i" from 1 to 12 do
	{
		_cash = createVehicle ["Land_Money_F", _dropPos, [], 5, "None"];
		_cash setPos ([_dropPos, [[0.1 + random 0.5,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", 1200 / 12, true];
		_cash setVariable ["owner", "world", true];
	};

	_successHintMessage = "The colonel is down and the secret document is near his corpse!<br/>Be aware!<br/>The guarding soldiers could still be there!";
};

_this call rareMissionProcessor;
