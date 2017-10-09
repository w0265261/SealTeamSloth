/*
	COPY PASTE TIME
*/
if(!isNil "life_bankWaiting") exitWith {};
private["_val"];
_value = if(life_gov) then {gov_bank} else {life_myfunds};
_val = parseNumber(ctrlText 2702);
if(_val > 999999) exitWith {hint localize "STR_ATM_WithdrawMax";};
if(_val < 0) exitwith {};
if(!([str(_val)] call life_fnc_isnumeric)) exitWith {hint localize "STR_ATM_notnumeric"};
if(_val > _value) exitWith {hint localize "STR_ATM_NotEnoughFunds"};
if(_val < 100 && _value > 20000000) exitWith {hint localize "STR_ATM_WithdrawMin"}; /*Temp fix for something.*/
if(life_gov) then {[_val,true] remoteExecCall ["life_fnc_updateGovBank",2]; gov_bank = gov_bank - _val; ["cash","add",_val] call life_fnc_handlePaper;
} else {
	["withdraw",nil,_val] call life_fnc_handlePaper;
};
hint format [localize "STR_ATM_WithdrawSuccess",[_val] call life_fnc_numberText];
[life_gov] call life_fnc_atmMenu;