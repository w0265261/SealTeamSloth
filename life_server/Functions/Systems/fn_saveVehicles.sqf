/*
fn_saveVehicles.sqf
Kevin Webb
Saves vehicle positions automatically
*/
{
_vehicle = _x;
_vInfo = _vehicle getVariable["dbInfo",[]];
if(count _vInfo > 0) then
{
	_plate = _vInfo select 1;
	_uid = _vInfo select 0;
	_query = format["UPDATE vehicles SET position='%3',fuel='%4' WHERE pid='%1' AND plate='%2'",_uid,_plate,getPosATL _vehicle,fuel _vehicle];
	[_query,1] call DB_fnc_asyncCall;
};
} forEach vehicles;
/*{
	_query = format["UPDATE itemprices SET sell_array=%1 WHERE className='%2'",_x select 1, _x select 0];
	[_query,1] call DB_fnc_asyncCall;
} forEach life_market_prices;*/
[] spawn {
	sleep 300;
	call TON_fnc_saveVehicles;
};