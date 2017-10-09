/*
	Created by: Tonic and Adapted by DirtDiver for STS
	Function Name: life_fnc_jailDialog
	Description: Creates Dialog for jail
*/

life_arrestTarget = param [0,ObjNull,[ObjNull]];
private["_pubCop"];

_pubCop = player getVariable "rank";
if(_pubCop < 1) exitWith {hint "No Jailing for Public Cops. Contact a Whitelisted Officer.";};

createDialog "STS_Life_jail_ui";