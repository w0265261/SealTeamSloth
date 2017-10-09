/*
	File: fn_toggleLaw.sqf
	Author: John "Paratus" VanderZwet
	Edited for compatibility and optimization by Kevin
	Description:
	Toggle laws from governor menu
*/

_paramID = param[0];
if(_paramID in [2,6,7]) then {
	_current = life_rules select _paramID;
	_current = _current + 1;
	if(_current == 3) then {_current = 0};
	life_rules set[_paramID,_current];
	[] call life_fnc_govMenu;
} else {
	if (life_rules select _paramID) then { 
		life_rules set [_paramID, false]; 
	} else {
		life_rules set [_paramID, true]; 
	};
};
[] call life_fnc_govMenu;
_minTax = 0;
if(life_rules select 2 == 1) then {_minTax = _minTax + 2}
else {if(life_rules select 2 == 2) then {_minTax = _minTax + 5}};
if(life_rules select 3) then {_minTax = _minTax + 1};
if(!(life_rules select 4)) then {_minTax = _minTax + 4};
if(life_rules select 6 == 1) then {_minTax = _minTax + 2}
else {if(life_rules select 6 == 2) then {_minTax = _minTax + 4}};
if(life_rules select 7 == 1) then {_minTax = _minTax + 1}
else {if(life_rules select 7 == 2) then {_minTax = _minTax + 3}};
_str = if(_minTax > 10) then {", which is over the prescribed 10%1 limit. Try turning some of the laws off(red)."} else {""};
if(life_rules select 1 < _minTax) exitWith {hint format["Tax rate is not currently high enough to support these changes, the tax rate must be set at %1%2" + _str,"%",_minTax]; govCheck = true};
govCheck = nil;
hintSilent "";