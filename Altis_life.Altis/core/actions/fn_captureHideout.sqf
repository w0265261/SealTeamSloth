#include <macro.h>
/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Blah blah.
*/
private["_group","_action","_cpRate","_cP","_progressBar","_title","_titleText","_ui","_flagTexture"];
_pole = _this select 0; //pole object
_marker = _this select 1; //Marker to be updated, if necessary
_zone = _this select 2; //zone as a string, convenient way of figuring out marker text.
_group = _pole getVariable ["gangOwner",""];
if(group player getVariable["gang_name",""] == "") exitWith {hint "You're required to have a permanent gang to capture a turf. Create one today to reap all of its benefits!"};
if(_pole getVariable ["inCapture",FALSE]) exitWith {
	_pole setVariable ["inCapture",false,true];
	hint format["You have thwarted the capture attempt on %1... For now!",_zone];
};
if(_group == group player getVariable["gang_name",nil]) exitWith {titleText[localize "STR_GNOTF_Controlled","PLAIN"]};
if(primaryWeapon player == "" && handgunWeapon player == "") exitWith {hint "Might not be a good idea to do this unarmed..."};
//if(license_civ_bh) exitWith {hint "You can not complete this action as a bounty hunter"; };
if(_group != "") then {
	_action = [
		format["This turf is currently controlled by %1, are you sure you wish to initiate capture?",_group],
		format["Capturing turf of %1",_group],
		localize "STR_Global_Yes",
		localize "STR_Global_No"
	] call BIS_fnc_guiMessage;
	if(_action) then {
		_enemies = [];
		{if(group _x getVariable["gang_name",""] == _group) then {_enemies pushBack _x}} forEach playableUnits;
		if(count _enemies > 0) then {[_zone,false,group player getVariable "gang_name"] remoteExec ["life_fnc_capNotice",_enemies]};
	};
};
if(!isNil "_action" && {!_action}) exitWith {};
_cpRate = 0.001;
/*Setup the progress bar*/
disableSerialization;
_title = format["Capturing turf from %1",_pole getVariable["gangOwner","government"]];
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;
_pole setVariable["inCapture",true,true];
while {_pole getVariable "inCapture"} do
{
	sleep 0.25;
	_cP = _cP + _cpRate;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	hintSilent format["Distance from territory center: %1m; stay within 50m",round(player distance _pole)];
	if(player getVariable["zipTie",false] || player getVariable["restrained",false] || (player getVariable["unconscious",false]) || _cP >= 1 || player distance _pole > 50) exitWith {_pole setVariable["inCapture",false,true];};
};

5 cutText ["","PLAIN"];
if(player distance _pole > 50) exitWith {titleText["You've gone too far away from the turf center!","PLAIN"]};
if(player getVariable["zipTie",false] || player getVariable["restrained",false] || (player getVariable["unconscious",false])) exitWith {};
if(_cP < 1) exitWith {titleText["An enemy gang member interrupted the capture!","PLAIN"]};

_pole setVariable["inCapture",false,true];
_pole setVariable["gangOwner",group player getVariable "gang_name",true];
_marker setMarkerText format["%1 - %2",_zone,group player getVariable "gang_name"];
[_zone,true] remoteExec ["life_fnc_capNotice",group player];
_select = switch(_marker) do {
	case "syrta_turf": {0};
	case "zaros_turf": {1};
	case "paros_turf": {2};
};
life_turf_list set[_select,[_marker,group player getVariable "gang_name"]];
publicVariable "life_turf_list";