/*
	Created by: Tonic and Adapted for STS
	Function Name: life_fn_jail_pre
	Description: Executes custom time for jail.
	Modified by Kevin to create a remote arresting tool
*/

diag_log "Started the jailPre";
private["_unit","_id"];
_unit = param [0,ObjNull,[ObjNull]];

/*Checks*/
if(isNull _unit) exitWith {hint "You cannot send this to jail.";}; /*Not valid*/
if(isNil "_unit") exitwith {hint "You cannot send this to jail.";}; /*Not Valid*/
if(!(_unit isKindOf "Man")) exitWith {hint "You cannot send this to jail.";}; /*Not a unit*/
if(!isPlayer _unit) exitWith {hint "You cannot send this to jail.";}; /*Not a human*/
if(isNull _unit) exitWith {hint "Not valid.";}; /*Not valid*/

/*Important*/
_jailTime = ctrlText 695696;

if(!([_jailTime] call fnc_isnumber)) exitWith {hint "Please Enter a number."};
if((parseNumber _jailTime) > 180) exitWith {hint "You can't jail someone for more than 180 minutes!"};
if((parseNumber _jailTime) < 1) exitWith {hint "You can't jail someone for less than 1 minute!"};


[_unit,player,false] remoteExec ["life_fnc_wantedBounty",2];


[_unit,false,(parseNumber _jailTime),true] remoteExec ["life_fnc_jailSys",2];
[0,format["%1 was jailed by admin %2!",_unit getVariable["realname",name _unit],profileName]] remoteExec ["life_fnc_broadcast",0];

closeDialog 0;