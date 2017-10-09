/*
	File: fn_spawnVehicle.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Sends the query request to the database, if an array is returned then it creates
	the vehicle if it's not in use or dead.
*/
private["_vid","_sp","_pid","_query","_sql","_vehicle","_nearVehicles","_name","_side","_dir","_cargo","_trunk","_color"];
_vid = param [0,-1,[0]];
_pid = param [1,"",[""]];
_sp = param [2,[],[[],""]];
_unit = param [3,ObjNull,[ObjNull]];
_price = param [4,0,[0]];
_dir = param [5,0,[0]];
_unit_return = _unit;
_name = name _unit;
_side = side _unit;
_exit = false;
//_unit = owner _unit;

if(_vid == -1 OR _pid == "") exitWith {};
if(_vid in serv_sv_use) exitWith {};
serv_sv_use pushBack _vid;

_query = format["SELECT side, classname, pid, alive, active, plate, color, stolen, inventory, virtItems, insured, tracked, alarm, fuel FROM vehicles WHERE id='%1' AND pid='%2'",_vid,_pid];

_vInfo = [_query,2] call DB_fnc_asyncCall;

if(typeName _vInfo == "STRING") exitWith {};

if(isNil "_vInfo") exitWith {serv_sv_use = serv_sv_use - [_vid];};
if(count _vInfo == 0) exitWith {serv_sv_use = serv_sv_use - [_vid];};
_cargo = _vInfo select 8;
if((_vInfo select 3) == 0) exitWith
{
	serv_sv_use = serv_sv_use - [_vid];
	[1,format[(localize "STR_Garage_SQLError_Destroyed"),_vInfo select 1]] remoteExec ["life_fnc_broadcast",_unit,false];
	_exit = true;
};

if((_vInfo select 4) == 1) exitWith
{
	serv_sv_use = serv_sv_use - [_vid];
	[1,format[(localize "STR_Garage_SQLError_Active"),_vInfo select 1]] remoteExec ["life_fnc_broadcast",_unit,false];
	_exit = true;
};

if(typeName _sp != "STRING") then {
	_nearVehicles = nearestObjects[_sp,["Car","Air","Ship"],10];
} else {
	_nearVehicles = [];
};
if(count _nearVehicles > 0) exitWith
{
	serv_sv_use = serv_sv_use - [_vid];
	[_price,_unit_return] remoteExec ["life_fnc_garageRefund",_unit,false];
	[1,"There is a vehicle on the spawn point, you have been refunded your pullout cost."] remoteExec ["life_fnc_broadcast",_unit,false];
	_exit = true;
};
if(_exit) exitWith {};

_query = format["UPDATE vehicles SET active='1' WHERE pid='%1' AND id='%2'",_pid,_vid];


[_query,1] spawn DB_fnc_asyncCall;
_vehicle = createVehicle [(_vInfo select 1),_sp,[],0,"NONE"];
waitUntil {!isNil "_vehicle" && {!isNull _vehicle}};
_vehicle allowDamage false;
_vehicle setPos _sp;
_vehicle setVectorUp (surfaceNormal _sp);
_vehicle setDir _dir;
if((_vInfo select 0) == "med") then { _vehicle setVariable["medic",true,true]; };
/*Send keys over the network.*/
[_vehicle] remoteExec ["life_fnc_addVehicle2Chain",_unit,false];

_vehicle lock 2;
_vehicle enableRopeAttach false;
/*Reskin the vehicle */
_color = _vInfo select 6;
[_vehicle,_color] remoteExec ["life_fnc_colorVehicle",0];
_vehicle setVariable["vehicle_info_owners",[[_pid,_name]],true];
_vehicle setVariable["dbInfo",[(_vInfo select 2),_vInfo select 5],true];
[_vehicle,_cargo] remoteExec ["life_fnc_clearVehicleAmmo",_unit,false];
[_vehicle] call TON_fnc_clearAmmo;
if(typeOf _vehicle == "I_MRAP_03_F") then { _vehicle disableTIEquipment true; };

/*Sets of animations*/
if((_vInfo select 0) == "civ" && {(_vInfo select 1) == "B_Heli_Light_01_F"} && {typeName _color == "SCALAR"} && {_color != 13}) then
{
	[_vehicle,"civ_littlebird",true] remoteExec ["life_fnc_vehicleAnimate",_unit,false];
};

if((_vInfo select 0) == "cop" && (_vInfo select 1) in ["C_Offroad_01_F","B_MRAP_01_F","C_SUV_01_F"]) then
{
	[_vehicle,"cop_offroad",true,_color] remoteExec ["life_fnc_vehicleAnimate",_unit,false];
};
if((_vInfo select 0) == "cop") then 
{ 
	_vehicle setVariable ["copCar",true,true]; 
	_vehicle setVariable ["unit",0,true];		
};
if((_vInfo select 0) == "med" && (_vInfo select 1) == "C_Offroad_01_F") then
{
	[_vehicle,"med_offroad",true] remoteExec ["life_fnc_vehicleAnimate",_unit,false];
};
if((_vinfo select 7) == 1) then
{
	_vehicle setVariable["stolen",true,true];
};
_trunk = _vInfo select 9;
if(count _trunk != 0) then {
_vehicle setVariable["trunk",_trunk,true];
};
if(_vInfo select 10 == 1) then {
	_vehicle setVariable["isInsured",true,true];
	[_vehicle] spawn TON_fnc_vehicleInsurance;
};
if(_vInfo select 10 == 1 || _vInfo select 11 == 1) then {
	[_vehicle,true] remoteExec ["life_fnc_gpsTracker",_unit,false];
};
if(_vInfo select 10 == 1 || _vInfo select 12 == 1) then {
	_vehicle setVariable["alarm",true,true];
};
_vehicle setFuel (_vInfo select 13);
[1,"Your vehicle is ready!"] remoteExec ["life_fnc_broadcast",_unit,false];
_vehicle spawn {
sleep 5;
_this allowDamage true;
};
serv_sv_use = serv_sv_use - [_vid];