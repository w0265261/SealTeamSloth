/*
	File: fn_cleanup.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Server-side cleanup script on vehicles.
*/
private["_deleted"];
_deleted = false;
while {true} do
{
	private["_veh","_units"];
	uiSleep (25 * 60);
	{
		_veh = _x;
		_vehicleClass = getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "vehicleClass");
		
		if(_vehicleClass in ["Car","Air","Ship"]) then
		{
			_dbInfo = _veh getVariable["dbInfo",[]];
			_virtItems = [];
			_inventory = getItemCargo _veh;
			_fuel = fuel _veh;
			_units = {(_x distance _veh < 500)} count playableUnits;
			if(count crew _x == 0 && _units == 0 && !(typeOf _x in ["B_UAV_01_F","B_UAV_02_F"])) then
			{
				deleteVehicle _x; 
				_deleted = true;
			};
			
			if(_deleted) then {
				waitUntil {isNull _veh};
				_deleted = false;
			};
			
			if(isNull _veh) then
			{
				if(count _dbInfo > 0) then
				{
					_uid = _dbInfo select 0;
					_plate = _dbInfo select 1;

					_query = format["UPDATE vehicles SET active='0', inventory='%3', virtItems='%4', fuel='%5' WHERE pid='%1' AND plate='%2'",_uid,_plate,_inventory,_virtItems,_fuel];
					
					[_query,1] call DB_fnc_asyncCall;
				};
			};
		};
	} foreach vehicles;
	
	uiSleep (3 * 60);
	{
		if((typeOf _x) in ["Land_BottlePlastic_V1_F","Land_TacticalBacon_F","Land_Can_V3_F","Land_CanisterFuel_F", "Land_Can_V3_F","Land_Money_F","Land_Suitcase_F"]) then
		{
			deleteVehicle _x;
		};
	} foreach (allMissionObjects "Thing");
	
	uiSleep (2 * 60);
	{
		deleteVehicle _x;
	} foreach (allMissionObjects "GroundWeaponHolder");
};