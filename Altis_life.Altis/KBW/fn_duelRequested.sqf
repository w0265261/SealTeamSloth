/*
fn_duelrequested.sqf
Kevin Webb
Tells us someone wants to 1v1 us bro
*/
if(dialog) then {closeDialog 0};
_dueler = param [0,ObjNull,[ObjNull]];
_stake = param [1,0,[0]];
_race = param [2,false,[false]];
_point = param [3,[],[[]]];
_word = if(_race) then {"race"} else {"duel"};
if(_stake > life_myFunds) exitWith {
	hint format["%1 challenged you to a bet, however you did not have enough funds to meet the stake",_dueler getVariable["realname",name _dueler]];
	if(!_race) then {
		player setVariable["duelRequesting",nil,true]; 
		_dueler setVariable["duelRequesting",nil,true];
		[1,"The player you tried to request a duel with did not have enough funds to meet the stake"] remoteExec ["life_fnc_broadcast",_dueler];
	};
};
_wording = format["%1 has requested to %3 you; the stake in this %3 is set at $%2.",_dueler getVariable["realname",name _dueler],[_stake] call life_fnc_numberText,_word];
if(_race) then {_wording = _wording + format[" It looks like the race endpoint is %1 meters from here.",round(player distance _point)]};
_wording = _wording + " Do you accept?";
_action = [
	_wording,
	"1v1 me bro!",
	"Yes",
	"No"
] call BIS_fnc_guiMessage;
if(_race) exitWith {
	life_racers = [];
	if(_action) then {
		[str player + "racer",1] remoteExec ["life_fnc_netSetVar",_dueler];
		vehicle player enableSimulation false;
		[] spawn {sleep 29; vehicle player enableSimulation true}; //failsafe!
		hint "Race accepted! Please wait for the race to begin.";
	} else {
		[str player + "racer",-1] remoteExec ["life_fnc_netSetVar",_dueler];
	};
};
if(!_action) exitWith {player setVariable["duelRequesting",nil,true]};
if(!(_dueler getVariable["duelRequesting",ObjNull] == player)) exitWith {hint "hmm, it appears you took too long to accept the request, and the request timed out."; player setVariable["duelRequesting",nil,true]};
if(!isNull _dueler && player distance _dueler < 25 && player getVariable["duelRequesting",ObjNull] == _dueler) then {
	[player,_dueler,(_stake * 2)] remoteExec ["TON_fnc_handleDuel",2];
} else {
	hint "Something seems to have gone wrong. The person requesting this duel has either disconnected or wandered off.";
};
player setVariable["duelRequesting",nil,true];
life_myGrp = group player;
life_originalPos = getPosATL player;