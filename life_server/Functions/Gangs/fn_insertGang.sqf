/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Inserts the gang into the database.
*/
private["_ownerID","_uid","_gangName","_query","_queryResult","_group"];
_ownerID = param [0,ObjNull,[ObjNull]];
_uid = param [1,"",[""]];
_gangName = param [2,"",[""]];
_group = group _ownerID;

if(isNull _ownerID OR _uid == "" OR _gangName == "") exitWith {}; 

//_ownerID = owner _ownerID;
_gangName = [_gangName] call DB_fnc_mresString;
_query = format["SELECT id FROM gangs WHERE name='%1' AND active='1'",_gangName];

_queryResult = [_query,2] call DB_fnc_asyncCall;

/*Check to see if the gang name already exists.*/
if(count _queryResult != 0) exitWith {
	[1,"There is already a gang created with that name please pick another name."] remoteExec ["life_fnc_broadcast",_ownerID,false];
	["life_action_gangInUse",nil,missionNamespace] remoteExec ["life_fnc_netSetVar",_ownerID,false];
};


/*Check to see if a gang with that name already exists but is inactive.*/
_query = format["SELECT id, active FROM gangs WHERE name='%1' AND active='0'",_gangName];

_queryResult = [_query,2] call DB_fnc_asyncCall;

if(count _queryResult != 0) then {
	_query = format["UPDATE gangs SET active='1', owner='%1' WHERE id='%2'",_uid,(_queryResult select 0)];
} else {
	_query = format["INSERT INTO gangs (owner, name) VALUES('%1','%2')",_uid,_gangName];
};

_queryResult = [_query,1] call DB_fnc_asyncCall;

_group setVariable["gang_name",_gangName,true];
_group setVariable["gang_owner",_uid,true];
_group setVariable["gang_bank",0,true];
[_group] remoteExec ["life_fnc_gangCreated",_ownerID,false];

sleep 0.35;
_query = format["SELECT id FROM gangs WHERE owner='%1' AND active='1'",_uid];

_queryResult = [_query,2] call DB_fnc_asyncCall;

_group setVariable["gang_id",(_queryResult select 0),true];

_query = format["UPDATE players SET gangrank='5',gangid='%1' WHERE playerid='%2'",(_queryResult select 0),_uid];
[_query,1] call DB_fnc_asyncCall;