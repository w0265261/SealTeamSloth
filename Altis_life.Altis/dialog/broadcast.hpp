class STS_life_broadcast_menu {
	idd = 10400;
	name= "STS_life_broadcast_menu";
	movingEnable = false;
	enableSimulation = true;
	
	class controlsBackground {	
		class MainBackground:Life_RscText {
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			idc = -1;
			x = 0.389875 * safezoneW + safezoneX;
			y = 0.415387 * safezoneH + safezoneY;
			w = 0.215844 * safezoneW;
			h = 0.122219 * safezoneH;
		};
	};
	
	class controls {
		class RscText_Head : Life_RscText {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "Broadcast Headline:";
			x = 0.39428 * safezoneW + safezoneX;
			y = 0.424788 * safezoneH + safezoneY;
			w = 0.11453 * safezoneW;
			h = 0.0188029 * safezoneH;
		};
		
		class RscEdit_Head: Life_RscEdit
		{
			idc = 10402;
			text = "";
			sizeEx = 0.030;
			x = 0.39428 * safezoneW + safezoneX;
			y = 0.443591 * safezoneH + safezoneY;
			w = 0.207034 * safezoneW;
			h = 0.0282044 * safezoneH;
		};
		class RscText_Message: Life_RscText
		{
			idc = -1;
			text = "Broadcast message:";
			x = 0.39428 * safezoneW + safezoneX;
			y = 0.481197 * safezoneH + safezoneY;
			w = 0.11453 * safezoneW;
			h = 0.0188029 * safezoneH;
		}; 
		class RscEdit_Message: Life_RscEdit
		{
			idc = 10404;
			text = "";
			sizeEx = 0.030;
			x = 0.39428 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.207034 * safezoneW;
			h = 0.0282044 * safezoneH;
		};
		class OK_Button: Life_RscButtonMenu
		{
			idc = -1;
			text = "Broadcast!";
			x = 0.5 * safezoneW + safezoneX;
			y = 0.547007 * safezoneH + safezoneY;
			w = 0.10572 * safezoneW;
			h = 0.0188029 * safezoneH;
			onButtonClick = "['atm','take',10000] call life_fnc_handlePaper; [ctrlText 10402,ctrlText 10404,player] remoteExec ['life_fnc_showBroadcast',0]; life_last_broadcast = serverTime; publicVariable ""life_last_broadcast""; closeDialog 0;";
		};
		class Cancel_Button: Life_RscButtonMenu
		{
			idc = -1;
			text = "Cancel";
			x = 0.389875 * safezoneW + safezoneX;
			y = 0.547007 * safezoneH + safezoneY;
			w = 0.0616698 * safezoneW;
			h = 0.0188029 * safezoneH;
			onButtonClick = "closeDialog 0;";
		};

	};
};