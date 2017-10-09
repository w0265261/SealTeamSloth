/*
	File: fn_s_onSliderChange.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Called when the slider is changed for any field and updates the view distance for it.
*/
private["_mode","_value"];
_mode = param [0,-1,[0]];
_value = param [1,-1,[0]];
if(_mode == -1 OR _value == -1) exitWith {};
disableSerialization;

switch (_mode) do
{
	case 0:
	{
		tawvd_foot = round(_value);
		ctrlSetText[2902,format["%1",round(_value)]];
		[] call life_fnc_updateViewDistance;
	};
	
	case 1:
	{
		tawvd_car = round(_value);
		ctrlSetText[2912,format["%1",round(_value)]];
		[] call life_fnc_updateViewDistance;
	};
	
	case 2:
	{
		tawvd_air = round(_value);
		ctrlSetText[2922,format["%1",round(_value)]];
		[] call life_fnc_updateViewDistance;
	};
	
	case 3: // sales
	{
		if(!life_governor) exitWith {[] call life_fnc_govMenu};
		_minTax = 0;
		if(life_rules select 2 == 1) then {_minTax = _minTax + 2}
		else {if(life_rules select 2 == 2) then {_minTax = _minTax + 5}};
		if(life_rules select 3) then {_minTax = _minTax + 1};
		if(!(life_rules select 4)) then {_minTax = _minTax + 4};
		if(life_rules select 6 == 1) then {_minTax = _minTax + 2}
		else {if(life_rules select 6 == 2) then {_minTax = _minTax + 4}};
		if(life_rules select 7 == 1) then {_minTax = _minTax + 1}
		else {if(life_rules select 7 == 2) then {_minTax = _minTax + 3}};
		_str = if(_minTax > 10) then {", which is over the prescribed 10%1 limit. Try turning some of the laws off(red/yellow)."} else {""};
		if(round(_value) < _mintax) exitWith {hintSilent format["This tax would be too low; current required tax level is %1%2" + _str,"%",_minTax]; [] call life_fnc_govMenu};
		govCheck = nil;
		life_rules set [1, round(_value)];
		ctrlSetText[1902,format["%1%2",round(_value),"%"]];
		hintSilent "";
	};
};