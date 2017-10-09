/*
fn_resetPrices.sqf
Kevin Webb
Calls the server to reset our prices for resources
*/
closeDialog 0;
if((call style) < 4) exitWith {hint "This isn't for you to be using."};
_action = [
	"This option will reset prices to their database defaults. are you sure?",
	"Price Reset",
	"Yes",
	"No"
] call BIS_fnc_guiMessage;
if(_action) then {
	[] remoteExec ["DB_fnc_getPrices",2];
};