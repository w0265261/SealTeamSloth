#include <macro.h>
/*
File: fn_jail.sqf
*/
private["_ret","_bad","_bail","_esc","_countDown","_unit","_msg"];
_ret = param [0];
_bad = param [1,false,[false]];
_jailTime = param [2,20,[0]];
_admin = param [3,false,[false]];
if(!_admin && isNil "life_bail_amount") then {
[] spawn {
	_action = ["Do you wish to provide valuable feedback on your experience with the ALE today? We are looking for constructive criticism from our players to help improve the police force. You will be compensated for doing so.", "ALE Survey", "Yes", "No"] call BIS_fnc_guiMessage;
	if(!_action) exitWith {};
	createDialog "STS_life_feedback";
};
};
if(typeName _ret == "ARRAY" && {count _ret > 0}) then {life_bail_amount = floor ((_ret select 3))} else {if(isNil "life_bail_amount") then {life_bail_amount = 10000}};
if(_admin) then {NoTrial = true} else {NoTrial = false};
if(_admin && life_is_arrested) exitWith {totaltime = time + (_jailTime * 60);};
jail_time = _jailTime;
[getPlayerUID player, [jail_time,life_bail_amount]] remoteExec ["life_fnc_saveJailTime",2];
_unit = player;
life_wantedlist = false;
//player setVariable["jailBreak",false,true];


_esc = false;
_bail = false;
life_wanted = false;
deathTime = nil;

if(isNull _unit) exitWith {}; 
if(_unit != player) exitWith {}; 
if(life_is_arrested) exitWith {}; 
player allowDamage false;
player setVariable["restrained",false,true];
player setVariable["zipTie",false,true];
player setVariable["Escorting",false,true];
player setVariable["shotByCop",false,true];

player setVariable["criminal",true,true];
player setVariable["bountyHunter",false,true];
player setVariable["approved",false];

_jail_uniform = uniform player;
_jail_hat = headgear player;
removeHeadgear player;
removeUniform player;
player forceAddUniform "U_C_WorkerCoveralls";
call life_fnc_equipGear;
titleText["You have been sent to jail!","PLAIN"];

[getPlayerUID player] remoteExec ["life_fnc_wantedRemove",2];
player setPosATL [(getPos jailRef select 0),(getPos jailRef select 1)-3,(getPosATL jailRef select 2)-2.6];


license_civ_gun = false;
license_civ_c3 = false;
license_civ_bh = false;

{
	_var = "life_inv_" + (_x select 0);
	_amount = call compile _var;
	if(_amount > 0) then {[false,_x select 0,_amount] call life_fnc_handleInv};
} forEach life_illegal_items;
life_is_arrested = true;
[5] call SOCK_fnc_updatePartial;

player removeWeapon (primaryWeapon player);
player removeWeapon (handgunWeapon player);
clearWeaponCargo (vestContainer player);
clearWeaponCargo (backpackContainer player);
clearWeaponCargo (uniformContainer player);
clearMagazineCargo (vestContainer player);
clearMagazineCargo (backpackContainer player);
clearMagazineCargo (uniformContainer player);
totaltime = time + (_jailTime * 60);
_esc = false;
_bail = false;
_death = if((life_rules select 4) && life_bail_amount >= 40000) then {true} else {false};
life_deathPen = _death;
_deathrow = if(_death) then {"ON DEATH ROW"} else {""};
[_jailTime,_death] spawn
{
	life_canpay_bail = false;
	sleep ((_this select 0) * 20);
	if(_this select 1) exitWith {deathTime = true};
	life_canpay_bail = nil;
};
[2] call SOCK_fnc_updatePartial;
[] call life_fnc_saveThat;
_counter = time;
while {true} do
{
	if(!alive player) exitWith {};
	if(Jail_Target getVariable["jailBreak",false] && {player distance Jail_Target > 75} && {!_admin}) exitWith { player allowDamage true; _esc = true; };
	if((round(totaltime - time)) < 1) exitWith {hintSilent ""};
	if(life_bail_paid) exitWith
	{
		_bail = true;
	};
	if((round(totaltime - time)) > 0 && !life_inTrial) then {
		_countDown = [(totaltime - time),"MM:SS.MS"] call BIS_fnc_secondsToString;
		hintSilent parseText format[(localize "STR_Jail_Time")+ "<br/> <t size='2'><t color='#FF0000'>%1</t></t><br/><br/>" +(localize "STR_Jail_Pay")+ " %3<br/>" +(localize "STR_Jail_Price")+ " $%2<br/>%4",_countDown,[life_bail_amount] call life_fnc_numberText,if(isNil "life_canpay_bail") then {"Yes"} else {"No"},_deathrow];
	};
	if(!isNull objectParent player) then { player action ["GetOut", vehicle player]; titleText["You can't escape from jail this way!","PLAIN"];};
	
	if(player distance (getMarkerPos "jail_marker") > 44 && !life_inTrial) then
	{
		player setPosATL [(getPos jailRef select 0),(getPos jailRef select 1)-3,(getPosATL jailRef select 2)-2.6];
	};
	
	if(time - _counter > 59) then { _counter = time; jail_time = jail_time - 1; [getPlayerUID player,[jail_time,life_bail_amount]] remoteExec ["life_fnc_saveJailTime",2]; };
	sleep 0.2;
};

