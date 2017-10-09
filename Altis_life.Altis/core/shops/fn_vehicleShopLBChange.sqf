#include <macro.h>
/*
	File: fn_vehicleShopLBChange.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Called when a new selection is made in the list box and
	displays various bits of information about the vehicle.
*/
disableSerialization;
private["_control","_index","_className","_basePrice","_vehicleInfo","_colorArray","_ctrl"];
_control = _this select 0;
_index = _this select 1;

/*Fetch some information.*/
_className = _control lbData _index;
_vIndex = _control lbValue _index;
if(undercover) then {
	life_veh_shop set[2,"civ"];
};
_vehicleList = [_className,life_vehicle_buy] call fnc_index; _basePrice = if(_vehicleList == -1) then {systemChat "BAD PRICE, report to developer"; 999999} else {(life_vehicle_buy select _vehicleList) select 1};
_vehicleInfo = [_className] call life_fnc_fetchVehInfo;
_trunkSpace = [_className] call life_fnc_vehicleWeightCfg;
if(playerSide == west && _classname in ["C_Heli_Light_01_civil_F","B_Heli_Transport_03_unarmed_F"]) then {_basePrice = _basePrice / 10;};
if(playerSide == independent) then {_basePrice = _basePrice / 100}; //Medics need hatch sports and littlebirds to function
_basePrice = (_basePrice * __GETC__(life_vip_discount));
if(playerSide == civilian && !(life_veh_shop select 0 in ["reb_car","reb_air"])) then {_basePrice = _basePrice * (1 + ((life_rules select 1) / 100))};
ctrlShow [2330,true];
(getControl(2300,2303)) ctrlSetStructuredText parseText format[
(localize "STR_Shop_Veh_UI_Ownership")+ " <t color='#8cff9b'>$%1</t><br/>" +(localize "STR_Shop_Veh_UI_MaxSpeed")+ " %2 km/h<br/>" +(localize "STR_Shop_Veh_UI_HPower")+ " %3<br/>" +(localize "STR_Shop_Veh_UI_PSeats")+ " %4<br/>" +(localize "STR_Shop_Veh_UI_Trunk")+ " %5<br/>" +(localize "STR_Shop_Veh_UI_Fuel")+ " %6<br/>" +(localize "STR_Shop_Veh_UI_Armor")+ " %7",
[_basePrice] call life_fnc_numberText,
_vehicleInfo select 8,
_vehicleInfo select 11,
_vehicleInfo select 10,
if(_trunkSpace == -1) then {"None"} else {_trunkSpace},
_vehicleInfo select 12,
_vehicleInfo select 9
];

_ctrl = getControl(2300,2304);
lbClear _ctrl;
_colorArray = [_className] call life_fnc_vehicleColorCfg;
for "_i" from 0 to count(_colorArray)-1 do {
	if((_colorArray select _i) select 1 == (life_veh_shop select 2)) then {
		_temp = [_className,_i] call life_fnc_vehicleColorStr;
		_ctrl lbAdd format["%1",_temp];
		_ctrl lbSetValue [(lbSize _ctrl)-1,_i];
	};
};


if(!(life_veh_shop select 3)) then {
	ctrlEnable [2309,true];
};

lbSetCurSel[2304,0];
if((lbSize _ctrl)-1 != -1) then {
	ctrlShow[2304,true];
} else {
	ctrlShow[2304,false];
};
true;