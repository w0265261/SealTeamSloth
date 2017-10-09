/*
	File: fn_reviveAction.sqf
	
	Author: Skeith
	
	Description: This gets sent to the unconscious client to revive them
*/
private["_medic","_lostcash"];
_medic = param [0,ObjNull,[ObjNull]];
_bool = param [1,false,[false]];
if (isNull _medic) exitWith {};
closeDialog 0;
if(!(player getVariable ["unconscious",false])) exitWith {};
if(_bool) then { titleText [format ["You are being revived by %1...",name _medic],"PLAIN"]; sleep 10; } else {
titleText [format ["You have been revived by %1...",name _medic],"PLAIN"]; };
if(playerSide == civilian) then {
life_is_alive = true;
[8] call SOCK_fnc_updatePartial;
};
player setVariable ["unconscious",false,true];
life_copRecieve = nil;
player setVariable ["mm",false];
player setVariable ["acp",false];
player setVariable ["arrowToTheKnee",false,true];
player setVariable ["heavy",false];
player setVariable ["rifle",false];
player setVariable ["sniper",false];
player setVariable ["fucked",false];
if (!alive player) exitWith {};
life_deathCamera cameraEffect ["TERMINATE","BACK"];
camDestroy life_deathCamera;
player allowDamage true;
player setDamage 0;
player playMoveNow "amovppnemstpsraswrfldnon";
life_medreq = false;
_multiplier = switch(life_rules select 2) do {
	case 0: {1};
	case 1: {0.5};
	case 2: {0};
};
if(life_rules select 2 > 0) then {systemChat format["Medical expenses have been reduced thanks to President %1!",life_rules select 5]};
if(isPlayer _medic) then {
	_lostCash = 0.0025;
	if((_lostcash * life_myfunds) > 1000) then {
		["atm","take",1000 * _multiplier] call life_fnc_handlePaper;
		hint format["Your medical bills have cost you %1.",1000 * _multiplier];
	} else {
		_lostCash = floor(life_myfunds * _lostCash);
		["atm","take",_lostCash * _multiplier] call life_fnc_handlePaper;
		hint format ["Your medical bills have cost you $%1 on this occasion.", [_lostCash * _multiplier] call life_fnc_numberText];
	};
};
life_stab_limit = 0; /*reset stabilization count*/