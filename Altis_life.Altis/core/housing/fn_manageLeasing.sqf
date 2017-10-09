/*
	Author: Pennyworth
	
	Description:
	Manages adding and removing house leasers
*/
private["_type","_house","_leasers","_exit","_dialog","_list","_plist","_sel","_player"];

disableSerialization;
_type = param [0,0,[0]];
_house = nearestBuilding (getPosATL player);
if(!(_house in life_vehicles)) exitWith {hint localize "STR_ISTR_Box_NotinHouse"};
_leasers = _house getVariable["leasers",[]];
_exit = false;

switch (_type) do {
	case 0: { /*remove*/
		_dialog = findDisplay 2700;
		_list = _dialog displayCtrl 2701;
		_plist = _dialog displayCtrl 2702;

		_sel = lbCurSel _list;
		_player = _list lbData _sel;
		_player = _leasers select parseNumber(_player);
		_uid = _player select 0;
		_unit = ObjNull;
		{if(getPlayerUID _x == _uid) then {_unit = _x;}; if(!isNull _unit) exitWith {}; } forEach playableUnits;
		if(!isNull _unit) then {
			[_house] remoteExec ["life_fnc_houseKeyDrop",_unit];
		};
		_leasers = _leasers - [[_player select 0,_player select 1]];
		
		_house setVariable["leasers",_leasers,true];		
		[_house,_leasers] remoteExec ["TON_fnc_updateLeasers",2];	
		[] spawn life_fnc_leaseMenu;
	};
	
	case 1: { /*add*/
		_dialog = findDisplay 2700;
		_plist = _dialog displayCtrl 2702;

		_sel = lbCurSel _plist;
		_unit = _plist lbData _sel;
		_unit = call compile format["%1", _unit];
		if(isNull _unit OR isNil "_unit") exitWith {};
		if(side _unit != civilian) exitWith { hint "You may only add civilians to your lease."};
		_type = typeOf _house;
		switch (true) do {
			case (_type in ["Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F"]): {
				if(count _leasers >= 3) exitWith {
					hint "You may only have 3 leasers for this building.";
					_exit = true;
				}			
			};
			case (_type in ["Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V3_F"]): {
				if(count _leasers >= 3) exitWith {
					hint "You may only have 3 leasers for this building.";
					_exit = true;					
				}
			};
			case (_type in ["Land_i_House_Big_01_V2_F"]): {
				if(count _leasers >= 3) exitWith {
					hint "You may only have 3 leasers for this building.";
					_exit = true;					
				}			
			};
			case (_type in ["Land_i_House_Small_01_V1_F","Land_i_House_Small_01_V2_F","Land_i_House_Small_01_V3_F"]): {
				if(count _leasers >= 1) exitWith {
					hint "You may only have 1 leasers for this building.";
					_exit = true;										
				}
			};
			case (_type in ["Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F"]): {
				if(count _leasers >= 1) exitWith {
					hint "You may only have 1 leasers for this building.";
					_exit = true;					
				}
			};
			case (_type in ["Land_i_House_Small_03_V1_F"]): {
				if(count _leasers >= 2) exitWith {
					hint "You may only have 2 leasers for this building.";
					_exit = true;					
				}			
			};
			case (_type in ["Land_i_Stone_HouseSmall_V2_F","Land_i_Stone_HouseSmall_V1_F","Land_i_Stone_HouseSmall_V3_F"]): {
				if(count _leasers >= 1) exitWith {
					hint "You may only have 1 leasers for this building.";
					_exit = true;					
				}					
			};
			case (_type in ["Land_i_Shed_Ind_F"]): {
				if(count _leasers >= 6) exitWith {
					hint "You may only have 6 leasers for this building.";
					_exit = true;					
				}
			};
			case (_type in ["Land_i_Garage_V1_F","Land_i_Garage_V2_F"]): {
				if(count _leasers >= 1) exitWith {
					hint "You may only have 1 leasers for this building.";
					_exit = true;					
				}
			};
		};

		if(isNil "_unit") exitWith {};
		_uid = getPlayerUID _unit;
		
		{
			if(_x select 0 == _uid) exitWith { hint format["%1 is already leasing",name _unit]; _exit = true;};
		} forEach _leasers;
		if(_exit) exitWith {};
		hint format["You have given %1 keys to your house.",_unit getVariable["realname",name _unit]];
		[_house,_unit,profileName] remoteExec ["clientGetKey",_unit];
		
		_leasers pushback [_uid,name _unit];
		_house setVariable["leasers",_leasers,true];
		[_house,_leasers] remoteExec ["TON_fnc_updateLeasers",2];
		[] spawn life_fnc_leaseMenu;
	};
};

