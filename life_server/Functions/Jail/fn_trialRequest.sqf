/*
fn_trialRequest.sqf
Kevin Webb
Monitors the players who may participate in the court proceeding
*/
_defendant = param [0,ObjNull,[ObjNull]];
_bail = param [1,0,[0]];
_response = param [2,false,[false]];
if(_response) exitWith {
	if(count life_jurors > 5 || !life_trial_inprogress) exitWith {};
	_add = param [3,true,[true]];
	if(_add) then {
		life_jurors pushBack _defendant;
	} else {
		life_jurors = life_jurors - _defendant;
	};
};
life_jury_vote = [];
life_jurors = [];
life_trial_inprogress = true;
publicVariable "life_trial_inprogress";
[_defendant] remoteExec ["life_fnc_jurySummons",civilian];
_time = serverTime;
waitUntil {uiSleep 0.3; serverTime - _time > 300 || count life_jurors > 5 || isNull _defendant};
if(count life_jurors < 6) exitWith {
	[1,"Unfortunately the court proceeding was unable to start. You have been rewarded the promised $2,000 regardless."] remoteExec ["life_fnc_broadcast",life_jurors];
	["atm","add",2000] remoteExec ["life_fnc_handlePaper",life_jurors];
	life_trial_inprogress = false;
	publicVariable "life_trial_inprogress";
};
[0,"All jurors have reported for duty!"] remoteExec ["life_fnc_broadcast",civilian];
[] remoteExec ["life_fnc_trialDefendant",_defendant];
[_defendant,_bail] remoteExec ["life_fnc_trialJury",life_jurors];
sleep 1;
{
	_pos = markerPos format["juror_%1",_forEachIndex];
	_pos set[2,1];
	_x setPos _pos;
} forEach life_jurors;
_defendant setDir 0;
_defendant setPos [markerPos "defendant" select 0, markerPos "defendant" select 1, (markerPos "defendant" select 2) + 2];
uiSleep 59;
life_trial_deliberating = true;
publicVariable "life_trial_deliberating";
uiSleep 59;
if(count life_jury_vote > 3) then {life_trial_verdict = true} else {life_trial_verdict = false};
life_trial_deliberating = false;
life_trial_inprogress = false;
life_trial_cooldown = true;
publicVariable "life_trial_cooldown";
publicVariable "life_trial_deliberating";
_verdict = if(life_trial_verdict) then {"NOT GUILTY"} else {"GUILTY"};
[0,format["%1 was found %2 by the Grand Jury of Altis!",name _defendant,_verdict]] remoteExec ["life_fnc_broadcast",0];
publicVariable "life_trial_verdict";
publicVariable "life_trial_inprogress";
sleep 5;
life_trial_verdict = nil;
publicVariable "life_trial_verdict";
[] spawn {
	uiSleep 895;
	life_trial_cooldown = false;
	publicVariable "life_trial_cooldown";
};
_msg = format["Trial verdict for %1: %2. Individual results: ",name _defendant,_verdict];
{ if(_x in life_jury_vote) then {_msg = _msg + format["%1: Not Guilty ",name _x]} else {_msg = _msg + format["%1: Guilty ",name _x]}; } forEach life_jurors;
[3,-1,_msg] call life_fnc_newMsg;