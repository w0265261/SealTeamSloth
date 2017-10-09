#include <macro.h>
/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Something about being a quitter.
*/
private["_unit","_unitID","_action","_index"];
disableSerialization;

if((lbCurSel 2621) == -1) exitWith {hint localize "STR_GNOTF_TransferSelect"};
_unit = call compile format["%1",getSelData(2621)];
if(isNull _unit) exitWith {}; /*Bad unit?*/
if(_unit == player) exitWith {hint localize "STR_GNOTF_TransferSelf"};

_action = [
	format[localize "STR_GNOTF_TransferMSG",_unit getVariable ["realname",name _unit]],
	localize "STR_Gang_Transfer",
	localize "STR_Global_Yes",
	localize "STR_Global_No"
] call BIS_fnc_guiMessage;

if(_action) then {
	_unitID = getPlayerUID _unit;
	if(_unitID == "") exitWith {}; /*Unlikely?*/
	group player setVariable["gang_owner",_unitID,true];
	group player selectLeader _unit;
	life_gang_rank = 4;
	player setVariable["gang_rank",4,true];
	[_unit,group player,true] remoteExec ["clientGangLeader",_unit];
	[3,group player,_unitID] remoteExec ["TON_fnc_updateGang",2];
	[6,grpNull,getPlayerUID player,4] remoteExec ["TON_fnc_updateGang",2];
	[6,grpNull,_unitID,5] remoteExec ["TON_fnc_updateGang",2];
} else {
	hint localize "STR_GNOTF_TransferCancel";
};
[] call life_fnc_gangMenu;