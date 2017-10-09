/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Fetches all the players houses and sets them up.
*/
private["_query","_houses","_queryResult"];

_query = format["SELECT pid, pos, inventory, containers FROM houses WHERE owned='1' AND (pid='%1' OR leasers LIKE '%2%1%2')",_this,"%"];

_houses = [_query,2,true] call DB_fnc_asyncCall;


_return = [];
{
	_pos = call compile format["%1",_x select 1];
	_house = nearestBuilding _pos;
	_house allowDamage false;
	if(isNil {(_house getVariable "containers")}) then {

		_trunk = _x select 2;
		_containerData = _x select 3;
		_house setVariable["Trunk",_trunk,true];
		_house setVariable["containers",_containerData,true];
	};
	_return pushBack (_x select 1);
} foreach _houses;

missionNamespace setVariable[format["houses_%1",_this],_return];


_query = format["SELECT gangs.id, gangs.owner, gangs.name, gangs.bank, players.gangrank FROM gangs INNER JOIN players ON gangs.id=players.gangid WHERE gangs.active='1' AND players.playerid='%1'",_this];

_queryResult = [_query,2] call DB_fnc_asyncCall;

missionNamespace setVariable[format["gang_%1",_this],_queryResult];