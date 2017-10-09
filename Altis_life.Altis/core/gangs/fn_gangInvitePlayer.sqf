#include <macro.h>
/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the invite process?
*/
private["_unit"];
disableSerialization;

if((lbCurSel 2632) == -1) exitWith {hint localize "STR_GNOTF_SelectPerson"};
_unit = call compile format["%1",getSelData(2632)];
if(isNull _unit) exitWith {}; /*Bad unit?*/
if(_unit == player) exitWith {hint localize "STR_GNOTF_InviteSelf"};
if(life_gang_rank < 2) exitWith {hint "You do not have the authority to invite players to the gang"};
_exit = false;
{if(_unit in (units(_x select 1))) exitWith {_exit = true};} forEach life_gang_list;
if(!isNil {(group _unit) getVariable "gang_name"} || _exit)  exitWith {hint "This player is already in a gang or temporary group."};
if(_unit getVariable["restrained",false] || _unit getVariable["ziptie",false]) exitWith {hint "This player is currently occupied in restraints, try again later"};

_action = [
	format[localize "STR_GNOTF_InvitePlayerMSG",_unit getVariable ["realname",name _unit]],
	localize "STR_Gang_Invitation",
	localize "STR_Global_Yes",
	localize "STR_Global_No"
] call BIS_fnc_guiMessage;

if(_action) then {
	_gang = group player getVariable "gang_id";
	hint format[localize "STR_GNOTF_InviteSent",_unit getVariable["realname",name _unit]];
	[profileName,group player,_gang] remoteExec ["life_fnc_gangInvite",_unit];
} else {
	hint localize "STR_GNOTF_InviteCancel";
};