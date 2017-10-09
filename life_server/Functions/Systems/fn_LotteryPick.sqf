/*
fn_LotteryPick.sqf
Mike McCrow & Kevin Webb
Draws the winner!
*/
private["_Entries","_Count","_JackPot","_Odds","_Pick","_Winner","_query","_Roll"];
_stored = profileNamespace getVariable["lottery",[]];
_Entries = [];
{
for [{_i=0},{_i<(_x select 1)},{_i=_i+1}] do
{
_Pick = (floor(random(1000)));
_Entries pushBack [_x select 0,_Pick];
};
} forEach _stored;
_Count = count _Entries;
_query = "SELECT jackpot FROM lottery WHERE id = '1'";

_Roll = [_query,2] call DB_fnc_asyncCall;
_Roll = _Roll select 0;
_JackPot = (300 * _Count) * 0.9;
_JackPot = _JackPot + _Roll;
_Pick = (floor(random(1000)));
_Winners = [];
{
if(_Pick == (_x select 1) ) then {
_Winners pushBack (_x select 0);
}; 
} forEach _Entries;
If ( (count(_Winners)) < 1 ) exitWith {
[0,format["No one has won the lottery! $%1 will be added to next drawing.",[_Jackpot] call life_fnc_numberText]] remoteExec ["life_fnc_broadcast",0];
_Roll = [_JackPot] call DB_fnc_numberSafe;
_query = format["Update lottery SET jackpot='%1' WHERE id=1",_Roll];

[_query,1] call DB_fnc_asyncCall;
profileNamespace setVariable["lottery",[]];
};
_query = format["Update lottery SET jackpot='%1' WHERE id=1",0];

[_query,1] call DB_fnc_asyncCall;
[0,format["Someone has won the lottery jackpot of $%1!",[_Jackpot] call life_fnc_numberText]] remoteExec ["life_fnc_broadcast",0];
_Split = _JackPot / (count(_Winners));
_WinnersOnline = [];

{
	_uid = _x;
	if([_uid] call life_fnc_isUIDActive) then { 
		_WinnersOnline pushBack _uid;
	} else {
		[0,_Split,_uid] spawn TON_fnc_compUID;
		_query = format["SELECT name FROM players WHERE playerid='%1'",_uid];
		
		_name = [_query,2] call DB_fnc_asyncCall;
		_name = _name select 0;
		[0,format["%1 is a winner!",_name]] remoteExec ["life_fnc_broadcast",0];
	};
} forEach _Winners;
{
if (getPlayerUID _x in _WinnersOnline) then 
{
["atm","add",_Split] remoteExec ["life_fnc_handlePaper",_x,false];
[2,format["You have won $%1 from the lottery!",[_Split] call life_fnc_numberText]] remoteExec ["life_fnc_broadcast",_x,false];
[1,format["You have won $%1 from the lottery!",[_Split] call life_fnc_numberText]] remoteExec ["life_fnc_broadcast",_x,false];
[0,format["%1 is a winner!",name _x]] remoteExec ["life_fnc_broadcast",0];
};
} forEach playableUnits;
profileNamespace setVariable["lottery",[]];