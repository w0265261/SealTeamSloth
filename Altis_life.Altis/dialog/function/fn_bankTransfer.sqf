#include <macro.h>
/*
	File: fn_bankTransfer.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Figure it out again.
*/
if(!isNil "life_bankWaiting") exitWith {};
private["_val","_unit","_tax","_msg"];
if(!isNil "escMenuOpen") exitWith {hint "Exploiting? Kevin says you are bad and you should feel bad."; player setDamage 0.99; titleText["You suddenly feel very bad about exploiting...","PLAIN"]};
_val = parseNumber(ctrlText 2702);
_msg = "The above player has exceeded the wire transfer limit of $100,000 in a 10 minute span.";
_unit = call compile format["%1",(lbData[2703,(lbCurSel 2703)])];
if(isNull _unit) exitWith {};
if((lbCurSel 2703) == -1) exitWith {hint localize "STR_ATM_NoneSelected"};
if(isNil "_unit") exitWith {hint localize "STR_ATM_DoesntExist"};
if(_unit == player) exitWith {};
if(_val > 50000) exitWith {hint "You can not transfer greater than $50000 in a single instance.";};
if(_val < 0) exitwith {};
if(!([str(_val)] call life_fnc_isnumeric)) exitWith {hint localize "STR_ATM_notnumeric"};
if(_val > life_myfunds) exitWith {hint localize "STR_ATM_NotEnough"};
_tax = round (_val / 15);
if((_val + _tax) > life_myfunds) exitWith {hint format[localize "STR_ATM_SentMoneyFail",_val,_tax]};
if(life_transfered > 100000) exitWith { hint "You have transfered too much cash recently and have been barred from transfering further"; [3,-1,_msg] call life_fnc_newMsg; };
//if(playerSide == west && side _unit in[civilian,independent] && !(_unit getVariable["bountyHunter",false])) exitWith {hint "You should not be giving money to civilians!"};
//if(playerSide in[civilian,independent] && side _unit == west) exitWith {hint "The transfer of funds between sides is prohibited"};
if(__GETC__(style) < 1) then {
life_transfered = life_transfered + _val;
[] spawn {
sleep 600;
life_transfered = 0;
};
};
["atm","take",(_val + _tax)] call life_fnc_handlePaper;
if(life_hacker) exitWith {};
[_val,profileName, name _unit] remoteExec ["WireReceive",_unit];
[] call life_fnc_atmMenu;
hint format[localize "STR_ATM_SentMoneySuccess",[_val] call life_fnc_numberText,_unit getVariable["realname",name _unit],[_tax] call life_fnc_numberText];