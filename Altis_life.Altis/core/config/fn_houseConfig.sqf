/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master config file for buyable houses?
*/
private["_house"];
_house = param [0,"",[""]];
if(_house == "") exitWith {[]};

/*
	Return Format:
	[price,# of containers allowed]
*/
switch (true) do {
	case (_house in ["Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F"]): {[100000,4]};
	case (_house in ["Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F"]): {[90000,3]};
	case (_house in ["Land_i_Stone_HouseSmall_V1_F","Land_i_Stone_HouseSmall_V2_F","Land_i_Stone_HouseSmall_V3_F"]): {[80000,3]};
	case (_house in ["Land_i_Shed_Ind_F"]): {[250000,4]};
	case (_house in ["Land_i_House_Small_01_V1_F","Land_i_House_Small_01_V2_F","Land_i_House_Small_01_V3_F","Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F"]): {[60000,2]};
	case (_house in ["Land_i_House_Small_03_V1_F"]): {[70000,3]};
	case (_house in ["Land_i_Garage_V1_F","Land_i_Garage_V2_F"]): {[40000,0]};
	case (_house in ["Land_i_Shed_Ind_F"]): {[250000,4]};
	case (_house in ["Land_i_Addon_02_V1_F"]): {[30000,1]};
	case (_house in ["Land_Slum_House01_F","Land_Slum_House02_F"]): {[20000,0]};
	case (_house in ["Land_i_Stone_Shed_V1_F","Land_i_Stone_Shed_V2_F","Land_i_Stone_Shed_V3_F"]): {[40000,1]};
	//case (_house in ["Land_Kiosk_blueking_F","Land_Kiosk_gyros_F","Land_Kiosk_papers_F","Land_Kiosk_redburger_F"]): {[40000,0]};
	default {[]};
};