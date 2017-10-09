/*

	file: fn_handleMessages.sqf
	Author: Silex

*/	
	
private["_msg","_to","_target","_player","_type"];
_target = param [0];
_msg = param [1,"",[""]];
_player = param [2,ObjNull,[ObjNull]];
_type = param [3,-1];

switch(_type) do
{
	/*normal message*/
	case 0:
	{
		if(isNil "_target") exitWith {};
		_type = typeName _target;
		if(_type == "OBJECT" && {isNull _target})  exitWith {};
		if(isNull _player) exitWith {};
		_to = _target;
		_anon = param [5,false,[false]];
		if(_anon) then { [_msg,"Anonymous",0] remoteExec ["clientMessage",_to]; 
		} else {[_msg,_player getVariable["realname",name _player],0] remoteExec ["clientMessage",_to]};
		
		private["_query","_pid","_toID"];
		
		if(_type == "ARRAY") exitWith {
			{
				_pid = getPlayerUID _player;
				_toID = getPlayerUID _x;
				_msg = [_msg] call DB_fnc_mresString;
				_fromName = if(_anon) then {"Anonymous"} else {_player getVariable["realname",name _player]};
				_toName = _x getVariable["realname",name _x];
				_query = format["INSERT INTO messages (fromID, toID, message, fromName, toName) VALUES('%1', '%2', '""%3""', '%4', '%5')",_pid,_toID,_msg,_fromName,_toName];
				["life_messages",[_pid,_toID,_msg,_fromName,_toName]] remoteExec ["life_fnc_netSetVar",_x];
		
				[_query,1] call DB_fnc_asyncCall;
			} forEach _target;
		};
		
		_pid = getPlayerUID _player;
		_toID = getPlayerUID _target;
		_msg = [_msg] call DB_fnc_mresString;
		_fromName = if(_anon) then {"Anonymous"} else {_player getVariable["realname",name _player]};
		_toName = _target getVariable["realname",name _target];
		_query = format["INSERT INTO messages (fromID, toID, message, fromName, toName) VALUES('%1', '%2', '""%3""', '%4', '%5')",_pid,_toID,_msg,_fromName,_toName];
		["life_messages",[_pid,_toID,_msg,_fromName,_toName]] remoteExec ["life_fnc_netSetVar",_target];
		
		[_query,1] call DB_fnc_asyncCall;
	};
	/*message to cops*/
	case 1:
	{	
		_anon = param [4,false,[false]];
		if(_anon) then { [_msg,"Anonymous",1] remoteExec ["clientMessage",west,false]; } else {
		[_msg,name _player,1] remoteExec ["clientMessage",west,false]; };
	};
	/*to admins*/
	case 2:
	{	
		[_msg,name _player,2] remoteExec ["clientMessage",0];
	};
	/*ems request*/
	case 3:
	{	
		[_msg,name _player,5] remoteExec ["clientMessage",independent,false];
	};
	/*adminToPerson*/
	case 4:
	{
		_to = call compile format["%1", _target];
		if(isNull _to) exitWith {};
	
		[_msg,name _player,3] remoteExec ["clientMessage",_to,false];
	};
	/*adminMsgAll*/
	case 5:
	{
		[_msg,name _player,4] remoteExec ["clientMessage",0];
	};
	//govmessage
	case 6:
	{
		[_msg,"President " + name _player,6] remoteExec ["clientMessage",0];
	};
};