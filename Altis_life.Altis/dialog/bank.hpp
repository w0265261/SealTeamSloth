class STS_Life_atm_management 
{
	idd = 2700;
	name= "life_atm_menu";
	movingEnable = false;
	enableSimulation = true;
	onLoad= "_this select 0 displayCtrl 0 ctrlEnable false";
	
	controlsBackground[]=
	{

	};
	controls[]=
	{
		RscAtmScreen,
		CashTitle,
		CloseButtonKey,
		Title,
		WithdrawButton,
		DepositButton,
		DepositThingie,
		moneyEdit,
		PlayerList,
		TransferButton,
		GangDeposit,
		CloseButtonKey,
		AtmTextLineOne,
		AtmTextLineTwo,
		AtmTextLineThree
	};
	objects[]=
	{
		RscModelDisplay
	};
	
	class RscModelDisplay: Life_RscObject
{
		idc = 0;
		model = "\A3\Structures_F_EPC\Civ\Accessories\Atm_01_F.p3d";
		scale = 1.56 * safezoneW;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.55 * safezoneH + safezoneY;
		z = 2;
		w = 1 * safezoneW;
		h = 1 * safezoneH;	
		
		direction[] = {0,0,1};
		up[] = {0,1,0};
		tooltip = "";
		tooltipColorShade[] = {0,0,0,1};
		tooltipColorText[] = {1,1,1,1};
		tooltipColorBox[] = {1,1,1,1};
		onMouseMoving = "";
		onMouseHolding = "";
		onMouseDown = "";
};
class RscAtmScreen: life_RscPicture
{
	idc = -1;
	colorBackground[] = {0,0,0,1};
	sizeEx = 0.5 * safezoneW;
	text = "icons\slothbank.paa";
	x = 0 * safezoneW + safezoneX;
	y = 0.0475 * safezoneH + safezoneY;
	w = 0.515 * safezoneW;
	h = 0.92 * safezoneH;	
};
	class CashTitle : Life_RscStructuredText
	{
		idc = 2701;
		text = "";
		colorBackground[] = {1, 1, 1, 0};
		size = 0.02 * safezoneW;
		x = 0.135 * safezoneW + safezoneX;
		y = 0.36 * safezoneH + safezoneY;
		w = 0.265 * safezoneW;
		h = 0.05 * safezoneH;	
	};
	
	class Title : Life_RscTitle {
		colorBackground[] = {1, 1, 1, 0};
		idc = -1;
		text = "$STR_ATM_Title";
		sizeEx = 0.02 * safezoneW;
		x = 0.19 * safezoneW + safezoneX;
		y = 0.325 * safezoneH + safezoneY;
		w = 0.1575 * safezoneW;
		h = 0.03 * safezoneH;	
	};
	
	class WithdrawButton : life_RscButtonMenu 
	{
		idc = -1;
		text = "";
		colorBackground[] = {0, 0, 0, 0};
		colorBackgroundFocused[] = {0,0,0,0};
		colorBackground2[] = {0,0,0,0};
		onButtonClick = "[] call life_fnc_bankWithdraw";
		x = 0.085 * safezoneW + safezoneX;
		y = 0.47 * safezoneH + safezoneY;
		w = 0.035 * safezoneW;
		h = 0.04 * safezoneH;
	};
	
	class DepositButton : life_RscButtonMenu 
	{
		idc = -1;
		text = "";
		colorBackground[] = {0, 0, 0, 0};
		colorBackgroundFocused[] = {0,0,0,0};
		colorBackground2[] = {0,0,0,0};
		onButtonClick = "[0] call life_fnc_bankDeposit";
		x = 0.085 * safezoneW + safezoneX;
		y = 0.5275 * safezoneH + safezoneY;
		w = 0.035 * safezoneW;
		h = 0.04 * safezoneH;
	};
	
	class DepositThingie : life_RscButtonMenu 
	{
		idc = -1;
		text = "";
		colorBackground[] = {0, 0, 0, 0};
		colorBackgroundFocused[] = {0,0,0,0};
		colorBackground2[] = {0,0,0,0};
		onButtonClick = "[1] call life_fnc_bankDeposit";
		x = 0.0825 * safezoneW + safezoneX;
		y = 0.585 * safezoneH + safezoneY;
		w = 0.035 * safezoneW;
		h = 0.04 * safezoneH;
	};
	
	class moneyEdit : Life_RscEdit 
	{
	
	idc = 2702;
	
	text = "Amount";
	sizeEx = 0.035;
	colorSelection[] = {1,1,1,0.25};
	colorBackground[] = {0, 0, 0, 0.25};
		x = 0.14 * safezoneW + safezoneX;
		y = 0.425 * safezoneH + safezoneY;
		w = 0.115 * safezoneW;
		h = 0.035 * safezoneH;	
	
	};
	
	class PlayerList : Life_RscCombo 
	{
		idc = 2703;
		colorBackground[] = {0, 0, 0, 1};
		x = 0.27 * safezoneW + safezoneX;
		y = 0.425 * safezoneH + safezoneY;
		w = 0.124 * safezoneW;
		h = 0.035 * safezoneH;
	};
	
	class TransferButton : life_RscButtonMenu 
	{
		idc = -1;
		text = "";
		colorBackground[] = {0, 0, 0, 0};
		colorBackgroundFocused[] = {0,0,0,0};
		colorBackground2[] = {0,0,0,0};
		onButtonClick = "[] call life_fnc_bankTransfer";
		x = 0.4075 * safezoneW + safezoneX;
		y = 0.47 * safezoneH + safezoneY;
		w = 0.035 * safezoneW;
		h = 0.04 * safezoneH;
	};
	
	class GangDeposit : TransferButton
	{
		idc = 2705;
		text = "";
		colorBackground[] = {0, 0, 0, 0};
		colorBackgroundFocused[] = {0,0,0,0};
		colorBackground2[] = {0,0,0,0};
		onButtonClick = "[] spawn life_fnc_gangDeposit";
		x = 0.4075 * safezoneW + safezoneX;
		y = 0.5275 * safezoneH + safezoneY;
		w = 0.035 * safezoneW;
		h = 0.04 * safezoneH;
	};
	
	class CloseButtonKey : Life_RscButtonMenu 
	{
		idc = -1;
		text = "";
		onButtonClick = "closeDialog 0;";
		colorBackground[] = {0, 0, 0, 0};
		colorBackgroundFocused[] = {0,0,0,0};
		colorBackground2[] = {0,0,0,0};
		x = 0.4075 * safezoneW + safezoneX;
		y = 0.586 * safezoneH + safezoneY;
		w = 0.035 * safezoneW;
		h = 0.04 * safezoneH;
	};
		class AtmTextLineOne : Life_RscStructuredText
	{
		idc = -1;
		text = "<t align='left'>----------------Withdraw</t><t align='right'>Transfer---------------------</t>";
		colorBackground[] = {0,0,0,0};
		size = 0.02 * safezoneW;
		x = 0.134 * safezoneW + safezoneX;
		y = 0.48 * safezoneH + safezoneY;
		w = 0.266 * safezoneW;
		h = 0.03 * safezoneH;	
	};
		class AtmTextLineTwo : Life_RscStructuredText
	{
		idc = -1;
		text = "<t align='left'>---------------------Deposit</t><t align='right'>Gang Bank-----------------</t>";
		colorBackground[] = {0, 0, 0, 0};
		size = 0.02 * safezoneW;
		x = 0.13 * safezoneW + safezoneX;
		y = 0.5375 * safezoneH + safezoneY;
		w = 0.27 * safezoneW;
		h = 0.03 * safezoneH;	
	};
		class AtmTextLineThree : Life_RscStructuredText
	{
		idc = -1;
		text = "<t align='left'>----------------Deposit All</t><t align='right'>Close-------------------------</t>";
		colorBackground[] = {0,0,0,0};
		size = 0.02 * safezoneW;
		x = 0.128 * safezoneW + safezoneX;
		y = 0.595 * safezoneH + safezoneY;
		w = 0.271 * safezoneW;
		h = 0.05 * safezoneH;	
	};
};
