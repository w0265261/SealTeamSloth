class STS_life_vote_menu {
	idd = 6900;
	name= "STS_life_vote_menu";
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
			colorBackground[] = {0, 0, 0, 0.7};
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
			idc = 6901;
			text = "Presidential Voting Booth";
			x = 0.1;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};
		
		class PlayerList_Admin : Life_RscListBox 
		{
			idc = 6902;
			text = "";
			sizeEx = 0.035;
			//colorBackground[] = {0,0,0,0};
			onLBSelChanged = "[false,_this] call life_fnc_candidate";
			
			x = 0.12; y = 0.26;
			w = 0.30; h = 0.6 - 0.04;
		};
		
		class PlayerBInfo : Life_RscStructuredText
		{
			idc = 6903;
			text = "";
			x = 0.42;
			y = 0.25;
			w = 0.45;
			h = 0.6;
		};

		class CloseButtonKey : Life_RscButtonMenu {
			idc = -1;
			text = "Close";
			onButtonClick = "closeDialog 0;";
			x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.88 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class VoteKey : Life_RscButtonMenu {
			idc = 6905;
			text = "Vote";
			onButtonClick = "life_voted = true; [true,lbData[6902,(lbCurSel 6902)]] call life_fnc_candidate; closeDialog 0;";
			x = 0.9 - (6.25 / 40);
			y = 0.88 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};