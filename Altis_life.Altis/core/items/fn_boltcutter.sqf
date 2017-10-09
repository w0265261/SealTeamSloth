/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Breaks the lock on a single door (Closet door to the player).
*/
private["_building","_door","_doors","_cpRate","_title","_progressBar","_titleText","_cp","_ui","_bool","_check","_uid","_unit","_security"];
_building = param [0,ObjNull,[ObjNull]];
_bool = true;
_check = false;
_leasers = _building getVariable ["leasers",[]];

_uid = (_building getVariable ["house_owner",["",""]]) select 0;
_uids = []; 
_uids pushBack _uid;
{ _uids pushBack (_x select 0); } forEach _leasers;
_security = _building getVariable ["security",0];

if(isNull _building) exitWith {};
if(!(_building isKindOf "House_F")) exitWith {hint "You are not looking at a house door."};
if(isNil "life_boltcutter_uses") then {life_boltcutter_uses = 0;};

if(_security == 3) exitWith {hint "These doors appear to made out of steel and are not able to be opened with bolt cutters. Perhaps something with a blast might do the trick."};

if(typeOf _building == "Land_MilOffices_V1_F") then {
	if(player distance (markerPos "fed_reserve") > 100) exitWith {_check = true};
	if(playersNumber west < 9) exitWith {hint "There aren't enough police online to complete a federal reserve robbery."; _check = true; };
	[[1,2],"Someone has begun breaching the vault room of the federal reserve!!",true,[]] remoteExec ["life_fnc_broadcast",0];
} else {
	[_building,_security,_uids] spawn {
		_building = _this select 0;
		_security = _this select 1;
		_uids = _this select 2;
		//_building setVariable ["robbed",profileName,true];
		[_building] remoteExec ["life_fnc_breakinMarker",west];
		[format["%1 was seen breaking into a house.",profileName],"Altis Home Security",1,position player] remoteExec ["clientMessage",west];
		//if (_security > 0) then {
			{
				_uid = getPlayerUID _x;
				if(_uid in _uids && side _x == civilian) then {
					[format["It appears %1 is breaking into your house! We have also notified the Police.",profileName],"Altis Home Security",0] remoteExec ["clientMessage",_x,false];         
					[_building,4] remoteExec ["life_fnc_breakinMarker",_x,false];
				};
			} forEach playableUnits;
		//};
	};
};
if(_check) exitWith {};
_doors = getNumber(configFile >> "CfgVehicles" >> (typeOf _building) >> "NumberOfDoors");

_door = 0;
/*Find the nearest door*/
for "_i" from 1 to _doors do {
	_selPos = _building selectionPosition format["Door_%1_trigger",_i];
	_worldSpace = _building modelToWorld _selPos;
		if(player distance _worldSpace < 2) exitWith {_door = _i;};
};
if(_door == 0) exitWith {hint localize "STR_Cop_NotaDoor"}; /*Not near a door to be broken into.*/
if((_building getVariable[format["bis_disabled_Door_%1",_door],0]) == 0) exitWith {hint localize "STR_House_Raid_DoorUnlocked"};
life_action_inUse = true;

/*Setup the progress bar*/
disableSerialization;
_title = localize "STR_ISTR_Bolt_Process";
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;

switch (typeOf _building) do {
	case "Land_Offices_01_V1_F": {_cpRate = 0.0086;};
	default {_cpRate = 0.013;}
};

while {true} do
{
	if(_bool) then {
				[] spawn {
					_bool = false;
					player playMoveNow "AinvPknlMstpSnonWnonDnon_medic0";
					sleep 10;
					_bool = true;
				};
			};
	sleep 0.26;
	if(isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN"];
		_ui = uiNamespace getVariable "life_progress";
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
	};
	_cP = _cP + _cpRate;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if(_cP >= 1 OR !alive player) exitWith {};
	if(life_istazed) exitWith {};
	if(life_interrupted) exitWith {};
};

/*Kill the UI display and check for various states*/
5 cutText ["","PLAIN"];
player playActionNow "stop";
if(!alive player OR life_istazed) exitWith {life_action_inUse = false;};
if((player getVariable["restrained",false])) exitWith {life_action_inUse = false;};
if(life_interrupted) exitWith {life_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN"]; life_action_inUse = false;};
life_action_inUse = false;

[_building, "burglar_alarm",300] remoteExec ["life_fnc_playSound",0];

if(typeOf _building == "Land_MilOffices_V1_F") exitWith {
	_building setVariable[format["bis_disabled_Door_%1",_door],0,true]; /*Unlock the door.*/
	if((_building getVariable["locked",false])) then {
		_building setVariable["locked",false,true];
	};
	[getPlayerUID player,profileName,"461"] remoteExec ["life_fnc_wantedAdd",2];
};


_dice = random(100);
_num = if(_security > 1) then {20} else {50};
if(_dice < _num) then {
	_building setVariable[format["bis_disabled_Door_%1",_door],0,true]; /*Unlock the door.*/
	if((_building getVariable["locked",false])) then {
		_building setVariable["locked",false,true];
		_building spawn {
			sleep 300;
			_this setVariable["locked",true,true];
			systemChat "The house you broke into has automatically locked its storage";
		};
	};
	[getPlayerUID player,profileName,"459",[_building getVariable "house_owner" select 1,getPos _building,"Boltcutter"]] remoteExec ["life_fnc_wantedAdd",2];	
	titleText["You were able to get the door open.","PLAIN"];		
} else {
	titleText["You were unable to get the door open.","PLAIN"];
};

life_boltcutter_uses = life_boltcutter_uses + 1;
if(life_boltcutter_uses > 8) then {
	[false,"boltcutter",1] call life_fnc_handleInv;
	life_boltcutter_uses = 0;
	hint "Your boltcutter has broken after extensive use";
};