_query = "SELECT list FROM zones WHERE id = '1'";

_queryResult = [_query,2] call DB_fnc_asyncCall;
life_capture_list = _queryResult select 0;
capture_1_active = false;
capture_2_active = false;
capture_3_active = false;
capture_4_active = false;
publicVariable "life_capture_list";
{
if((life_capture_list select _x) select 2 >= 0.99) then {
	_string = (life_capture_list select _x) select 0;
	_marker = format["capture_label_%1",(_x + 1)];
	_marker setMarkerText format["%1 - %2",(life_capture_list select _x) select 1,_string];
};
} forEach [0,1,2,3];
KBW_fnc_handleCapture = {
	private["_zone","_point","_var"];
	_zone = param[0];
	_point = param[1];
	_var = format["capture_%1_active",_point + 1];
	if(missionNameSpace getVariable _var) exitWith {};
	missionNameSpace setVariable[_var,true];
	while{count list _zone > 0} do {
		_groupsArr = [];
		uiSleep 25;
		_units = list _zone; //Total units inside the zone
		if(count _units == 0) exitWith {};
		_nonUnits = [];
		{if(!isPlayer _x || (((group _x) getVariable["gang_name",""]) == "") || (_x getVariable["unconscious",false]) || (_x getVariable["zipTie",false]) || ((primaryWeapon _x == "") && (handgunWeapon _x == ""))) then {_nonUnits pushBack _x};} forEach _units; //Remove non-units and non-gang players
		_units = _units - _nonUnits;
		//begin gathering information on different groups in the zone
		while {count _units > 0} do {
			_GroupName = (group (_units select 0)) getVariable["gang_name",""];
			if(_GroupName != "") then {
				_Groupunits = units (_units select 0);
				_GroupCount = count _Groupunits;
				_units = _units - _Groupunits;
				_groupsArr pushBack [_GroupName,_GroupCount];
			};
		};
		if(count _groupsArr == 0) exitWith {};
		highest = ((_groupsArr select 0) select 0);
		_highNum = ((_groupsArr select 0) select 1);
		for [{_x=0},{_x < count _groupsArr},{_x=_x+1}] do
		{
			if((_groupsArr select _x) select 1 > _highNum) then {
				highest = ((_groupsArr select _x) select 0);
				_highNum = ((_groupsArr select _x) select 1);
			};
		};
		{if(_highNum == (_x select 1) && highest != (_x select 0)) exitWith {highest = "";};} forEach _groupsArr; //Check that 2 groups didn't tie in units
		
		if(highest != "") then {
			toModify = life_capture_list select _point;
			if((toModify) select 0 == "Contested") then {
				toModify set[0,highest];
				toModify set[2,0.05];
			} else {
				if((highest == (toModify select 0)) && !((toModify select 2) >= 0.99)) then {
					toModify set[2,((toModify select 2) + 0.05)];
					if((toModify select 2) >= 0.99) then {
						toModify set[2,1];
						_winners = [];
						{if(group _x getVariable["gang_name",""] == (toModify select 0)) then {_winners pushBack _x}} forEach playableUnits;
						{[toModify select 1,true] remoteExec ["life_fnc_capNotice",_x,false]} forEach _winners;
						[0,format["The gang known as %1 has successfully captured the %2!",(toModify select 0),(toModify select 1)]] remoteExec ["life_fnc_broadcast",0];
					};
				} else {
					if(highest != (toModify select 0) && !((toModify select 2) <= 0.01)) then {
						toModify set[2,((toModify select 2) - 0.05)];
						_group = grpNull;
						{if((toModify select 0) == (_x getVariable["gang_name",""])) exitWith {_group = _x}} forEach allGroups;
						if(!isNull _group) then { {[toModify select 1,false,highest] remoteExec ["life_fnc_capNotice",_x,false];} forEach (units _group); };
					};
				};
			};
			if(toModify select 2 <= 0.01) then {toModify set[0,"Contested"]; toModify set[2,0]};
			life_capture_list set[_point,toModify];
			publicVariable "life_capture_list";
			[] spawn {
				_query = format["UPDATE zones SET list='%1' WHERE id='1'",life_capture_list];
				[_query,1] call DB_fnc_asyncCall;
			};
			{if(isPlayer _x) then {[] remoteexec ["life_fnc_updateCaptureUI",_x]};} forEach (list _zone);
		};
		_marker = format["capture_label_%1",(_point + 1)];
		_string = "";
		if(((life_capture_list select _point) select 2) >= 0.99) then {
			_string = (life_capture_list select _point) select 0;
		} else {
			_string = "Contested";
		};
		_name = switch((life_capture_list select _point) select 1) do {
			case "Arms Dealer": {format["Arms Dealer - %1",_string]};
			case "Cocaine Cartel": {format["Cocaine Cartel - %1",_string]};
			case "Meth Cartel": {format["Meth Cartel - %1",_string]};
			case "Heroin Cartel": {format["Heroin Cartel - %1",_string]};
		};
		_marker setMarkerText format["%1",_name];
	};
	missionNameSpace setVariable[_var,false];
};