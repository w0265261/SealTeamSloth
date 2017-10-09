/*
Author: MooN-Gaming

Thanks to Black lagoon Developing
*/
private["_uid","_type","_classname","_color","_plate","_vInfo"];
_vehicle = param [0,ObjNull,[ObjNull]];
_color = param [1,-1,[0]];
/*Error checks*/
if(isNull _vehicle) exitWith {diag_log "Tried to repaint null vehicle. Canceled.";};
if(!alive _vehicle) exitWith {diag_log "Tried to repaint non alive vehicle. Canceled.";};
_vInfo = _vehicle getVariable["dbInfo",[]];
if(count _vInfo == 0) exitWith
{
diag_log "Tried to repaint a non persistent vehicle. Canceled.";
};
_plate = _vInfo select 1;
_uid = _vInfo select 0;
diag_log "Vehicle repainted.";
[_uid,_plate,_color] call DB_fnc_repaintVehicle;