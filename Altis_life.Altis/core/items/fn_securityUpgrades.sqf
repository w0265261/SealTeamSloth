/*
	Author: Pennyworth
	
	Description:
	Tries to upgrade the security level of the nearest house.
*/
private["_house","_security","_item"];

_item = _this select 0;
_house = nearestBuilding (getPosATL player);
if(!(_house in life_vehicles)) exitWith {hint localize "STR_ISTR_Box_NotinHouse"};
_security = _house getVariable["security",0];

switch (_item) do {	
	case "alarm": {
		if(_security > 0) exitWith {hint "You already have an alarm system installed in your home."};
		_house setVariable["security",1, true];
		[_house,1] remoteExec ["TON_fnc_updateSecurity",2];			
		hint "You have successfully installed an alarm system in your home! You will be notified at an attempt of a break in via text message.";
		[false,_item,1] call life_fnc_handleInv;	
	};
	
	case "reinforceddoor": {
		if(_security == 0) exitWith {hint "You don't have the correct prerequisite installed."};
		if(_security > 1) exitWith {hint "You already have reinforced doors installed in your home."};
		_house setVariable["security",2, true];
		[_house,2] remoteExec ["TON_fnc_updateSecurity",2];			
		hint "You have successfully installed reinforced doors in your home! Intruders will now have a lower chance of being able to unlock the door.";
		[false,_item,1] call life_fnc_handleInv;	
	};
	
	case "steeldoor": {
		if(_security < 2) exitWith { hint "You don't have the correct prerequisite installed."};	
		if(_security == 3) exitWith { hint "You already have steel doors installed in your home."};
		_house setVariable["security",_security +1, true];
		[_house,3] remoteExec ["TON_fnc_updateSecurity",2];			
		hint "You have successfully installed steel doors in your home! Intruders will now need a blasting charge in order to open your doors.";		
		[false,_item,1] call life_fnc_handleInv;	
	};
};