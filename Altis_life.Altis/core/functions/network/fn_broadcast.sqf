#include <macro.h>
/*
	File: fn_broadcast.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Broadcast system used in the life mission for multi-notification purposes.
*/
private["_type","_message"];
_type = param [0,0,[[],0]];
_message = param [1,"",[""]];
if(_message == "") exitwith {};

if(typeName _type == typeName []) then
{
	for "_i" from 0 to (count _type)-1 do
	{
		switch((_type select _i)) do
		{
			case 0: {systemChat _message};
			case 1: {hint format["%1", _message]};
			case 2: {titleText[format["%1",_message],"PLAIN"];};
			case 3: { 
				if(__GETC__(style) < 1) exitWith {}; 
				systemChat _message; 
			};
			case 4: {hintSilent format["%1", _message]};
			case 5: {hint parseText format["%1", _message]};
		};
	};
}
	else
{
	switch (_type) do
	{
		case 0: {systemChat _message};
		case 1: {hint format["%1", _message]};
		case 2: {titleText[format["%1",_message],"PLAIN"];};
		case 3: {
			if(__GETC__(style) < 1) exitWith {}; 
			systemChat _message; 
		};
		case 4: {hintSilent format["%1", _message]};
		case 5: {hint parseText format["%1", _message]};
	};
};