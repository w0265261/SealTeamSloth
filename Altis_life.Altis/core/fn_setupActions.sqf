/*
	File: fn_setupActions.sqf
	
	Description:
	Master addAction file handler for all client-based actions.
*/
switch (playerSide) do
{
	case civilian:
	{
		/*Drop fishing net*/
		STS_actions = [player addAction[localize "STR_pAct_DropFishingNet",life_fnc_dropFishingNet,"",0,false,false,"",'
		(surfaceisWater (getPos vehicle player)) && (vehicle player isKindOf "Ship") && life_carryWeight < life_maxWeight && speed (vehicle player) < 2 && speed (vehicle player) > -1 && !life_net_dropped ']];
		/*Med Kit*/
		STS_actions pushBack (player addAction["Heal yourself",{life_action_inUse = true; player playActionNow "Medic";
		sleep 3; player setDamage 0; life_action_inUse = false;},nil,0,false,false,"",'"Medikit" in items player && getDammage player > 0.05 && license_civ_supermed && !life_action_inUse']);
		STS_actions pushBack (player addAction["Heal target",{_player = cursorTarget; life_action_inUse = true; player playActionNow "Medic";
		sleep 3; _player setDamage 0; life_action_inUse = false;},nil,0,false,false,"",'"Medikit" in items player && getDammage cursorTarget > 0.05 && license_civ_supermed && !life_action_inUse && player distance cursorTarget < 3 && isPlayer cursorTarget']);
		STS_actions pushBack (player addAction["Shank",life_fnc_shankAction,player,0,false,false,"",'cursorTarget isKindOf "Man" && isPlayer cursorTarget && alive cursorTarget && life_inv_shank > 0  && isNull objectParent player && player distance cursorTarget < 3 && !isNull life_placing']);	
		STS_actions pushBack (player addAction["Sit Down",{["life_sit",true] remoteExec ["life_fnc_netSetVar",cursorTarget]},nil,0,false,false,"",' isPlayer cursorTarget && animationState cursorTarget == "AmovPercMstpSnonWnonDnon_Ease" ']);
		STS_actions pushBack (player addAction["Stand Up",{["life_sit",false] remoteExec ["life_fnc_netSetVar",cursorTarget]},nil,0,false,false,"",' isPlayer cursorTarget && animationState cursorTarget == "Acts_AidlPsitMstpSsurWnonDnon_loop" ']);
		STS_actions pushBack (player addAction["Toggle BH Tags",{if(player getVariable["hiding",false]) then {player setVariable["hiding",false,true]; hint "Bounty Hunter tags toggled ON"} else {player setVariable["hiding",true,true]; hint "Bounty Hunter tags toggled OFF"}},nil,0,false,false,"",'license_civ_bh']);
	};

	case west:
	{
		/*CopEnter - Driver Seat*/
		STS_actions = [player addAction["Get in Driver",life_fnc_copEnter,"driver",200,false,false,"",'!isNull cursorTarget && ((cursorTarget isKindOf "Car")||(cursorTarget isKindOf "Air")||(cursorTarget isKindOf "Ship")) && (locked cursorTarget) != 0 && cursorTarget distance player < 3.5 && cursorTarget getVariable["copCar",false]']];
		/*CopEnter - Passenger Seat*/
		STS_actions pushBack (player addAction["Get in Passenger",life_fnc_copEnter,"passenger",100,false,false,"",'!isNull cursorTarget && ((cursorTarget isKindOf "Car")||(cursorTarget isKindOf "Air")||(cursorTarget isKindOf "Ship")) && (locked cursorTarget) != 0 && cursorTarget distance player < 3.5 && cursorTarget getVariable["copCar",false]']); 
		/*CopEnter - Exit*/
		STS_actions pushBack (player addAction["Get out of vehicle",life_fnc_copEnter,"exit",100,false,false,"",'(!isNull objectParent player) && (locked(vehicle player)==2) && !(player getvariable["restrained",false])']);
		/*placing checkpoints*/
		STS_actions pushBack (player addAction["Place Object",life_fnc_placedObject,player,0,false,false,"",'!isNull life_placing']);
		/* Pick up placed object*/
		STS_actions pushBack (player addAction["Pick Up Object",life_fnc_pickupObject,cursorTarget,0,false,false,"",
		' (typeOf cursorTarget in ["RoadCone_F","RoadBarrier_F","Land_CncBarrierMedium_F","Land_CncBarrierMedium4_F","Land_BarGate_F"]) && (player distance cursorTarget) < 5 ']);
		STS_actions pushBack (player addAction["Show Police Rank",{ player setVariable["rank",call life_coplevel, true]; },cursorTarget,-2,false,false,"",' (player getVariable ["rank",0]) == 0 && undercover ']);
		STS_actions pushBack (player addAction["Hide Police Rank",{ player setVariable["rank",nil,true]; },cursorTarget,-2,false,false,"",' (player getVariable ["rank",0]) > 0 && undercover ']);
		STS_actions pushBack (player addAction["Seize Objects",life_fnc_seizeObjects,cursorTarget,0,false,false,"",'((count(nearestObjects [player,["WeaponHolder"],3])>0) || (count(nearestObjects [player,["GroundWeaponHolder"],3])>0) || (count(nearestObjects [player,["WeaponHolderSimulated"],3])>0))']);
		STS_actions pushBack (player addAction["Heal yourself",{life_action_inUse = true; player playActionNow "Medic";
		sleep 3; player setDamage 0; life_action_inUse = false;},nil,0,false,false,"",' life_inv_medkit > 0 && getDammage player > 0.05 && !life_action_inUse']);
		STS_actions pushBack (player addAction["Heal target",{_player = cursorTarget; life_action_inUse = true; player playActionNow "Medic";
		sleep 3; _player setDamage 0; life_action_inUse = false;},nil,0,false,false,"",' life_inv_medkit > 0 && getDammage cursorTarget > 0.05 && !life_action_inUse && player distance cursorTarget < 3 && isPlayer cursorTarget']);
		STS_actions pushBack (player addAction["Sit Down",{["life_sit",true] remoteExec ["life_fnc_netSetVar",cursorTarget]},nil,0,false,false,"",' isPlayer cursorTarget && animationState cursorTarget == "AmovPercMstpSnonWnonDnon_Ease" ']);
		STS_actions pushBack (player addAction["Stand Up",{["life_sit",false] remoteExec ["life_fnc_netSetVar",cursorTarget]},nil,0,false,false,"",' isPlayer cursorTarget && animationState cursorTarget == "Acts_AidlPsitMstpSsurWnonDnon_loop" ']);
	};
	
	case independent:
	{
		/*CopEnter - Driver Seat*/
		STS_actions = [player addAction["Get in Driver",life_fnc_copEnter,"driver",200,false,false,"",'!isNull cursorTarget && ((cursorTarget isKindOf "Car")||(cursorTarget isKindOf "Air")||(cursorTarget isKindOf "Ship")) && (locked cursorTarget) != 0 && cursorTarget distance player < 3.5']];
		/*CopEnter - Passenger Seat*/
		STS_actions pushBack (player addAction["Get in Passenger",life_fnc_copEnter,"passenger",100,false,false,"",'!isNull cursorTarget && ((cursorTarget isKindOf "Car")||(cursorTarget isKindOf "Air")||(cursorTarget isKindOf "Ship")) && (locked cursorTarget) != 0 && cursorTarget distance player < 3.5']); 
		/*CopEnter - Exit*/
		STS_actions pushBack (player addAction["Get out of vehicle",life_fnc_copEnter,"exit",100,false,false,"",'(!isNull objectParent player) && (locked(vehicle player)==2)']);
		STS_actions pushBack (player addAction["Heal yourself",{life_action_inUse = true; player playActionNow "Medic";
		sleep 3; player setDamage 0; life_action_inUse = false;},nil,0,false,false,"",' life_inv_medkit > 0 && getDammage player > 0.05 && !life_action_inUse']);
		STS_actions pushBack (player addAction["Heal target",{_player = cursorTarget; life_action_inUse = true; player playActionNow "Medic";
		sleep 3; _player setDamage 0; life_action_inUse = false;},nil,0,false,false,"",' life_inv_medkit > 0 && getDammage cursorTarget > 0.05 && !life_action_inUse && player distance cursorTarget < 3 && isPlayer cursorTarget']);
	};

};
STS_actions pushBack (player addAction ["<t color='#BBBB00'>Put Seatbelt On</t>", {life_seatbelt=true; playSound "seatbelt"}, "", 3, false, true, "", 'vehicle player isKindOf "Car" && !life_seatbelt']);
[] call fnc_atmAction;
[] call fnc_phoneAction;