#include <macro.h>
/*
	File: fn_clothing_cop.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master config file for Cop clothing store.
*/
private["_filter","_ret"];
_filter = param [0,0,[0]];
/*Classname, Custom Display name (use nil for Cfg->DisplayName, price*/

/*Shop Title Name*/
ctrlSetText[3103,"Altis Police Department Shop"];

_ret = [];
switch (_filter) do
{
	/*Uniforms*/
	case 0:
	{
		switch (__GETC__(life_coplevel)) do {
			case 0: { _ret pushBack ["U_Rangemaster","Cadet Uniform",10]; };
			case 1: { _ret pushBack ["U_Rangemaster","Cadet Uniform",10]; };
			case 2: { _ret pushBack ["U_Rangemaster","PO Uniform",10]; };
			case 3: { _ret pushBack ["U_Rangemaster","SPO Uniform",10]; };
			case 4: { _ret pushBack ["U_Rangemaster","Corporal Uniform",10]; };
			case 5: { _ret pushBack ["U_Rangemaster","Sergeant Uniform",10]; };
			case 6: { _ret pushBack ["U_Rangemaster","Lieutenant Uniform",10]; };
			case 7: { _ret pushBack ["U_Rangemaster","Captain Uniform",10]; };
			case 8: { _ret pushBack ["U_Rangemaster","Superintendent Uniform",10]; };
		};
		switch (__GETC__(life_coplevel)) do {
			case 4: { _ret pushBack ["U_IG_Guerilla2_1","Corporal (New)",10]; };
			case 5: { _ret pushBack ["U_IG_Guerilla2_1","Sergeant (New)",10]; };
			case 6: { _ret pushBack ["U_IG_Guerilla2_1","Lieutenant (New)",10]; };
			case 7: { _ret pushBack ["U_IG_Guerilla2_1","Captain (New)",10]; };
			case 8: { _ret pushBack ["U_IG_Guerilla2_1","Superintendent (new)",10]; };
		};

		_ret pushBack ["U_B_Wetsuit",nil,200];
	};
	
	/*Hats*/
	case 1:
	{
	
		if(__GETC__(life_coplevel) >= 0) then
		{
			_ret pushBack ["H_Cap_blk","Cadet Hat",10];
			_ret pushBack ["H_Cap_usblack",nil,10];
			_ret pushBack ["H_Cap_police",nil,10];
			_ret pushBack ["H_MilCap_gry",nil,10];
			_ret pushBack ["H_Cap_blk_CMMG",nil,10];
			_ret pushBack ["H_Cap_blk_ION",nil,10];
			_ret pushBack ["H_Watchcap_blk",nil,10];
			_ret pushBack ["H_Watchcap_sgg",nil,10];
			_ret pushBack ["H_Watchcap_khk",nil,10];
			_ret pushBack ["H_Watchcap_camo",nil,10];
			_ret pushBack ["H_Watchcap_cbr",nil,10];
			_ret pushBack ["H_Booniehat_khk_hs",nil,10];
			_ret pushBack ["H_MilCap_blue",nil,10];
		};

		if(__GETC__(life_coplevel) > 1) then
		{
			_ret pushBack ["H_HelmetSpecB_blk",nil,100];
			_ret pushBack ["H_HelmetSpecB_paint1",nil,100];
			_ret pushBack ["H_HelmetSpecB_paint2",nil,100];
			_ret pushBack ["H_HelmetB_light_black",nil,100];
			_ret pushBack ["H_HelmetB_light_sand",nil,100];
			_ret pushback ["H_HelmetB_light",nil,100];
			_ret pushBack ["H_HelmetB_plain_blk",nil,100];
			_ret pushBack ["H_HelmetB",nil,100];
			_ret pushBack ["H_HelmetB_desert",nil,100];
			_ret pushBack ["H_HelmetB_grass",nil,100];
			_ret pushBack ["H_HelmetB_snakeskin",nil,100];
			_ret pushBack ["H_HelmetB_sand",nil,100];
			_ret pushBack ["H_HelmetB_paint",nil,100];
			_ret pushBack ["H_Helmet_Kerry",nil,100];
			_ret pushback ["H_HelmetB_light_grass",nil,100];
			_ret pushBack ["H_HelmetB_light_snakeskin",nil,100];
			_ret pushBack ["H_HelmetB_light_desert",nil,100];
			
		};

		if(__GETC__(life_coplevel) > 2) then
		{
			_ret pushBack ["H_PilotHelmetHeli_B",nil,500];	
		};
		
		if(__GETC__(life_copLevel) > 4) then 
		{
			_ret pushBack ["H_CrewHelmetHeli_B",nil,10000];
		};
		
		if(__GETC__(life_copLevel) > 5) then 
		{
			_ret pushBack ["H_Beret_02",nil,10];
			_ret pushBack ["H_Beret_blk",nil,10];
			_ret pushBack ["H_Beret_Colonel",nil,100];
		};
	};
	
	/*Glasses*/
	case 2:
	{
		_ret =
		[
			["G_Diving",nil,50],
			["G_Shades_Black",nil,2],
			["G_Shades_Blue",nil,2],
			["G_Sport_Blackred",nil,2],
			["G_Sport_Checkered",nil,2],
			["G_Sport_Blackyellow",nil,2],
			["G_Sport_BlackWhite",nil,2],
			["G_Aviator",nil,7],
			["G_Squares",nil,1],
			["G_Lowprofile",nil,3],
			["G_Tactical_Black",nil,5],
			["G_Tactical_Clear",nil,5],
			["G_Combat",nil,55],
			["G_Goggles_VR",nil,5]
		];
	};
	
	/*Vest*/
	case 3:
	{
		_ret pushBack ["V_Rangemaster_belt",nil,80];
		_ret pushBack ["V_RebreatherB",nil,500];
		_ret pushBack ["V_TacVest_blk_POLICE",nil,150];
		_ret pushBack ["V_Chestrig_blk",nil,150];
		if(__GETC__(life_coplevel) > 1) then
		{
			_ret pushBack ["V_PlateCarrier1_blk",nil,150];
			_ret pushBack ["V_PlateCarrier2_blk",nil,2500];
			_ret pushBack ["V_TacVestIR_blk",nil,150];
		};
	};
	
	/*Backpacks*/
	case 4:
	{
		_ret pushBack ["B_AssaultPack_blk",nil,50];
		_ret pushBack ["B_Kitbag_sgg","Invisi-Bag",100];
		if(__GETC__(life_coplevel) > 1) then
		{
			_ret pushBack ["B_Bergen_blk",nil,65];
		};
		if(__GETC__(life_coplevel) > 2) then
		{
			_ret pushBack ["B_TacticalPack_rgr",nil,80];
			_ret pushBack ["B_TacticalPack_mcamo",nil,80];
			_ret pushBack ["B_TacticalPack_ocamo",nil,80];
			_ret pushBack ["B_TacticalPack_oli",nil,80];
			_ret pushBack ["B_Bergen_sgg",nil,80];
			_ret pushBack ["B_FieldPack_ocamo",nil,300];
			_ret pushBack ["B_FieldPack_khk",nil,300];
			_ret pushBack ["B_FieldPack_oucamo",nil,300];
			_ret pushBack ["B_FieldPack_cbr",nil,300];
			_ret pushBack ["B_FieldPack_blk",nil,300];
		};
		if(__GETC__(life_coplevel) > 0) then
		{
			_ret pushBack ["B_Kitbag_rgr",nil,100];
			_ret pushBack ["B_Kitbag_cbr",nil,100];
			_ret pushBack ["B_Kitbag_mcamo",nil,100];
		};
		if(__GETC__(life_coplevel) > 4) then
		{
			_ret pushBack ["B_Carryall_oli",nil,120];
			_ret pushBack ["B_Carryall_ocamo",nil,120];
			_ret pushBack ["B_Carryall_oucamo",nil,120];
			_ret pushBack ["B_Carryall_mcamo",nil,120];
			_ret pushBack ["B_Carryall_khk",nil,120];
			_ret pushBack ["B_Carryall_cbr",nil,120];
			_ret pushBack ["B_UAV_01_backpack_F",nil,2500];
		};
	};
};

_ret;