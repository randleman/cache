// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: init.sqf
//	@file Author: AgentRev, MercifulFate, [K-TTT] Randleman

private ["_path", "_condition", "_action"];
_path = _this;


mf_items_missionrewardexchange_can_access = [_path, "can_access.sqf"] call mf_compile;

mf_items_missionrewardexchange_access = [_path, "access.sqf"] call mf_compile;

mf_items_missionrewardexchange_nearest = {
    _missionrewardexchange = objNull;
    _missionrewardexchanges = nearestObjects [player, ["Land_Device_assembled_F"], 10];
    if (count _missionrewardexchanges > 0) then {
        _missionrewardexchange = _missionrewardexchanges select 0;
    };
    _missionrewardexchange;
} call mf_compile;



_condition = "call mf_items_missionrewardexchange_can_access == ''";
_action = ["<img image='client\icons\exchange.paa'/> Exchange Missionreward", mf_items_missionrewardexchange_access, [], 10, true, true, "", _condition];
["missionrewardexchange-access", _action] call mf_player_actions_set;
