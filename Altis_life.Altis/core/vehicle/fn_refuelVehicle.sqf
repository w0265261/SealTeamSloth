/*
	File: fn_refuelVehicle.sqf
	Author: John "Paratus" VanderZwet
	edited for compatibility and optimization by Kevin
	Description:
	Refuel a vehicle!
*/

private ["_vehicle","_capacity","_litres","_cost","_level","_tick","_delay"];

_vehicle = nearestObjects [(_this select 0), ["Air", "Car", "Ship"], 25];
if (count _vehicle == 0) exitWith { hint "No vehicles found within 25 metres!"; };
_vehicle = _vehicle select 0;
_vehCheck = false;
if(!(_vehicle in life_vehicles)) then {
	_action = ["The closest vehicle does not appear to be yours, continue anyway?","Warning","Yes","No"] call BIS_fnc_guiMessage;
	if(!_action) then {_vehCheck = true};
};
if(_vehCheck) exitWith {};
if (isEngineOn _vehicle) exitWith { hint "Turn off your vehicle before refuelling!" };

_capacity = getNumber(configFile >> "CfgVehicles" >> typeOf _vehicle >> "fuelCapacity");

_litres = 0;
_cost = 0;
_level = fuel _vehicle;
_tax = (life_rules select 1) / 50;
_taxamt = 0;
_delay = 0.5;
if (_vehicle isKindOf "Air") then { _delay = _delay / 3; };

while {_level < 1} do
{
	sleep _delay;
	if (speed player > 1) exitWith {};
	if (player distance (_this select 0) > 5) exitWith {};
	
	_litres = _litres + 1;
	_taxamt = _taxamt + (5 * _tax);
	_cost = _cost + (5 * (1 + _tax));
	if (life_myFunds < _cost) exitWith {};
	
	_tick = 1 / _capacity;
	_level = _level + _tick;
	if (_level > 1) then { _level = 1; };
	
	hintSilent parseText format["<t color='#cec25b'>Litres:</t> %1<br/><t color='#cec25b'>Fuel Tax:</t> %5%4<br/><t color='#cec25b'>Cost:</t> $%2<br/><t color='#cec25b'>Filled:</t> %3%4", _litres, [_cost] call life_fnc_numberText, floor (_level * 100), "%", (life_rules select 1) * 2];
};

hintSilent parseText format["<t color='#cec25b'>Litres:</t> %1<br/><t color='#cec25b'>Fuel Tax:</t> %5%4<br/><t color='#cec25b'>Cost:</t> $%2<br/><t color='#cec25b'>Filled:</t> %3%4<br/><br/><t color='#00FF00'>Refueling completed</t>", _litres, [_cost] call life_fnc_numberText, floor (_level * 100), "%", (life_rules select 1) * 2];

if(!local _vehicle) then
{
	[_vehicle,_level] remoteExecCall ["life_fnc_setFuel",_vehicle];
}
else
{
	_vehicle setFuel _level;
};
_cost = round (_cost);
_taxamt = round (_taxamt);
if(playerSide != independent) then {
	["atm","take",_cost] call life_fnc_handlePaper;
	[_taxamt] remoteExecCall ["life_fnc_updateGovBank",2];
};