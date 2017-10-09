_clerk = _this select 0;

_markerName = ( (str (random 1000)) + "_robbery");
_marker = createMarker [_markerName, getPos _clerk];
_markerName setMarkerColor "ColorRed";
_markerName setMarkerText "Alarm Sounded!";
_markerName setMarkerType "mil_warning";

sleep 330;
deleteMarker _markerName;
_clerk setVariable ["inProgress", false, true];
sleep 900;

_clerk setVariable ["canBeRobbed", true, true];