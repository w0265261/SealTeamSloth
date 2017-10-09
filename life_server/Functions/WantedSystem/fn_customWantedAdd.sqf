/*
	File: fn_customWantedAdd.sqf
	Author: Kevin Webb
	
	Description:
	Custom wanted adding, inb4 ridiculous shit in the wanted list.
*/
private["_uid","_type","_index","_data","_crimes","_val","_name"];
_uid = param [0,"",[""]];
_name = param [1,"",[""]];
_type = param [2,["",0]];
_unit = param [3,ObjNull,[ObjNull]];
_details = param[4,[]];

_index = [_uid,life_wanted_list] call fnc_index;

if(_index != -1) then
{
	_data = life_wanted_list select _index;
	_crimes = _data select 2;
	_crimes pushBack [(_type select 0),_details];
	_val = _data select 3;
	life_wanted_list set[_index,[_name,_uid,_crimes,(_type select 1) + _val]];
	[[_name,_uid,_crimes,(_type select 1) + _val],_uid] spawn TON_fnc_saveBounties;
}
	else
{
	life_wanted_list pushBack [_name,_uid,[[(_type select 0),_details]],(_type select 1)];
	[[_name,_uid,[[(_type select 0),_details]],(_type select 1)],_uid] spawn TON_fnc_saveBounties;
};
[true] remoteExec ["life_fnc_amIWanted",_unit,false];
publicVariable "life_wanted_list";