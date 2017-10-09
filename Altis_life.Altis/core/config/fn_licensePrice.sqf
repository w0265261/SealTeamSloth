/*
	File: fn_licensePrice.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Returns the license price.
*/
private["_type"];
_type = param [0,"",[""]];
if(_type == "") exitWith {-1};

switch (_type) do
{
	case "driver": {50}; /*Drivers License cost*/
	case "boat": {50}; /*Boating license cost*/
	case "med": {2500};
	case "supermed": {5000};
	case "pilot": {2500};
	case "gun": {2000};
	case "dive": {1000};
	case "oil": {1000};
	case "cair": {1500};
	case "cg": {1500};
	case "heroin": {1150};
	case "marijuana": {600};
	case "rebel": {7500};
	case "truck": {2000};
	case "diamond": {1000};
	case "meth": {2000};
	case "salt": {750};
	case "cocaine": {1750};
	case "sand": {700};
	case "iron": {2000};
	case "copper": {650};
	case "cement": {1100};
	case "gold": {1850};
	case "moonshine": {950};
	case "steel" : {1250};
	case "bh": {7500};
	case "logging": {1250};
	case "medicair" : {2500};
	case "home": {10000};
	case "c3": {10000};
	case "mair": {1500};
	case "taxi": {7500};
};