/*
	File: fn_getVehicles.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Sends a request to query the database information and returns vehicles.
*/
private["_pid","_side","_type","_unit","_ret","_tickTime","_queryResult"];
_pid = param [0,"",[""]];
_side = param [1,sideUnknown,[west]];
_type = param [2,"",[""]];
_unit = param [3,ObjNull,[ObjNull]];

/*Error checks*/
if(_pid == "" OR _side == sideUnknown OR _type == "" OR isNull _unit) exitWith
{
	if(!isNull _unit) then
	{
		[[]] remoteExec ["life_fnc_impoundMenu",_unit,false];
	};
};

//_unit = owner _unit;
_side = switch(_side) do
{
	case west:{"cop"};
	case civilian: {"civ"};
	case independent: {"med"};
	default {"Error"};
};

if(_side == "Error") exitWith {
	[[]] remoteExec ["life_fnc_impoundMenu",_unit,false];
};

_query = format["SELECT id, classname, color, customName, insured, tracked, alarm, stolen FROM vehicles WHERE pid='%1' AND alive='1' AND active='0' AND side='%2' AND type='%3' AND listed < 1",_pid,_side,_type];

_queryResult = [_query,2,true] call DB_fnc_asyncCall;

{
	_x set[4,[_x select 4,1] call DB_fnc_bool];
	_x set[5,[_x select 5,1] call DB_fnc_bool];
	_x set[6,[_x select 6,1] call DB_fnc_bool];
	_x set[7,[_x select 7,1] call DB_fnc_bool];
} foreach _queryResult;
if(typeName _queryResult == "STRING") exitWith {
	[[]] remoteExec ["life_fnc_impoundMenu",_unit,false];
};

[_queryResult] remoteExec ["life_fnc_impoundMenu",_unit,false];