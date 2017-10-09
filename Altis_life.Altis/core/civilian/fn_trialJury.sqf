/*
	File: fn_trialJury.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Jury duty has begin!
*/

_defendant = param [0,objNull,[objNull]];
_amount = param [1,1,[1]];
if(dialog) then {closeDialog 0};
disableUserInput true;
private ["_dialog","_text"];

[[0,2], format["The trial for the defendant %1 has begun. Their bail is currently $%2. YOU MUST CHOOSE YOUR VERDICT BEFORE TIME ELAPSES.  Failure to choose a verdict will result in a guilty default.", name _defendant, [_amount] call life_fnc_numberText]] spawn life_fnc_broadcast;
life_jury_registered = nil;
life_trial_verdict = nil;
life_jury_active = true;
_defendant spawn {
	waitUntil{player distance _this < 50};
	player switchMove "";
	player setDir 180;
	_pos = getPosATL player;
	_pos set[2,4];
	_Camera  = "CAMERA" camCreate _pos;
	_Camera cameraEffect ["Internal","Back"];
	_Camera camSetTarget _this;
	_Camera camSetFOV .6;
	_Camera camCommit 0;
	waitUntil {life_trial_deliberating};
	_Camera cameraEffect ["TERMINATE","BACK"];
	camDestroy _Camera;
};
_defendant spawn
{
	waitUntil{player distance _this < 50};
	player allowDamage false;
	waitUntil { player distance (getMarkerPos "courtroom") > 50 };
	player allowDamage true;
	life_jury_active = nil;
};

//Setup our progress bar
_title = "Court in session";
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

//Kill the UI display and check for various states
5 cutText ["","PLAIN"];

waitUntil {life_trial_deliberating};

life_jury_response = nil;
disableUserInput false;
hintSilent parseText "<t align='center'>Don't decide too quickly, the jury will deliberate for 45 seconds. Speak your opinion. <t color='#00FF00'>Use your scroll wheel to choose your verdict!</t></t>";
player addAction ["Vote <t color='#00FF00'>NOT GUILTY</t>", {life_jury_response = true;},false,6,false,true,"",'isNil "life_jury_response"'];
player addAction ["Vote <t color='#FF0000'>GUILTY</t>", {life_jury_response = false},false,6,false,true,"",'isNil "life_jury_response"'];

[] spawn
{
	waitUntil {!isNil "life_jury_response" || !life_trial_deliberating || !life_trial_inprogress};
	if (!isNil "life_jury_response") then { if (life_jury_response) then { player remoteExec ["life_fnc_juryVote",2]; }; };
	removeAllActions player;
};

//Setup our progress bar
_title = "Jury deliberating";
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
	if (!life_trial_deliberating || !life_trial_inprogress) exitWith {};
	if (_cP >= 1) exitWith{};
};

5 cutText ["","PLAIN"];

waitUntil {!life_trial_inprogress && !isNil "life_trial_verdict"};

_verdict = "GUILTY";
if (life_trial_verdict) then { _verdict = "NOT GUILTY"; };
closeDialog 0;

[[0,2], format["A verdict has been reached. The defendant, %1, was found %2. As payment for your time, the government of %3 has awarded you $2000.", name _defendant, _verdict, worldName]] spawn life_fnc_broadcast;

player setPosATL life_originalPos;
life_jury_active = nil;

["atm","add",2000] call life_fnc_handlePaper;