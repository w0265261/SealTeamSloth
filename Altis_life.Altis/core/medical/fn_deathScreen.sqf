/*
	File: fn_deathScreen.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Handles stuff being displayed on the death screen while
	it is currently active.
*/
private["_medicsOnline","_bool","_nearestUI","_dist","_nearest","_nearestdist"];
disableSerialization;
_bool = 0;
_medicsOnline = ((findDisplay 7300) displayCtrl 7304);
_nearestUI = ((findDisplay 7300) displayCtrl 7307);

waitUntil {
	_nearest=objNull;
	_nearestdist=50000;
	_nearby = if(([independent,getPosATL player,1000] call life_fnc_nearUnits)) then {"Yes"} else {"No"};
	{
		_dist=vehicle _x distance player;
		if (_dist < _nearestdist && side _x == independent && !(_x getVariable ["unconscious",false])) then {
			_nearest=_x;
			_nearestdist=_dist;
		};
	} forEach playableUnits;
	switch (true) do {
		case (!isNull _nearest): 				{ _nearestUI ctrlSetText format["Closest medic: %1m",floor _nearestdist]; };
		default 								{ _nearestUI ctrlSetText ""; };
	};
	_medicsOnline ctrlSetText format[localize "STR_Medic_Online",playersNumber independent];

	if(player getVariable["restrained",false] || player getVariable["zipTie",false] || _bool < 30) then { ctrlEnable[7302,false]; } else { ctrlEnable[7302,true]; };
	sleep 1;
	_bool = _bool + 1;
	(isNull (findDisplay 7300) || !(player getVariable["unconscious",false]) || !alive player)
};