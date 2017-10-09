/*
fn_updateMailbox.sqf
Kevin Webb
Description: Simply updates the database with your new mailbox inventory.
*/
_box = param [0,[],[[]]];
_uid = param [1,"",[""]];
_query = format["UPDATE players SET mailbox='%1' WHERE playerid='%2'",_box,_uid];
[_query,1] call DB_fnc_asyncCall;