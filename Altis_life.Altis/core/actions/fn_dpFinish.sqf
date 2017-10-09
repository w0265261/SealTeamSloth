/*
	File: fn_dpFinish.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Finishes the DP Mission and calculates the money earned based
	on distance between A->B
*/
private["_dp","_dis","_price","_exit"];
_dp = param [0,ObjNull,[ObjNull]];
_exit = false;
_dis = round((getPos life_dp_start) distance (getPos _dp));
_price = round(_dis * 0.2);
if(!isNull life_DPBox) then {
	if(_dp distance life_DPBox > 10) exitWith {_exit = true; hint "Your package isn't close enough to be delivered; if the package was lost you will need to reset your delivery mission."; life_oopsFailed = true;};
	if(life_DPBox getVariable["loaded",false]) exitWith {_exit = true; hint "Please unload your package from your vehicle first"; life_oopsFailed = true;};
	deleteVehicle life_DPBox;
	_price = _price * 2;
};
if(playerSide == independent) then {_price = round(_price * 1)};
if(_exit) exitWith {};
life_delivery_in_progress = false;
life_dp_point = nil;
["DeliverySucceeded",[format[(localize "STR_NOTF_Earned_1"),[_price] call life_fnc_numberText]]] call bis_fnc_showNotification;
life_cur_task setTaskState "Succeeded";
player removeSimpleTask life_cur_task;
["cash","add",_price] call life_fnc_handlePaper;
if(!(license_civ_delivery)) then {
license_civ_delivery = true;
[2] call SOCK_fnc_updatePartial;
};