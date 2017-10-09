/*
	File: fn_zipTie.sqf
	Author: Unknown - edits by Kevin
	
	Description:
	Main functionality for civ restrain
*/
private["_attacker","_victim","_curWep","_curMags"];
_attacker = param [0,Objnull,[Objnull]];
if(isNull _attacker) exitWith {};

player setVariable["zipTie",true,true];
life_myGrp = group player;
[player] joinSilent (createGroup (side player));
if(!(_attacker getVariable["bountyHunter",false])) then {
	[getPlayerUID _attacker,name _attacker,"207",[player getVariable["realname",name player],getPos player]] remoteExec ["life_fnc_wantedAdd",2];
};


[] spawn
{
	while {true} do {
		sleep 420;
		if(!(player getVariable["zipTie",false])) exitWith {};
		hint "You feel as though it will take another three minutes to break free of your restraints";
		sleep 180;
		if(!(player getVariable["reZipped",false]) && player getVariable["zipTie",false]) exitWith {
			player setVariable["zipTie",FALSE,TRUE];
			player setVariable["Escorting",FALSE,TRUE];
			
			detach player;
			titleText["You have managed to break free of your restraints!","PLAIN"];
			_bool = false;
		};
		if(!(player getVariable["zipTie",false])) exitWith {};
			hint "Unfortunately your captors seem to have tightened your restraints, it will be a short while before you have a chance to escape.";
			player setVariable["reZipped",false,true];
	};
};	

_curWep = currentWeapon player;
_curMags = magazines player;
{player removeMagazine _x;} forEach _curMags;
player setAmmo [_curWep,0];
	
while {player getVariable["zipTie",false]} do
{
	if(!life_sit) then {player playMoveNow "AmovPercMstpSnonWnonDnon_Ease"} else {player playMoveNow "Acts_AidlPsitMstpSsurWnonDnon01"};
	_check = life_sit;
	waitUntil {(!(animationState player in ["AmovPercMstpSnonWnonDnon_Ease","Acts_AidlPsitMstpSsurWnonDnon01"]) || !(player getVariable["zipTie",false]) || if(_check) then {!life_sit} else {life_sit}) && !(player getVariable["unconscious",false])};
	if(!isNull objectParent player) then
	{
		if(driver (vehicle player) == player) then {player action["GetOut",vehicle player];};
	};
	if(!alive player) exitWith
	{
		player setVariable ["zipTie",false,true];
		[player] joinSilent life_myGrp;
	};
};
player setVariable["zipTie",false,true]; //failsafe?
if(alive player) then
{
	player switchMove "AmovPercMstpSlowWrflDnon_SaluteIn";
	player setVariable ["Escorting",false,true];
	
	detach player;
	if(count _curMags != 0) then
	{
		{player addMagazine _x;} foreach _curMags;
	};
	if(currentWeapon player != "" && isNull objectParent player) then {
			life_curWep_h = currentWeapon player;
			player action ["SwitchWeapon", player, player, 100];
			player switchcamera cameraView;
		};
};
[player] joinSilent life_myGrp;
