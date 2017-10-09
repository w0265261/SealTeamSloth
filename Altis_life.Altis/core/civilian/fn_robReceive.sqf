/*
	File: fn_robReceive.sqf
	Author: Bryan "Tonic" Boardwine
*/
private["_cash"];
_cash = param [0,0,[0]];
if(_cash == 0) exitWith {titleText[localize "STR_Civ_RobFail","PLAIN"]};

["cash","add",_cash] call life_fnc_handlePaper;
life_thief = life_thief + _cash;
titleText[format[localize "STR_Civ_Robbed",[_cash] call life_fnc_numberText],"PLAIN"];