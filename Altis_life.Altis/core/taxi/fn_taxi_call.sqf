// Exceptions

if (life_calledTaxi) exitWith { hint "You have already called a taxi!"; };
if (life_isOnDutyTaxi) exitWith { hint "You can't call a taxi since you are a taxidriver!"; };

// Main

life_calledTaxi = true;
[player] remoteExec ["TON_fnc_callTaxiDrivers",2];
hint "You called a taxi. Please wait until a Taxi Driver accepts the request. Your request will be deleted automatically after 60 seconds";