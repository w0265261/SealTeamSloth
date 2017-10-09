#include <macro.h>
/*
	File: fn_garageLBChange.sqf
	Author: Bryan "Tonic" Boardwine

*/
disableSerialization;
private["_control","_index","_dataArr","_vehicleColor","_vehicleInfo","_trunkSpace","_sellPrice","_retrievePrice"];
_control = _this select 0;
_index = _this select 1;

/*Fetch some information.*/
_dataArr = _control lbData _index; _dataArr = call compile format["%1",_dataArr];
_classname = _dataArr select 0;
_vehicleColor = [_classname,_dataArr select 1] call life_fnc_vehicleColorStr;
_insured = _dataArr select 2;
_tracked = _dataArr select 3;
_alarm = _dataArr select 4;
_stolen = _dataArr select 5;
if(_insured) then {_tracked = true; _alarm = true};
_vehicleInfo = [_classname] call life_fnc_fetchVehInfo;
_trunkSpace = [_classname] call life_fnc_vehicleWeightCfg;


_find = [_classname,life_vehicle_buy] call fnc_index;
_retrievePrice = if(_find == -1) then {systemChat "BAD PRICE, report to developer"; 1000} else {(((life_vehicle_buy select _find) select 1) / 30)};
if(playerSide == independent) then { _retrievePrice = _retrievePrice / 8; };
_retrievePrice = (_retrievePrice * __GETC__(life_vip_discount));

_sellPrice = if(_find == -1) then {systemChat "BAD PRICE, report to developer"; 1000} else {(((life_vehicle_buy select _find) select 1) / 10)};
if(playerSide == west && _classname in ["C_Heli_Light_01_civil_F","B_Heli_Transport_03_unarmed_F"]) then {_retrievePrice = _retrievePrice / 10; _sellPrice = _sellPrice / 10};
(getControl(2800,2803)) ctrlSetStructuredText parseText format[
	(localize "STR_Shop_Veh_UI_RetrievalP")+ " <t color='#8cff9b'>$%1</t><br/>
	" +(localize "STR_Shop_Veh_UI_SellP")+ " <t color='#8cff9b'>$%2</t><br/>
	" +(localize "STR_Shop_Veh_UI_Color")+ " %8<br/>
	" +(localize "STR_Shop_Veh_UI_MaxSpeed")+ " %3 km/h<br/>
	" +(localize "STR_Shop_Veh_UI_HPower")+ " %4<br/>
	" +(localize "STR_Shop_Veh_UI_PSeats")+ " %5<br/>
	" +(localize "STR_Shop_Veh_UI_Trunk")+ " %6<br/>
	" +(localize "STR_Shop_Veh_UI_Fuel")+ " %7<br/>
	" +"Insured: %9<br/>
	" +"GPS: %10<br/>
	" +"Alarm: %11<br/>
	" +"Stolen: %12
	",
[_retrievePrice] call life_fnc_numberText,
[_sellPrice] call life_fnc_numberText,
_vehicleInfo select 8,
_vehicleInfo select 11,
_vehicleInfo select 10,
if(_trunkSpace == -1) then {"None"} else {_trunkSpace},
_vehicleInfo select 12,
_vehicleColor,
_insured,
_tracked,
_alarm,
_stolen
];

ctrlShow [2803,true];
ctrlShow [2830,true];