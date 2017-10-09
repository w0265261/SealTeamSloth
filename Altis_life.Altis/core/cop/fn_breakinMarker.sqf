/*
File: fn_breakinMarker.sqf
Author: Kevin Webb
Description: Marks house break-ins on the maps of cops, pretty straightforward.
Update: Handles different map markers for police.
*/
if(isServer && isDedicated) exitWith {};
private["_bMarker","_criminal"];
_criminal = param [0,ObjNull,[ObjNull]];
_type = param [1,0,[0]];
switch(_type) do {
case 0: {
if(life_marked) exitWith {};
life_marked = true;
_bMarker = createMarkerLocal [format["%1_bMarker",_criminal],visiblePosition _criminal];
_bMarker setMarkerColorLocal "ColorRed";
_bMarker setMarkerTextLocal "Home Alarm Sounded!";
_bMarker setMarkerTypeLocal "waypoint";
sleep 120;
deleteMarkerLocal _bMarker;
life_marked = false;
};
case 1: {
if(playerSide == civilian && !license_civ_bh) exitWith {};
if(playerSide == independent) exitWith {};
_bMarker = createMarkerLocal [format["%1_bMarker",_criminal],visiblePosition _criminal];
_bMarker setMarkerColorLocal "ColorRed";
_bMarker setMarkerTextLocal format["Criminal %1",name _criminal];
_bMarker setMarkerTypeLocal "hd_destroy";
sleep 120;
deleteMarkerLocal _bMarker;
};
case 2: {
_bMarker = createMarkerLocal [format["%1_bMarker",_criminal],visiblePosition _criminal];
_bMarker setMarkerColorLocal "ColorGreen";
_from = "";
if(_this select 2) then { _from = "Anonymous"; } else { _from = name _criminal; };
_bMarker setMarkerTextLocal format["911 Call: %1",_from];
_bMarker setMarkerTypeLocal "hd_destroy";
sleep 120;
deleteMarkerLocal _bMarker;
};
case 3: {
_bMarker = createMarkerLocal [format["%1_bMarker",_criminal],visiblePosition _criminal];
_bMarker setMarkerColorLocal "ColorGreen";
_bMarker setMarkerTextLocal format["EMS Dispatch: %1",name _criminal];
_bMarker setMarkerTypeLocal "hd_destroy";
sleep 120;
deleteMarkerLocal _bMarker;
};
case 4: {
_bMarker = createMarkerLocal [format["%1_bMarker",_criminal],visiblePosition _criminal];
_bMarker setMarkerColorLocal "ColorRed";
_bMarker setMarkerTextLocal "Your Home Alarm Sounded!";
_bMarker setMarkerTypeLocal "hd_destroy";
sleep 120;
deleteMarkerLocal _bMarker;
};
case 5: {
_bMarker = createMarkerLocal [format["%1_bMarker",_criminal],visiblePosition _criminal];
_bMarker setMarkerColorLocal "ColorRed";
_bMarker setMarkerTextLocal "Vehicle theft in progress";
_bMarker setMarkerTypeLocal "hd_destroy";
sleep 120;
deleteMarkerLocal _bMarker;
};
};