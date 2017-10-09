/*
fn_fixBadOffers.qf
Kevin Webb
damned clogging of the exchange... should be fixed now
*/
_query = "SELECT ID,ClassName,isVirtual,isWeapon,isVehicle,Amount,pid,VehicleID FROM exchange WHERE timer>=167 AND BuyorSell=0 AND active=1";
_result = [_query,2,true] call DB_fnc_asyncCall;
_query = "UPDATE exchange SET active=0 WHERE timer>=167";
[_query,1] call DB_fnc_asyncCall;
{
_offer = _x;
_id = _offer select 0;
_class = _offer select 1;
_virt = _offer select 2;
_weapon = _offer select 3;
_vehicle = _offer select 4;
_amount = _offer select 5;
_uid = _offer select 6;
_veh = _offer select 7;
if(_vehicle == 1) then {
	_query = format["UPDATE vehicles SET listed=0 WHERE id=%1",_veh];
	[_query,1] call DB_fnc_asyncCall;
};
if(_weapon == 1) then {
	_query = format["SELECT mailbox FROM players WHERE playerid='%1'",_uid];
	_box = [_query,2] call DB_fnc_asyncCall;
	_box = _box select 0;
	_class pushBack (floor(random 10000));
	_box pushBack _class;
	_query = format["UPDATE players SET mailbox='%1' WHERE playerid='%2'",_box,_uid];
	[_query,1] call DB_fnc_asyncCall;
};
if(_virt == 1) then {
	_query = format["SELECT mailbox FROM players WHERE playerid='%1'",_uid];
	_box = [_query,2] call DB_fnc_asyncCall;
	_box = _box select 0;
	_checkForExisting = false;
	{if(_class == (_x select 0)) exitWith{_checkForExisting = true; _box set[_forEachIndex,[_x select 0,(_x select 1) + _amount,(floor(random 10000))]]};} foreach _box;
	if(!_checkForExisting) then {
		_box pushBack [_class,_amount,(floor(random 10000))];
	};
	_query = format["UPDATE players SET mailbox='%1' WHERE playerid='%2'",_box,_uid];
	[_query,1] call DB_fnc_asyncCall;
};
} forEach _result;

//check if governor is ready to be elected
_query = "SELECT time FROM rules";
_result = [_query,2] call DB_fnc_asyncCall;
if((_result select 0) >= 119) then {
	_query = "UPDATE players SET voted=0";
	[_query,1] call DB_fnc_asyncCall;
	_query = "SELECT name,uid FROM politics ORDER BY votecount DESC";
	_result = ([_query,2,true] call DB_fnc_asyncCall) select 0;
	_name = _result select 0;
	_winner = _result select 1;
	_query = format["UPDATE rules SET uid='%1', time=0, name='%2'",_winner,_name];
	[_query,1] call DB_fnc_asyncCall;
	_query = "CALL deleteCandidates";
	[_query,1] call DB_fnc_asyncCall;
};

_query = "SELECT uid,name,invest,policy FROM politics WHERE active=1";
life_run_data = [_query,2,true] call DB_fnc_asyncCall;
publicVariable "life_run_data";

_query = "Select uid,sales,fuel,weed,death,name,police,civilian FROM rules";
life_rules = ([_query,2] call DB_fnc_asyncCall);
life_rules set[3,([life_rules select 3,1] call DB_fnc_bool)];
life_rules set[4,([life_rules select 4,1] call DB_fnc_bool)];
[] spawn {
	waitUntil {!isNil "life_illegal_items"};
	life_rules call life_fnc_configChanged;
};