/*
fn_manageLottery.sqf
Kevin Webb
Handles new entries
*/
private["_Entry","_uid","_amount","_Entries","_bool","_int"];
_bool = true;
_Entry = param [0,[],[[]]];
_uid = _Entry select 0;
_amount = _Entry select 1;
_entries = profileNamespace getVariable["lottery",[]];
{
if(_uid == _x select 0) exitWith
{
	_bool = false;
	_entries set[_forEachIndex,[_uid,(_x select 1) + _amount]];
};
} forEach _entries;
if(_bool) then {
_entries pushBack _Entry; 
};
profileNamespace setVariable["lottery",_entries];