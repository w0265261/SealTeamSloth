#include <macro.h>
/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	31 hours of no sleep screw your description.
*/
private["_ownerID","_gangBank","_gangName","_members","_allUnits","_ctrl"];
disableSerialization;
if(isNull (findDisplay 2620)) then {
	if(!(createDialog "STS_Life_My_Gang_Diag")) exitWith {}; /*NOOOOOOOOOOOOOOOOOOOOOOOoooooooooooooOOOOOOOOOOOOOOOOOOOOOOOOOOO00000000000000oooooo*/
};

_ownerID = group player getVariable["gang_owner",""];
if(_ownerID == "") exitWith {closeDialog 0;}; /*Bad juju*/
_gangName = group player getVariable "gang_name";
_gangBank = group player getVariable "gang_bank";

if(_ownerID != getPlayerUID player) then {
	//(getControl(2620,2622)) ctrlEnable false; /*Upgrade*/
	//(getControl(2620,2624)) ctrlEnable false; /* Kick*/
	(getControl(2620,2625)) ctrlEnable false; /*Set New Leader*/
	//(getControl(2620,2630)) ctrlEnable false; /*Invite Player*/
	(getControl(2620,2631)) ctrlEnable false; /*Disband Gang*/
};

(getControl(2620,2629)) ctrlSetText _gangName;
(getControl(2620,601)) ctrlSetText format["Gang Funds: $%1",[_gangBank] call life_fnc_numberText];

/*Loop through the players.*/
_members = getControl(2620,2621);
lbClear _members;
{
	if((getPlayerUID _x) == _ownerID) then {
		_members lbAdd format["%1 - Captain",(_x getVariable["realname",name _x])];
		_members lbSetData [(lbSize _members)-1,str(_x)];
	} else {
		_rank = switch(_x getVariable["gang_rank",1]) do {
			case 1: {"Probie"};
			case 2: {"Soldier"};
			case 3: {"Lieutenant"};
			case 4: {"Underboss"};
		};
		_members lbAdd format["%1 - %2",(_x getVariable["realname",name _x]),_rank];
		_members lbSetData [(lbSize _members)-1,str(_x)];
	};
} foreach (units group player);

_grpMembers = units group player;
_allUnits = playableUnits;
/*Clear out the list..*/
{
	if(_x in _grpMembers OR (side _x != civilian) && isNil {(group _x) getVariable "gang_id"}) then {
		_allUnits set[_forEachIndex,-1];
	};
} foreach _allUnits;
_allUnits = _allUnits - [-1];

_ctrl = getControl(2620,2632);
lbClear _ctrl; /*Purge the list*/
{
	_ctrl lbAdd format["%1",_x getVariable["realname",name _x]];
	_ctrl lbSetData [(lbSize _ctrl)-1,str(_x)];
} foreach _allUnits;