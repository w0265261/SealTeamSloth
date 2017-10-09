class STS_customColor
{
	idd = 2900;
	name = "STS_customColor";
	movingEnabled = 1;
	enableSimulation = 1;
	
	class controlsBackground
	{
		class RscTitleBackground : life_RscText
		{
			colorBackground[] = {0,0.3294117647058824,0.5411764705882353,1};
			idc = -1;
			x = 0.3;
			y = -0.04;
			w = 0.5;
			h = (1 / 25);
		};
		
		class RscMainBackground : life_RscText
		{
			colorBackground[] = {0.1058823529411765,0.1058823529411765,0.1058823529411765,0.93};
			idc = -1;
			x = 0.3;
			y = 0.004;
			w = 0.5;
			h = 0.24;
		};
		
		class Title : life_RscTitle
		{
			idc = -1;
			colorBackground[] = {0,0,0,0};
			text = "Customize vehicle color";
			x = 0.3;
			y = -0.04;
			w = 0.5;
			h = (1 / 25);
		};
	};
	
	class controls
	{
		class VDonFoot : life_RscText
		{
			idc = -1;
			text = "Red";
			
			x = 0.32; y = 0.018;
			w = 0.275; h = 0.04;
		};
		
		class VDinCar : life_RscText
		{
			idc = -1;
			text = "Green";
			
			x = 0.32; y = 0.065;
			w = 0.275; h = 0.04;
		};
		
		class VDinAir : life_RscText
		{
			idc = -1;
			text = "Blue";
			
			x = 0.32; y = 0.115;
			w = 0.275; h = 0.04;
		};
		class Opacity : life_RscText
		{
			idc = -1;
			text = "Brightness";
			
			x = 0.29; y = 0.165;
			w = 0.275; h = 0.04;
		};
		
		class VD_onfoot_slider : life_RscXSliderH 
		{
			idc = 2901;
			text = "";
			onSliderPosChanged = "if(!isNil 'pleaseWait') exitWith {}; pleaseWait = true; redscale = _this select 1; life_myVehicle setObjectTexture [my_selection,format['#(rgb,8,8,3)color(%1,%2,%3,%4)',redscale,greenscale,bluescale,opacity]]; [] spawn {sleep 0.1; pleaseWait = nil}";
			tooltip = "";
			x = 0.42;
			y = 0.06 - (1 / 25);
			
			w = "9 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		
		class VD_car_slider : life_RscXSliderH 
		{
			idc = 2911;
			text = "";
			onSliderPosChanged = "if(!isNil 'pleaseWait') exitWith {}; pleaseWait = true; greenscale = _this select 1; life_myVehicle setObjectTexture [my_selection,format['#(rgb,8,8,3)color(%1,%2,%3,%4)',redscale,greenscale,bluescale,opacity]]; [] spawn {sleep 0.1; pleaseWait = nil}";
			tooltip = "";
			x = 0.42;
			y = 0.11 - (1 / 25);
			
			w = "9 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		
		class VD_air_slider : life_RscXSliderH 
		{
			idc = 2921;
			text = "";
			onSliderPosChanged = "if(!isNil 'pleaseWait') exitWith {}; pleaseWait = true; bluescale = _this select 1; life_myVehicle setObjectTexture [my_selection,format['#(rgb,8,8,3)color(%1,%2,%3,%4)',redscale,greenscale,bluescale,opacity]]; [] spawn {sleep 0.1; pleaseWait = nil}";
			tooltip = "";
			x = 0.42;
			y = 0.16 - (1 / 25);
			
			w = "9 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class Opacity_slider : life_RscXSliderH 
		{
			idc = 2931;
			text = "";
			onSliderPosChanged = "if(!isNil 'pleaseWait') exitWith {}; pleaseWait = true; opacity = _this select 1; life_myVehicle setObjectTexture [my_selection,format['#(rgb,8,8,3)color(%1,%2,%3,%4)',redscale,greenscale,bluescale,opacity]]; [] spawn {sleep 0.1; pleaseWait = nil}";
			tooltip = "";
			x = 0.42;
			y = 0.21 - (1 / 25);
			
			w = "9 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class ButtonClose : life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.32;
			y = 0.26;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		class ButtonAccept : life_RscButtonMenu {
			idc = -1;
			text = "Accept";
			onButtonClick = "if((redscale < 0.05 && bluescale < 0.05 && greenscale < 0.05) || opacity < 0.01) exitWith {systemChat 'You cannot choose a color close to black.'}; Accept_recolor = true; closeDialog 0;";
			x = 0.48;
			y = 0.26;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		class Buttonswitch : life_RscButtonMenu {
			idc = 1994;
			text = "Switch Selection";
			onButtonClick = "my_selection = my_selection + 1; if(my_selection >= numOfSelections) then {my_selection = 0}; systemChat 'Switched current section to color.'";
			x = 0.72;
			y = 0.26;
			w = (12 / 40);
			h = (1 / 25);
		};
	};
};