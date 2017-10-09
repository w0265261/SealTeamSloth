/*
	File: fn_openInventory.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the initialization of vehicle virtual inventory menu.
*/
private["_vehicle","_veh_data","_msg"];
if(dialog) exitWith {};
_vehicle = param [0,Objnull,[Objnull]];
if(_vehicle getVariable["trunkUsers",""] != "") exitWith {hint localize "STR_MISC_VehInvUse"};
//if((_vehicle getVariable ["trunk_in_use",false])) exitWith {hint localize "STR_MISC_VehInvUse"};
_uid = getPlayerUID player;
_vehicle setVariable["trunkUsers",_uid,true];
//_vehicle setVariable["trunkUsersName",profileName,true];
//_vehicle setVariable["trunk_in_use",true,true];
if(!createDialog "STS_TrunkMenu") exitWith {hint localize "STR_MISC_DialogError";}; /*Couldn't create the menu?*/
disableSerialization;

if(_vehicle isKindOf "House_F") then {
	ctrlSetText[3501,format[(localize "STR_MISC_HouseStorage")+ " - %1",getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")]];
} else {
	ctrlSetText[3501,format[(localize "STR_MISC_VehStorage")+ " - %1",getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")]];
	_vehicle spawn {waitUntil{!dialog}; [_this] remoteExec ["DB_fnc_saveVehPlayer",2];};
};

if(_vehicle isKindOf "House_F") then {
	private["_mWeight"];
	_mWeight = 500;
	//{_mWeight = _mWeight + ([(typeOf _x)] call life_fnc_vehicleWeightCfg);} foreach (_vehicle getVariable["containers",[]]);
	_veh_data = [_mWeight,(_vehicle getVariable["Trunk",[[],0]]) select 1];
} else {
	_veh_data = [_vehicle] call life_fnc_vehicleWeight;
};

//if((_vehicle isKindOf "House_F") && {count (_vehicle getVariable ["containers",[]]) == 0}) exitWith {hint localize "STR_MISC_NoStorageWarn"; closeDialog 0; _vehicle setVariable["trunk_in_use",false,true];};
if(_veh_data select 0 == -1 && {(!(_vehicle isKindOf "House_F"))}) exitWith {closeDialog 0; hint localize "STR_MISC_NoStorageVeh";};

ctrlSetText[3504,format[(localize "STR_MISC_Weight")+ " %1/%2",_veh_data select 1,_veh_data select 0]];
[_vehicle] call life_fnc_vehInventory;
life_trunk_vehicle = _vehicle;
/*_vehicle spawn
{
	_uid = getPlayerUID player;
	sleep 0.25;
	if(_this getVariable "trunkUsers" != _uid && !isNil (_this getVariable "trunkUsers")) then {
		_msg = format["Hack Alert: %1 and %2 appear to be using a vehicle trunk at the same time to duplicate items!",_this getVariable "trunkUsersName",profileName];
		[3,-1,_msg] call life_fnc_newMsg;
		hintSilent "";
	};
};*/
_vehicle spawn
{
	waitUntil {isNull (findDisplay 3500)};
	_this setVariable["trunkUsers",nil,true];
	//_this setVariable["trunk_in_use",false,true];
	if(_this isKindOf "House_F") then {
		[_this] remoteExec ["TON_fnc_updateHouseTrunk",2];
	};
	[] call life_fnc_saveThat;
};