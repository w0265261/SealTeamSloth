/*
	File: fn_robPerson.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Getting tired of adding descriptions...
*/
private["_robber"];
_robber = param [0,ObjNull,[ObjNull]];
if(isNull _robber) exitWith {}; /*No one to return it to?*/
[player] spawn life_fnc_dropItems;
if(life_handpaper > 0) then
{
	[life_handpaper] remoteExec ["life_fnc_robReceive",_robber,false];
	["cash","set",0] call life_fnc_handlePaper;
}
	else
{
	[2,format[localize "STR_NOTF_RobFail",profileName]] remoteExec ["life_fnc_broadcast",_robber,false];
};
[getPlayerUID _robber,name _robber,"211",[player getVariable["realname",name player],getPos player]] remoteExec ["life_fnc_wantedAdd",2];