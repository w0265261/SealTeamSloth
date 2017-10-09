/*
	File: fn_unrestrain.sqf
*/
private["_unit"];
_unit = param [0,ObjNull,[ObjNull]];
if(isNull _unit OR !(_unit getVariable["restrained",FALSE])) exitWith {}; /*Error check?*/

_unit setVariable["restrained",FALSE,TRUE];
_unit setVariable["Escorting",FALSE,TRUE];

detach _unit;
if(_unit != player) then {
	[0,format[localize "STR_NOTF_Unrestrain",_unit getVariable["realname",name _unit], profileName]] remoteExec ["life_fnc_broadcast",west];
};