/*
fn_duelRequest.sqf
Kevin Webb
Description: "1v1 me bro!"
*/
_unit = nil;
_exit = false;
if(count life_racers == 0) then {
if(lbCurSel 15101 == -1) exitWith {hint localize "STR_Global_NoSelection"; _exit = true};
_unit = lbData[15101,(lbCurSel 15101)];
_unit = call compile format["%1",_unit];
if(isNull _unit || !isNull (_unit getVariable ["duelRequesting",ObjNull]) || _unit distance player > 25) exitWith {hint "That player seems to be busy right now."; _exit = true};
};
if(_exit) exitWith {life_racing = false};
createDialog "STS_KBW_price_diag";
waitUntil{!isNull (findDisplay 13371)};
ctrlSetText[2651,"Enter your wager"];
waitUntil{isNull (findDisplay 13371) || life_charged};
if(!(life_charged)) exitWith {life_racing = false};
life_charged = false;
_stake = ctrlText 7331;
if(!([_stake] call fnc_isnumber)) exitWith {hint "You didn't enter an actual number."; closeDialog 0; life_racing = false};
_stake = parseNumber _stake;
if(_stake < 0 || _stake > life_myFunds) exitWith {hint "The number was invalid, or you did not have enough funds."; closeDialog 0; life_racing = false};
closeDialog 0;
if(count life_racers > 0) exitWith {
	//racing
	waitUntil{closeDialog 0; sleep 0.1; !dialog};
	openMap [true, false];
	onMapSingleClick "life_race = _pos; true";
	waitUntil{!isNil "life_race" || !visibleMap};
	if(!visibleMap) exitWith {hint "It seems you didn't pick a race endpoint."; onMapSingleClick ""; life_racers = []; life_racing = false};
	openMap [false, false];
	onMapSingleClick "";
	vehicle player enableSimulation false;
	[] spawn {sleep 31; vehicle player enableSimulation true}; //failsafe!
	[player,_stake,true,life_race] remoteExec ["KBW_fnc_duelRequested",life_racers];
	{missionNameSpace setVariable[str _x + "racer",0]} forEach life_racers;
	hint "The request has been sent. Waiting for a response now...";
	_time = time;
	waitUntil{
		sleep 1;
		_test1 = {if(call compile (str _x + "racer") != 1) exitWith {false}; true} forEach life_racers;
		_test3 = {if(call compile (str _x + "racer") == -1) exitWith {true}; false} forEach life_racers; 
		time - _time > 20 || 
		_test1 ||  
		_test3
	};
	_test = {if(call compile (str _x + "racer") != 1) exitWith {true}; false} forEach life_racers;
	if(_test) exitWith { 
		//Confused yet? If so, stay confused.
		life_racing = false;
		hint "It appears not everyone accepted the race."; 
		life_race = nil; 
		life_racers = [];
		{missionNameSpace setVariable[str _x + "racer",nil]} forEach life_racers;
	};
	life_racers pushBack player;
	[life_racers,life_race,_stake] remoteExec ["TON_fnc_startRace",2];
	life_race = nil; {missionNameSpace setVariable[str _x + "racer",nil]} forEach life_racers; life_racers = []; life_racing = false;
};
[player,_stake] remoteExec ["KBW_fnc_duelRequested",_unit];
[] spawn {sleep 20; player setVariable["duelRequesting",nil,true]};
_unit setVariable["duelRequesting",player,true];
player setVariable["duelRequesting",_unit,true];
hint "The request was sent. If no response is received in 20 seconds, the request will be deleted.";
life_myGrp = group player;
life_originalPos = getPosATL player;
waitUntil{sleep 0.1; dialog}; 
closeDialog 0;