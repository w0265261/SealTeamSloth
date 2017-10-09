/*
	File: fn_queryRequest.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Handles the incoming request and sends an asynchronous query 
	request to the database.
	
	Return:
	ARRAY - If array has 0 elements it should be handled as an error in client-side files.
	STRING - The request had invalid handles or an unknown error and is logged to the RPT.
*/
private["_uid","_side","_query","_return","_queryResult","_qResult","_handler","_thread","_loops"];
_uid = param [0,"",[""]];
_side = param [1,sideUnknown,[civilian]];
_ownerID = param [2,ObjNull,[ObjNull]];
_name = param[3,""];
if(isNull _ownerID) exitWith {};
_player = _ownerID;
//_ownerID = owner _ownerID;

_query = switch(_side) do {
	case west: {
		_underCover = false; 
		{
			_var = format["undercover_%1",_x];
			if((missionNameSpace getVariable _var) == _player) exitWith {_undercover = true};
		} forEach [1,2,3,4];
		if(_underCover) then {
			format["SELECT name, copcash, copbank, adminlevel, donatorlvl, cop_licenses, coplevel, under_gear, blacklist, cop_locker, prestige, ownedWeapons, voted FROM players WHERE playerid='%1'",_uid];
		} else {
			format["SELECT name, copcash, copbank, adminlevel, donatorlvl, cop_licenses, coplevel, cop_gear, blacklist, cop_locker, prestige, ownedWeapons, voted FROM players WHERE playerid='%1'",_uid];
		};
	};
	case civilian: {format["SELECT name, cash, bankacc, adminlevel, donatorlvl, civ_licenses, arrested, civ_gear, alive, civPosition, jailTime, factory, mailbox, voted, fakeName FROM players WHERE playerid='%1'",_uid];};
	case independent: {format["SELECT name, cash, bankacc, adminlevel, donatorlvl, med_licenses, mediclevel, voted FROM players WHERE playerid='%1'",_uid];};
};


_queryResult = [_query,2] call DB_fnc_asyncCall;

if(typeName _queryResult == "STRING" || count _queryResult == 0) exitWith {
	[] remoteExec ["SOCK_fnc_insertPlayerInfo",_ownerID,false];
};


private["_tmp"];
_tmp = _queryResult select 1;
_queryResult set[1,[_tmp] call DB_fnc_numberSafe];
_tmp = _queryResult select 2;
_queryResult set[2,[_tmp] call DB_fnc_numberSafe];

/*Convert tinyint to boolean*/
_old = _queryResult select 5;
for "_i" from 0 to (count _old)-1 do
{
	_data = _old select _i;
	_old set[_i,[_data select 0, ([_data select 1,1] call DB_fnc_bool)]];
};

_queryResult set[5,_old];


switch (_side) do {
	case west: {
		_queryResult set[8,([_queryResult select 8,1] call DB_fnc_bool)];
		_queryResult set[12,([_queryResult select 12,1] call DB_fnc_bool)];
	};
	
	case civilian: {
	[_uid,_ownerID] spawn {
		_query = format["SELECT COUNT(*) FROM exchange WHERE active=1 AND pid='%1' AND BuyorSell=0",_this select 0];
		_sql = [_query,2] call DB_fnc_asyncCall;
		_sql = _sql select 0;
		["life_offers",_sql] remoteExec ["life_fnc_netSetVar",_this select 1];
		_query = format["SELECT type, position FROM tents WHERE pid='%1' AND alive='1'",_this select 0];
		_tents = [_query,2] call DB_fnc_asyncCall;
		if(count _tents > 0) then {
			["life_tent",_tents] remoteExec ["life_fnc_netSetVar",_this select 1];
		};
	};
		_queryResult set[6,([_queryResult select 6,1] call DB_fnc_bool)];
		_queryResult set[13,([_queryResult select 13,1] call DB_fnc_bool)];
		_houseData = _uid spawn TON_fnc_fetchPlayerHouses;
		waitUntil {scriptDone _houseData};
		_houses = missionNamespace getVariable[format["houses_%1",_uid],[]];
		_queryResult pushBack _houses;
		_queryResult pushBack (missionNamespace getVariable[format["gang_%1",_uid],[]]);
		_queryResult set [8,([_queryResult select 8,1] call DB_fnc_bool)];

	};
	
	case independent: {
		_queryResult set[7,([_queryResult select 7,1] call DB_fnc_bool)];
	}
};
[_uid,_ownerID] spawn {
	_query = format["SELECT fromID, toID, message, fromName, toName FROM messages WHERE toID='%1' ORDER BY time DESC",_this select 0];
	_result = [_query,2,true] call DB_fnc_asyncCall;
	if(count _result > 0) then {
		["life_messages",_result,true] remoteExec ["life_fnc_netSetVar",_this select 1];
	};
};

_queryResult remoteExec ["SOCK_fnc_requestReceived",_ownerID];
if(_side == civilian) then {
	[_uid,_name,_player] spawn TON_fnc_loadBounties;
};