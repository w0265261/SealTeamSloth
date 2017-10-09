class STS_house_inv
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
			w = 0.40; h = (1 / 25);
		};
		
		class Mainbackground : Life_RscText
		{
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			idc = -1;
			x = 0.1; y = 0.2 + (11 / 250);
			w = 0.40; h = 0.6 - (20 / 250);
		};
		
		class Title : Life_RscTitle
		{
			colorBackground[] = {0,0,0,0};
			idc = 38401;
			text = "Inventory Management";
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
			onLBSelChanged = "_this call KBW_fnc_houseInvFilter";
			x = 0.11; y = 0.64;
			w = 0.3; h = 0.035;
		};
	};
	
	class controls
	{
		class itemList : Life_RscListBox
		{
			idc = 38403;
			onLBSelChanged = "";
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			sizeEx = 0.035;
			x = 0.11; y = 0.25;
			w = 0.38; h = 0.38;
		};
		
		class ButtonBuySell : Life_RscButtonMenu
		{
			idc = 38405;
			text = "Withdraw";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call KBW_fnc_invInteraction; true";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.85 - (1 / 25);
			w = (6.4 / 40);
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

	};
};