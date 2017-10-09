/*
	File: fn_stabilise
	
	Author: Bobbus
	
	Description: is used to extend bleedout time of players
*/

_target = param [0,ObjNull,[ObjNull]];
if (isNull _target) exitWith {};
if(life_stab_time > time) exitWith {hint format["You have stabilized wounds recently and cannot stabilize again for another %1 seconds",round(life_stab_time - time)];};
if (!isPlayer _target) exitWith {};
if(!(_target getVariable ["unconscious",false])) exitWith {};
if(player distance _target > 4) exitWith {};
if(playerSide == civilian && !(license_civ_med)) exitWith { hint "You wish you could help the poor soul, but you do have the right knowledge to stabilize wounds!"; };

if (!("Medikit" in (items player)) && life_inv_medkit < 1) then {
	player removeItem "FirstAidKit"
};

player playMove "AinvPknlMstpSnonWnonDnon_medic0";
[player] remoteExec ["life_fnc_stabiliseAction", _target, false];
life_stab_time = time + 10;
if(playerSide == independent) then {["atm","add",50] call life_fnc_handlePaper; hint "As a medic performing his duties, you have received $50 for stabilizing this victim's wounds"};