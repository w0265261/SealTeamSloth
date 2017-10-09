/*
	Created by: Tonic and Adapted for STS
	Function Name: life_fn_jail_pre
	Description: Executes custom time for jail.
*/

private["_unit","_id","_pubCop"];
_unit = param [0,ObjNull,[ObjNull]];

_pubCop = player getVariable "rank";
if(_pubCop < 1) exitWith {hint "No Jailing for Public Cops. Contact a Whitelisted Officer.";};

/*Checks*/
if(isNull _unit) exitWith {hint "You cannot send this to jail.";}; /*Not valid*/
if(isNil "_unit") exitwith {hint "You cannot send this to jail.";}; /*Not Valid*/
if(!(_unit isKindOf "Man")) exitWith {hint "You cannot send this to jail.";}; /*Not a unit*/
if(!isPlayer _unit) exitWith {hint "You cannot send this to jail.";}; /*Not a human*/
//if(!(_unit getVariable "restrained")) exitWith {hint "He is not restrained!";}; /*He's not restrained.*/
if(side _unit == west) exitWith {hint "You can't jail Police Officers!";}; /*You can't jail Police Officers.*/
if(isNull _unit) exitWith {hint "Not valid.";}; /*Not valid*/

_jailTime = ctrlText 695696;


if(!([_jailTime] call fnc_isnumber)) exitWith {hint "Please enter a number."};
if((parseNumber _jailTime) > 60) exitWith {hint "You can't jail someone for more than an hour, you sadist!"};
if((parseNumber _jailTime) < 1) exitWith {hint "You can't jail someone for less than 1 minute!"};


[_unit,player,false] remoteExec ["life_fnc_wantedBounty",2];


[_unit,false,(parseNumber _jailTime)] remoteExec ["life_fnc_jailSys",2];
[0,format["%1 was arrested by %2 for %3 minutes", name _unit, name player, parseNumber _jailTime]] remoteExec ["life_fnc_broadcast",0];
["BountyUpdate",[format["Good job taking %1 off the streets.", name _unit]]] call BIS_fnc_showNotification;

closeDialog 0;
