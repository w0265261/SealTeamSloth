class STS_life_feedback {
	idd = 1337;
	name= "life_feedback";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[] spawn {disableSerialization; waitUntil {!isNull (findDisplay 1337)}; _display = findDisplay 1337; _list = _display displayCtrl 1338; { if(side _x == west) then {_list lbAdd format['%1',name _x]; _list lbSetdata [(lbSize _list)-1,name _x]}; } forEach playableUnits; };";
	
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
			idc = 1336;
			text = "Provide Feedback";
			
			x = 0.1;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};
		
		class PlayerList_Admin : Life_RscListBox 
		{
			idc = 1338;
			text = "";
			sizeEx = 0.035;

			
			x = 0.12; y = 0.26;
			w = 0.30; h = 0.4;
		};
		
		class PlayerBInfo : Life_RscEdit
		{
			idc = 1339;
			text = "";
			sizeEx = 0.06;
			x = 0.42;
			y = 0.25;
			w = 0.35;
			h = 0.2;
		};

		class CloseButtonKey : Life_RscButtonMenu {
			idc = -1;
			text = "Add Officer";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "if((lbData[1338,(lbCurSel 1338)]) in life_feedback) exitWith {}; life_feedback pushBack lbData[1338,(lbCurSel 1338)]; systemChat format['Current officers you are providing feedback on: %1',life_feedback];";
			x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.88 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class feedback : Life_RscButtonMenu {
			idc = -1;
			text = "Send Feedback";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "if(count life_feedback == 0 || isNil 'life_copRating' || ctrlText 1339 == '') exitWith {systemChat 'Error: make your you have chosen a rating and officers to provide feedback on, as well as typed in your personal feedback.'}; [life_copRating,life_feedback,ctrlText 1339,[profileName,getPlayerUID player]] remoteExec ['DB_fnc_copFeedback',2]; life_copRating = nil; life_feedback = []; closeDialog 0; systemChat 'Thanks for your feedback, we will review this and use it to make the ALE better. You have been awarded $1000 for your efforts.'; ['atm','add',1000] call life_fnc_handlePaper; if(!isNil 'totaltime') then {totalTime = totalTime - 60};";
			x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.885;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class AdminID : Life_RscButtonMenu {
			idc = -1;
			text = "Rate 1/4";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "life_copRating = 1; systemChat 'You have chosen to rate your experience a 1 out of 4, indicating the cops performed poorly';";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.88 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class Spectate : Life_RscButtonMenu {
			idc = -1;
			text = "Rate 2/4";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "life_copRating = 2; systemChat 'You have chosen to rate your experience a 2 out of 4, indicating the cops performed at a mediocre level.';";
			x = 0.26 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.88 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class Revive : Life_RscButtonMenu {
			idc = -1;
			text = "Rate 3/4";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "life_copRating = 3; systemChat 'You have chosen to rate your experience a 3 out of 4, indicating the cops performed at a satisfactory level.';";
			x = 0.42 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.88 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};

		class SeizeWeapons : Life_RscButtonMenu {
			idc = -1;
			text = "Rate 4/4";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			onButtonClick = "life_copRating = 4; systemChat 'You have chosen to rate your experience a 4 out of 4, indicating the cops performed exceptionally.';";
			x = 0.58 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.88 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};