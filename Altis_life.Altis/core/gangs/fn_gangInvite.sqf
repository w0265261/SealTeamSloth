#include <macro.h>
/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Prompts the player about an invite.
*/
private["_name","_group"];
_name = param [0,"",[""]];
_group = param [1,grpNull,[grpNull]];
if(_name == "" OR isNull _group) exitWith {}; /*Fail horn anyone?*/
if(!isNil {(group player) getVariable "gang_name"}) exitWith {hint "You are already in a gang"};

_gangName = _group getVariable "gang_name";
_action = [
	format[localize "STR_GNOTF_InviteMSG",_name,_gangName],
	localize "STR_Gang_Invitation",
	localize "STR_Global_Yes",
	localize "STR_Global_No"
] call BIS_fnc_guiMessage;

if(_action) then {
	[player] join _group;
	[4,_group,getPlayerUID player,true] remoteExec ["TON_fnc_updateGang",2];
	life_gang_rank = 1;
	player setVariable["gang_rank",life_gang_rank,true];
};