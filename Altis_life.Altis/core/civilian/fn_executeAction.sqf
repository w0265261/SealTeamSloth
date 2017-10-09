/*
	File: fn_executeAction
	
	Author: Bobbus
	
	Description: is sent to executed player
*/
private["_killer"];
_killer = param [0,ObjNull,[ObjNull]];
if (isNull _killer) exitWith {};

titleText ["This is going to hurt...","PLAIN"];
titleFadeOut 2;
player setVariable ["executed",true,true];
sleep 3;
player setDamage 1;