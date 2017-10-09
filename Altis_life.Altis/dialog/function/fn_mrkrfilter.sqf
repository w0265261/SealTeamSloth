	_indexId = _this select 1;
	_mrkrGrpsCbo = ((findDisplay 12) displayCtrl (2101));
	_size = lbSize _mrkrGrpsCbo;
	switch (_indexId) do
	{
		case 0: {
					{_x setMarkerAlphaLocal 1;}forEach allMapMarkers;					
					for "_i" from 2 to (_size-1) do
					{
						_mrkrGrpsCbo lbSetPicture[_i,"\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa"];
						_mrkrGrpsCbo lbSetValue[_i, 0];
					};
				};
		case 1: {
					{_x setMarkerAlphaLocal 0;}forEach allMapMarkers;
					for "_i" from 2 to (_size-1) do
					{
						_mrkrGrpsCbo lbSetPicture[_i,"\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa"];
						_mrkrGrpsCbo lbSetValue[_i, 1];
					};
				};
		case default 
					{					
						_class = _mrkrGrpsCbo lbData _indexId;
						_alpha = _mrkrGrpsCbo lbValue _indexId;
						switch (_alpha) do
						{
							case 0: {
										_mrkrGrpsCbo lbSetValue[_indexId,  1];
										_mrkrGrpsCbo lbSetPicture[_indexId,"\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa"]; 
									};
							case 1: {
										_mrkrGrpsCbo lbSetValue[_indexId,  0];
										_mrkrGrpsCbo lbSetPicture[_indexId,"\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa"]; 
									};
						};
						_grpTypeColors = getArray (missionConfigFile >> "CfgSTSMarkers" >> "CfgSTSMarkersGrps" >> _class >> "GrpTypeColors");
						{
							_type = getMarkerType _x;
							_color = getMarkerColor _x;
							_typeColor = [_type,_color];
							if (_typeColor in _grpTypeColors) then
							{
								_x setMarkerAlphaLocal _alpha;
							};
						}forEach allMapMarkers;
					};
};