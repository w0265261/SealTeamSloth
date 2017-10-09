#include <macro.h>
/*
	File: fn_repairTruck.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Main functionality for toolkits, to be revised in later version.
*/
private["_veh","_upp","_ui","_progress","_pgText","_cP","_displayName","_bool","_check","_cargo","_itemCount","_arrayItem","_arrayItemCount"];
_veh = cursorTarget;
_bool = true;
_check = false;
_isVirtual = false;
life_interrupted = false;
if(isNull _veh) exitwith {};
_cargo = getItemCargo _veh;
_itemCount = count (_cargo select 0);
if(!([false,"hightoolkit",1] call life_fnc_handleInv)) then {
	for "_i" from 0 to (_itemCount - 1) do
	{
		_arrayItem = (_cargo select 0) select _i;
		if(_arrayItem == "ToolKit") exitWith {
			_check = true;
        };
	};
} else {_isVirtual = true};
//if(!_isVirtual && !(_veh in life_vehicles) && (damage _veh < 0.4)) exitWith {hint "This is not your vehicle to mess with."};
if("ToolKit" in (items player) || _check || _isVirtual || playerSide == independent) then
{
	life_action_inUse = true;
	_displayName = getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "displayName");
	_upp = format[localize "STR_NOTF_Repairing",_displayName];
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
		if(animationState player != "Acts_carFixingWheel") then {
			player playMoveNow "Acts_carFixingWheel";
		};
		sleep 0.2;
		_cP = _cP + 0.01;
		_progress progressSetPosition _cP;
		_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
		if(_cP >= 1) exitWith {life_action_inUse = false;};
		if(!alive player) exitWith {life_action_inUse = false;};
		if(player != vehicle player) exitWith {life_action_inUse = false;};
		if(life_interrupted) exitWith {life_action_inUse = false;};
	};
	
	life_action_inUse = false;
	5 cutText ["","PLAIN"];
	player playActionNow "stop";
	if(life_interrupted) exitWith {life_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN"]; life_action_inUse = false;};
	if(player != vehicle player) exitWith {titleText[localize "STR_NOTF_RepairingInVehicle","PLAIN"];};
	
	if(_isVirtual || playerSide == independent) then {_veh setDamage 0} 
	else {
		if(local _veh) then {
			_array = getAllHitPointsDamage _veh; 
			{
				if(_veh getHitPointDamage _x > 0.4) then {
					_veh setHitPointDamage[_x,0.4];
				};
			} forEach (_array select 0);
		} else {
			[true,_veh] remoteExecCall ["life_fnc_setFuel",_veh];
		};
	};
	titleText[localize "STR_NOTF_RepairedVehicle","PLAIN"];
	if(playerSide == independent && !(_veh in life_vehicles) && (time - life_last_repair >120)) then { ["atm","add",100] call life_fnc_handlePaper; hint "You have received $100 for repairing a citizen's vehicle"; life_last_repair = time; };
}
else
{
hint "You don't have a toolkit in your inventory or in your vehicle.";
};