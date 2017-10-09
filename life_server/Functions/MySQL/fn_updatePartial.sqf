/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Takes partial data of a player and updates it, this is meant to be
	less network intensive towards data flowing through it for updates.
*/
private["_uid","_side","_value","_mode","_query"];
_uid = param [0,"",[""]];
_side = param [1,sideUnknown,[civilian]];
_mode = param [3,-1,[0]];

if(_uid == "" OR _side == sideUnknown) exitWith {}; /*Bad.*/
_query = "";

switch(_mode) do {
	case 1: {
		_value1 = param [2,"",[""]];
		_value2 = param [4,[],[[]]];
		_query = format["INSERT INTO tents (pid, type, position) VALUES ('%1', '%2', '%3')",_uid,_value1,_value2];
	};
	
	case 2: {
		_value = param [2,[],[[]]];

		for "_i" from 0 to count(_value)-1 do {
			_bool = [(_value select _i) select 1] call DB_fnc_bool;
			_value set[_i,[(_value select _i) select 0,_bool]];
		};
		switch(_side) do {
			case west: {_query = format["UPDATE players SET cop_licenses='%1' WHERE playerid='%2'",_value,_uid];};
			case civilian: {_query = format["UPDATE players SET civ_licenses='%1' WHERE playerid='%2'",_value,_uid];};
			case independent: {_query = format["UPDATE players SET med_licenses='%1' WHERE playerid='%2'",_value,_uid];};
		};
	};
	
	case 3: {
		_value = param [2,[],[[]]];
		switch(_side) do {
			case west: {_query = format["UPDATE players SET cop_gear='%1' WHERE playerid='%2'",_value,_uid];};
			case civilian: {_query = format["UPDATE players SET civ_gear='%1' WHERE playerid='%2'",_value,_uid];};
		};
	};
	
	case 4: {
		_value = param [2,[],[[]]];
		_query = format["UPDATE players SET civPosition='%1' WHERE playerid='%2'",_value,_uid];
	};
	
	case 5: {
		_value = param [2,false,[false]];
		_value = [_value] call DB_fnc_bool;
		_query = format["UPDATE players SET arrested='%1' WHERE playerid='%2'",_value,_uid];
	};
	
	case 6: {
		_value1 = param [2,0,[0]];
		_value2 = param [4];
		if(typeName _value2 == "ARRAY" && {_value2 select 0 in ["add","take"]}) then {
			_type = _value2 select 0;
			_amount = _value2 select 1;
			_word = if(_side == west) then {"copbank"} else {"bankacc"};
			_value2 = switch(_type) do {
				case "add": {format["%2+%1",_amount,_word]};
				case "take": {format["%2-%1",_amount,_word]};
				default {""};
			};
		};
		_value1 = [_value1] call DB_fnc_numberSafe;
		if(typeName _value2 != "STRING") then {_value2 = [_value2] call DB_fnc_numberSafe};
		_query = switch (_side) do {
			case civilian: {format["UPDATE players SET cash='%1', bankacc=%2 WHERE playerid='%3'",_value1,_value2,_uid]};
			case west: {format["UPDATE players SET copcash='%1', copbank=%2 WHERE playerid='%3'",_value1,_value2,_uid]};
			case independent: {format["UPDATE players SET cash='%1', bankacc=%2 WHERE playerid='%3'",_value1,_value2,_uid]};
		};
	};
	case 7: {
		_prestige = param [2,0,[0]];
		_item = param [4,"",[""]];
		_query = format["SELECT ownedWeapons FROM players WHERE playerid='%1'",_uid];
		_weapons = [_query,2] call DB_fnc_asyncCall;
		_weapons = _weapons select 0;
		_weapons pushBack _item;
		_query = format["UPDATE players SET ownedWeapons='%1',prestige=%3 WHERE playerid='%2'",_weapons,_uid,_prestige];
		[_query,1] call DB_fnc_asyncCall;
	};
	
	case 8: {
		_value = param [2,false,[false]];
		_value = [_value,0] call DB_fnc_bool;
		_query = format["UPDATE players SET alive='%1' WHERE playerid='%2'",_value,_uid];
	};
	
	case 9: {
		_value = param [2,[],[[]]];
		_query = format["UPDATE players SET factory='%1' WHERE playerid='%2'",_value,_uid];
	};
	
	case 10: {
		_value = param [2,[],[[]]];
		_query = format["UPDATE players SET under_gear='%1' WHERE playerid='%2'",_value,_uid];
	};
};

if(_query == "") exitWith {};

[_query,1] call DB_fnc_asyncCall;