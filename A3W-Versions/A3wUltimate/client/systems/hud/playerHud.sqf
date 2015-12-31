// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: playerHud.sqf
//	@file Author: [404] Deadbeat, [GoT] JoSchaap, [KoS] Bewilderbeest
//	@file Created: 11/09/2012 04:23
//	@file Args:

#define hud_status_idc 3600
#define hud_vehicle_idc 3601
#define hud_activity_icon_idc 3602
#define hud_activity_textbox_idc 3603



scriptName "playerHud";

disableSerialization;
private ["_lastHealthReading", "_lastTerritoryName", "_lastTerritoryDescriptiveName", "_territoryCaptureIcon", "_activityIconOrigPos", "_activityTextboxOrigPos", "_dispUnitInfo", "_topLeftBox", "_topLeftBoxPos"];

_lastHealthReading = 100; // Used to flash the health reading when it changes



_unlimitedStamina = ["A3W_unlimitedStamina"] call isConfigOn;
_atmEnabled = ["A3W_atmEnabled"] call isConfigOn;

private ["_globalVoiceTimer", "_globalVoiceWarnTimer", "_globalVoiceWarning", "_globalVoiceMaxWarns", "_globalVoiceTimestamp"];

_globalVoiceTimer = 0;
_globalVoiceWarnTimer = ["A3W_globalVoiceWarnTimer", 5] call getPublicVar;
_globalVoiceWarning = 0;
_globalVoiceMaxWarns = ceil (["A3W_globalVoiceMaxWarns", 5] call getPublicVar);

private ["_mapCtrls", "_mapCtrl"];

