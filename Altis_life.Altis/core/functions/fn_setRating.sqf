systemChat "The convoy AI will now become hostile!!";
player addRating -9999999999999999999999;
_time = time;
waitUntil{sleep 1; time - _time > 300 || player getVariable["unconscious",false]};
player addRating 9999999999999999999999;