/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Allows cops to 'kick' in the door?
*/
private["_house","_door","_title","_titleText","_progressBar","_cpRate","_cP"];
_house = param [0,ObjNull,[ObjNull]];
if(isNull _house OR (!(_house isKindOf "House_F"))) exitWith {};
if(isNil {(_house getVariable "house_owner")}) exitWith {hint localize "STR_House_Raid_NoOwner"};
if(((_house getVariable "house_owner") select 0) == getPlayerUID player && playerSide == west) exitWith { hint "The IA department will hear about this. You best tender your resignation ASAP if you want to keep some dignity. You should be ashamed of yourself."; };

_door = [_house] call life_fnc_nearestDoor;
if(_door == 0) exitWith {hint localize "STR_Cop_NotaDoor"};
if((_house getVariable[format["bis_disabled_Door_%1",_door],0]) == 0) exitWith {hint localize "STR_House_Raid_DoorUnlocked"};

life_action_inUse = true;

/*Setup the progress bar*/
disableSerialization;
_title = localize "STR_House_Raid_Progress";
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;
 _cpRate = switch(playerSide) do { case civilian: {0.003}; case west: {0.0125}; };
_charge = "SLAMDirectionalMine_Wire_Ammo" createVehicle (player modelToWorld [0.1,0.75,1.5]);
_charge allowDamage false; /* Prevents Users from shooting charge prematurely and damaging house.*/
_dir = (getDir player + 180) % 360;
_charge setDir _dir;
_location = getPosATL _charge;
if(playerSide == west) then {
	[0,format[localize "STR_House_Raid_NOTF",(_house getVariable "house_owner") select 1]] remoteExec ["life_fnc_broadcast",0];
};
hint "The breaching charge has been planted, it would be wise to back up a bit!";
[_charge, "bank_alarm",50] remoteExec ["life_fnc_playSound",0];
_uids = [];
_uid = (_house getVariable ["house_owner",["",""]]) select 0;
	_leasers = _house getVariable ["leasers",[]];
	_uids pushBack _uid;
	{ _uids pushBack (_x select 0); } forEach _leasers;	
if(playerSide == civilian) then {
	[_house] remoteExec ["life_fnc_breakinMarker",west];
	[format["%1 was seen breaking into a house.",profileName],"Altis Home Security",1,position player] remoteExec ["clientMessage",west];	
};

{
	_uid = getPlayerUID _x;
	if(_uid in _uids && side _x == civilian) then {
		["It appears someone is breaking into your house!","Altis Home Security",0] remoteExec ["clientMessage",_x,false];         
		[_house,4] remoteExec ["life_fnc_breakinMarker",_x,false];
	};
} forEach playableUnits;

if(playerSide == civilian && !([false,"blastingcharge",1] call life_fnc_handleInv)) exitWith {};
while {true} do
{
	sleep 0.25;
	if(isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN"];
		_ui = uiNamespace getVariable "life_progress";
	};
	_cP = _cP + _cpRate;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if(_cP >= 1 OR !alive player) exitWith {};
};
/*Kill the UI display and check for various states*/
5 cutText ["","PLAIN"];
if(!alive player) exitWith {life_action_inUse = false;};
life_interrupted = false;
life_action_inUse = false;
_house allowDamage false;
_charge allowDamage true;
_charge setDamage 1;
_house setDamage 0;
_house setVariable["breached",true,true];
_house spawn {sleep 60; _this setVariable["breached",nil,true]};

_numberOfDoors = getNumber(configFile >> "CfgVehicles" >> (typeOf _house) >> "numberOfDoors");
_house animate [format["door_%1_rot",_door],1];
for "_i" from 1 to _numberOfDoors do
{
	_house setVariable[format["bis_disabled_Door_%1",_i],0,true]; /*Unlock the door.*/
};
if(playerSide == civilian) then {
	if((_house getVariable["locked",false])) then {
		_house setVariable["locked",false,true];
		_house spawn {
			sleep 300;
			_this setVariable["locked",true,true];
			systemChat "The house you broke into has automatically locked its storage";
		};
	};
	[getPlayerUID player,profileName,"459",[_house getVariable "house_owner" select 1,getPos _house,"Blasting Charge"]] remoteExec ["life_fnc_wantedAdd",2];	
};
[_house, "burglar_alarm",300] remoteExec ["life_fnc_playSound",0];