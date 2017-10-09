/*
	Created by: STS Dev Team
	Function Name: life_fnc_createmarker.sqf
	Description: Creates a marker on the map for texting of police
*/

Private["_playerName","_pos","_marker","_format"];
_playerName = param [ 0, "",[""]];
_pos = _this select 1;
_format = format["911 %1",_playerName];
_playerName = "911+_playerName;

deleteMarkerLocal _playerName;
_marker = createMarkerLocal [_playerName, _pos];
_marker setMarkerShapeLocal "Icon";
_marker setMarkerTypeLocal "waypoint";
_marker setMarkerColorLocal "ColorRed";
_marker setMarkerTextLocal _text;

sleep 300;
deleteMarkerLocal _playerName;