/*
	File: fn_adminRestrainAction.sqf
	Author: Kevin Webb
	
	Description:
	Retrains the rulebreaking individual clientside.
*/
private["_cop","_player"];
_cop = param [0,Objnull,[Objnull]];
_player = player;
if(isNull _cop) exitWith {};

if(!isNull objectParent player) then
{
	player action ["GetOut",vehicle player];
};

hint "You've been restrained remotely by an ADMIN; standby for further instructions.";
player setVariable ["restrained",true,true];
while {player getvariable["restrained",false]} do
{
	if(isNull objectParent player) then {
		player playMove "AmovPercMstpSnonWnonDnon_Ease";
	};
	
	_state = vehicle player;
	waitUntil {animationState player != "AmovPercMstpSnonWnonDnon_Ease" || !(player getvariable["restrained",false]) || vehicle player != _state};

	if(!alive player) exitWith
	{
		player setVariable ["restrained",false,true];
		player setVariable ["Escorting",false,true];
		
		detach _player;
	};
	
	if(!isNull objectParent player) then
	{
		if(driver (vehicle player) == player) then {player action["GetOut",vehicle player];};
	};
};
	
if(alive player) then
{
	player switchMove "AmovPercMstpSlowWrflDnon_SaluteIn";
	player setVariable ["Escorting",false,true];
	
	detach player;
	hint "You've now been unrestrained, be sure to follow the rules or risk a ban from the server! You can read the rules at sealteamsloth.life";
};