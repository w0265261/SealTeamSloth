/*
fn_buyTicket.sqf
Authors: Kevin Webb & Mike McCrow
Description: Client portion of lottery system
*/
[] spawn {
If (Life_Handpaper < 300) exitWith {Hint format["Tickets cost $300. You are lacking at least $%1 for a single ticket.",[(300 - Life_HandPaper)] call life_fnc_numberText]};
_Entry = [];
createDialog "STS_KBW_price_diag";
waitUntil{!isNull (findDisplay 13371)};
ctrlSetText[2651,"Type Amount to Buy: $300 each"];
waitUntil{isNull (findDisplay 13371) || life_charged};
if(!(life_charged)) exitWith {};
life_charged = false;
_amount = ctrlText 7331;
if(!([_amount] call fnc_isnumber)) exitWith {hint "You didn't enter an actual number."; closeDialog 0;};
_amount = parseNumber (_amount);
if(_amount <= 0) exitWith { hint "Invalid number"; closeDialog 0; };
if(_amount > 250) exitWith { hint "You may not buy more than 250 tickets in a single purchase."; closeDialog 0; };
_price = 300 * _amount;
if(life_handpaper < _price) exitWith { hint "You do not have enough cash on hand to purchase that many tickets!"; closeDialog 0;};
["cash","take",_price] call life_fnc_handlePaper;
_uid = getPlayerUID player;
_Entry = [_uid,_amount];
Hint format["You have purchased %1 lottery tickets for a price of $%2, good luck!",_amount,[_price] call life_fnc_numberText];
[_Entry] remoteExec ["TON_fnc_manageLottery",2];
closeDialog 0;
};