/*
	File: fn_colorVehicle.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Reskins the vehicle
*/
private["_vehicle","_index","_texture","_texture2","_texture3","_texture4"];
_vehicle = param [0,Objnull,[Objnull]];
_index = _this select 1;
if(isNull _vehicle OR !alive _vehicle) exitWith {};
if(typeName _index == "ARRAY") exitWith {
	{_vehicle setObjectTexture _x} forEach _index;
	if(local _vehicle) then
	{
		_vehicle setVariable["Life_VEH_color",_index,true];
	};
};
_index = param [1,-1,[0]];
if(_index == -1) exitWith {};
_texture = [(typeOf _vehicle)] call life_fnc_vehicleColorCfg;
if(isNil "_texture") exitWith {};
if(count _texture == 0) exitWith {};
if(count (_texture select _index) > 2) then {_texture2 = (_texture select _index) select 2;};
if(count (_texture select _index) > 3) then {_texture3 = (_texture select _index) select 3;};
if(count (_texture select _index) > 4) then {_texture4 = (_texture select _index) select 4;};
_texture = _texture select _index;
if(typeName _texture == "ARRAY") then { _texture = _texture select 0;};

/*Local to us? Set it's color.*/
if(local _vehicle) then
{
	_vehicle setVariable["Life_VEH_color",_index,true];
};

waitUntil{!isNil {_vehicle getVariable "Life_VEH_color"}};

_vehicle setObjectTexture[0,_texture];
if(!isNil "_texture2") then
{
	_vehicle setObjectTexture[1,_texture2];
};
if(!isNil "_texture3") then
{
	_vehicle setObjectTexture[2,_texture3];
};
if(!isNil "_texture4") then
{
	_vehicle setObjectTexture[3,_texture4];
};
if(typeOf _vehicle == "C_Offroad_01_F") then
{
	if(_index < 5) then
	{
		_vehicle setObjectTexture[1,_texture];
	};
};