/*
fn_houseRequest.sqf
Kevin Webb
Someone wants to buy my stuff
*/
private["_uid","_time","_pos","_price","_house"];
_buyer = param [0,ObjNull,[ObjNull]];
_house = param [1,ObjNull,[ObjNull]];
_price = param [2,0,[0]];
_car = param [3,false,[false]];
if(life_houseRequest) exitWith {};
if(_car) then {
hint format["%1 has requested to purchase your %2. Press CTRL+G within 1 minute to transfer ownership and receive %3",name _buyer, getText(configFile >> "CfgVehicles" >> (typeOf _house) >> "displayName"), [_price] call life_fnc_numberText];
} else {
hint format["%1 has requested to purchase your house located at %2. Press CTRL+G within 1 minute to transfer ownership and receive %3",name _buyer, getPosATL _house, [_price] call life_fnc_numberText]; };
_time = time + 60;
life_houseRequest = true;
waitUntil{_time - time <= 0 || life_soldHouse};
if(life_soldHouse) then {
life_soldHouse = false;
if(isNull _buyer) exitWith { hint "It appears the player interested in purchasing your property is now offline."; };
_uid = getPlayerUID _buyer;
life_vehicles = life_vehicles - [_house];
if(!(_car)) then {
life_houses = life_houses - [_house]; };
[_house,_price,_car] remoteExec ["life_fnc_housePurchased",_buyer,false];
[_uid,getPosATL _house,_car,_house] remoteExec ["TON_fnc_housePurchased",2];
hint format["Your asset has been sold and you have received %1",_price];
["atm","add",_price] call life_fnc_handlePaper;
};
life_houseRequest = false;
_house setVariable["inSale",false,true];