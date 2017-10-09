#include <macro.h>
/*
	File: fn_onTakeItem.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Blocks the unit from taking something they should not have.
*/
private["_unit","_item"];
_unit = param [0,ObjNull,[ObjNull]];
_container = param [1,ObjNull,[ObjNull]];
_item = param [2,"",[""]];
[] call life_fnc_equipGear;

if(isNull _unit OR _item == "") exitWith {};

switch(playerSide) do
{
	case civilian: {
		if(_item in ["V_PlateCarrier2_blk","U_Rangemaster","H_Cap_police","H_CrewHelmetHeli_B","H_Beret_02","H_Beret_blk","V_TacVest_blk_POLICE","V_PlateCarrier1_blk","V_TacVestIR_blk","V_PlateCarrierSpec_rgr"]) then {
			[_item,false,false,false,false] call life_fnc_handleItem;
		};
	};
};