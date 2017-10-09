class CfgSTSMarkersGrps
{
	class mrkrGrpPlrsCiv
	{
		displayName = "Player";
		GrpTypeColors[] = {{"Mil_arrow","ColorGreen"},{"Mil_arrow2","ColorGreen"}};
		side = 3;
	};
	class mrkrGrpPlrsCop
	{
		displayName = "Player";
		GrpTypeColors[] = {{"Mil_arrow","ColorBlue"},{"Mil_arrow2","ColorBlue"},{"Mil_arrow","ColorGreen"},{"Mil_arrow2","ColorGreen"},{"waypoint","ColorGreen"}};
		side = 1;
	};
	class mrkrGrpPlrsMedic
	{
		displayName = "Player";
		GrpTypeColors[] = {{"Mil_arrow","ColorRed"},{"Mil_arrow2","ColorRed"},{"Mil_arrow","ColorGreen"},{"Mil_arrow2","ColorGreen"},{"waypoint","ColorGreen"},
		{"waypoint","ColorOrange"}};
		side = 2;
	};
	class mrkrGrpGathering
	{
		displayName = "Gathering";
		GrpTypeColors[] = {{"mil_dot","ColorGreen"},{"mil_dot","ColorRed"},{"Empty","ColorWhite"},{"Empty","ColorKhaki"}};
		side = -1;
	};
	
	class mrkrGrpProcessing
	{
		displayName = "Processing";
		GrpTypeColors[] = {{"mil_box","ColorOrange"},{"mil_box","ColorRed"},{"loc_Stack","ColorGreen"}};
		side = -1;
	};
	
	class mrkrGrpMaterialTraders
	{
		displayName =  "Material Traders";
		GrpTypeColors[] = {{"mil_triangle","ColorCIV"},{"mil_triangle","ColorRed"},{"MinefieldAP","ColorRed"}};
		side = -1;
	};
	
	class mrkrGrpVeh
	{
		displayName =  "Vehicle Shops";
		GrpTypeColors[] = {{"c_ship","ColorBlue"},{"c_air","ColorOrange"},{"c_air","ColorRed"},{"c_car","ColorCIV"},{"c_car","ColorYellow"},{"c_car","ColorRed"}};
		side = -1;	
	};
	class mrkrGrpVehService
	{
		displayName = "Vehicle Service";
		GrpTypeColors[] = {{"loc_Fuelstation","ColorYellow"},{"respawn_air","ColorYellow"},{"o_service","Default"}};
		side = -1;
	};
	class mrkrGrpStores
	{
		displayName = "Stores";
		GrpTypeColors[] = {{"c_unknown","ColorUNKNOWN"},{"c_unknown","ColorCIV"},{"c_unknown","ColorBlue"},{"c_unknown","ColorGreen"},{"b_support","ColorGreen"},
		{"b_inf","ColorRed"},{"b_mech_inf","ColorRed"},{"o_hq","ColorRed"},{"loc_Lighthouse","ColorGreen"}};
		side = -1;
	};
	class mrkrGrpDelivery
	{
		displayName = "Delivery Points";
		GrpTypeColors[] = {{"mil_start","ColorYellow"},{"mil_box","ColorYellow"}};
		side = -1;
	};
	
	class mrkrGrpRecreation
	{
		displayName = "Recreation";
		GrpTypeColors[] = {{"c_plane","ColorCIV"},{"b_naval","ColorWhite"},{"o_armor","ColorBrown"},{"loc_Transmitter","ColorYellow"},{"mil_flag","ColorBlue"},
		{"mil_dot","ColorYellow"}};
		side = -1;
	};
	class mrkrGrpsGovernment
	{
		displayName =  "Government";
		GrpTypeColors[] = {{"n_inf","Color4_FD_F"},{"loc_Tourism","ColorRed"},{"flag_Altis","Default"},{"loc_Ruin","ColorGreen"}};
		side = -1;
	};
	class mrkrGrpsATM
	{
		displayName =  "ATM";
		GrpTypeColors[] = {{"loc_Tourism","ColorGreen"}};
		side = -1;
	};
	class mrkrGrpsPolice
	{
		displayName =  "Police";
		GrpTypeColors[] = {{"mil_triangle","ColorWEST"},{"mil_box","ColorWEST"},{"b_hq","ColorWEST"},{"mil_circle","ColorWEST"},{"u_installation","ColorBlue"},
		{"o_naval","ColorWEST"},{"c_car","ColorWEST"},{"Empty","ColorWEST"},{"waypoint","Default"}};
		side = -1;
	};
	class mrkrGrpsMedical
	{
		displayName =  "Medical";
		GrpTypeColors[] = {{"loc_Hospital","ColorRed"},{"b_uav","ColorRed"},{"n_air","ColorRed"}};
		side = -1;
	};
		class mrkrGrpsGangs
	{
		displayName =  "Gang Areas";
		GrpTypeColors[] = {{"hd_flag","ColorRed"},{"hd_warning","ColorRed"}};
		side = -1;
	};
};