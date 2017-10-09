/*
fn_listItem.sqf
Kevin Webb
Allows for the listing of the things we refer to as virtual items...
Copyright © 2015 Kevin Webb, All rights reserved
Written for Seal Team Sloth ™ LLC
*/
if(life_offers > 9) exitWith {hint "You may only have up to 10 sell offers at a time."};
_available = [];
_accepted =
[
	"life_inv_oilu",
	"life_inv_oilp",
	"life_inv_copperore",
	"life_inv_ironore",
	"life_inv_ironr",
	"life_inv_copperr",
	"life_inv_sand",
	"life_inv_glass",
	"life_inv_rock",
	"life_inv_cement",
	"life_inv_goldore",
	"life_inv_goldr",
	"life_inv_coalore",
	"life_inv_steel",
	"life_inv_log",
	"life_inv_lumber",
	"life_inv_detector",
	"life_inv_ammoBoxS",
	"life_inv_ammoBox",
	"life_inv_blindfold",
	"life_inv_lockpick",
	"life_inv_spikeStrip",
	"life_inv_blastingcharge",
	"life_inv_boltcutter",
	"life_inv_zip",
	"life_inv_chainsaw",
	"life_inv_lethal",
	"life_inv_vammo"
];

{
	_amount = call compile _x;
	if(_amount > 0) then {_available pushBack _x};
} forEach _accepted;
if(count _available == 0) exitWith {hint "You don't seem to have any of the resources which can be listed on the market."};
_toSell = "";
if(count _available > 1) then {
	{
		//Yes, I do have an obsession with BIS_fnc_guiMessage, deal with it...
		_action = [
		format["It seems you have more than one type of resource which can be sold. Do you wish to sell your %1?",[_x] call life_fnc_varToStr],
		"Selling Resources",
		localize "STR_Global_Yes",
		localize "STR_Global_No"
		] call BIS_fnc_guiMessage;
		if(_action) exitWith {_toSell = _x};
	} forEach _available; //I'm also obsessed with forEach loops. Fuck you, "for loop" lovers.
} else {
	_toSell = _available select 0;
};
if(_toSell == "") exitWith {hint "It seems you didn't select one of your resources!"};
hint "Please enter the amount you would like to receive PER UNIT of the resource that you are carrying";
createDialog "STS_KBW_price_diag";
waitUntil{!isNull (findDisplay 13371)};
waitUntil{isNull (findDisplay 13371) || life_charged};
if(!(life_charged)) exitWith {};
life_charged = false;
_price = ctrlText 7331;
if(!([_price] call fnc_isnumber)) exitWith {hint "You didn't enter an actual number."; closeDialog 0;};
_price = parseNumber _price;
if(_price < 0) exitWith {hint "Invalid Number"; closeDialog 0;};
if(_price > 2000) exitWith {hint "That price isn't appropriate for the exchange"; closeDialog 0;};
_var = [_toSell,1] call life_fnc_varHandle;
_amount = call compile _toSell;
_fee = round(_amount * (_price * 0.05));
if(life_myFunds < _fee) exitWith {hint "It seems you do not have enough funds to cover the 5% listing fee."};
if([false,_var,_amount] call life_fnc_handleInv) then {
	["atm","take",_fee] call life_fnc_handlePaper;
	[2,_toSell,_price,_amount,player] remoteExec ["KBW_fnc_listing",2];
	hint format["Your resources have been inserted into the exchange; you have been assessed a listing fee of $%1 which will be refunded if your items sell successfully within 1 week",_fee];
};
closeDialog 0;