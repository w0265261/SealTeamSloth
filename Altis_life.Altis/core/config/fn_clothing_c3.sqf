/*
	File: fn_clothing_c3.sqf
	Author: Kevin
	
	Description:
	Master configuration file for C3 shop.
*/
private["_filter"];
_filter = param [0,0,[0]];
/*Classname, Custom Display name (use nil for Cfg->DisplayName, price*/

/*Shop Title Name*/
ctrlSetText[3103,"Mercenary Clothing"];

switch (_filter) do
{
	/*Uniforms*/
	case 0:
	{
		[
			["U_B_CTRG_1",nil,1000],
			["U_B_CTRG_2",nil,1000],
			["U_B_CTRG_3",nil,1000],
			["U_B_survival_uniform",nil,1000],
			["U_B_CombatUniform_mcam",nil,1000],
			["U_B_GhillieSuit",nil,2500],
			["U_B_CombatUniform_mcam_vest",nil,1000],
			["U_I_G_Story_Protagonist_F",nil,750],
			["U_B_CombatUniform_mcam_tshirt",nil,750],
			["U_I_G_resistanceLeader_F",nil,1150],
			["U_Competitor","Competitor",500],
			["U_OG_Guerrilla_6_1",nil,500],
			["U_Marshal","Marshal Uniform", 100],
			["U_IG_Guerilla2_1",nil,500],
			["U_OG_Guerilla2_2",nil,500],
			["U_OG_Guerilla3_1",nil,500],
			["U_BG_Guerilla2_1",nil,500],
			["U_B_FullGhillie_lsh",nil,5000],
			["U_B_FullGhillie_sard",nil,5000],
			["U_B_FullGhillie_ard",nil,5000]
			
		];
	};
	
	/*Hats*/
	case 1:
	{
		[
			["H_Booniehat_khk",nil,100],
			["H_Booniehat_oli",nil,100],
			["H_Booniehat_mcamo",nil,100],
			["H_Booniehat_grn",nil,100],
			["H_Booniehat_tan",nil,100],
			["H_Booniehat_dgtl",nil,100],
			["H_Booniehat_khk_hs",nil,100],
			["H_MilCap_ocamo",nil,100],
			["H_MilCap_mcamo",nil,100],
			["H_MilCap_oucamo",nil,120],
			["H_MilCap_dgtl",nil,150],
			["H_MilCap_gry",nil,150],
			["H_MilCap_blue",nil,150],
			["H_Cap_headphones",nil,120],
			["H_Cap_marshal","Marshal Hat",17],
			["H_Bandanna_camo",nil,65],
			["H_Bandanna_khk_hs",nil,100],
			["H_Bandanna_mcamo",nil,65],
			["H_Hat_camo",nil,15],
			["H_Cap_blk_CMMG",nil,100],
			["H_Cap_brn_SPECOPS",nil,100],
			["H_Cap_tan_specops_US",nil,100],
			["H_Cap_khaki_specops_UK",nil,100],
			["H_Cap_blk_ION",nil,10],
			["H_Cap_grn_BI",nil,100],
			["H_Cap_blk_Raven",nil,100],
			["H_Cap_oli_hs",nil,100],
			["H_Watchcap_blk",nil,10],
			["H_Watchcap_sgg",nil,10],
			["H_Watchcap_khk",nil,10],
			["H_Watchcap_camo",nil,10],
			["H_Watchcap_cbr",nil,10],
			["H_HelmetIA_camo",nil,500],
			["H_HelmetB_camo",nil,500],
			["H_HelmetCrew_I",nil,500],
			["H_HelmetCrew_O",nil,500],
			["H_HelmetCrew_B",nil,500],
			["H_PilotHelmetHeli_O",nil,2500],
			["H_PilotHelmetHeli_I",nil,2500],
			["H_CrewHelmetHeli_O",nil,10000],
			["H_CrewHelmetHeli_I",nil,10000]

		];
	};
	
	/*Glasses*/
	case 2:
	{
		[
			["G_Bandanna_aviator","Aviator Bandanna",50],
			["G_Bandanna_beast","Beast Bandanna",50],
			["G_Bandanna_blk","Black Bandanna",50],
			["G_Bandanna_khk","Khaki Bandanna",50],
			["G_Bandanna_oli","Olive Bandanna",50],
			["G_Bandanna_shades","Bandanna with Shades",50],
			["G_Bandanna_sport","Sport Bandanna",50],
			["G_Bandanna_tan","Tan Bandanna",50],
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
			["G_Lady_Blue",nil,15],
			["G_Goggles_VR",nil,5],
			["G_Tactical_Black",nil,5],
			["G_Tactical_Clear",nil,5],
			["G_Lowprofile",nil,3],
			["G_Combat",nil,5]
		];
	};
	
	/*Vest*/
	case 3:
	{
		[
			["V_PlateCarrierL_CTRG",nil,1500],
			["V_PlateCarrierH_CTRG",nil,1500],
			["V_PlateCarrier_Kerry",nil,1500],
			["V_PlateCarrier1_rgr",nil,1500],
			["V_PlateCarrier2_rgr",nil,1500],
			["V_TacVest_khk",nil,1250],
			["V_TacVest_brn",nil,1250],
			["V_TacVest_camo",nil,1250],
			["V_TacVest_oli",nil,1250],
			["V_I_G_resistanceLeader_F",nil,1250],
			["V_Rangemaster_belt",nil,250],
			["V_BandollierB_khk",nil,250],
			["V_BandollierB_cbr",nil,250],
			["V_BandollierB_rgr",nil,250],
			["V_BandollierB_oli",nil,250],
			["V_BandollierB_blk",nil,250],
			["V_HarnessO_brn",nil,750],
			["V_HarnessOGL_gry",nil,750],
			["V_HarnessOGL_gry",nil,1000],
			["V_HarnessOGL_brn",nil,1000],
			["V_Chestrig_khk",nil,750],
			["V_Chestrig_oli",nil,750],
			["V_Chestrig_rgr",nil,750]
			

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
