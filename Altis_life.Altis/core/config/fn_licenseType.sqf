/*
	File: fn_licenseType.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Returns the short-var of the license name to a long var and display name.
*/
private["_type","_ret","_var","_mode"];
_type = param [0,"",[""]];
_mode = param [1,-1,[0]];
if(_type == "" OR _mode == -1) exitWith {[]};

switch (_mode) do
{
	case 0:
	{
		switch (_type) do
		{
			case "driver": {_var = "license_civ_driver"}; /*Drivers License cost*/
			case "taxi": {_var = "license_civ_taxi"};
			case "supermed": {_var = "license_civ_supermed"};
			case "tracker": {_var = "license_cop_tracker"};
			case "meth": {_var = "license_civ_meth"};
			case "boat": {_var = "license_civ_boat"}; /*Boating license cost*/
			case "pilot": {_var = "license_civ_air"}; /*Pilot/air license cost*/
			case "gun": {_var = "license_civ_gun"}; /*Firearm/gun license cost*/
			case "dive": {_var = "license_civ_dive"}; /*Diving license cost*/
			case "oil": {_var = "license_civ_oil"}; /*Oil processing license cost*/
			case "cair": {_var = "license_cop_air"}; /*Cop Pilot License cost*/
			case "cg": {_var = "license_cop_cg"}; /*Coast guard license cost*/
			case "heroin": {_var = "license_civ_heroin"}; /*Heroin processing license cost*/
			case "marijuana": {_var = "license_civ_marijuana"}; /*Marijuana processing license cost*/
			case "med": {_var = "license_civ_med"}; /*Stabilization license*/
			case "gang": {_var = "license_civ_gang"}; /*Gang license cost*/
			case "rebel": {_var = "license_civ_rebel"}; /*Rebel License*/
			case "truck":{_var = "license_civ_truck"}; /*Truck License*/
			case "diamond": {_var = "license_civ_diamond"};
			case "salt": {_var = "license_civ_salt"};
			case "cocaine": {_var = "license_civ_coke"};
			case "sand": {_var = "license_civ_sand"};
			case "iron": {_var = "license_civ_iron"};
			case "copper": {_var = "license_civ_copper"};
			case "cement": {_var = "license_civ_cement"};
			case "gold": {_var = "license_civ_gold"};
			case "moonshine": {_var = "license_civ_moonshine"};
			case "crabbing": {_var = "license_civ_crabbing"};
			case "steel": {_var = "license_civ_steel"};
			case "bh" : {_var = "license_civ_bh"};
			case "logging" : {_var = "license_civ_logging"};
			case "medicair" : {_var = "license_medic_air"};
			case "c3": {_var = "license_civ_c3"};
			case "swat": {_var = "license_cop_swat"}; /*Swat License cost*/
			case "mair": {_var = "license_med_air"};
			case "home": {_var = "license_civ_home"};
			case "excav": {_var = "license_civ_excav"};
			case "hacker": {_var = "license_civ_hacker"};
			case "delivery": {_var = "license_civ_delivery"};
			default {_var = ""};
		};
	};
	
	case 1:
	{
		switch (_type) do
		{
			case "license_civ_driver": {_var = "driver"}; /*Drivers License cost*/
			case "license_civ_taxi": {_var = "taxi"};
			case "license_civ_supermed": {_var = "supermed"};
			case "license_cop_tracker": {_var = "tracker"};
			case "license_civ_meth": {_var = "meth"};
			case "license_civ_boat": {_var = "boat"}; /*Boating license cost*/
			case "license_civ_air": {_var = "pilot"}; /*Pilot/air license cost*/
			case "license_civ_gun": {_var = "gun"}; /*Firearm/gun license cost*/
			case "license_civ_dive": {_var = "dive"}; /*Diving license cost*/
			case "license_civ_oil": {_var = "oil"}; /*Oil processing license cost*/
			case "license_cop_air": {_var = "cair"}; /*Cop Pilot License cost*/
			case "license_cop_cg": {_var = "cg"}; /*Coast guard license cost*/
			case "license_civ_heroin": {_var = "heroin"}; /*Heroin processing license cost*/
			case "license_civ_marijuana": {_var = "marijuana"}; /*Marijuana processing license cost*/
			case "license_civ_med": {_var = "med"}; /*Stabilization license*/
			case "license_civ_gang": {_var = "gang"}; /*Gang license cost*/
			case "license_civ_rebel": {_var = "rebel"}; /*Rebel License*/
			case "license_civ_truck":{_var = "truck"}; /*Truck License*/
			case "license_civ_diamond": {_var = "diamond"};
			case "license_civ_salt": {_var = "salt"};
			case "license_civ_coke": {_var = "cocaine"};
			case "license_civ_sand": {_var = "sand"};
			case "license_civ_iron": {_var = "iron"};
			case "license_civ_copper": {_var = "copper"};
			case "license_civ_cement": {_var = "cement"};
			case "license_civ_gold": {_var = "gold"};
			case "license_civ_moonshine": {_var = "moonshine"};
			case "license_civ_crabbing": {_var = "crabbing"};
			case "license_civ_steel": {_var = "steel"};
			case "license_civ_bh": {_var = "bh"};
			case "license_civ_logging" : {_var = "logging"};
			case "license_medic_air" : {_var = "medicair"};
			case "license_civ_home": {_var = "home"};
			case "license_civ_c3": {_var = "c3"};
			case "license_cop_swat": {_var = "swat"}; /*Swat License cost*/
			case "license_med_air": {_var = "mair"};
			case "license_civ_hacker": {_var = "hacker"};
			case "license_civ_excav": {_var = "excav"};
			case "license_civ_delivery": {_var = "delivery"};
			default {_var = ""};
		};
	};
};

_ret = [_var,(if(_var != "") then {([_var] call life_fnc_varToStr)})];
_ret;