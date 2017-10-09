class STS_life_weapon_shop
{
	idd = 38400;
	movingEnabled = false;
	enableSimulation = true;
	
	class controlsBackground
	{
		class RscTitleBackground : Life_RscText
		{
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};
			idc = -1;
			x = 0.1; y = 0.2;
			w = 0.32; h = (1 / 25);
		};
		
		class Mainbackground : Life_RscText
		{
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			idc = -1;
			x = 0.1; y = 0.2 + (11 / 250);
			w = 0.32; h = 0.6 - (22 / 250);
		};
		
		class Title : Life_RscTitle
		{
			colorBackground[] = {0,0,0,0};
			idc = 38401;
			text = "";
			x = 0.1; y = 0.2;
			w = 0.32; h = (1 / 25);
		};
		
		class itemInfo : Life_RscStructuredText
		{
			idc = 38404;
			text = "";
			sizeEx = 0.035;
			x = 0.11; y = 0.68;
			w = 0.2; h = 0.2;
		};
		
		class FilterList : Life_RscCombo
		{
			idc = 38402;
			onLBSelChanged = "_this call life_fnc_weaponShopFilter";
			x = 0.11; y = 0.64;
			w = 0.3; h = 0.035;
		};
	};
	
	class controls
	{
		class itemList : Life_RscListBox
		{
			idc = 38403;
			onLBSelChanged = "_this call life_fnc_weaponShopSelection";
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			sizeEx = 0.035;
			x = 0.11; y = 0.25;
			w = 0.3; h = 0.38;
		};
		
		class ButtonBuySell : Life_RscButtonMenu
		{
			idc = 38405;
			text = "$STR_Global_Buy";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "false spawn life_fnc_weaponShopBuySell; true";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.85 - (1 / 25);
			w = (6.4 / 40);
			h = (1 / 25);
		};
		
		class Buttonprestige : Life_RscButtonMenu
		{
			idc = 1070;
			text = "Prestige Purchase";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_prestigeBuy;";
			x = 0.1;
			y = 0.9 - (1 / 25);
			w = (10 / 40);
			h = (1 / 25);
		};
		
		class ButtonClose : life_RscButtonMenu 
		{
			idc = -1;
			text = "$STR_Global_Close";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "closeDialog 0;";
			x = 0.1;
			y = 0.85 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		class ButtonVBuySell : Life_RscButtonMenu
		{
			idc = 38406;
			text = "Buy for Vehicle inv.";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "true spawn life_fnc_weaponShopBuySell; true";
			x = 0.1;
			y = 0.80 - (1 / 25);
			w = 0.32;
			h = (1 / 25);
		};

	};
};

class STS_shops_menu {
	idd = 2400;
	name= "shops_menu";
	movingEnable = false;
	enableSimulation = true;
	
	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};
			idc = -1;
			x = 0.1;
			y = 0.2;
			w = 0.8;
			h = (1 / 25);
		};
		
		class MainBackground:Life_RscText {
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			idc = -1;
			x = 0.1;
			y = 0.2 + (11 / 250);
			w = 0.8;
			h = 0.6 - (22 / 250);
		};
		
		class vasText : Life_RscText
		{
			idc = -1;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "$STR_VS_SI";
			sizeEx = 0.04;
			x = 0.12; y = 0.27;
			w = 0.275; h = 0.04;
		};
		
		class vasgText : Life_RscText
		{
			idc = -1;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "$STR_VS_PI";
			sizeEx = 0.04;
			
			x = 0.60; y = 0.27;
			w = 0.275; h = 0.04;
		};
	};
	
	class controls {

		class itemList : Life_RscListBox 
		{
			idc = 2401;
			text = "";
			sizeEx = 0.030;
			
			x = 0.12; y = 0.31;
			w = 0.275; h = 0.340;
		};
		
		class pItemlist : Life_RscListBox 
		{
			idc = 2402;
			text = "";
			sizeEx = 0.030;
			
			x = 0.60; y = 0.31;
			w = 0.275; h = 0.340;
		};
			
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = 2403;
			text = "";
			x = 0.1;
			y = 0.2;
			w = 0.8;
			h = (1 / 25);
		};

		class PlayersName : Title {
			idc = 601;
			style = 1;
			text = "";
		};
		
		class buyEdit : Life_RscEdit 
		{
			idc = 2404;
			
			text = "1";
			sizeEx = 0.030;
			x = 0.12; y = 0.66;
			w = 0.27; h = 0.03;
		};
	
		class ButtonAddG : Life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_VS_BuyItem";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] spawn life_fnc_virt_buy;";
			
			x = 0.16;
			y = 0.70;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class sellEdit : Life_RscEdit 
		{
			idc = 2405;
			
			text = "1";
			sizeEx = 0.030;
			x = 0.60; y = 0.66;
			w = 0.27; h = 0.03;
		};
		class ButtonRemoveG : Life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_VS_SellItem";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_virt_sell";
			
			x = 0.67;
			y = 0.70;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class ButtonClose : Life_RscButtonMenu {
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
	};
};