/*
    File: fn_saveThat.sqf
    Author: Kevin Webb - Adaptation/merging of multiple save gear scripts.
   
    Description:
    Saves the players gear for syncing to the database for persistence.
*/
private["_ret","_uItems","_bItems","_vItems","_pItems","_hItems","_yItems","_pMag","_hMag","_uni","_ves","_bag","_handled","_itemArray","_val"];
if(playerSide == independent || life_paintballing) exitWith {};
_life_gear = str life_gear;
_ret = [];
_ret pushBack uniform player;
_ret pushBack vest player;
_ret pushBack backpack player;
_ret pushBack goggles player;
_ret pushBack headgear player;
_ret pushBack assignedItems player;
_ret pushBack primaryWeapon player;
_ret pushBack handGunWeapon player;
 
_uItems = [];
_bItems = [];
_vItems = [];
_pItems = [];
_hItems = [];
_yItems = [];

 if (count (primaryWeaponMagazine player) > 0 ) then
{
    _pMag = ((primaryWeaponMagazine player) select 0);
    if (_pMag != "") then
    {
        _uni = player canAddItemToUniform _pMag;
        _bag = player canAddItemToBackpack _pMag;
        _handled = false;
        if (player canAddItemToVest _pMag) then
        {
            _vItems pushBack [_pMag,1];
            _handled = true;
        };
        if (_uni AND !_handled) then
        {
            _uItems pushBack [_pMag,1];
            _handled = true;
        };
        if (_bag AND !_handled) then
        {
            _bItems pushBack [_pMag,1];
            _handled = true;
        };
    };
};

if (count (handgunMagazine player) > 0 ) then
{
    _hMag = ((handgunMagazine player) select 0);
    if (_hMag != "") then
    {
        _uni = player canAddItemToUniform _hMag;
        _bag = player canAddItemToBackpack _hMag;
        _handled = false;
        if (player canAddItemToVest _hMag) then
        {
            _vItems pushBack [_hMag,1];
            _handled = true;
        };
        if (_uni AND !_handled) then
        {
            _uItems pushBack [_hMag,1];
            _handled = true;
        };
        if (_bag AND !_handled) then
        {
            _bItems pushBack [_hMag,1];
            _handled = true;
        };
    };
};

if(uniform player != "") then
{
    {
			_exit = false;
			_thing = _x;
			_temp = str _x;
			for [{_x=0},{_x < count _uItems},{_x=_x+1}] do {
				_item = ((_uItems select _x) select 0);
				_mag = str _item;
				if(_mag == _temp) exitWith {
					_exit = true;
					_uItems set[_x,[_item,((_uItems select _x) select 1) + 1]];
				};
			};
			if(!_exit) then {
            _uItems pushBack [_thing,1]; };
    } forEach (uniformItems player);
};
 
if(backpack player != "") then
{
    {
			_exit = false;
			_thing = _x;
			_temp = str _x;
			for [{_x=0},{_x < count _bItems},{_x=_x+1}] do {
				_item = ((_bItems select _x) select 0);
				_mag = str _item;
				if(_mag == _temp) exitWith {
					_exit = true;
					_bItems set[_x,[_item,((_bItems select _x) select 1) + 1]];
				};
			};
			if(!_exit) then {
            _bItems pushBack [_thing,1]; };
    } forEach (backpackItems player);
};
 
if(vest player != "") then
{
    {
			_exit = false;
			_thing = _x;
			_temp = str _x;
			for [{_x=0},{_x < count _vItems},{_x=_x+1}] do {
				_item = ((_vItems select _x) select 0);
				_mag = str _item;
				if(_mag == _temp) exitWith {
					_exit = true;
					_vItems set[_x,[_item,((_vItems select _x) select 1) + 1]];
				};
			};
			if(!_exit) then {
            _vItems pushBack [_thing,1] };
    } forEach (vestItems player);
};

 
if(count (primaryWeaponItems player) > 0) then
{
    {
        _pItems = _pItems + [_x];
    } forEach (primaryWeaponItems player);
};
 
if(count (handGunItems player) > 0) then
{
    {
        _hItems = _hItems + [_x];
    } forEach (handGunItems player);
};

