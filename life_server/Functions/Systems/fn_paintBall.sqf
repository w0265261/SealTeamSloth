/*
paintball
Kevin Webb
server side handling of paintball
*/
private["_painters","_number","_team","_group","_time","_painterArray"];
_painterArray = [paint_1,paint_2,paint_3,paint_4];
if(life_paintBalling) exitWith { [3,"life_fnc_initPaint",_this select 0,false]; };
if(isNull (_this select 0)) exitWith {};
life_paintBallers pushBack (_this select 0);
if(count life_paintBallers == 1) then {
_time = time + 30;
	waitUntil{uiSleep 0.3; (_time - time <= 0 || count life_paintBallers > 9)};
	if(count life_paintBallers < 2) exitWith {
		{ if(!isNull _x) then {1 remoteExec ["life_fnc_initPaint",_x];}; } forEach life_paintBallers;
		life_paintBallers = [];
};
_painters = life_paintBallers;
life_paintBallers = [];
{ _check = false; _painter = _x; {if(_painter distance _x < 50 || _painter distance (markerPos "paint_arena") < 110) then {_check = true;};} forEach _painterArray; if(_check && !isNull _x && vehicle _x == _x && !(_x getVariable["restrained",false] || _x getVariable["zipTie",false] || _x getVariable["unconscious",false])) then {life_paintBallers pushBack _x}; } forEach _painters;
if(count life_paintBallers < 2) exitWith {
		{ if(!isNull _x) then {1 remoteExec ["life_fnc_initPaint",_x];}; } forEach life_paintBallers;
		life_paintBallers = [];
};
life_paintBalling = true;
_number = 1;
_team = true;
_redGroup = createGroup civilian;
_blueGroup = createGroup civilian;
{
[2,_number,_team] remoteExec ["life_fnc_initPaint",_x,false];
_number = _number + 1;
if(_number > 5) then {_number = 1;};
if(_team) then {[_x] joinSilent _redGroup; _team = false;} else {[_x] joinSilent _blueGroup; _team = true;};
} forEach life_paintBallers;
while{true} do
{
	uiSleep 2;
	if(count units _redGroup < 1) exitWith {
		_blue = units _blueGroup;
		{
		[2,"The blue team was the winner!"] remoteExec ["life_fnc_broadcast",_x,false];
		} forEach life_paintBallers;
		{ 4 remoteExec ["life_fnc_initPaint",_x,false]; } forEach _blue;
	};
	if(count units _blueGroup < 1) exitWith {
		_red = units _redGroup;
		{
		[2,"The red team was the winner!"] remoteExec ["life_fnc_broadcast",_x,false];
		} forEach life_paintBallers;
		{ 4 remoteExec ["life_fnc_initPaint",_x,false]; } forEach _red;
	};
};
life_paintBalling = false;
life_paintBallers = [];
};