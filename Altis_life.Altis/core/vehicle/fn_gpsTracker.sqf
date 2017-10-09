/*
	File: fn_gpsTracker.sqf
	Author: Poseidon
	
	Description: Attaches a gps tracker to selected vehicle
*/
private["_unit","_nope"];
_nope = false;
_unit = param [0,ObjNull,[ObjNull]];
_tracker = param [1,false,[false]];
if(isNull _unit) exitWith {};
if(!(_unit isKindOf "LandVehicle" OR _unit isKindOf "Ship" OR _unit isKindOf "Air" OR (_unit isKindOf "Man" && _tracker))) exitWith {};
if(player distance _unit > 7 && !_tracker) exitWith {hint "You need to be up closer to use this."};
if(_unit getVariable["tracker",ObjNull] == player) exitWith {hint "You are already tracking this vehicle."};
if(!_tracker) then {
if(!([false,"gpstracker",1] call life_fnc_handleInv)) exitWith {_nope = true;};
};
if(_nope) exitWith {};
if(!_tracker) then {
closeDialog 0;
life_action_inUse = true;
player playMove "AinvPknlMstpSnonWnonDnon_medic_1";
sleep 4;
life_action_inUse = false;
titleText["You have attached a tracking device to this vehicle.","PLAIN"];
};
_unit setVariable["tracking",true,true];
_unit setVariable["tracker",player];
_unit setVariable["trackee",getPlayerUID player,true];
[_unit] spawn {
	_veh = _this select 0;
	_markerName = format["%1_gpstracker",_veh];
	_marker = createMarkerLocal [_markerName, visiblePosition _veh];
	_marker setMarkerColorLocal "ColorRed";
	_marker setMarkerTypeLocal "Mil_arrow2";
	_name = if(_veh isKindOf "Man") then {name _veh} else {getText(configFile >> "CfgVehicles" >> typeof _veh >> "displayName")};
	_marker setMarkerTextLocal ("GPS Tracker " + _name);
	_marker setMarkerPosLocal getPos _veh;
	while {true} do {
		if(not alive _veh) exitWith {deleteMarkerLocal _markerName;};
		_marker setMarkerPosLocal getPos _veh;
		_marker setMarkerDirLocal getDir _veh;
		sleep 0.25;
	};
};
if(count units player > 1 && !_tracker) then {
_units = units player;
_units = _units - [player];
[_unit,true] remoteExec ["life_fnc_gpsTracker",_units];
};
_owner = ((_unit getVariable["vehicle_info_owners",[[""]]]) select 0) select 0;
if(_owner == getPlayerUID player && !_tracker) exitWith {
	_unit remoteExec ["TON_fnc_gpsTracked",2];
};