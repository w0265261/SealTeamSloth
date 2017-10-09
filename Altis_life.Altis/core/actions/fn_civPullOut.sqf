/*
	File: civPullOut.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Pulls anyone out of a car if it's stopped.
*/
if(player getVariable["zipTie",false]) then
{
	detach player;
	player setVariable["Escorting",false,true];
	
};

player action ["GetOut", vehicle player];
titleText["You have been pulled out of the vehicle","PLAIN"];
titleFadeOut 4;