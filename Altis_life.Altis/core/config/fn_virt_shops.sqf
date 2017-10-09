#include <macro.h>
/*
	File: fn_virt_shops.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Config for virtual shops.
*/
private["_shop"];
_shop = _this select 0;

switch (_shop) do
{
	case "market": {["Altis Market",["hightoolkit","water","rabbit","apple","redgull","tbacon","pickaxe","fuelF","peach","crabpot","alarm","reinforceddoor","steeldoor","corn","pearl","doubl","ruby","silver","excavator","gpstracker","alarmV","tentciv","nitro","chainsaw","ammoBox","ammoBoxS"]]};
	case "gang": {["Gang Market", ["hightoolkit","water","rabbit","apple","redgull","tbacon","tacTrig","trackDart","lockpick","pickaxe","fuelF","peach","blastingcharge","boltcutter","zip","gpstracker","blindfold","detector","alarmV","ammoBox","ammoBoxS","lethal","lethali","vammo","tentciv","nitro"]]};
	case "rebel": {["Rebel Market",["hightoolkit","water","rabbit","apple","redgull","tbacon","tacTrig","trackDart","lockpick","blindfold","vammo","pickaxe","fuelF","peach","boltcutter","blastingcharge","zip","lethal","lethali","gpstracker","ammoBox","ammoBoxS","detector","alarmV","tentciv","nitro"]]};
	case "wongs": {["Wong's Food Cart",["fcrabp","mcrabs","turtle"]]};
	case "med": {["Altis Market",["water","rabbit","apple","redgull","tbacon","pickaxe","fuelF","peach","crabpot","alarm","reinforceddoor","steeldoor","corn","pearl","doubl","ruby","silver","excavator","gpstracker","alarmV","medkit"]]};
	case "heroin": {["Drug Dealer",["cocainep","heroinp","marijuana","meth"]]};
	case "oil": {["Oil Trader",["oilp","pickaxe","fuelF"]]};
	case "fishmarket": {["Fish Market",["salema","ornate","mackerel","mullet","tuna","catshark","fcrab","mcrab"]]};
	case "glass": {["Glass Dealer",["glass"]]};
	case "iron": {["Industrial Trader",["ironr","copperr","goldr","steel"]]};
	case "diamond": {["Diamond Dealer",["diamond","diamondc","diamondf"]]};
	case "salt": {["Salt Dealer",["saltr"]]};
	case "cop" : {
        switch(true) do {
				case (call life_coplevel == 0) : {["Cop Item Shop",["hightoolkit","donuts","coffee","water","rabbit","apple","redgull","fuelF","defusekit","gpstracker","alarmV","medkit","nitro"]]};
                case (call life_coplevel == 1) : {["Cop Item Shop",["hightoolkit","donuts","coffee","spikeStrip","water","rabbit","apple","redgull","fuelF","defusekit","gpstracker","alarmV","medkit","nitro"]]};
                case (call life_coplevel >= 2) : {["Cop Item Shop",["hightoolkit","donuts","coffee","spikeStrip","water","rabbit","apple","redgull","fuelF","defusekit","trackDart","tacTrig","gpstracker","roadCone","roadBarrier","cncBarrier","cncBarrierL","barGate","alarmV","medkit","lockpick","nitro"]]};
        };
	};
	case "cement": {["Cement Dealer",["cement"]]};
	case "gold": {["Gold Buyer",["goldbar"]]};
	case "logging" : {["Kevin's Hardwood Supply",["chainsaw","lumber"]]};
	case "moonshine": {["Distributor",["moonshine"]]};
	case "bh": {["Bounty Hunter Tool Shed",["hightoolkit","bhTool","shank","tacTrig","trackDart","zip","blindfold","gpstracker","spikeStrip","water","rabbit","apple","redgull","tbacon","pickaxe","fuelF","peach","tentciv","nitro","ammoBox","ammoBoxS"]]};
	case "c3": {["Altis Market",["hightoolkit","water","rabbit","apple","tacTrig","trackDart","redgull","tbacon","pickaxe","fuelF","peach","alarm","reinforceddoor","steeldoor","gpstracker","alarmV","tentciv","nitro","ammoBox","ammoBoxS"]]};
	case "kiosk": {["Kiosk Market",["hightoolkit","water","rabbit","apple","redgull","donuts","coffee","tbacon","peach","salema","mackerel","tuna","mullet","catshark"]]};
};