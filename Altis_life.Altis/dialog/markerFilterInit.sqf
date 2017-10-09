disableSerialization;
_map = findDisplay 12;
_map ctrlCreate ["RscPicture", 2102];
_background = ((findDisplay 12) displayCtrl (2102));
_picposX = 0.019 * safezoneW + safezoneX;
_picposY = 0.499 * safezoneH + safezoneY;
_picwidth = 0.135 * safezoneW;
_picheight = 0.218 * safezoneH;
_background ctrlSetPosition [_picposX, _picposY, _picwidth, _picheight];
_background ctrlCommit 0;
_background ctrlSetText "icons\mrkrUIBack.jpg";

_map ctrlCreate ["RscListBox", 2101];
_mrkrGrpsCbo = ((findDisplay 12) displayCtrl (2101));
_lbposX = 0.025 * safezoneW + safezoneX;
_lbposY = 0.5075 * safezoneH + safezoneY;
_lbwidth = 0.125 * safezoneW;
_lbheight = 0.2 * safezoneH;
_mrkrGrpsCbo ctrlSetPosition [_lbposX,_lbposY,_lbwidth, _lbheight];
_mrkrGrpsCbo ctrlSetBackgroundColor [0, 0, 0, 0];
_mrkrGrpsCbo ctrlCommit 0;
_mrkrGrpsCbo lbAdd "SHOW ALL";
_mrkrGrpsCbo lbAdd "SHOW NONE";
	_count =  count (MissionConfigFile >> "CfgSTSMarkers" >> "CfgSTSMarkersGrps");
	_plrClass = typeOf player;
	_plrSide = getNumber (configFile >> "cfgVehicles" >> _plrClass >> "side");
	for "_x" from 0 to (_count-1) do
	{

		_mrkrGrp = ((missionConfigFile >> "CfgSTSMarkers" >> "CfgSTSMarkersGrps") select _x);
		_grpSide = getNumber (_mrkrGrp >> "Side");
		if ((_grpSide < 0) || (_grpSide == _plrSide)) then
		{
		_index = _mrkrGrpsCbo lbAdd (getText (_mrkrGrp >> "displayName"));
		_class = configName _mrkrGrp;
		_mrkrGrpsCbo lbSetData[(lbSize _mrkrGrpsCbo)-1,  _class];
		_mrkrGrpsCbo lbSetPicture[(lbSize _mrkrGrpsCbo)-1,"\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa"];
		_mrkrGrpsCbo lbSetValue[(lbSize _mrkrGrpsCbo)-1,  0];
		};
	};	
_mrkrGrpsCbo ctrlSetEventHandler ["LBSelChanged","_this call life_fnc_mrkrfilter"];