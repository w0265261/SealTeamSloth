#define __CONST__(var1,var2) var1 = compileFinal (if(typeName var2 == "STRING") then {var2} else {str(var2)})
life_server_isReady = false;
publicVariable "life_server_isReady";
life_HC_isActive = false;
publicVariable "life_HC_isActive";

[] execVM "\life_server\functions.sqf";


private["_result","_life_sql_id"];


if ( isNil {uiNamespace getVariable "life_sql_id"}) then
{

	"extDB2" callExtension "9:ADD_DATABASE:Database2";

	_life_sql_id = str(round(random(999999)));
	life_sql_id = compileFinal _life_sql_id;
	"extDB2" callExtension format["9:ADD_DATABASE_PROTOCOL:Database2:SQL_RAW_v2:%1:ADD_QUOTES",_life_sql_id];
	"extDB2" callExtension "9:START_RCON:RCON";
	"extDB2" callExtension "9:ADD_PROTOCOL:RCON:rcon";
	"extDB2" callExtension "9:START_VAC";
	"extDB2" callExtension "9:ADD_PROTOCOL:STEAM:steam";
	"extDB2" callExtension "9:LOCK";
	[] spawn DB_fnc_RCON_Restart;

	uiNamespace setVariable ["life_sql_id", _life_sql_id];
}
else
{
	life_sql_id = uiNamespace getVariable "life_sql_id";
	__CONST__(life_sql_id,life_sql_id);
	[] spawn DB_fnc_RCON_Restart;
};

[] spawn TON_fnc_createVehicles;
/*Run procedures for SQL cleanup on mission start.*/
[] spawn {
[] call KBW_fnc_fixBadOffers;
["CALL deleteOldHouses",1] spawn DB_fnc_asyncCall;
["CALL deleteOldGangs",1] spawn DB_fnc_asyncCall;
["CALL deleteOldMessages",1] spawn DB_fnc_asyncCall;
["CALL deleteOldOffers",1] spawn DB_fnc_asyncCall;
["CALL deleteDeadTents",1] spawn DB_fnc_asyncCall;
};
style = {0};
life_medicLevel = {0};
life_chopping = false;
life_coplevel = {0};
life_paintBallers = [];
life_paintBalling = false;
life_duel1active = false;
life_duel2active = false;
life_duel3active = false;

life_radio_west = radioChannelCreate [[0, 0.95, 1, 0.8], "Side Channel", "%UNIT_NAME", []];
life_radio_civ = radioChannelCreate [[0, 0.95, 1, 0.8], "OOC Channel", "%UNIT_NAME", []];
life_radio_civTrade = radioChannelCreate [[1, 0.6, 0, 0.8], "Trade Channel", "%UNIT_NAME", []];

serv_sv_use = [];

addMissionEventHandler ["HandleDisconnect",{_this call TON_fnc_clientDisconnect; false;}];

life_gang_list = [];
publicVariable "life_gang_list";
life_wanted_list = [];
publicVariable "life_wanted_list";

/*
[] spawn
{
	private["_logic"];
	while {true} do
	{
		sleep (30 * 60);
		_logic = missionnamespace getvariable ["bis_functions_mainscope",objnull];
		_logic setVariable["BIS_fnc_MP_queue",[],TRUE];
	};
};
*/
[] spawn TON_fnc_initHouses;
[] spawn DB_fnc_getPrices;
[] spawn DB_fnc_initTents;

life_server_isReady = true;
publicVariable "life_server_isReady";
_query = "SELECT list FROM zones WHERE id='2'";
life_turf_list = [_query,2] call DB_fnc_asyncCall;
life_turf_list = life_turf_list select 0;
publicVariable "life_turf_list";
{
_marker = ((life_turf_list select _x) select 0);
_gang = ((life_turf_list select _x) select 1);
if(_gang != "") then {
_string = switch(_marker) do {
	case "syrta_turf": {gang_flag_1 setVariable["gangOwner",_gang,true]; _test = format["Syrta Turf - %1",_gang]; _test};
	case "zaros_turf": {gang_flag_2 setVariable["gangOwner",_gang,true]; _test = format["Zaros Turf - %1",_gang]; _test};
	case "paros_turf": {gang_flag_3 setVariable["gangOwner",_gang,true]; _test = format["Paros Turf - %1",_gang]; _test};
};
_marker setMarkerText _string;
};
} forEach [0,1,2];
_query = "SELECT jackpot FROM lottery WHERE id=2";
_bars = [_query,2] call DB_fnc_asyncCall;
_bars = _bars select 0;
fed_bank setVariable["safe",_bars,true];
[] call TON_fnc_capZones;
[] call compile PreprocessFileLineNumbers "\life_server\fn_initHC.sqf";
fnc_queryBank = {
	_uid = getPlayerUID _this;
	_word = if(side _this == west) then {"copbank"} else {"bankacc"};
	_query = format["SELECT %1 from players WHERE playerid='%2'",_word,_uid];
	_bank = ([_query,2] call DB_fnc_asyncCall) select 0;
	["life_myFunds",_bank] remoteExecCall ["life_fnc_netSetVar",_this];
};