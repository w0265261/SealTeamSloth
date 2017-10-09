/*
	File: fn_updateRequest.sqf
	Description: Full synchronization request to the DB.
	Kevin Note: Everything has been truncated except for position and gear. Rest is handled via updatePartial.
*/
if(life_paintballing || life_dueling) exitWith {};
if(!isNil "life_jury_active") exitWith {};
private["_packet","_array","_flag","_msg","_civPosition"];
_civPosition = getPosATL player;
_packet = [getPlayerUID player,(profileName),playerSide];
_array = [];
_flag = switch(playerSide) do {case west: {"cop"}; case civilian: {"civ"}; case independent: {"med"};};
_msg = format["Hack Alert The player with the above name was flagged for money hacking! He seems to have $%1 cash in hand and $%2 in his bank",life_handpaper,life_myfunds];
if ((life_Tswiftie != (life_handpaper / 2) + 5) || (life_ShakeItOff != (life_myfunds / 2) + 3)) exitWith
{
	if(!(life_hacker)) then {
	[3,-1,_msg] call life_fnc_newMsg;
	};
	hintSilent "";
	life_hacker = true;
};

switch (playerSide) do {
	case west: {
	[] call life_fnc_saveThat;
	};
	case civilian: {
		[] call life_fnc_saveThat;
		_packet pushBack _civPosition;
	};
};
if(playerSide in [west,independent] && life_name == profileName) exitWith {};
_packet remoteExec ["DB_fnc_updateRequest",2];