// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: buy_account.sqf
//	@file Author: [K-TTT] Randleman
//	@file Function: mf_items_atm_buy_account

#define atmAccountPrice 2000

if (player getVariable ["baccount", 0] == 1) exitWith 
{
	//["You already own an ATM-Account.", 7] call mf_notify_client;
	titleText ["You already own an ATM-Account.", "PLAIN", 0.5];
};
		
if (mutexScriptInProgress) exitWith
{
	["You are already performing another action.", 5] call mf_notify_client;
};

private ["_playerMoney", "_confirmMsg"];

_playerMoney = player getVariable "cmoney";

// Add confirm message 
_confirmMsg = format ["Creating a personal ATM-Account costs you $%1.", atmAccountPrice];

// Display confirm message
if ([parseText _confirmMsg, "ATM Account Creation", "BUY", true] call BIS_fnc_guiMessage) then
	{
		mutexScriptInProgress = true;
		
		// Ensure the player has enough money
			if (atmAccountPrice > _playerMoney) exitWith
			{
				//["Come back with some money in bag!", 7] call mf_notify_client;
				titleText ["Come back with some money in bag!", "PLAIN", 0.5];

				playSound "FD_CP_Not_Clear_F";
				mutexScriptInProgress = false;
			};
		
		player setVariable["cmoney",(player getVariable "cmoney") - atmAccountPrice, true];
		sleep 1;
		player setVariable ["baccount", 1, true];
		sleep 1;
		//["You have now access to your personal ATM-Account.", 7] call mf_notify_client;
		titleText ["You have now access to your personal ATM-Account.", "PLAIN", 0.5];
		playSound "FD_Finish_F";
		[] call fn_savePlayerData;
		mutexScriptInProgress = false;
	} else {
		//["We're sure you cancelled with good cause.", 5] call mf_notify_client;
		titleText ["We're sure you cancelled with good cause.", "PLAIN", 0.5];
		mutexScriptInProgress = false;
	};