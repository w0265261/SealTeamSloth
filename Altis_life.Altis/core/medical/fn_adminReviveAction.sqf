#include <macro.h>
/*
	File: fn_adminReviveAction.sqf
	
	Author: Kevin

	
	Description: This gets sent to the unconscious client to revive them
*/
private["_medic"];
_medic = param [0,ObjNull,[ObjNull]];
_self = param [1,false,[false]];
closeDialog 0;
if(_self && __GETC__(style) == 0) exitWith {};
if(isNull _medic) exitWith {};
if(isNull player) exitWith {};
titleText [format ["You have been administratively revived by %1...",name _medic],"PLAIN"];
player enableSimulation true;
player setVariable ["unconscious",false,true];
player setVariable ["mm",false];
player setVariable ["acp",false];
player setVariable ["arrowToTheKnee",false,true];
player setVariable ["heavy",false];
player setVariable ["rifle",false];
player setVariable ["sniper",false];
player setVariable ["fucked",false];
life_copRecieve = nil;
if (!alive player) exitWith {}; /*stops reviving if they died*/
/*deleteMarker name player;*/
player allowDamage true;
life_abort_enabled = false;
life_medreq = false;
player setDamage 0;
player playMoveNow "amovppnemstpsraswrfldnon";
life_hunger = 100;
life_thirst = 100;
life_is_alive = true;
[8] call SOCK_fnc_updatePartial;
life_deathCamera cameraEffect ["TERMINATE","BACK"];
camDestroy life_deathCamera;