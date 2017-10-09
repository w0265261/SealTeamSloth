/*
	File: fn_escortAction.sqf
*/
private["_unit"];
_unit = param [0,ObjNull,[ObjNull]];
if(isNil "_unit" OR isNull _unit) exitWith {};
_unit attachTo [player,[0.1,1.1,0]];
if(typeOf _unit in["I_supplyCrate_F","C_supplyCrate_F"]) then { _unit attachTo [player,[0.1,1.1,0.9]]; };

_unit setVariable["Escorting",true,true];
life_escort = _unit;
player reveal _unit;
[] spawn {
	while{!isNull life_escort} do {
		sleep 1;
		if(!isNull objectParent player) exitWith {
			detach life_escort;
			life_escort = ObjNull;
		};
	};
};