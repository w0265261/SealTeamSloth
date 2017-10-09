/*
	File: fn_dataQuery.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the 'authentication' process and sends a request out to
	the server to check for player information.
*/
private["_uid","_side","_sender"];
if(life_session_completed) exitWith {}; /*Why did this get executed when the client already initialized? Fucking arma...*/

cutText[format[localize "STR_Session_Query",getPlayerUID player],"BLACK FADED"];
0 cutFadeOut 999999999;

[getPlayerUID player,playerSide,player,profileName] remoteExec ["DB_fnc_queryRequest",2];