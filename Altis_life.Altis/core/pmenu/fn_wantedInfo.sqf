/*
	File: fn_wantedInfo.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Pulls back information about the wanted criminal.
*/
private["_display","_list","_crimes","_bounty","_mylist"];
disableSerialization;
_isDetailed = param[0,false];
_display = findDisplay 2400;
_list = _display displayCtrl 2402;
_data = lbData[2401,(lbCurSel 2401)];
_mylist = [];
_data = call compile format["%1", _data];
lbClear _list;
if(isNil "_data") exitWith {_list lbAdd "Failed to fetch crimes";};
if(typeName _data != "ARRAY") exitWith {_list lbAdd "Failed to fetch crimes";};
if(count _data == 0) exitWith {_list lbAdd "Failed to fetch crimes";};
if(count _data == 3) exitWith {
	//begin mega switch statement because I couldn't think of a better way
	_details = _data select 0;
	if(count _details == 0) exitWith {_list lbAdd "No extra details"};
	switch(_data select 1) do {
		case "Murder": {_list lbadd format["Victim: %1",_details select 0]; _list lbadd format["Location: %1",_details select 1]; _list lbAdd format["Death by %1",_details select 2]};
		case "Murder of an Officer": {_list lbadd format["Victim: %1",_details select 0]; _list lbadd format["Location: %1",_details select 1]; _list lbAdd format["Death by %1",_details select 2]};
		case "Kidnapping": {_list lbadd format["Victim: %1",_details select 0]; _list lbadd format["Location: %1",_details select 1]};
		case "Mugging": {_list lbadd format["Victim: %1",_details select 0]; _list lbadd format["Location: %1",_details select 1]};
		case "Armed Robbery": {_list lbadd format["The gas station clerk at %1",_details select 1]; _list lbadd format["was questioned by %1",_details select 0]; _list lbadd format["Weapon used in robbery: %1",_details select 2];};
		case "Assault with Firearm": {_list lbadd format["Victim: %1",_details select 0]; _list lbadd format["Location: %1",_details select 1]; _list lbAdd format["Weapon used: %1",([_details select 2] call life_fnc_fetchCfgDetails) select 1]};
		case "Firing on an Officer": {_list lbadd format["Victim: %1",_details select 0]; _list lbadd format["Location: %1",_details select 1]; _list lbAdd format["Weapon used: %1",([_details select 2] call life_fnc_fetchCfgDetails) select 1]};
		case "Breaking and Entering": {_list lbadd format["Victim: %1's house",_details select 0]; _list lbadd format["Location: %1",_details select 1]; _list lbAdd format["Tool used: %1",_details select 2]};
		case "Hit and run": {_list lbadd format["Victim: %1",_details select 0]; _list lbadd format["Location: %1",_details select 1]; _list lbAdd format["Vehicle used: %1",_details select 2]};
		case "Search Warrant - Alcohol": {_list lbAdd format["Moonshine dealer questioned by %1",_details select 0]};
		case "GTA": {_list lbadd format["Victim: %1's %2",_details select 0,_details select 2]; _list lbadd format["Location: %1",_details select 1]};
		case "Supplying Chop Shop": {_list lbadd format["Victim: %1's %2",_details select 0,_details select 2]; _list lbadd format["Location: %1",_details select 1]};
		case "Possession": {_list lbadd format["Searched by: %1",_details select 0]; _list lbadd format["Location: %1",_details select 1]; _list lbAdd format["Found: %1",_details select 2]};
		case "Felony Possession": {_list lbadd format["Searched by: %1",_details select 0]; _list lbadd format["Location: %1",_details select 1]; _list lbAdd format["Found: %1",_details select 2]};
		case "Search Warrant - Drugs": {_list lbadd format["Dealer at %1 questioned by %2",_details select 1,_details select 0]};
		case "Aiding Escape": {_list lbadd format["%1 was freed",_details select 0]; _list lbadd format["Location: %1",_details select 1]};
		case "Presidential Assassination": {_list lbadd format["Victim: %1",_details select 0]; _list lbadd format["Location: %1",_details select 1]; _list lbAdd format["Weapon used: %1",([_details select 2] call life_fnc_fetchCfgDetails) select 1]};
		case "Poaching": {_list lbAdd format["Wildlife dealer questioned by %1",_details select 0]};
		default {_list lbadd format["Charged by %1",_details select 0]};
	};
};
_crimes = _data select 2;
_bounty = _data select 3;

if(_isDetailed) exitWith {
	if(lbCurSel 2401 == -1) exitWith {hint localize "STR_Global_NoSelection"};
	_list = _display displayctrl 2401;
	lbClear _list;
	((findDisplay 2400) displayCtrl 2403) ctrlSetStructuredText parseText format ["%1",_data select 0];
	{
		_crime = _x select 0;
		_list lbAdd format["%1",_crime];
		_list lbSetData [(lbSize _list)-1,str[(_x select 1),_crime,_data select 1]];
	} foreach _crimes;
};
((findDisplay 2400) displayCtrl 2403) ctrlSetStructuredText parseText format ["$%1", [_bounty] call life_fnc_numberText];
{
	_crime = _x select 0;
	_list lbAdd format["%1",_crime];
} foreach _crimes;