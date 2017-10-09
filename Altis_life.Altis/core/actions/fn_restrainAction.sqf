/*
	File: fn_restrainAction.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Retrains the target.
*/
private["_unit"];
_unit = cursorTarget;
if(player getVariable["zipTie",false] || player getVariable["unconscious",false]) exitWith {};
if(isNull _unit) exitWith {}; /*Not valid*/
if((_unit getvariable["restrained",false])) exitWith {};
if(side _unit == west) exitWith {};
if(player == _unit) exitWith {};
if(!isPlayer _unit) exitWith {};
if(player distance _unit > 2.5) exitWith {};
if(!(currentWeapon _unit in["","Binocular","Rangefinder"]) && !(_unit getVariable["tazed",false] || _unit getVariable["unconscious",false] || animationState _unit == "amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon" || animationState _unit == "incapacitated" || _unit getVariable["downed",false])) exitWith {titletext["He has a weapon out, can't restrain!","PLAIN"]};
/*Broadcast!*/

_unit setVariable["restrained",true,true];
[player] remoteExec ["life_fnc_restrain", _unit, false];
[_unit, "zip_tie",30] remoteExec ["life_fnc_playSound",0];
player playActionNow "PutDown";
[0,format[localize "STR_NOTF_Restrained",_unit getVariable["realname", name _unit], profileName]] remoteExec ["life_fnc_broadcast",west];
