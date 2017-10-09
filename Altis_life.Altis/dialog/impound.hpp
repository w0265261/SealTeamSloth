class STS_Life_impound_menu
{
	idd = 2800;
	name="life_vehicle_shop";
	movingEnabled = 0;
	enableSimulation = 1;
	onLoad = "ctrlShow [2330,false];";
	
	class controlsBackground
	{
		class Life_RscTitleBackground : Life_RscText
		{
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};
			idc = -1;
			x = 0.1;
			y = 0.2;
			w = 0.8;
			h = (1 / 25);
		};
		
		class MainBackground : Life_RscText
		{
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			idc = -1;
			x = 0.1;
			y = 0.2 + (11 / 250);
			w = 0.8;
			h = 0.7 - (22 / 250);
		};
		
		class Title : Life_RscTitle
		{
			idc = 2801;
			text = "$STR_GUI_Garage";
			x = 0.1;
			y = 0.2;
			w = 0.8;
			h = (1 / 25);
		};
		
		class VehicleTitleBox : Life_RscText
		{
			idc = -1;
			text = "$STR_GUI_YourVeh";
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};
			x = 0.11; y = 0.26;
			w = 0.3;
			h = (1 / 25);
		};
		
		class VehicleInfoHeader : Life_RscText
		{
			idc = 2830;
			text = "$STR_GUI_VehInfo";
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};
			x = 0.42; y = 0.26;
			w = 0.46;
			h = (1 / 25);
		};
		
		class CloseBtn : Life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_Global_Close";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "closeDialog 0;";
			x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.9 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class RentCar : Life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_Global_Retrieve";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_unimpound;";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.9 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class BuyCar : life_RscButtonMenu 
		{
			idc = -1;
			text = "$STR_Global_Sell";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_sellGarage;";
			x = 0.26 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.9 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class Rename : life_RscButtonMenu 
		{
			idc = -1;
			text = "Rename";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] spawn life_fnc_renameGarage;";
			x = 0.42 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.9 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class Insure : life_RscButtonMenu 
		{
			idc = -1;
			text = "Temp insure nearest";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "false spawn life_fnc_insurance;";
			x = (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.95 - (1 / 25);
			w = (11 / 40);
			h = (1 / 25);
		};
		
		class Insurance : life_RscButtonMenu 
		{
			idc = -1;
			text = "Perm insure nearest";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "true spawn life_fnc_insurance;";
			x = 0.3 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.95 - (1 / 25);
			w = (11 / 40);
			h = (1 / 25);
		};
		
		class ExchangeVehicle : life_RscButtonMenu 
		{
			idc = 1007;
			text = "List on Exchange";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] spawn KBW_fnc_vehicleExchange;";
			x = (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 1 - (1 / 25);
			w = (11 / 40);
			h = (1 / 25);
		};
	};
	
	class controls
	{
		class VehicleList : Life_RscListBox
		{
			idc = 2802;
			text = "";
			sizeEx = 0.04;
			colorBackground[] = {0.1,0.1,0.1,0.9};
			onLBSelChanged = "_this call life_fnc_garageLBChange;";
			
			//Position & height
			x = 0.11; y = 0.302;
			w = 0.303; h = 0.49;
		};
		
		class vehicleInfomationList : Life_RscStructuredText
		{
			idc = 2803;
			text = "";
			sizeEx = 0.035;
			
			x = 0.41; y = 0.3;
			w = 0.5; h = 0.5;
		};
		
		class MainBackgroundHider : Life_RscText
		{
			colorBackground[] = {0,0,0,1};
			idc = 2810;
			x = 0.1;
			y = 0.2 + (11 / 250);
			w = 0.8;
			h = 0.7 - (22 / 250);
		};
		
		class MainHideText : Life_RscText
		{
			idc = 2811;
			text = "$STR_ANOTF_QueryGarage";
			sizeEx = 0.06;
			x = 0.24; y = 0.5;
			w = 0.6;
			h = (1 / 15);
		};
	};
};


class STS_Life_renameCar_menu {
	idd = 2850;
	name= "Life_renameCar_menu";
	movingEnable = false;
	enableSimulation = true;
	
	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			idc = -1;
			x = 0.1;
			y = 0.2;
			w = 0.5;
			h = (1 / 25);
		};
		
		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.1;
			y = 0.2 + (11 / 250);
			w = 0.5;
			h = 0.3 - (22 / 250);
		};
	};
	
	class controls {
	
		class InfoMsg : Life_RscStructuredText
		{
			idc = 2851;
			sizeEx = 0.020;
			text = "";
			x = 0.1;
			y = 0.25;
			w = 0.5; h = .11;
		};
		
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "Rename Garage Vehicle";
			x = 0.1;
			y = 0.2;
			w = 0.5;
			h = (1 / 25);
		};

		class CloseLoadMenu : Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;[] call life_fnc_p_updateMenu;";
			x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.5 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class RenameCarField : Life_RscButtonMenu {
			idc = -1;
			text = "Rename";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "newVehName = ctrlText 2852;closeDialog 0;";
			x = 0.27;
			y = 0.40;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class RenameCarText : Life_RscEdit
		{
			idc = 2852;
			text = "";
			
			x = 0.04 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.35;
			w = (13 / 40);
			h = (1 / 25);
		};
	};
};