/*
fn_claimMailbox.sqf
Kevin Webb
Description: Mail time, mail time, maaaaaaiiiilll tiiiiiiime!
Copyright © 2015 Kevin Webb, All rights reserved
Written for Seal Team Sloth ™ LLC
*/
if(count life_mailbox == 0) exitWith {hint "You don't seem to have anything in your mailbox at this time!"};
_chosen = [];
_whatItemType = "";
_index = -1;
{
	_whatItemType = if(typeName (_x select 1) == "ARRAY") then {"Weapon"} else {"Virtual"};
	_displayName = switch(_whatItemType) do {
		case "Weapon": {([_x select 0] call life_fnc_fetchCfgDetails) select 1};
		case "Virtual": {[_x select 0] call life_fnc_varToStr};
	};
	if(typeName (_x select 0) == "STRING" && {_x select 0 == "cash"}) then {_displayName = format["$%1",_x select 1]; _whatItemType = "cash"};
	_action = [
		format["Would you like to claim your %1?",_displayName],
		"Altis Exchange Mail",
		localize "STR_Global_Yes",
		localize "STR_Global_No"
	] call BIS_fnc_guiMessage;
	_index = _forEachIndex;
	if(_action) exitWith {_chosen = _x};
} forEach life_mailbox;
if(count _chosen == 0) exitWith {};
_variable = if(_whatItemType == "Virtual") then {[_chosen select 0,1] call life_fnc_varHandle} else {""};
if(_whatItemType == "Virtual" && (life_maxWeight - life_carryWeight) < [_variable] call life_fnc_itemWeight) exitWith {hint "You don't have enough space to claim any of this resource!"};
if(_whatItemType == "Weapon" && primaryWeapon player != "") exitWith {hint "You need to have your primary weapon slot free to claim this item."};

switch(_whatItemType) do {
	case "Weapon": {
		player addWeapon (_chosen select 0);
		{
			if(_x != "") then {
				player addPrimaryWeaponItem _x;
			};
		} forEach (_chosen select 1);
		life_mailbox = life_mailbox - [_chosen];
	};
	case "Virtual": {
		_acceptable = floor((life_maxWeight - life_carryWeight) / ([_variable] call life_fnc_itemWeight));
		if(_acceptable > _chosen select 1) exitWith {
			[true,_variable,_chosen select 1] call life_fnc_handleInv;
			life_mailbox = life_mailbox - [_chosen];
		};
		[true,_variable,_acceptable] call life_fnc_handleInv;
		life_mailbox set[_index,[(life_mailbox select _index) select 0,(((life_mailbox select _index) select 1) - _acceptable),floor(random 10000)]];
		hint "You couldn't carry all of what was in your mailbox, so you have withdrawn just as much as you can carry.";
	};
	case "cash": {
		["atm","add",_chosen select 1] call life_fnc_handlePaper;
		life_mailbox = life_mailbox - [_chosen];
	};
};
[life_mailbox,getPlayerUID player] remoteExec ["KBW_fnc_updateMailbox",2];