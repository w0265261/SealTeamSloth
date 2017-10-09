/*
	File: fn_wantedBounty.sqf
	Author: Bryan "Tonic" Boardwine"
	
	Description:
	Checks if the person is on the bounty list and awards the cop for killing them.
*/
private["_civ","_cop","_id","_half"];
_civ = param [0,Objnull,[Objnull]];
_cop = param [1,Objnull,[Objnull]];
_half = param [2,false,[false]];
if(isNull _civ OR isNull _cop) exitWith {};
_id = [getPlayerUID _civ,life_wanted_list] call fnc_index;
if(_id != -1) then
{
	_badcop = if(_civ getVariable["shotByCop",false]) then {1} else {2};
	_bounty = (life_wanted_list select _id) select 3;
	_bounty = _bounty * _badcop;
	_reward = if(_half) then {_bounty / 4} else {_bounty};
	[_reward,_bounty] remoteExec ["life_fnc_bountyReceive",_cop];
	if(_badcop == 2) then {
		_val = if(life_rules select 6 == 2) then {2} else {1};
		_query = format["UPDATE players SET prestige=prestige+%2 WHERE playerid='%1'",getPlayerUID _cop,_val];
		[_query,1] call DB_fnc_asyncCall;
	};
};