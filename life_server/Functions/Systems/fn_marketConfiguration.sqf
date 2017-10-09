/*
Market Configuration
Params: shortName,basePrice,minprice,maxprice,
AMOUNT to decrease this reasource buy per resource sold,
AMOUNT to increase all of the other resources by in the following array per resource sold.
*/
life_market_resources = [


	
	 ["oilp", (sell_array select (["oilp",sell_array] call fnc_index)) select 1, 0, 10000, 0.2, 0.05,
                [  
                        ["ironr",1],
                        ["copperr",1],
                        ["steel",1],
                        ["lumber",1]
                ]
        ],
       
        ["steel", (sell_array select (["steel",sell_array] call fnc_index)) select 1, 0, 10000, 0.2, 0.05,
                [
                        ["ironr",1],
                        ["copperr",1],
                        ["oilp",1],
                        ["lumber",1]
                ]
        ],
       
        ["lumber", (sell_array select (["lumber",sell_array] call fnc_index)) select 1, 0, 30000, 5, 1.25,
                [
                        ["ironr",1],
                        ["copperr",1],
                        ["steel",1],
                        ["oilp",1]
                ]
        ],
       
        ["goldr", (sell_array select (["goldr",sell_array] call fnc_index)) select 1, 0, 10000, 0.125, 0.03125,
                [
                        ["diamondc",1],
                        ["saltr",1],
                        ["cement",1],
                        ["glass",1]
                ]
        ],
       
        ["ironr", (sell_array select (["ironr",sell_array] call fnc_index)) select 1, 0, 10000, 0.125, 0.03125,  
                [  
                        ["oilp",1],
                        ["copperr",1],
                        ["steel",1],
                        ["lumber",1]
                ]
        ],
       
        ["diamondc", (sell_array select (["diamondc",sell_array] call fnc_index)) select 1, 0, 10000, 0.1, 0.025,
                [
                        ["saltr",1],
                        ["cement",1],
                        ["glass",1],
                        ["goldr",1]
                ]
        ],
       
        ["copperr", (sell_array select (["copperr",sell_array] call fnc_index)) select 1, 0, 10000, 0.1, 0.025,
                [
                        ["oilp",1],
                        ["ironr",1],
                        ["steel",1],
                        ["lumber",1]
                ]
        ],
       
        ["saltr", (sell_array select (["saltr",sell_array] call fnc_index)) select 1, 0, 10000, 0.075, 0.01875,
                [
                        ["diamondc",1],
                        ["cement",1],
                        ["glass",1],
                        ["goldr",1]
                ]
        ],
       
        ["glass", (sell_array select (["glass",sell_array] call fnc_index)) select 1, 0, 10000, 0.075, 0.01875,
                [
                        ["diamondc",1],
                        ["saltr",1],
                        ["cement",1],
                        ["goldr",1]
                ]
        ],
       
        ["cement", (sell_array select (["cement",sell_array] call fnc_index)) select 1, 0, 10000, 0.125, 0.03125,
                [
                        ["diamondc",1],
                        ["saltr",1],
                        ["glass",1],
                        ["goldr",1]
                ]
        ],
 
        /*legal above, illegal below*/
       
        ["turtle", (sell_array select (["turtle",sell_array] call fnc_index)) select 1, 0, 10000, 0.5, 0.5,  
                [
                        ["meth",1]
                ]
        ],
       
        ["meth", (sell_array select (["meth",sell_array] call fnc_index)) select 1, 0, 10000, 0.2, 0.2,  
                [
                        ["turtle",1]
                ]
        ],
       
        ["moonshine", (sell_array select (["moonshine",sell_array] call fnc_index)) select 1, 0, 10000, 0.075, 0.025,  
                [
                        ["marijuana",1],
                        ["cocainep",1],
                        ["heroinp",1]
                ]
        ],
       
        ["marijuana", (sell_array select (["marijuana",sell_array] call fnc_index)) select 1, 1, 10000, 0.105, 0.035,  
                [
                        ["moonshine",1],
                        ["cocainep",1],
                        ["heroinp",1]
                ]
        ],
       
        ["cocainep", (sell_array select (["cocainep",sell_array] call fnc_index)) select 1, 0, 10000, 0.15, 0.05,  
                [
                        ["marijuana",1],
                        ["heroinp",1],
                        ["moonshine",1]
                ]
        ],
       
        ["heroinp", (sell_array select (["heroinp",sell_array] call fnc_index)) select 1, 0, 10000, 0.15, 0.05,  
                [
                        ["marijuana",1],
                        ["cocainep",1],
                        ["moonshine",1]
                ]
        ]
];


publicVariable "life_market_resources";



/*GENERATED CONFIG*/
life_market_shortnames = []; /*shortnames if in market*/

{
	life_market_shortnames pushBack (_x select 0);
}
foreach life_market_resources;

publicVariable "life_market_shortnames";

life_market_prices = []; /*[SHORTNAME,CURRENTPRICE,DIRECTIONGLOBAL,DIRECTIONLOCAL]*/
{
	life_market_prices pushBack[_x select 0, _x select 1, 0, 0];
}
foreach life_market_resources;
	
publicVariable "life_market_prices";