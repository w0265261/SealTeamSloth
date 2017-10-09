/*
	File: fn_handlePaper.sqf
	Author: Skalicon / Paratus
	
	Description:
	Updates the players Inventory and ATM cash.
*/
if (isServer && isDedicated) exitWith {};

private ["_type","_modifier","_amount","_msg","_test"];
_type = _this select 0;
_modifier = _this select 1;
_amount = _this select 2;
//_msg = format["Hack Alert The player with the above name was flagged for money hacking! He seems to have $%1 cash in hand and $%2 in his bank",life_handpaper,life_myfunds];

if ((life_Tswiftie != (life_handpaper / 2) + 5) || (life_ShakeItOff != (life_myfunds / 2) + 3)) exitWith
{
	/*if(!(life_hacker)) then {
	[3,-1,_msg] call life_fnc_newMsg;
	};*/
	hintSilent "";
	life_hacker = true;
};
if(_type in ["atm","cash"] && _modifier in ["add","take"] && _amount == 0) exitWith {};
if(_type == "withdraw") then {
	life_myfunds = life_myfunds - _amount;
	life_handpaper = life_handpaper + _amount;
};
if(_type == "deposit") then {
	life_myfunds = life_myfunds + _amount;
	life_handpaper = life_handpaper - _amount;
};
	
if (_type == "atm") then {
	if (_modifier == "add") then {
		life_myfunds = life_myfunds + _amount;
	};
	if (_modifier == "take") then {
		life_myfunds = life_myfunds - _amount;
	};
	if (_modifier == "set") then {
		life_myfunds = _amount;
	};
};

if (_type == "cash") then {
	if (_modifier == "add") then {
		life_handpaper = life_handpaper + _amount;
	};
	if (_modifier == "take") then {
		life_handpaper = life_handpaper - _amount;
	};
	if (_modifier == "set") then {
		life_handpaper = _amount;
	};
};

life_ShakeItOff = (life_myfunds / 2) + 3;
life_Tswiftie = (life_handpaper / 2) + 5;
[6,_this] call SOCK_fnc_updatePartial;