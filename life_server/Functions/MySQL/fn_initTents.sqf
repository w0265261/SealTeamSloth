/*
	Author: Raku @ Veterans of Altis
	
	Description:
	Sets up tents on the map
*/
private["_tickTime","_queryResult","_query"];
_query = format["SELECT type, position, pid FROM tents WHERE alive=1"];
_queryResult = [_query,2,true] call DB_fnc_asyncCall;
 
{
	_type = _x select 0;
	_position = _x select 1;
 
	_height = [5,5,-5.45,5];
	
	_tent = createVehicle [_type, [1.6650946,1.6626484,_height select 0], [], 0, "CAN_COLLIDE"];
	_tent setDir 90;
	_chair = createVehicle ["Land_CampingChair_V1_F", [3.2369072,2.8136106,_height select 1], [], 0, "CAN_COLLIDE"];
	_fire = createVehicle ["Land_FirePlace_F", [2.5509803,3.8476455,_height select 2], [], 0, "CAN_COLLIDE"];
	_light = createVehicle ["Land_Camping_Light_off_F", [0.98040187,3.285964,_height select 3], [], 0, "CAN_COLLIDE"];
	_tent allowDamage false;
	_chair allowDamage false;
	_fire allowDamage false;
	_light allowDamage false;
	sleep 0.3;
	_chair attachTo [_tent];
	_fire attachTo [_tent];
	_light attachTo [_tent];
	_tent setDir (floor (random 360));		
	_tent setPos (_position);
	_chair setDir (+63.3056);
	_chair setPos (getPos _chair);
	_fire setPos (getPos _fire);
	_light setPos (getPos _light);
	
	_tent setVariable["pid",_x select 2,true];
} foreach _queryResult;