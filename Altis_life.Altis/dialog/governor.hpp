class STS_life_governor_menu 
{
	idd = 1900;
	name= "STS_life_governor_menu";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "";
	
	class controlsBackground {
		class TAWVD_RscTitleBackground : life_RscText {
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};
			idc = -1;
			x = 0.3;
			y = 0.2;
			w = 0.5;
			h = (1 / 25);
		};
		
		class MainBackground : life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.3;
			y = 0.2 + (11 / 250);
			w = 0.5;
			h = 0.5 - (22 / 250);
		};
		
		class VDonFoot : life_RscText
		{
			idc = -1;
			text = "Sales:";
			
			x = 0.32; y = 0.258;
			w = 0.275; h = 0.04;
		};

	};
	
	class controls 
	{
		class Title : life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "Taxes";
			x = 0.3;
			y = 0.2;
			w = 0.8;
			h = (1 / 25);
		};
		
		class VD_onfoot_slider : life_RscXSliderH 
		{
			idc = 1901;
			text = "";
			onSliderPosChanged = "[3,_this select 1] call life_fnc_s_onSliderChange;";
			tooltip = "Sales tax as a percentage";
			x = 0.42;
			y = 0.30 - (1 / 25);
			
			w = "9 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		
		class VD_onfoot_value : life_RscText
		{
			idc = 1902;
			text = "";
			
			x = 0.70; y = 0.258;
			w = 0.275; h = 0.04;
		};
		
		class SideChannelSettings : life_RscText
		{
			idc = 1865;
			text = "Law Toggles";
			shadow = 0;
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};

			x = 0.30;
			y = 0.35;
			w = 0.5;
			h = (1 / 25);
		};
		
		class MarijuanaONOFF : Life_RscActiveText
		{
			idc = 1926;
			text = "Marijuana";
			color[] = {1, 0, 0, 1};
			action = "if(!life_governor) exitWith {}; [3] call life_fnc_toggleLaw";
			sizeEx = 0.04;
			
			x = 0.45; y = 0.4;
			w = 0.275; h = 0.04;
		};
		
		class DeathONOFF : Life_RscActiveText
		{
			idc = 1928;
			text = "Death Penalty";
			color[] = {1, 0, 0, 1};
			action = "if(!life_governor) exitWith {}; [4] call life_fnc_toggleLaw";
			sizeEx = 0.04;
			
			x = 0.45; y = 0.6;
			w = 0.275; h = 0.04;
		};
		
		class HealthONOFF : Life_RscActiveText
		{
			idc = 1994;
			text = "Healthcare";
			color[] = {1, 0, 0, 1};
			action = "if(!life_governor) exitWith {}; [2] call life_fnc_toggleLaw";
			sizeEx = 0.04;
			
			x = 0.45; y = 0.45;
			w = 0.275; h = 0.04;
		};
		
		class policeONOFF : Life_RscActiveText
		{
			idc = 1995;
			text = "coppay";
			color[] = {1, 0, 0, 1};
			action = "if(!life_governor) exitWith {}; [6] call life_fnc_toggleLaw";
			sizeEx = 0.04;
			
			x = 0.45; y = 0.50;
			w = 0.275; h = 0.04;
		};
		
		class civilianONOFF : Life_RscActiveText
		{
			idc = 1996;
			text = "civpay";
			color[] = {1, 0, 0, 1};
			action = "if(!life_governor) exitWith {}; [7] call life_fnc_toggleLaw";
			sizeEx = 0.04;
			
			x = 0.45; y = 0.55;
			w = 0.275; h = 0.04;
		};

		class ButtonClose : life_RscButtonMenu {
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "Close";
			onButtonClick = "closeDialog 0; if(!life_governor) exitWith {}; if(!isNil 'govCheck') exitWith {titleText ['Law changes did not take effect due to not meeting tax requirements','PLAIN']; hint 'The tax rate was not high enough to support your changes, and thus they did not take effect. Please edit the tax rate.';}; titleText['Laws successfully updated','PLAIN']; life_rules remoteExec ['life_fnc_configChanged',2];";
			x = 0.48;
			y = 0.7 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};