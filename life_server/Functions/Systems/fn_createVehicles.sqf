/*
fn_createVehicles.sqf
Kevin Webb
Attempts to set up previously active vehicles.
*/
_query = "UPDATE vehicles SET active=0 WHERE NOT side='civ'";
[_query,1] call DB_fnc_asyncCall;
_query = "SELECT vehicles.side, vehicles.classname, vehicles.pid, vehicles.plate, vehicles.color, vehicles.stolen, vehicles.inventory, vehicles.virtItems, vehicles.insured, vehicles.tracked, vehicles.alarm, vehicles.position, players.name, vehicles.fuel FROM vehicles INNER JOIN players ON vehicles.pid=players.playerid WHERE vehicles.active=1 AND vehicles.alive=1 AND vehicles.side='civ'";
_vInfo = [_query,2,true] call DB_fnc_asyncCall;
_toColor = [];
{
_vehicle = _x;
_position = _vehicle select 11;
if(count _position > 0) then {
_side = _vehicle select 0;
_class = _vehicle select 1;
_uid = _vehicle select 2;
_plate = _vehicle select 3;
_color = _vehicle select 4;
_stolen = _vehicle select 5;
_cargo = _vehicle select 6;
_virtItems = _vehicle select 7;
_insured = _vehicle select 8;
_tracker = _vehicle select 9;
_alarm = _vehicle select 10;
_name = _vehicle select 12;
_fuel = _vehicle select 13;
_object = _class createVehicle _position;
_object lock 2;
_toColor pushBack [_object,_color];;
_object setVariable["vehicle_info_owners",[[_uid,_name]],true];
_object setVariable["dbInfo",[_uid,_plate],true];
clearWeaponCargoGlobal _object;
clearMagazineCargoGlobal _object;
clearItemCargoGlobal _object;
_multi = false;
if(count _cargo > 2) then {
	_multi = true;
	_MagazineCount = count ((_cargo select 1) select 0);
	for "_i" from 0 to (_MagazineCount - 1) step 1 do
	{
		_arrayMagazine = ((_cargo select 1) select 0) select _i;
		_arrayMagazineCount = ((_cargo select 1) select 1) select _i;
		_object addMagazineCargoGlobal [_arrayMagazine,_arrayMagazineCount];
	};
	_WeaponCount = count ((_cargo select 2) select 0);
	for "_i" from 0 to (_WeaponCount - 1) step 1 do
	{
		_arrayWeapon = ((_cargo select 2) select 0) select _i;
		_arrayWeaponCount = ((_cargo select 2) select 1) select _i;
		_object addWeaponCargoGlobal [_arrayWeapon,_arrayWeaponCount];
	};
};
if(!_multi) then {
	_itemCount = count (_cargo select 0);
	for "_i" from 0 to (_itemCount - 1) step 1 do
	{
		_arrayItem = (_cargo select 0) select _i;
		_arrayItemCount = (_cargo select 1) select _i;
		_object addItemCargoGlobal [_arrayItem,_arrayItemCount];      
	};
} else {
	_itemCount = count ((_cargo select 0) select 0);
	for "_i" from 0 to (_itemCount - 1) step 1 do
	{
		_arrayItem = ((_cargo select 0) select 0) select _i;
		_arrayItemCount = ((_cargo select 0) select 1) select _i;
		_object addItemCargoGlobal [_arrayItem,_arrayItemCount];      
	};
};
[_object] call TON_fnc_clearAmmo;
if(_class == "I_MRAP_03_F") then { _object disableTIEquipment true; };
if(_class == "B_Heli_Light_01_F" && {typeName _color == "SCALAR"} && {_color != 13}) then
{
	[_object,"civ_littlebird",true] spawn life_fnc_vehicleAnimate;
};

if(_stolen == 1) then
{
	_object setVariable["stolen",true,true];
};
if(count _virtItems != 0) then {
	_object setVariable["trunk",_virtItems,true];
};
if(_insured == 1) then {
	_object setVariable["isInsured",true,true];
	[_object] spawn TON_fnc_vehicleInsurance;
};
if(_insured == 1 || _tracker == 1) then {
	_object setVariable["trackee",_uid,true];
};
if(_insured == 1 || _alarm == 1) then {
	_object setVariable["alarm",true,true];
};
_object setFuel _fuel;
};
} forEach _vInfo;
waitUntil{sleep 1; count playableUnits > 0};
{[_x select 0,_x select 1] remoteExec ["life_fnc_colorVehicle",0]} forEach _toColor;
call TON_fnc_saveVehicles;