/*
	File: fn_medicMarkers.sqf
	Author: Skeith
	
	Description:
	Marks medics on the map for other medics. Only initializes when the actual map is open.
*/
private["_mMarkers","_vMarkers","_medics","_victims"];
_mMarkers = [];
_vMarkers = [];
_medics = [];
_victims = [];

sleep 0.25;
if(visibleMap) then {
	/*Get list of medics and list of unconscious*/
	{
		if(side _x == independent) then { _medics pushBack _x; };
		if(_x getVariable ["unconscious",false]) then { _victims pushBack _x; };
	} foreach playableUnits; 
	
	/*Create markers for medics*/
	{
		_mMarker = createMarkerLocal [format["%1_mMarker",_x],visiblePosition _x];
		_mMarker setMarkerColorLocal "ColorGreen";
		_mMarker setMarkerTypeLocal "Mil_arrow";
		_mMarker setMarkerTextLocal format["%1", name _x];
	
		_mMarkers pushBack [_mMarker,_x];
	} foreach _medics;
	/*Create markers for unconscious*/
	{
		_vMarker = createMarkerLocal [format["%1_vMarker",_x],visiblePosition _x];
		_vMarker setMarkerColorLocal "ColorOrange";
		if(_x getVariable["arrowToTheKnee",false]) then {
		_vMarker setMarkerTextLocal format["Unconscious From Gunshot: %1", name _x];
		} else {
		_vMarker setMarkerTextLocal format["Unconscious: %1", name _x];
		};
		_vMarker setMarkerTypeLocal "hd_destroy";
	
		_vMarkers pushBack [_vMarker,_x];
	} foreach _victims;

	/*Update medic positions while map open*/
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
					if(side _unit == independent) then {_marker setMarkerDirLocal (getDir _unit)};
				};
			};
		} foreach _mMarkers;
		if(!visibleMap) exitWith {};
	};
	
	/*Clean up markers after map closes*/
	{deleteMarkerLocal (_x select 0);} foreach _mMarkers;
	{deleteMarkerLocal (_x select 0);} foreach _vMarkers;
	_mMarkers = [];
	_vMarkers = [];
	_medics = [];
	_victims = [];
};