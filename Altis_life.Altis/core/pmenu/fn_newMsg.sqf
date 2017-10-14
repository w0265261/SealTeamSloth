#include <macro.h>
/*
	
	file: fn_newMsg.sqf
	Author: Silex
	
*/

private["_to","_type","_playerData","_msg"];
disableSerialization;

_type = param [0,-1];
_playerData = param [1,-1];
_msg = param [2,"",[""]];
if([":",_msg] call BIS_fnc_inString) exitWith {hint "A bad character was found. Try again."};
_display = findDisplay 88888;
_cPlayerList = _display displayCtrl 88881;
_cMessageEdit = _display displayCtrl 88884;

switch(_type) do
{
	case 0:
	{
		life_smartphoneTarget = call compile format["%1",_playerData];
		ctrlSetText[88886, format["Message to: %1",name life_smartphoneTarget]];
		if((__GETC__(style) < 1)) then
		{
			ctrlShow[888897,false];
		};
	};
	/*normal message*/
	case 1:
	{
		_type = typeName life_smartphoneTarget;
		if(_type == "OBJECT" && {isNull life_smartphoneTarget}) exitWith {hint "That person's phone doesn't seem to be functioning...";};
		ctrlShow[88885, false];
		if(_msg == "") exitWith {hint "You must enter a message to send!";ctrlShow[88885, true];};
		_name = if(_type == "OBJECT") then {name life_smartphoneTarget} else {"The vehicle's crew"};
		[life_smartphoneTarget,_msg,player,0,_name,life_anon] remoteExec ["GHB_fnc_handleMessages",2];
		_headgear = ["H_Shemag_tan","H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk"];
		_goggles = ["G_Balaclava_oli","G_Balaclava_lowprofile","G_Balaclava_combat","G_Balaclava_blk"];
		_to = "";
		if(_name != "The vehicle's crew") then {
			if(headGear life_smartphoneTarget in _headGear || goggles life_smartphoneTarget in _goggles) then {_to = "Masked Man"} else {_to = life_smartphoneTarget getVariable["realname",name life_smartphoneTarget]};
		} else {_to = _name};
		hintSilent format["You sent %1 a message: %2",_to,_msg];	
		if(life_anon) exitWith { life_anon = false; closeDialog 0; };
		ctrlShow[88885, true];
		closeDialog 88883;
	};
	/*copmessage*/
	case 2:
	{
		if(({side _x == west} count playableUnits) == 0) exitWith {hint format["There don't seem to be any police available to answer your call..."];};
		ctrlShow[888895,false];
		if(_msg == "") exitWith {hint "You must enter a message to send!";ctrlShow[888895,true];};
		[ObjNull,_msg,player,1,life_anon] remoteExec ["GHB_fnc_handleMessages",2];
		_to = "The Police";
		hintSilent format["You sent %1 a message: %2",_to,_msg];
		if(life_anon) exitWith { life_anon = false; closeDialog 0; };
		ctrlShow[888895,true];
		closeDialog 887890;
	};
	/*msgadmin*/
	case 3:
	{
		ctrlShow[888896,false];
		if(_msg == "") exitWith {hint "You must enter a message to send!";ctrlShow[888896,true];};
		[ObjNull,_msg,player,2] remoteExec ["GHB_fnc_handleMessages",2];
		_to = "The Admins";
		hintSilent format["You sent %1 a message: %2",_to,_msg];
		ctrlShow[888896,true];
		closeDialog 887890;
		if(["comp",_msg] call BIS_fnc_inString) then { TitleText["It appears you are seeking compensation. You should file an adjustment request in the slacker at sealteamsloth.life","PLAIN"]; };
	};
	/*emsrequest*/
	case 4:
	{
		if(({side _x == independent} count playableUnits) == 0) exitWith {hint format["There don't seem to be any medics available to answer your call..."];};
		ctrlShow[888899,false];
		if(_msg == "") exitWith {hint "You must enter a message to send!";ctrlShow[888899,true];};
		[ObjNull,_msg,player,3] remoteExec ["GHB_fnc_handleMessages",2];
		hintSilent format["You have sent a message to all EMS Units: %1",_msg];
		ctrlShow[888899,true];
		closeDialog 887890;
	};
	/*adminToPerson*/
	case 5:
	{
		if((call style) < 1) exitWith {hint "You are not an admin!";};
		if(isNULL life_smartphoneTarget) exitWith {hint format["Their phone has been turned off!"];};
		if(_msg == "") exitWith {hint "You must enter a message to send!";};
		[life_smartphoneTarget,_msg,player,4] remoteExec ["GHB_fnc_handleMessages",2];
		hintSilent format["Admin Message Sent To: %1 - Message: %2",name life_smartphoneTarget,_msg];
		closeDialog 88883;
	};
	/*emergencyloading*/
	case 6:
	{
		if((__GETC__(style) < 1)) then
		{
			ctrlShow[888898,false];
			ctrlShow[888896,true];
		} else {
			ctrlShow[888898,true];
			ctrlShow[888896,false];
		};
		if(!life_governor) then
		{
			ctrlShow[888900,false];
		};
	};
	/*adminMsgAll*/
	case 7:
	{
		if((call style) < 1) exitWith {hint "You are not an admin!";};
		if(_msg == "") exitWith {hint "You must enter a message to send!";};
		[ObjNull,_msg,player,5] remoteExec ["GHB_fnc_handleMessages",2];
		hintSilent format["Admin Message Sent To All: %1",_msg];
		closeDialog 887890;
	};
	//gov message
	case 8:
	{
		if(!life_governor) exitWith {};
		if(!isNil "messageTime") exitWith {hint "You've used your global message too recently."};
		if(_msg == "") exitWith {hint "You must enter a message to send!";};
		[ObjNull,_msg,player,6] remoteExec ["GHB_fnc_handleMessages",2];
		//hintSilent format["Government Message Sent To All: %1",_msg];
		closeDialog 887890;
		messageTime = true;
		[] spawn {sleep 600; messageTime = nil};
	};
};