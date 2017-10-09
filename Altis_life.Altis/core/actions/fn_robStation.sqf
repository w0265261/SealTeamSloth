/*
	File: fn_robStation.sqf

	Description:
	Action for robbing gas stations
*/
private["_clerk","_timer","_cash","_marker","_markerName","_inProgress","_success"];

_clerk = param [0,ObjNull,[ObjNull]];
_limit = 240;
_timer = 0;
_cash = 5000;

if(playerSide == west) exitWith {hint "I'm reporting you to IA!";};
if(!(_clerk getVariable ["canBeRobbed", true])) exitWith {cutText ["Sorry... I was robbed recently! Try again later!","PLAIN"];};
if(player distance _clerk > 15) exitWith {cutText ["You must be within 15 meters of the clerk!","PLAIN"];};
if(!isNull objectParent player) exitWith {cutText ["You're not very scary sitting in your car...","PLAIN"];};
if(currentWeapon player in["Binocular","Rangefinder"]) exitWith {cutText ["Nice binos brah, come back with some real weaponry","PLAIN"];};
if(currentWeapon player == "") exitWith {cutText ["Punk... Your fists don't scare me!","PLAIN"];};
if(playersNumber west < 4) exitWith {hint "There are not enough police online to complete this action, try again later!"; };

_action = [
	"Are you sure you want to initiate a robbery? The police will be notified.",
	"Gas Station Robbery",
	"Yes",
	"No"
] call BIS_fnc_guiMessage;
if(!_action) exitWith {};

life_use_atm = false;
_inProgress = true;
_success = true;
_clerk setVariable ["canBeRobbed", false, true];
_clerk setVariable ["inProgress", true, true];


[[2],"A gas station is being robbed, check the map!"] remoteExec ["life_fnc_broadcast",west];
titleText["Stay within 15 meters for least 1 minute and 4 minutes for the highest payout!","PLAIN"];
playSound3D ["A3\Sounds_F\sfx\alarm_independent.wss", player];
_clerk switchMove "AmovPercMstpSsurWnonDnon";
_array = _clerk getVariable["Robbers",[]];
_ind = [getPlayerUID player,_array] call fnc_index;
if(_ind == -1) then {
	_array pushBack [getPlayerUID player,profileName,if(primaryWeapon player != "") then {primaryWeapon player} else {currentWeapon player}];
	_clerk setVariable["Robbers",_array,true];
};
[_clerk] remoteExec ["TON_fnc_robGasStation",2];

while {_clerk getVariable ["inProgress", false]} do {


	if(_timer >= _limit) then {
		_clerk setVariable ["inProgress", false, true];
		_success = true;
	};
	hintSilent format["Time remaining: %1\n Distance from clerk: %2",(_limit-_timer),round(player distance _clerk)];

	if(!alive player) then {
		_clerk setVariable ["inProgress", false, true];
		_success = false;
	};

	if(player distance _clerk > 15) then {
		_clerk setVariable ["inProgress", false, true];
		_success = false;
		titleText["You've gone too far from the clerk!","PLAIN"]; 
	};

	if(life_istazed || life_isdowned || player getVariable["unconscious",false]) then {
		_clerk setVariable ["inProgress", false, true];
		_success = false;
	};

	if(player getvariable["restrained",false]) then {
		_clerk setVariable ["inProgress", false, true];
		_success = false;
	};

	if(!isNull objectParent player) then {
		_clerk setVariable ["inProgress", false, true];
		_success = false;
	};

	_timer = (_timer+1);
	sleep 1;
};

if(_success) then {

	[0,"A gas station was successfuly robbed!"] remoteExec ["life_fnc_broadcast",west];
	_clerk setVariable ["inProgress", false, true];
	["cash","add",_cash] call life_fnc_handlePaper;
	hint format ["You have successfully robbed this gas station for $%1",_cash];
	life_thief = life_thief + _cash;
	_clerk switchMove "";

} else {
	[0,"A gas station robbery has failed!"] remoteExec ["life_fnc_broadcast",west];
	_clerk setVariable ["inProgress", false, true];
	_clerk switchMove "";
	hintSilent "";
	if(_timer > 60) then {
	["cash","add",(round((_timer/_limit)*_cash))] call life_fnc_handlePaper;
	hint format ["You have only gotten away with $%1",round((_timer/_limit)*_cash)];
	life_thief = life_thief + round((_timer/_limit)*_cash);
	} else { hint "You did not stay long enough, so you did not earn any money!"; };
};
[] spawn
{
	sleep 600;
	life_use_atm = true;
};