/*
Kevin Webb
fn_fetchGovBank
called when governor logs in to fetch coffers value
*/
_player = _this;
_query = "SELECT govbank FROM rules";
_money = ([_query,2] call DB_fnc_asyncCall) select 0;
["gov_bank",_money] remoteExecCall ["life_fnc_netSetVar",_player];