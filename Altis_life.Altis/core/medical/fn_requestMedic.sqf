/*
	File: fn_requestMedic.sqf
	Author: Bryan "Tonic" Boardwine
*/
private["_medicsOnline"];
_medicsOnline = {_x != player && {side _x == independent} && {alive _x}} count playableUnits > 0; /*Check if medics (indep) are in the room.*/

if(_medicsOnline) then {
	[player,profileName] remoteExec ["life_fnc_medicRequest",independent,FALSE];
	titleText["A message has been dispatched to medical personnel!","PLAIN"];
	life_medreq = true;
	[] spawn {sleep 180; life_medreq = false};
} else { titleText["No medics appear to be available!","PLAIN"]; };

/*Create a thread to monitor duration since last request (prevent spammage).*/
[] spawn 
{
	((findDisplay 7300) displayCtrl 7303) ctrlEnable false;
	sleep (3 * 60);
	((findDisplay 7300) displayCtrl 7303) ctrlEnable true;
};