/*
	File: fn_receiveMoney.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Receives money
*/
private["_unit","_val","_from"];
_unit = param [0,Objnull,[Objnull]];
_val = param [1,"",[""]];
_from = param [2,Objnull,[Objnull]];
_fromName = param [3,"",[""]];
if(isNull _unit OR isNull _from OR _val == "") exitWith {};
if(player != _unit) exitWith {};
if(!([_val] call fnc_isnumber)) exitWith {};
if(_unit == _from) exitWith {}; /*Bad boy, trying to exploit his way to riches.*/

hint format[localize "STR_NOTF_GivenMoney",_fromName,[(parseNumber (_val))] call life_fnc_numberText];
["cash","add",(parseNumber(_val))] call life_fnc_handlePaper;