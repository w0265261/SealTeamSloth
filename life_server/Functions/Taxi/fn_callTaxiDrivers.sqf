// Get Parameters

_player = param [ 0, objNull];

// Exceptions

if (_player == objNull) exitWith {};
if (isNil "TaxiDriversOnDuty") then { TaxiDriversOnDuty = []; };
if (isNil "TaxiCalls") then { TaxiCalls = []; };

// Code

if (count TaxiDriversOnDuty == 0) exitWith { [4] remoteExec ["life_fnc_taxi_respond",_player,false]; };

TaxiCalls pushBack _player;

[1,TaxiCalls] remoteExec ["life_fnc_taxi_respond",TaxiDriversOnDuty]; // call Taxidrivers

_player spawn {
	_player = _this;
	sleep 60;
	if (_player in TaxiCalls) then {
		TaxiCalls = TaxiCalls - [_player];
		[3] remoteExec ["life_fnc_taxi_respond",_player,false];
		 [1,TaxiCalls] remoteExec ["life_fnc_taxi_respond",TaxiDriversOnDuty];
	};
};