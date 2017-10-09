class CraftingMenu {
	idd = 44000;
	movingEnable = false;
	enableSimulation = true;
	
	class ControlsBackground {
		class MasterBackground: Life_RscText
		{
			idc = -1;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.391875 * safezoneW;
			h = 0.407 * safezoneH;
			colorBackground[] = {0.098,0.098,0.098,1};
		};
		class ProgressBarBackground: Life_RscText
		{
			idc = -1;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.180469 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.533,0,0.082,1};
		};
		class Title: Life_RscText
		{
			idc = -1;
			text = "Manufacturing Menu";
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.098,0.098,0.098,1};
		};
		class PlayerInventoryLabel: Life_RscText
		{
			idc = -1;
			text = "Player Inventory";
			x = 0.309219 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.302,0.302,0.302,1};
		};
		class FactoryStorageLabel: Life_RscText
		{
			idc = -1;
			text = "Factory Storage";
			x = 0.309219 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.302,0.302,0.302,1};
		};
		class MissingPartsLabel: Life_RscText
		{
			idc = -1;
			text = "Missing Parts/Materials";
			x = 0.572187 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.486,0.306,0.204,1};
		};
		class PartListLabel: Life_RscText
		{
			idc = -1;
			text = "Parts";
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.302,0.302,0.302,1};
		};
		class MaterialListLabel: Life_RscText
		{
			idc = -1;
			text = "Materials";
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.302,0.302,0.302,1};
		};
		class HelpParts: Life_RscText
		{
			idc = -1;
			text = "?";
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.212,0.553,1,1};
			tooltip = "How many of each part is required to make the selected manufacture item.";
		};
		class HelpMaterials: Life_RscText
		{
			idc = -1;
			text = "?";
			x = 0.525781 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.212,0.553,1,1};
			tooltip = "How much of each material is required to make one of the selected part.";
		};
	};
	class Controls {
		class PlayerInventoryList: Life_RscListBox
		{
			idc = 44001;
			x = 0.309219 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.165 * safezoneH;
			colorBackground[] = {0.498,0.498,0.498,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorSelectBackground[] = {0,0,0,0};
			colorSelectBackground2[] = {0,0,0,0};
			sizeEx = .03;
		};
		class FactoryStorageList: Life_RscListBox
		{
			idc = 44002;
			x = 0.309219 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.165 * safezoneH;
			colorBackground[] = {0.498,0.498,0.498,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorSelectBackground[] = {0,0,0,0};
			colorSelectBackground2[] = {0,0,0,0};
			sizeEx = .03;
		};
		class ProgressBar: Life_RscProgress
		{
			idc = 44003;
			colorFrame[] = {0.533,0,0.082,1};
			colorBar[] = {1,0,0,1};
			texture = "#(argb,8,8,3)color(1,0,0,1)";
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.180469 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class TerminalItemsList: Life_RscCombo
		{
			idc = 44004;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.180469 * safezoneW;
			h = 0.033 * safezoneH;
			colorText[] = {0,0,0,1};
			colorBackground[] = {1,1,1,1};
			onLBSelChanged = "call life_fnc_termItemSelectedEvent;";
		};
		class MissingPartsList: Life_RscListBox
		{
			idc = 44005;
			x = 0.572187 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.275 * safezoneH;
			colorBackground[] = {0.725,0.478,0.341,1};
			colorSelect[] = {1, 1, 1, 1};
			colorSelect2[] = {1, 1, 1, 1};
			colorSelectBackground[] = {0,0,0,0};
			colorSelectBackground2[] = {0,0,0,0};
			sizeEx = 0.03;
		};
		class ManufactureButton: Life_RscButton
		{
			idc = 44006;
			text = "Manufacture";
			x = 0.572187 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.066 * safezoneH;
			colorBackground[] = {0.133,0.694,0.298,1};
			onButtonClick = "call life_fnc_manufactureItem";
			tooltip = "Manufacture the selected item.";
		};
		class ProgressBarPercent: Life_RscText
		{
			idc = 44007;
			text = "";
			x = 0.54125 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class PartList: Life_RscListbox
		{
			idc = 44008;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.275 * safezoneH;
			colorText[] = {1, 1, 1,	1};
			colorSelect[] = {0, 0, 0, 1};
			colorSelect2[] = { 0, 0, 0, 1};
			colorSelectBackground[] = {0.95, 0.95, 0.95, 1};
			colorSelectBackground2[] = {1, 1, 1, 0.5};
			colorBackground[] = {0, 0, 0, 0.3};
			onLBSelChanged = "call life_fnc_partSelectedEvent;";
			sizeEx = 0.03;
		};
		class MaterialList: Life_RscListbox
		{
			idc = 44009;
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.198 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.3};
			colorText[] = {1, 1, 1,	1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorSelectBackground[] = {0,0,0,0};
			colorSelectBackground2[] = {0,0,0,0};
			sizeEx = 0.03;
		};
		class CraftButton: Life_RscButton
		{
			idc = 44010;
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.066 * safezoneH;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.764,0.764,0.764,1};
			text = "Make";
			onButtonClick = "[false] call life_fnc_makePart";
			shadow = 0;
			tooltip = "Make the selected part.";
		};
		class Craft2Button: Life_RscButton
		{
			idc = 44011;
			x = 0.525781 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.066 * safezoneH;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.764,0.764,0.764,1};
			text = "Make x2";
			onButtonClick = "[true] call life_fnc_makePart";
			shadow = 0;
			tooltip = "Make the selected part twice.";
		};
		class CloseDialog: Life_RscButton
		{
			idc = 44012;
			text = "Close";
			x = 0.659844 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.022 * safezoneH;
			onButtonClick = "closeDialog 44000";
			colorBackground[] = {1,0,0,1};
			colorShadow[] = {0,0,0,0};
			shadow = 0;
		};

	};
};