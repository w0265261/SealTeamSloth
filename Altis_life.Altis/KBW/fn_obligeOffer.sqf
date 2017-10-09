/*
fn_obligeOffer.sqf
Kevin Webb
We've decided we like his offer and want to oblige it.
Copyright © 2015 Kevin Webb, All rights reserved
Written for Seal Team Sloth ™ LLC
*/
private["_exit"];
if(lbCurSel 2802 == -1) exitWith {hint localize "STR_Global_NoSelection"};
_id = lbValue[2802,(lbCurSel 2802)];
_dataArr = lbData[2802,(lbCurSel 2802)];
_dataArr = call compile format["%1",_dataArr];
_price = _dataArr select 1;
_buySell = _dataArr select 2;
_className = _dataArr select 3;
_type = _dataArr select 4;
_amount = _dataArr select 5;
_vehicleID = _dataArr select 6;
_exit = false;
if(_buySell == 0) then {
	if(life_myfunds < _price) exitWith {hint "You don't seem to have enough money to meet his/her asking price!"; _exit = true};
	if(_type == "Virtual" && (_price * _amount) > life_myFunds) exitWith {"You don't seem to have enough money to meet his/her asking price!"; _exit = true};
} else {
	//So we are trying to oblige a buy offer. Do we even have the item requested???
	if(_type == "Virtual") then {
		if((call compile _className) == 0) exitWith {hint "You don't have any of this item on your person to sell"; _exit = true};
	};
	if(_type == "Weapon" && primaryWeapon player != _className) exitWith {hint "To sell a weapon to someone, you must be holding it in your hands."; _exit = true};
	if(_type == "Vehicle") exitWith {hint "To oblige someone's vehicle buy offer, You will need to manually make a matching offer from your garage."; _exit = true};
};
if(_exit) exitWith {};
//Now... Let's figure out what the hell we are even trying to do here.
if(_buySell == 0) exitWith {
	if(_type == "Virtual") then {
		["atm","take",_price * _amount] call life_fnc_handlePaper;
	} else {
		["atm","take",_price] call life_fnc_handlePaper;
	};
	[4,_className,_type,_amount,_price,player] remoteExec ["KBW_fnc_listing",2]; //Make it easy and use the existing  buy offer function to get us our product
	closeDialog 0;
};
//Made it thus far, indicating it's a buy offer.
switch(_type) do {
	case "Weapon": {
		[1,[primaryWeapon player,primaryWeaponItems player],_price,player] remoteExec ["KBW_fnc_listing",2];
		player removeWeapon (primaryWeapon player);
	};
	case "Virtual": {
		_var = [_className,1] call life_fnc_varHandle;
		_amount = call compile _className;
		if([false,_var,_amount] call life_fnc_handleInv) then {
			[2,_className,_price,_amount,player] remoteExec ["KBW_fnc_listing",2];
		};
	};
};
closeDialog 0;