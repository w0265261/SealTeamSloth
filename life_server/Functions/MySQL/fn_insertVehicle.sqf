/*
	File: fn_insertVehicle.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Inserts the vehicle into the database
*/
private["_uid","_side","_type","_className","_color","_plate","_query","_sql"];
_uid = param [0,"",[""]];
_side = param [1,"",[""]];
_type = param [2,"",[""]];
_className = param [3,"",[""]];
_color = param [4,-1,[0]];
_plate = param [5,-1,[0]];
_stolen = param [6,0,[0]];
_craft = param [7,false,[false]];
_active = if(_craft) then {0} else {1};
/*Stop bad data being passed.*/
if(_uid == "" OR _side == "" OR _type == "" OR _className == "" OR _color == -1 OR _plate == -1) exitWith {};
if(_stolen == 0) then {
_query = format["INSERT INTO vehicles (side, classname, type, pid, alive, active, inventory, color, plate, stolen, virtItems,position) VALUES ('%1', '%2', '%3', '%4', '1','%8','[]', '%5', '%6', '%7', '[]','[]')",_side,_className,_type,_uid,_color,_plate,_stolen,_active];
};
if(_stolen == 1) then {
_query = format["INSERT INTO vehicles (side, classname, type, pid, alive, active, inventory, color, plate, stolen, virtItems,position) VALUES ('%1', '%2', '%3', '%4', '1','0','[]', '%5', '%6', '%7', '[]','[]')",_side,_className,_type,_uid,_color,_plate,_stolen];
};

[_query,1] call DB_fnc_asyncCall;