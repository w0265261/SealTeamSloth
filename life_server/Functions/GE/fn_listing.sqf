/*
fn_listing.sqf
Kevin Webb
Sets up our listing in the database...
*/
_mode = param [0,0,[0]];
switch(_mode) do {
	case 0: {
		//vehicle listing
		_vid = param [1,0,[0]];
		_price = param [2,0,[0]];
		_className = param [3,"",[""]];
		_player = param [4,ObjNull,[ObjNull]];
		_uid = getPlayerUID _player;
		//Check for existing buy offer
		_query = format["SELECT ID, Price, pid FROM exchange WHERE ClassName='%1' AND Price>='%2' AND BuyorSell=1 AND active=1",str _className,_price];
		_result = [_query,2,true] call DB_fnc_asyncCall;
		if(count _result == 0) exitWith {
		["life_offers",1] remoteExec ["life_fnc_netSetVar",_player];
		_query = format["UPDATE vehicles SET listed=1 WHERE id='%1'",_vid];
		[_query,1] call DB_fnc_asyncCall;
		_query = format["INSERT INTO exchange (ClassName, Price, isVehicle, pid, BuyorSell, VehicleID) VALUES ('%1', '%2', '1', '%3', '0', '%4')",str _className,_price,_uid,_vid];
		[_query,1] call DB_fnc_asyncCall;
		};
		_result = _result select 0;
		_id = _result select 0;
		_price2 = _result select 1;
		_buyerid = _result select 2;
		//handle cash - our seller should still be online.
		["atm","add",_price2] remoteExec ["life_fnc_handlePaper",_player];
		_query = format["UPDATE exchange SET active=0 WHERE ID=%1",_id];
		[_query,1] call DB_fnc_asyncCall;
		_query = format["UPDATE vehicles SET pid='%1' WHERE id='%2'",_buyerid,_vid];
		[_query,1] call DB_fnc_asyncCall;
		[1,"Congratulations, the offer you just posted was instantly met with a buyer! Your bank balance has been updated."] remoteExec ["life_fnc_broadcast",_player];
		_buyer = ObjNull;
		{if(getPlayerUID _x == _buyerid) exitWith {_buyer = _x};} forEach playableUnits;
		if(!isNull _buyer) exitWith {
			[1,"The vehicle you were attempting to buy on the Altis Exchange has been added to your garage!"] remoteExec ["life_fnc_broadcast",_buyer];
		};
	};
	case 1: {
		//weapon listing
		_weapon = param [1,[],[[]]];
		_search = _weapon select 0;
		_price = param [2,0,[0]];
		_player = param [3,ObjNull,[ObjNull]];
		_uid = getPlayerUID _player;
		//Check for existing buy offer
		_query = format["SELECT ID, Price, pid FROM exchange WHERE ClassName LIKE '%2%1%2' AND Price>='%3' AND BuyorSell=1 AND active=1",_search,"%",_price];
		_result = [_query,2,true] call DB_fnc_asyncCall;
		if(count _result == 0) exitWith {
			_query = format["SELECT ID, Amount FROM exchange WHERE ClassName='%1' AND Price=%2 AND BuyorSell=0 AND active=1 AND pid='%3'",_weapon,_price,_uid];
			_result = [_query,2,true] call DB_fnc_asyncCall;
			if(count _result == 0) exitWith {
				["life_offers",1] remoteExec ["life_fnc_netSetVar",_player];
				_query = format["INSERT INTO exchange (ClassName, Price, isWeapon, pid, BuyorSell) VALUES ('%1', '%2', '1', '%3', '0')",_weapon,_price,_uid];
				[_query,1] call DB_fnc_asyncCall;
			};
			_result = _result select 0;
			_id = _result select 0;
			_number = _result select 1;
			_query = format["UPDATE exchange SET amount=amount+1 WHERE ID=%1",_id];
			[_query,1] call DB_fnc_asyncCall;
		};
		_result = _result select 0; //gotta remember that this is a multi-array return format
		_id = _result select 0;
		_price2 = _result select 1;
		_buyerid = _result select 2;
		//handle cash - our seller should still be online.
		["atm","add",(round(_price * 0.05)) + _price2] remoteExec ["life_fnc_handlePaper",_player];
		_query = format["UPDATE exchange SET active=0 WHERE ID=%1",_id];
		[_query,1] call DB_fnc_asyncCall;
		_query = format["SELECT mailbox FROM players WHERE playerid='%1'",_buyerid];
		_box = [_query,2] call DB_fnc_asyncCall;
		_box = _box select 0;
		_weapon pushBack (floor(random 10000));
		_box pushBack _weapon;
		_query = format["UPDATE players SET mailbox='%1' WHERE playerid='%2'",_box,_buyerid];
		[_query,1] call DB_fnc_asyncCall;
		[1,"Congratulations, the offer you just posted was instantly met with a buyer! Your bank balance has been updated."] remoteExec ["life_fnc_broadcast",_player];
		//Is our buyer online? unlikely, but possible.
		_buyer = ObjNull;
		{if(getPlayerUID _x == _buyerid) exitWith {_buyer = _x};} forEach playableUnits;
		if(!isNull _buyer) exitWith {
			[1,"One of your Altis Exchange buy offers has been met with a seller! Your weapon will be in your GE mailbox."] remoteExec ["life_fnc_broadcast",_buyer];
			["life_mailbox",_weapon,nil,true] remoteExec ["life_fnc_netSetVar",_buyer];
		};
	};
	case 2: {
		//resource listing
		_item = param [1,"",[""]];
		_price = param [2,0,[0]];
		_amount = param [3,0,[0]];
		_player = param [4,ObjNull,[Objnull]];
		_uid = getPlayerUID _player;
		//Check for existing buy offer
		_query = format["SELECT ID, Price, pid, Amount FROM exchange WHERE ClassName='%1' AND Price>='%2' AND BuyorSell=1 AND active=1",str _item,_price];
		_result = [_query,2,true] call DB_fnc_asyncCall;
		if(count _result == 0) exitWith {
			//check for existing sell offer
			_query = format["SELECT ID, Amount FROM exchange WHERE ClassName='%1' AND Price='%2' AND BuyorSell=0 AND active=1 AND pid='%3'",str _item,_price,_uid];
			_result = [_query,2,true] call DB_fnc_asyncCall;
			if(count _result == 0) exitWith {
				["life_offers",1] remoteExec ["life_fnc_netSetVar",_player];
				_query = format["INSERT INTO exchange (ClassName, Price, isVirtual, Amount, pid, BuyorSell) VALUES ('%1', '%2', '1', '%3', '%4', '0')",str _item,_price,_amount,_uid];
				[_query,1] call DB_fnc_asyncCall;
			};
			_result = _result select 0;
			_id = _result select 0;
			_number = _result select 1;
			if(_number + _amount > 100) exitWith {
				_var = [_item,1] call life_fnc_varHandle;
				[true,_var,_amount] remoteExec ["life_fnc_handleInv",_player];
				[1,"You have exceeded the maximum amount of 100 units for this offer and have had your product returned to you"] remoteExec ["life_fnc_broadcast",_player];
			};
			_query = format["UPDATE exchange SET amount=amount+%1 WHERE ID=%2",_amount,_id];
			[_query,1] call DB_fnc_asyncCall;
		};
		_done = false;
		{
			_offer = _x; //loop until my amount is exhausted, this should be fun.
			_id = _offer select 0;
			_price2 = _offer select 1;
			_buyerid = _offer select 2;
			_amountRequested = _offer select 3;
			_query = format["SELECT mailbox FROM players WHERE playerid='%1'",_buyerid];
			_box = [_query,2] call DB_fnc_asyncCall;
			_box = _box select 0;
			_buyer = ObjNull;
			{if(getPlayerUID _x == _buyerid) exitWith {_buyer = _x};} forEach playableUnits;
			if(_amountRequested >= _amount) exitWith {
				_amountRequested = _amountRequested - _amount;
				if(_amountRequested != 0) then {
					_query = format["UPDATE exchange SET amount='%1' WHERE ID='%2'",_amountRequested,_id];
					[_query,1] call DB_fnc_asyncCall;
				} else {
					_query = format["UPDATE exchange SET active=0 WHERE ID=%1",_id];
					[_query,1] call DB_fnc_asyncCall;
				};
				["atm","add",round((_price * 0.05) * _amount) + (_price2 * _amount)] remoteExec ["life_fnc_handlePaper",_player];
				_checkForExisting = false;
				{if(_item == (_x select 0)) exitWith{_checkForExisting = true; _box set[_forEachIndex,[_x select 0,(_x select 1) + _amount,(floor(random 10000))]]};} foreach _box;
				if(!_checkForExisting) then {
					_box pushBack [_item,_amount,(floor(random 10000))];
				};
				_query = format["UPDATE players SET mailbox='%1' WHERE playerid='%2'",_box,_buyerid];
				[_query,1] call DB_fnc_asyncCall;
				//Is our buyer online? unlikely, but possible.
				if(!isNull _buyer) then {
					_arr = [_item,_amount,floor(random 10000)];
					[1,"One of your Altis Exchange buy offers has been met with a seller! Your resources will be in your GE mailbox."] remoteExec ["life_fnc_broadcast",_buyer];
					["life_mailbox",_arr,nil,true,true] remoteExec ["life_fnc_netSetVar",_buyer]; //Have to update the mailbox in real time. Thankfully we have netSetVar at our disposal
				};
				_done = true;
				[1,"Congratulations, the resources you were attempting to sell have sold! Your bank balance has been updated."] remoteExec ["life_fnc_broadcast",_player];
			};
			["atm","add",round((_price * 0.05) * _amountRequested) + (_price2 * _amountRequested)] remoteExec ["life_fnc_handlePaper",_player];
			if(!isNull _buyer) then {
				[1,"You have received a partial sale of the resources you have requested in the Altis Exchange. Your resources will be in your GE mailbox."] remoteExec ["life_fnc_broadcast",_buyer];
				_arr = [_item,_amountRequested,floor(random 10000)];
				["life_mailbox",_arr,nil,true,true] remoteExec ["life_fnc_netSetVar",_buyer]; //Have to update the mailbox in real time. Thankfully we have netSetVar at our disposal
			};
			_checkForExisting = false;
			{if(_item == (_x select 0)) exitWith{_checkForExisting = true; _box set[_forEachIndex,[_x select 0,(_x select 1) + _amountRequested,(floor(random 10000))]]};} foreach _box;
			if(!_checkForExisting) then {
				_box pushBack [_item,_amountRequested,(floor(random 10000))];
			};
			_query = format["UPDATE exchange SET active=0 WHERE ID=%1",_id];
			[_query,1] call DB_fnc_asyncCall;
			_query = format["UPDATE players SET mailbox='%1' WHERE playerid='%2'",_box,_buyerid];
			[_query,1] call DB_fnc_asyncCall;
			_amount = _amount - _amountRequested;
		} forEach _result;
		if(!_done) then {
			_query = format["INSERT INTO exchange (ClassName, Price, isVirtual, Amount, pid, BuyorSell) VALUES ('%1', '%2', '1', '%3', '%4', '0')",str _item,_price,_amount,_uid];
			[_query,1] call DB_fnc_asyncCall;
		};
	};
	case 3: {
		//removing a listing
		_id = param [1,0,[0]];
		_className = _this select 2;
		_type = param [3,"",[""]];
		_player = param [4,ObjNull,[ObjNull]];
		_uid = getPlayerUID _player;
		_amount = param [5,0,[0]];
		_buySell = param [6,0,[0]];
		_vehicleID = param [7,0,[0]];
		_price = param [8,0,[0]];
		_query = format["SELECT active FROM exchange WHERE ID='%1' AND active=1",_id];
		_result = [_query,2] call DB_fnc_asyncCall;
		if(count _result == 0) exitWith {}; //Bad boy
		if(_buySell == 1) exitWith {
			_query = format["UPDATE exchange SET active=0 WHERE ID='%1'",_id];
			[_query,1] call DB_fnc_asyncCall;
			if(_type != "Virtual") exitWith {["atm","add",_price] remoteExec ["life_fnc_handlePaper",_player]};
			["atm","add",(_price * _amount)] remoteExec ["life_fnc_handlePaper",_player];
		};
		["life_offers",-1] remoteExec ["life_fnc_netSetVar",_player];
		switch(_type) do {
			case "Weapon": {
				_className remoteExec ["KBW_fnc_addWeapon",_player]; 
				if(_amount == 1) then {
					_query = format["UPDATE exchange SET active=0 WHERE ID='%1'",_id];
					[_query,1] call DB_fnc_asyncCall;
				} else {
					_query = format["UPDATE exchange SET Amount=Amount-1 WHERE ID='%1'",_id];
					[_query,1] call DB_fnc_asyncCall;
				};
			};
			case "Virtual": {
				_query = format["UPDATE exchange SET active=0 WHERE ID='%1'",_id];
				[_query,1] call DB_fnc_asyncCall;
				_query = format["SELECT mailbox FROM players WHERE playerid='%1'",_uid];
				_box = [_query,2] call DB_fnc_asyncCall;
				_box = _box select 0;
				_checkForExisting = false;
				{if(_className == (_x select 0)) exitWith{_checkForExisting = true; _box set[_forEachIndex,[_x select 0,(_x select 1) + _amount,(floor(random 10000))]]};} foreach _box;
				if(!_checkForExisting) then {
					_box pushBack [_className,_amount,(floor(random 10000))];
				};
				_query = format["UPDATE players SET mailbox='%1' WHERE playerid='%2'",_box,_uid];
				[_query,1] call DB_fnc_asyncCall;
				_arr = [_className,_amount,floor(random 10000)];
				["life_mailbox",_arr,nil,true,true] remoteExec ["life_fnc_netSetVar",_player];
			};
			case "Vehicle": {
				_query = format["UPDATE exchange SET active=0 WHERE ID='%1'",_id];
				[_query,1] call DB_fnc_asyncCall;
				_query = format["UPDATE vehicles SET listed=0 WHERE id ='%1'",_vehicleid];
				[_query,1] call DB_fnc_asyncCall;
			};
		};
	};
	case 4: {
	//buy offer handling
		_className = _this select 1;
		_type = param [2,"",[""]];
		_amount = param [3,0,[0]];
		_price = param [4,0,[0]];
		_player = param [5,ObjNull,[ObjNull]];
		_uid = getPlayerUID _player;
		_exit = false;
		_query = format["SELECT ID, ClassName, pid, Amount, VehicleID, Price FROM exchange WHERE ClassName LIKE '%3%1%3' AND Price<='%2' AND BuyorSell=0 AND active=1",_className,_price,"%"];
		_result = [_query,2,true] call DB_fnc_asyncCall;
		if(count _result == 0) exitWith {
			_query = switch(_type) do {
				case "Virtual": {format["INSERT INTO exchange (ClassName, Price, isVirtual, Amount, pid, BuyorSell) VALUES ('%1', '%2', '1', '%3', '%4', '1')",str _className,_price,_amount,_uid]};
				case "Vehicle":{format["INSERT INTO exchange (ClassName, Price, isVehicle, pid, BuyorSell) VALUES ('%1', '%2', '1', '%3', '1')",str _className,_price,_uid]};
				case "Weapon":{format["INSERT INTO exchange (ClassName, Price, isWeapon, pid, BuyorSell) VALUES ('%1', '%2', '1', '%3', '1')",str _className,_price,_uid]};
			};
			[_query,1] call DB_fnc_asyncCall;
		};
		if(_type != "Virtual") exitWith {
			_result = _result select 0;
			_id = _result select 0;
			_className = _result select 1;
			_sellerid = _result select 2;
			_amount = _result select 3;
			_vehicleid = _result select 4;
			_price2 = _result select 5;
			[1,"Congratulations, the offer you just posted was instantly met with a seller!"] remoteExec ["life_fnc_broadcast",_player];
			_seller = ObjNull;
			{if(getPlayerUID _x == _sellerid) exitWith {_seller = _x};} forEach playableUnits;
			if(!isNull _seller && side _seller == civilian) then {
				[1,"One of your Altis Exchange sell offers has been met with a buyer! Your bank balance has been updated."] remoteExec ["life_fnc_broadcast",_seller];
				if(_type != "Vehicle") then {["atm","add",_price + round(_price2 * 0.05)] remoteExec ["life_fnc_handlepaper",_seller]} else {
				["atm","add",_price] remoteExec ["life_fnc_handlepaper",_seller]};
				["life_offers",-1] remoteExec ["life_fnc_netSetVar",_seller];
			} else {
				_query = format["SELECT mailbox FROM players WHERE playerid='%1'",_sellerid];
				_box = [_query,2] call DB_fnc_asyncCall;
				_box = _box select 0;
				if(_type != "Vehicle") then {_box pushBack ["cash",_price + round(_price2 * 0.05),floor(random 10000)]} else {
				_box pushBack ["cash",_price,floor(random 10000)]};
				_query = format["UPDATE players SET mailbox='%1' WHERE playerid='%2'",_box,_sellerid];
				[_query,1] call DB_fnc_asyncCall;
			};
			if(_type == "Vehicle") then {
				_query = format["UPDATE exchange SET active=0 WHERE ID=%1",_id];
				[_query,1] call DB_fnc_asyncCall;
				_query = format["UPDATE vehicles SET pid='%1',listed=0 WHERE id='%2'",_uid,_vehicleid];
				[_query,1] call DB_fnc_asyncCall;
			} else {
				_query = format["SELECT mailbox FROM players WHERE playerid='%1'",_uid];
				_box = [_query,2] call DB_fnc_asyncCall;
				_box = _box select 0;
				_className pushBack (floor(random 10000));
				["life_mailbox",_className,nil,true] remoteExec ["life_fnc_netSetVar",_player];
				_box pushBack _className;
				_query = format["UPDATE players SET mailbox='%1' WHERE playerid='%2'",_box,_uid];
				[_query,1] call DB_fnc_asyncCall;
				_query = if(_amount > 1) then {format["UPDATE exchange SET amount=amount-1 WHERE ID=%1",_id]}
				else {format["UPDATE exchange SET active=0 WHERE ID=%1",_id]};
				[_query,1] call DB_fnc_asyncCall;
			};
		};
		_done = false;
		{
			_offer = _x; //loop until my amount is exhausted, this should be fun.
			_id = _offer select 0;
			_className = _offer select 1;
			_sellerid = _offer select 2;
			_amountRequested = _offer select 3;
			_price2 = _offer select 5;
			_query = format["SELECT mailbox FROM players WHERE playerid='%1'",_uid];
			_box = [_query,2] call DB_fnc_asyncCall;
			_box = _box select 0;
			_seller = ObjNull;
			{if(getPlayerUID _x == _sellerid) exitWith {_seller = _x};} forEach playableUnits;
			if(_amountRequested >= _amount) exitWith {
				_amountRequested = _amountRequested - _amount;
				if(_amountRequested != 0) then {
					_query = format["UPDATE exchange SET amount='%1' WHERE ID='%2'",_amountRequested,_id];
					[_query,1] call DB_fnc_asyncCall;
				} else {
					if(!isNull _seller) then {["life_offers",-1] remoteExec ["life_fnc_netSetVar",_seller]};
					_query = format["UPDATE exchange SET active=0 WHERE ID=%1",_id];
					[_query,1] call DB_fnc_asyncCall;
				};
				_arr = [_className,_amount,floor(random 10000)];
				["life_mailbox",_arr,nil,true,true] remoteExec ["life_fnc_netSetVar",_player];
				_checkForExisting = false;
				{if(_className == (_x select 0)) exitWith{_checkForExisting = true; _box set[_forEachIndex,[_x select 0,(_x select 1) + _amount,(floor(random 10000))]]};} foreach _box;
				if(!_checkForExisting) then {
					_box pushBack [_className,_amount,(floor(random 10000))];
				};
				_query = format["UPDATE players SET mailbox='%1' WHERE playerid='%2'",_box,_uid];
				[_query,1] call DB_fnc_asyncCall;
				//Is our seller online? unlikely, but possible.
				if(!isNull _seller && side _seller == civilian) then {
					[1,"Some of the resources you were selling in the Altis Exchange have been met with a buyer, your bank balance has been updated."] remoteExec ["life_fnc_broadcast",_seller];
					["atm","add",round((_price2 * 0.05) * _amount) + (_price * _amount)] remoteExec ["life_fnc_handlepaper",_seller];
				} else {
					_query = format["SELECT mailbox FROM players WHERE playerid='%1'",_sellerid];
					_box = [_query,2] call DB_fnc_asyncCall;
					_box = _box select 0;
					_box pushBack ["cash",round((0.05 * _price2) * _amount) + (_amount * _price),floor(random 10000)];
					_query = format["UPDATE players SET mailbox='%1' WHERE playerid='%2'",_box,_sellerid];
					[_query,1] call DB_fnc_asyncCall;
				};
				_done = true;
				[1,"Congratulations, the resources you were attempting to buy have arrived!"] remoteExec ["life_fnc_broadcast",_player];
			};
			_arr = [_className,_amountRequested,floor(random 10000)];
			["life_mailbox",_arr,nil,true,true] remoteExec ["life_fnc_netSetVar",_player];
			if(!isNull _seller && side _seller == civilian) then {
				["life_offers",-1] remoteExec ["life_fnc_netSetVar",_seller];
				[1,"One of your resource sales in the Altis Exchange has been met with a buyer, your bank balance has been updated."] remoteExec ["life_fnc_broadcast",_seller];
				["atm","add",round((_price2 * 0.05) * _amountRequested) + (_price * _amountRequested)] remoteExec ["life_fnc_handlePaper",_seller];
			} else {
				_query = format["SELECT mailbox FROM players WHERE playerid='%1'",_sellerid];
				_box = [_query,2] call DB_fnc_asyncCall;
				_box = _box select 0;
				_box pushBack ["cash",round((_price2 * 0.05) * _amountRequested) + (_price * _amountRequested),floor(random 10000)];
				_query = format["UPDATE players SET mailbox='%1' WHERE playerid='%2'",_box,_sellerid];
				[_query,1] call DB_fnc_asyncCall;
			};
			_checkForExisting = false;
			{if(_className == (_x select 0)) exitWith{_checkForExisting = true; _box set[_forEachIndex,[_x select 0,(_x select 1) + _amountRequested,(floor(random 10000))]]};} foreach _box;
			if(!_checkForExisting) then {
				_box pushBack [_className,_amountRequested,(floor(random 10000))];
			};
			_query = format["UPDATE exchange SET active=0 WHERE ID=%1",_id];
			[_query,1] call DB_fnc_asyncCall;
			_query = format["UPDATE players SET mailbox='%1' WHERE playerid='%2'",_box,_uid];
			[_query,1] call DB_fnc_asyncCall;
			_amount = _amount - _amountRequested;
		} forEach _result;
		if(!_done) then {
			_query = format["INSERT INTO exchange (ClassName, Price, isVirtual, Amount, pid, BuyorSell) VALUES ('%1', '%2', '1', '%3', '%4', '1')",str _className,_price,_amount,_uid];
			[_query,1] call DB_fnc_asyncCall;
		};
		
	};
};