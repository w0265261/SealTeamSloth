#include <macro.h>
/*
        Author: Bryan "Tonic" Boardwine
       
        Description:
        For the mean time it blocks the player from opening another persons backpack
*/
private["_container","_unit"];
if(count _this == 1) exitWith {false};
_result = false;
_unit = _this select 0;
_container = _this select 1;
 if(_container getVariable["Cash",0] > 0) exitWith {
	hint format["You found $%1 within the crate!",_container getVariable "Cash"];
	["cash","add",_container getVariable "Cash"] call life_fnc_handlePaper;
	_container setVariable["Cash",0,true];
};
if((typeOf _container) == "O_supplyCrate_F") then {
	if(_container getVariable["owner",""] != getPlayerUID player || playerSide != west) then {
		_result = true;
	};
};
//if(playerSide == west || (__GETC__(style) > 0)) exitWith {};
_isPack = getNumber(configFile >> "CfgVehicles" >> (typeOf _container) >> "isBackpack");
if(_isPack == 1 && !(cursorTarget getVariable["zipTie",false]) && playerSide != west && call style < 1) then {
        hint localize "STR_MISC_Backpack";
        _result = true;
};

if(player getVariable["restrained",false] || player getVariable["zipTie",false]) then {
	hint "You wish you could reach for that which might set you free, but you forgot your hands are bound!";
	_result = true;
};

if((typeOf _container) in ["Land_PlasticCase_01_large_F","CargoNet_01_box_F"] && playerSide != west) then {
        _house = nearestBuilding (getPosATL player);
        if(!(_house in life_vehicles) && {(_house getVariable ["locked",false])}) then {
                hint localize "STR_House_ContainerDeny";
                _result = true;
        };
};
 
if((_container isKindOf "LandVehicle" OR _container isKindOf "Ship" OR _container isKindOf "Air") && playerSide != west) then {
        if(!(_container in life_vehicles) && ((locked _container) == 2)) then {
                hint localize "STR_MISC_VehInventory";
                _result = true;
        };
};
if(life_paintBalling || life_dueling) then {
	_result = true;
};
/*Stop dead body looting*/
if(_container isKindOf "Man" && !alive _container && !life_exec) then {
	hint localize "STR_NOTF_NoLootingPerson";
	_result = true;
};
_result;