/*
	File: fn_groupMarkers.sqf
	Description: Voir membres d'un gang sur la map
Marks cops on the map for other cops. Only initializes when the actual map is open.
*/
private["_markers","_units"];
_markers = [];
_units = [];

sleep 0.5;
if(visibleMap) then {
	{
		if((side _x == civilian) && !(_x getVariable["restrained",false] || _x getVariable["zipTie",false])) then {
			_units pushBack _x;
		}
	} forEach (units(group player)); /*Fetch list of units*/
	
	/*Create markers*/
	{
		_marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
		_marker setMarkerColorLocal "ColorGreen";
		_marker setMarkerTypeLocal "Mil_arrow";
		_marker setMarkerTextLocal format["%1", name _x];
	
		_markers pushBack [_marker,_x];
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
	_units = [];
};