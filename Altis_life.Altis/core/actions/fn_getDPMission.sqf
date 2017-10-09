/*
	File: fn_getDPMission.sqf
	Author: Bryan "Tonic" Boardwine
	Edited by: Kayler "K-Town" Renslow (Added a waypoint to the current DP location)
	Edited by: Kevin Webb (Added support for DP Box)
	Description:
	Selects a random DP point for a delivery mission.
	Needs to be revised.
*/
_target = param [0,ObjNull,[ObjNull]];
_target spawn {
_target = _this;
_dp = "";
if(str(_target) in life_dp_points) then
{
	_point = life_dp_points - [(str(_target))];
	_dp = _point call BIS_fnc_selectRandom;
}
	else
{
	_dp = life_dp_points call BIS_fnc_selectRandom;
};

life_dp_start = _target;
_exit = false;
if(!isNull life_DPBox) then {deleteVehicle life_DPBox};

_action = [
	format["Would you like to deliver a package which must be loaded into a vehicle, or a simple letter? Delivering the package will result in a higher payout."],
	"Delivery type",
	"Package",
	"Letter"
] call BIS_fnc_guiMessage;
 if(_action) then {
	_marker = str _target;
	_pos = markerPos _marker;
	_nearVehicles = nearestObjects [_pos,["Car","Air","C_supplyCrate_F"],3];
	if(count _nearVehicles > 0) exitWith {
		hint "It seems there is something blocking the spawn point. Clear the area and try again."; 
		_exit = true;
		if(typeOf (_nearVehicles select 0) == "C_supplyCrate_F") then {deleteVehicle (_nearVehicles select 0)};
	};
	life_DPBox = "C_supplyCrate_F" createVehicle _pos;
	clearWeaponCargoGlobal life_DPBox;
	clearMagazineCargoGlobal life_DPBox;
	clearItemCargoGlobal life_DPBox;
	clearBackPackCargoGlobal life_DPBox;
	life_DPBox enableRopeAttach false;
	_d1 = player distance chop_1;
	_d2 = player distance chop_2;
	_d3 = player distance chop_3;
	_value = switch(true) do {
		case (_d3 < _d2 && _d3 < _d1): {_d3};
		case (_d2 < _d3 && _d2 < _d1): {_d2};
		case (_d1 < _d2 && _d1 < _d3): {_d1};
	};
	life_DPBox setVariable["value",(_value * 0.3),true];
};
if(_exit) exitWith {};

life_delivery_in_progress = true;
life_dp_point = call compile format["%1",_dp];

life_cur_task = player createSimpleTask [format["Delivery_%1",life_dp_point]];
life_cur_task setTaskState "Assigned";
life_cur_task setSimpleTaskTarget [nearestObject[getMarkerPos _dp, "man"], true];

_dp = [_dp,"_"," "] call KRON_Replace;
life_cur_task setSimpleTaskDescription [format[localize "STR_NOTF_DPStart",toUpper _dp],"Delivery Job","Deliver Package"];

player setCurrentTask life_cur_task;

["DeliveryAssigned",[format[localize "STR_NOTF_DPTask",toUpper _dp]]] call bis_fnc_showNotification;

if(!isNull life_DPBox) then {
	[] spawn {
		waitUntil {uiSleep 1; (life_delivery_in_progress && isNull life_DPBox) || !life_delivery_in_progress || damage life_DPBox >= 1};
		if((life_delivery_in_progress && isNull life_DPBox) || damage life_DPBox >= 1) then
		{
			if(!isNull life_DPBox) then {deleteVehicle life_DPBox};
			life_cur_task setTaskState "Failed";
			player removeSimpleTask life_cur_task;
			["DeliveryFailed",["Delivery objective was destroyed!"]] call BIS_fnc_showNotification;
			life_delivery_in_progress = false;
			life_dp_point = nil;
		};
	};
	player reveal life_DPBox;
};
[] spawn
{
	waitUntil {uiSleep 1; !life_delivery_in_progress OR !alive player};
	if(!alive player) then
	{
		life_cur_task setTaskState "Failed";
		player removeSimpleTask life_cur_task;
		["DeliveryFailed",[localize "STR_NOTF_DPFailed"]] call BIS_fnc_showNotification;
		life_delivery_in_progress = false;
		life_dp_point = nil;
	};
};
};