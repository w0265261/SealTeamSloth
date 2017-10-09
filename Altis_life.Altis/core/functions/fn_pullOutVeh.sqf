/*
	File: fn_pullOutVeh.sqf
	Author: Bryan "Tonic" Boardwine
*/
if(isNull objectParent player) exitWith {};
if(player getvariable["restrained",false]) then
{
	detach player;
	player setVariable["Escorting",false,true];
	
};

player action ["GetOut", vehicle player];
titleText[localize "STR_NOTF_PulledOut","PLAIN"];
titleFadeOut 4;