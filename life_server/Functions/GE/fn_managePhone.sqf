/*
fn_managePhone.sqf
Kevin Webb
For creating and managing new radio channels spawned from phone calls.
*/
_caller = param[0];
_target = param[1];
_units = [_caller,_target];
_isDelete = param[2];
if(_isDelete) exitWith {
	_channel = param[3];
	missionNameSpace setVariable[format["cell_%1_active",_channel + 5],false];
	_units = missionNameSpace getVariable format["radio_units_%1",_channel];
	missionNameSpace setVariable [format["radio_units_%1",_channel],[]];
	_channel radioChannelRemove _units;
	life_phone_channel = -1;
	{
		_id = owner _x;
		_id publicVariableClient "life_phone_channel";
	} forEach _units;
};
if(isNil "cell_15_active") then {
	life_phone_channel = radioChannelCreate [[1, 0, 1, 0.5], "Phone Call", "%UNIT_NAME", _units];
} else {
	life_phone_channel = switch(true) do {
		//case (!cell_8_active): {3};
		case (!cell_9_active): {4};
		case (!cell_10_active): {5};
		case (!cell_11_active): {6};
		case (!cell_12_active): {7};
		case (!cell_13_active): {8};
		case (!cell_14_active): {9};
		case (!cell_15_active): {10};
		default {-1};
	};
	life_phone_channel radioChannelAdd _units;
};
if(life_phone_channel == -1) exitWith {[2,"All phone lines are currently in use, try again later"] remoteExecCall ["life_fnc_broadcast",_units]; ["life_phone_status",0] remoteExecCall ["life_fnc_netSetVar",_units]};
missionNameSpace setVariable[format["cell_%1_active",life_phone_channel + 5],true];
missionNameSpace setVariable[format["radio_units_%1",life_phone_channel],_units];
{
	_id = owner _x;
	_id publicVariableClient "life_phone_channel";
} forEach _units;