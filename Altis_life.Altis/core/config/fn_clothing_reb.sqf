/*
	File: fn_clothing_reb.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master configuration file for Reb shop.
*/
private["_filter"];
_filter = param [0,0,[0]];
/*Classname, Custom Display name (use nil for Cfg->DisplayName, price*/

/*Shop Title Name*/
ctrlSetText[3103,"Mohammed's Jihadi Shop"];

switch (_filter) do
{
	/*Uniforms*/
	case 0:
	{
		[
			["U_IG_Guerilla1_1",nil,500],
			["U_OG_Guerrilla_6_1",nil,500],
			["U_O_CombatUniform_oucamo",nil,500],
			["U_I_G_Story_Protagonist_F",nil,500],
			["U_I_G_resistanceLeader_F",nil,500],
			["U_O_OfficerUniform_ocamo",nil,500],
			["U_IG_leader","Guerilla Leader",500],
			["U_I_Wetsuit",nil,2000],
			["U_O_Wetsuit",nil,2000],
			["U_B_Wetsuit",nil,2000],
			["U_B_HeliPilotCoveralls",nil,500],
			["U_B_PilotCoveralls",nil,500],
			["U_O_PilotCoveralls",nil,500],
			["U_I_pilotCoveralls",nil,500],
			["U_I_HeliPilotCoveralls",nil,500],
			["U_O_CombatUniform_ocamo",nil,500],
			["U_I_OfficerUniform",nil,500],
			["U_I_CombatUniform",nil,500],
			["U_I_CombatUniform_shortsleeve",nil,500],
			["U_O_GhillieSuit",nil,2500],
			["U_I_GhillieSuit",nil,2500],
			["U_I_FullGhillie_ard",nil,4000],			
			["U_I_FullGhillie_sard",nil,4000],
			["U_I_FullGhillie_lsh",nil,4000],
			["U_O_FullGhillie_ard",nil,4000],			
			["U_O_FullGhillie_sard",nil,4000],
			["U_O_FullGhillie_lsh",nil,4000]
		];
	};
	
	/*Hats*/
	case 1:
	{
		[
			["H_ShemagOpen_tan",nil,850],
			["H_Shemag_tan","Shemag (Pattern)",850],
			["H_Shemag_olive",nil,850],
			["H_Shemag_olive_hs",nil,850],
			["H_ShemagOpen_khk",nil,800],
			["H_Cap_brn_SPECOPS",nil,100],
			["H_Cap_tan_specops_US",nil,100],
			["H_Cap_khaki_specops_UK",nil,100],
			["H_Cap_blk_Raven",nil,100],
			["H_Cap_oli_hs",nil,100],
			["H_MilCap_ocamo",nil,100],
			["H_MilCap_mcamo",nil,100],
			["H_MilCap_oucamo",nil,120],
			["H_MilCap_dgtl",nil,150],
			["H_MilCap_gry",nil,150],
			["H_MilCap_blue",nil,150],
			["H_Hat_camo",nil,150],
			["H_HelmetO_ocamo",nil,250],
			["H_HelmetO_oucamo",nil,250],
			["H_HelmetIA_net",nil,250],
			["H_HelmetCrew_I",nil,250],
			["H_HelmetCrew_B",nil,250],
			["H_HelmetCrew_O",nil,250],
			["H_HelmetLeaderO_ocamo",nil,250],
			["H_HelmetLeaderO_oucamo",nil,250],
			["H_Cap_headphones",nil,200],
			["H_Booniehat_khk",nil,100],
			["H_Booniehat_oli",nil,100],
			["H_Booniehat_mcamo",nil,100],
			["H_Booniehat_grn",nil,100],
			["H_Booniehat_tan",nil,100],
			["H_Booniehat_dgtl",nil,100],
			["H_Booniehat_khk_hs",nil,100],
			["H_Bandanna_camo",nil,50],
			["H_Bandanna_khk_hs",nil,50],
			["H_Bandanna_mcamo",nil,50],
			["H_Watchcap_blk",nil,10],
			["H_Watchcap_sgg",nil,10],
			["H_Watchcap_khk",nil,10],
			["H_Watchcap_camo",nil,10],
			["H_Watchcap_cbr",nil,10],
			["H_HelmetB_camo",nil,1000],
			["H_CrewHelmetHeli_O",nil,10000],
			["H_CrewHelmetHeli_I",nil,10000],
			["H_PilotHelmetHeli_O",nil,2500],
			["H_PilotHelmetHeli_I",nil,2500],
			["H_HelmetSpecO_ocamo",nil,250],
			["H_HelmetSpecO_blk",nil,250]

		];
	};
	
	/*Glasses*/
	case 2:
	{
		[
			["G_Shades_Black",nil,2],
			["G_Shades_Blue",nil,2],
			["G_Shades_Green",nil,2],
			["G_Shades_Red",nil,2],
			["G_spectacles",nil,2],
			["G_spectacles_tinted",nil,2],
			["G_Sport_Blackred",nil,2],
			["G_Sport_Checkered",nil,2],
			["G_Sport_Blackyellow",nil,2],
			["G_Sport_BlackWhite",nil,2],
			["G_Sport_Red",nil,2],
			["G_Sport_GreenBlack",nil,2],
			["G_Squares_tinted",nil,1],
			["G_Aviator",nil,10],
			["G_Goggles_VR",nil,5],
			["G_Tactical_Black",nil,5],
			["G_Tactical_Clear",nil,5],
			["G_Lowprofile",nil,3],
			["G_Combat",nil,5],
			["G_Balaclava_blk",nil,850],
			["G_Balaclava_combat",nil,850],
			["G_Balaclava_lowprofile",nil,850],
			["G_Balaclava_oli",nil,850],
			["G_Bandanna_aviator",nil,10],
			["G_Bandanna_beast",nil,10],
			["G_Bandanna_blk",nil,10],
			["G_Bandanna_khk",nil,10],
			["G_Bandanna_oli",nil,10],
			["G_Bandanna_shades",nil,10],
			["G_Bandanna_sport",nil,10],
			["G_Bandanna_tan",nil,10]
		];
	};
	
	/*Vest*/
	case 3:
	{
		[
			["V_Rangemaster_belt",nil,250],
			["V_TacVest_khk",nil,1250],
			["V_TacVest_brn",nil,1250],
			["V_TacVest_camo",nil,1250],
			["V_TacVest_oli",nil,1250],
			["V_I_G_resistanceLeader_F",nil,1250],
			["V_BandollierB_khk",nil,250],
			["V_BandollierB_cbr",nil,250],
			["V_BandollierB_rgr",nil,250],
			["V_BandollierB_oli",nil,250],
			["V_BandollierB_blk",nil,250],
			["V_Chestrig_khk",nil,750],
			["V_Chestrig_oli",nil,750],
			["V_Chestrig_rgr",nil,750],
			["V_HarnessO_brn",nil,750],
			["V_HarnessO_gry",nil,750],
			["V_HarnessOGL_brn",nil,1000],
			["V_HarnessOGL_gry",nil,1000],
			["V_PlateCarrierIA1_dgtl",nil,1000],
			["V_PlateCarrierIA2_dgtl",nil,1500],
			["V_PlateCarrierIAGL_dgtl",nil,3000],
			["V_RebreatherIR","Camo Rebreather",5000],
			["V_RebreatherIA","Green Rebreather",5000],
			["V_RebreatherB","Black Rebreather",5000]

		];
	};
	
	case 4:
	{
		[
			["B_AssaultPack_dgtl",nil,300],
			["B_AssaultPack_ocamo",nil,300],
			["B_AssaultPack_blk",nil,300],
			["B_AssaultPack_cbr",nil,300],
			["B_AssaultPack_mcamo",nil,300],
			["B_AssaultPack_rgr",nil,300],
			["B_AssaultPack_khk",nil,300],			
			["B_AssaultPack_sgg",nil,300],
			["B_FieldPack_ocamo",nil,300],
			["B_FieldPack_khk",nil,300],
			["B_FieldPack_oucamo",nil,300],
			["B_FieldPack_cbr",nil,300],
			["B_FieldPack_blk",nil,300],
			["B_Kitbag_rgr",nil,300],
			["B_Kitbag_cbr",nil,300],
			["B_Kitbag_mcamo",nil,300],
			["B_Kitbag_sgg","Invisi-Bag",300],
			["B_TacticalPack_ocamo",nil,300],
			["B_TacticalPack_oli",nil,300],
			["B_Bergen_sgg",nil,300],
			["B_Bergen_mcamo",nil,300],
			["B_Bergen_rgr",nil,300],
			["B_Bergen_blk",nil,300],			
			["B_Carryall_oli",nil,300],
			["B_Carryall_ocamo",nil,300],
			["B_Carryall_oucamo",nil,300],
			["B_Carryall_mcamo",nil,300],
			["B_Carryall_cbr",nil,300],
			["B_Carryall_khk",nil,300]
		];
	};
};
