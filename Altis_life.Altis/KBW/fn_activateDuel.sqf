/*
fn_activateDuel
Kevin Webb
Makes our clients do what is necessary to set up our duel
*/
call life_fnc_saveThat;
if(primaryWeapon player != "") then {_prim = primaryWeapon player; player removeWeapon _prim};
if(handgunWeapon player != "") then {_seco = handgunWeapon player; player removeWeapon _seco};
_mags = magazines player;
{player removeMagazine _x} foreach _mags;
_arena = _this select 0;
_number = _this select 1;
if(_arena == "duel_arena_2") then {_number = _number + 2};
if(_arena == "duel_arena_3") then {_number = _number + 4};
_marker = format["duel_%1",_number];
player setDir (markerDir _marker);
player setPos (markerPos _marker);
life_dueling = true;
_distance = if(_arena == "duel_arena_1") then {80} else {65};
[player,"hgun_Pistol_heavy_02_Yorris_F",5] call BIS_fnc_addWeapon;
while {life_dueling} do {
	if(!(cameraView in ["INTERNAL","GUNNER"])) then {player switchCamera "INTERNAL"};
	if(player distance (markerPos _arena) > _distance || getPosASL player select 2 < 0) exitWith {life_dueling = false};
	hintSilent format["Distance from center: %1      Forfeit distance: %2",round(player distance (markerPos _arena)),_distance];
};
hintSilent "";
player setPosATL life_originalPos;
[player] joinSilent life_myGrp;
[true] call life_fnc_optiLoadGear;
player switchMove "";