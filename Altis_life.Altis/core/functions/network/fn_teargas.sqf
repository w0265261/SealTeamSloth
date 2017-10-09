While{!isNull _this} do 
{
    "dynamicBlur" ppEffectEnable true; /* enables ppeffect */
    "dynamicBlur" ppEffectAdjust [0]; /* enables normal vision */
    "dynamicBlur" ppEffectCommit 6; /* time it takes to normal */


    waitUntil{_this distance player < 8};
    if (!(headgear player in["H_CrewHelmetHeli_B","H_CrewHelmetHeli_I","H_CrewHelmetHeli_O"]) && isNull objectParent player && !(player getVariable ["invis",false])) then
    {
        "dynamicBlur" ppEffectEnable true; /* enables ppeffect */
        "dynamicBlur" ppEffectAdjust [10]; /* intensity of blur */
        "dynamicBlur" ppEffectCommit 2; /* time till vision is fully blurred */

    };
    
    sleep 2;
};