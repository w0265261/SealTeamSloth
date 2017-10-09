/*
	File: fn_insertPlayerInfo.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Read the file name... Explains it.
*/
if(life_session_completed) exitWith {}; /*Why did this get executed when the client already initialized? Fucking arma...*/
if(playerSide != civilian) exitWith {systemChat "It appears this is your first time playing. Please join civilian side instead!";}; //Bad Query
cutText[localize "STR_Session_QueryFail","BLACK FADED"];
0 cutFadeOut 9999999;

[getPlayerUID player,profileName,player] remoteExec ["DB_fnc_insertRequest",2];