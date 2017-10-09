/*
 police sender, open gates via a key (only for cops) 
 Thanks to Insane
*/

{
	if (_x animationPhase "Door_1_rot" == 1) then {
		_x animate ["Door_1_rot", 0];
	} 
	else 
	{
		_x animate ["Door_1_rot", 1];
	};
	
} forEach (nearestObjects [player, ["Land_BarGate_F"], 20]);