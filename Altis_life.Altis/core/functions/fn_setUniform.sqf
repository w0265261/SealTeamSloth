/*
	File: fn_setUniform.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Sets given uniform texture to a unit, should be done MP
*/

private ["_unit","_texture"];
_unit = param [0,objNull,[objNull]];
_texture = param [1,"",[""]];

if(isNull _unit || _texture == "") exitWith {};

_unit setObjectTextureGlobal [0, _texture];
