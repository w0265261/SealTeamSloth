/*
	File: fn_newCandidate.sqf
	Author: John "Paratus" VanderZwet
	Governor system modified for compatibility and optimization by Kevin
	
	Description:
	Send candidacy to server for review.
*/
private["_invest","_policy"];
_invest = parseNumber(ctrlText 6802);
_policy = ctrlText 6804;
if(!([str(_invest)] call life_fnc_isnumber)) exitWith {hint "Your investment isn't in an actual number format."};
if(_invest < 0) exitWith {};
if(_invest > 999999) exitWith {hint "You can't invest more then $999,999!";};
if(_invest < 25000) exitWith {hint "You must invest at least $25,000 to run for office.";};
_len = [_policy] call KRON_StrLen;
if(_len > 300) exitWith {hint "The maximum character limit for a policy is 300."};

if(_invest > life_myFunds) exitWith {hint "You don't have that much in your bank account!"};
["atm","take",_invest] call life_fnc_handlePaper;

[player, _invest * -1, _policy] remoteExec ["life_fnc_submitCandidate",2];

closeDialog 0;
hint format ["Your candidacy has been received and you are now running for office with an investment of $%1!",[_invest] call life_fnc_numberText];