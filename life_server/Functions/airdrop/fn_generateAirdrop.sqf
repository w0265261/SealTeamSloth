/*
	file Version: 1.0.0.0
	file Author: RYN_Ryan
	file edit: 20.01.2015
	Copyright © 2015 Ryan Torzynski, All rights reserved
	All servers are allowed to use this code, modify and publish it. Every modified release of this script must contain "Original by RTT"!
*/


_posPlayer = param [0,[],[[]]];

if (!airdrop_enable) exitWith {};
if (airdrop_goingon) exitWith {};
airdrop_goingon = true;

_dest = _posPlayer;

[5,"<t size='1.2'><t color='#FF0000'>Airdrop-Mission</t></t><br/><br/><t size='1'>A helicopter is going to drop a Supply crate in 15 minutes! The drop-location will be transmitted soon!</t>"] remoteExec ["life_fnc_broadcast",0];

uiSleep 300;

_marker = createMarker ["Airdropmarker", _dest];
"Airdropmarker" setMarkerColor "ColorRed";
"Airdropmarker" setMarkerType "Empty";
"Airdropmarker" setMarkerShape "ELLIPSE";
"Airdropmarker" setMarkerSize [500,500];
_markerText = createMarker ["Airdropmarkertext", _dest];
"Airdropmarkertext" setMarkerColor "ColorBlack";
"Airdropmarkertext" setMarkerText "Airdrop-Mission";
"Airdropmarkertext" setMarkerType "mil_warning";

[5,"<t size='1.2'><t color='#FF0000'>Airdrop-Mission</t></t><br/><br/><t size='1'>10 minutes until the helicopter will drop the supplies! Check your map for the drop-location!</t>"] remoteExec ["life_fnc_broadcast",0];

uiSleep 300;

[5,"<t size='1.2'><t color='#FF0000'>Airdrop-Mission</t></t><br/><br/><t size='1'>5 minutes until the helicopter will drop the supplies!</t>"] remoteExec ["life_fnc_broadcast",0];

uiSleep 240;

[5,"<t size='1.2'><t color='#FF0000'>Airdrop-Mission</t></t><br/><br/><t size='1'>1 minute until the helicopter will drop the supplies!</t>"] remoteExec ["life_fnc_broadcast",0];

heli1 = CreateVehicle [airdrop_helicopter_main, [7950, 9667, 0], [], 0, "FLY"];
heli2 = CreateVehicle [airdrop_helicopter_scnd, [7950, 9700, 0], [], 0, "FLY"];
heli3 = CreateVehicle [airdrop_helicopter_scnd, [7950, 9630, 0], [], 0, "FLY"];

heli1 allowDamage false;
heli2 allowDamage false;
heli3 allowDamage false;

