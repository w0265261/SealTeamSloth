#include <macro.h>
/*

	file: fn_smartphone.sqf
	Author: Silex
	
*/
private["_display","_units","_type","_data","_rowData","_msg"];
_type = param [0,0];
_data = param [1,0,["",[],0]];
if(!("ItemRadio" in (assignedItems  player)) && (__GETC__(style) < 1)) exitWith {hint "You don't have a Cellphone"; closeDialog 0;};
if((player getVariable["restrained",false] || player getVariable["zipTie",false]) && (__GETC__(style) < 1)) exitWith { hint "You wish you could text behind your back, but you just don't have the necessary skill set!"; closeDialog 0; };

disableSerialization;

//waitUntil {!isNull findDisplay 88888};

_display = findDisplay 88888;
_cPlayerList = _display displayCtrl 88881;
_cMessageList = _display displayCtrl 88882;
_cMessageHeader = _display displayCtrl 88886;
_cMessageHeader ctrlSetText format["From:                 Message:"];
ctrlEnable[887892,false];
switch(_type) do
{
	case 0:
	{
		_playableUnits = [];
		_under = [];
		{if(!(_x getVariable["undercover",false])) then {_playableUnits pushBack _x} else {_under pushBack _x};} forEach playableUnits;
		{_playableUnits pushBack _x} forEach _under;
		lbClear _cPlayerList;
		{
			if(alive _x && _x != player) then
			{
				if(_x getVariable["undercover",false]) then {_type = "Civ"} else {
				_type = switch(side _x) do
				{
					case west: {"Cop"};
					case civilian: {"Civ"};
					case independent: {"Med"};
				};
				};
				_cPlayerList lbAdd format["%1 (%2)",_x getVariable["realname", name _x],_type];
				_cPlayerList lbSetData [(lbSize _cPlayerList)-1,str(_x)];
			};
		} forEach _playableUnits;
		
		{[1,_x] call life_fnc_smartPhone} forEach life_messages;
		ctrlEnable[887892,false];
	};
	case 1:
	{
		_msg = [_data select 2,40] call KRON_StrLeft;
		_rowData = [_data select 0, _data select 1, _data select 2, _data select 3];
		_cMessageList lnbAddRow[_data select 3,format["%1 ...",_msg]];
		_cMessageList lnbSetData[[((lnbSize _cMessageList) select 0)-1,0],str(_rowData)];
	};
	case 2:
	{
		ctrlEnable[887892,true];
		_target = lbData[88881,(lbCurSel 88881)];
		life_smartphoneTarget = call compile format["%1",_target];
	};
	
	case 4:
	{
		createDialog "STS_Life_smartphone_schreiben";
		ctrlSetText[88886,"Message to target"];
		if((__GETC__(style) < 1)) then
		{
			ctrlShow[888897,false];
		};
	};
};