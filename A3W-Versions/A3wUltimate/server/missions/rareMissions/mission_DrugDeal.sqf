// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_ConFile.sqf
//	@file Author: AgentRev, [K-TTT] Randleman
//	@file Created: 22/01/2015 23:19
#define MONEYPACKS 12
#define DRUGPACKS 4  // example: 4 = 16 drug-items (4*4)
if (!isServer) exitwith {};
#include "rareMissionDefines.sqf";

private ["_DrugDealMissionSpecs", "_moneyAmount", "_groupsAmount", "_drugitem1", "_drugitem2", "_drugitem3", "_drugitem4", "_nbUnits", "_nbUnitStart", "_nbUnitFinal", "_moneyText","_townName", "_missionPos", "_buildingRadius", "_putOnRoof", "_fillEvenly"];

_setupVars =
{
	////////////////////////////////////// GET AMOUNT OF GROUP ////////////////////////////////////////////////
	_nbUnits = AI_GROUP_LARGE;					//_nbUnits (AI_GROUP_LARGE) in RareMissionDefines = 55 Soldiers
	_nbUnitStart = (_nbUnits);				// 55-50=5 :D
	_nbUnitFinal = _nbUnitStart + round(random 6);	// 5+(something up to 6)= max. 11
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	_locArray = ((call cityList) call BIS_fnc_selectRandom);
	_missionPos = markerPos (_locArray select 0);
	_buildingRadius = _locArray select 1;
	_townName = _locArray select 2;
	
	// reduce radius for larger towns. for example to avoid endless hide and seek in kavala ;)
	_buildingRadius = if (_buildingRadius > 201) then {(_buildingRadius*0.5)} else {_buildingRadius};
	_putOnRoof = false;
	_fillEvenly = true;
	
	_DrugDealMissionSpecs =
	[
		"Drug Deal", // Marker text
		6000, // money amount (just for hint)
		_nbUnitFinal
	];

	_missionType = _DrugDealMissionSpecs select 0;
	_moneyAmount = _DrugDealMissionSpecs select 1;
	_groupsAmount = _DrugDealMissionSpecs select 2;

	_moneyText = format ["$%1", [_moneyAmount] call fn_numbersText];
	
};

_setupObjects =
{
	_aiGroup = createGroup CIVILIAN;															
	[_aiGroup, _missionPos, _groupsAmount] call createCustomGroup;								
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
	//_aiGroup allowDamage false;																	// safe until positioning
	[_aiGroup, _missionPos, _buildingRadius, _fillEvenly, _putOnRoof] call moveIntoBuildings;	// move _PubEnemy into a building
	//_aiGroup allowDamage true;																	// free to kill! :P
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	_aiGroup setCombatMode "RED";																// set some hardness :D
	_aiGroup setBehaviour "COMBAT";
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	_missionHintText = format ["<br/>Kill %3 enemies in<br/><t size='1.35' color='%1'>%2</t><br/><br/> and grab their drugs and %4.", rareMissionColor, _townName, _groupsAmount, _moneyText];
};

_waitUntilMarkerPos = nil; 
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	
};

_successExec =
{
	// Mission completed
	
	for "_x" from 1 to DRUGPACKS do
	{
	//spawn Stuff
		_drugitem1 = createVehicle ["Land_VitaminBottle_F", _lastPos, [], 5, "None"];
		_drugitem1 setPos ([_lastPos, [[0.2 + random 0.5,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_drugitem1 setDir random 360;
		_drugitem1 setVariable ["mf_item_id", "lsd", true];
		
		_drugitem2 = createVehicle ["Land_PainKillers_F", _lastPos, [], 5, "None"];
		_drugitem2 setPos ([_lastPos, [[0.2 + random 0.5,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_drugitem2 setDir random 360;
		_drugitem2 setVariable ["mf_item_id", "marijuana", true];
		
		_drugitem3 = createVehicle ["Land_PowderedMilk_F", _lastPos, [], 5, "None"];
		_drugitem3 setPos ([_lastPos, [[0.2 + random 0.5,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_drugitem3 setDir random 360;
		_drugitem3 setVariable ["mf_item_id", "cocaine", true];
		
		_drugitem4 = createVehicle ["Land_BloodBag_F", _lastPos, [], 5, "None"];
		_drugitem4 setPos ([_lastPos, [[0.2 + random 0.5,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_drugitem4 setDir random 360;
		_drugitem4 setVariable ["mf_item_id", "heroin", true];
	};	
		
	for "_i" from 1 to MONEYPACKS do
	{
		_cash = createVehicle ["Land_Money_F", _lastPos, [], 5, "None"];
		_cash setPos ([_lastPos, [[0.1 + random 0.5,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", _moneyAmount / MONEYPACKS, true];
		_cash setVariable ["owner", "world", true];
	};

	_successHintMessage = "Well done, last enemy killed! He had money and the drugs about him.";
};

_this call rareMissionProcessor;