{
    _name = (_x select 0);
    _val = (_x select 1);
    if (_val > 0) then {
           _yItems pushBack [_name,_val];
    };
} forEach [
    ["life_inv_oilu",life_inv_oilu],
	["life_inv_gpstracker",life_inv_gpstracker],
	["life_inv_eph",life_inv_eph],
	["life_inv_phos",life_inv_phos],
	["life_inv_hydro",life_inv_hydro],
	["life_inv_meth",life_inv_meth],
	["life_inv_blindfold",life_inv_blindfold],
	["life_inv_oilp",life_inv_oilp],
	["life_inv_heroinu",life_inv_heroinu],
	["life_inv_heroinp",life_inv_heroinp],
	["life_inv_cannabis",life_inv_cannabis],
	["life_inv_marijuana",life_inv_marijuana],
	["life_inv_apple",life_inv_apple],
	["life_inv_rabbit",life_inv_rabbit],
	["life_inv_salema",life_inv_salema],
	["life_inv_ornate",life_inv_ornate],
	["life_inv_mackerel",life_inv_mackerel],
	["life_inv_tuna",life_inv_tuna],
	["life_inv_mullet",life_inv_mullet],
	["life_inv_catshark",life_inv_catshark],
	["life_inv_turtle",life_inv_turtle],
	["life_inv_water",life_inv_water],
	["life_inv_donuts",life_inv_donuts],
	["life_inv_coffee",life_inv_coffee],
	["life_inv_fuelF",life_inv_fuelF],
	["life_inv_fuelE",life_inv_fuelE],
	["life_inv_pickaxe",life_inv_pickaxe],
	["life_inv_copperore",life_inv_copperore],
	["life_inv_ironore",life_inv_ironore],
	["life_inv_ironr",life_inv_ironr],
	["life_inv_copperr",life_inv_copperr],
	["life_inv_sand",life_inv_sand],
	["life_inv_salt",life_inv_salt],
	["life_inv_saltr",life_inv_saltr],
	["life_inv_glass",life_inv_glass],
	["life_inv_tbacon",life_inv_tbacon],
	["life_inv_lockpick",life_inv_lockpick],
	["life_inv_redgull",life_inv_redgull],
	["life_inv_peach",life_inv_peach],
	["life_inv_diamond",life_inv_diamond],
	["life_inv_cocainep",life_inv_cocainep],
	["life_inv_cocaine",life_inv_cocaine],
	["life_inv_diamondc",life_inv_diamondc],
	["life_inv_spikeStrip",life_inv_spikeStrip],
	["life_inv_rock",life_inv_rock],
	["life_inv_cement",life_inv_cement],
	["life_inv_blastingcharge",life_inv_blastingcharge],
	["life_inv_defusekit",life_inv_defusekit],
	["life_inv_toolkit",life_inv_toolkit],
	["life_inv_goldore",life_inv_goldore],
	["life_inv_goldr",life_inv_goldr],
	["life_inv_zip",life_inv_zip],
	["life_inv_corn",life_inv_corn],
	["life_inv_moonshine",life_inv_moonshine],
	["life_inv_fcrab",life_inv_fcrab],
	["life_inv_fcrabp",life_inv_fcrabp],
	["life_inv_mcrabs",life_inv_mcrabs],
	["life_inv_mcrab",life_inv_mcrab],
	["life_inv_crabpot",life_inv_crabpot],
	["life_inv_coalore",life_inv_coalore],
	["life_inv_steel",life_inv_steel],
	["life_inv_log",life_inv_log],
	["life_inv_lumber",life_inv_lumber],
	["life_inv_chainsaw",life_inv_chainsaw],
    ["life_inv_lethal",life_inv_lethal],
	["life_inv_diamondf",life_inv_diamondf],
	["life_inv_pearl",life_inv_pearl],
	["life_inv_excavator",life_inv_excavator],
	["life_inv_silver",life_inv_silver],
	["life_inv_doubl",life_inv_doubl],
	["life_inv_ruby",life_inv_ruby],
	["life_inv_vammo",life_inv_vammo],
	["life_inv_detector",life_inv_detector],
	["life_inv_bhTool",life_inv_bhTool],
	["life_inv_medkit",life_inv_medkit],
	["life_inv_tentciv", life_inv_tentciv],
	["life_inv_nitro",life_inv_nitro],
	["life_inv_lethali",life_inv_lethali],
	["life_inv_alarm",life_inv_alarm],
	["life_inv_alarmV",life_inv_alarmV],
	["life_inv_ammoBoxS",life_inv_ammoBoxS],
	["life_inv_ammoBox",life_inv_ammoBox],
	["life_inv_shank",life_inv_shank],
	["life_inv_barGate",life_inv_barGate],
	["life_inv_roadCone",life_inv_roadCone],
	["life_inv_roadBarrier",life_inv_roadBarrier],
	["life_inv_cncBarrier",life_inv_cncBarrier],
	["life_inv_cncBarrierL",life_inv_cncBarrierL],
	["life_inv_reinforceddoor",life_inv_reinforceddoor],
	["life_inv_trackDart",life_inv_trackDart]
	
];


_ret pushBack _uItems;
_ret pushBack _bItems;
_ret pushBack _vItems;
_ret pushBack _pItems;
_ret pushBack _hItems;
_ret pushBack _yItems;
life_gear = _ret;
if(str life_gear == _life_gear) exitWith {};
[3] call SOCK_fnc_updatePartial;