#include <macro.h>
/*
	File: fn_vehicleShopBuy.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Does something with vehicle purchasing.
*/
private["_spawnPoints","_className","_basePrice","_colorIndex","_spawnPoint","_vehicle"];
if((lbCurSel 2302) == -1) exitWith {hint localize "STR_Shop_Veh_DidntPick"};
_className = lbData[2302,(lbCurSel 2302)];
_vIndex = lbValue[2302,(lbCurSel 2302)];
_vehicleList = [_className,life_vehicle_buy] call fnc_index; _basePrice = if(_vehicleList == -1) then {systemChat "BAD PRICE, report to developer"; 999999} else {(life_vehicle_buy select _vehicleList) select 1};
_colorIndex = lbValue[2304,(lbCurSel 2304)];
if(playerSide == west && _classname in ["C_Heli_Light_01_civil_F","B_Heli_Transport_03_unarmed_F"]) then {_basePrice = _basePrice / 10;};
_basePrice = (_basePrice * __GETC__(life_vip_discount));
/*Series of checks (YAY!)*/
if(_basePrice < 0) exitWith {}; /*Bad price entry*/
if(playerSide == independent) then {_basePrice = _basePrice / 100}; //Medics need hatch sports and littlebirds to function
_taxamt = round(((life_rules select 1) * _basePrice)/200);
if(playerSide == civilian && !(life_veh_shop select 0 in ["reb_car","reb_air"])) then {_basePrice = _basePrice + _taxamt};
if(life_handpaper < _basePrice) exitWith {hint format[localize "STR_Shop_Veh_NotEnough",[_basePrice - life_handpaper] call life_fnc_numberText];};
if(!([_className] call life_fnc_vehShopLicenses) && !undercover) exitWith {hint localize "STR_Shop_Veh_NoLicense"};

_spawnPoints = life_veh_shop select 1;
_spawnPoint = "";

if((life_veh_shop select 0) == "med_air_hs") then {
	if(count(nearestObjects[(getMarkerPos _spawnPoints),["Air"],35]) == 0) exitWith {_spawnPoint = _spawnPoints};
} else {
	/*Check if there is multiple spawn points and find a suitable spawnpoint.*/
	if(typeName _spawnPoints == typeName []) then {
		/*Find an available spawn point.*/
		{if(count(nearestObjects[(getMarkerPos _x),["Car","Ship","Air"],5]) == 0) exitWith {_spawnPoint = _x};} foreach _spawnPoints;
	} else {
		if(count(nearestObjects[(getMarkerPos _spawnPoints),["Car","Ship","Air"],5]) == 0) exitWith {_spawnPoint = _spawnPoints};
	};
};


if(_spawnPoint == "") exitWith {hint localize "STR_Shop_Veh_Block";};
["cash","take",floor _basePrice] call life_fnc_handlePaper;
if(playerSide == civilian && !(life_veh_shop select 0 in ["reb_car","reb_air"])) then {[_taxamt] remoteExecCall ["life_fnc_updateGovBank",2]};
hint format[localize "STR_Shop_Veh_Bought",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_basePrice] call life_fnc_numberText];

/*Spawn the vehicle and prep it.*/
_vehicle = createVehicle [_className, (getMarkerPos _spawnPoint), [], 0, "NONE"];
waitUntil {!isNil "_vehicle"}; /*Wait?*/
_vehicle allowDamage false; /*Temp disable damage handling..*/
_vehicle lock 2;
_vehicle setVectorUp (surfaceNormal (getMarkerPos _spawnPoint));
_vehicle setDir (markerDir _spawnPoint);
_vehicle setPos (getMarkerPos _spawnPoint);
[_vehicle,_colorIndex] remoteExec ["life_fnc_colorVehicle",0];
//_vehicle setVariable["trunk_in_use",false,true];
_vehicle setVariable["vehicle_info_owners",[[getPlayerUID player,profileName]],true];


/*Side Specific actions.*/
switch(playerSide) do {
	case west: {
		[_vehicle,"cop_offroad",true,7] spawn life_fnc_vehicleAnimate;
		_vehicle setVariable["copCar",true,true];
		_vehicle setVariable["unit",0,true];		
	};
	
	case civilian: {
		if((life_veh_shop select 2) == "civ" && {_className == "B_Heli_Light_01_F"}) then {
			[_vehicle,"civ_littlebird",true] spawn life_fnc_vehicleAnimate;
		};
	};
	
	case independent: {
		[_vehicle,"med_offroad",true] spawn life_fnc_vehicleAnimate;
		_vehicle setVariable["medic",true,true];
	};
};
_vehicle allowDamage true;
[_vehicle] call life_fnc_clearAmmo;
[_vehicle] call life_fnc_clearVehicleAmmo;
if(typeOf _vehicle == "I_MRAP_03_F") then { _vehicle disableTIEquipment true; };
life_vehicles pushBack _vehicle; /*Add err to the chain.*/
[(getPlayerUID player),playerSide,_vehicle,_colorIndex] remoteExec ["TON_fnc_vehicleCreate",2];
closeDialog 0; /*Exit the menu.*/

true;