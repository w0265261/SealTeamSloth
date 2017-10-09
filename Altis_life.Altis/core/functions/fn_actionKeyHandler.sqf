#include <macro.h>
/*
        File: fn_actionKeyHandler.sqf
        Author: Bryan "Tonic" Boardwine
        
        Description:
        Master action key handler, handles requests for picking up various items and
        interacting with other players (Cops = Cop Menu for unrestrain,escort,stop escort, arrest (if near cop hq), etc).
*/
private["_curTarget","_isWater"];
if(!isNull objectParent player) exitWith {
	_units = [];
	{if(vehicle _x != _x && player distance _x < 20 && !(_x in crew (vehicle player)) && _x == (driver (vehicle _x))) then {_units pushBack _x};} forEach playableUnits;
	if(count _units > 0 && count life_racers == 0) then {
		_units call KBW_fnc_openDuelUI;
	};
}; 
_curTarget = cursorTarget;
if(!isNull life_escort) exitWith {
	if(player distance life_escort > 5) then {life_escort = ObjNull;} else {
	if(!isPlayer life_escort) exitWith {[life_escort] call life_fnc_crateMenu};
	switch(playerSide) do {
		case west: {[life_escort] call life_fnc_copInteractionMenu};
		case civilian: {[life_escort] call life_fnc_civInteractionMenu};
		case independent: {[life_escort] call life_fnc_medicInteractionMenu};
	};
	};
};
if(life_action_inUse) exitWith {}; /*Action is in use, exit to prevent spamming.*/
if(life_interrupted) exitWith {life_interrupted = false;};
_spikes = nearestObjects[getPos player,["Land_Razorwire_F"],8];
if(count _spikes > 0) exitWith {
	_spikes = _spikes select 0;
	_var = _spikes getVariable "item";
	if(!isNil "_spikes" && !isNil "_var") exitWith {_spikes call life_fnc_packupSpikes};
};
_isWater = surfaceIsWater (getPosASL player);
if(isNull _curTarget) exitWith {
    if(_isWater) then {
		_animalTypes = ["Salema_F","Ornate_random_F","Mackerel_F","Tuna_F","Mullet_F","CatShark_F","Turtle_F"];
        private["_fish"];
        _fish = (nearestObjects[getPos player,["Fish_Base_F"],3]) select 0;
        if(!isNil "_fish") then {
            [_fish] call life_fnc_catchFish;
        };
		if((typeOf ((nearestObjects [player, [], 10]) select 1)) in _animalTypes) then {
            if((typeOf ((nearestObjects [player, [], 10]) select 1)) == "Turtle_F") then {
				_turtle = (nearestObjects [player, [], 10]) select 1;
                [_turtle] spawn life_fnc_catchTurtle;
            } else {
				_turtle = (nearestObjects [player, [], 10]) select 1;
                [_turtle] spawn life_fnc_catchFish;
            };
        };
	} else {
		if(playerSide == civilian || undercover) then {
			_handle = [] spawn life_fnc_gather;
			waitUntil {scriptDone _handle};
			life_action_gathering = false;
			if(life_inv_pickaxe > 0) then {
				_handle = [] spawn life_fnc_pickaxeUse;
				waitUntil {scriptDone _handle};
				life_action_gathering = false;
			};
			if(life_inv_chainsaw > 0) then {
				_handle = [] spawn life_fnc_chainsaw;
				waitUntil {scriptDone _handle};
				life_action_gathering = false;
			};
        };
	};
};

if((_curTarget isKindOf "House_F") && {player distance _curTarget < 12} OR (nearestObject [[16547.4,12785.4,12],"Land_Offices_01_V1_F"]) == _curTarget) exitWith {
        [_curTarget] call life_fnc_houseMenu;
};
if(typeOf _curTarget in["I_supplyCrate_F","Box_IND_Wps_F","C_supplyCrate_F"]) exitWith {
	[_curTarget] call life_fnc_crateMenu;
};

if(dialog) exitWith {}; /*Don't bother when a dialog is open.*/
life_action_inUse = true;

/*If target is a player then check if we can use the cop menu.*/
if(isPlayer _curTarget && _curTarget isKindOf "Man") then {

        if(playerSide == west && {(_curTarget distance player < 5)}) then {
                [_curTarget] call life_fnc_copInteractionMenu;
        };

        if(playerSide == civilian && {(_curTarget distance player < 5)}) then {
                [_curTarget] call life_fnc_civInteractionMenu;
        };

        if(playerSide == independent && {(_curTarget distance player < 5)}) then {
                [_curTarget] call life_fnc_medicInteractionMenu;
        };

} else {

        private["_isVehicle","_miscItems","_money"];
        _isVehicle = if((_curTarget isKindOf "landVehicle") OR (_curTarget isKindOf "Ship") OR (_curTarget isKindOf "Air")) then {true} else {false};
        _miscItems = ["Land_BottlePlastic_V2_F","Land_TacticalBacon_F","Land_Can_V3_F","Land_CanisterFuel_F","Land_Suitcase_F","Land_FMradio_F","Land_GasCanister_F","Land_Defibrillator_F","Land_HandyCam_F","Land_Ground_sheet_folded_khaki_F","Land_Shovel_F","Land_PortableLongRangeRadio_F","Land_MetalBarrel_F","Land_Ammobox_rounds_F","Land_Sleeping_bag_blue_folded_F","Land_SatellitePhone_F","Land_Hammer_F","Land_Bucket_F","Land_Antibiotic_F","Land_WoodenLog_F","Land_Axe_F","Land_MetalWire_F","Land_Pillow_grey_F","Land_Sacks_heap_F","Land_Basket_F"];
        _money = "Land_Money_F";
        

        if(_isVehicle) then {
                if(!dialog) then {
                        if(player distance _curTarget < ((boundingBox _curTarget select 1) select 0) + 2) then {
                                [_curTarget] call life_fnc_vInteractionMenu;
                        };
                };
        } else {



                        if((typeOf _curTarget) in _miscItems) then {

                                private["_handle"];
                                _handle = [_curTarget] spawn life_fnc_pickupItem;
                                waitUntil {scriptDone _handle};
                        } else {

                                if((typeOf _curTarget) == _money && {!(_curTarget getVariable["inUse",false])}) then {
                                        private["_handle"];
                                        _curTarget setVariable["inUse",TRUE,TRUE];
                                        _handle = [_curTarget] spawn life_fnc_pickupMoney;
                                        waitUntil {scriptDone _handle};
                                };
                        };
        };
};