/*
	File: fn_bankDeposit.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Figure it out.
*/
private["_value"];
if(!isNil "life_bankWaiting") exitWith {};
if(life_gov) exitWith {hint "You can only withdraw from the government coffers."};
_param = param [0,0,[0]];
if(_param == 1) then {
["cash","set",floor(life_handpaper)] call life_fnc_handlePaper;
_value = life_handpaper;
} else {
_value = parseNumber(ctrlText 2702); };

/*Series of stupid checks*/
if(_value > 999999) exitWith {hint localize "STR_ATM_GreaterThan";};
if(_value < 0) exitWith {};
if(!([str(_value)] call life_fnc_isnumeric)) exitWith {hint localize "STR_ATM_notnumeric"};
if(_value > life_handpaper) exitWith {hint localize "STR_ATM_NotEnoughCash"};

["deposit",nil,_value] call life_fnc_handlePaper;

hint format[localize "STR_ATM_DepositMSG",[_value] call life_fnc_numberText];
[] call life_fnc_atmMenu;