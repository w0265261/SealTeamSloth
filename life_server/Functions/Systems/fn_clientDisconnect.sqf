/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	When a client disconnects this will remove their corpse and
	clean up their storage boxes in their house.
*/
private["_unit","_uid"];
_unit = _this select 0;
_uid = _this select 2;
//if(_unit == hc_1) exitWith {deleteVehicle _unit; life_HC_isActive = false; publicVariable "life_HC_isActive"};
if(isNil "_unit" || isNull _unit) exitWith {};
if(side _unit == independent) then {
	if((_unit getVariable ["unconscious",false]) && (_unit getVariable ["shotByCop",false])) then {
		[_uid] call life_fnc_wantedRemove;
	} else {
		[_uid,1] call life_fnc_wantedRemove;
	};
};
if(side _unit == civilian && (_unit getVariable ["unconscious",false])) then {
	[_uid,civilian,[],3] spawn DB_fnc_updatePartial;
	[_uid,civilian,0,0] spawn DB_fnc_updatePartial;
	if(_unit getVariable ["shotByCop",false]) then {
		[_uid] call life_fnc_wantedRemove;
	};
};
if(side _unit == civilian) then {
	[_uid,1] call life_fnc_wantedRemove;
	if(_unit distance (getMarkerPos "respawn_civilian") < 750 || _unit distance [0,0,0] < 300) exitWith {};
	[_uid,civilian,getPosATL _unit,4] spawn DB_fnc_updatePartial;
};
if(side _unit == west && (_unit getVariable ["unconscious",false])) then {
	[_uid,west,[],3] spawn DB_fnc_updatePartial;
	[_uid,west,0,0] spawn DB_fnc_updatePartial;
};
if(side _unit == west) then {
	for [{_i=1},{_i<=35},{_i=_i+1}] do {
		_var = format["locker_1_%1",_i];
		_box = missionNameSpace getVariable _var;
		if(_box getVariable["owner",""] == _uid) exitWith {
			_box setVariable["owner",nil,true];
		};
	};
};
_containers = nearestObjects[_unit,["WeaponHolderSimulated"],5];
{deleteVehicle _x;} forEach _containers;
//check if they were in an active phone call and free up the channel.
for "_i" from 4 to 10 do {
	_units = missionNameSpace getVariable [format["radio_units_%1",_i],[]];
	if(count _units > 0 && {_unit in _units}) exitWith {
		_i radioChannelRemove _units;
		missionNameSpace setVariable[format["cell_%1_active",_i + 5],false];
		missionNameSpace setVariable [format["radio_units_%1",_i],[]];
		life_phone_channel = -1;
		{
			if(isPlayer _x) then {
				_id = owner _x;
				_id publicVariableClient "life_phone_channel";
			};
		} forEach _units;
	};
};
deleteVehicle _unit;
{deleteVehicle _x;} forEach allDeadMen;
{
    if(count units _x == 0) then {
    deleteGroup _x;
    };
} forEach allGroups;