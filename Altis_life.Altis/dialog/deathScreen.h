class STS_DeathScreen
{
	idd = 7300;
	name = "Life_Death_Screen";
	movingEnabled = false;
	enableSimulation = true;
	
	class controlsBackground
	{
	};
	
	class Controls
	{
		class MedicsOnline : Life_RscText
		{
			idc = 7304;
			colorBackground[] = {0,0,0,0};
			text = "Medics Online: 1";
			x = 0.000874975 * safezoneW + safezoneX;
			y = 0.0556 * safezoneH + safezoneY;
			w = 0.8;
			h = (1 / 25);
		};
		
		class NearestMed : Life_RscText
		{
			idc = 7307;
			colorBackground[] = {0,0,0,0};
			text = "Nearest medic: 1000m";
			x = 0.000874975 * safezoneW + safezoneX;
			y = 0.0976 * safezoneH + safezoneY;
			w = 0.8;
			h = (1 / 25);
		};
		
		class RespawnBtn : Life_RscButtonMenu
		{
			idc = 7302;
			x = 0.9 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = (9 / 40);
			h = (1 / 25);
			text = "Suicide";
			onButtonClick = "[] spawn life_fnc_confirmSuicide;";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			class Attributes 
			{
				align = "center";
			};
		};
		
		class AdminBtn : Life_RscButtonMenu
		{
			idc = 7306;
			x = 0.000874975 * safezoneW + safezoneX;
			y = 0.0336 * safezoneH + safezoneY;
			w = (9 / 40);
			h = (1 / 25);
			text = "Revive Self";
			onButtonClick = "[] spawn { _action = ['Are you sure you wish to revive yourself with administrative abilities?','Confirm Self Revive','yes','no'] call BIS_fnc_guiMessage; if(_action) then {[player,true] call life_fnc_adminReviveAction}}";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			class Attributes 
			{
				align = "center";
			};
		};
		
		class MedicBtn : Life_RscButtonMenu
		{
			idc = 7303;
			x = 0.9 * safezoneW + safezoneX;
			y = 0.0292 * safezoneH + safezoneY;
			w = (9 / 40);
			h = (1 / 25);
			onButtonClick = "[] call life_fnc_requestMedic;";
			text = "Request Medic";
			colorBackground[] = {0,0.2235294117647059,0.3725490196078431,1};
			class Attributes 
			{
				align = "center";
			};
		};
		
		class respawnTime : Life_RscText
		{
			idc = 7301;
			colorBackground[] = {0,0,0,0};
			text = "";
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.918 * safezoneH + safezoneY;
			w = 0.8;
			h = (1 / 25);
		};
	};
};