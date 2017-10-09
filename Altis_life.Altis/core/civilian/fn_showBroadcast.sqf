/*
	File: fn_showBroadcast.sqf
	Author: John "Paratus" VanderZwet
	Edited by: Kevin
	Description:
	AAN world news broadcast
*/

disableserialization;

_headline = _this select 0;
_message = _this select 1;
_from = _this select 2;

70 cutrsc ["rscAAN","plain"];
_display = uinamespace getvariable "BIS_AAN";
_textHeader = _display displayctrl 3001;
//Following code added by Kevin
_out = format["<t size='2'>%1</t><br />Brought to you by %2", _headline, name _from];
if(side _from == west) then { _out = _out + " of the Altis Law Enforcement"} else {
	if(group _from getVariable["gang_name",""] != "") then {
		_out = _out + format[" of the gang %1",group _from getVariable "gang_name"];
	};
};
_textHeader ctrlsetstructuredtext parseText _out;
_textHeader ctrlcommit 0;

_textLine = _display displayctrl 3002;
_textLine ctrlsetstructuredtext parseText format["              %1          %1",_message];
_textLine ctrlcommit 0;
_textLinePos = ctrlposition _textLine;
_textLinePos set [0,-100];
_textLine ctrlSetPosition _textLinePos;
_textLine ctrlcommit 1500;

_textClock = _display displayctrl 3003;
_textClock ctrlsettext ([daytime,"HH:MM"] call bis_fnc_timetostring);
_textClock ctrlcommit 0;

sleep 20;
70 cutText ["", "plain"];