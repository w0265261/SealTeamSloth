/*
fn_listHouse.sqf
Kevin Webb
Description: Initialization for listing your house for sale.
*/
_house = param [0,ObjNull,[ObjNull]];
if(_house getVariable["listPrice",-1] > 0) exitWith {_house setVariable["listPrice",nil,true]; hint "The house has been removed sales listing"; [_house,0] remoteExec ["TON_fnc_listHouse",2];};
_action = [
	"Choosing to list your house for sale means that any player can purchase it for the asking price you define. Are you sure?",
	"List house for sale",
	localize "STR_Global_Yes",
	localize "STR_Global_No"
] call BIS_fnc_guiMessage;
createDialog "STS_KBW_price_diag";
waitUntil{!isNull (findDisplay 13371)};
waitUntil{isNull (findDisplay 13371) || life_charged};
if(!(life_charged)) exitWith {hint "House listing cancelled"};
life_charged = false;
_price = ctrlText 7331;
if(!([_price] call fnc_isnumber)) exitWith {hint "You didn't enter an actual number."; closeDialog 0;};
_price = parseNumber _price;
if(_price < 0) exitWith { hint "Invalid number"; closeDialog 0; };
if(_price > 300000) exitWith {hint "That price is too high... You can't realistically list it for that!"; closeDialog 0;};
hint format["The house has successfully been listed for sale at a price of %1. You will continue to own it up until the point that another player purchases it.",_price];
[_house,_price] remoteExec ["TON_fnc_listHouse",2];
_house setVariable["listPrice",_price,true];
closeDialog 0;