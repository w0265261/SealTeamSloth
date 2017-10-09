/*
File: fn_RepaintVehicle.sqf
Author: MooN-Gaming

Description: Does the active repaint man....read the title!
*/
private["_index","_veh","_color","_color_index","_nearVehicles"];
if(!isNull (findDisplay 2300)) then {
_nearVehicles = nearestObjects[getPos player,["Car","Air","Ship"],50];
	if(count _nearVehicles > 0) then
	{
		{
			if(!isNil "_veh") exitWith {}; /*Kill the loop.*/
			_vehData = _x getVariable["vehicle_info_owners",[]];
			if(count _vehData  > 0) then
			{
				_vehOwner = (_vehData select 0) select 0;
				if((getPlayerUID player) == _vehOwner) exitWith
				{
					_veh = _x;
				};
			};
		} foreach _nearVehicles;
	};
if(isNull _veh || isNil "_veh") exitWith {hint "There is no vehicle nearby!";};
if(!(_veh in life_vehicles)) exitWith {hint "It appears this is not your vehicle"; };
_color = lbcursel 2303;
_color_index = lbValue[2303,_color];
closeDialog 0;
if(!(typeOf _veh in["C_Hatchback_01_sport_F","C_Offroad_01_F","C_Hatchback_01_F","C_SUV_01_F","C_Van_01_box_F","C_Van_01_transport_F","B_Quadbike_01_F","O_Heli_Light_02_unarmed_F","C_Heli_Light_01_civil_F","B_Heli_Light_01_F","I_Heli_Transport_02_F"])) exitWith { hint "Coloring this type of vehicle could produce catastrophic results!"; };
_baseprice = 1000;  /*Price for repaint*/
if(life_myfunds < _basePrice) exitWith {hint "You don't have enough funds in your bank to complete this action."};



		life_action_inUse = true;
		_displayName = getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "displayName");
		_upp = format["Painting %1",_displayName];
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
			sleep 0.29;
			_cP = _cP + 0.01;
			_progress progressSetPosition _cP;
			_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];			
			if(_cP >= 1) exitWith {};
			if(player != vehicle player) exitWith {};
		};
		
		life_action_inUse = false;
		life_interrupted = false;
		5 cutText ["","PLAIN"];
		if(!isNull objectParent player) exitWith {titleText["You must remain outside the vehicle while painting is in progress.","PLAIN"];};

		["cash","take",_basePrice] call life_fnc_handlePaper;
		/*Send toDB*/
		[_veh,_color_index] remoteExec ["TON_fnc_vehicleRepaint",2];
		
		/*Color vehicle locally*/
		[_veh,_color_index] remoteExec ["life_fnc_colorVehicle",0];
	

};