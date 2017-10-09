/*
	File: fn_vehicleStore.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Stores the vehicle in the 'Garage'
*/
private["_vehicle","_impound","_vInfo","_plate","_uid","_query","_sql","_unit"];
_vehicle = param [0,ObjNull,[ObjNull]];
_impound = param [1,false,[true]];
_unit = param [2,ObjNull,[ObjNull]];
_virtItems = [];
_inventory = getItemCargo _vehicle;

if(isNull _vehicle OR isNull _unit) exitWith {
	["life_impound_inuse",false] remoteExec ["life_fnc_netSetVar",_unit,false];
	["life_garage_store",false] remoteExec ["life_fnc_netSetVar",_unit,false];						
}; /*Bad data passed.*/

_vInfo = _vehicle getVariable["dbInfo",[]];
if(count _vInfo > 0) then
{
	_plate = _vInfo select 1;
	_uid = _vInfo select 0;
};

if(_impound) then
{
	if(count _vInfo == 0) then 
	{
		["life_impound_inuse",false] remoteExec ["life_fnc_netSetVar",_unit,false];		
		if(!isNil "_vehicle" && {!isNull _vehicle}) then {
			deleteVehicle _vehicle;
		};
	} 
	else
	{
		_query = format["UPDATE vehicles SET active='0', inventory='%3', virtItems='%4', fuel='%5' WHERE pid='%1' AND plate='%2'",_uid,_plate,_inventory,_virtItems, fuel _vehicle];
		
		_thread = [_query,1] call DB_fnc_asyncCall;
		if(!isNil "_vehicle" && {!isNull _vehicle}) then {
			deleteVehicle _vehicle;
		};
		["life_impound_inuse",false] remoteExec ["life_fnc_netSetVar",_unit,false];
	};
}
else
{
	if(count _vInfo == 0) exitWith
	{
		[1,"You cannot store this vehicle, as it is a rental."] remoteExec ["life_fnc_broadcast",_unit,false];
		["life_garage_store",false] remoteExec ["life_fnc_netSetVar",_unit,false];				
	};
	
	_query = format["UPDATE vehicles SET active='0', inventory='%3', virtItems='%4', fuel='%5' WHERE pid='%1' AND plate='%2'",_uid,_plate,_inventory,_virtItems, fuel _vehicle];
	
	_thread = [_query,1] call DB_fnc_asyncCall;
	if(!isNil "_vehicle" && {!isNull _vehicle}) then {
		deleteVehicle _vehicle;
	};
	["life_garage_store",false] remoteExec ["life_fnc_netSetVar",_unit,false];				
	[1,"You have successfully stored your vehicle in the garage."] remoteExec ["life_fnc_broadcast",_unit,false];
};