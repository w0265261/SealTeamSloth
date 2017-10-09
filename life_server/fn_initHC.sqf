//#define __CONST__(var1,var2) var1 = compileFinal (if(typeName var2 == "STRING") then {var2} else {str(var2)})
/*
	File: fn_initHC.sqf
	Author: Pennyworth/Kevin
	Description:
	HC runs this to initialize
*/
//life_HC_isActive = true;
life_trial_inprogress = false;
//life_duel1active = false;
//life_paintBallers = [];
//life_paintBalling = false;
governorPardon = false;
//life_duel2active = false;
//serv_sv_use = [];
life_last_broadcast = -900;
//life_duel3active = false;
life_trial_deliberating = false;
life_trial_cooldown = false;
//style = {0};
//life_chopping = false;
"life_turf_list" addPublicVariableEventHandler {
	_list = _this select 1;
	_query = format["UPDATE zones SET list='%1' WHERE id='2'",_list];
	[_query,1] call DB_fnc_asyncCall;
};

/*private["_result","_life_sql_id"];
if ( isNil {uiNamespace getVariable "life_sql_id"}) then
{

	_result = call compile ("extDB2" callExtension "9:ADD_DATABASE:Database2");

	_life_sql_id = str(round(random(999999)));
	life_sql_id = compileFinal _life_sql_id;
	_result = call compile ("extDB2" callExtension format["9:ADD_DATABASE_PROTOCOL:Database2:SQL_RAW_v2:%1:ADD_QUOTES",_life_sql_id]);
	"extDB2" callExtension "9:LOCK";

	uiNamespace setVariable ["life_sql_id", _life_sql_id];
}
else
{
	life_sql_id = uiNamespace getVariable "life_sql_id";
	__CONST__(life_sql_id,life_sql_id);
};*/
[] spawn TON_fnc_cleanup;
[] spawn TON_fnc_RunLottery;
[] execFSM "\life_server\cleanup.fsm";
[] execVM "\life_server\Functions\airdrop\config.sqf";
publicVariable "life_last_broadcast";
//publicVariable "life_HC_isActive";
publicVariable "life_trial_inprogress";
publicVariable "governorPardon";
publicVariable "life_trial_deliberating";
publicVariable "life_trial_cooldown";

[] spawn {
	while{true} do {
		sleep (60 * 60);
		{
			_x setVariable["sellers",[],true];
		} foreach [Dealer_1,Dealer_2,Dealer_3,poacher_1,distrib_1];
		fed_bank setVariable["safe",((fed_bank getVariable "safe") + (round((count playableUnits) / 10))),true];
		_query = format["UPDATE lottery SET jackpot=%1 WHERE id=2",fed_bank getVariable "safe"];
		[_query,1] call DB_fnc_asyncCall;
		_query = "UPDATE rules SET time=time+1";
		[_query,1] call DB_fnc_asyncCall;
		_query = "UPDATE exchange SET timer=timer+1";
		[_query,1] call DB_fnc_asyncCall;
	};
};