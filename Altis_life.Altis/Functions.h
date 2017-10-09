class Socket_Reciever
{
	tag = "SOCK";
	class SQL_Socket
	{
		file = "core\session";
		class requestReceived {};
		class dataQuery {};
		class insertPlayerInfo {};
		class updateRequest {};
		class syncData {};
		class updatePartial {};
		class killTent {};
	};
};
	
class KBWFiles
{
	tag = "KBW";
	class KBW
	{
		file = "KBW";
		class initCustomColor {};
		class GEMenu {};
		class GELBChange {};
		class obligeOffer {};
		class addFakeName {};
		class vehicleExchange {};
		class listWeapon {};
		class checkOffer {};
		class listItem {};
		class removeOffer {};
		class addWeapon {};
		class claimMailbox {};
		class buyOffer {};
		//GE functins above, Dueling functions below
		class openDuelUI {};
		class duelRequest {};
		class duelRequested {};
		class activateDuel {};
		class initRace {};
		class houseInvFilter {};
		class invInteraction {};
	};
};

class Life_Client_Core
{
	tag = "life";
	
	class Master_Directory
	{
		file = "core";
		class setupActions {};
		class setupEVH {};
		class initCiv {};
		class initCop {};
		class initMedic {};
	};
	
	class Admin
	{
		file = "core\admin";
		class adminRestrain {};
		class resetPrices {};
		class callRestart {};
		class hiderFunction {};
		class hideMe {};
		class adminComp {};
		class compRequest {};
		class compRequest2 {};
		class adminDebugCon {};
		class adminImpound {};
		class TPtoHIM {};
		class grantbh {};
		class adminRestrainAction {};
		class adminFeed {};
		class admininfo {};
		class adminUnrestrain {};
		class adminJailPre {};
		class adminArrest {};
		class adminJailDialog {};
		class adminJail {};
		class adminSeizeWeapons {};
		class adminSeizeAction {};
		class adminUnrestrainAction {};
		class adminMenu {};
		class adminQuery {};
		class adminSpectate {}; 
		class adminRevive {};
		class adminTeleport {};
		class adminTpHere {}; 
	};
	
	class Governor
	{
		file = "core\governor";
		class newCandidate {};
		class runDialog {};
		class voteDialog {};
		class candidate {};
	};
	
	class Taxi
	{
		file = "core\taxi";
		class taxi_call {};
		class taxi_respond {};
		class taxi_acceptCall {};
		class finishRide {};
		class openTaxiMenu {};
	};
	
	class Medical_System
	{
		file = "core\medical";
		class drag {};
		class confirmSuicide {};
		class requestMedic {};
		class medicRequest {};
		class deathScreen {};
		class medicInteractionMenu {};
		class mediclights {};
		class medicLoadGear {};
		class medicMarkers {};
		class medicSiren {};
		class medicSirenLights {};
		class revive {};
		class reviveAction {};
		class adminReviveAction {};
		class stabilise {};
		class stabiliseAction {};
	};
	
	class repaint
	{
		file = "core\repaint";
		
		class repaintMenu;
		class repaintColor;
		class repaintVehicle;		
	};
	
	class tempGangs
	{
		file = "core\tempGangs";
		class createGroup {};
		class gangBrowser {};
		class gangManagement {};
		class groupMenu {};
		class joinGang {};
		class kickGang {};
		class leaveGang {};
		class setGangLeader {};
		class lockGang {};
		class unlockGang {};
	};
	
	class Actions
	{
		file = "core\actions";
		class captureHideout {};
		class BuyTicket {};
		class placedObject {};
		class activateNitro {};
		class compAction {};
		class civPullOut {};
		class civPutInCar {};
		class buyLicense {};
		class zipTieAction {};
		class unzip {};
		class drugeffect_alc {};
		class drugeffect_coc {};
		class drugeffect_her {};
		class drugeffect_mar {};
		class healHospital {};
		class pushVehicle {};
		class repairTruck {};
		class serviceChopper {};
		class catchFish {};
		class catchTurtle {};
		class dpFinish {};
		class dropFishingNet {};
		class getDPMission {};
		class postBail {};
		class processAction {};
		class arrestAction {};
		class escortAction {};
		class impoundAction {};
		class pulloutAction {};
		class putInCar {};
		class stopEscorting {};
		class restrainAction {};
		class searchAction {};
		class searchVehAction {};
		class unrestrain {};
		class pickupItem {};
		class pickupMoney {};
		class ticketAction {};
		class packupSpikes {};
		class storeVehicle {};
		class robAction {};
		class robStation {};
		class reviveHospital {};
		class gather {};
		class shankAction {};
	};
	
