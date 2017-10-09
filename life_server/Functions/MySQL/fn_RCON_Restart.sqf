/*
fn_RCON_Restart.sqf
Kevin Webb
Utilizes extDB RCON bot to conduct automatic restarts
*/
uiSleep 300;
"extDB2" callExtension "1:rcon:SAY -1 extDB2 RCON ONLINE";
waitUntil{uiSleep 60; serverTime > 25200};
"extDB2" callExtension "1:rcon:SAY -1 extDB2 Auto RCON: server restart in 1 hour!";
["Automated restart message: the server will be conducting a server restart in 1 hour.","Server",4] remoteExec ["clientMessage",0];
waitUntil{uiSleep 60; serverTime > 27000};
"extDB2" callExtension "1:rcon:SAY -1 extDB2 Auto RCON: server restart in 30 minutes!";
["Automated restart message: the server will be conducting a server restart in 30 minutes.","Server",4] remoteExec ["clientMessage",0];
waitUntil{uiSleep 60; serverTime > 27900};
"extDB2" callExtension "1:rcon:SAY -1 extDB2 Auto RCON: server restart in 15 minutes!";
["Automated restart message: the server will be conducting a server restart in 15 minutes.","Server",4] remoteExec ["clientMessage",0];
waitUntil{uiSleep 60; serverTime > 28200};
"extDB2" callExtension "1:rcon:SAY -1 extDB2 Auto RCON: server restart in 10 minutes!";
["Automated restart message: the server will be conducting a server restart in 10 minutes.","Server",4] remoteExec ["clientMessage",0];
waitUntil{uiSleep 60; serverTime > 28500};
"extDB2" callExtension "1:rcon:SAY -1 extDB2 Auto RCON: server restart in 5 minutes!";
["Automated restart message: the server will be conducting a server restart in 5 minutes.","Server",4] remoteExec ["clientMessage",0];
waitUntil{uiSleep 5; serverTime > 28740};
"extDB2" callExtension "1:rcon:SAY -1 extDB2 Auto RCON: server restart in 1 minute!";
["Automated restart message: the server will be conducting a server restart in 1 minute.","Server",4] remoteExec ["clientMessage",0];
waitUntil{uiSleep 1; serverTime > 28785};
[] remoteExec ["SOCK_fnc_syncData",civilian];
[] call TON_fnc_saveVehicles;
//was the fed robbed? Fetch gold bar amount
_query = format["UPDATE lottery SET jackpot=%1 WHERE id=2",fed_bank getVariable "safe"];
[_query,1] call DB_fnc_asyncCall;
waitUntil{uiSleep 1; serverTime >= 28800};
"extDB2" callExtension "1:rcon:#shutdown";