/*
	File: fn_questionGasStation.sqf
	Author: Morph
	
	Description:
	Questions the gas station employee and adds robbers to wanted list.
*/
private["_station","_robbers","_names"];

_station = param [0,ObjNull,[ObjNull]];
_robbers = _station getVariable["Robbers",[]];


if(count _robbers == 0) exitWith {hint "No one has robbed this gas station recently."};
_names = "";


{
	_gun = ([_x select 2] call life_fnc_fetchCfgDetails) select 1;
	[_x select 0,_x select 1,"211A",[name player,getPos player,_gun]] remoteExec ["life_fnc_wantedAdd",2];
	_names = _names + format["%1<br/>",_x select 1];
} foreach _robbers;



hint parseText format["The following people robbed this gas station.<br/><br/>%1",_names];
_station setVariable["Robbers",[],true];