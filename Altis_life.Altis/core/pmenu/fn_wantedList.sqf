/*
	Copyright © 2013 Bryan "Tonic" Boardwine, All rights reserved
	See http://armafiles.info/life/list.txt for servers that are permitted to use this code.
	File: fn_wantedList.sqf
	Author: Bryan "Tonic" Boardwine"
	
	Description:
	Displays wanted list information sent from the server.
*/
private["_display","_list","_units","_entry"];
disableSerialization;
_display = findDisplay 2400;
_list = _display displayctrl 2401;
lbClear _list;
{
	_entry = _x;
	_list lbAdd format["%1", _entry select 0];
	_list lbSetData [(lbSize _list)-1,str(_entry)];
} foreach life_wanted_list;

/*ctrlSetText[2404,"Connection Established"];*/
((findDisplay 2400) displayCtrl 2404) ctrlSetStructuredText parseText "Connection Established";

if(((lbSize _list)-1) == -1) then
{
	_list lbAdd "No criminals";
};