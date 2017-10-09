/*
	Master eventhandler file
*/
player addEventHandler["Killed", {_this spawn life_fnc_onDeath}];
player addEventHandler["handleDamage",{_this call life_fnc_handleDamage;}];
player addEventHandler["Respawn", {_this spawn life_fnc_onRespawn}];
player addEventHandler["Take",{_this call life_fnc_onTakeItem}];
player addEventHandler["InventoryClosed", {_this call life_fnc_inventoryClosed}];
player addEventHandler["InventoryOpened", {_this call life_fnc_inventoryOpened}];
player addEventHandler["Fired",{_this call life_fnc_onFired}];
"life_phone_channel" addPublicVariableEventHandler
{
	_message = if (life_phone_channel < 0) then { life_phone_status = 0; "Your phone call has ended." } else { "Phone link established!" };
	[[0,2], _message] call life_fnc_broadcast;
	if (life_phone_channel > -1) then { life_phone_status = 3; setCurrentChannel (life_phone_channel + 5); };
};