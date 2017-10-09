/*
	File: fn_impoundAction.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Impounds the vehicle
*/
private["_vehicle","_type","_time","_price","_vehicleData","_upp","_ui","_progress","_pgText","_cP","_veh"];
_vehicle = cursorTarget;
_veh = typeOf _vehicle;
if(!(_vehicle isKindOf "Car" || _vehicle isKindOf "Air" || _vehicle isKindOf "Ship" || typeOf _vehicle in["Land_Pod_Heli_Transport_04_covered_F","Land_Pod_Heli_Transport_04_bench_F"])) exitWith {};
if(player distance cursorTarget > 10) exitWith {};
if(!alive _vehicle) exitWith {};
if((_veh in["I_G_Offroad_01_armed_F","O_MRAP_02_F","I_MRAP_03_F"] || _vehicle getVariable["stolen",false]) && playerSide != independent) exitWith { [] spawn life_fnc_copCrush; hint "Due to the crimes in which this vehicle has been involved in, it is being crushed instead.";};

	_vehicleData = _vehicle getVariable["vehicle_info_owners",[]];

	_vehicleName = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
	if(playerSide == west) then{
	[0,format[localize "STR_NOTF_BeingImpounded",(_vehicleData select 0) select 1,_vehicleName]] remoteExec ["life_fnc_broadcast",0];
	};
	
	_upp = localize "STR_NOTF_Impounding";
	/*Setup our progress bar.*/
	disableSerialization;
	5 cutRsc ["life_progress","PLAIN"];
	_ui = uiNameSpace getVariable "life_progress";
	_progress = _ui displayCtrl 38201;
	_pgText = _ui displayCtrl 38202;
	_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
	_progress progressSetPosition 0.01;
	_cP = 0.01;
	while{true} do
	{
		sleep 0.09;
		_cP = _cP + 0.01;
		_progress progressSetPosition _cP;
		_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
		if(_cP >= 1) exitWith {};
		if(player distance _vehicle > 10) exitWith {};
		if(!alive player) exitWith {};
	};
	5 cutText ["","PLAIN"];
	
	if(player distance _vehicle > 10) exitWith {hint localize "STR_NOTF_ImpoundingCancelled"; life_action_inUse = false;};
	if(!alive player) exitWith {life_action_inUse = false;};

	if((count crew _vehicle) == 0) then
	{
		if(!((_vehicle isKindOf "Car") || (_vehicle isKindOf "Air") || (_vehicle isKindOf "Ship"))) exitWith {life_action_inUse = false;};
		_type = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
		switch (true) do
		{
			case (_vehicle isKindOf "Car"): {_price = 75};
			case (_vehicle isKindOf "Ship"): {_price = 50};
			case (_vehicle isKindOf "Air"): {_price = 100};
		};
		if(playerSide == independent) then {_price = _price * 2};
		life_impound_inuse = true;
		[_vehicle,true,player] remoteExec ["TON_fnc_vehicleStore",2];
		waitUntil {!life_impound_inuse};
		hint format[localize "STR_NOTF_Impounded",_type,_price];
		[0,format[localize "STR_NOTF_HasImpounded",profileName,(_vehicleData select 0) select 1,_vehicleName]] remoteExec ["life_fnc_broadcast",0];
		["atm","add",_price] call life_fnc_handlePaper;
	}
		else
	{
		hint localize "STR_NOTF_ImpoundingCancelled";
	};
life_action_inUse = false;