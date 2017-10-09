disableSerialization;
_display        = findDisplay 6600;
_taxiListbox    = _display displayCtrl 6601;
if !(lbCurSel _taxiListbox >=0) exitWith {hint "Error";};
_player         = _taxiListbox lbData (lbCurSel _taxiListbox);
_player = call compile _player;

hint format ["You have accepted the taxi call of %1. He is %2 meters away from you current location. The location has been marked on your map.",name _player,player distance _player];

life_taxiCustomer = _player;

[player,_player] remoteExec ["TON_fnc_acceptedTaxiCall",2];
[2,player] remoteExec ["life_fnc_taxi_respond",_player,false];

_markerText = createMarkerLocal ["Taxilocation", getPos _player];
_markerText setMarkerTypeLocal "mil_warning";
_markerText setMarkerColorLocal "ColorRed";
_markerText setMarkerTextLocal format ["LAST POSITION OF %1",name _player];

life_isOnDutyTaxi = false;
closeDialog 0;

taxi_ActionToLeave = player addAction ["Stop Taxi-Service", {
	if (alive life_taxiCustomer) then {
		[6] remoteExec ["life_fnc_taxi_respond",life_taxiCustomer,false];
		player removeAction taxi_ActionToLeave;
	} else {
		player removeAction taxi_ActionToLeave;
		_message = "You stopped the ride, but the customer seems to be either dead or not connected anymore.";
		titleText[format["%1",_message],"PLAIN"];
		life_isOnDutyTaxi = true;
		[player] remoteExec ["TON_fnc_goOnDuty",2];
	};
}];


while {!isNull life_taxiCustomer && player distance _player > 10} do { sleep 1; _markerText setMarkerPosLocal getPos _player; };

deleteMarkerLocal _markerText;