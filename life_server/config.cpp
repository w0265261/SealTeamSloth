class DefaultEventhandlers;
class CfgPatches 
{
	class life_server
	{
		units[] = {"C_man_1"};
		weapons[] = {};
		requiredAddons[] = {"A3_Data_F","A3_Soft_F","A3_Soft_F_Offroad_01","A3_Characters_F"};
		fileName = "life_server.pbo";
		author[]= {"TAW_Tonic"}; 
	};
};

class CfgFunctions
{
	
	class MySQL_Database
	{
		tag = "DB";
		class MySQL
		{
			file = "\life_server\Functions\MySQL";
			class numberSafe {};
			class queryRequest{};
			class updateFakeName {};
			class asyncCall{};
			class repaintVehicle {};
			class RCON_Restart {};
			class killTent {};
			class copFeedback {};
			class insertRequest{};
			class initTents {};
			class updateRequest{};
			class saveVehPlayer {};
			class insertVehicle {};
			class bool{};
			class mresString {};
			class updatePartial {};
			class updateVehName {};
			class getPrices {};
		};
	};
	
	class GEServer
	{
		tag = "KBW";
		class GE
		{
			file = "\life_server\Functions\GE";
			class getOffers {};
			class listing {};
			class updateMailbox {};
			class fixBadOffers {};
			class updateVehColor {};
			class managePhone {};
		};
	};
	
	class Governor
	{
		tag = "life";
		class Gov
		{
			file = "\life_server\Functions\governor";
			class submitCandidate {};
			class vote {};
			class updateGovBank {};
			class configChanged {};
			class fetchGovBank {};
			
		};
	};
	
	class Life_System
	{
		tag = "life";
		class Wanted_Sys
		{
			file = "\life_server\Functions\WantedSystem";
			class customWantedAdd {};
			class wantedPerson {};
			class wantedBounty {};
			class wantedPardon {};
			class wantedRemove {};
			class wantedAdd {};
			class saveJailTime {};
			class getFeedback {};
		};
		
		class Jail_Sys
		{
			file = "\life_server\Functions\Jail";
			class jailSys {};
			class trialRequest {};
			class juryVote {};
		};
	};
	
	class TON_System
	{
		tag = "TON";
		class Systems
		{
			file = "\life_server\Functions\Systems";
			class managesc {};
			class marketConfiguration {};
			class RunLottery {};
			class gpsTracked {};
			class handleDuel {};
			class saveAlarm {};
			class saveVehicles {};
			class createVehicles {};
			class paintBall {};
			class clearAmmo {};
			class startRace {};
			class manageLottery {};
			class LotteryPick {};
			class saveBounties {};
			class blastingChargeMonitor {};
			class loadBounties {};
			class cleanup {};
			class compUID {};
			class vehicleInsurance {};
			class vehicleCreate {};
			class vehicleIsDead {};
			class spawnVehicle {};
			class getVehicles {};
			class vehicleStore {};
			class vehicleDelete {};
			class spikeStrip {};
			class vehicleRepaint {};
			class chopShopSell {};
			class clientDisconnect {};
			class robGasStation {};
			class changeWeather {};
		};
		
		class Taxi
		{
			file = "\life_server\Functions\Taxi";
			class callTaxiDrivers {};
			class acceptedTaxiCall {};
			class goOnDuty {};
			class goOffDuty {};
		};
		
		
		class Airdrop
		{
			file = "\life_server\Functions\airdrop";
			class generateAirdrop {};
		};
		
		class Housing
		{
			file = "\life_server\Functions\Housing";
			class addHouse {};
			class housePurchased {};
			class listHouse {};
			class fetchPlayerHouses {};
			class initHouses {};
			class sellHouse {};
			class updateHouseContainers {};
			class updateHouseTrunk {};
			class updateSecurity {};
			class updateLeasers{};			
		};
		
		class Gangs
		{
			file = "\life_server\Functions\Gangs";
			class insertGang {};
			class capZones {};
			class removeGang {};
			class updateGang {};
		};
	};
	class GHBSystem
	{
		tag = "GHB";
		class Smartphone
		{
			file = "\life_server\Functions\Smartphone";
			class handleMessages {};
		};	
	};
};