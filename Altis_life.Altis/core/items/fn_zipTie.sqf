/*
	File: fn_zipTie.sqf
	Author: Bad^^Eye
	
	Description:
	Main functionality for civ restrain
*/
private["_unit"];
_unit = param [0,ObjNull,[ObjNull]];

if(_unit getvariable["restrained",false] || _unit getvariable["Escorting",false] || _unit getVariable["zipTie",false]) exitWith {};
if (!(animationState _unit == "amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon") && !(animationState _unit == "Incapacitated") && !(_unit getVariable ["tazed",false]) && !(_unit getVariable ["downed",false]) && !(_unit getVariable["unconscious",false])) exitWith {};
if(isNull _unit) exitWith {}; /*Not valid*/
if(player == _unit) exitWith {};
if(life_inv_zip == 0) exitWith { hint "You don't seem to have any zip ties!";};
if(player getVariable ["restrained",false] || player getVariable ["zipTie",false] || !isNil "surrender" || player getVariable ["unconscious",false] || (animationState player == "Incapacitated")) exitWith {};
if(player distance _unit > 4) exitWith {};
player playActionNow "PutDown";
if(!license_civ_bh) then {
	life_inv_zip = life_inv_zip - 1;
	life_carryWeight = life_carryWeight - 1;
};
[_unit, "zip_tie",30] remoteExec ["life_fnc_playSound",0];
[player] remoteExec ["life_fnc_zipTieAction",_unit];
_unit spawn {
	_unit = _this;
	_bool = true;
	while {true} do {
		sleep 30;
		if(!(_unit getVariable["zipTie",false])) exitWith {};
		sleep 540;
		if(_unit getVariable["zipTie",false] && !(_unit getVariable["reZipped",false])) then {systemChat "Your victim seems to be wriggling out of his restraints."};
	};
};
