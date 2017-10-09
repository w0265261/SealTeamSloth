class STS_life_admin_menu {
	idd = 2900;
	name= "life_admin_menu";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[] spawn life_fnc_adminMenu;";
	
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
			h = 0.6 - (2 / 250);
		};
	};
	
	class controls {

		
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = 2901;
			text = "$STR_Admin_Title";
			x = 0.1;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};
		
		class PlayerList_Admin : Life_RscListBox 
		{
			idc = 2902;
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			text = "";
			sizeEx = 0.035;
			onLBSelChanged = "[_this] spawn life_fnc_adminQuery";
			
			x = 0.12; y = 0.26;
			w = 0.30; h = 0.4;
		};
		
		class PlayerBInfo : Life_RscStructuredText
		{
			idc = 2903;
			text = "";
			x = 0.42;
			y = 0.25;
			w = 0.35;
			h = 0.6;
		};

		class Impound : Life_RscButtonMenu {
			idc = -1;
			text = "Impound";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_adminImpound;";
			x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.88 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class Unrestrain : Life_RscButtonMenu {
			idc = -1;
			text = "Unrestrain";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_adminUnrestrain;";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.88 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class Spectate : Life_RscButtonMenu {
			idc = -1;
			text = "Spectate";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_adminSpectate;";
			x = 0.26 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.88 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class Revive : Life_RscButtonMenu {
			idc = -1;
			text = "Revive";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_adminRevive;";
			x = 0.42 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.88 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class SeizeWeapons : Life_RscButtonMenu {
			idc = -1;
			text = "Seize Guns";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_adminSeizeWeapons;";
			x = 0.58 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.88 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
	
		class Jail : Life_RscButtonMenu {
			idc = -1;
			text = "JAIL";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_adminJail;";
			x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.885;
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class Teleport : Life_RscButtonMenu {
			idc = -1;
			text = "Teleport";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_adminTeleport;";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.885;
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class TPtoME: Life_RscButtonMenu {
			idc = -1;
			text = "TPtoME";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_adminTpHere;";
			x = 0.42 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.885;
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class RealFeed: Life_RscButtonMenu {
			idc = -1;
			text = "Food";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "life_hunger = 1000; life_thirst = 1000; call life_fnc_hudUpdate";
			x = 0.26 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.975;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class Feed: Life_RscButtonMenu {
			idc = -1;
			text = "Airdrop";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_adminFeed;";
			x = 0.58 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.885;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class Restrain: Life_RscButtonMenu {
			idc = -1;
			text = "Restrain";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_adminrestrain;";
			x = 0.26 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.885;
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class TPtoHIM: Life_RscButtonMenu {
			idc = -1;
			text = "TPtoHIM";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_TPtoHIM;";
			x = 0.42 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.93;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class DebugCon: Life_RscButtonMenu {
			idc = 1337;
			text = "Debug";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_adminDebugCon;";
			x = 0.58 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.975;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class Comp: Life_RscButtonMenu {
			idc = -1;
			text = "adj cash";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_adminComp;";
			x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.93;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class invis: Life_RscButtonMenu {
			idc = -1;
			text = "invisible";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] call life_fnc_hideMe;";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.93;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		class Comp2: Life_RscButtonMenu {
			idc = -1;
			text = "offl adj";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "closeDialog 0; createDialog ""STS_Adjustment_ui2"";";
			x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.975;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		/*class DebugNoob: Life_RscButtonMenu {
			idc = -1;
			text = "ForceLotto";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] spawn life_fnc_forceLotto;";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.975;
			w = (6.25 / 40);
			h = (1 / 25);
		};*/
		
		class Restart: Life_RscButtonMenu {
			idc = -1;
			text = "restart";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] spawn life_fnc_callRestart;";
			x = 0.58 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.93;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class Fog : Life_RscButtonMenu {
			idc = -1;
			text = "no fog";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[0] remoteExec [""TON_fnc_changeWeather"",2]";
			x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 1.02;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class Rain : Life_RscButtonMenu {
			idc = -1;
			text = "Price Reset";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] spawn life_fnc_resetPrices";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 1.02;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		/*class Convoy : Life_RscButtonMenu {
			idc = -1;
			text = "CONVOY";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "if(call style < 4) exitWith {hint 'Insufficient Authority'}; [] remoteExec ['TON_fnc_initConvoy1',2]";
			x = 0.1 + (12.6 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 1.02;
			w = (6.25 / 40);
			h = (1 / 25);
		};*/
		
		class norain : Life_RscButtonMenu {
			idc = -1;
			text = "No Rain";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[1] remoteExec [""TON_fnc_changeWeather"",2]";
			x = 0.42 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 1.02;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class GrantBH: Life_RscButtonMenu {
 			idc = -1;
 			text = "Grant BH";
 			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
 			onButtonClick = "[true] call life_fnc_grantBH;";
 			x = 0.26 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
 			y = 0.93;
 			w = (6.25 / 40);
 			h = (1 / 25);
 		};
		
		class sync: Life_RscButtonMenu {
			idc = -1;
			text = "sync all";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "[] spawn {_action = ['This button is only meant to be used when a server restart is imminent. Using it before, and not restarting, could have strange effects on the server. Are you sure?','Sync all data','Yes','No'] call BIS_fnc_GUIMessage; if(!_action) exitWith {}; [] remoteExec ['SOCK_fnc_syncData',civilian]; [] remoteExec ['TON_fnc_saveVehicles',2]};";
			x = 0.58 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 1.02;
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};