while {true} do
{
	private ["_ui","_vitals","_hudVehicle","_health","_tempString","_yOffset","_vehicle"];

	1000 cutRsc ["WastelandHud","PLAIN",1e10];
	_ui = uiNameSpace getVariable "WastelandHud";
	_vitals = _ui displayCtrl hud_status_idc;
	_hudVehicle = _ui displayCtrl hud_vehicle_idc;
	_hudActivityIcon = _ui displayCtrl hud_activity_icon_idc;
	_hudActivityTextbox = _ui displayCtrl hud_activity_textbox_idc;

	
	
	//Calculate Health 0 - 100
	_health = ((1 - damage player) * 100) max 0;
	_health = if (_health > 1) then { floor _health } else { ceil _health };

	// Flash the health colour on the HUD according to it going up, down or the same
	_healthTextColor = "#FFFFFF";

	if (_health != _lastHealthReading) then
	{
		// Health change. Up or down?
		if (_health < _lastHealthReading) then
		{
			// Gone down. Red flash
			_healthTextColor = "#FF1717";
		}
		else
		{
			// Gone up. Green flash
			_healthTextColor = "#17FF17";
		};
	};

	// Make sure we keep a record of the health value from this iteration
	_lastHealthReading = _health;

	// Icons in bottom right

	_minimumBRs = 5;
	_strArray = [];

	if (_atmEnabled && (player getVariable ["baccount", 0] == 1)) then { _strArray pushBack format ["%1 <img size='0.7' image='client\icons\suatmm_icon.paa'/>", [player getVariable ["bmoney", 0]] call fn_numbersText] };
	_strArray pushBack format ["%1 <img size='0.7' image='client\icons\money.paa'/>", [player getVariable ["cmoney", 0]] call fn_numbersText];
	_strArray pushBack format ["%1 <img size='0.7' image='client\icons\water.paa'/>", ceil (thirstLevel max 0)];
	_strArray pushBack format ["%1 <img size='0.7' image='client\icons\food.paa'/>", ceil (hungerLevel max 0)];
	if (!_unlimitedStamina) then { _strArray pushBack format ["%1 <img size='0.7' image='client\icons\running_man.paa'/>", 100 - ceil ((getFatigue player) * 100)] };
	_strArray pushBack format ["<t color='%1'>%2</t> <img size='0.7' image='client\icons\health.paa'/>", _healthTextColor, _health];

	_str = "";

	for "_i" from 0 to (_minimumBRs - count _strArray) do
	{
		_str = _str + "<br/>";
	};

	{
		_str = _str + format ["%1%2", if (_forEachIndex > 0) then { "<br/>" } else { "" }, _x];
	} forEach _strArray;

	_vitals ctrlShow alive player;
	_vitals ctrlSetStructuredText parseText _str;
	_vitals ctrlCommit 0;

	_tempString = "";
	_yOffset = 0.26;

	if (isStreamFriendlyUIEnabled) then
	{
		_tempString = format ["<t color='#A0FFFFFF'>A3Wasteland %1<br/>www.a3wasteland.com</t>", getText (configFile >> "CfgWorlds" >> worldName >> "description")];
		_yOffset = 0.28;

		_hudVehicle ctrlSetStructuredText parseText _tempString;

		_x = safeZoneX + (safeZoneW * (1 - (0.42 / SafeZoneW)));
		_y = safeZoneY + (safeZoneH * (1 - (_yOffset / SafeZoneH)));
		_hudVehicle ctrlSetPosition [_x, _y, 0.4, 0.65];
	}
	else
	{
		if (player != vehicle player) then
		{
			_yOffset = 0.24;
			_vehicle = assignedVehicle player;

			{
				_icon = switch (true) do
				{
					case (driver _vehicle == _x): { "client\icons\driver.paa" };
					case (gunner _vehicle == _x): { "client\icons\gunner.paa" };
					default                       { "client\icons\cargo.paa" };
				};

				_tempString = format ["%1 %2 <img image='%3'/><br/>", _tempString, name _x, _icon];
				_yOffset = _yOffset + 0.04;
			} forEach crew _vehicle;
		};
	};

	_hudVehicle ctrlSetStructuredText parseText _tempString;
	_x = safeZoneX + (safeZoneW * (1 - (0.42 / SafeZoneW)));
	_y = safeZoneY + (safeZoneH * (1 - (_yOffset / SafeZoneH)));
	_hudVehicle ctrlSetPosition [_x, _y, 0.4, 0.65];
	_hudVehicle ctrlCommit 0;

	// Territory system! Uses two new boxes in the top left of the HUD. We
	// can extend the system later to encompas other activities
	//
	// This does nothing if the system is not enabled, as TERRITORY_ACTIVITY is never set
	_activityIconStr = "";
	_activityMessage = "";
	_activityBackgroundAlpha = 0;

	

	_hudActivityIcon ctrlSetBackgroundColor [0, 0, 0, _activityBackgroundAlpha];
	_hudActivityIcon ctrlSetStructuredText parseText _activityIconStr;
	_hudActivityIcon ctrlCommit 0;

	_hudActivityTextbox ctrlSetBackgroundColor [0, 0, 0, _activityBackgroundAlpha];
	_hudActivityTextbox ctrlSetStructuredText parseText _activityMessage;
	_hudActivityTextbox ctrlCommit 0;

	// Remove unrealistic blur effects
	if (!isNil "BIS_fnc_feedback_damageBlur" && {ppEffectCommitted BIS_fnc_feedback_damageBlur}) then { ppEffectDestroy BIS_fnc_feedback_damageBlur };
	if (!isNil "BIS_fnc_feedback_fatigueBlur" && {ppEffectCommitted BIS_fnc_feedback_fatigueBlur}) then { ppEffectDestroy BIS_fnc_feedback_fatigueBlur };

	// Global voice warning system
	if (_globalVoiceWarnTimer > 0 && _globalVoiceMaxWarns > 0) then
	{
		if (!isNull findDisplay 55 && ctrlText (findDisplay 63 displayCtrl 101) == localize "str_channel_global") then
		{
			if (isNil "_globalVoiceTimestamp") then
			{
				_globalVoiceTimestamp = diag_tickTime;
			}
			else
			{
				_globalVoiceTimer = _globalVoiceTimer + (diag_tickTime - _globalVoiceTimestamp);

				if (_globalVoiceTimer >= _globalVoiceWarnTimer) then
				{
					_globalVoiceWarning = _globalVoiceWarning + 1;
					_globalVoiceTimestamp = diag_tickTime;
					_globalVoiceTimer = 0;

					_msgTitle = format ["Warning %1 of %2", _globalVoiceWarning, _globalVoiceMaxWarns];

					if (_globalVoiceWarning < _globalVoiceMaxWarns) then
					{
						uiNamespace setVariable ["BIS_fnc_guiMessage_status", false];
						["Please stop using the global voice channel, or you will be killed and crashed.", _msgTitle] spawn BIS_fnc_guiMessage;
					}
					else
					{
						_globalVoiceTimestamp = 1e11;
						_msgTitle spawn
						{
							setPlayerRespawnTime 1e11;
							player setDamage 1;
							uiNamespace setVariable ["BIS_fnc_guiMessage_status", false];
							_msgBox = ["You have exceeded the tolerance limit for using the global voice channel. Goodbye.", _this] spawn BIS_fnc_guiMessage;
							_time = diag_tickTime;
							waitUntil {scriptDone _msgBox || diag_tickTime - _time >= 5};
							preprocessFile "client\functions\quit.sqf"; // CTD
						};
					};
				};
			};
		}
		else
		{
			_globalVoiceTimestamp = nil;
		};
	};

	if (isNil "_mapCtrls") then
	{
		_mapCtrls =
		[
			[{(uiNamespace getVariable ["RscDisplayAVTerminal", displayNull]) displayCtrl 51}, controlNull]/*, // UAV Terminal
			[{artilleryComputerDisplayGoesHere displayCtrl 500}, controlNull]*/  // Artillery computer - cannot be enabled until this issue is resolved: http://feedback.arma3.com/view.php?id=21546
		];
	};

	if (!isNil "A3W_mapDraw_eventCode") then
	{
		// Add custom markers and lines to misc map controls
		{
			if (isNull (_x select 1)) then
			{
				_mapCtrl = call (_x select 0);

				if (!isNull _mapCtrl) then
				{
					_mapCtrl ctrlAddEventHandler ["Draw", A3W_mapDraw_eventCode];
					_x set [1, _mapCtrl];
				};
			};
		} forEach _mapCtrls;
	};

	uiSleep 1;
};
