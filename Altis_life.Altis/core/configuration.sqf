#include <macro.h>
/*
	Master Life Configuration File
	This file is to setup variables for the client, there are still other configuration files in the system

*****************************
****** Backend Variables *****
*****************************
*/
redscale = 0.5;
greenscale = 0.5;
bluescale = 0.5;
life_phone_status = 0;
life_phone_channel = -1;
opacity = 1;
life_seatbelt = false;
ownedWeapons = [];
life_racers = [];
life_targetTag = false;
life_tent = [];
life_inTrial = false;
life_medreq = false;
lethal_death = false;
life_prestige = 0;
life_governor = false;
life_diagIsWaiting = false;
myGrassCheck = true;
style = 0;
life_sit = false;
life_diagWaiting = false;
life_mailbox = [];
life_racing = false;
life_deathPen = false;
current_object = objnull;
current_L = 2;
raceDone = false;
life_tags = 0;
NotYetTripped = true;
life_offers = 0;
life_messages = [];
life_taxiCustomer = ObjNull;
life_dueling = false;
life_feedback = [];
life_request_trial = false;
TaxiCallsClient = [];
life_escort = ObjNull;
life_cruise = false;
life_market = [];
life_stab_time = time;
life_tax = 0;
life_realname = "";
life_detectCount = 0;
life_UAV_isActive = false;
detectCooldown = time;
life_calledTaxi = false;
life_isOnDutyTaxi = false;
life_inTaxi = false;
life_DPBox = ObjNull;
undercover = false;
life_oopsFailed = false;
life_lastVehicle = ObjNull;
life_suicide = false;
life_query_time = time;
life_houseRequest = false;
life_noTroll = false;
life_soldHouse = false;
life_drugged = false;
life_wantedlist = false;
forceWeaponState = false;
life_environ = true;
life_reviving = false;
life_silencer = 0;
life_paintRequest = false;
life_paintBalling = false;
life_gather = 0;
life_copReceive = ObjNull;
life_lastKnownPos = [0,0,0];
life_originalPos = [];
life_restart = false;
life_wanted = false;
life_firstSpawn = true;
life_exec = false;
life_anon = false;
life_charged = false;
life_myGrp = grpNull;
life_drug_level = 0;
life_transfered = 0;
life_sellingCars = false;
life_compTarget = ObjNull;
civ_position = [];
life_carSold = 0;
life_thief = 0;
life_poorBoy = false;
life_meth_effect = 0;
life_respawning = false;
life_action_gathering = false;
life_isSelling = false;
life_moneyMade = 0;
life_sold = [];
life_myGarage = false;
life_is_alive = false;
life_action_delay = time;
life_hacker = false;
life_vdm_limit = 0;
life_lock = true;
life_trunk_vehicle = Objnull;
life_session_completed = false;
life_garage_store = false;
life_gear = [];
life_session_tries = 0;
life_net_dropped = false;
life_siren_active = false;
life_stab_limit = 0;
life_Tswiftie = 5;
life_ShakeItOff = 17503;
life_clothing_filter = 0;
life_bleedout = time;
life_is_processing = false;
life_bail_paid = false;
life_impound_inuse = false;
life_action_inUse = false;
life_spikestrip = ObjNull;
life_knockout = false;
life_interrupted = false;
life_show_actions = false;
life_action_time = 0;
life_trunkCheck = false;
STS_actions = [];
life_smartphoneTarget = ObjNull;
life_reviving = false;
life_marked = false;

/*Revive constant variables.*/
__CONST__(life_revive_fee,1250);

/*House Limit*/
__CONST__(life_houseLimit,4);

/*Gang related stuff?*/
__CONST__(life_gangPrice,7500);


life_clothing_purchase = [-1,-1,-1,-1,-1];
life_abort_enabled = false; /* If true, can't abort */

/*
*****************************
****** Weight Variables *****
*****************************
*/
life_maxWeight = 24;
life_maxWeightT = 24;
life_carryWeight = 0;

/*
*****************************
****** Life Variables *******
*****************************
*/
life_net_dropped = false;
life_siren_active = false;
life_use_atm = true;
life_is_arrested = false;
life_delivery_in_progress = false;
life_action_in_use = false;
life_thirst = 100;
life_hunger = 100;
__CONST__(life_paycheck_period,5); /*Five minutes*/
life_handpaper = 0;
life_istazed = false;
life_isdowned = false;
life_my_gang = ObjNull;
life_placing = ObjNull;
life_previous_shank = 0;
life_last_repair = 0;

life_vehicles = [];

/* inventory, class, name, height, distance, damageable*/
life_placeable = 
[
	["roadCone","RoadCone_F","Road Cone",1,4, false],
	["roadBarrier","RoadBarrier_F","Road Barrier",1,4, false],
	["cncBarrier","Land_CncBarrierMedium_F","Concrete Barrier",1,4, false],
	["cncBarrierL","Land_CncBarrierMedium4_F","Concrete Barrier Long",1,4, false],
	["barGate","Land_BarGate_F","Bar Gate", 4, 4, false],
	["shank","Land_File_F","Shank", 1, 0, false]
];

switch (playerSide) do
{
	case west:
	{
		life_myfunds = 60000;
		life_paycheck = 400;
	};
	case civilian:
	{
		life_myfunds = 20000;
		life_paycheck = 200;
	};
	case independent:
	{
		life_myfunds = 40000;
		life_paycheck = 300;
	}
};

/*
	Master Array of items?
*/

