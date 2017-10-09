/*
	File: fn_clothing_bruce.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master configuration file for Bruce's Outback Outfits.
*/
private["_filter"];
_filter = param [0,0,[0]];
_isStore = param[1,true];
/*Classname, Custom Display name (use nil for Cfg->DisplayName, price*/

/*Shop Title Name*/
if(_isStore) then {
	ctrlSetText[3103,"Bruce's Outback Outfits"];
};

switch (_filter) do
{
	/*Uniforms*/
	case 0:
	{
		[
			["U_Marshal","Marshal Uniform", 100],
			["U_C_Poloshirt_blue","Poloshirt STS",25],
			["U_BG_Guerilla2_2",nil,35],
			["U_C_Poloshirt_burgundy","Poloshirt Burgundy",27],
			["U_C_Poloshirt_redwhite","Poloshirt Red/White",15],
			["U_Competitor",nil,100],
			["U_C_Poloshirt_salmon","Poloshirt Salmon",17],
			["U_C_Poloshirt_stripped","Lumberjack",12],
			["U_C_Poloshirt_tricolour","Poloshirt Tricolor",35],
			["U_C_Poor_2","Rag tagged clothes",25],
			["U_C_WorkerCoveralls",nil,25],
			["U_C_HunterBody_grn","Green Hunter",150],
			["U_IG_Guerilla2_2","Green Striped shirt & Pants",65],																												
			["U_IG_Guerilla3_1","Brown Jacket & Pants",73],
			["U_IG_Guerilla2_3","The Outback Wrangler",120],
			["U_OrestesBody","Surfing On Land",110],
			["U_C_Scientist","Scientist",300],	
			["U_NikosBody","Badass Uniform",500],
			["U_C_Journalist","Journalist Clothes",500],
			["U_NikosAgedBody","Business Casual",500],
			["U_C_Driver_1_black",nil,150],
	 		["U_C_Driver_1_blue",nil,150],
	 		["U_C_Driver_1_red",nil,150],
	 		["U_C_Driver_1_orange",nil,150],
	 		["U_C_Driver_1_green",nil,150],
	 		["U_C_Driver_1_white",nil,150],
	 		["U_C_Driver_1_yellow",nil,150],
	 		["U_C_Driver_2",nil,350],
	 		["U_C_Driver_1",nil,360],
	 		["U_C_Driver_3",nil,370],
	 		["U_C_Driver_4",nil,370]
			
			
		];
	};
	
	/*Hats*/
	case 1:
	{
		[
			["H_Cap_marshal","Marshal Hat",17],
			["H_Bandanna_surfer","Surfer Bandanna",13],
			["H_Bandanna_gry","Grey Bandanna",15],
			["H_Bandanna_cbr",nil,16],
			["H_Bandanna_khk","Khaki Bandanna",14],
			["H_Bandanna_sgg","Sage Bandanna",16],
			["H_Bandanna_blu",nil,15],
			["H_Bandanna_sand",nil,15],
			["H_Bandanna_surfer_blk",nil,13],
			["H_Bandanna_surfer_grn",nil,13],
			["H_StrawHat","Straw Fedora",22],
			["H_BandMask_blk","Hat & Bandanna",30],
			["H_BandMask_khk","Bike Helmet",100],
			["H_Hat_blue",nil,31],
			["H_Hat_brown",nil,27],
			["H_Hat_checker",nil,34],
			["H_Hat_grey",nil,28],
			["H_Hat_tan",nil,26],
			["H_Cap_blu",nil,15],
			["H_Cap_grn",nil,15],
			["H_Cap_grn_BI",nil,15],
			["H_Cap_oli",nil,15],
			["H_Cap_red",nil,15],
			["H_Cap_tan",nil,15],
			["H_Cap_blk_CMMG","Black Cap",20],
			["H_Cap_blk_ION",nil,10],
			["H_Cap_press","Press Cap",80],
			["H_TurbanO_blk","Striped Boonie",15],
			["H_Booniehat_khk",nil,100],
			["H_Booniehat_oli",nil,100],
			["H_Booniehat_grn",nil,100],
			["H_Booniehat_tan",nil,100],
			["H_RacingHelmet_1_black_F",nil,100],
 			["H_RacingHelmet_1_red_F",nil,100],
 			["H_RacingHelmet_1_white_F",nil,100],
 			["H_RacingHelmet_1_blue_F",nil,100],
 			["H_RacingHelmet_1_yellow_F",nil,100],
 			["H_RacingHelmet_1_green_F",nil,100],
 			["H_RacingHelmet_1_F",nil,250],
 			["H_RacingHelmet_2_F",nil,250],
 			["H_RacingHelmet_3_F",nil,250],
 			["H_RacingHelmet_4_F",nil,250]
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
			["G_Lady_Blue",nil,15]
		];
	};
	
	/*Vest*/
	case 3:
	{
		if(undercover) exitWith {
		[
			["V_Rangemaster_belt",nil,250],
			["V_TacVest_khk",nil,1250],
			["V_TacVest_brn",nil,1250],
			["V_TacVest_camo",nil,1250],
			["V_TacVest_oli",nil,1250],
			["V_BandollierB_rgr",nil,450],
			["V_BandollierB_oli",nil,450],
			["V_BandollierB_cbr",nil,450],
			["V_Chestrig_oli",nil,750],
			["V_Chestrig_khk",nil,750],
			["V_Chestrig_blk",nil,750],
			["V_HarnessO_brn",nil,750],
			["V_HarnessO_gry",nil,750],
			["V_HarnessOGL_brn",nil,1000],
			["V_HarnessOGL_gry",nil,1000]
		];
		};
		[
		["V_Rangemaster_belt",nil,250],
		["V_BandollierB_khk",nil,250],
		["V_BandollierB_cbr",nil,250],
		["V_BandollierB_rgr",nil,250],
		["V_BandollierB_oli",nil,250],
		["V_BandollierB_blk",nil,250],
		["V_Press_F",nil,250]
		];
	};
	
	/*Backpacks*/
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
			["B_Kitbag_sgg","Invisi-Bag",1000],
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
