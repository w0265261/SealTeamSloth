#include <macro.h>
/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Sells the house?
*/
private["_house","_uid","_uids","_action","_houseCfg"];
_house = param [0,ObjNull,[ObjNull]];
_leasers = _house getVariable "leasers";
if(_house getVariable["sold",false]) exitWith {hint "It appears you are abusing a bug! BAN!"};
if(isNull _house) exitWith {};
if(!(_house isKindOf "House_F")) exitWith {};
closeDialog 0;

_houseCfg = [(typeOf _house)] call life_fnc_houseConfig;
if(count _houseCfg == 0) exitWith {};

_action = [
	format[localize "STR_House_SellHouseMSG",
	(round((_houseCfg select 0)/2)) call life_fnc_numberText,
	(_houseCfg select 1)],localize "STR_pInAct_SellHouse",localize "STR_Global_Sell",localize "STR_Global_Cancel"
] call BIS_fnc_guiMessage;

if(_action) then {
	
	_uids = [];
	{ _uids pushBack (_x select 0); } forEach _leasers;
	
	{
		_uid = getPlayerUID _x;
		if(_uid in _uids) then {
			[_house] remoteExec ["life_fnc_houseKeyDrop",_x,false];
		};
	} forEach playableUnits;
	
	_house setVariable["house_sold",true,true];
	[_house] remoteExec ["TON_fnc_sellHouse",2];
	_house setVariable["locked",false,true];
	_house setVariable["Trunk",nil,true];
	_house setVariable["house_owner",["",""],true];
	_house setVariable["containers",nil,true];
	_house setVariable["security",nil,true];
	_house setVariable["leasers",nil,true];
	_house setVariable["sold",true,true];
	deleteMarkerLocal format["house_%1",_house getVariable "uid"];
	_house setVariable["uid",nil,true];
	
	["atm","add",(round((_houseCfg select 0)/2))] call life_fnc_handlePaper;
	_index = life_vehicles find _house;
	if(_index != -1) then {
		life_vehicles set[_index,-1];
		life_vehicles = life_vehicles - [-1];
	};

		life_houses = life_houses - [str(getPosATL _house)];

	_numOfDoors = getNumber(configFile >> "CfgVehicles" >> (typeOf _house) >> "numberOfDoors");
	for "_i" from 1 to _numOfDoors do {
		_house setVariable[format["bis_disabled_Door_%1",_i],0,true];
	};
	_house setVariable["listPrice",nil,true];
};
