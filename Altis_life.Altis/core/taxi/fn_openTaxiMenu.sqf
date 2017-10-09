
disableSerialization;
createDialog "life_taxiMenu";
_display        = findDisplay 6600;
_taxiListbox    = _display displayCtrl 6601;

if (!life_isOnDutyTaxi) exitWith {hint "You are not on duty or you already accepted a request!";closeDialog 0;};

//[player] remoteExec ["TON_fnc_goOnDuty",2];
if (count TaxiCallsClient > 0) then
{
	{
		if(player distance _x < 15000 && _x != player) then {
			_taxiListbox lbAdd format ["%1 (%2 meters)",name _x,(_x distance player)];
			_taxiListbox lbSetData [(lbSize _taxiListbox)-1,str _x];
		};
	} forEach TaxiCallsClient;
} else {
	_taxiListbox lbAdd "No Taxi Requests Currently!";
};