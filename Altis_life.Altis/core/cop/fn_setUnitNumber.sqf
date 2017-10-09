/*
fn_setUnitNumber.sqf
Kevin Webb
Allows the fuzz to designate their vehicle as a unit number.
*/
private["_vehicle","_unit"];
_vehicle = param [0,ObjNull,[ObjNull]];
_unit = 1;
while{true} do {
	_action = [
		"This function will allow you to designate your vehicle as a numbered unit. Cycle through the numbers with the 'Next' button and then designate by clicking the unit number.",
		"Unit Designation",
		format["Unit %1",_unit],
		"Next"
		] call BIS_fnc_guiMessage;
	if(_action) exitWith { _vehicle setVariable["unit",_unit,true]; player setVariable["unit",_unit,true]; };
	_unit = _unit + 1;
	if(_unit > 20) then { _unit = 1; };
};
hint format["Your vehicle has been designated as unit %1, to change this simply go through the designation process again.",_unit];