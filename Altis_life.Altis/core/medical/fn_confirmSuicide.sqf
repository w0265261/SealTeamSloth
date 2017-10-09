/*
fn_confirmSuicide
Kevin Webb
Confirmation dialog for confirming their own demise.
*/
private["_action"];
_action = [
"Are you sure you want to suicide?",
"Ending your life...",
localize "STR_Global_Yes",
localize "STR_Global_No"
] call BIS_fnc_guiMessage;
if(life_medreq) exitWith { systemChat "You cannot suicide once you have requested a medic. Stop wasting their time." };
if(!(player getVariable["restrained",false] || player getVariable["zipTie",false]) && _action) then { life_suicide = true; player setDamage 1; };