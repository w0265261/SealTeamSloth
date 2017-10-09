/*
File: fn_stealVehicle.sqf
Author: Kevin Webb
Description: Allows the player to put a stolen vehicle in his garage.
*/
disableSerialization;
private["_control","_price","_vehicle","_nearVehicles","_color","_check"];
_control = ((findDisplay 39400) displayCtrl 39402);
_price = _control lbValue (lbCurSel _control);
_price = _price*0.5;
if(life_myfunds < _price) exitWith {hint format["We require a fee of %1 to make that vehicle yours",_price]; };
_vehicle = _control lbData (lbCurSel _control);
_vehicle = call compile format["%1", _vehicle];
_nearVehicles = nearestObjects [getMarkerPos life_chopShop,["Car","Truck","C_supplyCrate_F"],25];
_vehicle = _nearVehicles select _vehicle;
if(isNull _vehicle || isNil "_vehicle") exitWith {};
if(typeOf _vehicle == "C_supplyCrate_F") exitWith {hint "This is not something you can put in your garage."};
if(_vehicle getVariable["medic",false]) exitWith {hint "This is a medical vehicle, how low of you to steal that!"};
_check = false; 
{if(player distance _x < 200 && side _x == west) then { _check = true; };} forEach playableUnits; 
if(_check) exitWith {hint "The cops are too close to complete this action!";};
if(typeOf _vehicle == "B_MRAP_01_F") exitWith {hint "Unfortunately, you can not make that type of vehicle yours! You will have to sell it instead."; };
_color = 0;
if(typeOf _vehicle in["C_Offroad_01_F"]) then { _color = floor(random 12); };
while {typeOf _vehicle in["C_Offroad_01_F"] && _color in [6,7,8]} do {_color = floor(random 12); };
if(typeOf _vehicle in["C_Hatchback_01_F"]) then { _color = floor(random 7); };
if(typeOf _vehicle in["C_Hatchback_01_sport_F"]) then { _color = floor(random 6); };
if(typeOf _vehicle in["C_SUV_01_F"]) then { _color = floor(random 8); };
while {typeOf _vehicle in["C_SUV_01_F"] && _color in[1,4,5]} do { _color = floor(random 8); };
if(typeOf _vehicle in["B_Quadbike_01_F"]) then { _color = floor(random 9); };
life_action_inUse = true;
disableSerialization;
[getPlayerUID player,profileName,"490",[(_vehicle getVariable "vehicle_info_owners" select 0) select 1,getPos player,getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")]] remoteExec ["life_fnc_wantedAdd",2];
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText "Chop Shop Operating...";
_progress progressSetPosition 0.01;
_cP = 0.01;
_pos = getPos _vehicle;
while{true} do {
	sleep 0.5;
	_cP = _cP + (1/120);
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["Chop Shop Operating (%1%2)",round(_cP * 100),"%"];
	if(_cP >= 1) exitWith {};
	if(player distance _pos > 75) exitWith {};
	if(_vehicle distance _pos > 3) exitWith {};
	if(player getVariable["unconscious",false] || life_istazed || life_isdowned || player getVariable["restrained",false] || player getVariable["zipTie",false]) exitWith {};
};
5 cutText ["","PLAIN"];
if(_cp < 1) exitWith {hint "The chopping process has failed!"; life_action_inUse = false};
life_action_inUse = false;
hint format["You have been charged %1 for this transaction and the vehicle has been added to your garage.",_price];
if(_vehicle getVariable["copCar",false]) then {systemChat "Congratulations on successfully stealing a police vehicle; you have extracted the police computer and now have the ability to view the wanted list."; life_wantedlist = true; };
["atm","take",_price] call life_fnc_handlePaper;
[(getPlayerUID player),playerSide,_vehicle,_color,1] remoteExec ["TON_fnc_vehicleCreate",2];
closeDialog 0;