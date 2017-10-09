/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Unlocks / locks the house.
*/
private["_house"];
_house = param [0,ObjNull,[ObjNull]];
if(isNull _house OR (!(_house isKindOf "House_F"))) exitWith {};

_state = _house getVariable["locked",true];
if(_state) then {
	_house setVariable["locked",false,true];
	titleText[localize "STR_House_StorageUnlock","PLAIN"];
	hint "House inventory will automatically re-lock in 2 minutes";
	_house spawn {
		sleep 120;
		_this setVariable["locked",true,true];
	};
} else {
	_house setVariable["locked",true,true];
	titleText[localize "STR_House_StorageLock","PLAIN"];
};