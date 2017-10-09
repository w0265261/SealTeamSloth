/*
	File: fn_restrain.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Retrains the client.
*/
private["_cop","_curWep","_curMags","_check"];
_cop = param [0,Objnull,[Objnull]];
_check = true;
deleteVehicle life_placing;
deleteVehicle life_spikestrip;
if(isNull _cop) exitWith {};
life_myGrp = group player;
[player] joinSilent grpNull;
/*Monitor excessive restrainment*/
[] spawn
{
	private["_time"];
	while {true} do
	{
		_check = true;
		_time = time;
		waitUntil {(time - _time) > (450)};
		
		if(!(player getVariable["restrained",FALSE])) exitWith {};
		{if(player distance _x < 50 && side _x == west) then { _check = false; };} forEach playableUnits;
		if((_check) && (player getVariable["restrained",FALSE]) && isNull objectParent player && !(player getVariable["Escorting",false])) exitWith {
			player setVariable["restrained",FALSE,TRUE];
			player setVariable["Escorting",FALSE,TRUE];
			
			detach player;
			titleText["You have managed to break free of your handcuffs!","PLAIN"];
		};
	};
};
if(_cop != player) then {
	titleText[format[localize "STR_Cop_Retrained",_cop getVariable["realname",name _cop]],"PLAIN"];
} else {
	player setVariable["restrained",true];
};
_curWep = currentWeapon player;
_curMags = magazines player;
{player removeMagazine _x;} forEach _curMags;
player setAmmo [_curWep,0];
while {player getvariable["restrained",false]} do
{
	
	if(isNull objectParent player) then {
		if(!life_sit) then {player playMoveNow "AmovPercMstpSnonWnonDnon_Ease"} else {player playMoveNow "Acts_AidlPsitMstpSsurWnonDnon01"};
	};
	_state = vehicle player;
	_check = life_sit;
	waitUntil {(!(animationState player in ["AmovPercMstpSnonWnonDnon_Ease","Acts_AidlPsitMstpSsurWnonDnon01"]) || !(player getvariable["restrained",false]) || vehicle player != _state || (if(_check) then {!life_sit} else {life_sit})) && !(player getVariable["unconscious",false])};
	if(!alive player) exitWith
	{
		player setVariable ["restrained",false,true];
		player setVariable ["Escorting",false,true];
		
		detach player;
	};
	
	if(!alive _cop) exitWith {
		player setVariable ["Escorting",false,true];
		detach player;
	};
	
	if(!isNull objectParent player) then
	{
		if(driver (vehicle player) == player) then {player action["GetOut",vehicle player];};
	};
};
player setVariable["restrained",false,true]; //failsafe

		
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
