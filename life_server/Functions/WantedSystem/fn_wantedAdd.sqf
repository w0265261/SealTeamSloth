/*
	File: fn_wantedAdd.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Adds or appends a unit to the wanted list.
*/
private["_uid","_type","_index","_data","_crimes","_val","_customBounty","_name","_unit"];
_uid = param [0,"",[""]];
_name = param [1,"",[""]];
_type = param [2,"",[""]];
_details = param[3,[]];
_loc = _details select 1;
if(!isNil "_loc" && {typeName _loc == "ARRAY"}) then {
	_details set[1,[round (_loc select 0),round (_loc select 1)]];
	_xCord = (_details select 1) select 0;
	_yCord = (_details select 1) select 1;
	_selectX = if(_xCord > 10000) then {3} else {2};
	_selectY = if(_yCord > 10000) then {3} else {2};
	_details set [
		1,
		[
			parseNumber ((str _xCord) select [0,_selectX]),
			parseNumber ((str _yCord) select [0,_selectY])
		]
	];
};
_unit = ObjNull;
if(_uid == "" OR _type == "" OR _name == "") exitWith {}; /*Bad data passed.*/

/*What is the crime?*/
switch(_type) do
{
	case "187": {_type = ["Murder",5000]};
	case "187A": {_type = ["Murder of an Officer",7500]};
	case "207": {_type = ["Kidnapping",2000]};
	case "211": {_type = ["Mugging",1000]};
	case "211A": {_type = ["Armed Robbery",2200]};
	case "215": {_type = ["Att. GTA",800]};
	case "245": {_type = ["Assault with Firearm",3000]};
	case "245A": {_type = ["Firing on an Officer",4000]};
	case "459": {_type = ["Breaking and Entering",500]};
	case "460": {_type = ["Initiating Jailbreak",900]};
	case "461": {_type = ["Tampering with the Fed",1000]};
	case "459A": {_type = ["Att. Burglary",300]};
	case "481": {_type = ["Hit and run",1300]};
	case "484": {_type = ["Search Warrant - Alcohol",0]};
	case "487": {_type = ["GTA",1000]};
	case "490": {_type = ["Supplying Chop Shop",1500]};
	case "600": {_type = ["Criminal Threatening",200]};
	case "601": {_type = ["Obstruction of Justice",800]};
	case "602": {_type = ["Aviation Violation",700]};
	case "603": {_type = ["2nd Degree GTA",500]};
	case "604": {_type = ["Moving Violation",100]};
	case "902": {_type = ["Possession",200]};
	case "903": {_type = ["Felony Possession",1000]};
	case "904": {_type = ["Search Warrant - Drugs",0]};
	case "905": {_type = ["Aiding Escape",500]};
	case "906": {_type = ["Bank Robbery",2000]};
	case "Kev": {_type = ["Att. Murder",1500]};
	case "Ass": {_type = ["Presidential Assassination",10000]};
	case "Dev": {_type = ["Evasion",1000]};
	case "Drug": {_type = ["Proven Drug Trafficking",2200]};
	case "poach": {_type = ["Poaching",1100]};
	default {_type = [];};
};

if(count _type == 0) exitWith {}; /*Not our information being passed...*/

_index = [_uid,life_wanted_list] call fnc_index;

if(_index != -1) then
{
	_data = life_wanted_list select _index;
	_crimes = _data select 2;
	_crimes pushBack [(_type select 0),_details];
	_val = _data select 3;
	life_wanted_list set[_index,[_name,_uid,_crimes,(_type select 1) + _val]];
	[[_name,_uid,_crimes,(_type select 1) + _val],_uid] spawn TON_fnc_saveBounties;
}
	else
{
	life_wanted_list pushBack [_name,_uid,[[(_type select 0),_details]],(_type select 1)];
	[[_name,_uid,[[(_type select 0),_details]],(_type select 1)],_uid] spawn TON_fnc_saveBounties;
};

{if(getPlayerUID _x == _uid) then {_unit = _x;}; if(!isNull _unit) exitWith {}; } forEach playableUnits;
[true] remoteExec ["life_fnc_amIWanted",_unit];
if(!(_unit getVariable["realname",name _unit] in[name _unit,""]) && side _unit == civilian) then {_unit setVariable["realname",name _unit, true]; [_uid,""] call DB_fnc_updateFakeName };
publicVariable "life_wanted_list";