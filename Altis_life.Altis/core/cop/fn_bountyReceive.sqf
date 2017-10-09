/*
	File: fn_bountyReceive.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Notifies the player he has received a bounty and gives him the cash.
*/
private["_val","_total"];
_val = param [0,"",["",0]];
_total = param [1,"",["",0]];

if(_val == _total) then
{
	titleText[format[localize "STR_Cop_BountyRecieve",[_val] call life_fnc_numberText],"PLAIN"];
	_value = if(life_rules select 6 == 2) then {2} else {1};
	if(_value == 2) then {hint format["Thanks to the police bonus put in place by President %1, you have received an extra prestige point for this arrest.",life_rules select 5]};
	life_prestige = life_prestige + _value;
}
	else
{
	titleText[format[localize "STR_Cop_BountyKill",[_val] call life_fnc_numberText,[_total] call life_fnc_numberText],"PLAIN"];
};

["atm","add",_val] call life_fnc_handlePaper;