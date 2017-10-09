/*
fn_startRace.sqf
Kevin Webb
Sets up the race for the "true_racers"
*/
_racers = param [0,[],[[]]];
_point = param [1,[],[[]]];
_stake = param [2,0,[0]];
[_point,_stake] remoteExec ["KBW_fnc_initRace",_racers];
_winner = ObjNull;
_exit = false;
while {isNull _winner} do {
//uiSleep 0.1;
{if(vehicle _x distance _point < 12) exitWith {_winner = _x};} forEach _racers;
};
[2,format["%1 won the race!",_winner getVariable["realname",name _winner]]] remoteExec ["life_fnc_broadcast",_racers];
["atm","add",(_stake * (count _racers))] remoteExec ["life_fnc_handlePaper",_winner];
["raceDone",true] remoteExec ["life_fnc_netSetVar",_racers];