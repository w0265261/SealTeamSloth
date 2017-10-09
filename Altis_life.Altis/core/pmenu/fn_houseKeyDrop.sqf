/*
	File: fn_housKeyDrop.sqf
	Author: Pennyworth
	
	Description:
	Drops house key
*/
private["_house","_index"];
_house = param [0,ObjNull,[ObjNull]];
life_vehicles = life_vehicles - [_house];
life_houses = life_houses - [_house];