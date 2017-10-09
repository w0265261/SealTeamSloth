/*
	Author: Kayler "K-Town" Renslow
*/
class CfgRecipes
{
	class TerminalItems{
		class craft_term_EMR {
			displayName = "MK-I EMR Battle Rifle";
			recipe[] = {"craft_EMRBarrel", "craft_EMRHandguard", "craft_EMRUpper", "craft_EMRLower", "craft_rifleTrigger"};
			recipeIngredientCount[] = {1, 1, 1, 1, 1};
			creationTime = 20;
			onCreation = "[""srifle_DMR_03_tan_F"",1] call life_fnc_handleCrafted;";
		};		
		class craft_term_ABR {
			displayName = "MK-18 ABR Battle Rifle";
			recipe[] = {"craft_ABRBarrel", "craft_ABRHandguard", "craft_ABRUpper", "craft_ABRLower", "craft_rifleTrigger"};
			recipeIngredientCount[] = {1, 1, 1, 1, 1};
			creationTime = 20;
			onCreation = "[""srifle_EBR_F"",1] call life_fnc_handleCrafted;";
		};	
		class craft_term_rahimgun {
			displayName = "Rahim 7.62mm rifle";
			recipe[] = {"craft_rahimBarrel", "craft_rahimHandguard", "craft_rahimUpper", "craft_rahimLower", "craft_rifleTrigger"};
			recipeIngredientCount[] = {1, 1, 1, 1, 1};
			creationTime = 20;
			onCreation = "[""srifle_DMR_01_F"",1] call life_fnc_handleCrafted;";
		};			
		class craft_term_katiba {
			displayName = "Katiba 6.5mm Rifle";
			recipe[] = {"craft_rifleBarrel", "craft_katibaHandguard", "craft_katibaUpper", "craft_katibaLower", "craft_rifleTrigger"};
			recipeIngredientCount[] = {1, 1, 1, 1, 1};
			creationTime = 20;
			onCreation = "[""arifle_katiba_f"",1] call life_fnc_handleCrafted;";
		};
		class craft_term_katibaC {
			displayName = "Katiba 6.5mm Carbine";
			recipe[] = {"craft_carbineBarrel", "craft_katibaHandguard", "craft_katibaUpper", "craft_katibaLower", "craft_rifleTrigger"};
			recipeIngredientCount[] = {1, 1, 1, 1, 1};
			creationTime = 20;
			onCreation = "[""arifle_Katiba_C_F"",1] call life_fnc_handleCrafted;";
		};		
		class craft_term_MX {
			displayName = "MX 6.5mm Rifle";
			recipe[] = {"craft_rifleBarrel", "craft_MXHandguard", "craft_MXUpper", "craft_MXLower", "craft_rifleTrigger"};
			recipeIngredientCount[] = {1, 1, 1, 1, 1};
			creationTime = 20;
			onCreation = "[""arifle_MX_F"",1] call life_fnc_handleCrafted;";
		};	
		class craft_term_MXC {
			displayName = "MX 6.5mm Carbine";
			recipe[] = {"craft_carbineBarrel", "craft_MXHandguard", "craft_MXUpper", "craft_MXLower", "craft_rifleTrigger"};
			recipeIngredientCount[] = {1, 1, 1, 1, 1};
			creationTime = 20;
			onCreation = "[""arifle_MXC_F"",1] call life_fnc_handleCrafted;";
		};	
		class craft_term_TRG21 {
			displayName = "TRG 5.56mm Rifle";
			recipe[] = {"craft_rifleBarrel", "craft_TRGHandguard", "craft_TRGUpper", "craft_TRGLower", "craft_rifleTrigger"};
			recipeIngredientCount[] = {1, 1, 1, 1, 1};
			creationTime = 20;
			onCreation = "[""arifle_TRG21_F"",1] call life_fnc_handleCrafted;";
		};
		class craft_term_TRG20 {
			displayName = "TRG 5.56mm Carbine";
			recipe[] = {"craft_carbineBarrel", "craft_TRGHandguard", "craft_TRGUpper", "craft_TRGLower", "craft_rifleTrigger"};
			recipeIngredientCount[] = {1, 1, 1, 1, 1};
			creationTime = 20;
			onCreation = "[""arifle_TRG20_F"",1] call life_fnc_handleCrafted;";
		};
		class craft_term_MK20 {
			displayName = "MK20 5.56mm Rifle";
			recipe[] = {"craft_rifleBarrel", "craft_MKHandguard", "craft_MKUpper", "craft_MKLower", "craft_rifleTrigger"};
			recipeIngredientCount[] = {1, 1, 1, 1, 1};
			creationTime = 20;
			onCreation = "[""arifle_Mk20_F"",1] call life_fnc_handleCrafted;";
		};		
		class craft_term_MK20C {
			displayName = "MK20 5.56mm Carbine";
			recipe[] = {"craft_carbineBarrel", "craft_MKHandguard", "craft_MKUpper", "craft_MKLower", "craft_rifleTrigger"};
			recipeIngredientCount[] = {1, 1, 1, 1, 1};
			creationTime = 20;
			onCreation = "[""arifle_Mk20C_F"",1] call life_fnc_handleCrafted;";
		};	
		class craft_term_vermin {
			displayName = "Vermin .45ACP SMG";
			recipe[] = {"craft_smgBarrel", "craft_verminHandguard", "craft_verminUpper", "craft_verminLower", "craft_SMGTrigger"};
			recipeIngredientCount[] = {1, 1, 1, 1, 1};
			creationTime = 20;
			onCreation = "[""SMG_01_F"",1] call life_fnc_handleCrafted;";
		};
		class craft_term_PDW {
			displayName = "PDW2000 SMG";
			recipe[] = {"craft_smgBarrel", "craft_PDWHandguard", "craft_PDWUpper", "craft_PDWLower", "craft_SMGTrigger"};
			recipeIngredientCount[] = {1, 1, 1, 1, 1};
			creationTime = 20;
			onCreation = "[""hgun_PDW2000_F"",1] call life_fnc_handleCrafted;";
		};
		class craft_term_sting {
			displayName = "Sting 9mm SMG";
			recipe[] = {"craft_smgBarrel", "craft_stingHandguard", "craft_stingUpper", "craft_stingLower", "craft_SMGTrigger"};
			recipeIngredientCount[] = {1, 1, 1, 1, 1};
			creationTime = 20;
			onCreation = "[""SMG_02_F"",1] call life_fnc_handleCrafted;";
		};	
		class craft_term_ACO {
			displayName = "Close Range ACO (G)";
			recipe[] = {"craft_gSight","craft_gFrame"};
			recipeIngredientCount[] = {1, 1};
			creationTime = 5;
			onCreation = "[""optic_Aco_smg"",0] call life_fnc_handleCrafted;";
		};
		class craft_term_ACOr {
			displayName = "Close Range ACO (R)";
			recipe[] = {"craft_gSight","craft_gFrame"};
			recipeIngredientCount[] = {1, 1};
			creationTime = 5;
			onCreation = "[""optic_ACO_grn_smg"",0] call life_fnc_handleCrafted;";
		};
		class craft_term_Holo {
			displayName = "Close Range Holosight";
			recipe[] = {"craft_gSight","craft_gFrame"};
			recipeIngredientCount[] = {1, 1};
			creationTime = 5;
			onCreation = "[""optic_Holosight_smg"",0] call life_fnc_handleCrafted;";
		};
		class craft_term_RCO {
			displayName = "HAMR Combat Optic (6x) (RCO)";
			recipe[] = {"craft_lSight","craft_lFrame"};
			recipeIngredientCount[] = {1, 1};
			creationTime = 5;
			onCreation = "[""optic_Hamr"",0] call life_fnc_handleCrafted;";
		};
		class craft_term_ARCO {
			displayName = "Advanced Combat Optic (6x) (ARC0)";
			recipe[] = {"craft_lSight","craft_lFrame"};
			recipeIngredientCount[] = {1, 1};
			creationTime = 5;
			onCreation = "[""optic_Arco"",0] call life_fnc_handleCrafted;";
		};
		class craft_term_MRCO {
			displayName = "Modern Combat Optic (6x) (MRCO)";
			recipe[] = {"craft_lSight","craft_lFrame"};
			recipeIngredientCount[] = {1, 1};
			creationTime = 5;
			onCreation = "[""optic_MRCO"",0] call life_fnc_handleCrafted;";
		};
		class craft_term_spikes {
			displayName = "SpikeStrip";
			recipe[] = {"craft_wireStrip"};
			recipeIngredientCount[] = {4};
			creationTime = 10;
			onCreation = "[true,'spikeStrip',1] call life_fnc_handleInv;";
		};
		/*
		TERMINAL ITEMS - VEHICLES
		*/
		class craft_term_hatchSport {
			displayName = "Hatchback (sport)";
			recipe[] = {"craft_sedanWheels","craft_carWindow","craft_carFrame","craft_engine","craft_turbo"};
			recipeIngredientCount[] = {4,4,1,1,1};
			creationTime = 30;
			onCreation = "[getPlayerUID player,'civ','Car','C_Hatchback_01_sport_F',round(random 5),round(random(1000000)),0,true] remoteExec ['DB_fnc_insertVehicle',2]; hint 'Your crafted vehicle has been added to your garage'";
		};
		class craft_term_mh9 {
			displayName = "MH9 Hummingbird";
			recipe[] = { "craft_engine", "craft_rotor", "craft_carWindow", "craft_skids", "craft_heliBody", "craft_bench", "craft_tail", "craft_blade", "craft_transmission", "craft_fuelsmall" };
			recipeIngredientCount[] = {2,1,4,2,1,2,1,4,1,2};
			creationTime = 30;
			onCreation = "[getPlayerUID player,'civ','Air','B_Heli_Light_01_F',13,round(random(1000000)),0,true] remoteExec ['DB_fnc_insertVehicle',2]; hint 'Your crafted vehicle has been added to your garage'";
		};
		class craft_term_boxVan {
			displayName = "Box Van";
			recipe[] = { "craft_sedanWheels", "craft_carWindow","craft_enginesmall","craft_smallcabin","craft_smallbox" };
			recipeIngredientCount[] = {4,2,1,1,1};
			creationTime = 30;
			onCreation = "[getPlayerUID player,'civ','Car','C_Van_01_box_F',0,round(random(1000000)),0,true] remoteExec ['DB_fnc_insertVehicle',2]; hint 'Your crafted vehicle has been added to your garage'";
		};
		class craft_term_zamTrans {
			displayName = "Zamak Transport";
			recipe[] = { "craft_sedanWheels", "craft_carWindow", "craft_smallcabin", "craft_engine" };
			recipeIngredientCount[] = {6,2,1,1};
			creationTime = 30;
			onCreation = "[getPlayerUID player,'civ','Car','I_Truck_02_transport_F',0,round(random(1000000)),0,true] remoteExec ['DB_fnc_insertVehicle',2]; hint 'Your crafted vehicle has been added to your garage'";
		};
		class craft_term_zamCov {
			displayName = "Covered Zamak";
			recipe[] = { "craft_sedanWheels", "craft_carWindow", "craft_smallcabin", "craft_engine","craft_coversmall" };
			recipeIngredientCount[] = {6,2,1,1,1};
			creationTime = 30;
			onCreation = "[getPlayerUID player,'civ','Car','I_Truck_02_covered_F',0,round(random(1000000)),0,true] remoteExec ['DB_fnc_insertVehicle',2]; hint 'Your crafted vehicle has been added to your garage'";
		};
		class craft_term_fuelHEM {
			displayName = "Fuel HEMTT";
			recipe[] = { "craft_sedanWheels", "craft_carWindow", "craft_cabin", "craft_engine", "craft_tanker" };
			recipeIngredientCount[] = {8,3,1,1,1};
			creationTime = 30;
			onCreation = "[getPlayerUID player,'civ','Car','B_Truck_01_fuel_F',0,round(random(1000000)),0,true] remoteExec ['DB_fnc_insertVehicle',2]; hint 'Your crafted vehicle has been added to your garage'";
		};
		class craft_term_boxHem {
			displayName = "Box HEMTT";
			recipe[] = { "craft_sedanWheels", "craft_carWindow", "craft_cabin", "craft_engine", "craft_boxlining", "craft_boxplating","craft_hooklift" };
			recipeIngredientCount[] = {8,3,1,1,1,2,1};
			creationTime = 30;
			onCreation = "[getPlayerUID player,'civ','Car','B_Truck_01_box_F',0,round(random(1000000)),0,true] remoteExec ['DB_fnc_insertVehicle',2]; hint 'Your crafted vehicle has been added to your garage'";
		};
		class craft_term_covHem {
			displayName = "Covered HEMTT";
			recipe[] = { "craft_sedanWheels", "craft_carWindow", "craft_cabin", "craft_engine","craft_coversmall","craft_trailer","craft_woodbench" };
			recipeIngredientCount[] = {8,3,1,1,2,1,1};
			creationTime = 30;
			onCreation = "[getPlayerUID player,'civ','Car','B_Truck_01_covered_F',0,round(random(1000000)),0,true] remoteExec ['DB_fnc_insertVehicle',2]; hint 'Your crafted vehicle has been added to your garage'";
		};
		class craft_term_hemTrans {
			displayName = "HEMTT Transport";
			recipe[] = { "craft_sedanWheels", "craft_carWindow", "craft_cabin", "craft_engine", "craft_trailer", "craft_woodbench" };
			recipeIngredientCount[] = {8,3,1,1,1,1};
			creationTime = 30;
		onCreation = "[getPlayerUID player,'civ','Car','B_Truck_01_transport_F',0,round(random(1000000)),0,true] remoteExec ['DB_fnc_insertVehicle',2]; hint 'Your crafted vehicle has been added to your garage'";
		};
		class craft_term_fuelTemp {
			displayName = "Fuel Tempest";
			recipe[] = { "craft_sedanWheels", "craft_carWindow", "craft_cabin", "craft_engine", "craft_tanker" };
			recipeIngredientCount[] = {6,3,1,1,1};
			creationTime = 30;
			onCreation = "[getPlayerUID player,'civ','Car','O_Truck_03_fuel_F',0,round(random(1000000)),0,true] remoteExec ['DB_fnc_insertVehicle',2]; hint 'Your crafted vehicle has been added to your garage'";
		};
		class craft_term_transTemp {
			displayName = "Tempest Covered";
			recipe[] = { "craft_sedanWheels", "craft_carWindow", "craft_cabin", "craft_engine", "craft_coversmall", "craft_woodbench" };
			recipeIngredientCount[] = {6,3,1,1,1,1};
			creationTime = 30;
			onCreation = "[getPlayerUID player,'civ','Car','O_Truck_03_covered_F',0,round(random(1000000)),0,true] remoteExec ['DB_fnc_insertVehicle',2]; hint 'Your crafted vehicle has been added to your garage'";
		};
		class craft_term_Tempdev {
			displayName = "Tempest Device";
			recipe[] = { "craft_sedanWheels", "craft_carWindow", "craft_cabin", "craft_engine", "craft_device","craft_stabilizer"};
			recipeIngredientCount[] = {6,3,1,1,1,2};
			creationTime = 30;
			onCreation = "[getPlayerUID player,'civ','Car','O_Truck_03_device_F',0,round(random(1000000)),0,true] remoteExec ['DB_fnc_insertVehicle',2]; hint 'Your crafted vehicle has been added to your garage'";
		};
		class craft_term_50cal {
			displayName = "M2 .50Cal Offroad";
			recipe[] = { "craft_sedanWheels", "craft_carWindow", "craft_offrbody", "craft_engine", "craft_tripod", "craft_50cal", "craft_rollbar", "craft_suspension" };
			recipeIngredientCount[] = {4,2,1,1,1,1,3,3};
			creationTime = 30;
			onCreation = "[getPlayerUID player,'civ','Car','I_G_Offroad_01_armed_F',0,round(random(1000000)),0,true] remoteExec ['DB_fnc_insertVehicle',2]; hint 'Your crafted vehicle has been added to your garage'";
		};
		/*
		WEAPON INGREDIENTS
		*/
	};
	class Ingredients{
		
