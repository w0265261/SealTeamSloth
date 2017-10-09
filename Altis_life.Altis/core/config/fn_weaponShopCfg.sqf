#include <macro.h>
/*
	File: fn_weaponShopCfg.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master configuration file for the weapon shops.
	
	params: classname, custom name
	prices now determined in DB
*/
private["_shop"];
_shop = param [0,"",[""]];
if(_shop == "") exitWith {closeDialog 0};
if(undercover && _shop == "cop_gun") then {_shop = "under"};
switch(_shop) do
{
	case "cop_basic":
	{
		switch(true) do
		{
			case (playerSide != west): {"You are not a cop!"};
			default
			{
				["Cop Shop",
					[
						["itemMap",nil],
						["itemGPS",nil],
						["B_UavTerminal",nil],
						["ItemRadio","Cell"],
						["ItemCompass",nil],
						["ItemWatch",nil],
						["Rangefinder",nil],
						["Binocular",nil],
						["FirstAidKit",nil],
						["ToolKit",nil],
						["Medikit","Stabilization Kit"],
						["NVGoggles_OPFOR",nil],
						["Chemlight_red",nil],
						["Chemlight_yellow",nil],
						["Chemlight_green",nil],
						["Chemlight_blue",nil],
						["Rangefinder",nil]
					]
				];
			};
		};
	};

	case "cop_gun":
	{
		switch(true) do
		{
			case (playerSide != west): {"You are not a cop!"};
			
			case (__GETC__(style) > 0):
			{
				["Admin Shop",
					[
						["hgun_P07_snds_F","Taser Pistol"],
						["hgun_Rook40_snds_F","Stun Pistol"],
						["16Rnd_9x21_Mag",nil],
						["muzzle_snds_L"],
						["hgun_PDW2000_F",nil],
						["30Rnd_9x21_Mag",nil],
						["hgun_ACPC2_F",nil],
						["9Rnd_45ACP_Mag",nil],
						["hgun_Pistol_heavy_01_F",nil],
						["11Rnd_45ACP_Mag",nil],
						["muzzle_snds_acp"],
						["hgun_Pistol_heavy_02_F",nil],
						["6Rnd_45ACP_Cylinder",nil],
						["SMG_01_F",nil],
						["30Rnd_45ACP_Mag_SMG_01",nil],
						["30Rnd_45ACP_Mag_SMG_01_Tracer_Green",nil],
						["SMG_02_F",nil],
						["arifle_Mk20C_plain_F",nil],
						["arifle_Mk20_plain_F",nil],
						["arifle_Mk20_GL_plain_F",nil],
						["arifle_TRG20_F",nil],
						["arifle_TRG21_F",nil],
						["arifle_TRG21_GL_F",nil],
						["30Rnd_556x45_Stanag",nil],
						["30Rnd_556x45_Stanag_Tracer_Red",nil],
						["30Rnd_556x45_Stanag_Tracer_Green",nil],
						["30Rnd_556x45_Stanag_Tracer_Yellow",nil],
						["arifle_MXC_Black_F",nil],
						["arifle_MX_Black_F",nil],
						["arifle_MXM_Black_F",nil],
						["arifle_MX_SW_Black_F",nil],
						["100Rnd_65x39_caseless_mag_Tracer",nil],
						["30Rnd_65x39_caseless_mag",nil],
						["30Rnd_65x39_caseless_mag_Tracer",nil],
						["arifle_Katiba_F",nil],
						["arifle_Katiba_C_F",nil],
						["30Rnd_65x39_caseless_green",nil],
						["30Rnd_65x39_caseless_green_mag_Tracer",nil],
						["srifle_DMR_01_F",nil],
						["10Rnd_762x54_Mag",nil],
						["srifle_DMR_06_olive_F",nil],
						["srifle_DMR_06_camo_F",nil],
						["srifle_EBR_F",nil],
						["srifle_DMR_03_F",nil],
						["srifle_DMR_03_woodland_F",nil],
						["srifle_DMR_03_multicam_F",nil],
						["srifle_DMR_03_tan_F",nil],
						["srifle_DMR_03_khaki_F",nil],
						["20Rnd_762x51_Mag",nil],
						["arifle_SDAR_F","Stun Rifle"],
						["20Rnd_556x45_UW_mag","SDAR Taser Rounds"],
						["B_IR_Grenade",nil],
						["MiniGrenade","Flashbang"],
						["1Rnd_SmokeYellow_Grenade_shell","Tear Gas Shell"],
						["1Rnd_HE_Grenade_shell","Flash Shell"],
						["SmokeShell",nil],
						["SmokeShellRed",nil],
						["SmokeShellGreen",nil],
						["SmokeShellPurple",nil],
						["SmokeShellBlue",nil],
						["SmokeShellOrange",nil],
						["SmokeShellYellow","Tear Gas"],
						["optic_MRD",nil],
						["optic_Yorris",nil],
						["optic_Aco_smg",nil],
						["optic_ACO_grn_smg",nil],
						["optic_ACO",nil],
						["optic_ACO_grn",nil],
						["optic_Holosight_smg",nil],
						["optic_Holosight",nil],
						["optic_MRCO",nil],
						["optic_Arco",nil],
						["optic_Hamr",nil],
						["acc_flashlight",nil],
						["acc_pointer_IR",nil],
						["bipod_01_F_blk","Deployable Bipod"]
					]
				];
			};
	
			case (__GETC__(life_coplevel) == 0):
			{
				["Public Cop Shop",
					[
						["hgun_P07_snds_F","Taser Pistol"],
						["hgun_Rook40_snds_F","Stun Pistol"],
						["16Rnd_9x21_Mag",nil],
						["muzzle_snds_L",nil],
						["SMG_02_F","Nonlethal 9mm SMG"],
						["30Rnd_9x21_Mag",nil],
						["arifle_SDAR_F","Stun Rifle"],
						["20Rnd_556x45_UW_mag","SDAR Taser Rounds"],
						["optic_Aco_smg",nil],
						["optic_ACO_grn_smg",nil],				
						["optic_Holosight_smg",nil],
						["Rangefinder",nil]
					]
				];
			};

			case (__GETC__(life_coplevel) == 1):
			{
				["Cadet Shop",
					[
						["hgun_P07_snds_F","Taser Pistol"],
						["hgun_Rook40_snds_F","Stun Pistol"],
						["16Rnd_9x21_Mag",nil],
						["muzzle_snds_L",nil],
						["SMG_02_F","Nonlethal 9mm SMG"],
						["30Rnd_9x21_Mag",nil],
						["arifle_SDAR_F","Stun Rifle"],
						["20Rnd_556x45_UW_mag","SDAR Taser Rounds"],
						["optic_Aco_smg",nil],
						["optic_ACO_grn_smg",nil],
						["optic_Holosight_smg",nil],
						["Rangefinder",nil]
					]
				];
			};
			
			case (__GETC__(life_coplevel) in [2,3]):
			{
				_return = ["Patrolman's Depot",
					[
						["hgun_P07_snds_F","Taser Pistol"],
						["hgun_Rook40_snds_F","Stun Pistol"],
						["16Rnd_9x21_Mag",nil],
						["muzzle_snds_L",nil],
						["SMG_01_F",nil],
						["30Rnd_45ACP_Mag_SMG_01",nil],
						["30Rnd_45ACP_Mag_SMG_01_Tracer_Green",nil],
						["SMG_02_F",nil],
						["30Rnd_9x21_Mag",nil],
						["arifle_SDAR_F","Stun Rifle"],
						["20Rnd_556x45_UW_mag","SDAR Taser Rounds"],
						["arifle_MXC_Black_F",nil],
						["arifle_MX_Black_F",nil],
						["30Rnd_65x39_caseless_mag",nil],
						["30Rnd_65x39_caseless_mag_Tracer",nil],
						["arifle_Mk20C_plain_F",nil],
						["arifle_Mk20_plain_F",nil],
						["arifle_TRG20_F",nil],
						["arifle_TRG21_F",nil],
						["30Rnd_556x45_Stanag",nil],
						["30Rnd_556x45_Stanag_Tracer_Green",nil],
						["O_IR_Grenade",nil],
						["MiniGrenade","Flashbang"],
						["SmokeShell",nil],
						["SmokeShellRed",nil],
						["SmokeShellGreen",nil],
						["SmokeShellPurple",nil],
						["SmokeShellBlue",nil],
						["SmokeShellOrange",nil],
						["SmokeShellYellow","Tear Gas"],
						["optic_Aco_smg",nil],
						["optic_ACO_grn_smg",nil],
						["optic_ACO",nil],
						["optic_ACO_grn",nil],
						["optic_Holosight_smg",nil],
						["optic_Holosight",nil],
						["optic_MRCO",nil],
						["optic_Arco",nil],
						["optic_Hamr",nil],
						["acc_flashlight",nil],
						["acc_pointer_IR",nil],
						["bipod_01_F_blk","Deployable Bipod"],
						["Rangefinder",nil]
						
					]
				];
				if(call life_coplevel == 3) then {
					_newReturn = _return select 1;
					_newReturn pushBack ["srifle_EBR_F",nil];
					_newReturn pushBack ["srifle_DMR_03_F",nil];
					_newReturn pushBack ["20Rnd_762x51_Mag",nil];
					_return set[1,_newReturn];
				};
				_return;
			};

			case (__GETC__(life_coplevel) == 4):
			{
				["Corporal Shop",
					[
						["hgun_P07_snds_F","Taser Pistol"],
						["hgun_Rook40_snds_F","Stun Pistol"],
						["16Rnd_9x21_Mag",nil],
						["muzzle_snds_L",nil],
						["SMG_01_F",nil],
						["30Rnd_45ACP_Mag_SMG_01",nil],
						["30Rnd_45ACP_Mag_SMG_01_Tracer_Green",nil],
						["SMG_02_F",nil],
						["30Rnd_9x21_Mag",nil],
						["arifle_SDAR_F","Stun Rifle"],
						["20Rnd_556x45_UW_mag","SDAR Taser Rounds"],
						["arifle_MXC_Black_F",nil],
						["arifle_MX_Black_F",nil],
						["arifle_MXM_Black_F",nil],
						["30Rnd_65x39_caseless_mag",nil],
						["30Rnd_65x39_caseless_mag_Tracer",nil],
						["srifle_EBR_F",nil],
						["srifle_DMR_03_F",nil],
						["srifle_DMR_03_woodland_F",nil],
						["srifle_DMR_03_multicam_F",nil],
						["srifle_DMR_03_tan_F",nil],
						["srifle_DMR_03_khaki_F",nil],
						["20Rnd_762x51_Mag",nil],
						["arifle_Mk20C_plain_F",nil],
						["arifle_Mk20_plain_F",nil],
						["arifle_TRG20_F",nil],
						["arifle_TRG21_F",nil],
						["30Rnd_556x45_Stanag",nil],
						["30Rnd_556x45_Stanag_Tracer_Green",nil],
					    ["O_IR_Grenade",nil],
						["MiniGrenade","Flashbang"],
						["SmokeShell",nil],
						["SmokeShellRed",nil],
						["SmokeShellGreen",nil],
						["SmokeShellPurple",nil],
						["SmokeShellBlue",nil],
						["SmokeShellOrange",nil],
						["SmokeShellYellow","Tear Gas"],
						["optic_Aco_smg",nil],
						["optic_ACO_grn_smg",nil],
						["optic_ACO",nil],
						["optic_ACO_grn",nil],
						["optic_Holosight_smg",nil],
						["optic_Holosight",nil],
						["optic_MRCO",nil],
						["optic_Arco",nil],
						["optic_Hamr",nil],
						["acc_flashlight",nil],
						["acc_pointer_IR",nil],
						["bipod_01_F_blk","Deployable Bipod"],
						["Rangefinder",nil]
					]
				];
			};

			case (__GETC__(life_coplevel) > 4):
			{
				["Upper Rank Armory",
					[
						["hgun_P07_snds_F","Taser Pistol"],
						["hgun_Rook40_snds_F","Stun Pistol"],
						["16Rnd_9x21_Mag",nil],
						["muzzle_snds_L",nil],
						["SMG_01_F",nil],
						["30Rnd_45ACP_Mag_SMG_01",nil],
						["30Rnd_45ACP_Mag_SMG_01_Tracer_Green",nil],
						["SMG_02_F",nil],
						["30Rnd_9x21_Mag",nil],
						["arifle_SDAR_F","Stun Rifle"],
						["20Rnd_556x45_UW_mag","SDAR Taser Rounds"],
						["arifle_MXC_Black_F",nil],
						["arifle_MX_Black_F",nil],
						["arifle_MXM_Black_F",nil],
						["30Rnd_65x39_caseless_mag",nil],
						["30Rnd_65x39_caseless_mag_Tracer",nil],
						["arifle_MX_SW_Black_F",nil],
						["100Rnd_65x39_caseless_mag_Tracer",nil],
						["srifle_EBR_F",nil],
						["srifle_DMR_03_F",nil],
						["srifle_DMR_03_woodland_F",nil],
						["srifle_DMR_03_multicam_F",nil],
						["srifle_DMR_03_tan_F",nil],
						["srifle_DMR_03_khaki_F",nil],
						["20Rnd_762x51_Mag",nil],
						["arifle_Mk20C_plain_F",nil],
						["arifle_Mk20_plain_F",nil],
						["arifle_Mk20_GL_plain_F",nil],
						["arifle_TRG20_F",nil],
						["arifle_TRG21_F",nil],
						["arifle_TRG21_GL_F",nil],
						["30Rnd_556x45_Stanag",nil],
						["30Rnd_556x45_Stanag_Tracer_Green",nil],
						["O_IR_Grenade",nil],
						["MiniGrenade","Flashbang"],
						["1Rnd_SmokeYellow_Grenade_shell","Tear Gas Shell"],
						["1Rnd_HE_Grenade_shell","Flash Shell"],
						["SmokeShell",nil],
						["SmokeShellRed",nil],
						["SmokeShellGreen",nil],
						["SmokeShellPurple",nil],
						["SmokeShellBlue",nil],
						["SmokeShellOrange",nil],
						["SmokeShellYellow","Tear Gas"],
						["optic_Aco_smg",nil],
						["optic_ACO_grn_smg",nil],
						["optic_ACO",nil],
						["optic_ACO_grn",nil],
						["optic_Holosight_smg",nil],
						["optic_Holosight",nil],
						["optic_MRCO",nil],
						["optic_Arco",nil],
						["optic_Hamr",nil],
						["acc_flashlight",nil],
						["acc_pointer_IR",nil],
						["bipod_01_F_blk","Deployable Bipod"],						
						["Rangefinder",nil]
					]
				];
			};
		};
	};
	
	case "medic":
	{
		switch (true) do 
		{
			case (playerSide != independent): {"You are not an AMS Medic"};
			case (__GETC__(life_medicLevel) > 1):
			{
				["Hospital AMS Shop",
					[
						["itemMap",nil],
						["itemGPS",nil],
						["ItemRadio","Cell"],
						["ItemCompass",nil],
						["ItemWatch",nil],
						["Rangefinder",nil],
						["FirstAidKit",nil],
						["ToolKit",nil],
						["Medikit","Stabilization Kit"],
						["Chemlight_red",nil],
						["Chemlight_yellow",nil],
						["Chemlight_green",nil],
						["Chemlight_blue",nil],
						["V_TacVestIR_blk",nil],
						["H_PilotHelmetHeli_B",nil]
					]
				];
			};
			default {
				["Hospital AMS Shop",
					[
						["itemMap",nil],
						["itemGPS",nil],
						["ItemRadio","Cell"],
						["ItemCompass",nil],
						["ItemWatch",nil],
						["Rangefinder",nil],
						["FirstAidKit",nil],
						["ToolKit",nil],
						["Medikit","Stabilization Kit"],
						["Chemlight_red",nil],
						["Chemlight_yellow",nil],
						["Chemlight_green",nil],
						["Chemlight_blue",nil]
					]
				];
			};
		};
	};
	
	case "rebel":
	{
		switch(true) do
		{
			case (playerSide != civilian): {"You are not a civilian!"};
			case (!license_civ_rebel): {"You don't have a Gangster license!"};
			default
			{
				_return = ["Black Market",
					[
						["itemMap",nil],
						["itemGPS",nil],
						["ItemRadio","Cell"],
						["ItemCompass",nil],
						["ItemWatch",nil],
						["Rangefinder",nil],
						["FirstAidKit",nil],
						["ToolKit",nil],
						["Medikit","Stabilization Kit"],
						["NVGoggles_INDEP",nil],
						["hgun_P07_F",nil],
						["hgun_Rook40_F",nil],
						["16Rnd_9x21_Mag",nil],
						["SMG_02_F",nil],
						["hgun_PDW2000_F",nil],
						["30Rnd_9x21_Mag",nil],
						["hgun_ACPC2_F",nil],
						["9Rnd_45ACP_Mag",nil],
						["hgun_Pistol_heavy_01_F",nil],
						["11Rnd_45ACP_Mag",nil],
						["optic_MRD",nil],
						["hgun_Pistol_heavy_02_F",nil],
						["6Rnd_45ACP_Cylinder",nil],
						["optic_Yorris",nil],
						["SMG_01_F",nil],
						["30Rnd_45ACP_Mag_SMG_01",nil],
						["30Rnd_45ACP_Mag_SMG_01_Tracer_Green",nil],
						["arifle_TRG20_F",nil],
						["arifle_TRG21_F",nil],
						["arifle_TRG21_GL_F",nil],
						["arifle_Mk20C_F",nil],	
						["arifle_Mk20_F",nil],
						["arifle_Mk20_GL_F",nil],
						["30Rnd_556x45_Stanag",nil],
						["30Rnd_556x45_Stanag_Tracer_Red",nil],
						["30Rnd_556x45_Stanag_Tracer_Green",nil],
						["30Rnd_556x45_Stanag_Tracer_Yellow",nil],
						["arifle_Katiba_C_F",nil],
						["arifle_Katiba_F",nil],
						["30Rnd_65x39_caseless_green",nil],
						["30Rnd_65x39_caseless_green_mag_Tracer",nil],
						["srifle_DMR_01_F",nil],
						["10Rnd_762x54_Mag",nil],
						["srifle_DMR_06_olive_F",nil],
						["srifle_DMR_06_camo_F",nil],
						["srifle_EBR_F",nil],
						["srifle_DMR_03_F",nil],
						["srifle_DMR_03_woodland_F",nil],
						["srifle_DMR_03_multicam_F",nil],
						["srifle_DMR_03_tan_F",nil],
						["srifle_DMR_03_khaki_F",nil],
						["20Rnd_762x51_Mag",nil],
						["O_IR_Grenade",nil],
						["MiniGrenade","Flashbang"],
						["1Rnd_SmokeYellow_Grenade_shell","Tear Gas Shell"],
						["1Rnd_HE_Grenade_shell","Flash Shell"],
						["SmokeShell",nil],
						["SmokeShellRed",nil],
						["SmokeShellGreen",nil],
						["SmokeShellPurple",nil],
						["SmokeShellBlue",nil],
						["SmokeShellOrange",nil],
						["SmokeShellYellow","Tear Gas"],
						["optic_Aco_smg",nil],
						["optic_ACO_grn_smg",nil],
						["optic_ACO",nil],
						["optic_ACO_grn",nil],
						["optic_Holosight_smg",nil],
						["optic_Holosight",nil],
						["optic_MRCO",nil],
						["optic_Arco",nil],
						["optic_Hamr",nil],
						["acc_flashlight",nil],
						["acc_pointer_IR",nil],
						["bipod_01_F_blk","Deployable Bipod"]
					]
				];
				_toSelect = ((life_capture_list) select 0);
				if(_toSelect select 2 == 1 && _toSelect select 0 == group player getVariable["gang_name",""]) then {
					_newReturn = _return select 1;
					_newReturn pushBack ["LMG_Mk200_F",nil];
					_newReturn pushBack ["200Rnd_65x39_cased_Box_Tracer",nil];
					_return set[1,_newReturn];
				};
				_return;
			};
		};
	};
	
	case "gun":
	{
		switch(true) do
		{
			default
			{
				["Billy Joe's Firearms",
					[
						["hgun_Pistol_Signal_F","Flare Gun"],
						["6Rnd_RedSignal_F",nil],
						["6Rnd_GreenSignal_F",nil],
						["hgun_P07_F",nil],
						["hgun_Rook40_F",nil],
						["16Rnd_9x21_Mag",nil],
						["hgun_PDW2000_F",nil],
						["30Rnd_9x21_Mag",nil],
						["hgun_ACPC2_F",nil],
						["9Rnd_45ACP_Mag",nil],
						["hgun_Pistol_heavy_01_F",nil],
						["11Rnd_45ACP_Mag",nil],
						["hgun_Pistol_heavy_02_F",nil],
						["6Rnd_45ACP_Cylinder",nil],
						["V_Rangemaster_belt",nil],
						["V_Press_F",nil],
						["V_BandollierB_rgr",nil,450],
						["V_BandollierB_oli",nil,450],
						["V_BandollierB_cbr",nil,450]
					]
				];
			};
		};
	};
	
	case "gang":
	{
		switch(true) do
		{
			case (playerSide != civilian): {"You are not a civilian!"};
			default
			{
				["Hideout Armament",
					[
						["hgun_P07_F",nil],
						["hgun_Rook40_F",nil],
						["16Rnd_9x21_Mag",nil],
						["hgun_PDW2000_F",nil],
						["SMG_02_F",nil],
						["30Rnd_9x21_Mag",nil],
						["hgun_ACPC2_F",nil],
						["9Rnd_45ACP_Mag",nil],
						["hgun_Pistol_heavy_01_F",nil],
						["11Rnd_45ACP_Mag",nil],
						["optic_MRD",nil],
						["hgun_Pistol_heavy_02_F",nil],
						["6Rnd_45ACP_Cylinder",nil],
						["optic_Yorris",nil],
						["SMG_01_F",nil],
						["30Rnd_45ACP_Mag_SMG_01",nil],
						["30Rnd_45ACP_Mag_SMG_01_Tracer_Green",nil],
						["arifle_TRG20_F",nil],
						["arifle_TRG21_F",nil],
						["arifle_Mk20C_F",nil],	
						["arifle_Mk20_F",nil],
						["30Rnd_556x45_Stanag",nil],
						["optic_ACO_grn_smg",nil],
						["optic_Aco_smg",nil],
						["optic_Holosight_smg",nil],
						["V_Rangemaster_belt",nil],
						["V_BandollierB_rgr",nil],
						["V_BandollierB_oli",nil],
						["V_BandollierB_cbr",nil]
					]
				];
			};
		};
	};
	
	case "c3":
	{
		switch(true) do
		{
			case (playerSide != civilian): {"You are not a civilian!"};
			case (!license_civ_c3): {"You don't have a Class Three license!"};
			default
			{
				["Class Three Weaponry",
					[
						["itemMap",nil],
						["itemGPS",nil],
						["ItemRadio","Cell"],
						["ItemCompass",nil],
						["ItemWatch",nil],
						["Rangefinder",nil],
						["FirstAidKit",nil],
						["ToolKit",nil],
						["Medikit","Stabilization Kit"],
						["NVGoggles_INDEP",nil],
						["hgun_P07_F",nil],
						["hgun_Rook40_F",nil],
						["16Rnd_9x21_Mag",nil],
						["hgun_PDW2000_F",nil],
						["SMG_02_F",nil],
						["30Rnd_9x21_Mag",nil],
						["hgun_ACPC2_F",nil],
						["9Rnd_45ACP_Mag",nil],
						["hgun_Pistol_heavy_01_F",nil],
						["11Rnd_45ACP_Mag",nil],
						["optic_MRD",nil],
						["hgun_Pistol_heavy_02_F",nil],
						["6Rnd_45ACP_Cylinder",nil],
						["optic_Yorris",nil],
						["SMG_01_F",nil],
						["30Rnd_45ACP_Mag_SMG_01",nil],
						["30Rnd_45ACP_Mag_SMG_01_Tracer_Green",nil],
						["arifle_TRG20_F",nil],
						["arifle_TRG21_F",nil],
						["arifle_TRG21_GL_F",nil],
						["arifle_Mk20_plain_F",nil],	
						["arifle_Mk20C_plain_F",nil],
						["arifle_Mk20_GL_plain_F",nil],
						["30Rnd_556x45_Stanag",nil],
						["30Rnd_556x45_Stanag_Tracer_Red",nil],
						["30Rnd_556x45_Stanag_Tracer_Green",nil],
						["30Rnd_556x45_Stanag_Tracer_Yellow",nil],
						["arifle_MXC_F",nil],
						["30Rnd_65x39_caseless_mag",nil],
						["30Rnd_65x39_caseless_mag_Tracer",nil],
						["hgun_Pistol_Signal_F","Flare Gun"],
						["6Rnd_RedSignal_F",nil],
						["6Rnd_GreenSignal_F",nil],
						["B_IR_Grenade",nil],
						["MiniGrenade","Flashbang"],
						["1Rnd_SmokeYellow_Grenade_shell","Tear Gas Shell"],
						["1Rnd_HE_Grenade_shell","Flash Shell"],
						["SmokeShell",nil],
						["SmokeShellRed",nil],
						["SmokeShellGreen",nil],
						["SmokeShellPurple",nil],
						["SmokeShellBlue",nil],
						["SmokeShellOrange",nil],
						["SmokeShellYellow","Tear Gas"],
						["optic_Aco_smg",nil],
						["optic_ACO_grn_smg",nil],
						["optic_ACO",nil],
						["optic_ACO_grn",nil],
						["optic_Holosight_smg",nil],
						["optic_Holosight",nil],
						["optic_MRCO",nil],
						["optic_Arco",nil],
						["optic_Hamr",nil],
						["acc_flashlight",nil],
						["acc_pointer_IR",nil],
						["bipod_01_F_blk","Deployable Bipod"]
					]
				];
			};
		};
	};
	
	case "genstore":
	{
		["Altis General Store",
			[
				["itemMap",nil],
				["itemGPS",nil],
				["ItemRadio","Cell"],
				["ItemCompass",nil],
				["ItemWatch",nil],
				["Binocular",nil],
				["FirstAidKit",nil],
				["ToolKit",nil],
				["Medikit","Stabilization Kit"],
				["NVGoggles",nil],
				["Chemlight_red",nil],
				["Chemlight_yellow",nil],
				["Chemlight_green",nil],
				["Chemlight_blue",nil]
			]
		];
	};
	
	case "bh":
	{
		["Bounty Hunter Shop",
			[
				["itemMap",nil],
				["itemGPS",nil],
				["ItemRadio","Cell"],
				["ItemCompass",nil],
				["ItemWatch",nil],
				["Binocular",nil],
				["FirstAidKit",nil],
				["ToolKit",nil],
				["Medikit","Stabilization Kit"],
				["NVGoggles_INDEP",nil],
				["hgun_P07_snds_F","Taser"],
				["hgun_Rook40_snds_F","Stun Pistol"],
				["16Rnd_9x21_Mag",nil],
				["SMG_02_F","Stun SMG"],
				["30Rnd_9x21_Mag","9mm rubber bullets"],
				["arifle_SDAR_F","Stun Rifle"],
				["20Rnd_556x45_UW_mag","SDAR Taser Rounds"],
				["30Rnd_556x45_Stanag","SDAR Stun Rounds"],
				["srifle_DMR_04_F","Dart Rifle"],
				["10Rnd_127x54_Mag","10Rnd Dart Mag"],
				["B_IR_Grenade",nil],
				["optic_ACO_grn_smg",nil],
				["optic_Holosight_smg",nil],
				["optic_Aco_smg",nil],
				["MiniGrenade","Flashbang"],
				["SmokeShell",nil],
				["SmokeShellYellow","Tear Gas"]
			]
		];
	};

	case "dive":
	{
		["Underwater Weaponry",
			[
				["arifle_SDAR_F",nil],
				["20Rnd_556x45_UW_mag",nil]
			]
		];
	};
	
	case "ammo":
	{
		["Munition stock",
			[
				["MiniGrenade","Flashbang"],
				["SmokeShell",nil],
				["SmokeShellYellow","Tear Gas"],
				["16Rnd_9x21_Mag",nil],
				["30Rnd_9x21_Mag",nil],
				["9Rnd_45ACP_Mag",nil],
				["11Rnd_45ACP_Mag",nil],
				["6Rnd_45ACP_Cylinder",nil],
				["30Rnd_45ACP_Mag_SMG_01",nil],
				["30Rnd_45ACP_Mag_SMG_01_Tracer_Green",nil],
				["30Rnd_556x45_Stanag",nil],
				["30Rnd_556x45_Stanag_Tracer_Red",nil],
				["30Rnd_556x45_Stanag_Tracer_Green",nil],
				["30Rnd_556x45_Stanag_Tracer_Yellow",nil],
				["30Rnd_65x39_caseless_green",nil],
				["30Rnd_65x39_caseless_green_mag_Tracer",nil],
				["30Rnd_65x39_caseless_mag",nil],
				["30Rnd_65x39_caseless_mag_Tracer",nil],
				["10Rnd_762x54_Mag",nil],
				["20Rnd_762x51_Mag",nil]
			]
		];
	};
	
	case "under":
	{
		["Undercover",
			[
				["itemMap",nil],
				["itemGPS",nil],
				["ItemRadio","Cell"],
				["ItemCompass",nil],
				["ItemWatch",nil],
				["Binocular",nil],
				["FirstAidKit",nil],
				["ToolKit",nil],
				["Medikit","Stabilization Kit"],
				["NVGoggles_INDEP",nil],
				["hgun_P07_F",nil],
				["hgun_Rook40_F",nil],
				["16Rnd_9x21_Mag",nil],
				["hgun_PDW2000_F",nil],
				["SMG_02_F",nil],
				["30Rnd_9x21_Mag",nil],
				["hgun_ACPC2_F",nil],
				["9Rnd_45ACP_Mag",nil],
				["hgun_Pistol_heavy_01_F",nil],
				["11Rnd_45ACP_Mag",nil],
				["optic_MRD",nil],
				["hgun_Pistol_heavy_02_F",nil],
				["6Rnd_45ACP_Cylinder",nil],
				["optic_Yorris",nil],
				["SMG_01_F",nil],
				["30Rnd_45ACP_Mag_SMG_01",nil],
				["30Rnd_45ACP_Mag_SMG_01_Tracer_Green",nil],
				["arifle_TRG20_F",nil],
				["arifle_TRG21_F",nil],	
				["arifle_Mk20C_F",nil],	
				["arifle_Mk20_F",nil],
				["30Rnd_556x45_Stanag",nil],
				["30Rnd_556x45_Stanag_Tracer_Red",nil],
				["30Rnd_556x45_Stanag_Tracer_Green",nil],
				["30Rnd_556x45_Stanag_Tracer_Yellow",nil],
				["arifle_MXC_F",nil],
				["30Rnd_65x39_caseless_mag",nil],
				["30Rnd_65x39_caseless_mag_Tracer",nil],
				["hgun_Pistol_Signal_F","Flare Gun"],
				["6Rnd_RedSignal_F",nil],
				["6Rnd_GreenSignal_F",nil],
				["B_IR_Grenade",nil],
				["MiniGrenade","Flashbang"],
				["SmokeShell",nil],
				["SmokeShellRed",nil],
				["SmokeShellGreen",nil],
				["SmokeShellPurple",nil],
				["SmokeShellBlue",nil],
				["SmokeShellOrange",nil],
				["SmokeShellYellow","Tear Gas"],
				["optic_Aco_smg",nil],
				["optic_ACO_grn_smg",nil],
				["optic_ACO",nil],
				["optic_ACO_grn",nil],
				["optic_Holosight_smg",nil],
				["optic_Holosight",nil],
				["optic_MRCO",nil],
				["optic_Arco",nil],
				["optic_Hamr",nil],
				["acc_flashlight",nil],
				["acc_pointer_IR",nil],
				["bipod_01_F_blk","Deployable Bipod"]
			]
		];
	};
};
