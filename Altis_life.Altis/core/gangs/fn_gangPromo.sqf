#include <macro.h>
/*
fn_gangPromo.sqf
Kevin Webb
Description: Promote or demote your LBData.
*/
private["_unit","_unitID","_members"];
disableSerialization;

if((lbCurSel 2621) == -1) exitWith {hint "You didn't select anyone"};
_unit = call compile format["%1",getSelData(2621)];
if(isNull _unit) exitWith {}; /*Bad unit?*/
_exit = false;
if(_unit == player) exitWith {hint "A self promotion? Seems legit."};
if(life_gang_rank < 4 || (_unit getVariable["gang_rank",1] > 3 && life_gang_rank < 5)) exitWith {hint "You do not have the authority to promote or demote this person"};
_unitID = getPlayerUID _unit;
_rank = _unit getVariable "gang_rank";
_promote = [
"Would you like to promote or demote the selected gang member?",
"Rank Management",
"Promote",
"Demote"
] call BIS_fnc_guiMessage;
if(_promote) then {
	if(_unit getVariable["gang_rank",1] > 2 && life_gang_rank < 5) exitWith{hint "You do not have the authority to promote this person"; _exit = true};
	if(_unit getVariable["gang_rank",1] > 3) exitWith {hint "You cannot promote them to leader this way, you must set them as the leader instead."; _exit = true};
	_rank = _rank + 1;
} else {
if(_unit getVariable["gang_rank",1] < 2) exitWith {hint "You can not demote lower than this rank, kick them instead."; _exit = true;};
	_rank = _rank - 1;
};
if(_exit) exitWith {};
_unit setvariable["gang_rank",_rank,true];
["life_gang_rank",_rank] remoteExec ["life_fnc_netSetVar",_unit];
_ranknew = switch(_rank) do {
			case 1: {"Probie"};
			case 2: {"Soldier"};
			case 3: {"Lieutenant"};
			case 4: {"Underboss"};
		};
hint format["The rank of %1 has been changed to %2",name _unit,_ranknew];
[6,grpNull,_unitID,_rank] remoteExec ["TON_fnc_updateGang",2];
[] call life_fnc_gangMenu;