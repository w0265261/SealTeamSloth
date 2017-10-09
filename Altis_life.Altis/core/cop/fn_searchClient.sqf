#include <macro.h>
/*
	File: fn_searchClient.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Searches the player and he returns information back to the player.
*/
private["_cop","_inv","_guns","_var","_val","_robber","_licenses","_pubCop"];

_cop = param [0,Objnull,[objNull]];
if(isNull _cop) exitWith {};
_inv = [];
_guns = [];
_robber = false;

/*Debug*/
hint format ["%1 is searching you...",name _cop];
life_wantedlist = false;
/*Illegal items*/
if (side _cop == west) then {
	{
		if(!(_x select 0 in ["c","m"])) then {
			_var = [_x select 0,0] call life_fnc_varHandle;
			_val = missionNamespace getVariable _var;
			if(_val > 0) then
			{
				_inv pushBack [_x select 0,_val];
				[false,(_x select 0),_val] call life_fnc_handleInv;
			};
			missionNamespace setVariable[_var,0];
		};
	} foreach life_illegal_items;
};

/* Check for hidden weapons.*/
if (uniform player != "") then {
    {
        _cfg = [_x] call life_fnc_fetchCfgDetails;
        if(count _cfg > 0) then {
            if((_cfg select 6) == "CfgWeapons") then {
                if((_cfg select 4) in [1,2,4,5]) then {
                    _guns pushBack (_cfg select 1);
                };
            };
        };
    } forEach (uniformItems player);
};
if (vest player != "") then {
    {
        _cfg = [_x] call life_fnc_fetchCfgDetails;
        if(count _cfg > 0) then {
            if((_cfg select 6) == "CfgWeapons") then {
                if((_cfg select 4) in [1,2,4,5]) then {
                    _guns set [count _guns, (_cfg select 1)];
                };
            };
        };
    } forEach (vestItems player);
};
if (backpack player != "") then {
    {
        _cfg = [_x] call life_fnc_fetchCfgDetails;
        if(count _cfg > 0) then {
            if((_cfg select 6) == "CfgWeapons") then {
                if((_cfg select 4) in [1,2,4,5]) then {
                    _guns set [count _guns, (_cfg select 1)];
                };
            };
        };
    } forEach (backpackItems player);
};


if(!(life_use_atm) && side _cop == west) then 
{
	["cash","set",0] call life_fnc_handlePaper;
	_robber = true;
};

[player,_inv,_robber,_guns,life_bleedout - time] remoteExec ["life_fnc_copSearch",_cop,false];