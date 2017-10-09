/*
fn_buyPlayerHouse.sqf
Kevin Webb
Attempt to buy another player's house or car
*/
private["_uid","_seller","_price","_house"];
_house = param [0,ObjNull,[ObjNull]];
_car = param [1,false,[false]];
_price = 0;
_uid = "";
closeDialog 0;
if(_car && _house getVariable["rental",false]) exitWith {hint "It appears this is a rental vehicle"; };
if(_car && (_house getVariable["medic",false] || _house getVariable["copCar",false])) exitWith {hint "The owner of this vehicle is not a civilian."};
if(life_noTroll) exitWith { hint "You have already sent a purchase request recently, try again in a short while."; };
if(_house getVariable["inSale",false]) exitWith { hint "Someone is already attempting to place a contract on this, try again later."; };
if(_house in life_houses || _house in life_vehicles || ((_house getVariable["vehicle_info_owners",[]]) select 0) select 0 == getPlayerUID player) exitWith { hint "This is yours already!"; };
if(_house getVariable["listPrice",-1] > 0) then {_price = _house getVariable "listPrice"} else {
createDialog "STS_KBW_price_diag";
waitUntil{!isNull (findDisplay 13371)};
waitUntil{isNull (findDisplay 13371) || life_charged};
if(!(life_charged)) exitWith {};
life_charged = false;
_price = ctrlText 7331;
if(!([_price] call fnc_isnumber)) exitWith {hint "You didn't enter an actual number."; closeDialog 0;};
_price = parseNumber _price;
};
if(_price < 0) exitWith { hint "Invalid number"; closeDialog 0; };
if(!_car) then {
	_uid = (_house getVariable "house_owner") select 0;
} else {
	_uid = ((_house getVariable "vehicle_info_owners") select 0) select 0;
};
if(life_myFunds < _price) exitWith { hint "It appears you have insufficient funds to complete this purchase."; };
_seller = ObjNull;
{if(getPlayerUID _x == _uid) exitWith { _seller = _x; };} forEach playableUnits;
_out = "";
if(_house getVariable["listPrice",-1] == _price) then {_out = format["It looks like this property is listed for sale. The asking price is %1. Do you wish to buy this house?",[_price] call life_fnc_numberText]} else {
_out = format["This option will send a request to the owner asking them if they want to sell their property. If they confirm, the asset will be yours for %1.",[_price] call life_fnc_numberText];};
if(_house getVariable["stolen",false]) then {_out = _out + " WARNING: it seems this is a stolen vehicle!"; };
_action = [
	_out,
	"House Purchase Request",
	localize "STR_Global_Yes",
	localize "STR_Global_No"
] call BIS_fnc_guiMessage;
if(_action && isNull _seller && _price != (_house getVariable["listPrice",-1])) exitWith { hint "Unfortunately it appears the owner is offline.";};
if(_action) then {
	if(_house getVariable["listPrice",-1] == _price) then {
	if(isNull _seller) then {
		[0,_price,_uid] remoteExec ["TON_fnc_compUID",2];
	} else {
		[_house,_price] remoteExec ["life_fnc_houseSold",_seller];
	};
		[_house,_price,_car] call life_fnc_housePurchased;
		[getPlayerUID player,getPosATL _house,_car,_house] remoteExec ["TON_fnc_housePurchased",2];
		_house setVariable["listPrice",nil,true];
	} else {
	[player,_house,_price,_car] remoteExec ["life_fnc_houseRequest",_seller,false];
	hint "A request has been sent to the owner.";
	_house setVariable["inSale",true,true];
	life_noTroll = true;
	[] spawn { sleep 65; life_noTroll = false; };
	};
};