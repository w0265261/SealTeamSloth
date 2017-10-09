/*
	File: fn_copMarkers.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Marks cops on the map for other cops. Only initializes when the actual map is open.
*/
private["_markers","_cops","_vMarkers","_victims","_vMarker","_units","_uMarker"];
_markers = [];
_cops = [];
_victims = [];
_units = [];

sleep 0.25;
if(visibleMap) then {
	{if(!(_x getVariable["invis",false]) && vehicle _x == _x)  then {_cops pushBack _x;}} forEach (units player);
	{if(_x getVariable ["nicked",false]) then { _victims pushBack _x; }; if(_x getVariable["unit",-1] > -1 && count crew _x > 0 && (side ((crew _x) select 0)) == west) then { _units pushBack _x;};} forEach vehicles;
	/*Create markers*/
	{
		_marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
		_marker setMarkerColorLocal "ColorBlue";
		_type = if(_x isKindOf "Man") then {"Mil_arrow"} else {"Mil_arrow2"};
		_marker setMarkerTypeLocal _type;
		if(_x getVariable["unit",0] > 0) then {
		_marker setMarkerTextLocal format["%1 - Unit %2", _x getVariable["realname",name _x],_x getVariable["unit",0]]; } else {
		_marker setMarkerTextLocal format["%1", _x getVariable["realname",name _x]]; };
	
		_markers pushBack [_marker,_x];
	} foreach _cops;
	
	{
		_vMarker = createMarkerLocal [format["%1_vMarker",_x],visiblePosition _x];
		_vMarker setMarkerColorLocal "ColorRed";
		_vMarker setMarkerTextLocal "Potentially Stolen Vehicle";
		_vMarker setMarkerTypeLocal "Mil_arrow2";
	
		_markers pushBack [_vMarker,_x];
	} foreach _victims;
	
	{
		_uMarker = createMarkerLocal [format["%1_uMarker",_x],visiblePosition _x];
		_uMarker setMarkerColorLocal "ColorBlue";
		_uMarker setMarkerTextLocal format["Unit %1",_x getVariable "unit"];
		_uMarker setMarkerTypeLocal "Mil_arrow2";
	
		_markers pushBack [_uMarker,_x];
	} foreach _units;
	
	while {visibleMap} do
	{
		{
			private["_marker","_unit"];
			_marker = _x select 0;
			_unit = _x select 1;
			if(!isNil "_unit") then
			{
				if(!isNull _unit) then
				{
					_marker setMarkerPosLocal (visiblePosition _unit);
					_marker setMarkerDirLocal (getDir _unit);
				};
			};
		} foreach _markers;
		if(!visibleMap) exitWith {};
	};

	{deleteMarkerLocal (_x select 0);} foreach _markers;
	_markers = [];
	_cops = [];
	_victims = [];
};