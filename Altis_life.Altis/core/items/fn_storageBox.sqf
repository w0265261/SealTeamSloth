/*
fn_storageBox.sqf
Kevin Webb
Accessing the new "virtual" house inventory system...
*/
closeDialog 0;
if(_this getVariable["locked",false] && !(_this in life_vehicles)) exitWith {hint "Storage is locked"};
if(count (_this getVariable["containers",[]]) == 0 && !(_this in life_vehicles)) exitWith {hint "Inventory appears to be empty, OR the owner has not been online recently enough to raid this house!"}; //error check?
if(_this getVariable["invUsers",""] != "") exitWith { hint "Someone else is currently using the house inventory"};
_isOnline = [(_this getVariable "house_owner") select 0] call life_fnc_isUIDActive;
if(!_isOnline && playerSide != west && !(_this in life_vehicles)) exitWith {hint "Raiding houses while the owner is offline is currently disabled."};
_this setVariable["invUsers",getPlayerUID player,true];
disableSerialization;
createDialog "STS_house_inv";
_filters = ((findDisplay 38400) displayCtrl 38402);
lbClear _filters;

_filters lbAdd "House Inventory";
_filters lbAdd "Your Inventory";
_filters lbSetCurSel 0;
_this spawn
{
	waitUntil {isNull (findDisplay 38400)};
	_this setVariable["invUsers",nil,true];
};