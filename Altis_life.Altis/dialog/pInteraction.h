#define BGX 0.35
#define BGY 0.2
#define BGW 0.3

class STS_pInteraction_Menu
{
	idd = 37400;
	movingEnabled = false;
	enableSimulation = true;
	
	class controlsBackground
	{
		class RscTitleBackground:life_RscText 
		{
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};
			idc = -1;
			x = BGX;
			y = BGY;
			w = BGW;
			h = (1 / 25);
		};
		
		class MainBackground : life_RscText
		{
			idc = -1;
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};

			x = BGX;
			y = BGY + (11 / 250);
			w = BGW;
			h = 0.6 - (22 / 250);
		};
		
		class Title : life_RscTitle
		{
			colorBackground[] = {0,0,0,0};
			idc = 37401;
			text = "$STR_pInAct_Title";
			x = BGX;
			y = BGY;
			w = BGW;
			h = (1 / 25);
		};
	};
	
	class controls
	{
		class ButtonClose : life_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "$STR_Global_Close";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "closeDialog 0;";
			x = BGX;
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class ButtonOne : life_RscButtonMenu
		{
			idc = 37450;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.07;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonTwo : life_RscButtonMenu
		{
			idc = 37451;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.12;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonThree : life_RscButtonMenu
		{
			idc = 37452;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.17;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonFour : life_RscButtonMenu
		{
			idc = 37453;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.22;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonFive : life_RscButtonMenu
		{
			idc = 37454;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.27;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonSix : life_RscButtonMenu
		{
			idc = 37455;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.32;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonSeven : life_RscButtonMenu
		{
			idc = 37456;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.37;
			w = 0.24;
			h = 0.038;
		};
		class ButtonEight : life_RscButtonMenu
		{
			idc = 37457;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.42;
			w = 0.24;
			h = 0.038;
		};

		class ButtonNine : life_RscButtonMenu
		{
			idc = 37458;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.47;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonTen : life_RscButtonMenu
		{
			idc = 37459;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.52;
			w = 0.24;
			h = 0.038;
		};
		
	};
};

class STS_vInteraction_Menu
{
	idd = 37400;
	movingEnabled = false;
	enableSimulation = true;
	
	class controlsBackground
	{
		class RscTitleBackground:life_RscText 
		{
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};
			idc = -1;
			x = BGX;
			y = BGY;
			w = BGW;
			h = (1 / 25);
		};
		
		class MainBackground : life_RscText
		{
			idc = -1;
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			x = BGX;
			y = BGY + (11 / 250);
			w = BGW;
			h = 0.45 - (4 / 250);
		};
		
		class Title : life_RscTitle
		{
			colorBackground[] = {0,0,0,0};
			idc = 37401;
			text = "$STR_vInAct_Title";
			x = BGX;
			y = BGY;
			w = BGW;
			h = (1 / 25);
		};
	};
	
	class controls
	{
		class ButtonClose : life_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "$STR_Global_Close";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "closeDialog 0;";
			x = BGX;
			y = 0.65 - (-0.85 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class ButtonOne : life_RscButtonMenu
		{
			idc = 37450;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.07;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonTwo : life_RscButtonMenu
		{
			idc = 37451;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.12;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonThree : life_RscButtonMenu
		{
			idc = 37452;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.17;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonFour : life_RscButtonMenu
		{
			idc = 37453;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.22;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonFive : life_RscButtonMenu
		{
			idc = 37454;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.27;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonSix : life_RscButtonMenu
		{
			idc = 37455;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.32;
			w = 0.24;
			h = 0.038;
		};
		class ButtonSeven : life_RscButtonMenu
		{
			idc = 37456;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.37;
			w = 0.24;
			h = 0.038;
		};
		class ButtonEight : life_RscButtonMenu
		{
			idc = 37457;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.42;
			w = 0.24;
			h = 0.038;
		};
	};
};

class STS_cInteraction_Menu
{

	idd = 37400;
	movingEnabled = false;
	enableSimulation = true;
	
	class controlsBackground
	{
		class RscTitleBackground:life_RscText 
		{
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};
			idc = -1;
			x = BGX;
			y = BGY;
			w = BGW;
			h = (1 / 25);
		};
		
		class MainBackground : life_RscText
		{
			idc = -1;
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			x = BGX;
			y = BGY + (11 / 250);
			w = BGW;
			h = 0.6 - (22 / 250);
		};
		
		class Title : life_RscTitle
		{
			colorBackground[] = {0,0,0,0};
			idc = 37401;
			text = "$STR_pInAct_Title";
			x = BGX;
			y = BGY;
			w = BGW;
			h = (1 / 25);
		};
	};
	
	class controls
	{
		class TargetName : Life_RscStructuredText
		{
			idc = 37450;
			text = "";
			
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.07;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonClose : life_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = BGX;
			y = BGY + 0.47;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class ButtonOne : life_RscButtonMenu
		{
			idc = 37451;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.12;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonTwo : life_RscButtonMenu
		{
			idc = 37452;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.17;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonThree : life_RscButtonMenu
		{
			idc = 37453;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.22;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonFour : life_RscButtonMenu
		{
			idc = 37454;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.27;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonFive : life_RscButtonMenu
		{
			idc = 37455;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.32;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonSix : life_RscButtonMenu
		{
			idc = 37456;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.37;
			w = 0.24;
			h = 0.038;
		};

		class ButtonSeven : life_RscButtonMenu
		{
			idc = 37457;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.42;
			w = 0.24;
			h = 0.038;
		};

		/*class ButtonEight : life_RscButtonMenu
		{
			idc = 37458;
			colorBackground[] = {0.62,0.012,0.004,0.5};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.47;
			w = 0.24;
			h = 0.038;
		};
		*/
	};
};

class STS_hInteraction_Menu
{

	idd = 37400;
	movingEnabled = false;
	enableSimulation = true;
	
	class controlsBackground
	{
		class RscTitleBackground:life_RscText 
		{
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};
			idc = -1;
			x = BGX;
			y = BGY;
			w = BGW;
			h = (1 / 25);
		};
		
		class MainBackground : life_RscText
		{
			idc = -1;
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			x = BGX;
			y = BGY + (11 / 250);
			w = BGW;
			h = 0.518;
		};
		
		class Title : life_RscTitle
		{
			colorBackground[] = {0,0,0,0};
			idc = 37401;
			text = "Building Interaction Menu";
			x = BGX;
			y = BGY;
			w = BGW;
			h = (1 / 25);
		};
	};
	
	class controls
	{
		class TargetName : Life_RscStructuredText
		{
			idc = 37450;
			text = "";
			
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.07;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonClose : life_RscButtonMenu 
		{
			idc = -1;
			text = "$STR_Global_Close";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "closeDialog 0;";
			x = BGX;
			y = BGY + 0.5;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class ButtonOne : life_RscButtonMenu
		{
			idc = 37451;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.10;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonTwo : life_RscButtonMenu
		{
			idc = 37452;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.15;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonThree : life_RscButtonMenu
		{
			idc = 37453;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.20;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonFour : life_RscButtonMenu
		{
			idc = 37454;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.25;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonFive : life_RscButtonMenu
		{
			idc = 37455;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.30;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonSix : life_RscButtonMenu
		{
			idc = 37456;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.35;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonSeven : life_RscButtonMenu
		{
			idc = 37457;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.40;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonEight : life_RscButtonMenu
		{
			idc = 37458;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.45;
			w = 0.24;
			h = 0.038;
		};
	};
};

class STS_crateInteraction_Menu
{

	idd = 37400;
	movingEnabled = false;
	enableSimulation = true;
	
	class controlsBackground
	{
		class RscTitleBackground:life_RscText 
		{
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};
			idc = -1;
			x = BGX;
			y = BGY;
			w = BGW;
			h = (1 / 25);
		};
		
		class MainBackground : life_RscText
		{
			idc = -1;
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			x = BGX;
			y = BGY + (11 / 250);
			w = BGW;
			h = 0.448 - (22 / 250);
		};
		
		class Title : life_RscTitle
		{
			colorBackground[] = {0,0,0,0};
			idc = 37401;
			text = "Crate Interaction Menu";
			x = BGX;
			y = BGY;
			w = BGW;
			h = (1 / 25);
		};
	};
	
	class controls
	{
		class TargetName : Life_RscStructuredText
		{
			idc = 37450;
			text = "";
			
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.07;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonClose : life_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "$STR_Global_Close";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "closeDialog 0;";
			x = BGX;
			y = 0.6 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class ButtonOne : life_RscButtonMenu
		{
			idc = 37451;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.12;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonTwo : life_RscButtonMenu
		{
			idc = 37452;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.17;
			w = 0.24;
			h = 0.038;
		};
	};
};

class STS_mInteraction_Menu
{

	idd = 37400;
	movingEnabled = false;
	enableSimulation = true;
	
	class controlsBackground
	{
		class RscTitleBackground:life_RscText 
		{
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};
			idc = -1;
			x = BGX;
			y = BGY;
			w = BGW;
			h = (1 / 25);
		};
		
		class MainBackground : life_RscText
		{
			idc = -1;
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			x = BGX;
			y = BGY + (11 / 250);
			w = BGW;
			h = 0.486 - (22 / 250);
		};
		
		class Title : life_RscTitle
		{
			colorBackground[] = {0,0,0,0};
			idc = 37401;
			text = "$STR_pInAct_Title";
			x = BGX;
			y = BGY;
			w = BGW;
			h = (1 / 25);
		};
	};
	
	class controls
	{
		class TargetName : Life_RscStructuredText
		{
			idc = 37450;
			text = "";
			
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.07;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonClose : life_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "$STR_Global_Close";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "closeDialog 0;";
			x = BGX;
			y = 0.6 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class ButtonOne : life_RscButtonMenu
		{
			idc = 37451;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.12;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonTwo : life_RscButtonMenu
		{
			idc = 37452;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.17;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonThree : life_RscButtonMenu
		{
			idc = 37453;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.22;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonFour : life_RscButtonMenu
		{
			idc = 37454;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.27;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonFive : life_RscButtonMenu
		{
			idc = 37455;
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.32;
			w = 0.24;
			h = 0.038;
		};
		/*
		class ButtonSix : life_RscButtonMenu
		{
			idc = 37456;
			colorBackground[] = {0.62,0.012,0.004,0.5};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.37;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonSeven : life_RscButtonMenu
		{
			idc = 37457;
			colorBackground[] = {0.62,0.012,0.004,0.5};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.42;
			w = 0.24;
			h = 0.038;
		};
		
		class ButtonEight : life_RscButtonMenu
		{
			idc = 37458;
			colorBackground[] = {0.62,0.012,0.004,0.5};
			text = "";
			sizeEx = 0.025;
			x = BGX + 0.03;
			y = BGY + 0.47;
			w = 0.24;
			h = 0.038;
		};
		*/
	};
};