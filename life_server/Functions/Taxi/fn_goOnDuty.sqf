_driver = _this select 0;
if (isNil "TaxiDriversOnDuty") then { TaxiDriversOnDuty = []; };
if (isNil "TaxiCalls") then { TaxiCalls = []; };
if (!(_driver in TaxiDriversOnDuty)) then {TaxiDriversOnDuty pushBack _driver;
[1,TaxiCalls] remoteExec ["life_fnc_taxi_respond",_driver,false];
};