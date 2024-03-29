/*
	File: fn_varToStr.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Takes the long-name (variable) and returns a display name for our
	virtual item.
*/
private["_var"];
_var = param [0,"",[""]];
if(_var == "") exitWith {""};

switch (_var) do
{
	/*Virtual Inventory Items*/
	case "life_inv_alarmV": {"Vehicle Alarm"};
	case "life_inv_tacTrig": {"Tactical Trigger"};
	case "life_inv_trackDart": {"Tracking Dart"};
	case "life_inv_toolkit": {"High Grade Toolkit"};
	case "life_inv_oilu": {"Crude Oil"};
	case "life_inv_detector": {"Loot Detector"};
	case "life_inv_ammoBoxS": {"Temp Storage Small"};
	case "life_inv_nitro": {"Nitrous Oxide"};
	case "life_inv_lethali": {"Lethal Injection"};
	case "life_inv_medkit": {"Med Kit"};
	case "life_inv_ammoBox": {"Temp Storage Large"};
	case "life_inv_diamondf": {"Perfect Diamond"};
	case "life_inv_bhTool": {"Plate Checker"};
	case "life_inv_plateMetal": {"Metal Scrap"};
	case "life_inv_tentciv": {"Tent"};
	case "life_inv_plate": {"License Plate"};
	case "life_inv_excavator": {"Excavator"};
	case "life_inv_doubl": {"Doubloon"};
	case "life_inv_silver": {"Silverpiece"};
	case "life_inv_roadCone": {"Road Cone"};
	case "life_inv_roadBarrier": {"Road Barrier"};
	case "life_inv_cncBarrier": {"Concrete Barrier"};
	case "life_inv_cncBarrierL": {"Long Concrete Barrier"};
	case "life_inv_barGate": {"Bar Gate"};
	case "life_inv_shank": {"Shank"};
	case "life_inv_ruby": {"Ruby"};
	case "life_inv_pearl": {"Pearl"};
	case "life_inv_gpstracker": {"Tracking Device"};
	case "life_inv_eph": {"Ephedra"};
	case "life_inv_phos": {"Phosphorus"};
	case "life_inv_hydro": {"Hydrogen Sulfate"};
	case "life_inv_meth": {"Crystal Meth"};
	case "life_inv_vammo": {"Vehicle Ammo"};
	case "life_inv_oilp": {"Refined Oil"};
	case "life_inv_heroinu": {"Heroin Leaves"};
	case "life_inv_heroinp": {"Heroin"};
	case "life_inv_cannabis": {(localize "STR_Item_Cannabis")};
	case "life_inv_marijuana": {(localize "STR_Item_Marijuana")};
	case "life_inv_apple": {(localize "STR_Item_Apple")};
	case "life_inv_rabbit": {(localize "STR_Item_RabbitMeat")};
	case "life_inv_salema": {(localize "STR_Item_SalemaMeat")};
	case "life_inv_ornate": {(localize "STR_Item_OrnateMeat")};
	case "life_inv_mackerel": {(localize "STR_Item_MackerelMeat")};
	case "life_inv_tuna": {(localize "STR_Item_TunaMeat")};
	case "life_inv_mullet": {(localize "STR_Item_MulletMeat")};
	case "life_inv_catshark": {(localize "STR_Item_CatSharkMeat")};
	case "life_inv_turtle": {(localize "STR_Item_TurtleMeat")};
	case "life_inv_water": {(localize "STR_Item_WaterBottle")};
	case "life_inv_coffee": {(localize "STR_Item_Coffee")};
	case "life_inv_donuts": {(localize "STR_Item_Donuts")};
	case "life_inv_fuelE": {(localize "STR_Item_FuelE")};
	case "life_inv_fuelF": {(localize "STR_Item_FuelF")};
	case "life_inv_pickaxe": {(localize "STR_Item_Pickaxe")};
	case "life_inv_copperore": {(localize "STR_Item_CopperOre")};
	case "life_inv_ironore": {(localize "STR_Item_IronOre")};
	case "life_inv_ironr": {(localize "STR_Item_IronIngot")};
	case "life_inv_copperr": {(localize "STR_Item_CopperIngot")};
	case "life_inv_sand": {(localize "STR_Item_Sand")};
	case "life_inv_salt": {(localize "STR_Item_Salt")};
	case "life_inv_saltr": {(localize "STR_Item_SaltR")};
	case "life_inv_glass": {(localize "STR_Item_Glass")};
	case "life_inv_diamond": {"Uncut Diamond"};
	case "life_inv_diamondc": {"Cut Diamond"};
	case "life_inv_tbacon": {(localize "STR_Item_TBacon")};
	case "life_inv_redgull": {(localize "STR_Item_RedGull")};
	case "life_inv_lockpick": {(localize "STR_Item_Lockpick")};
	case "life_inv_peach": {(localize "STR_Item_Peach")};
	case "life_inv_cocaine": {"Coca leaves"};
	case "life_inv_cocainep": {"Cocaine"};
	case "life_inv_spikeStrip": {(localize "STR_Item_SpikeStrip")};
	case "life_inv_rock": {(localize "STR_Item_Rock")};
	case "life_inv_cement": {(localize "STR_Item_CementBag")};
	case "life_inv_goldbar": {(localize "STR_Item_GoldBar")};
	case "life_inv_blastingcharge": {(localize "STR_Item_BCharge")};
	case "life_inv_boltcutter": {(localize "STR_Item_BCutter")};
	case "life_inv_defusekit": {(localize "STR_Item_DefuseKit")};
	case "life_inv_alarm": {"Home Alarm System"};
	case "life_inv_reinforceddoor": {"Reinforced Doors"};
	case "life_inv_steeldoor": {"Steel Doors"};
	case "life_inv_goldore": {"Gold Ore"};
	case "life_inv_blindfold": {"Blindfold"};
	case "life_inv_goldr": {"Gold Ingot"};
    case "life_inv_crowbar": {"Crowbar"};
    case "life_inv_lethal": {"Bullet with your name on it"};
	case "life_inv_corn": {"Ears of Corn"};
	case "life_inv_moonshine": {"Moonshine"};
	case "life_inv_fcrab": {"Female Crab"};
	case "life_inv_fcrabp": {"Pregnant Female Crab"};
	case "life_inv_mcrabs": {"Male Crab Small"};
	case "life_inv_mcrab": {"Male Crab"};
	case "life_inv_crabpot": {"Crab Pot"};
	case "life_inv_coalore": {"Coal"};
	case "life_inv_steel" : {"Steel"};
	case "life_inv_defib" : {"Defibrilator"};
	case "life_inv_log" : {"Wood Log"};
	case "life_inv_lumber" : {"Cut Lumber"};
	case "life_inv_chainsaw" : {"Chainsaw"};
	case "life_inv_cellphone" : {"Cell Phone"};
	case "life_inv_zip": {"Ziptie"};
	/*License Block*/
	case "license_civ_taxi": {"Taxi License"};
	case "license_civ_driver": {(localize "STR_License_Driver")};
	case "license_civ_supermed": {"First Aid Training"};
	case "license_civ_med": {"Stabilization Training"};
	case "license_civ_meth": {"Meth Training"};
	case "license_civ_air": {(localize "STR_License_Pilot")};
	case "license_civ_heroin": {(localize "STR_License_Heroin")};
	case "license_civ_oil": {(localize "STR_License_Oil")};
	case "license_civ_dive": {(localize "STR_License_Diving")};
	case "license_civ_boat": {(localize "STR_License_Boat")};
	case "license_civ_gun": {(localize "STR_License_Firearm")};
	case "license_cop_air": {(localize "STR_License_Pilot")};
	case "license_cop_cg": {(localize "STR_License_CG")};
	case "license_civ_rebel": {"Gangster Training"};
	case "license_civ_truck": {(localize "STR_License_Truck")};
	case "license_civ_diamond": {(localize "STR_License_Diamond")};
	case "license_civ_copper": {(localize "STR_License_Copper")};
	case "license_civ_iron": {(localize "STR_License_Iron")};
	case "license_civ_sand": {(localize "STR_License_Sand")};
	case "license_civ_salt": {(localize "STR_License_Salt")};
	case "license_civ_coke": {(localize "STR_License_Cocaine")};
	case "license_civ_marijuana": {(localize "STR_License_Marijuana")};
	case "license_civ_cement": {(localize "STR_License_Cement")};
	case "license_med_air": {(localize "STR_License_Pilot")};
	case "license_civ_home": {(localize "STR_License_Home")};
	case "license_civ_gang": {"Gang License"};
	case "license_civ_gold": {"Gold Processing License"};
	case "license_civ_moonshine": {"Distillery Agreement"};
	case "license_civ_crabbing": {"Crabbing License"};
	case "license_civ_steel" : {"Steel Processing License"};
	case "license_civ_bh" : {"Bounty Hunting License"};
	case "license_civ_logging" : {"Logging License"};
	case "license_civ_c3" : {"Class Three Weapons"};
	default {""};
};
