/*
fn_changeWeather.sqf
Pennyworth
Changes the weather
*/
private["_type"];
_type = param [0,-1,[-1]];
closeDialog 0;
if(_type == 0) exitWith {
	120 setFog 0;
};
if(_type == 1) exitWith {
	120 setRain 0;
};
