/*
	File: fn_tazed.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the tazed animation and broadcasts out what it needs to.
	Starts the tazed animation and broadcasts out what it needs to.
*/
private["_unit","_shooter","_curWep","_curMags","_attach"];
_unit = param [0,Objnull,[Objnull]];
_shooter = param [1,Objnull,[Objnull]];
if(isNull _unit OR isNull _shooter) exitWith {};
if(player getVariable["restrained",false] || player getVariable["zipTie",false]) exitWith {};
_time = time;
if(_shooter isKindOf "Man" && alive player) then
{
	if(!life_istazed && !life_isdowned) then
	{
		life_istazed = true;
		if(typeOf (vehicle player) == "B_Quadbike_01_F" || ["C_Kart",typeOf vehicle player] call BIS_fnc_inString) then
		{
			player action ["GetOut",vehicle player];
			waitUntil{isNull objectParent player};
		};
		player allowDamage false;
		if(isNull objectParent player) then {
			for [{_x=1},{_x<=10},{_x=_x+1}] do { call KK_fnc_forceRagdoll; sleep 0.1; if(animationState player == "unconscious") exitWith{}};
		};
		player setVariable ["tazed",true,true];
		_curWep = currentWeapon player;
		_curMags = magazines player;
		_attach = if(primaryWeapon player != "") then {primaryWeaponItems _unit} else {[]};
		{player removeMagazine _x} foreach _curMags;
		player removeWeapon _curWep;
		player addWeapon _curWep;
		if(count _attach != 0 && primaryWeapon _unit != "") then
		{
			{
				_unit addPrimaryWeaponItem _x;
			} foreach _attach;
		};
		if(count _curMags != 0) then
		{
			{player addMagazine _x;} foreach _curMags;
		};
		
		[_unit] remoteExec ["life_fnc_tazeSound",0];

		[0,format[localize "STR_NOTF_Tazed", _unit getVariable["realname",name _unit], _shooter getVariable["realname",name _shooter]]] remoteExec ["life_fnc_broadcast",0];
		disableUserInput true;
		player setDamage 0;
		waitUntil{animationState player != "unconscious"};
		_anim = if(isNull objectParent player) then {"Incapacitated"} else {"kia_driver_mid01"};
		[player,_anim] remoteExec ["life_fnc_animSync",0];
		waitUntil{time - _time >=15};
		player allowDamage true;
		if(player getVariable["restrained",false] || player getVariable["zipTie",false]) exitWith {
		if(!(player getVariable["Escorting",false])) then {
			detach player;
		};
		life_istazed = false;
		player setVariable ["tazed",false,true];
		disableUserInput false;
		};

		if(!(player getVariable["Escorting",false])) then {
			detach player;
		};
		life_istazed = false;
		player setVariable ["tazed",false,true];
		disableUserInput false;
		player playMoveNow "amovppnemstpsraswrfldnon";
	};
};