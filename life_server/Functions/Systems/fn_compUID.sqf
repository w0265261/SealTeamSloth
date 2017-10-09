/*
fn_compUID.sqf
Kevin Webb
For adding/subtracting money from offline players. Comp request mastery!
*/
private["_type","_amount","_uid","_query","_queryResult"];
_type = param [0,0,[0]];
_amount = param [1,0,[0]];
_uid = param [2,"",[""]];
_query = "";
if(_type == 0) then {
	_query = format["UPDATE players SET bankacc = bankacc + %1 WHERE playerid='%2'",_amount,_uid];
} else {
	_query = format["UPDATE players SET bankacc = bankacc - %1 WHERE playerid='%2'",_amount,_uid];
};

[_query,1] call DB_fnc_asyncCall;