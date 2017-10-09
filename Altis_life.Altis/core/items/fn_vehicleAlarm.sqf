/*
fn_vehicleAlarm.sqf
Kevin Webb
Description: Sets the alarm variable and updates the database,
nothing special here.
*/
private["_unit"];
_unit = param [0,ObjNull,[ObjNull]];
if(isNull _unit) exitWith {};
if(!(_unit isKindOf "LandVehicle" OR _unit isKindOf "Ship" OR _unit isKindOf "Air")) exitWith {};
if(player distance _unit > 7) exitWith {hint "You need to be up closer to use this."};
if(_unit getVariable["alarm",false]) exitWith {hint "This vehicle already has a security system installed."};
if(!([false,"alarmV",1] call life_fnc_handleInv)) exitWith {};
closeDialog 0;
life_action_inUse = true;
player playMove "AinvPknlMstpSnonWnonDnon_medic_1";
sleep 4;
life_action_inUse = false;
titleText["You have attached an alarm system to this vehicle.","PLAIN"];
_unit setVariable["alarm",true,true];
_unit remoteExec ["TON_fnc_saveAlarm",2];