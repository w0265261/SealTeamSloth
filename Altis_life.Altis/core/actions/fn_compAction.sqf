/*
File: fn_compAction.sqf
Author: Kevin Webb
Description: The client runs this to finish the comping process
*/
_type = param [0,0,[0]];
_amount = param [1,0,[0]];
_admin = param [2,"",[""]];

if(_type == 0) then {
	["atm","add",_amount] call life_fnc_handlePaper;
	hint format["You have received $%1 in compensation to your bank account from the Admin %2",_amount,_admin];
} else {
	["atm","take",_amount] call life_fnc_handlePaper;
	hint format["Your bank account has been deducted $%1 by Admin %2",_amount,_admin];
};