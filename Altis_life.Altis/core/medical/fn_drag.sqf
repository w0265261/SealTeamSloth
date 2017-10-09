/*
	File: fn_drag.sqf
	
	Author Skeith
	
	Description: action that makes medic drag player.
*/
_unit = param [0,ObjNull,[ObjNull]];
if(isNull _unit) exitWith {}; /*Not valid*/
if(!(_unit isKindOf "Man") || !isPlayer _unit) exitWith {};
if(player distance _unit > 5) exitWith {};
player setVariable["isDragging",true,true];
player setVariable["dragging",_unit,true];
life_action_inUse = true;
_unit setPosATL (getPosATL _unit);
_unit attachTo [player, [0, 1.1, 0.092]];
_unit setDir 180;
if(currentWeapon player != "") then {player playMoveNow "AcinPknlMstpSrasWrflDnon";} 
else {player playMoveNow "AcinPknlMstpSnonWnonDnon";}; 
_dragact = player addAction ["<t color=""#C90000"">" + "Release" + "</t>", { 
	player setVariable["isDragging",false,true];
	life_action_inUse = false;
	_unit = player getVariable "dragging";
	_unit switchMove "AinjPpneMstpSnonWrflDnon"; 
	player playMoveNow "AmovPercMstpSnonWnonDnon"; 
	detach _unit;
	_act = _this select 2;
	player removeAction _act;
},"",10,true];

while {(player getVariable "isDragging")} do {
	if(!(player getVariable "isDragging")) then {player removeAction _id;};
};