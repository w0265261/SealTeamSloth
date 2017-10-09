/*
	File: fn_onDeath.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Does whatever it needs to when a player dies.
*/
private["_unit","_handle","_corpse","_medicsOn","_lostCash","_containers"];
_unit = param [0,Objnull,[Objnull]];
_source = param [1,Objnull,[Objnull]];
_containers = nearestObjects[player,["WeaponHolderSimulated"],5];
{deleteVehicle _x;} foreach _containers; /*Delete the containers.*/
if(isNull _unit) exitWith {};
closeDialog 0;
if(!life_is_arrested) then {
[getPos _unit] spawn life_fnc_NLR; };
if(playerSide == civilian) then {
[getPlayerUID _unit,civilian,[],3] remoteExec ["DB_fnc_updatePartial",2];
} else {
	if(side player == west) then {
		[getPlayerUID _unit,west,[],3] remoteExec ["DB_fnc_updatePartial",2];
	};
};
life_respawning = true;
if(!isNil "life_deathCamera") then {
life_deathCamera cameraEffect ["TERMINATE","BACK"];
camDestroy life_deathCamera;
};
cutText[format["Cloning %1, please stand by...",profileName],"BLACK FADED"];
0 cutFadeOut 9999999;

	if(_source == _unit) then
	{
		switch (true) do
		{
			case (_unit getVariable["executed",false]):							{[0,format["%1 was finished off by %2", name _unit, name player]] remoteExec ["life_fnc_broadcast",0]};
			case (life_deathPen): 												{[0,format["%1 was put to death for his crimes", name _unit]] remoteExec ["life_fnc_broadcast",0]};
			case (life_thirst == 0) : 											{[0,format["%1 died of dehydration.", name _unit]] remoteExec ["life_fnc_broadcast",0];};
			case (life_hunger == 0) : 											{[0,format["%1 starved to death.", name _unit]] remoteExec ["life_fnc_broadcast",0]; };
			case (life_bleedout < time && _unit getVariable["unconscious",false]) :	{[0,format["%1 bled out.", name _unit]] remoteExec ["life_fnc_broadcast",0]; };
			default 															{[0,format["%1 ended himself.", name _unit]] remoteExec ["life_fnc_broadcast",0];};
		};
	};

if(playerSide == civilian && player getVariable["shotByCop",false]) then
{
	[getPlayerUID player] remoteExec ["life_fnc_wantedRemove",2];
	license_civ_rebel = false;
	license_civ_c3 = false;
	life_wanted = false;
	player setVariable["shotByCop",nil,true];
	if(!isNil "life_copRecieve") then {
	[player,life_copRecieve,true] remoteExec ["life_fnc_wantedBounty",2];
	life_copRecieve = nil;
	};
};

_handle = [_unit] spawn life_fnc_dropItems;
waitUntil {scriptDone _handle};
/*Handle money lost on death*/
_medicsOn = playersNumber independent;
_lostCash = 0;
if(_medicsOn > 0) then {_lostCash = 0.01};
if(_medicsOn < 1 || playerSide == independent || (playerSide == civilian && !(license_civ_rebel))) then {_lostCash = 0};
if(life_suicide) then {_lostCash = _lostCash * 2; life_suicide = false};
_multiplier = switch(life_rules select 2) do {
	case 0: {1};
	case 1: {0.5};
	case 2: {0};
};
_lostCash = floor(life_myfunds * _lostCash * _multiplier);
if(life_rules select 2 > 0) then {systemChat format["Cloning expenses have been reduced thanks to President %1!",life_rules select 5]};
if(_lostCash > 0) then
{
	["atm","take",_lostCash] call life_fnc_handlePaper;
	systemChat format ["You have died and lost $%1 from your bank account for your cloning.", [_lostCash] call life_fnc_numberText];
};
life_carryWeight = 0;
life_thirst = 100;
life_hunger = 100;
life_use_atm = true;
life_stab_limit = 0;
life_medreq = false;


_unit setVariable ["restrained", false, true];
player setVariable ["arrowToTheKnee",false,true];
_unit setVariable ["escorting", false, true];

player setVariable ["unconscious",false,true];
_unit allowDamage true;


{ _unit removeAction _x; } foreach STS_actions;
STS_actions = [];
if(playerSide == civilian) then {
	life_is_alive = false;
	[8] call SOCK_fnc_updatePartial;
	[2] call SOCK_fnc_updatePartial;
};
(findDisplay 46) displayRemoveAllEventHandlers "MouseButtonDown";