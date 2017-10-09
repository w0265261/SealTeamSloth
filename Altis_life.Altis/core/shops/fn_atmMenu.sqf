#include <macro.h>
/*
	File: fn_atmMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Opens and manages the bank menu.
*/
private["_display","_text","_units","_type","_spotted","_msg"];
life_gov = if(typeName _this == "BOOL") then {true} else {false};
_firstOpen = false;

if(!life_use_atm) exitWith
{
	hint localize "STR_Shop_ATMRobbed";
};

if(!dialog) then
{
	createDialog "STS_Life_atm_management";
	_firstOpen = true;
};

disableSerialization;

_display = findDisplay 2700;
_text = _display displayCtrl 2701;
_units = _display displayCtrl 2703;
if(!life_gov) then {
	if(_firstOpen) then {
		life_bankWaiting = true;
		player remoteExecCall ["fnc_querybank",2];
		_text ctrlSetStructuredText parseText format["<img align='left' size='1.7' image='icons\bank.paa'/><t align='left'> %1</t>
		<img align='right'size='1.6' image='icons\money.paa'/><t align='right'> %2</t>",
		"Please wait...",[life_handpaper] call life_fnc_numberText];
		_text spawn {
			disableSerialization;
			waitUntil{isNil "life_bankWaiting"};
			_this ctrlSetStructuredText parseText format["<img align='left' size='1.7' image='icons\bank.paa'/><t align='left'> %1</t>
			<img align='right'size='1.6' image='icons\money.paa'/><t align='right'> %2</t>",
			[life_myfunds] call life_fnc_numberText,[life_handpaper] call life_fnc_numberText];
		};
	} else {
		_text ctrlSetStructuredText parseText format["<img align='left' size='1.7' image='icons\bank.paa'/><t align='left'> %1</t>
		<img align='right'size='1.6' image='icons\money.paa'/><t align='right'> %2</t>",
		[life_myfunds] call life_fnc_numberText,[life_handpaper] call life_fnc_numberText];
	};
} else {
	_text ctrlSetStructuredText parseText format["<img align='left' size='1.7' image='icons\bank.paa'/><t align='left'> %1</t>
	<img align='right' size='1.6' image='icons\money.paa'/><t align='right'> %2</t>",
	[gov_bank] call life_fnc_numberText,[life_handpaper] call life_fnc_numberText];
};
if(life_gov) then {_units ctrlShow false} else {
	lbClear _units;

	{
		if(alive _x) then
		{
			switch (side _x) do
			{
				case west: {if(_x getVariable["undercover",false]) then {_type = "Civ"} else {_type = "Cop"};};
				case civilian: {_type = "Civ"};
				case independent: {_type = "EMS"};
			};
			_units lbAdd format["%1 (%2)",_x getVariable["realname",name _x],_type];
			_units lbSetData [(lbSize _units)-1,str(_x)];
		};
	} foreach playableUnits;

	lbSetCurSel [2703,0];
};
if(group player getVariable["gang_bank",-1] == -1 || life_gov) then {
	(getControl(2700,2705)) ctrlEnable false;
};
if(playerSide != civilian || life_gov) then { ctrlShow[2705,false]; };
[] spawn
{
waitUntil{!dialog};
if(life_wanted && !((player distance (getPos reb_1) < 25) || (player distance (getPos reb_1_2) < 25) || (player distance (getPos reb_1_1) < 25))) then {
_msg = format["The fugitive known as %1 was logged using an ATM at the below coordinates. Check the map for details.",profileName];
_spotted = random 100;
if(_spotted <= 15 && playerSide == civilian) then {
	[player,1] remoteExec ["life_fnc_breakInMarker",0]; 
	[_msg] call fnc_cell_textcop;
	sleep 0.05;
	hintSilent "";
	};
};
};