class STS_life_wanted_menu {
	idd = 2400;
	name= "life_wanted_menu";
	movingEnable = false;
	enableSimulation = true;
	
	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = -0.35;
			y = -0.2 + (11 / 250);
			w = 1.6;
			h = 0.2 - (22 / 250);
		};
		
		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.5};
			idc = -1;
			x = -0.35;
			y = -0.2 + (11 / 250);
			w = 1.6;
			h = 1.27 - (22 / 250);
		};

		class ListBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = .15;
			y = 0;
			w = 1.05;
			h = 0.08;
		};
	};
	
	class controls {
		
		class Title {
			idc = -1; 
			type = 13;
		    style = 0x00;
		    x = -0.35;
			y = -0.2 + (11 / 250);
			w = 1.6;
			h = 0.2 - (22 / 250);
		    size = 0.1;
		    text = "$STR_Wanted_Title";
			class Attributes {
		    	font = "PuristaLight";
		    	color = "#FFF";
		    	align = "Left";
		    	valign = "middle";
		    };
		};
		
		class WantedConnection {
			idc = 2404;
			style = 1;
			text = ""; 
		    type = 13;
		    x = -0.35;
			y = -0.175 + (11 / 250);
			w = 1.6;
			h = 0.2 - (22 / 250);
		    size = 0.06;
		    class Attributes {
		    	font = "PuristaLight";
		    	color = "#FFF";
		    	align = "Right";
		    	valign = "middle";
		    	shadow = false;
		    };
		};
		
		class WantedList : Life_RscListBox {
			colorBackground[] = {0, 0, 0, 0.4};
			idc = 2401;
			text = "";
			sizeEx = 0.035;
			onLBSelChanged = "[] call life_fnc_wantedInfo";
			x = .15;
			y = 0.08;
			w = 1.05;
			h = 0.84;
		    class Attributes {
		    	font = "PuristaLight";
		    	color = "#FFF";
		    	align = "Right";
		    	valign = "middle";
		    	shadow = false;
		    };
		};
		
		class wantedListTitle {
		    idc = 2406;
		    type = 13;
		    style = 0x00;
			x = .15;
			y = 0.02;
			w = 1.05;
			h = 0.08;
		    size = 0.04;
		    text = "";
		    class Attributes {
		    	font = "PuristaLight";
		    	color = "#FFF";
		    	align = "left";
		    	valign = "middle";
		    	shadow = false;
		    };
		};
		
		class WantedDetails : Life_RscListBox
		{
			idc = 2402;
			text = "";
			sizeEx = 0.035;
			colorBackground[] = {0, 0, 0, 0};
			x = -0.3;
			y = 0.1;
			w = 0.4;
			h = 0.6;
		};
		
		class BountyPrice : Life_RscText
		{
			idc = 2403;
			style = 1;
			size = 0.1;
		    type = 13;
			text = "";
			x = -0.3;
			y = 0;
			w = 0.4;
			h = 0.3;
		    class Attributes {
		    	font = "PuristaLight";
		    	color = "#FFEA00";
		    	align = "Left";
		    	valign = "middle";
		    	shadow = false;
		    };
		};

		class CloseButtonKey : Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 1.02;
			y = 0.94;
			w = 0.18;
			h = 0.06;
	    	size = 0.05;
		    class Attributes {
		    	font = "PuristaLight";
		    	color = "#FFF";
		    	align = "center";
		    	valign = "middle";
		    	shadow = false;
		    };
		};

		class PardonButtonKey : Life_RscButtonMenu {
			idc = 2405;
			text = "$STR_Wanted_Pardon";
			onButtonClick = "[] call life_fnc_pardon;";
			x = 0.75;
			y = 0.94;
			w = 0.21;
			h = 0.06;
	    	size = 0.05;
		    class Attributes {
		    	font = "PuristaLight";
		    	color = "#FFF";
		    	align = "center";
		    	valign = "middle";
		    	shadow = false;
		    };
		};
		
		class moreDetails : Life_RscButtonMenu {
			idc = 1994;
			text = "Detailed View";
			onButtonClick = "[true] call life_fnc_wantedInfo; ((findDisplay 2400) displayCtrl 1994) ctrlShow false;";
			x = 0.4;
			y = 0.94;
			w = 0.32;
			h = 0.06;
	    	size = 0.05;
		    class Attributes {
		    	font = "PuristaLight";
		    	color = "#FFF";
		    	align = "center";
		    	valign = "middle";
		    	shadow = false;
		    };
		};
		
		class mainView : Life_RscButtonMenu {
			idc = 1995;
			text = "Main View";
			onButtonClick = "_display = findDisplay 2400; _list = _display displayCtrl 2402; lbClear _list; call life_fnc_wantedList; ((findDisplay 2400) displayCtrl 1994) ctrlShow true;";
			x = 0.05;
			y = 0.94;
			w = 0.3;
			h = 0.06;
	    	size = 0.05;
		    class Attributes {
		    	font = "PuristaLight";
		    	color = "#FFF";
		    	align = "center";
		    	valign = "middle";
		    	shadow = false;
		    };
		};
	};
};