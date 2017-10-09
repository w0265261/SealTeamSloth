#include "player_sys.sqf"

class STS_playerSettings {

	idd = playersys_DIALOG;
	movingEnable = true;
	enableSimulation = true;
	
	class controlsBackground {
	
	class life_RscTitleBackground:life_RscText {
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};
			idc = -1;
			x = 0.1;
			y = 0.2;
			w = 0.8;
			h = (1 / 25);
		};
		
		class MainBackground:life_RscText {
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			idc = -1;
			x = 0.1;
			y = 0.2 + (11 / 250);
			w = 0.8;
			h = 0.6 - (22 / 250);
		};
		
		class Title : life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "$STR_PM_Title";
			x = 0.1;
			y = 0.2;
			w = 0.8;
			h = (1 / 25);
		};
		
		class moneyStatusInfo : Life_RscStructuredText
		{
			idc = 2015;
			sizeEx = 0.020;
			text = "";
			x = 0.105;
			y = 0.30;
			w = 0.3; h = 0.6;
		};
		
		class PlayersName : Title {
			idc = carry_weight;
			style = 1;
			text = "";
		};
	};
	
	class controls {
		
		class itemHeader : Life_RscText
		{
			idc = -1;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "$STR_PM_cItems";
			sizeEx = 0.04;
			
			x = 0.62; y = 0.26;
			w = 0.275; h = 0.04;
		};
		
		class licenseHeader : Life_RscText
		{
			idc = -1;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "$STR_PM_Licenses";
			sizeEx = 0.04;
			
			x = 0.336; y = 0.26;
			w = 0.275; h = 0.04;
		};
		
		class moneySHeader : Life_RscText
		{
			idc = -1;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "$STR_PM_MoneyStats";
			sizeEx = 0.04;
			
			x = 0.11; y = 0.26;
			w = 0.219; h = 0.04;
		};
	
		class itemList : life_RscListBox 
		{
			idc = item_list;
			sizeEx = 0.030;
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			
			x = 0.62; y = 0.30;
			w = 0.275; h = 0.3;
		};
		
		class moneyEdit : Life_RscEdit 
		{
			idc = 2018;
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};

			
			text = "1";
			sizeEx = 0.030;
			x = 0.12; y = 0.42;
			w = 0.18; h = 0.03;
		};
		
		class NearPlayers : Life_RscCombo 
		{
			idc = 2022;
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};

			x = 0.12; y = 0.46;
			w = 0.18; h = 0.03;
		};
		
		class moneyDrop : Life_RscButtonMenu
		{
			idc = 2001;
			text = "$STR_Global_Give";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};

			onButtonClick = "[] call life_fnc_giveMoney";
			sizeEx = 0.025;
			x = 0.135; y = 0.50;
			w = 0.13; h = 0.036;
		};
		
		class itemEdit : Life_RscEdit  {
		
		idc = item_edit;
		colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
		text = "1";
		sizeEx = 0.030;
		x = 0.62; y = 0.61;
		w = 0.275; h = 0.03;
		
		};

		class iNearPlayers : Life_RscCombo
		{
			idc = 2023;
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			x = 0.62; y = 0.65;
			w = 0.275; h = 0.03;
		};
		
		class DropButton : life_RscButtonMenu {
			
			idc = 2002;
			text = "$STR_Global_Give";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_giveItem;";
			
			x = 0.765;
			y = 0.70;
			w = (5.25 / 40);
			h = (1 / 25);
			
		};
		
		class UseButton : life_RscButtonMenu {
			
			text = "$STR_Global_Use";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_useItem;";
			
			x = 0.62;
			y = 0.70;
			w = (5.25 / 40);
			h = (1 / 25);
			
		};
		
		class RemoveButton : life_RscButtonMenu {
			
			text = "$STR_Global_Remove";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_removeItem;";
			
			x = 0.475;
			y = 0.70;
			w = (5.25 / 40);
			h = (1 / 25);
			
		};
		
		class ButtonClose : life_RscButtonMenu {
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "$STR_Global_Close";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "closeDialog 0;";
			x = 0.1;
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class ButtonSettings : life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Settings";
			onButtonClick = "[] call life_fnc_settingsMenu;";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class ButtonStop : Life_RscButtonMenu {
			idc = 2011;
			text = "$STR_PM_MyGang";
			onButtonClick = "if(isNil ""life_action_gangInUse"") then {if(isNil {(group player) getVariable ""gang_owner""}) then {createDialog ""STS_Life_Create_Gang_Diag"";} else {[] spawn life_fnc_gangMenu;};};";
			x = 0.1 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class ButtonMyGang : Life_RscButtonMenu {
			idc = 3011;
			text = "All Stop";
			onButtonClick = "doStop (units player);";
			x = 0.42 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			y = 0.805;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class Licenses_Menu : Life_RscControlsGroup
		{
			idc = -1;
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			w = 0.28;
			h = 0.38;
			x = 0.34;
			y = 0.30;
			
			class Controls
			{
				class Life_Licenses : Life_RscStructuredText
				{
					idc = 2014;
					sizeEx = 0.020;
					colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
					text = "";
					x = 0;
					y = 0;
					w = 0.27; h = 0.65;
				};
			};
		};
		
		class ButtonGangList : Life_RscButtonMenu {
			idc = 2012;
			text = "Charge Civ";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "createDialog ""STS_Life_charge"";";
			x = 0.1 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
	
		class ButtonKeys : Life_RscButtonMenu {
			idc = 2013;
			text = "$STR_PM_KeyChain";
			onButtonClick = "createDialog ""STS_Life_key_management"";";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			x = 0.26 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class ButtonCell : Life_RscButtonMenu {
			idc = 2014;
			text = "$STR_PM_CellPhone";
			onButtonClick = "createDialog ""STS_Life_my_smartphone"";";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			x = 0.42 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class ButtonAdminMenu : Life_RscButtonMenu {
			idc = 2021;
			text = "$STR_PM_AdminMenu";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "createDialog ""STS_life_admin_menu"";";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.805;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		class TaxiMenu: Life_RscButtonMenu
		{
			idc = 100;
			onButtonClick = "if (license_civ_taxi AND life_isOnDutyTaxi) then { [] spawn life_fnc_openTaxiMenu; } else { hint ""You are either not a taxi driver or not on duty!""; };";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "TAXI MENU";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.855;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		class TaxiCall: Life_RscButtonMenu
		{
			idc = 101;
			onButtonClick = "closeDialog 0;[] call life_fnc_taxi_call;";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "CALL TAXI";
			x = 0.42 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.805;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		class ButtonSyncData : life_RscButtonMenu {
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "$STR_PM_SyncData";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call SOCK_fnc_syncData;";
			x = 0.1;
			y = 0.805;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class ButtonMarket : Life_RscButtonMenu {
			idc = -1;
			text = "Market";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_openMarketView;";
			x = 0.26 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.805;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class ButtonMyGroup : Life_RscButtonMenu {
			idc = 1999;
			text = "Groups";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_groupMenu";
			x = 0.1 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.805;
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};