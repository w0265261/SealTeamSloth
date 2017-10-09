/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Updates the gang information?
*/
private["_mode","_group","_groupID","_bank","_members","_query","_owner"];
_mode = param [0,0,[0]];
_group = param [1,grpNull,[grpNull]];

if(isNull _group && !(_mode in[5,6])) exitWith {};

_groupID = _group getVariable["gang_id",-1];
if(_groupID == -1 && !(_mode in[5,6])) exitWith {};

switch (_mode) do {
	case 0: {
		_bank = [(_group getVariable ["gang_bank",0])] call DB_fnc_numberSafe;
		_owner = _group getVariable ["gang_owner",""];
		if(_owner == "") exitWith {};

		_query = format["UPDATE gangs SET bank='%1', owner='%2' WHERE id='%3'",_bank,_owner,_groupID];
	};
	
	case 1: {
		_gFund = param [2,0,[0]];
		_query = format["UPDATE gangs SET bank='%1' WHERE id='%2'",([_gFund] call DB_fnc_numberSafe),_groupID];
	};
	
	case 3: {
		_owner = param [2,"",[""]];
		if(_owner == "") exitWith {};
		_query = format["UPDATE gangs SET owner='%1' WHERE id='%2'",_owner,_groupID];
	};
	
	case 4: {
		//adding a new gang member, or removing them
		_uid = param [2,"",[""]];
		_add = param [3,false,[false]];
		_query = "";
		if(_add) then {
			_query = format["UPDATE players SET gangid='%1', gangrank=1 WHERE playerid='%2'",_groupID,_uid];
		} else {
			_query = format["UPDATE players SET gangid=0 WHERE playerid='%1'",_uid];
		};
	};
	
	case 5: {
		_gang = param [2,"",[""]];
		_toAdd = param [3,0,[0]];
		_query = format["UPDATE gangs SET bank = bank + %1 WHERE name='%2'",_toAdd,_gang];
		_group = grpNull;
		{if(_gang == (_x getVariable["gang_name",""])) exitWith {_group = _x}} forEach allGroups;
		if(!isNull _group) then { _group setVariable["gang_bank",((_group getVariable["gang_bank",0]) + _toAdd),true]; };
	};
	
	case 6: {
		//rank management
		_uid = param [2,"",[""]];
		_rank = param [3,0,[0]];
		_query = format["UPDATE players SET gangrank=%1 WHERE playerid='%2'",_rank,_uid];
	};	
};

if(!isNil "_query") then {
	[_query,1] call DB_fnc_asyncCall;
};