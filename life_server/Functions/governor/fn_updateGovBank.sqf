/*
fn_updateGovBank
Kevin Webb
updates the coffers
*/
_query = "";
_amount = param[0,0];
_isWithdraw = param[1,false];
if(_isWithdraw) then {
	_query = format["UPDATE rules SET govbank=govbank-%1",_amount];
} else {
	_multiplier = 1;
	if(life_rules select 2 == 1) then {_multiplier = _multiplier - 0.1}
	else {if(life_rules select 2 == 2) then {_multiplier = _multiplier - 0.25}; };
	if(life_rules select 3) then {_multiplier = _multiplier - 0.05};
	if(!(life_rules select 4)) then {_multiplier = _multiplier - 0.2};
	if(life_rules select 6 == 1) then {_multiplier = _multiplier - 0.05}
	else {if(life_rules select 6 == 2) then {_multiplier = _multiplier - 0.15}; };
	if(life_rules select 7 == 1) then {_multiplier = _multiplier - 0.1}
	else {if(life_rules select 7 == 2) then {_multiplier = _multiplier - 0.25}; };
	_query = format["UPDATE rules SET govbank=govbank+%1",_amount * _multiplier];
};
[_query,1] call DB_fnc_asyncCall;
_uid = life_rules select 0;
if([_uid] call life_fnc_isUIDActive && !_isWithdraw) then {
	_unit = ObjNull;
	{if(getPlayerUID _x == _uid) exitWith {_unit = _x;}} forEach playableUnits;
	if(!isNull _unit) then {
		_query = "SELECT govbank FROM rules";
		_money = ([_query,2] call DB_fnc_asyncCall) select 0;
		["gov_bank",_money] remoteExecCall ["life_fnc_netSetVar",_unit];
	};
};