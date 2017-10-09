class STS_life_spawn_selection {
    idd = 38500;
    movingEnable = 0;
    enableSimulation = 1;

    class controlsBackground {
        

        class MapView : Life_RscMapControl {
            idc = 38502;
            x = 0.288594 * safezoneW + safezoneX;
            y = 0.324 * safezoneH + safezoneY;
            w = 0.422812 * safezoneW;
            h = 0.495 * safezoneH;
            maxSatelliteAlpha = 0.75;//0.75;
            alphaFadeStartScale = 1.15;//0.15;
            alphaFadeEndScale = 1.29;//0.29;
        };

        class MainBackground: Life_RscPicture{            
            idc = -1;
           // text = "textures\milpadframex2W.paa";
            text = "";
            x = 0.2525 * safezoneW + safezoneX;
            y = 0.258 * safezoneH + safezoneY; 
            w = 0.495 * safezoneW;
            h = 0.627 * safezoneH;
            colorText[] = {0.157,0.157,0.157,0.8};
            colorBackground[] = {0.157,0.157,0.157,0.8};
            colorActive[] = {0.157,0.157,0.157,0.8};
        };         

        class PhoneBackground: Life_RscPicture{            
            idc = -1;
           // text = "textures\milphonex2W.paa";
            text = "";
            x = 0.768125 * safezoneW + safezoneX;
            y = 0.181 * safezoneH + safezoneY;
            w = 0.185625 * safezoneW;
            h = 0.594 * safezoneH;
            colorText[] = {0.157,0.157,0.157,0.8};
            colorBackground[] = {0.157,0.157,0.157,0.8};
            colorActive[] = {0.157,0.157,0.157,0.8};
        };     

        class HeaderBackground: Life_RscPicture{         
            idc = -1;
            text = "textures\spawn_header.paa";
            x = 0.257656 * safezoneW + safezoneX;
            y = 0.049 * safezoneH + safezoneY;
            w = 0.484688 * safezoneW;
            h = 0.187 * safezoneH;
        };  

        class life_RscTitleBackground: Life_RscText    {
            //colorBackground[] = {0.561,0.067,0.29,1};
            colorBackground[] = {0.835,0.514,0.094,1};
            idc = -1;
            x = 0.298906 * safezoneW + safezoneX;
            y = 0.764 * safezoneH + safezoneY;
            w = 0.402187 * safezoneW;
            h = 0.033 * safezoneH;
        };

        class Title: Life_RscTitle {
            colorBackground[] = {0,0,0,0};
            idc = -1;
            text = "$STR_Spawn_Title";
            x = 0.298906 * safezoneW + safezoneX;
            y = 0.764 * safezoneH + safezoneY;
            w = 0.402187 * safezoneW;
            h = 0.033 * safezoneH;
        };

        class SpawnPointTitle: Title {
            idc = 38501;
            style = 1;
            text = "";
        };
    };

    class controls {
        
        class SpawnPointList: Life_RscListNBox {
            idc = 38510;
            text = "";
            sizeEx = 0.041;
            coloumns[] = {0,0,0.9};
            drawSideArrows = 0;
            idcLeft = -1;
            idcRight = -1;
            rowHeight = 0.050;
            x = 0.785656 * safezoneW + safezoneX;
            y = 0.324 * safezoneH + safezoneY;
            w = 0.154687 * safezoneW;
            h = 0.33 * safezoneH;
            onLBSelChanged = "_this call life_fnc_spawnPointSelected;";
        };        

        class spawnButton: Life_RscButtonMenu { 
            idc = -1;
            //colorBackground[] = {0.561,0.067,0.29,1};
            colorBackground[] = {0.835,0.514,0.094,1};
            style = ST_CENTER;
            text = "$STR_Spawn_Spawn";
            onButtonClick = "[] call life_fnc_spawnConfirm";
            x = 0.78494 * safezoneW + safezoneX;
            y = 0.6628 * safezoneH + safezoneY;
            w = 0.154687 * safezoneW;
            h = 0.033 * safezoneH;
        }; 
    };
};