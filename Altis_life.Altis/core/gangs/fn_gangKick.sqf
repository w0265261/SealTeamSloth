#include <macro.h>
/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	32 hours...
*/
private["_unit","_unitID"];
disableSerialization;

if((lbCurSel 2621) == -1) exitWith {hint localize "STR_GNOTF_SelectKick"};
_unit = call compile format["%1",getSelData(2621)];
if(isNull _unit) exitWith {}; /*Bad unit?*/
if(_unit == player) exitWith {hint localize "STR_GNOTF_KickSelf"};
if(life_gang_rank < 4 || (_unit getVariable["gang_rank",1] > 3 && life_gang_rank < 5)) exitWith {hint "You do not have the authority to kick this person"};
_unitID = getPlayerUID _unit;

[_unit,group player,true] remoteExec ["clientGangKick",_unit]; /*Boot that bitch!*/
[4,group player,_unitID] remoteExec ["TON_fnc_updateGang",2];
[] call life_fnc_gangMenu;