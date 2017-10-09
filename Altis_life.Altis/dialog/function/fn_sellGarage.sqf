#include <macro.h>
/*
	File: fn_sellGarage.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Sells a vehicle from the garage.
*/
private["_vehicle","_vid","_pid","_unit","_price"];
if(playerSide == independent) exitWith {hint "You can not sell vehicles as a medic"};
disableSerialization;
if(lbCurSel 2802 == -1) exitWith {hint localize "STR_Global_NoSelection"};
_vehicle = lbData[2802,(lbCurSel 2802)];
_vehicle = (call compile format["%1",_vehicle]) select 0;
_vid = lbValue[2802,(lbCurSel 2802)];
_pid = getPlayerUID player;
_unit = player;

if(isNil "_vehicle") exitWith {hint localize "STR_Garage_Selection_Error"};
_price = [_vehicle,life_vehicle_buy] call fnc_index;
if(_price == -1) then {systemChat "BAD PRICE, report to developer"; _price = 1000;} else {_price = ((life_vehicle_buy select _price) select 1) / 10};
if(missionNameSpace getVariable["soldCarVID",0] == _vid && !life_hacker) exitWith {life_hacker = true; [3,-1,"Hack Alert! This user was caught using a script to sell the same car many times"] call life_fnc_newMsg; hint "Nice autoclicker script bro. Get rekt!"};
soldCarVID = _vid;
["cash","add",_price] call life_fnc_handlePaper;
[_vid,_pid,_price,player,life_garage_type] remoteExec ["TON_fnc_vehicleDelete",2];

closeDialog 0;