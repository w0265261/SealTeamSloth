#include <macro.h>
/*
	File: fn_unconscious
	
	Description: when handle damage calls this file, it will do all of the actions needed to be unconscious.
*/
private["_paramName","_param","_timeLeft","_bool"];
if(!isNull objectParent player) then {
	player playMoveNow "kia_driver_mid01";
} else { [] spawn { for [{_x=1},{_x<=10},{_x=_x+1}] do { call KK_fnc_forceRagdoll; sleep 0.1; if(animationState player == "unconscious") exitWith{}; }; }; };
createDialog "STS_DeathScreen";
ctrlSetFocus ((findDisplay 7300) displayCtrl 7303);

if(playerSide == civilian) then {
	life_is_alive = false;
	[8] call SOCK_fnc_updatePartial;
};
if(playerSide == west) then { call life_fnc_saveThat; };
switch (true) do
{
	case (player getVariable["mm",false]): { life_bleedout = time + (60*9); };
	case (player getVariable["acp",false]): { life_bleedout = time + (60*7.5); };
	case (player getVariable["rifle",false]): { life_bleedout = time + (60*6); };
	case (player getVariable["heavy",false]): { life_bleedout = time + (60*4.5); };
	case (player getVariable["sniper",false]): { life_bleedout = time + (60*3); };
	case (player getVariable["fucked",false]): { life_bleedout = time + (60*1.5); };
	default {life_bleedout = time + (60*10); };
};

player setVariable["restrained",false,true];
player setVariable["Escorting",false,true];
player setVariable["zipTie",false,true];

player setVariable["blindfolded",false,true];
player allowDamage false;
player setDamage 0;
/*Setup our camera view*/
life_deathCamera  = "CAMERA" camCreate (getPosATL player);
showCinemaBorder TRUE;
life_deathCamera cameraEffect ["Internal","Back"];
life_deathCamera camSetTarget player;
life_deathCamera camSetRelPos [0,3.5,4.5];
life_deathCamera camSetFOV .5;
life_deathCamera camSetFocus [50,0];
life_deathCamera camCommit 0;
(findDisplay 7300) displaySetEventHandler ["KeyDown","if((_this select 1) == 1) then {true}"]; /*Block the ESC menu*/
[] spawn
{
	disableSerialization;
	private["_RespawnBtn","_Timer","_adminBtn"];
	_Timer = ((findDisplay 7300) displayCtrl 7301);
	_adminBtn = ((findDisplay 7300) displayCtrl 7306);
	if(__GETC__(style) < 1) then {
		_adminBtn ctrlShow false; 
	};
	[_Timer] spawn {
		disableSerialization;
		_Timer = _this select 0;
		while{player getVariable["unconscious",false] && life_bleedout > time} do { 
			_Timer ctrlSetText format["Time until bleedout: %1",[(life_bleedout - time),"MM:SS.MS"] call BIS_fnc_secondsToString]; 
		};
	};
};

[] spawn life_fnc_deathScreen;

[] spawn
{
	waitUntil {if(!(player getVariable["unconscious",false])) exitWith {true}; life_deathCamera camSetTarget player; life_deathCamera camSetRelPos [0,3.5,4.5]; life_deathCamera camCommit 0;};
};
sleep 0.25;
waitUntil{animationState player != "unconscious"};
lethal_death = true;
while {player getVariable["unconscious",false]} do
{
	if(animationState player != "AinjPpneMstpSnonWrflDnon" && isNull objectParent player) then {
		[player,"AinjPpneMstpSnonWrflDnon"] remoteExec ["life_fnc_animSync",0];
	} else {
		if(animationState player != "kia_driver_mid01" && !isNull objectParent player) then {
			[player,"kia_driver_mid01"] remoteExec ["life_fnc_animSync",0];
		};
	};
	if(vehicle player getVariable "medic") then {life_bleedout = life_bleedout + 1};
	if (life_bleedout <= time) exitWith {
		player setDamage 1;
	};
	sleep 0.25;
};
lethal_death = false;