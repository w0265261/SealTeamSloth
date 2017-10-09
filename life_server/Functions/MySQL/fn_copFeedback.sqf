/*
DB_fnc_copFeedback
Kevin Webb
Inserts feedback to database
*/
_rating = param [0,1,[0]];
_cops = param [1,[],[[]]];
_message = param [2,"",[""]];
_player = param [3,[],[[]]];
_query = format["INSERT INTO feedback (reporter, cops, rating, message) VALUES ('%1', '%2', %3, '%4')",_player,_cops,_rating,_message];
[_query,1] call DB_fnc_asyncCall;