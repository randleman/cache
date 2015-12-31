// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: fn_manualObjectSave.sqf
//	@file Author: AgentRev

#define MANUAL_OBJ_SAVE_COOLDOWN 5

private "_obj";
_obj = _this;

if (typeName _obj == "STRING") then { _obj = objectFromNetId _obj };

if (diag_tickTime - (_obj getVariable ["objSaving_lastSave", 0]) > MANUAL_OBJ_SAVE_COOLDOWN) then
{
	if (_obj call fn_isObjectSaveable && call A3W_savingMethod == "extDB") then
	{
		[_obj, nil, true] spawn fn_saveObject;
	};

	_obj setVariable ["objSaving_lastSave", diag_tickTime];
};
