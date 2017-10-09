#include <macro.h>
/*
	File: fn_chargeAttempt.sqf
	Author: Kevin Webb

	Description:
	Charges the target remotely
*/
if(__GETC__(life_coplevel) < 3) exitWith {};

private["_unit","_param"];
_unit = lbData[1338,lbCurSel (1338)];
_unit = call compile format["%1", _unit];
if(isNil "_unit") exitwith {};
if(isNull _unit) exitWith {};
if(side _unit == west) exitWith {hint "You can't charge a Police Officer!";};
_param = param [0,0,[0]];
_code = "";
switch(_param) do
{
	case 0: 
	{
		_code = "Kev";
		titleText [format["You have charged %1 with attempted murder",_unit getVariable["realname",name _unit]],"PLAIN"];
		[0,format["%1 was charged with Attempted Murder by %2",_unit getVariable["realname",name _unit],profileName]] remoteExec ["life_fnc_broadcast",west];
	};
	case 1:
	{
		_code = "Dev";
		titleText [format["You have charged %1 with evading police.",_unit getVariable["realname",name _unit]],"PLAIN"];
		[0,format["%1 was charged with Evading Police by %2",_unit getVariable["realname",name _unit],profileName]] remoteExec ["life_fnc_broadcast",west];
	};
	case 2:
	{
		_code = "600";
		titleText [format["You have charged %1 with Criminal Threatening.",_unit getVariable["realname",name _unit]],"PLAIN"];
		[0,format["%1 was charged with Criminal Threatening by %2",_unit getVariable["realname",name _unit],profileName]] remoteExec ["life_fnc_broadcast",west];
	};
	case 3:
	{
		_code = "601";
		titleText [format["You have charged %1 with Obstruction.",_unit getVariable["realname",name _unit]],"PLAIN"];
		[0,format["%1 was charged with Obstruction of Justice by %2",_unit getVariable["realname",name _unit],profileName]] remoteExec ["life_fnc_broadcast",west];
	};
	case 4:
	{
		_code = "603";
		titleText [format["You have charged %1 with GTA.",_unit getVariable["realname",name _unit]],"PLAIN"];
		[0,format["%1 was charged with GTA by %2",_unit getVariable["realname",name _unit],profileName]] remoteExec ["life_fnc_broadcast",west];
	};
	case 5:
	{
		_code = "602";
		titleText [format["You have charged %1 with an aviation violation.",_unit getVariable["realname",name _unit]],"PLAIN"];
		[0,format["%1 was charged with an Aviation Violation by %2",_unit getVariable["realname",name _unit],profileName]] remoteExec ["life_fnc_broadcast",west];
	};
	case 6:
	{
		_code = "604";
		titleText [format["You have given %1 a traffic warning.",_unit getVariable["realname",name _unit]],"PLAIN"];
		[0,format["%1 was given a Traffic Warning by %2",_unit getVariable["realname",name _unit],profileName]] remoteExec ["life_fnc_broadcast",west]; 
	};
	case 7:
	{
		_code = "Drug";
		titleText [format["You have charged %1 with drug trafficking.",_unit getVariable["realname",name _unit]],"PLAIN"];
		[0,format["%1 was charged with Drug Trafficking by %2",_unit getVariable["realname",name _unit],profileName]] remoteExec ["life_fnc_broadcast",west]; 
	};
};
[getPlayerUID _unit,name _unit,_code,[name player]] remoteExec ["life_fnc_wantedAdd",2];