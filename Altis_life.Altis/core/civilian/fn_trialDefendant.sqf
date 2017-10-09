/*
	File: fn_trialDefendant.sqf
	Author: John "Paratus" VanderZwet

	Description:
	Your trial has begun!
*/
life_inTrial = true;
["atm","take",floor(life_bail_amount / 5)] call life_fnc_handlePaper;
[[0,1,2], "Your trial has begun. You have 45 seconds to convince the jury of your innocence. Good luck."] spawn life_fnc_broadcast;
[] spawn {
waitUntil{player distance markerPos "jail_marker" > 100};
sleep 0.5;
player setDir 0;
[player] spawn life_fnc_restrain;
};

//Setup our progress bar
_title = "Plead your innocence";
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNamespace getVariable ["life_progress",displayNull];
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;
while {true} do
{
	sleep 0.6;
	_cP = _cP + 0.01;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if (!life_trial_inprogress) exitWith {};
	if (_cP >= 1) exitWith{};
};

5 cutText ["","PLAIN"];

waitUntil {life_trial_deliberating};
life_inTrial = false;
[[0,1,2], "The jury is now deliberating.  You will have the verdict soon."] spawn life_fnc_broadcast;
[player] call life_fnc_unrestrain;

waitUntil {!life_trial_inprogress && !isNil "life_trial_verdict"};

_verdict = "GUILTY";
if (life_trial_verdict) then
{
	_verdict = "NOT GUILTY";
	//if(life_bail_amount <= 40000) then {
		[true] call life_fnc_postBail;
	/*} else {
		totaltime = totaltime / 2;
		jail_time = floor(totaltime / 60);
		[getPlayerUID player,jail_time] remoteExec ["life_fnc_saveJailTime",2];
	};*/
} else {
	totaltime = totaltime + 300;
	jail_time = jail_time + 5;
	[getPlayerUID player,jail_time] remoteExec ["life_fnc_saveJailTime",2];
};

[[0,1,2], format["A verdict has been reached.  You, the defendant, were found %1.", _verdict]] spawn life_fnc_broadcast;