/*
	File: fn_vehicleCreate.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Answers the query request to create the vehicle in the database.
*/
private["_uid","_side","_type","_classname","_color","_plate","_stolen"];
_uid = param [0,"",[""]];
_side = param [1,sideUnknown,[west]];
_vehicle = param [2,ObjNull,[ObjNull]];
_color = param [3,-1,[0]];
_stolen = param [4,0,[0]];

/*Error checks*/
if(_uid == "" OR _side == sideUnknown OR isNull _vehicle) exitWith {};
if(!alive _vehicle || isNull _vehicle) exitWith {};
if(_stolen == 1) then {
	_dbInfo = _vehicle getVariable["dbInfo",[]];
	if(count _dbInfo == 0) exitWith {};
	_ouid = _dbInfo select 0;
	_oplate = _dbInfo select 1;

	_query = format["UPDATE vehicles SET alive='0' WHERE pid='%1' AND plate='%2'",_ouid,_oplate];

	
	[_query,1] call DB_fnc_asyncCall;
};
_className = typeOf _vehicle;
_type = switch(true) do
{
	case (_vehicle isKindOf "Car"): {"Car"};
	case (_vehicle isKindOf "Air" || _className in["Land_Pod_Heli_Transport_04_covered_F","Land_Pod_Heli_Transport_04_bench_F"]): {"Air"};
	case (_vehicle isKindOf "Ship"): {"Ship"};
};
_side = switch(_side) do
{
	case west:{"cop"};
	case civilian: {"civ"};
	case independent: {"med"};
	default {"Error"};
};
_plate = round(random(1000000));
[_uid,_side,_type,_classname,_color,_plate,_stolen] call DB_fnc_insertVehicle;
if(_stolen == 1) exitWith { deleteVehicle _vehicle; };
_vehicle setVariable["dbInfo",[_uid,_plate],true];