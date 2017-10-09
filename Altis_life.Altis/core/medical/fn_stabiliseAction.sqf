/*
	File: fn_stabiliseAction
	
	Author: Bobbus/Kevin
	
	Description: is sent to client to extend bleedout time of player
*/
private["_bleedTime","_medic"];
_medic = param [0,ObjNull,[ObjNull]];
_bleedTime = life_bleedout;
if (isNull _medic) exitWith {};
if (!isPlayer _medic) exitWith {};
if(!(player getVariable ["unconscious",false])) exitWith {};
if(side _medic != independent && life_stab_limit > 5) exitWith { 
	titleText [format ["%1 is stabilising your wounds...",name _medic],"PLAIN"]; 
	_bleedTime = _bleedTime + 15;
	sleep 4;
	life_bleedout = _bleedTime;
};

titleText [format ["%1 is stabilising your wounds...",name _medic],"PLAIN"];
sleep 4;
_multiplier = if(side _medic == independent) then {2} else {1};
switch (true) do
{
case (player getVariable["mm",false]): { _bleedTime = _bleedTime + (105 * _multiplier); };
case (player getVariable["acp",false]): { _bleedTime = _bleedTime + (90 * _multiplier); };
case (player getVariable["rifle",false]): { _bleedTime = _bleedTime + (75 * _multiplier); };
case (player getVariable["heavy",false]): { _bleedTime = _bleedTime + (60 * _multiplier); };
case (player getVariable["sniper",false]): { _bleedTime = _bleedTime + (45 * _multiplier); };
case (player getVariable["fucked",false]): { _bleedTime = _bleedTime + (30 * _multiplier); };
default {_bleedTime = _bleedTime + (120 * _multiplier); };
};
life_bleedout = _bleedTime;
life_stab_limit = life_stab_limit + 1;