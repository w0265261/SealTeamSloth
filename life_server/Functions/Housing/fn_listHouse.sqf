/*
fn_listHouse.sqf
Kevin Webb
Server portion of house listing
*/
_house = param [0,ObjNull,[Objnull]];
_price = param [1,0,[0]];
_pos = getPosATL _house;
_query = format["UPDATE houses SET listPrice='%1' WHERE pos='%2'",_price,_pos];

[_query,1] call DB_fnc_asyncCall;