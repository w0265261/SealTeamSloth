/*
	File: fn_placeObject.sqf
	Author: John "Paratus" VanderZwet
	compatibility edits for STS by Kevin
	
	Description:
	Places an object in the world.
*/
private ["_item","_index","_object"];

_item = param [0,"",[""]];
if (_item == "") exitWith {hint "null item"};

closeDialog 0;

if (!isNull life_placing) exitWith {hint "You are already placing another object.";};

_index = [_item,life_placeable] call fnc_index;
if (_index < 0) exitWith {hint "index is less than 0"};

if(_item == "shank") exitWith {
_object = "Land_File_F" createVehicle [0,0,0];  
_object attachTo[player,[-.02,.05,0], "righthandmiddle1"];  
_object setDir 180;
_object setVariable["owner",true,true];

life_placing = _object;
_object enableSimulation false;
_object allowDamage false;
};

_object = ((life_placeable select _index) select 1) createVehicle [0,0,0];
_object attachTo[player,[0,5.5,((life_placeable select _index) select 3)]];
_object setDir 0;
_object setVariable["owner",true,true];

life_placing = _object;
_object enableSimulation false;
_object allowDamage false;