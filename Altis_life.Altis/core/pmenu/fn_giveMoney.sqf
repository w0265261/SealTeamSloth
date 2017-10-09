/*
	File: fn_giveMoney.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Gives the selected amount of money to the selected player.
*/
private["_unit","_amount"];
if(!isNil "escMenuOpen") exitWith {hint "Exploiting? Kevin says you are bad and you should feel bad."; player setDamage 0.99; titleText["You suddenly feel very bad about exploiting...","PLAIN"]};
_amount = ctrlText 2018;
ctrlShow[2001,false];
if((lbCurSel 2022) == -1) exitWith {hint "No one was selected!";ctrlShow[2001,true];};
_unit = lbData [2022,lbCurSel 2022];
_unit = call compile format["%1",_unit];
if(isNil "_unit") exitWith {ctrlShow[2001,true];};
if(_unit == player) exitWith {ctrlShow[2001,true];};
if(isNull _unit) exitWith {ctrlShow[2001,true];};
_headgear = ["H_Shemag_tan","H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk"];
_goggles = ["G_Balaclava_oli","G_Balaclava_lowprofile","G_Balaclava_combat","G_Balaclava_blk"];
if(!life_use_atm) exitWith {hint "You recently robbed a gas station! You can't give money away just yet.";ctrlShow[2001,true];};
if(!([_amount] call fnc_isnumber)) exitWith {hint "You didn't enter an actual number format.";ctrlShow[2001,true];};
if(parseNumber(_amount) <= 0) exitWith {hint "You need to enter an actual amount you want to give.";ctrlShow[2001,true];};
if(parseNumber(_amount) > life_handpaper) exitWith {hint "You don't have that much to give!";ctrlShow[2001,true];};
if(isNull _unit) exitWith {ctrlShow[2001,true];};
if(isNil "_unit") exitWith {ctrlShow[2001,true]; hint "The selected player is not within range";};
//if(playerSide == west && side _unit in[civilian,independent] && !(_unit getVariable["bountyHunter",false])) exitWith {hint "You should not be giving money to civilians!"; ctrlShow[2001,true];};
//if(playerSide in[civilian,independent] && side _unit == west) exitWith {hint "The transfer of funds between sides is prohibited"; ctrlShow[2001,true];};
_to = "";
_from = "";
if(headGear _unit in _headgear || goggles _unit in _goggles) then {_to = "Masked Man"} else {_to = _unit getVariable["realname",name _unit]};
if(headGear player in _headgear || goggles player in _goggles) then {_from = "Masked Man"} else {_from = player getVariable["realname",name player]};
hint format["You gave $%1 to %2",[(parseNumber(_amount))] call life_fnc_numberText,_to];
["cash","take",(parseNumber(_amount))] call life_fnc_handlePaper;
if(life_hacker) exitWith {};
[_unit,_amount,player,_from,name _unit] remoteExec ["life_fnc_receiveMoney",_unit];
[] call life_fnc_p_updateMenu;

ctrlShow[2001,true];