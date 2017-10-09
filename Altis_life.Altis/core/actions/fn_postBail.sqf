/*
	File: fn_postBail.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Called when the player attempts to post bail.
	Needs to be revised.
*/
_param = _this select 0;
if(typeName _param == "BOOL") then {life_bail_amount = 0};
if(life_bail_paid) exitWith {};
if(isNil {life_bail_amount}) then {life_bail_amount = 350;};
if(life_myfunds < life_bail_amount) exitWith {hint format[localize "STR_NOTF_Bail_NotEnough",life_bail_amount];};

["atm","take",life_bail_amount] call life_fnc_handlePaper;
life_bail_paid = true;
deleteVehicle life_placing;
[] spawn {
	while{true} do {
		_action = [
			"You now get to choose which city you wish to be delivered to. Do you wish to go to Athira?",
			"Choose Destination",
			localize "STR_Global_Yes",
			"Next choice"
			] call BIS_fnc_guiMessage;
		if(_action) exitWith { player setPos (getMarkerPos "jail_release"); };
		_action = [
			"Pyrgos?",
			"Choose Destination",
			localize "STR_Global_Yes",
			"Next choice"
			] call BIS_fnc_guiMessage;
		if(_action) exitWith { player setPos (getMarkerPos "civ_spawn_2"); };
		_action = [
			"Sofia?",
			"Choose Destination",
			localize "STR_Global_Yes",
			"Next choice"
			] call BIS_fnc_guiMessage;
		if(_action) exitWith { player setPos (getMarkerPos "civ_spawn_4"); };
		_action = [
			"Agios Dionysios?",
			"Choose Destination",
			localize "STR_Global_Yes",
			"Previous"
			] call BIS_fnc_guiMessage;
		if(_action) exitWith { player setPos (getMarkerPos "medic_spawn_1"); };
	};
};