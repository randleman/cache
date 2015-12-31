//	@file Name: changeOwner.sqf
//	@file Author: Cael817 based on fn_chopShop.sqf from Lodac, Wiking, Gigatek (original auth)
// [K-TTT] Randleman customized for well work :P

#define CANGEOWNER_PRICE_RELATIONSHIP 2

private ["_vehicle", "_driver", "_eng", "_type", "_price", "_confirmMsg", "_playerMoney", "_vehicleCrewArr", "_text"];
// _vehicle = vehicle player; // Used when activated by a player action.
_vehicle = vehicle player;
_driver = driver _vehicle;
_eng = isengineon _vehicle;
_vehicle setVelocity [0,0,0];

titleText ["Welcome to Altis Ownership Licence Office!", "PLAIN DOWN", 0.5];
sleep 3;
// Check if mutex lock is active.
if (mutexScriptInProgress) exitWith
{
	titleText ["You are already performing another action.", "PLAIN DOWN", 0.5];
};
mutexScriptInProgress = true;

//check if caller is in vehicle
if (_vehicle == player) exitWith {mutexScriptInProgress = false;};

//Check if player is still owner
if (_vehicle getVariable ['ownerUID',''] == getPlayerUID player) exitWith {
	titleText ["You are already owner of this Vehicle.", "PLAIN DOWN", 0.5];
	mutexScriptInProgress = false;
};

if (_eng) then {
	titleText ["Can't write Ownership while Engine is Running! Turn OFF within 10 seconds to retry...", "PLAIN DOWN", 0.5];
	sleep 10;
	_eng = isengineon _vehicle;
	if (_eng) exitWith {
	titleText ["Engine still running. Writing Ownership-Licence CANCELED!", "PLAIN DOWN", 0.5];
	sleep 2;
	titleText ["Bye, maybe next time!", "PLAIN DOWN", 0.5];
	mutexScriptInProgress = false;
	};
};

//set up prices
if((player == driver _vehicle) && (!_eng))then {
	_type = typeOf _vehicle;
	_playerMoney = player getVariable "cmoney";
	_price = 300;
	
	//find price from vehicle store prices
	{	
	if (_type == _x select 1) then
	{	
	_price = _x select 2;
	_price = _price / CANGEOWNER_PRICE_RELATIONSHIP;
	};
} forEach (call allVehStoreVehicles);


//Pre Engine check
_eng = isEngineOn _vehicle;
if (_eng) exitWith {
	titleText ["Engine is running. We're sorry you cancelled the deal!", "PLAIN DOWN", 0.5];
	sleep 2;
	titleText ["Bye, maybe next time!", "PLAIN DOWN", 0.5];
	mutexScriptInProgress = false;
};

	if (!isNil "_price") then 
	{
		// Add total sell value to confirm message
		_confirmMsg = format ["Ownership Licence for<br/>%1<br/>will costs you $%2 ...", _type, _price];

		// Display confirm message
		if ([parseText _confirmMsg, "Altis - Ownership-Licence Office", "OK, BUY IT!", true] call BIS_fnc_guiMessage) then
		{	
			// Ensure the player has enough money
			if (_price > _playerMoney) exitWith
			{
				titleText ["Try again with some money in bag!", "PLAIN DOWN", 0.5];
				playSound "FD_CP_Not_Clear_F";
				sleep 2;
				titleText ["Bye, maybe next time!", "PLAIN DOWN", 0.5];
				mutexScriptInProgress = false;
			};

			// get everyone out of the vehicle
			_vehicleCrewArr = crew _vehicle;
			{
				_x action ["Eject", vehicle _x];
			} foreach _vehicleCrewArr;
			player setVariable["cmoney",(player getVariable "cmoney")-_price,true];
			player setVariable["timesync",(player getVariable "timesync")+(_price * 3),true];
			[] spawn fn_savePlayerData; // Changed call to spawn
			sleep 1;
			titleText ["Take a cup of coffee while handling.", "PLAIN DOWN", 0.5];
			_vehicle setVelocity [0,0,0];
			_vehicle setFuel 0;
			sleep 5;
			titleText ["Evaluating this vehicle...", "PLAIN DOWN", 0.5];
			sleep 5;
			titleText ["Carefully removing your current VIN tag.", "PLAIN DOWN", 0.5];
			sleep 5;
			titleText ["Installing locks.", "PLAIN DOWN", 0.5];
			sleep 5;
			titleText ["Adding new VIN tag.", "PLAIN DOWN", 0.5];
			sleep 5;		
			titleText ["Taking another coffee break.", "PLAIN DOWN", 0.5];
			sleep 5;
			titleText ["Forging title papers.", "PLAIN DOWN", 0.5];
			sleep 5;
			titleText ["Finishing up and refuelling.", "PLAIN DOWN", 0.5];
			_vehicle setVelocity [0,0,0];
			_vehicle setFuel 1;
			_vehicle setVariable ["A3W_purchasedVehicle", true, true];
			_vehicle setVariable ["ownerUID", getPlayerUID player, true];
			_vehicle setVariable ["vehOwnerName", name player, true];
			_vehicle setVariable ["ownedVehicle", true, true];
			playSound "FD_Finish_F";
			sleep 2;
			titleText ["You are now Owner of this Vehicle!", "PLAIN DOWN", 0.5];
			sleep 0.5;
			titleText ["It was a pleasure! Come back soon!", "PLAIN DOWN", 0.5];
			mutexScriptInProgress = false;
		} else {
		titleText ["We're sorry you cancelled the deal.", "PLAIN DOWN", 0.5];
		sleep 2;
		titleText ["Bye, maybe next time!", "PLAIN DOWN", 0.5];
		mutexScriptInProgress = false;
		};
	} else {
		hint parseText "<t color='#ffff00'>An unknown error occurred.</t><br/>Cancelled.";
		playSound "FD_CP_Not_Clear_F";
		mutexScriptInProgress = false;
	};
};	
