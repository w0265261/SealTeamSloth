/*
	developed by JackLags
	Usable by only the Seal Team Sloth Community
	Any configurations are only permitted by the Seal Team Sloth DEV Team
*/
	
/*Enable ppeffects*/
"dynamicBlur" ppEffectEnable true;
"chromAberration" ppEffectEnable true;

/*Let's go for 45secs of effects*/
for "_i" from 0 to 44 do
{
	"dynamicBlur" ppEffectAdjust [1.5];
	"dynamicBlur" ppEffectCommit 1;
	"chromAberration" ppEffectAdjust [0.3,0.3,true];
	"chromAberration" ppEffectCommit 1;
	addcamShake[random 3, 1, random 3];
	sleep 1;
};

/*Stop the ppeffects*/
"chromAberration" ppEffectAdjust [0,0,true];
"chromAberration" ppEffectCommit 5;
"dynamicBlur" ppEffectAdjust [0];
"dynamicBlur" ppEffectCommit 5;
sleep 6;

/*disable effects*/
"dynamicBlur" ppEffectEnable false;
"chromAberration" ppEffectEnable false;
resetCamShake;

if(!alive player) exitWith {};
