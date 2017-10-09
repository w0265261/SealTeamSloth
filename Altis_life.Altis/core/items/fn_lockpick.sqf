/*
	File: fn_lockpick.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Main functionality for lock-picking.
*/
private["_curTarget","_distance","_isVehicle","_title","_progressBar","_cP","_titleText","_dice","_badDistance"];
_curTarget = cursorTarget;
bool = true;
life_interrupted = false;
if(life_action_inUse) exitWith {};
if(isNull _curTarget) exitWith {}; /*Bad type*/
if(_curTarget getVariable["medic",false]) exitWith { hint "On second thought, I think I won't steal this medic's vehicle."; };
_distance = ((boundingBox _curTarget select 1) select 0) + 2;
if(player distance _curTarget > _distance) exitWith {}; /*Too far*/
_isVehicle = if((_curTarget isKindOf "LandVehicle") OR (_curTarget isKindOf "Ship") OR (_curTarget isKindOf "Air")) then {true} else {false};
if(_isVehicle && _curTarget in life_vehicles) exitWith {hint localize "STR_ISTR_Lock_AlreadyHave";};

/*More error checks*/
if (player getVariable ["unconscious",false]) exitWith {};
if(!_isVehicle && !isPlayer _curTarget) exitWith {};
if(!_isVehicle && !(_curTarget getVariable["restrained",false])) exitWith {};

_title = format[localize "STR_ISTR_Lock_Process",if(!_isVehicle) then {"Handcuffs"} else {getText(configFile >> "CfgVehicles" >> (typeOf _curTarget) >> "displayName")}];
life_action_inUse = true; /*Lock out other actions*/

/*Setup the progress bar*/
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;
_alarm = _curTarget getVariable["alarm",false];
if(_alarm) then {
	systemChat "This vehicle seems to have an advanced security system installed...";
};
if(_alarm && NotYetTripped) then {
	_uid = (_curTarget getVariable "dbInfo") select 0;
	_unit = {if(getPlayerUID _x == _uid) exitWith {_x}; ObjNull} forEach playableUnits;
	if(!isNull _unit) then {
		["Your vehicle alarm has sounded, someone is breaking into your car!","Vehicle Alarm Alert",0] remoteExec ["clientMessage",_unit];
	};
	if(_curTarget getVariable["tracking",false]) then {
		_curTarget setVariable["nicked",true,true];
	} else {
		[player,5] remoteExec ["life_fnc_breakInMarker",west];
	};
	_msg = "A vehicle alarm was activated by the above criminal, indicating a theft is taking place! Check the map for details.";
	[_msg] call fnc_cell_textCop;
	NotYetTripped = false;
	[] spawn { sleep 60; NotYetTripped = true};
};
while {true} do
{
	if(bool) then {
		[] spawn {
			bool = false;
			player playMoveNow "AinvPknlMstpSnonWnonDnon_medic0";
			sleep 7;
			bool = true;
		};
	};
	sleep 0.26;
	if(isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN"];
		_ui = uiNamespace getVariable "life_progress";
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
	};
	_cP = _cP + 0.01;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if(_cP >= 1 OR !alive player) exitWith {life_action_inUse = false;};
	if((life_istazed) || (life_isdowned)) exitWith {life_action_inUse = false;};
	if(life_interrupted) exitWith {life_action_inUse = false;};
	if((player getVariable["restrained",false])) exitWith {life_action_inUse = false;};
	if(player distance _curTarget > _distance) exitWith {_badDistance = true; life_action_inUse = false;};
};
if(_cP < 1) exitWith {life_action_inUse = false; 5 cutText ["","PLAIN"];};
/*Kill the UI display and check for various states*/
5 cutText ["","PLAIN"];
player playActionNow "stop";
if(!alive player OR life_istazed) exitWith {life_action_inUse = false;};
if((player getVariable["restrained",false])) exitWith {life_action_inUse = false;};
if(!isNil "_badDistance") exitWith {titleText[localize "STR_ISTR_Lock_TooFar","PLAIN"]; life_action_inUse = false;};
if(life_interrupted) exitWith {life_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN"]; life_action_inUse = false;};
if(!([false,"lockpick",1] call life_fnc_handleInv)) exitWith {life_action_inUse = false;};

life_action_inUse = false;

if(!_isVehicle) then {
	_curTarget setVariable["restrained",false,true];
	_curTarget setVariable["Escorting",false,true];
	
	[getPlayerUID player,profileName,"905",[_curTarget getVariable["realname",name _curTarget],getPos player]] remoteExec ["life_fnc_wantedAdd",2];
} else {
	_dice = random(100);
	_chance = if(_alarm) then {16.5} else {33};
	if(_dice < _chance) then {
		titleText[localize "STR_ISTR_Lock_Success","PLAIN"];
		life_vehicles pushBack _curTarget;
		_arr = _curTarget getVariable["vehicle_info_owners",[]];
		_arr pushBack [getPlayerUID player,profileName]; _curTarget setVariable["vehicle_info_owners",_arr,true];
		if(playerSide == civilian) then {[getPlayerUID player,profileName,"487",[(_curTarget getVariable "vehicle_info_owners" select 0) select 1, getPos player,getText(configFile >> "CfgVehicles" >> (typeOf _curTarget) >> "displayName")]] remoteExec ["life_fnc_wantedAdd",2]};
	} else {
		[0,format[localize "STR_ISTR_Lock_FailedNOTF",profileName]] remoteExec ["life_fnc_broadcast",west];
		titleText[localize "STR_ISTR_Lock_Failed","PLAIN"];
	};
	[_curTarget, "car_alarm",200] remoteExec ["life_fnc_playSound",0];
};