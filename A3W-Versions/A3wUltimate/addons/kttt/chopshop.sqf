//	@file Name: chopshop.sqf
//	@file Author: Cael817, Lodac, Wiking, Gigatek (original auth)
// [K-TTT] Randleman customized for well work :P

#define CHOPSHOP_PRICE_RELATIONSHIP 2

private ["_vehicle", "_driver", "_eng", "_type", "_price", "_confirmMsg", "_vehicleCrewArr", "_cash"];
_vehicle = vehicle player;
_driver = driver _vehicle;
_eng = isengineon _vehicle;
_vehicle setVelocity [0,0,0];

titleText ["Welcome to Altis Chop Shop!", "PLAIN DOWN", 0.5];
sleep 1;
// Check if mutex lock is active.
if (mutexScriptInProgress) exitWith
{
	titleText ["You are already performing another action.", "PLAIN DOWN", 0.5];
};
mutexScriptInProgress = true;

//check if caller is in vehicle
if (_vehicle == player) exitWith {mutexScriptInProgress = false;};


if (_eng) then {
	titleText ["Can't chop while Engine is Running! Turn OFF within 10 seconds to chop...", "PLAIN DOWN", 0.5];
	sleep 10;
	_eng = isengineon _vehicle;
	if (_eng) exitWith {
	titleText ["Engine still running. Chopping CANCELED!", "PLAIN DOWN", 0.5];
	sleep 2;
	titleText ["Bye, maybe next time!", "PLAIN DOWN", 0.5];
	mutexScriptInProgress = false;
	};
};

//set up prices
if((player == driver _vehicle) && (!_eng))then {
	_type = typeOf _vehicle;
	_price = 300;
	
	//find price from vehicle store prices
	{	
	if (_type == _x select 1) then
	{	
	_price = _x select 2;
	_price = _price / CHOPSHOP_PRICE_RELATIONSHIP;
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
		_confirmMsg = format ["Dismantling<br/>%1<br/>will bring you $%2 ...", _type, _price];

		// Display confirm message
		if ([parseText _confirmMsg, "Altis - Chop Shop", "OK, CHOP IT!", true] call BIS_fnc_guiMessage) then
		{	
			// get everyone out of the vehicle
			_vehicleCrewArr = crew _vehicle;
			{
				_x action ["Eject", vehicle _x];
			} foreach _vehicleCrewArr;
			sleep 1;
			titleText ["Take a cup of coffee while chopping", "PLAIN DOWN", 0.5];
			_vehicle setVelocity [0,0,0];
			_vehicle setFuel 0;
			_vehicle setVehicleAmmo 0;
			sleep 5;
			_vehicle animate ["HideBackpacks", 1];
			sleep 1;
			_vehicle animate ["HideBumper1", 1];
			sleep 1;
			_vehicle animate ["HideBumper2", 1];
			sleep 1;
			_vehicle animate ["HideDoor1", 1];
			sleep 1;		
			_vehicle animate ["HideDoor2", 1];
			sleep 1;
			_vehicle animate ["HideDoor3", 1];
			sleep 1;
			deleteVehicle _vehicle;
			sleep 1;
			titleText ["Chop done!", "PLAIN DOWN", 0.5];
			sleep 2;
			titleText ["We will put your money on the table!", "PLAIN DOWN", 0.5];
			sleep 8;
			_cash = createVehicle ["Land_Money_F", [13951.341,15145.745,0.85], [], 5, "None"];
			_cash setPos [13951.341,15145.745,0.85];
			_cash setDir random 360;
			_cash enableSimulation false;
			_cash setVariable ["cmoney", _price, true];
			_cash setVariable ["owner", "world", true];
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