/*
	File: fn_playSound.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Plays a sound, allowing for MP.
	Big Thanks From STS =P
*/

private["_source","_sound","_distance"];
_source = param [0,ObjNull,[ObjNull]];
_sound = param [1,"",[""]];
_distance = param [2,0,[0]];

if (player distance _source > _distance) exitWith {};

_source say3D _sound;