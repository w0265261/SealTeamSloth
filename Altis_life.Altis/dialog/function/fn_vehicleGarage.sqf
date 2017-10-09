/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Vehicle Garage, why did I spawn this in an action its self?
*/
private["_spawnPos","_dir","_type"];
_type = param [1,"",[""]];
_spawnPos = param [0,ObjNull,[ObjNull]];

life_garage_sp = [(_spawnPos modelToWorld [-10,0,0]),(getDir _spawnPos)-90];
if(typeOf life_pInact_curTarget == "Land_i_Shed_Ind_F") then {
	life_garage_sp = [[(getPos life_pInact_curTarget select 0)-(cos(getDir life_pInact_curTarget)*17), (getPos life_pInact_curTarget select 1)+(sin(getDir life_pInact_curTarget)*17), getPos life_pInact_curTarget select 2],(getDir life_pInact_curTarget+180)];
};
life_garage_type = _type;
[getPlayerUID player,playerSide,_type,player] remoteExec ["TON_fnc_getVehicles",2];
createDialog "STS_Life_impound_menu";
disableSerialization;
ctrlSetText[2802,(localize "STR_ANOTF_QueryGarage")];
waitUntil {!dialog};
life_myGarage = false;