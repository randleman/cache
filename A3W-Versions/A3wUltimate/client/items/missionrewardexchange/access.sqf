// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: access.sqf
//	@file Author: AgentRev, [K-TTT] Randleman
//	@file Function: mf_items_missionrewardexchange_access

 #define ERR_NO_MR "Failed. You have no Missionreward"
 #define MONEYPACKS 12
 
	_playerPos = getPos player;
	_moneyspawnPos = [(_playerPos select 0), (_playerPos select 1) -5,0];
	
if (MF_ITEMS_MISSION_REWARD call mf_inventory_count <= 0) exitWith {
[ERR_NO_MR,5] call mf_notify_client;
playSound "FD_CP_Not_Clear_F";
false;
};

if (MF_ITEMS_MISSION_REWARD call mf_inventory_count >= 1) then {
	for "_i" from 1 to MONEYPACKS do
	{
		_cash = createVehicle ["Land_Money_F", _moneyspawnPos, [], 5, "None"];
		_cash setPos ([_moneyspawnPos, [[2 + random 2,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", 12000 / MONEYPACKS, true];
		_cash setVariable ["owner", "world", true];
	};
	[MF_ITEMS_MISSION_REWARD, 1] call mf_inventory_remove;
	playSound "FD_Finish_F";
	["Your Reward has exchanged", 5] call mf_notify_client;
	};