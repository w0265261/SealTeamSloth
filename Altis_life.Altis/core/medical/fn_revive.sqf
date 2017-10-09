#include <macro.h>
/*
	File: fn_revive
	
	Author: Skeith
	
	Description: is used by the medics to revive players
*/
if(life_reviving) exitWith {};
private["_target","_unit"];
_target = param [0,ObjNull,[ObjNull]];
if (isNull _target) exitWith {};
if (!isPlayer _target) exitWith {};
if(!(_target getVariable ["unconscious",false])) exitWith {};
if(player distance _target > 4) exitWith {};
life_reviving = true;
life_interrupted = false;
life_action_inUse = true;
_target spawn {
	_target = _this;
	[player] remoteExec ["life_fnc_stabiliseAction",_target,false];
	player playMoveNow "AinvPknlMstpSnonWnonDr_medic1";
	sleep 2.761;
	if(life_interrupted) exitWith {life_interrupted = false; life_action_inUse = false; life_reviving = false; titleText["Revive aborted","PLAIN"]};
	player playMoveNow "AinvPknlMstpSnonWnonDr_medic2";
	sleep 6.592;
	if(life_interrupted) exitWith {life_interrupted = false; life_action_inUse = false; life_reviving = false; titleText["Revive aborted","PLAIN"]};
	player playMoveNow "AinvPknlMstpSnonWnonDr_medic3";
	sleep 6.592;
	if(life_interrupted) exitWith {life_interrupted = false; life_action_inUse = false; life_reviving = false; titleText["Revive aborted","PLAIN"]};
	player playMoveNow "AinvPknlMstpSnonWnonDr_medic4";
	sleep 4.545;
	if(life_interrupted) exitWith {life_interrupted = false; life_action_inUse = false; life_reviving = false; titleText["Revive aborted","PLAIN"]};
	player playMoveNow "AinvPknlMstpSnonWnonDr_medic5";
	sleep 8;
	if(life_interrupted) exitWith {life_interrupted = false; life_action_inUse = false; life_reviving = false; titleText["Revive aborted","PLAIN"]};
	[player, false] remoteExec ["life_fnc_reviveAction", _target, false];
	["atm","add",__GETC__(life_revive_fee)] call life_fnc_handlePaper;
	hint format["You have revived %1\n\nYou have received $750 for saving a life!",name _target];
	_target allowDamage true;
	life_reviving = false;
	life_action_inUse = false;
};