hintSilent "";

switch (true) do
{
	case (_bail) :
	{
		life_is_arrested = false;
		life_bail_paid = false;

		removeUniform player;
		player forceAddUniform _jail_uniform;
		if (!(_jail_hat in ["H_CrewHelmetHeli_B","H_CrewHelmetHeli_I","H_CrewHelmetHeli_O","H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk"])) then {
			player addHeadgear _jail_hat;
		};
		if(life_inv_plate > 0) then {[false,"plate",life_inv_plate] call life_fnc_handleInv;};
		if(life_inv_plateMetal > 0) then {[false,"plateMetal",life_inv_plateMetal] call life_fnc_handleInv;};
		if(life_inv_shank > 0) then {[false,"shank",life_inv_shank] call life_fnc_handleInv;};
		[] call life_fnc_equipGear;
	};
	
	case (_esc) :
	{
		life_is_arrested = false;
		hint "You have escaped from jail and are now wanted for it!";
		[0,format["%1 has escaped from jail!",name player]] remoteExec ["life_fnc_broadcast",0];
		[getPlayerUID _unit,name _unit,[format["Escaping %1 minute jail time",jail_time],1500]] remoteExec ["life_fnc_customWantedAdd",2];
		deleteVehicle life_placing;
		if(life_inv_shank > 0) then {[false,"shank",life_inv_shank] call life_fnc_handleInv;};
	};
	
	case (alive player && !_esc && !_bail) :
	{
		life_is_arrested = false;
		deleteVehicle life_placing;
		if (_death && isNil "life_trial_verdict") exitWith
		{
			life_suicide = true;
			playSound "handcuffs";
			cutText["Your head is covered while sitting on the chair.","BLACK FADED"];
			0 cutFadeOut 999999;
			player setPos (getMarkerPos "respawn_civilian");
			sleep 1;
			playSound "elechair";
			sleep 9;
			player setDamage 1;
			cutText ["", "BLACK IN", 0.75];
		};
		hint "You have been released.";
		player setPos (getMarkerPos "jail_release");
		player setVariable["restrained",FALSE,TRUE];

		removeUniform player;
		player forceAddUniform _jail_uniform;
		if (!(_jail_hat in ["H_CrewHelmetHeli_B","H_CrewHelmetHeli_I","H_CrewHelmetHeli_O","H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk"])) then {
			player addHeadgear _jail_hat;
		};
		if(life_inv_plate > 0) then {[false,"plate",life_inv_plate] call life_fnc_handleInv;};
		if(life_inv_plateMetal > 0) then {[false,"plateMetal",life_inv_plateMetal] call life_fnc_handleInv;};
		if(life_inv_shank > 0) then {[false,"shank",life_inv_shank] call life_fnc_handleInv;};
		[] call life_fnc_equipGear;
	};
};
[5] call SOCK_fnc_updatePartial;
player allowDamage true;
life_bail_amount = nil;
if(_death) exitWith {sleep 10; if(!life_is_arrested) then {life_deathPen = false}};
life_is_alive = true;
[8] call SOCK_fnc_updatePartial;