		class craft_rifleBarrel {
			craftID = 0;
			displayName = "Rifle Barrel";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};			
		class craft_rifleTrigger {
			craftID = 1;
			displayName = "Trigger mechanism";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {1};
			creationTime = 5;
		};		
		class craft_EMRBarrel {
			craftID = 2;
			displayName = "EMR Barrel";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {4};
			creationTime = 5;
		};	
		class craft_EMRHandguard {
			craftID = 3;
			displayName = "EMR Handguard";
			recipe[] = {"life_inv_oilp"};
			recipeIngredientCount[] = {4};
			creationTime = 5;
		};		
		class craft_EMRUpper {
			craftID = 4;
			displayName = "EMR Upper Rcvr";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};		
		class craft_EMRLower {
			craftID = 5;
			displayName = "EMR Lower Rcvr";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {4};
			creationTime = 5;
		};	
		class craft_ABRBarrel {
			craftID = 6;
			displayName = "ABR Barrel";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {4};
			creationTime = 5;
		};	
		class craft_ABRHandguard {
			craftID = 7;
			displayName = "ABR Handguard";
			recipe[] = {"life_inv_oilp"};
			recipeIngredientCount[] = {4};
			creationTime = 5;
		};		
		class craft_ABRUpper {
			craftID = 8;
			displayName = "ABR Upper Rcvr";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};		
		class craft_ABRLower {
			craftID = 9;
			displayName = "ABR Lower Rcvr";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {4};
			creationTime = 5;
		};	
		class craft_rahimBarrel {
			craftID = 12;
			displayName = "Rahim Barrel";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};	
		class craft_rahimHandguard {
			craftID = 13;
			displayName = "Rahim Handguard";
			recipe[] = {"life_inv_oilp"};
			recipeIngredientCount[] = {4};
			creationTime = 5;
		};				
		class craft_rahimUpper {
			craftID = 14;
			displayName = "Rahim Upper Rcvr";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};		
		class craft_rahimLower {
			craftID = 15;
			displayName = "Rahim Lower Rcvr";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};			
		class craft_katibaHandguard {
			craftID = 18;
			displayName = "Katiba Handguard";
			recipe[] = {"life_inv_oilp"};
			recipeIngredientCount[] = {4};
			creationTime = 5;
		};			
		class craft_katibaUpper {
			craftID = 19;
			displayName = "Katiba Upper Rcvr";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};		
		class craft_katibaLower {
			craftID = 20;
			displayName = "Katiba Lower Rcvr";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {4};
			creationTime = 5;
		};
		class craft_carbineBarrel {
			craftID = 21;
			displayName = "Carbine Barrel";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {1};
			creationTime = 5;
		};		
		class craft_MXHandguard {
			craftID = 24;
			displayName = "MX Handguard";
			recipe[] = {"life_inv_oilp"};
			recipeIngredientCount[] = {4};
			creationTime = 5;
		};			
		class craft_MXUpper {
			craftID = 25;
			displayName = "MX Upper Rcvr";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};		
		class craft_MXLower {
			craftID = 26;
			displayName = "MX Lower Rcvr";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {4};
			creationTime = 5;
		};	
		class craft_TRGHandguard {
			craftID = 27;
			displayName = "TRG Handguard";
			recipe[] = {"life_inv_oilp"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};			
		class craft_TRGUpper {
			craftID = 28;
			displayName = "TRG Upper Rcvr";
			recipe[] = {"life_inv_oilp"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};		
		class craft_TRGLower {
			craftID = 29;
			displayName = "TRG Lower Rcvr";
			recipe[] = {"life_inv_ironr"};
			recipeIngredientCount[] = {3};
			creationTime = 5;
		};	
		class craft_MKHandguard {
			craftID = 30;
			displayName = "MK Handguard";
			recipe[] = {"life_inv_oilp"};
			recipeIngredientCount[] = {3};
			creationTime = 5;
		};			
		class craft_MKUpper {
			craftID = 31;
			displayName = "MK Upper Rcvr";
			recipe[] = {"life_inv_oilp"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};		
		class craft_MKLower {
			craftID = 32;
			displayName = "MK Lower Rcvr";
			recipe[] = {"life_inv_ironr"};
			recipeIngredientCount[] = {3};
			creationTime = 5;
		};	
		class craft_smgBarrel {
			craftID =35;
			displayName = "SMG Barrel";
			recipe[] = {"life_inv_copperr"};
			recipeIngredientCount[] = {1};
			creationTime = 5;
		};			
		class craft_verminHandguard {
			craftID = 36;
			displayName = "Vermin Handguard";
			recipe[] = {"life_inv_oilp"};
			recipeIngredientCount[] = {1};
			creationTime = 5;
		};			
		class craft_verminUpper {
			craftID = 37;
			displayName = "Vermin Upper Rcvr";
			recipe[] = {"life_inv_oilp"};
			recipeIngredientCount[] = {3};
			creationTime = 5;
		};		
		class craft_verminLower {
			craftID = 38;
			displayName = "Vermin Lower Rcvr";
			recipe[] = {"life_inv_ironr"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};
		class craft_PDWHandguard {
			craftID = 41;
			displayName = "PDW Handguard";
			recipe[] = {"life_inv_oilp"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};			
		class craft_PDWUpper {
			craftID = 42;
			displayName = "PDW Upper Rcvr";
			recipe[] = {"life_inv_oilp"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};		
		class craft_PDWLower {
			craftID = 43;
			displayName = "PDW Lower Rcvr";
			recipe[] = {"life_inv_ironr"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};
		class craft_stingHandguard {
			craftID = 44;
			displayName = "Sting Handguard";
			recipe[] = {"life_inv_oilp"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};			
		class craft_stingUpper {
			craftID = 45;
			displayName = "Sting Upper Rcvr";
			recipe[] = {"life_inv_oilp"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};		
		class craft_stingLower {
			craftID = 46;
			displayName = "Sting Lower Rcvr";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};					
		class craft_gSight {
			craftID = 49;
			displayName = "Glass sight";
			recipe[] = {"life_inv_glass"};
			recipeIngredientCount[] = {1};
			creationTime = 5;
		};
		class craft_gFrame {
			craftID = 50;
			displayName = "Scope Frame";
			recipe[] = {"life_inv_ironr"};
			recipeIngredientCount[] = {1};
			creationTime = 5;
		};
		class craft_lSight {
			craftID = 51;
			displayName = "Magnified Glass";
			recipe[] = {"life_inv_glass"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};
		class craft_lFrame {
			craftID = 52;
			displayName = "Sight Frame";
			recipe[] = {"life_inv_ironr"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};
		class craft_SMGTrigger {
			craftID = 53;
			displayName = "Trigger mechanism";
			recipe[] = {"life_inv_ironr"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};
		class craft_sedanWheels {
			craftID = 54;
			displayName = "Vehicle Wheel";
			recipe[] = {"life_inv_oilp"};
			recipeIngredientCount[] = {4};
			creationTime = 5;
		};
		class craft_carWindow {
			craftID = 55;
			displayName = "Window Pane";
			recipe[] = {"life_inv_glass"};
			recipeIngredientCount[] = {3};
			creationTime = 5;
		};
		class craft_carFrame {
			craftID = 56;
			displayName = "Car Body";
			recipe[] = {"life_inv_steel","life_inv_ironr","life_inv_copperr"};
			recipeIngredientCount[] = {2,2,2};
			creationTime = 5;
		};
		class craft_engine {
			craftID = 57;
			displayName = "Engine";
			recipe[] = {"life_inv_steel","life_inv_oilp"};
			recipeIngredientCount[] = {4,4};
			creationTime = 5;
		};
		class craft_rotor {
			craftID = 58;
			displayName = "Rotary Mechanism";
			recipe[] = {"life_inv_steel","life_inv_oilp","life_inv_ironr","life_inv_copperr"};
			recipeIngredientCount[] = {4,4,2,2};
			creationTime = 5;
		};
		class craft_skids {
			craftID = 59;
			displayName = "Landing Skid";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {3};
			creationTime = 5;
		};
		class craft_heliBody {
			craftID = 60;
			displayName = "Helicopter Body";
			recipe[] = {"life_inv_oilp","life_inv_steel","life_inv_ironr","life_inv_copperr"};
			recipeIngredientCount[] = {3,5,2,2};
			creationTime = 5;
		};
		class craft_bench {
			craftID = 61;
			displayName = "Helicopter Bench";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {3};
			creationTime = 5;
		};
		class craft_blade {
			craftID = 62;
			displayName = "Rotor Blade";
			recipe[] = {"life_inv_steel","life_inv_copperr"};
			recipeIngredientCount[] = {4,1};
			creationTime = 5;
		};
		class craft_tail {
			craftID = 63;
			displayName = "Tail Cone";
			recipe[] = {"life_inv_steel","life_inv_ironr"};
			recipeIngredientCount[] = {6,2};
			creationTime = 5;
		};
		class craft_transmission {
			craftID = 64;
			displayName = "Transmission";
			recipe[] = {"life_inv_steel","life_inv_oilp"};
			recipeIngredientCount[] = {4,2};
			creationTime = 5;
		};
		class craft_fuelsmall {
			craftID = 65;
			displayName = "Fuel Tank";
			recipe[] = {"life_inv_ironr","life_inv_oilp"};
			recipeIngredientCount[] = {2,6};
			creationTime = 5;
		};
		class craft_turbo {
			craftID = 66;
			displayName = "Turbo";
			recipe[] = {"life_inv_steel","life_inv_oilp"};
			recipeIngredientCount[] = {3,2};
			creationTime = 5;
		};
		class craft_smallcabin {
			craftID = 67;
			displayName = "Small Truck Cabin";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};
		class craft_smallbox {
			craftID = 68;
			displayName = "Small Truck Box";
			recipe[] = {"life_inv_steel","life_inv_ironr"};
			recipeIngredientCount[] = {1,2};
			creationTime = 5;
		};
		class craft_enginesmall {
			craftID = 69;
			displayName = "Small Engine";
			recipe[] = {"life_inv_steel","life_inv_oilp"};
			recipeIngredientCount[] = {2,2};
			creationTime = 5;
		};
		class craft_coversmall {
			craftID = 70;
			displayName = "Truck Cover";
			recipe[] = {"life_inv_lumber"};
			recipeIngredientCount[] = {2};
			creationTime = 5;
		};
		class craft_cabin {
			craftID = 71;
			displayName = "Truck Cabin";
			recipe[] = {"life_inv_steel","life_inv_ironr"};
			recipeIngredientCount[] = {4,2};
			creationTime = 5;
		};
		class craft_tanker {
			craftID = 72;
			displayName = "Fuel Tanker";
			recipe[] = {"life_inv_steel","life_inv_oilp","life_inv_copperr"};
			recipeIngredientCount[] = {6,2,1};
			creationTime = 5;
		};
		class craft_boxlining {
			craftID = 73;
			displayName = "Container Lining";
			recipe[] = {"life_inv_steel","life_inv_ironr","life_inv_lumber"};
			recipeIngredientCount[] = {3,3,1};
			creationTime = 5;
		};
		class craft_boxplating {
			craftID = 74;
			displayName = "Container Plating";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {8};
			creationTime = 5;
		};
		class craft_hooklift {
			craftID = 75;
			displayName = "Container Hook Lift";
			recipe[] = {"life_inv_steel","life_inv_oilp","life_inv_copperr"};
			recipeIngredientCount[] = {4,2,1};
			creationTime = 5;
		};
		class craft_trailer {
			craftID = 76;
			displayName = "HEMTT Trailer";
			recipe[] = {"life_inv_steel","life_inv_ironr"};
			recipeIngredientCount[] = {6,4};
			creationTime = 5;
		};
		class craft_woodbench {
			craftID = 77;
			displayName = "Wooden Benches";
			recipe[] = {"life_inv_lumber","life_inv_ironr"};
			recipeIngredientCount[] = {1,4};
			creationTime = 5;
		};
		class craft_device {
			craftID = 78;
			displayName = "Device";
			recipe[] = {"life_inv_steel","life_inv_goldr","life_inv_ironr"};
			recipeIngredientCount[] = {2,6,1};
			creationTime = 5;
		};
		class craft_stabilizer {
			craftID = 79;
			displayName = "Outrigger Stabilizer";
			recipe[] = {"life_inv_steel","life_inv_cement"};
			recipeIngredientCount[] = {2,4};
			creationTime = 5;
		};
		class craft_tripod {
			craftID = 80;
			displayName = "Tripod";
			recipe[] = {"life_inv_steel","life_inv_ironr"};
			recipeIngredientCount[] = {6,2};
			creationTime = 5;
		};
		class craft_rollbar {
			craftID = 81;
			displayName = "Anti Roll Bar";
			recipe[] = {"life_inv_steel"};
			recipeIngredientCount[] = {4};
			creationTime = 5;
		};
		class craft_50cal {
			craftID = 82;
			displayName = "M2HB 50.cal";
			recipe[] = {"life_inv_steel","life_inv_copperr"};
			recipeIngredientCount[] = {4,3};
			creationTime = 5;
		};
		class craft_offrbody {
			craftID = 83;
			displayName = "Offroad Body";
			recipe[] = {"life_inv_steel","life_inv_ironr"};
			recipeIngredientCount[] = {6,2};
			creationTime = 5;
		};
		class craft_suspension {
			craftID = 84;
			displayName = "Suspension";
			recipe[] = {"life_inv_steel","life_inv_oilp"};
			recipeIngredientCount[] = {2,4};
			creationTime = 5;
		};
		class craft_wireStrip {
			craftID = 85;
			displayName = "Sharp Wire";
			recipe[] = {"life_inv_steel","life_inv_copperr","life_inv_ironr"};
			recipeIngredientCount[] = {1,1,1};
			creationTime = 3;
		};
	};
};