#include <macro.h>
/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Sends specific information to the server to update on the player,
	meant to keep the network traffic down with large sums of data flowing
	through life_fnc_sloth
*/
if(life_paintballing || life_dueling) exitWith {};
private["_mode","_packet","_array","_flag","_msg"];
_mode = param [0,0,[0]];
_packet = [getPlayerUID player,playerSide,nil,_mode];
_array = [];
_flag = switch(playerSide) do {case west: {"cop"}; case civilian: {"civ"}; case independent: {"med"};};
_msg = format["Hack Alert The player with the above name was flagged for money hacking! He seems to have $%1 cash in hand and $%2 in his bank",life_handpaper,life_myfunds];
if ((life_Tswiftie != (life_handpaper / 2) + 5) || (life_ShakeItOff != (life_myfunds / 2) + 3)) exitWith
{
	if(!(life_hacker)) then {
	[3,-1,_msg] call life_fnc_newMsg;
	};
	hintSilent "";
	life_hacker = true;
};
switch(_mode) do {
//licenses, only updated when changed
	case 2: {
		{
			if(_x select 1 == _flag) then
			{
				_array pushBack [_x select 0,(missionNamespace getVariable (_x select 0))];
			};
		} foreach life_licenses;
		
		_packet set[2,_array];
	};
	//gear, updated by sync button and a few occasions of purchases/gear losses such as death
	case 3: {
		_packet set[2,life_gear];
		if(undercover) then {_packet set [3,10]};
	};
	
	//getting jailed, or getting released from jail (includes jailbreak)
	case 5: {
		_packet set[2,life_is_arrested];
	};
	//full cash update, happens every time cash is changed
	case 6: {
		_packet set[2,life_handpaper];
		_packet set[4,life_myfunds];
		_cashParams = param[1];
		_type = _cashParams select 0;
		if(_type == "atm") then {
			_packet set[4,[_cashParams select 1,_cashParams select 2]];
		};
	};
	//dead or alive, determines if you get the spawn menu on login or not.
	case 8: {
		_packet set[2,life_is_alive];
	};
};

_packet remoteExec ["DB_fnc_updatePartial",2];