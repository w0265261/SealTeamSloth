/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Open Vehicle Rename UI
*/
private["_spawnPos","_vid","_vehicle"];	
if(lbCurSel 2802 == -1) exitWith {hint localize "STR_Global_NoSelection"};
_vid = lbValue[2802,(lbCurSel 2802)];
closeDialog 0;

createDialog "STS_Life_renameCar_menu";
disableSerialization;
waitUntil {!dialog};

if(newVehName == "") exitWith {hint "No Name Entered!";};
if([":",newVehName] call BIS_fnc_inString) exitWith {hint "A bad character was found. Try again."};
[_vid,newVehName] remoteExec ["DB_fnc_updateVehName",2];

hint "Vehicle Name Updated!";