	class Housing
	{
		file = "core\housing";
		class buyHouse {};
		class listHouse {};
		class buyPlayerHouse {};
		class initLocker {};
		class houseRequest {};
		class raidHouse {};
		class getBuildingPositions {};
		class houseMenu {};
		class lightHouse {};
		class lightHouseAction {};
		class sellHouse {};
		class initHouses {};
		class copBreakDoor {};
		class lockupHouse {};
		class copHouseOwner {};
		class lockHouse {};
		class manageLeasing {};
	};
	
	class Config
	{
		file = "core\config";
		class licensePrice {};
		class civDefault {};
		class vehicleColorCfg {};
		class vehicleColorStr {};
		class vehicleListCfg {};
		class licenseType {};
		class eatFood {};
		class varHandle {};
		class varToStr {};
		class copDefault {};
		class itemWeight {};
		class virt_shops {};
		class vehShopLicenses {};
		class vehicleAnimate {};
		class weaponShopCfg {};
		class vehicleWeightCfg {};
		class houseConfig {};
		class clothing_cop {};
		class clothing_bruce {};
		class clothing_reb {};
		class clothing_c3 {};
		class clothing_dive {};
	};

	class Player_Menu
	{
		file = "core\pmenu";
		class wantedList {};
		class reportStolen {};
		class smartphone {};
        class newMsg {};
		class showMsg {};
		class wantedInfo {};
		class wantedMenu {};
		class pardon {};
		class giveItem {};
		class giveMoney {};
		class p_openMenu {};
		class p_updateMenu {};
		class removeItem {};
		class useItem {};
		class cellphone {};
		class keyMenu {};
		class keyGive {};
		class keyDrop {};
		class s_onSliderChange {};
		class updateViewDistance {};
		class settingsMenu {};
		class settingsInit {};
		class leaseMenu {};
		class houseKeyDrop {};
	};
	
	class Functions
	{
		file = "core\functions";
		class setRating {};
		class phoneCall {};
		class handleDowned {};
		class saveThat {};
		class calWeightDiff {};
		class blindfolded {};
		class fetchCfgDetails {};
		class handleInv {};
		class hudSetup {};
		class hudUpdate {};
		class tazeSound {};
		class animSync {};
		class keyHandler {};
		class keyUpHandler {};
		class dropItems {};
		class handleDamage {};
		class numberText {};
		class handleItem {};
		class accType {};
		class receiveItem {};
		class giveDiff {};
		class receiveMoney {};
		class playerTags {};
		class clearVehicleAmmo {};
		class pullOutVeh {};
		class nearUnits {};
		class actionKeyHandler {};
		class isnumeric {};
		class onTakeItem {};
		class fetchVehInfo {};
		class pushObject {};
		class onFired {};
		class nearestDoor {};
		class inventoryClosed {};
		class inventoryOpened {};
		class isUIDActive {};
		class playsound {};
		class setUniform {};
		class equipGear {};
		class onDeath {};
		class onRespawn {};
		class escInterupt {};
		class handleFlashbang {};
		class handlePaper {};
		class unconscious {};
		class enableActions {};
	};
	
	class Network
	{
		file = "core\functions\network";
		class broadcast {};
		class teargas {};
		class netSetVar {};
		class soundDevice {};
		class setFuel {};
	};
	
	class Civilian
	{
		file = "core\civilian";
		class feedMe {};
		class execute {};
		class executeAction {};
		class requestTrial {};
		class trialJury {};
		class juryRegister {};
		class trialDefendant {};
		class ch7Broadcast {};
		class jurySummons {};
		class showBroadcast {};
		class initPaint {};
		class NLR {};
		class amIWanted {};
		class meth {};
		class attachSmoke {};
		class vdmMonitor {};
		class skyDive {};
		class searchWreck {};
		class blindfold {};
		class blindfoldRemove {};
		class jail {};
		class tazed {};
		class knockedOut {};
		class knockoutAction {};
		class robReceive {};
		class robPerson {};
		class demoChargeTimer {};
		class civInteractionMenu {};
		class surrender {};
		class jailFeed {};
	};
	
	class Vehicle
	{
		file = "core\vehicle";
		class gpsTracker {};
		class refuelVehicle {};
		class insurance {};
		class lockVehicle {};
		class oilDrill {};
		class colorVehicle {};
		class openInventory {};
		class vehicleOwners {};
		class vehStoreItem {};
		class vehTakeItem {};
		class vehInventory {};
		class vInteractionMenu {};
		class vehicleWeight {};
		class deviceMine {};
		class clearAmmo {};
		class addVehicle2Chain {};
	};
	
