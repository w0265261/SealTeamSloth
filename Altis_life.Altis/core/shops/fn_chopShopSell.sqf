/*
	File: fn_chopShopSell.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Sells the selected vehicle off.
*/
disableSerialization;
private["_control","_price","_vehicle","_nearVehicles","_price2","_check"];
_control = ((findDisplay 39400) displayCtrl 39402);
_price = _control lbValue (lbCurSel _control);
_vehicle = _control lbData (lbCurSel _control);
_vehicle = call compile format["%1", _vehicle];
_nearVehicles = nearestObjects [getMarkerPos life_chopShop,["Car","Truck","C_supplyCrate_F"],25];
_vehicle = _nearVehicles select _vehicle;
if(isNull _vehicle) exitWith {};
if(_vehicle getVariable["medic",false]) exitWith {hint "This is a medical vehicle, how low of you to steal that!"};
_check = false; 
{if(player distance _x < 200 && side _x == west) then { _check = true; };} forEach playableUnits; 
if(_check) exitWith {hint "The cops are too close to complete this action!";};
hint localize "STR_Shop_ChopShopSelling";
life_action_inUse = true;
[getPlayerUID player,profileName,"490",[(_vehicle getVariable "vehicle_info_owners" select 0) select 1,getPos player,getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")]] remoteExec ["life_fnc_wantedAdd",2];
disableSerialization;
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
if(_vehicle getVariable["copCar",false]) then {hint "Congratulations on successfully stealing a police vehicle; you have extracted the police computer and now have the ability to view the wanted list."; life_wantedlist = true; };
[player,_vehicle,_price] remoteExec ["TON_fnc_chopShopSell",2];
closeDialog 0;