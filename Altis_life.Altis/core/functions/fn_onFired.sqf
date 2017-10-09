#include <macro.h>
/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Handles various different ammo types being fired.
*/
private["_ammoType","_weap"];
_ammoType = _this select 4; 
_weap = currentWeapon player;
if(!(_ammoType in["mini_Grenade","SmokeShellYellow","Chemlight_red","Chemlight_green","Chemlight_yellow","Chemlight_blue","SmokeShell","G_40mm_SmokeYellow"])) exitWith {
	if (_weap == "hgun_P07_snds_F") then {
		if (player ammo "hgun_P07_snds_F" > 5) then {
			player setAmmo ["hgun_P07_snds_F",5];
		};
		if (license_civ_bh || (playerSide == west)) then {
			if((player ammo "hgun_P07_snds_F" == 0) && !("16Rnd_9x21_Mag" in (magazines player)) && !("30Rnd_9x21_Mag" in (magazines player))) then {
				player addItem "16Rnd_9x21_Mag";
				reload player;
			};
		};
	};
	if(_weap in ["LMG_Mk200_F","arifle_MX_SW_Black_F"]) exitWith {
		_ammo = player ammo _weap;
		if(_ammo > 74) then {player setAmmo[_weap,74];};
	};
	_BoltAction = ((["srifle_EBR", _weap] call BIS_fnc_inString) || (["srifle_DMR", _weap] call BIS_fnc_inString));
	if(_BoltAction) exitWith {
		if(!license_civ_bh && _weap == "srifle_DMR_04_F") exitWith {deleteVehicle (_this select 6); player removeWeapon _weap; hint "Hmm, now how'd you get that? Oh well!"};
		if(_weap == "srifle_DMR_04_F" && player ammo _weap > 5) then {player setAmmo[_weap,4]};
		_weap spawn {
			_ammo = player ammo _this;
			player setAmmo[_this,0];
			uiSleep 0.35;
			player setAmmo[_this,_ammo];
		};
	};
	if(_weap == "hgun_Pistol_Signal_F") exitWith {
		_p = _this select 6;
		_weapon = _this select 1;
		_v = velocity _p;
		_f = 'CMflare_Chaff_Ammo' createVehicle (position _p);
		_f setPosATL (getPosATL _p);_f setVelocity _v;
		[_p,_f] spawn {waitUntil{isNull (_this select 0)}; deleteVehicle (_this select 1);};
	};
	if(!isNil "life_trackDart" && currentWeapon player == handgunWeapon player) then {
		deleteVehicle (_this select 6);
		_obj = cursorTarget;
		if(!(_obj isKindOf "Car" || _obj isKindOf "Air" || _obj isKindOf "Ship" || _obj isKindOf "Man")) then {_obj = objNull};
		if(!isNull _obj && !(_obj IsKindOf "Man" && !isPlayer _obj) && player distance _obj <= 100) then {titleText["Tracking dart was successful","PLAIN"]; [_obj,true] call life_fnc_gpsTracker} else {
			titleText["Tracking dart was unsuccessful, you missed!","PLAIN"];
		};
		life_trackDart = nil;
		if(playerSide == west || license_civ_bh) exitWith {};
		_silencer = player weaponAccessories currentMuzzle player select 0;
		_hasSilencer = !isNil "_silencer" && {_silencer != ""};
		if(_hasSilencer) then {
			switch(handgunWeapon player) do {
				case "hgun_Pistol_heavy_01_F": {player removeHandgunItem "muzzle_snds_acp"};
				case "hgun_ACPC2_F": {player removeHandgunItem "muzzle_snds_acp"};
				case "hgun_Rook40_F": {player removeHandgunItem "muzzle_snds_L"};
				case "hgun_P07_snds_F": {player removeHandgunItem "muzzle_snds_L"};
			};
		} else { player removeItem "muzzle_snds_L"; player removeItem "muzzle_snds_acp"};
	};
};
if(_ammoType in["SmokeShellYellow","G_40mm_SmokeYellow"]) then {
	[_this select 6] spawn {
		_projectile = _this select 0;
		waitUntil{sleep 1; speed _projectile < 0.2};
		_enemies = _projectile nearEntities ["Man", 100];
		_nonUnits = [];
		{if(!isPlayer _x) then {_nonUnits pushBack _x}} forEach _enemies;
		_enemies = _enemies - _nonUnits;
		_projectile remoteExec ["life_fnc_teargas",_enemies];
	};
};