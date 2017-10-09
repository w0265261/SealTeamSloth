/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	32 hours later...
*/
private["_grpMembers"];
if(getPlayerUID player == (group player getVariable "gang_owner")) exitWith {hint localize "STR_GNOTF_LeaderLeave"};
[4,group player,getPlayerUID player] remoteExec ["TON_fnc_updateGang",2];
closeDialog 0;
[] spawn {
	sleep 1;
	[player] joinSilent (createGroup civilian);
};