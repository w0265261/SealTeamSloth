/*
File: fn_salesCheck.sqf
Author: Kevin Webb
Description: It's a secret!
*/
private["_msg"];
_soldWeight = 0;
_soldCount = 0;
_out = "";
{
	_soldCount = _soldCount + (_x select 1);
	_weight = [_x select 0] call life_fnc_itemWeight;
	_num = _x select 1;
	_soldWeight = _soldWeight + (_weight * _num);
	_var = format["life_inv_%1",_x select 0];
	_out = _out + format["%2 of %1; ",[_var] call life_fnc_varToStr,_x select 1];
} forEach life_sold;
_msg = format["Hack Alert User sold %1 items weighing %2 total and earned $%3 in the span of 5 minutes. Details %4",_soldCount,_soldWeight,[life_moneyMade] call life_fnc_numberText,_out];
if(_soldWeight > 520 || life_moneyMade > 500000 || _soldCount > 250) then {
	[3,-1,_msg] call life_fnc_newMsg;
	hintSilent "";
};