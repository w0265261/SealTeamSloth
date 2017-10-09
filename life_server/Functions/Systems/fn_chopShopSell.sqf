/*
	File: fn_chopShopSell.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Checks whether or not the vehicle is persistent or temp and sells it.
*/
if(life_chopping) exitWith {};
private["_unit","_vehicle","_price","_cash"];
_unit = param [0,objNull,[objNull]];
_vehicle = param [1,objNull,[objNull]];
_price = param [2,500,[0]];
/*_cash = param [3,0,[0]];*/

/*Error checks*/
if(isNull _vehicle OR isNull _unit) exitWith 
{
	["life_action_inUse",false] remoteExec ["life_fnc_netSetVar",0];
};
life_chopping = true;
_displayName = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
//_unit = owner _unit;

_dbInfo = _vehicle getVariable["dbInfo",[]];
if(count _dbInfo > 0) then {
	_uid = _dbInfo select 0;
	_plate = _dbInfo select 1;

	_query = format["UPDATE vehicles SET alive='0' WHERE pid='%1' AND plate='%2'",_uid,_plate];
	
	_sql = [_query,1] call DB_fnc_asyncCall;
};

deleteVehicle _vehicle;
["life_action_inUse",false] remoteExec ["life_fnc_netSetVar",_unit,false];
[2,format[(localize "STR_NOTF_ChopSoldCar"),_displayName,[_price] call life_fnc_numberText]] remoteExec ["life_fnc_broadcast",_unit,false];
["cash","add",_price] remoteExec ["life_fnc_handlePaper",_unit,false];
life_chopping = false;