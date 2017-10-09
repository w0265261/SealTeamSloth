/*
	File: fn_requestTrial.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Requests a trial.
*/
if(life_trial_inprogress) exitWith {systemChat "Another trial is already in process and the courts are at capacity.  Try again shortly."};
if(life_trial_cooldown) exitWith {systemChat "A trial was conducted too recently for another one to take place so soon, sorry!"};
if(playersNumber civilian < 10) exitWith {systemChat "It doesn't seem there are enough civilians online to get a proper sample of the population in the jury."};
if((life_bail_amount / 5) > life_myFunds) exitWith {systemChat "You don't have enough to meet your court costs!"};
_action = [
	format["This action will send a request to form an eligible jury from the civilian populace. It will cost you %1$. If you win, you will be released; if you lose, 5 minutes will be added to your sentence. Are you sure?",life_bail_amount/5],
	"Go to Court!",
	"Yes",
	"No"
] call BIS_fnc_GUImessage;
if(!_action) exitWith {};
[player,life_bail_amount] remoteExec ["life_fnc_trialRequest",2];

life_request_trial = true;
systemChat "Your trial request has been submitted.  It may take as long as 5 minutes before you receive word concerning the trial.";