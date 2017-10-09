/*
fn_handleDuel
Kevin Webb
Handles getting our 2 duelists into a duel arena.
*/
_dueler1 = param [0,ObjNull,[ObjNull]];
_dueler2 = param [1,ObjNull,[ObjNull]];
_reward = param [2,0,[0]];
_duelists = [_dueler1,_dueler2];
if(life_duel1active && life_duel2active && life_duel3active) exitWith {[1,"Unfortunately all duel arenas are currently being used. Try again in a few minutes"] remoteExec ["life_fnc_broadcast",_duelists]};
_place = ceil (random 3);
_var = format["life_duel%1active",_place];
while {call compile _var} do {
	_place = ceil (random 3);
	_var = format["life_duel%1active",_place];
};
_arena = format["duel_arena_%1",_place];
missionNamespace setVariable[_var,true];
[_arena,1] remoteExec ["KBW_fnc_activateDuel",_dueler1];
[_arena,2] remoteExec ["KBW_fnc_activateDuel",_dueler2];
["atm","take",(_reward/2)] remoteExec ["life_fnc_handlePaper",_duelists];
_group1 = group _dueler1;
_group2 = group _dueler2;
_duelgroup1 = createGroup civilian;
_duelgroup2 = createGroup civilian;
[_dueler1] joinSilent _duelgroup1;
[_dueler2] joinSilent _duelgroup2;
_name1 = _dueler1 getVariable["realname",name _dueler1];
_name2 = _dueler2 getVariable["realname",name _dueler2];
while{true} do
{
	uiSleep 2;
	if(count units _duelgroup1 < 1) exitWith {
		[2,format["%1 was victorious!",_name2]] remoteExec ["life_fnc_broadcast",_duelists];
		["atm","add",_reward] remoteExec ["life_fnc_handlePaper",_dueler2];
		["life_dueling",false] remoteExec ["life_fnc_netSetVar",_dueler2];
	};
	if(count units _duelgroup2 < 1) exitWith {
		[2,format["%1 was victorious!",_name1]] remoteExec ["life_fnc_broadcast",_duelists];
		["atm","add",_reward] remoteExec ["life_fnc_handlePaper",_dueler1];
		["life_dueling",false] remoteExec ["life_fnc_netSetVar",_dueler1];
	};
};
switch(_arena) do {
	case "duel_arena_1": {life_duel1active = false};
	case "duel_arena_2": {life_duel2active = false};
	case "duel_arena_3": {life_duel3active = false};
};