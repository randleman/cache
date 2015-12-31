// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: checkFish.sqf
//	@file Author: Tonic, [K-TTT] Randleman

private["_curTarget"];
_curTarget = cursorTarget;

if(isNull _curTarget) exitWith {
	private["_animal"];
	_animal = (nearestObjects[getPos player,["Animal_Base_F"],3]) select 0;
	if(!isNil "_animal") then {
		[_animal] call fn_catchAnimal;
	};
};