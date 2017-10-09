/*
	File: fn_useItem.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Main function for item effects and functionality through the player menu.
*/
private["_item"];
disableSerialization;
if((lbCurSel 2005) == -1) exitWith {hint localize "STR_ISTR_SelectItemFirst";};
_item = lbData[2005,(lbCurSel 2005)];

switch (true) do
{

	case (_item == "trackDart"):
	{
		if(handgunWeapon player == "") exitWith {hint "You need a handgun for this to work"};
		if(([false,_item,1] call life_fnc_handleInv)) then
		{
			hint "You have ONE shot to land your tracking dart on a vehicle with your pistol.";
			life_trackDart = true;
			switch(handgunWeapon player) do {
				case "hgun_Pistol_heavy_01_F": {player addHandgunItem "muzzle_snds_acp"};
				case "hgun_ACPC2_F": {player addHandgunItem "muzzle_snds_acp"};
				case "hgun_Rook40_F": {player addHandgunItem "muzzle_snds_L"};
				case "hgun_P07_F": {player addHandgunItem "muzzle_snds_L"};
			};
		};
	};
	case (_item == "nitro"):
	{
		[] spawn life_fnc_nitro;
	};
	case (_item == "tacTrig"):
	{
		if([false,_item,1] call life_fnc_handleInv) then
		{
			findDisplay 46 displayAddEventHandler ["MouseButtonDown", {
				if (inputAction "DefaultAction" != 0 && ["hgun",currentWeapon player] call BIS_fnc_inString && !(["PDW",currentWeapon player] call BIS_fnc_inString)) then {
					[] spawn {
						while {inputAction "DefaultAction" != 0 && player ammo currentWeapon player != 0} do {
							player forceWeaponFire [currentWeapon player, "Single"]; uiSleep 0.1; player setWeaponReloadingTime [player, currentWeapon player, 0];
						};
					};
				};
			}];
			hint "You're now making use of a tactical trigger, handguns you fire will be fully automatic for this session.";
		};
	};
	case (_item == "hightoolkit"):
	{
		[] spawn life_fnc_repairTruck;
	};
	
	case (_item == "water" or _item == "coffee"):
	{
		if(([false,_item,1] call life_fnc_handleInv)) then
		{
			life_thirst = 100;
		};
	};
	
	case (_item == "tentciv"):
	{
		[_item, "Land_TentDome_F"] spawn life_fnc_tent;
	};
	
	case (_item == "lethal"):
	{
		hint "You've chaimbered a bullet with your name on it. The next person you shoot who is critically wounded will die!";
		player setVariable["lethal",true,true];
		[false,"lethal",1] call life_fnc_handleInv;
	};
	
	case (_item == "alarmV"): {
		if(!isNull objectParent player) exitWith { hint "You must be outside of the vehicle to perform this action."; };
		[cursorTarget] spawn life_fnc_vehicleAlarm;
	};
	
	case (_item == "detector"): {
		if(detectCooldown > time) exitWith { hintSilent "The detector is currently recharging..."; };
		if(!isNull objectParent player) exitWith {hintSilent "This gadget will not function inside of a vehicle.";};
		_obj = nearestObjects[player,["House_F"],50];
		_bool = false;
		if(count _obj != 0) then {
			_bool = {if(count(_x getVariable["containers",[]]) > 0) exitWith {true}; false} forEach _obj;
		};
		if(_bool) then {
			hint "The loot detector beeps, indicating their is loot close by!"; } else {
			hintSilent "The loot detector remains silent; no loot here."; 
		};
		life_detectCount = life_detectCount + 1;
		if(life_detectCount > 11) then { life_detectCount = 0; [false,_item,1] call life_fnc_handleInv; };
		detectCooldown = time + 30;
	};
	
	case(_item in ["ammoBox","ammoBoxS"]):
	{
		[_item] spawn life_fnc_ammoBox;
		closeDialog 0;
		if(_item == "ammoBox") then {life_inv_ammoBox = life_inv_ammoBox - 1;};
		if(_item == "ammoBoxS") then {life_inv_ammoBoxS = life_inv_ammoBoxS - 1;};
	};
	
	case(_item in ["roadCone","roadBarrier","cncBarrier","cncBarrierL","barGate"]):
	{
		if(!(playerSide == west)) exitWith { hint "You have no idea how to use this item, perhaps if you were a Police Officer."; };
		[_item] spawn life_fnc_placeObject;
	};
	
	case(_item == "shank"): {
		[_item] spawn life_fnc_placeObject;
	};
	
	case (_item == "excavator"): {
		[] spawn life_fnc_searchWreck;
	};
	
	case (_item == "gpstracker"): {
		if(!isNull objectParent player) exitWith { hint "You must be outside of the vehicle to perform this action."; };
		[cursorTarget] spawn life_fnc_gpsTracker;
	};
	
	case (_item == "vammo"):
	{
		if(isNull objectParent player) exitWith { hint "You must be in an armed vehicle to use this properly";};
		[] spawn life_fnc_vehammo;
	};
	
	
	case (_item == "boltcutter"): {
		[cursorTarget] spawn life_fnc_boltcutter;
		closeDialog 0;
	};
	
	case (_item == "blastingcharge"): {
		player reveal fed_bank;
		player reveal Jail_Target;
		(group player) reveal Jail_Target;
		(group player) reveal fed_bank;
		[cursorTarget] spawn life_fnc_blastingCharge;
	};
	
	case (_item == "defusekit"): {
		[cursorTarget] spawn life_fnc_defuseKit;
	};
	
	case (_item in ["storagesmall","storagebig"]): {
		[_item] call life_fnc_storageBox;
	};

	case (_item in ["alarm","reinforceddoor","steeldoor"]): {
		[_item] call life_fnc_securityUpgrades;	
	};
		
	
	case (_item == "chainsaw"):
	{
		hint "This should be used with the windows key instead.";
	};

	case (_item == "crabpot"):
	{
		[] spawn life_fnc_crabpot;
	};

	case (_item == "fishing"):
	{
		[] spawn fnc_fishing;
	};

	
	case (_item == "redgull"):
	{
		if(([false,_item,1] call life_fnc_handleInv)) then
		{
			life_thirst = 100;
			[] spawn
			{	
				if(player getVariable "healing") exitWith {titleText["You drank redgull too recently, so this one has not healed you.","PLAIN"];};
				player setVariable["healing",true,true];
				if((damage player) > 0.4) then {
					player setDamage 0.4;
					} else {
						player setDamage ((damage player) - 0.05);
						};
				player playMove "AinvPknlMstpSnonWnonDnon_medic_1";
				sleep 10;
				player setVariable ["healing",false,true];			
			};
		};
	};
	
	case (_item == "spikeStrip"):
	{
		if(!isNull life_spikestrip) exitWith {hint localize "STR_ISTR_SpikesDeployment"};
		if(!isNull objectParent player) exitWith {hint "The windows of your vehicle aren't exactly big enough for you to toss a spike strip out."; };
		if(player getvariable["restrained",false]  OR player getVariable["zipTie",false] OR !alive player OR !isNil "surrender" OR (animationState player == "Incapacitated")) exitWith { hint "How could you deploy a spikestrip in that state?"; };
		if(([false,_item,1] call life_fnc_handleInv)) then
		{
			[] spawn life_fnc_spikeStrip;
		};
	};
	
	case (_item == "fuelF"):
	{
		if(!isNull objectParent player) exitWith {hint localize "STR_ISTR_RefuelInVehicle"};
		[] spawn life_fnc_jerryRefuel;
	};
	
	case (_item == "lockpick"):
	{
		[] spawn life_fnc_lockpick;
	};
	
	case (_item in ["apple","rabbit","salema","ornate","mackerel","tuna","mullet","catshark","turtle","turtlesoup","donuts","tbacon","peach"]):
	{
		[_item] call life_fnc_eatFood;
	};

	case (_item == "pickaxe"):
	{
		hint "This should be used with the windows key instead.";
	};
	
	case (_item == "heroinp"):
	{
		if(life_drugged) exitWith {systemChat "Perhaps you should reconsider dosing up again so soon..."; };
		life_drugged = true;
		if(([false,_item,1] call life_fnc_handleInv)) then
		{
			[] spawn life_fnc_drugeffect_her;
		};
		[] spawn { sleep 60; life_drugged = false; };
	};

	case (_item == "marijuana"):
	{
		if(life_drugged) exitWith {systemChat "Perhaps you should reconsider dosing up again so soon..."; };
		life_drugged = true;
		if(([false,_item,1] call life_fnc_handleInv)) then
		{
			[] spawn life_fnc_drugeffect_mar;
			[player] spawn life_fnc_attachSmoke;
		};
		[] spawn { sleep 60; life_drugged = false; };
	};

	case (_item == "cocainep"):
	{
		if(life_drugged) exitWith {systemChat "Perhaps you should reconsider dosing up again so soon..."; };
		life_drugged = true;
		if(([false,_item,1] call life_fnc_handleInv)) then
		{
			[] spawn life_fnc_drugeffect_coc;
			//life_thirst = -20;
		};
		[] spawn { sleep 60; life_drugged = false; };
	};
	
	case (_item == "meth"):
	{
		if(life_drugged) exitWith {systemChat "Perhaps you should reconsider dosing up again so soon..."; };
		life_drugged = true;
		if(([false,_item,1] call life_fnc_handleInv)) then
		{
			[] spawn life_fnc_meth;
		};
		[] spawn { sleep 60; life_drugged = false; };
	};
	
	case (_item == "moonshine"):
    {
		if(life_drugged) exitWith {systemChat "Perhaps you should reconsider dosing up again so soon..."; };
		life_drugged = true;
		if(([false,_item,1] call life_fnc_handleInv)) then
		{
			[] spawn life_fnc_drugeffect_alc;
			life_thirst = 100;
		};
		[] spawn { sleep 60; life_drugged = false; };
	};


	default
	{
		hint localize "STR_ISTR_NotUsable";
	};
};
	
[] call life_fnc_p_updateMenu;
[] call life_fnc_hudUpdate;