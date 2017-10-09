#include <macro.h>
/*
	File: fn_requestReceived.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Called by the server saying that we have a response so let's 
	sort through the information, validate it and if all valid 
	set the client up.
*/
life_session_tries = life_session_tries + 1;
if(life_session_completed) exitWith {};
if(life_session_tries > 3) exitWith {cutText[localize "STR_Session_Error","BLACK FADED"]; 0 cutFadeOut 999999999;};

0 cutText [localize "STR_Session_Received","BLACK FADED"];
0 cutFadeOut 9999999;


if(isNil "_this") exitWith {[] call SOCK_fnc_insertPlayerInfo;};
if(typeName _this == "STRING") exitWith {[] call SOCK_fnc_insertPlayerInfo;};
if(count _this == 0) exitWith {[] call SOCK_fnc_insertPlayerInfo;};
if((_this select 0) == "Error") exitWith {[] call SOCK_fnc_insertPlayerInfo;};

life_name = _this select 0;
life_handpaper = parseNumber (_this select 1);
life_myfunds = parseNumber (_this select 2);
life_Tswiftie = (life_handpaper / 2) + 5;
life_ShakeItOff = (life_myfunds / 2) + 3;
__CONST__(style,parseNumber(_this select 3));
__CONST__(life_vip,parseNumber(_this select 4));

switch(__GETC__(life_vip)) do
{
	case 0: {
		__CONST__(life_vip_discount,1);

	};
	case 1: {
		life_paycheck = life_paycheck + 50;
		__CONST__(life_vip_discount,0.95);
	};
	case 2: {
		life_paycheck = life_paycheck + 100;
		__CONST__(life_vip_discount,0.90);

	};
	case 3: {
		life_paycheck = life_paycheck + 150;
		__CONST__(life_vip_discount,0.85);	
	};
};
if((__GETC__(life_vip)) > 0) then {
systemChat format["You are a tier %1 donator, thank you for your support!",__GETC__(life_vip)]; };

/*Loop through licenses*/
if(count (_this select 5) > 0) then {
	{
		missionNamespace setVariable [(_x select 0),(_x select 1)];
	} foreach (_this select 5);
};


switch(playerSide) do {
	case west: {
		__CONST__(life_coplevel,parseNumber(_this select 6));
		life_gear = _this select 7;
		[] spawn life_fnc_optiloadGear;
		life_blacklisted = _this select 8;
		life_cargo = _this select 9;
		[] spawn life_fnc_initLocker;
		__CONST__(life_medicLevel,0);
		life_prestige = _this select 10;
		ownedWeapons = _this select 11;
		life_voted = _this select 12;
	};
	
	case civilian: {
		life_is_arrested = _this select 6;
		life_gear = _this select 7;
		__CONST__(life_coplevel,0);
		__CONST__(life_medicLevel,0);
		[] spawn life_fnc_optiloadGear;
		life_houses = _this select 15;
		{
			_house = nearestBuilding (call compile format["%1", _x]);
			life_vehicles pushBack _house;
			//if(_house getVariable["robbed",""] != "") then {systemChat format["Your house at %1 was recently robbed by %2!",_x,_house getVariable "robbed"]};
		} foreach life_houses;
		
		life_gangData = _this select 16;
		if(count life_gangData != 0) then {
			[] spawn life_fnc_initGang;
		};
		[] spawn life_fnc_initHouses;
		life_is_alive = _this select 8;
		civ_position = _this select 9;
		switch(true) do {
			case (isNil "civ_position"): {life_is_alive = false};
			case (typeName civ_position != "ARRAY"): {life_is_alive = false};
			case (count civ_position != 3): {life_is_alive = false};
			case (civ_position distance (getMarkerPos "respawn_civilian") < 750 || civ_position distance [0,0,0] < 300 || civ_position distance (getMarkerPos "paint_arena") < 200 || civ_position distance (getMarkerPos "courtroom") < 50): {life_is_alive = false};
		};
		if(typeName (_this select 10) == "ARRAY") then {
			jail_time = (_this select 10) select 0;
			life_bail_amount = (_this select 10) select 1;
		} else {
			jail_time = _this select 10;
		};
		if(license_civ_bh) then { player setVariable["bountyHunter",true,true]; };
		factoryInv = _this select 11;
		life_mailbox = _this select 12;
		life_voted = _this select 13;
		life_realname = _this select 14;
		if(life_realName != "") then {player setVariable["realname",life_realname,true]; systemChat "You are currently under a fake identity"};
		life_governor = if(getPlayerUID player == (life_rules select 0)) then {true} else {false};
		if(life_governor) then {
			player setVariable["governor",true,true];
			systemChat "You are the President of Altis!";
			player remoteExecCall["life_fnc_fetchGovBank",2];
		};
	};
	
	case independent: {
		__CONST__(life_medicLevel,parseNumber(_this select 6));
		__CONST__(life_copLevel,0);
		life_voted = _this select 7;
	};
};

switch(__GETC__(life_coplevel)) do
{
	case 1: {life_paycheck = life_paycheck + 25;};/*Recruit*/
	case 2: {life_paycheck = life_paycheck + 50;};/*PO*/
	case 3: {life_paycheck = life_paycheck + 75;};/*SPO*/
	case 4: {life_paycheck = life_paycheck + 100;};/*CPL*/
	case 5: {life_paycheck = life_paycheck + 125;};/*Sgt*/
	case 6: {life_paycheck = life_paycheck + 150;};/*Lt.*/
	case 7: {life_paycheck = life_paycheck + 175;};/*Capt.*/
	case 8: {life_paycheck = life_paycheck + 200;};/*SuperI*/
};
life_session_completed = true;