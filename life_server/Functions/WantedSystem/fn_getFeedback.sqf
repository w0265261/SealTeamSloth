/*
Kevin Webb
getFeedback.sqf
pulls info from the DB
*/

_query = "SELECT reporter,cops,rating,message FROM feedback where DATEDIFF(TIME,now()) < 31";
_info = [_query,2,true] call DB_fnc_asyncCall;
[1,_info] remoteExecCall ["life_fnc_readFeedback",_this];