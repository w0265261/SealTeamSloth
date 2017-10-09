/*
	File: fn_pickupMoney.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Picks up money
*/
if((time - life_action_delay) < 1) exitWith {
	hint "You can't rapidly use action keys!";
	if(!isNil {(_this select 0) getVariable "inUse"}) then {
		_this select 0 setVariable["inUse",false,true];
	};
};
private["_obj","_val"];
_obj = param [0,ObjNull,[ObjNull]];
_val = (_obj getVariable "item") select 1;
if(isNil {_val}) exitWith {};
if(isNull _obj || player distance _obj > 3) exitWith {if(!isNull _obj) then {_obj setVariable["inUse",false,true];};};
if((_obj getVariable["PickedUp",false])) exitWith {deleteVehicle _obj;}; /*Object was already picked up.*/
_obj setVariable["PickedUp",TRUE,TRUE];
if(!isNil {_val}) then
{
	deleteVehicle _obj;
	/*waitUntil {isNull _obj};*/
	
	/*Stop people picking up huge values of money which should stop spreading dirty money.*/
	switch (true) do
	{
		case (_val > 2000000) : {_val = 10000;};
		case (_val > 500000) : {_val = 25000;};
		default {};
	};
	
	player playmove "AinvPknlMstpSlayWrflDnon";
	titleText[format[localize "STR_NOTF_PickedMoney",[_val] call life_fnc_numberText],"PLAIN"];
	["cash","add",_val] call life_fnc_handlePaper;
	life_action_delay = time;
};
