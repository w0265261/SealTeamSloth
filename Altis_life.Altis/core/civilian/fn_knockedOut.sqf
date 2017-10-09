/*
	File: fn_knockedOut.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts and monitors the knocked out state.
*/
private["_target","_who","_obj"];
_target = param [0,ObjNull,[ObjNull]];
_who = param [1,ObjNull,[ObjNull]];
if(isNull _target || isNull _who) exitWith {};
if(_target != player) exitWith {};
_headgear = ["H_Shemag_tan","H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk"];
_goggles = ["G_Balaclava_oli","G_Balaclava_lowprofile","G_Balaclava_combat","G_Balaclava_blk"];
_name = "";
if((headgear _who) in _headgear || (goggles _who) in _goggles) then {_name = "The Masked Man"} else { _name = name _who; };
titleText[format[localize "STR_Civ_KnockedOut",_name],"PLAIN"];
_obj = "Land_ClutterCutter_small_F" createVehicle (getPosATL player);
_obj setPosATL (getPosATL player);
player attachTo [_obj,[0,0,0]];
player playMoveNow "Incapacitated";
disableUserInput true;
sleep 15;
disableUserInput false;
deleteVehicle _obj;
if(player getVariable["zipTie",false]) exitWith{};
player playMoveNow "amovppnemstpsraswrfldnon";
detach player;