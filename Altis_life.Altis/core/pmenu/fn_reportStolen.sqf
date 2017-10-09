/*
	File: fn_reportStolen.sqf
	Author: Kevin Webb
	
	Description:
	OH NOES I DIDN'T TAKE GOOD CARE OF MY VEHICLE, HEEEELLLLLPPPP
*/
private["_dialog","_list","_sel","_vehicle","_index"];
disableSerialization;

_dialog = findDisplay 2700;
_list = _dialog displayCtrl 2701;
_sel = lbCurSel _list;
if(_sel == -1) exitWith {hint "You didn't select a vehicle";};
_index = (parseNumber(_list lbData _sel));
_vehicle = life_vehicles select _index;
if(_vehicle isKindOf "House_F") exitWith {hint "You can't report your house stolen!"};
if(!(_vehicle getVariable["tracking",false])) exitWith { hint "If you would have invested in a GPS Tracker for your vehicle, maybe the police could have helped you in your time of need..."; };

if(_vehicle getVariable["nicked",false]) then {
	_vehicle setVariable["nicked",false,true]; hint "You have removed your vehicle from the stolen vehicles list"; /*nah it isn't stolen*/
} else {
	_msg = "This citizen has reported their vehicle stolen, and its GPS tracker has been activated - check your map for details on its position!";
	[_msg] call fnc_cell_textcop;
	_vehicle setVariable["nicked",true,true]; hint "You have reported your vehicle stolen - this puts it on the map for the police.";
}; /*or is it?*/