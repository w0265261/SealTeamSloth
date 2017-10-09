#include <macro.h>
/*
	File: fn_vehicleExchange.sqf
	Author: Kevin Webb
	
	Description:
	Sends our vehicle to the exchange table for listing
	Copyright © 2015 Kevin Webb, All rights reserved
	Written for Seal Team Sloth ™ LLC
*/
if(life_offers > 9) exitWith {hint "You may only have up to 10 sell offers at a time."};
private["_vid","_price"];
disableSerialization;
if(lbCurSel 2802 == -1) exitWith {hint localize "STR_Global_NoSelection"};
_vid = lbValue[2802,(lbCurSel 2802)];
_vehicle = lbData[2802,(lbCurSel 2802)];
_vehicle = (call compile format["%1",_vehicle]);
_stolen = _vehicle select 5;
if(_stolen) exitWith {hint "What do you think you're doing trying to list a stolen vehicle? Pawn that shit elsewhere!"};
_vehicle = _vehicle select 0;
if(isNil "_vehicle") exitWith {hint localize "STR_Garage_Selection_Error"};
closeDialog 0;
createDialog "STS_KBW_price_diag";
waitUntil{!isNull (findDisplay 13371)};
waitUntil{isNull (findDisplay 13371) || life_charged};
if(!(life_charged)) exitWith {};
life_charged = false;
_price = ctrlText 7331;
if(!([_price] call fnc_isnumber)) exitWith {hint "You didn't enter an actual number."; closeDialog 0;};
_price = parseNumber _price;
if(_price < 0) exitWith {hint "Invalid Number"; closeDialog 0;};
if(_price > 999999) exitWith {hint "That price isn't appropriate for the exchange"; closeDialog 0;};
[0,_vid,_price,_vehicle,player] remoteExec ["KBW_fnc_listing",2];
hint "Your vehicle has been taken from your garage and listed on the exchange.";
closeDialog 0;