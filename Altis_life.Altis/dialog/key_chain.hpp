class STS_Life_key_management {
	idd = 2700;
	name= "life_key_chain";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[] spawn life_fnc_keyMenu;";
	
	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};
			idc = -1;
			x = 0.1;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};
		
		class MainBackground:Life_RscText {
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			idc = -1;
			x = 0.1;
			y = 0.2 + (11 / 250);
			w = 0.6;
			h = 0.6 - (22 / 250);
		};
	};
	
	class controls {

		
		class Title : Life_RscTitle {
			idc = -1;
			text = "Your Keys";
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};
			x = 0.1;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};
		
		class KeyChainList : Life_RscListBox 
		{
			idc = 2701;
			text = "";
			sizeEx = 0.035;
			
			x = 0.12; y = 0.26;
			w = 0.56; h = 0.370;
		};

		class CloseButtonKey : Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "closeDialog 0;";
			x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class NearPlayers : Life_RscCombo {
		
		idc = 2702;
		
		x = 0.26; y = 0.645;
		w = 0.275; h = 0.03;
		
		};
		
		class DropKey : life_RscButtonMenu {
			idc = -1;
			text = "Drop Key";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_keyDrop";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class GiveKey : Life_RscButtonMenu {
			idc = 2703;
			text = "Give Key";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_keyGive";
			x = 0.32;
			y = 0.69;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class ReportStolen: Life_RscButtonMenu {
			idc = 2704;
			text = "Rep.Stolen";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_reportStolen";
			x = 0.26 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};