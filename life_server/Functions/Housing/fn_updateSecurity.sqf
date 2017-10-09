/*
	Author: Pennyworth
	
	Description:
	Server side of upgrading house security
*/
private["_house","_houseID","_security","_query"];
_house = param [0,ObjNull,[ObjNull]];
_security = param [1,0,[0]];
if(isNull _house) exitWith {systemChat "House null";};
_houseID = _house getVariable["house_id",-1];
if(_houseID == -1) exitWith {systemChat "HouseID invalid";};

_query = format["UPDATE houses SET security='%1' WHERE id='%2'",_security,_houseID];

[_query,1] call DB_fnc_asyncCall;