life_prestige_array =
[
	["arifle_SDAR_F",5],
	["SMG_01_F",5],
	["SMG_02_F",5],
	["arifle_Mk20_GL_plain_F",15],
	["arifle_Mk20C_plain_F",10],
	["arifle_Mk20_plain_F",10],
	["arifle_TRG20_F",10],
	["arifle_TRG21_F",10],
	["arifle_TRG21_GL_F",15],
	["arifle_MX_Black_F",20],
	["arifle_MXC_Black_F",20],
	["arifle_MX_SW_Black_F",20],
	["arifle_MXM_Black_F",20],
	["srifle_EBR_F",30],
	["srifle_DMR_03_F",30],
	["srifle_DMR_03_woodland_F",30],
	["srifle_DMR_03_multicam_F",30],
	["srifle_DMR_03_tan_F",30],
	["srifle_DMR_03_khaki_F",30]
];

life_inv_items = 
[
	"life_inv_detector",
	"life_inv_lethali",
	"life_inv_alarmV",
	"life_inv_toolkit",
	"life_inv_oilu",
	"life_inv_bhTool",
	"life_inv_nitro",
	"life_inv_ammoBoxS",
	"life_inv_ammoBox",
	"life_inv_diamondf",
	"life_inv_plateMetal",
	"life_inv_plate",
	"life_inv_excavator",
	"life_inv_silver",
	"life_inv_pearl",
	"life_inv_medkit",
	"life_inv_ruby",
	"life_inv_doubl",
	"life_inv_gpstracker",
	"life_inv_eph",
	"life_inv_phos",
	"life_inv_hydro",
	"life_inv_meth",
	"life_inv_blindfold",
	"life_inv_oilp",
	"life_inv_heroinu",
	"life_inv_heroinp",
	"life_inv_cannabis",
	"life_inv_marijuana",
	"life_inv_apple",
	"life_inv_rabbit",
	"life_inv_salema",
	"life_inv_ornate",
	"life_inv_mackerel",
	"life_inv_tuna",
	"life_inv_mullet",
	"life_inv_catshark",
	"life_inv_turtle",
	"life_inv_water",
	"life_inv_donuts",
	"life_inv_coffee",
	"life_inv_fuelF",
	"life_inv_fuelE",
	"life_inv_pickaxe",
	"life_inv_copperore",
	"life_inv_ironore",
	"life_inv_ironr",
	"life_inv_copperr",
	"life_inv_sand",
	"life_inv_salt",
	"life_inv_saltr",
	"life_inv_glass",
	"life_inv_tbacon",
	"life_inv_lockpick",
	"life_inv_redgull",
	"life_inv_peach",
	"life_inv_diamond",
	"life_inv_cocaine",
	"life_inv_cocainep",
	"life_inv_diamondc",
	"life_inv_spikeStrip",
	"life_inv_rock",
	"life_inv_cement",
	"life_inv_goldbar",
	"life_inv_blastingcharge",
	"life_inv_boltcutter",
	"life_inv_defusekit",
	"life_inv_alarm",
	"life_inv_reinforceddoor",
	"life_inv_steeldoor",
	"life_inv_goldore",
	"life_inv_goldr",
	"life_inv_zip",
	"life_inv_corn",
	"life_inv_moonshine",
	"life_inv_fcrab",
	"life_inv_fcrabp",
	"life_inv_mcrabs",
	"life_inv_mcrab",
	"life_inv_crabpot",
	"life_inv_coalore",
	"life_inv_steel",
	"life_inv_log",
	"life_inv_lumber",
	"life_inv_chainsaw",
	"life_inv_roadCone",
	"life_inv_roadBarrier",
	"life_inv_cncBarrier",
	"life_inv_cncBarrierL",
	"life_inv_barGate",
	"life_inv_shank",
    "life_inv_lethal",
	"life_inv_vammo",
	"life_inv_tentciv",
	"life_inv_tacTrig",
	"life_inv_trackDart"
];

/*Setup variable inv vars.*/
{missionNamespace setVariable[_x,0];} foreach life_inv_items;
/*Licenses [license var, civ/cop]*/
life_licenses =
[
	["license_cop_air","cop"],
	["license_civ_taxi","civ"],
	["license_civ_med","civ"],
	["license_civ_supermed","civ"],
	["license_civ_meth","civ"],
	["license_cop_cg","cop"],
	["license_civ_driver","civ"],
	["license_civ_air","civ"],
	["license_civ_heroin","civ"],
	["license_civ_marijuana","civ"],
	["license_civ_gang","civ"],
	["license_civ_boat","civ"],
	["license_civ_oil","civ"],
	["license_civ_dive","civ"],
	["license_civ_truck","civ"],
	["license_civ_gun","civ"],
	["license_civ_rebel","civ"],
	["license_civ_coke","civ"],
	["license_civ_diamond","civ"],
	["license_civ_copper","civ"],
	["license_civ_iron","civ"],
	["license_civ_sand","civ"],
	["license_civ_salt","civ"],
	["license_civ_cement","civ"],
	["license_med_air","med"],
	["license_civ_home","civ"],
	["license_civ_moonshine","civ"],
	["license_civ_gold","civ"],
	["license_civ_steel","civ"],
	["license_civ_bh","civ"],
	["license_civ_logging","civ"],
	["license_medic_air","medic"],
	["license_civ_c3", "civ"],
	["license_civ_hacker","civ"],
	["license_civ_delivery","civ"],
	["license_civ_excav","civ"]
];

/*Setup License Variables*/
{missionNamespace setVariable[(_x select 0),false];} foreach life_licenses;

life_dp_points = ["dp_1","dp_2","dp_3","dp_4","dp_5","dp_6","dp_7","dp_8","dp_9","dp_10","dp_11","dp_12","dp_13","dp_14","dp_15","dp_15","dp_16","dp_17","dp_18","dp_19","dp_20","dp_21","dp_22","dp_23","dp_24","dp_25"];