_mygroup1 = [[7950, 9667, 0], CIVILIAN, ["O_G_Soldier_SL_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
_mygroup2 = [[7950, 9667, 0], CIVILIAN, ["O_G_Soldier_SL_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
_mygroup3 = [[7950, 9667, 0], CIVILIAN, ["O_G_Soldier_SL_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;

{_x moveInDriver heli1} forEach units _mygroup1;
{_x moveInDriver heli2} forEach units _mygroup2;
{_x moveInDriver heli3} forEach units _mygroup3;

_mygroup1 addWaypoint [_dest, 0];
_mygroup1 addWaypoint [[2380.47,22267.8,0], 0];
_mygroup2 addWaypoint [_dest, 0];
_mygroup2 addWaypoint [[2380.47,22267.8,0], 0];
_mygroup3 addWaypoint [_dest, 0];
_mygroup3 addWaypoint [[2380.47,22267.8,0], 0];

_markerText = createMarker ["airbox_marker", [14028.5,18719.7,0.0014267]];
"airbox_marker" setMarkerColor "ColorBlue";
"airbox_marker" setMarkerText " Airdrop-Box";
"airbox_marker" setMarkerType "mil_destroy";

_containerdummy = createVehicle ["Land_Cargo20_blue_F", [3450.7363, 16708.432, 90], [], 0, "CAN_COLLIDE"];
_containerdummy attachTo [heli1,[0,0,-3.5]];
_containerdummy setDir 90;


while { _dest distance heli1 > 250 } do { "airbox_marker" setMarkerPos getPos heli1; sleep 1; };
[5,"<t size='1.2'><t color='#FF0000'>Airdrop-Mission</t></t><br/><br/><t size='1'>The supplies have been dropped!</t>"] remoteExec ["life_fnc_broadcast",0];

// Drop the container

deleteVehicle _containerdummy;
sleep 0.1;
_container = createVehicle ["Land_Cargo20_blue_F", [3450.7363, 16708.432, 90], [], 0, "CAN_COLLIDE"];
_para = createVehicle ["O_Parachute_02_F", [getPos heli1 select 0, getPos heli1 select 1, getPos heli1 select 2], [], 0, ""];
_para setPosATL (heli1 modelToWorld[0,0,100]);
_para attachTo [heli1,[0,0,-10]];
detach _para;
_container attachTo [_para,[0,0,-2]];
_container setDir 90;
playSound3D ["a3\sounds_f\weapons\Flare_Gun\flaregun_1_shoot.wss", _container];
_smoke="SmokeShellRed" createVehicle [getpos _container select 0, getpos _container select 1,0];
_smoke attachTo [_container,[0,0,0]];
_light = "Chemlight_green" createVehicle getPos _container;
_light attachTo [_container,[0,0,0]];
_flare = "F_40mm_Green" createVehicle getPos _container;
_flare attachTo [_container,[0,0,0]];
sleep 0.1;
while { (getPos _container select 2) > 2 } do { "airbox_marker" setMarkerPos getPos _container;sleep 1; };
detach _container;
_container setPos [getPos _container select 0, getPos _container select 1, (getPos _container select 2)+0.5];
playSound3D ["A3\Sounds_F\sfx\alarm_independent.wss", _container];
sleep 6;
"M_NLAW_AT_F" createVehicle [getPos _container select 0, getPos _container select 1, 0];
_pos_container = getPos _container;
deleteVehicle _container;
sleep 0.5;
_box = createVehicle ["CargoNet_01_box_F", _pos_container, [], 0, "CAN_COLLIDE"];
_box allowDamage false;
_flare = "F_40mm_Green" createVehicle getPos _container;
_light attachTo [_box,[0,0,0]];
_flare attachTo [_box,[0,0,0]];

// Fill box

clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearItemCargoGlobal _box;
_var = random 2;
if(_var < 1) then {
	_box addWeaponCargoGlobal ["arifle_Mk20C_ACO_F",1];
	_box addMagazineCargoGlobal ["30Rnd_556x45_Stanag",3];
};
_var = random 2;
if(_var < 1) then {
	_box addWeaponCargoGlobal ["arifle_MXC_ACO_F",1];
	_box addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag",3];
};
_var = random 2;
if(_var < 1) then {
	_box addWeaponCargoGlobal ["SMG_01_ACO_F",1];
	_box addMagazineCargoGlobal ["30Rnd_45ACP_Mag_SMG_01",3];
};
_var = random 2;
if(_var < 1) then {
	_box addWeaponCargoGlobal ["srifle_DMR_01_ACO_F",1];
	_box addMagazineCargoGlobal ["10Rnd_762x54_Mag",3];
};
_var = random 2;
if(_var < 1) then {
	_box addWeaponCargoGlobal ["hgun_ACPC2_snds_F",1];
	_box addMagazineCargoGlobal ["9Rnd_45ACP_Mag",3];
};
_var = random 2;
if(_var < 1) then {
	_box addWeaponCargoGlobal ["SMG_02_ACO_F",1];
	_box addMagazineCargoGlobal ["30Rnd_9x21_Mag",3];
};
_items = [
"MiniGrenade",
"SmokeShellGreen",
"muzzle_snds_L",
"muzzle_snds_acp",
"Rangefinder",
"FirstAidKit",
"FirstAidKit",
"FirstAidKit",
"ToolKit",
"ToolKit",
"Binocular",
"U_B_CTRG_3",
"U_O_GhillieSuit",
"U_O_Wetsuit",
"U_O_SpecopsUniform_ocamo",
"U_O_OfficerUniform_ocamo",
"U_I_CombatUniform",
"U_I_OfficerUniform",
"U_IG_leader",
"U_B_survival_uniform",
"V_BandollierB_cbr",
"V_BandollierB_khk",
"V_TacVest_khk",
"V_TacVest_brn",
"V_PlateCarrierIA2_dgtl",
"V_PlateCarrierIA1_dgtl",
"V_RebreatherB",
"V_I_G_resistanceLeader_F",
"U_B_FullGhillie_lsh",
"U_O_Wetsuit",
"H_HelmetB_camo",
"H_HelmetIA",
"H_PilotHelmetFighter_B",
"H_PilotHelmetFighter_O",
"H_PilotHelmetFighter_I",
"U_B_HeliPilotCoveralls",
"H_BandMask_reaper",
"H_BandMask_demon",
"H_Shemag_olive"
];
{
_var = random 2; 
if(_var < 0.75) then {_box additemCargoGlobal [_x,1]}; 
} forEach _items;
_obj = "Land_Money_F" createVehicle position _box;
_obj setVariable["item",["money",floor (random 7500)],true];
_obj = "Land_Money_F" createVehicle position _box;
_obj setVariable["item",["money",floor (random 7500)],true];
_obj = "Land_Money_F" createVehicle position _box;
_obj setVariable["item",["money",floor (random 7500)],true];
_box setVariable["Cash",floor (random 7500),true];

sleep 60;
deleteVehicle heli1;
deleteVehicle heli2;
deleteVehicle heli3;
{deleteVehicle _x} forEach units _mygroup1;
{deleteVehicle _x} forEach units _mygroup2;
{deleteVehicle _x} forEach units _mygroup3;
{deleteGroup _x} forEach [_mygroup1,_mygroup2,_mygroup3];
"Airdropmarker" setMarkerAlpha 0;
"Airdropmarkertext" setMarkerAlpha 0;
deleteMarker "Airdropmarker";
deleteMarker "Airdropmarkertext";
sleep 240;
deleteVehicle _box;

deleteMarker "airbox_marker";

airdrop_goingon = false;