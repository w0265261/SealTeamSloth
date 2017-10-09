/*
	File: fn_meth.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Not even once!
*/



life_drug_level = life_drug_level + 0.2;
if (life_drug_level > 1) then { life_drug_level = 1; };

if (life_meth_effect == 0) then
{
	life_meth_effect = time;
	[] spawn
	{
		"ColorInversion" ppEffectEnable true;
		"ColorInversion" ppEffectAdjust [life_drug_level / 5,0,life_drug_level / 5];
		"ColorInversion" ppEffectCommit 1;
		"chromAberration" ppEffectEnable true;
		"chromAberration" ppEffectAdjust [life_drug_level / 10,life_drug_level / 10,true];
		"chromAberration" ppEffectCommit 1;
		sleep 2.25;	
		
		while {alive player && ((time - life_meth_effect) < (4 * 60))} do
		{
			"ColorInversion" ppEffectEnable true;
			"ColorInversion" ppEffectAdjust [life_drug_level / 5,0,life_drug_level / 5];
			"ColorInversion" ppEffectCommit 1;
			"chromAberration" ppEffectEnable true;
			"chromAberration" ppEffectAdjust [life_drug_level / 10,life_drug_level / 10,true];
			"chromAberration" ppEffectCommit 1;
			sleep 2;
		};
		
		"chromAberration" ppEffectEnable false;
		"ColorInversion" ppEffectEnable false;
		life_meth_effect = 0;
	};
};

life_meth_effect = time;

[] spawn
{
	systemChat "You feel incredible!";
	waitUntil {!alive player OR ((time - life_meth_effect) > (4.5 * 60))};
	life_meth_effect = 0;
};

[] call life_fnc_hudUpdate;