	class Cop
	{
		file = "core\cop";
		class chargeMenu {};
		class readFeedback {};
		class feedLBChange {};
		class setUnitNumber {};
		class initCustomCharge {};
		class breakinMarker {};
		class removeMask {};
		class questionDistrib {};
		class copCrush {};
		class copEnter {};
		class chargeAttempt {};
		class revokeLicense {};
		class revokeLicenseAction {};
		class copMarkers {};
		class copLights {};
		class optiloadGear {};
		class vehInvSearch {};
		class copSearch {};
		class bountyReceive {};
		class searchClient {};
		class restrain {};
		class ticketGive {};
		class ticketPay {};
		class ticketPrompt {};
		class copSiren {};
		class spikeStripEffect {};
		class radar {};
		class questionDealer {};
		class copInteractionMenu {};
		class sirenLights {};
		class licenseCheck {};
		class licensesRead {};
		class repairDoor {};
		class doorAnimate {};
		class seizeObjects {};
		class seizePlayerWeapon {};
		class seizePlayerWeaponAction {};
		class questionGasStation {};
		class jailDialog {};
		class jailPre {};
		class copOpener {};
		class seizeVehicleWeapon {};
	};
	
	class Gangs
	{
		file = "core\gangs";
		class initGang {};
		class gangPromo {};
		class gangMarkers {};
		class createGang {};
		class gangCreated {};
		class gangMenu {};
		class gangKick {};
		class gangLeave {};
		class gangNewLeader {};
		class gangInvitePlayer {};
		class gangInvite {};
		class gangDisband {};
		class gangDisbanded {};
		class toggleCaptureUI {};
		class updateCaptureUI {};
	};
	
	class Shops
	{
		file = "core\shops";
		class atmMenu {};
		class stealVehicle {};
		class salesCheck {};
		class prestigeBuy {};
		class buyClothes {};
		class changeClothes {};
		class clothingMenu {};
		class clothingFilter {};
		class vehicleShopMenu {};
		class vehicleShopLBChange {};
		class vehicleShopBuy {};
		class weaponShopFilter {};
		class weaponShopMenu {};
		class weaponShopSelection {};
		class weaponShopBuySell {};
		class virt_buy {};
		class virt_menu {};
		class virt_update {};
		class virt_sell {};
		class chopShopMenu {};
		class chopShopSelection {};
		class chopShopSell {};
		class slotmachine {};
		class slotSpin {};
		class blackjack {};
		class BJbet {};
		class BJhit {};
		class BJstay {};
	};
	
	class Items
	{
		file = "core\items";
		class pickaxeUse {};
		class handleCrate {};
		class crateMenu {};
		class vehicleAlarm {};
		class nitro {};
		class tent {};
		class ammoBox {};
		class pickupObject {};
		class placeObject {};
		class vehammo {};
		class lockpick {};
		class spikeStrip {};
		class jerryRefuel {};
		class boltcutter {};
		class blastingCharge {};
		class defuseKit {};
		class storageBox {};
		class zipTie {};
		class crabpot {};
		class chainsaw {};
		class securityUpgrades {};
	};
	
	class Dialog_Controls
	{
		file = "dialog\function";
		class setMapPosition {};
		class displayHandler {};
		class spawnConfirm {};
		class govMenu {};
		class toggleLaw {};
		class spawnMenu {};
		class spawnPointCfg {};
		class spawnPointSelected {};
		class impoundMenu {};
		class unimpound {};
		class sellGarage {};
		class bankDeposit {};
		class bankWithdraw {};
		class bankTransfer {};
		class garageLBChange {};
		class safeInventory {};
		class safeOpen {};
		class safeTake {};
		class safeFix {};
		class vehicleGarage {};
		class gangDeposit {};
		class renameGarage {}; //Added by MrBoolean - Renaming Garage
		class mrkrfilter {};
	};
	
	class Cam
	{
	   file ="core";
	   class IntroCam {};
	};
	
	class Market
    {
        file = "core\market";
        class openMarketView;
        class refreshMarketView;
        class marketShortView;
        class marketGetBuyPrice;
        class marketGetSellPrice;
        class marketGetRow;
        class marketGetPriceRow;
        class marketSetPriceRow;
        class marketBuy;
        class marketSell;
    };
	
	class Crafting {
		file = "core\crafting";
		class getCraftItemAttr{};
		class handleCrafted {};
		class loadCraftingMenu{};
		class makePart{};
		class manufactureItem{};
		class termItemSelectedEvent{};
		class partSelectedEvent{};
		class isCraftable{};
		class updateResources{};
		class giveCraftedItem{};
		class factoryInvManager{};
	};

};