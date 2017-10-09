#include <macro.h>
/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Deposits money into the players gang bank.
private["_value"];
*/
if(count life_gangData == 0) exitWith {hint "An error occurred, if you just joined this gang try relogging."};
if(group player getVariable["gang_name",""] != (life_gangData select 2)) exitWith {hint "An error occurred, if you just joined this gang try relogging."};
_value = parseNumber(ctrlText 2702);
_gFund = group player getVariable ["gang_bank",0];
_exit = false;
{if(player in (units(_x select 1))) exitWith {_exit = true};} forEach life_gang_list;
if(_exit) exitWith {}; //nope, we're in a temp group.
_exit = false;
/*Series of stupid checks*/
if(_value > 999999) exitWith {hint "Your transactions cannot be in excess of $1,000,000.";};
if(_value < 0) exitWith {};
if(!([str(_value)] call life_fnc_isnumeric)) exitWith {hint localize "STR_ATM_notnumeric"};
group player setVariable["withdrawing",getPlayerUID player,true];
_action = [
	format["Do you wish to deposit or withdraw $%1 from the gang bank?",[_value] call life_fnc_numberText],
	format["%1 bank balance: %2",group player getVariable["gang_name","Gang"],_gFund],
	"Deposit",
	"Withdraw"
] call BIS_fnc_guiMessage;
if(group player getVariable["withdrawing",""] != getPlayerUID player) exitWith {closeDialog 0; hint "Too many people were interacting with the gang bank at once"};
if(_action) then {
	if(_value > life_myfunds) exitWith {hint localize "STR_NOTF_NotEnoughFunds"; _exit = true;};
	["atm","take",_value] call life_fnc_handlePaper;
	_gFund = _gFund + _value;
	hint format[localize "STR_ATM_DepositGang",[_value] call life_fnc_numberText];
} else {
	if(life_gang_rank < 3) exitWith {hint "You do not have the authority to withdraw from the gang bank"; _exit = true};
	if(_value > _gFund) exitWith { hint "You do not have that much in your gang bank."; _exit = true;};
	["atm","add",_value] call life_fnc_handlePaper;
	_gFund = _gFund - _value;
	hint format["You have withdrawn %1 from your gang bank into your personal bank account",[_value] call life_fnc_numberText];
};
group player setVariable["withdrawing",nil,true];
if(_exit) exitWith {};
(group player) setVariable ["gang_bank",_gFund,true];
[1,group player,_gFund] remoteExec ["TON_fnc_updateGang",2];
[] call life_fnc_atmMenu;