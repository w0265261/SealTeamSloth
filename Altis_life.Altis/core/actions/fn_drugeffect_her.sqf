/*
	developed by JackLags
	Usable by only the Seal Team Sloth Community
	Any configurations are only permitted by the Seal Team Sloth DEV Team
*/
 
"colorCorrections" ppEffectEnable true;
"colorCorrections" ppEffectAdjust [1, 1, 0, [0,0,0,0.5], [random 5 - random 5,random 5 - random 5,random 5 - random 5,random 1], [random 5 - random 5,random 5 - random 5,random 5 - random 5, random 1]];
"colorCorrections" ppEffectCommit 1;
"chromAberration" ppEffectEnable true;
"chromAberration" ppEffectAdjust [0.01,0.01,true];
"chromAberration" ppEffectCommit 1;
sleep 25;	

private["_force"];
for "_i" from 0 to 20 do
{
	"colorCorrections" ppEffectEnable true;
	"colorCorrections" ppEffectAdjust [1, 1, 0, [0,0,0,0.5], [random 5 - random 5,random 5 - random 5,random 5 - random 5,random 1], [random 5 - random 5,random 5 - random 5,random 5 - random 5, random 1]];
	"colorCorrections" ppEffectCommit 1;	
	sleep 0.02;
};
"chromAberration" ppEffectEnable false;
"colorCorrections" ppEffectEnable false;
if(!alive player) exitWith {};