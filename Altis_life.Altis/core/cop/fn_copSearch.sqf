#include <macro.h>
/*
	File: fn_copSearch.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Returns information on the search.
*/
private["_civ","_guns","_gun","_inv","_robber","_out","_illegal","_invs","_bleedout"];

_civ = param [0,Objnull,[Objnull]];
_invs = param [1,[],[[]]];
_robber = param [2,false,[false]];
_guns = param [3,[],[[]]];
_bleedout = param [4,0,[0]];
_illegal = 0;
_inv = "";
_gun = "";

if(isNull _civ) exitWith {};

/* Format guns.*/
if (count _guns > 0) then {
    {
        _gun = format["%1%2<br/>", _gun, _x];
    } forEach _guns;
} else {
    _gun = "No concealed weapons";
};

_out = format["<t color='#FF0000'><t size='2'>%1</t></t><br/>", name _civ];
_found = "";
/*Fix so medics don't search for illegals*/
if(side player == west && count _invs > 0) then
{
	{
		_inv = _inv + format["%1 %2<br/>",_x select 1,[([_x select 0,0] call life_fnc_varHandle)] call life_fnc_varToStr];
		_index = [_x select 0,life_illegal_items] call fnc_index;
		if(_index != -1) then
		{
			_illegal = _illegal + ((_x select 1) * ((life_illegal_items select _index) select 1));
			_found = _found + format["%1; ",[[_x select 0,0] call life_fnc_varHandle] call life_fnc_varToStr];
		};
	} foreach _invs;
	switch(true) do
	{
		case (_illegal > 10000):
		{
			[getPlayerUID _civ,name _civ,"903",[name player,getPos player,_found]] remoteExec ["life_fnc_wantedAdd",2];
		};
		case (_illegal > 0 && _illegal <= 10000):
		{
			[getPlayerUID _civ,name _civ,"902",[name player,getPos player,_found]] remoteExec ["life_fnc_wantedAdd",2];
		};
	};
	[0,format["%1 has $%2 worth of contraband on them.",name _civ,[_illegal] call life_fnc_numberText]] remoteExec ["life_fnc_broadcast",west];
}
	else
{
	_inv = "No illegal items";
};

if(!alive _civ || player distance _civ > 5) exitWith {hint format["Couldn't search %1", name _civ]};

if (side player == independent) then {
	if (primaryWeapon _civ != "" || handGunWeapon _civ != "") then {
		_out = _out + "<t color='#FFFF00'><t size='1.5'>Armed</t></t><br/><br/>";
	} else {
		_out = _out + "<t color='#00AA00'><t size='1.5'>Unarmed</t></t><br/><br/>";
	};
} else {
	_out = _out + format ["<t color='#FFD700'><t size='1.5'>Illegal Items:</t></t><br/>%1<br/><br/>", _inv];
};
_out = _out + format ["<t color='#FF0000'><t size='1.5'>Concealed Weapons:</t></t><br/>%1<br/><br/>", _gun];
if(handGunWeapon _civ != "") then
{_out = _out + "<t color='#FF0000'><t size='1'>Has a handgun</t></t><br/><br/>";};
if (_civ getVariable ["unconscious",false]) then {
	_out = _out + format ["<t color='#FFFFFF'>Bleedout in %1 seconds.</t><br/><br/>", round (_bleedout)];
};
if(_civ getVariable["realname",name _civ] != name _civ) then {
	[0,format["%1's real identity was revealed to be %2!",_civ getVariable "realname",name _civ]] remoteExec ["life_fnc_broadcast",0];
	_civ setVariable["realname",name _civ,true]; 
	[getPlayerUID _civ,""] remoteExecCall ["DB_fnc_updateFakeName",2];
};
hint parseText _out;


if(_robber && side player == west) then
{
	[0,format["%1 was identified as the gas station robber!",name _civ]] remoteExec ["life_fnc_broadcast",0];
};