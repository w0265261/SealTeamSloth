/*
	File: fn_insertRequest.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Does something with inserting... Don't have time for
	descriptions... Need to write it...
*/
private["_uid","_name","_side","_money","_bank","_licenses","_handler","_thread","_queryResult","_query","_alias"];
_uid = param [0,"",[""]];
_name = param [1,"",[""]];
_money = 0;
_bank = 75000;
_returnToSender = param [2,ObjNull,[ObjNull]];

if((_uid == "") OR (_name == "")) exitWith {systemChat "Bad UID or name";};
if(isNull _returnToSender) exitWith {systemChat "ReturnToSender is Null!";};

_query = format["SELECT playerid, name FROM players WHERE playerid='%1'",_uid];

_queryResult = [_query,2] call DB_fnc_asyncCall;

if(typeName _queryResult == "STRING") exitWith {[] remoteExec ["SOCK_fnc_dataQuery",_returnToSender,false];};
if(count _queryResult != 0) exitWith {[] remoteExec ["SOCK_fnc_dataQuery",_returnToSender,false];};


_name = [_name] call DB_fnc_mresString;
_alias = [_name];
_money = [_money] call DB_fnc_numberSafe;
_bank = [_bank] call DB_fnc_numberSafe;

_query = format["INSERT INTO players (playerid, name, cash, bankacc, aliases, cop_licenses, med_licenses, civ_licenses, civ_gear, cop_gear, bounties, civPosition, factory, cop_locker, under_gear, mailbox, ownedWeapons, jailTime) VALUES('%1', '%2', '%3', '%4', '%5','[]','[]','[]','[]','[]','[]','[0,0,0]','[]','[]','[]','[]','[]','[2,1000]')",
	_uid,
	_name,
	_money,
	_bank,
	_alias
];

[_query,1] call DB_fnc_asyncCall;

_query = format["INSERT INTO vehicles (side, classname, type, pid, plate, color, inventory, virtItems, customName, position) VALUES ('civ','C_Hatchback_01_F','Car','%1',%2,%3,'[]','[]','Starting Car','[]')",_uid,round(random 100000),round(random 6)];
[_query,1] call DB_fnc_asyncCall;
[] remoteExec ["SOCK_fnc_dataQuery",_returnToSender,false];