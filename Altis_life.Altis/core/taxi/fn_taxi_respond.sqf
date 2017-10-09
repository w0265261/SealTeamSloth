_mode = param [ 0, -1];
_info = param [ 1, -1];
pricePerM = 0.2;

switch (_mode) do
{
	case 1:
	{
		if(str TaxiCallsClient != str _info) then {
			TaxiCallsClient = _info;
			systemChat "Your active taxi calls have been updated!";
		};
	};
	case 2:
	{
		_name = _info getVariable["realname",name _info];
		hint format ["Taxidriver %1 accepted your call, he is currently %2 meters away from your position.",_name,floor (player distance _info)];
		life_taxiDriver = _info;
		life_calledTaxi = true;
		taxi_ActionToLeave = player addAction ["Stop Taxi-Service", {
			life_calledTaxi = false;
			[] spawn { sleep 0.5;
			hint format ["You have stopped using the Taxi-Service, you payed $%1 for the ride.",round life_taxiTotalPrice];
			if (life_myFunds<life_taxiTotalPrice) then {life_taxiTotalPrice = life_myFunds; ["atm","set",0] call life_fnc_handlePaper} else { ["atm","take",life_taxiTotalPrice] call life_fnc_handlePaper};
			[life_taxiTotalPrice,pricePerM] remoteExec ["life_fnc_finishRide",life_taxiDriver,false];
			player removeAction taxi_ActionToLeave;
			};
		}];
		sleep 2;
		waitUntil {sleep 0.25; hintSilent format["Taxi Driver %1 is %2 meters away from your position",_name,floor(player distance _info)]; player distance _info < 20 || !life_calledTaxi};
		_oldTaxiPos = getPos player;
		life_taxiTotalPrice = 0;
		while {life_calledTaxi} do {
			hintSilent parseText format ["TAXI-METER<br/><br/><t align='left'>Distance driven</t><t align='right'>%1 meters</t><br/><t align='left'>Price</t><t align='right'>$%2</t>",floor (life_taxiTotalPrice/pricePerM),[life_taxiTotalPrice] call life_fnc_numberText];
			if ((_oldTaxiPos distance player >= 1)&&(life_taxiDriver == (driver vehicle player))) then { life_taxiTotalPrice = life_taxiTotalPrice + pricePerM; _oldTaxiPos = getPos player; };
			if(life_taxiTotalPrice >= life_myFunds) exitWith {
				hint format ["You have stopped using the Taxi-Service, you payed $%1 for the ride.",round life_taxiTotalPrice];
				life_calledTaxi = false;
				if (life_myFunds<life_taxiTotalPrice) then {life_taxiTotalPrice = life_myFunds; ["atm","set",0] call life_fnc_handlePaper} else { ["atm","take",life_taxiTotalPrice] call life_fnc_handlePaper};
				[life_taxiTotalPrice,pricePerM] remoteExec ["life_fnc_finishRide",life_taxiDriver,false];
				player removeAction taxi_ActionToLeave;
			};
		};
	};
	case 3:
	{
		hint "No taxidriver accepted your request after 30 seconds, your call got deleted from the active calls list. You can now create a new call.";
		life_calledTaxi = false;
    };
    case 4:
    {
    	hint "There are currently no Taxidrivers on duty.";
    	life_calledTaxi = false;
	};
	case 6:
	{
			life_calledTaxi = false;
			sleep 0.2;
			hint format ["The taxidriver stopped the service, you payed $%1 for it.",life_taxiTotalPrice];
			if (life_myFunds<life_taxiTotalPrice) then {life_taxiTotalPrice = life_myFunds; ["atm","set",0] call life_fnc_handlePaper} else { ["atm","take",life_taxiTotalPrice] call life_fnc_handlePaper};
			[life_taxiTotalPrice,pricePerM] remoteExec ["life_fnc_finishRide",life_taxiDriver,false];
			player removeAction taxi_ActionToLeave;
	};
};