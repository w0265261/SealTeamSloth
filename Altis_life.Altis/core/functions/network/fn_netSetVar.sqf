/*
	File: fn_netSetVar.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Set a variable on a client.
*/
disableSerialization;
private["_varName","_ns","_value","_mailbox"];
_varName = param [0,"",[""]];
_value = _this select 1;
if(_varName == "life_offers") exitWith {life_offers = life_offers + _value};
if(_varName == "life_messages") exitWith {
	_isEqual = param [2,false,[false]];
	if(_isEqual) then {life_messages = _value} else {life_messages pushBack _value};
};
if(_varName == "life_tent") exitWith {
	life_tent = _value;
	_markerLocal = createMarkerLocal[format["civ_spawn_tent_%1",getPlayerUID player],life_tent select 1];
	_markerLocal setMarkerShapeLocal "ICON";
	_markerLocal setMarkerTypeLocal "hd_destroy";
	_markerLocal setMarkerColorLocal "ColorBlack";
	_markerLocal setMarkerTextLocal "Tent";
};
_ns = param [2,missionNamespace,[missionNamespace]];
_mailbox = param [3,false,[false]];
if(_mailbox) exitWith {
	_item = param [4,false,[false]];
	if(_item) exitWith {
		_checkForExisting = false;
		{if((_value select 0) == (_x select 0)) exitWith {_checkForExisting = true; life_mailbox set[_forEachIndex,[_x select 0,((_x select 1) + (_value select 1))]]};} forEach life_mailbox;
		if(!_checkForExisting) then {
			life_mailbox pushBack _value;
		};
	};
	life_mailbox pushBack _value;
};

if(_varName == "") exitWith {}; /*Error checking*/
_ns setVariable[_varName,_value];
if(_varName == "life_myFunds") then {life_ShakeItOff = (life_myfunds / 2) + 3; life_bankWaiting = nil};