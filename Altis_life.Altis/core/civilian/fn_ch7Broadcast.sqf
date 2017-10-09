/*
	File: fn_ch7Broadcast.sqf
	Author: John "Paratus" VanderZwet
	Edited by Kevin for formatted hints
	
	Description:
	Display UI to send a message server wide
*/
if (life_myfunds < 10000) exitWith { hint format["Reaching all of Altis with a broadcast isn't cheap. You're lacking $%1 in your bank to cover our costs.",(10000 - life_myfunds)]};
if ((serverTime - life_last_broadcast) < 900) exitWith { hint format["A broadcast was sent recently, try coming back in about %1 minute(s)",round ((900 - (serverTime - life_last_broadcast)) / 60)]; };
createDialog "STS_life_broadcast_menu";