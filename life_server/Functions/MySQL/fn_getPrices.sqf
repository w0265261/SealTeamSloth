/*
DB_fnc_getPrices
Fetches prices when the server loads, or when an admin wishes for them to be reloaded
*/

_query = format["SELECT classname, life_illegal_items FROM itemprices WHERE life_illegal_items > 0"];
life_illegal_items = [_query,2,true] call DB_fnc_asyncCall;
_query = format["SELECT classname, sell_array FROM itemprices WHERE sell_array > 0"];
sell_array = [_query,2,true] call DB_fnc_asyncCall;
_query = format["SELECT classname, buy_array FROM itemprices WHERE buy_array > 0"];
buy_array = [_query,2,true] call DB_fnc_asyncCall;
_query = format["SELECT classname, life_weapon_shop_array FROM itemprices WHERE life_weapon_shop_array > 0"];
life_weapon_shop_array = [_query,2,true] call DB_fnc_asyncCall;
_query = format["SELECT classname, life_vehicle_buy FROM itemprices WHERE life_vehicle_buy > 0"];
life_vehicle_buy = [_query,2,true] call DB_fnc_asyncCall;


publicVariable "sell_array";
publicVariable "buy_array";
publicVariable "life_weapon_shop_array";
publicVariable "life_vehicle_buy";
[] call TON_fnc_marketConfiguration;