/*
	File: fn_itemWeight.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Gets the items weight and returns it.
*/
private["_item"];
_item = param [0,"",[""]];
if(_item == "") exitWith {};

switch (_item) do
{
	case "oilu": {8};
	case "tacTrig": {5};
	case "alarmV": {5};
	case "ammoBox": {30};
	case "ammoBoxS": {15};
	case "excavator": {5};
	case "nitro": {5};
	case "doubl": {1};
	case "ruby": {1};
	case "tentciv": {30};
	case "pearl": {1};
	case "medkit": {5};
	case "diamondf": {2};
	case "plateMetal": {20};
	case "ied": {25};
	case "eph": {3};
	case "phos": {3};
	case "hydro": {3};
	case "meth": {2};
	case "vammo": {10};
	case "blindfold": {2};
	case "oilp": {4};
	case "heroinu": {6};
	case "heroinp": {4};
	case "cannabis": {4};
	case "marijuana": {3};
	case "apple": {1};
	case "water": {1};
	case "rabbit": {1};
	case "salema": {2};
	case "ornate": {2};
	case "mackerel": {4};
	case "tuna": {6};
	case "mullet": {4};
	case "catshark": {6};
	case "turtle": {6};
	case "donuts": {1};
	case "coffee": {1};
	case "fuelE": {2};
	case "fuelF": {5};
	case "money": {0};
	case "pickaxe": {2};
	case "copperore": {4};
	case "ironore": {5};
	case "copperr": {3};
	case "ironr": {4};
	case "sand": {3};
	case "salt": {3};
	case "saltr": {2};
	case "glass": {2};
	case "diamond": {3};
	case "diamondc": {1};
	case "cocaine": {6};
	case "cocainep": {4};
	case "spikeStrip": {10};
	case "rock": {6};
	case "cement": {5};
	case "goldore": {5};
	case "goldr": {4};
	case "goldbar": {10};
	case "corn": {3};
	case "moonshine": {2};
	case "roadCone": {1};
	case "roadBarrier": {2};
	case "cncBarrier": {3};
	case "cncBarrierL": {3};
	case "barGate": {2};
	case "shank": {2};
	case "fcrab": {2};
	case "fcrabp": {4};
	case "mcrabs": {2};
	case "mcrab": {4};
	case "crabpot": {10};
	case "defib" : {10};
	case "log" : {10};
	case "lumber" : {8};
	case "chainsaw" : {5};
	case "RoadCone": {2};
	case "coalore": {5};
	case "steel": {5};
	case "storage2": {30};
	case "storagesmall": {10};
	case "storagebig": {15};
	case "alarm": {20};
	case "reinforceddoor": {30};
	case "steeldoor": {35};
	case "blastingcharge": {15};
	case "boltcutter": {5};
	case "defusekit": {2};
	case "detector": {5};
	default {1};
};
