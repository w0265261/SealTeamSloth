/*
	File: fn_gather.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Main functionality for gathering.
*/
if(isNil "life_action_gathering") then {life_action_gathering = false;};
_rabbit = (nearestObjects[getPos player,["Rabbit_F"],3]) select 0;
if(!isNil "_rabbit" && {(!alive _rabbit)}) exitWith {deleteVehicle _rabbit; [true,"rabbit",1] call life_fnc_handleInv; systemChat "You have gathered some rabbit meat"};
private["_gather","_itemWeight","_diff","_itemName","_val","_resourceZones","_zone","_check"];
_resourceZones = ["apple_1","apple_2","apple_3","apple_4","peaches_1","peaches_2","peaches_3","peaches_4","heroin_1","cocaine_1","weed_1","corn_1","ephedra_1","metal_1"];
_zone = "";
if(life_gather > 2) exitWith {};
if(life_action_gathering) exitWith {}; /*Action is in use, exit to prevent spamming.*/
life_action_gathering = true;

/*Find out what zone we're near*/
{
	if(player distance (getMarkerPos _x) < 30) exitWith {_zone = _x;};
} foreach _resourceZones;

if(_zone == "") exitWith {
	life_action_inUse = false;
};

/*Get the resource that will be gathered from the zone name...*/
switch(true) do {
	case (_zone in ["apple_1","apple_2","apple_3","apple_4"]): {_gather = "apple"; _val = 3;};
	case (_zone in ["peaches_1","peaches_2","peaches_3","peaches_4"]): {_gather = "peach"; _val = 3;};
	case (_zone in ["heroin_1"]): {_gather = "heroinu"; _val = 1;};
	case (_zone in ["cocaine_1"]): {_gather = "cocaine"; _val = 1;};
	case (_zone in ["weed_1"]): {_gather = "cannabis"; _val = 2;};
	case (_zone in ["corn_1"]): {_gather = "corn"; _val = 3;};
	case (_zone in ["ephedra_1"]): {_gather = "eph"; _val = 2;};
	case (_zone in ["metal_1"]): {_gather = "plateMetal"; _val = 1;};
	default {""};
};
/*gather check??*/
if(!isNull objectParent player) exitWith {/*hint localize "STR_NOTF_GatherVeh";*/};

_diff = [_gather,_val,life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
if(_diff == 0) exitWith {systemChat "Your inventory is full!"; life_action_gathering = false;};
life_action_inUse = true;
life_gather = life_gather + 1;
for "_i" from 0 to 2 do
{
	if(speed player >= 1) exitWith {titleText["Gathering aborted due to movement!","PLAIN"]; _check = true};
	player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
	waitUntil{animationState player != "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";};
	sleep 2.5;
	_check = false;
};
if(_check) exitWith {life_action_inUse = false; life_action_gathering = false; life_gather = 0;};
if(([true,_gather,_diff] call life_fnc_handleInv)) then
{
	_itemName = [([_gather,0] call life_fnc_varHandle)] call life_fnc_varToStr;
	titleText[format[localize "STR_NOTF_Gather_Success",_itemName,_diff],"PLAIN"];
};
life_action_inUse = false;
life_gather = 0;
if(_zone == "metal_1") then { life_action_gathering = false; };
life_action_gathering = false;