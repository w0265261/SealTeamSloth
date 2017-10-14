waitUntil {!isNull player && player == player};
if(player diarySubjectExists "rules")exitwith{};

player createDiarySubject ["tutorial","Tutorial"];
player createDiarySubject ["controls","Controls"];
player createDiarySubject ["serverrules","General Rules"];
/*player createDiarySubject ["policerules","Police Procedures/Rules"];*/
/*player createDiarySubject ["safezones","Safe Zones (No Killing)"];*/
/*player createDiarySubject ["civrules","Civilian Rules"];*/
player createDiarySubject ["illegalitems","Illegal Activity"];
/*player createDiarySubject ["gangrules","Gang Rules"];*/
/*player createDiarySubject ["terrorrules","Terrorism Rules"];*/
player createDiarySubject ["ts3web","Teamspeak & Website"];

/*  Example
	player createDiaryRecord ["", //Container
		[
			"", //Subsection
				"
				TEXT HERE<br/><br/>
				"
		]
	];
*/
	player createDiaryRecord["ts3web",
		[
			"Teamspeak",
				"
					Our Teamspeak server is located at ts3.sealteamsloth.life<br/><br/>
					
					Usage of Teamspeak is required for all Police Officers and Medics.<br/>
					It is also your best bet for contacting an admin if you have questions or are in need of assistance.<br/><br/>
				"
		]
	];
	player createDiaryRecord["ts3web",
		[
			"Website",
				"
					Our website is located at www.sealteamsloth.life<br/><br/>
					
					All reporting and applications are done under the SLACKER heading in the top bar.<br/>
					This includes applying to become a cop or medic, ban appeals, or reporting another player or cop if you feel their behaviour has breached rules or policies.<br/>
					All compensation requests MUST be posted in the appropriate section or they will not be granted.
					The website also hosts the master-copy of the rules, laws and police policies. If there are any contradictions with those displayed in game, the website is the correct version.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord["tutorial",
		[
			"Death",
				"
					There are two types of 'death'. If you get critically wounded, you become incapacitated and the EMS revives people that are incapacitated. Be sure you text the EMS with your cell phone if you get critically wounded. You do not lose your gear when you get incapacitated. Some times your virtual items will fall onto the ground including your money. Being incapacitated means you have a timer until you bleed out. People with Medical Training can stabilize you to increase the counter. If you bleed out, you completely die.<br /><br />
					
					You can also revive incapacitated players at a Hospital. It costs $100 to do so. Getting revived by a medic costs 1% of your total bank account but will not cost more than $1000.<br /><br />
					
					Complete death can be caused from bleeding out, respawning, not eating food, not drinking water, or getting lethal injected. It can also occur if you are caught in the blast of an exploding car, or hit by vehicle-mounted weapons. If you completely die, your bank account balance will be charged 0.5% of your total bank account for a 'cloning' fee, and you will keep your garage contents, and ownership of your houses. You will be prompted to spawn in a town and you will have lost all of your things on your character. Be sure you read the rules that take effect after your death at sealteamsloth.life.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Chop Shop",
				"
					All vehicles, except helicopters, are eligible for a chop. There is a garage at the chop shop and if you chop a vehicle, you will get wanted for Supplying an Illegal Chop Shop and you will get money from the chop shop. It does not cost you money to chop shop vehicles. Alternatively, you can use the chop shops to make a stolen vehicle your own, for a fee which is based on the type of vehicle. They can be found on the map all across Altis. Map legend is at the top left of the map.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Crimes",
				"
					Committing a crime puts you on the Wanted List. To access the Wanted List, you must go to a Police HQ and use the computer there.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Bounty Hunters",
				"
					To be a Bounty Hunter, you need admin approval. Go to the forums at sealteamsloth.life to submit your application.<br /><br />
					
					Bounty Hunters are civs that get money from capturing wanted people with a bounty of over $3,000. If a Bounty Hunter captures you with a bounty less than $3000 the bounty hunter can not turn you in for money. They must initiate RP to capture wanted civilians. It also gives access to unique gear.<br /><br />Bounty Hunter's license costs $7500.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Class 3 Weapons",
				"
					Class 3 Weapons license allows you to purchase 5.56mm weapons and legally have them. It also gives access to unique gear. If you get arrested, the license is revoked. See the Licenses tab to learn where to get the license.<br /><br />Class 3 Weapons costs $10,000.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Gang Training",
				"
					Gang Training allows you to purchase illegal high calibre weapons, vehicles, and gear. It is not illegal to dress in gang gear. See the Licenses tab to learn where to get the license. <br /><br />Gang Training costs $7500.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Garages",
				"
					There are three types of garages: Air, Water, and Ground.<br /><br />
					
					You can only pull out helicopters from the Air Garages. You can only pull out land vehicles from the Land garage. And you can only pull out boats from the Water garage. You can find an air Garage North of Kavala at the stadium or at the airport. Water garages are at boat shops. Any other garage is a land garage.<br /><br />
					
					Any vehicle you store in the garage is saved into the database. Some times if you leave your vehicle to long, the server will remove it from the world but place it back into your garage. You can only garage your vehicles that you permanently bought. You can store any vehicle, land or air, in any garage.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Housing & Personal Garages",
				"
					To purchase a house, you need a Home Owners License. Look at the Licenses/Processing List to figure out where to get one. Once you have the license, press Windows Key on a house that you would like to purchase. Houses start at $30,000 and very big and nice two story houses go up to $115,000. Push the buy button to see the price tag. <br /><br />Not all houses are for sale.<br /><br />
					
					To purchase a personal garage, do the same thing you would to houses. All garages are no less than $70,000. You get a 50% discount on pullout fees when you own a personal garage.<br /><br />
					
					Anything you store in your house or garage is synced to the database and will be saved on logout. Your garage is the same garage as any other garage. Personal garages can not be Air Garages.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Stores/Gas Stations",
				"
					Stores are scattered across Altis. Use the legend at the top left part of the map to find specific stores. Use the Item Guide to know what you might find in some stores. Not all items and objects are listed as the store usually suggests what is sold and bought there. <br /><br />
					
					<font color='#00FF00'>The Clothing store</font> sells backpacks, clothes, hats, and glasses.<br />
					<font color='#00FF00'>The General store</font> sells Arma 3 inventory items such as a map, repair kits, etc.<br />
					<font color='#00FF00'>The Market</font> sells virtual items such as food, water, etc.<br /><br />
					
					Gas Stations marked on the map that have a yellow icon can be used as a regular Market, or General Store. You will also be able to rob the station if you have a weapon.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Repairing a Vehicle",
				"
					To repair a vehicle, press Windows Key on the truck with a tool kit/repair kit in your inventory or the vehicle's inventory.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Mining/Collecting Resources",
				"
					Some resources require the use of a tool. To use the tool, press Y to open your Personal Menu. Click Use on tool required for the job and if you are in the area, the collecting will commence. See 'Collection and Processing' to know what jobs require the use of tools and what tool is required. To collect other resources, get in the area and press Windows Key.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Auto-Mining/Auto-Drilling",
				"
					To Auto-Mine or Auto-Drill, purchase a Tempest Device or Fuel Truck from the Truck Store, respectively. These trucks require no effort on your part and to start them, press Windows Key on the truck.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Collection and Processing",
				"
					All things you sell except food, crab, and poaches, have 3 stages. Harvesting, processing, and selling. Look at the map legend at the top left of the map to help figure out where to start collecting resources, where to process them, and where to sell them.<br /><br />
					
					<font color='#00FF00'>Requires Tool:</font><br />
					1.) Diamond - Pickaxe<br />
					2.) Sand - Pickaxe<br />
					3.) Iron - Pickaxe<br />
					4.) Coal - Pickaxe<br />
					5.) Gold - Pickaxe<br />
					6.) Hydrogen Sulfate - Pickaxe<br />
					7.) Phosphorus - Pickaxe<br />
					8.) Copper- Pickaxe<br />
					9.) Oil - Pickaxe or Fuel Truck<br />
					10.) Logging - Chainsaw (Available at Wood trader)<br />
					11.) Crab - Crab pot<br />
					12.) Poaching - SDAR gun<br />
					13.) Excavating Ship Wrecks - Excavator<br /><br />
					
					<font color='#00FF00'>Requires Multiple Items:</font><br />
					1.) Meth (1 Ephedra, 1 Hydrogen Sulfate, 1 Phosphorus)<br />
					2.) Steel (1 Coal, 1 Iron)<br /><br />
					
					<font color='#00FF00'>Unique Outputs:</font><br />
					1.) Sand - Yields Glass<br />
					2.) Logging - Yields Lumber<br />
					3.) Corn - Yields Moonshine<br />
					4.) 1 Ephedra, 1 Hydrogen Sulfate, and 1 Phosphorus  - Yields Meth<br />
					5.) 1 Coal and 1 Iron - Yields Steel<br /><br />
					
					<font color='#00FF00'>Unique storage items:</font><br />
					1.) Meth - can only be stored in boats, houses, your person, or land vehicles <br />
					2.) Oil - can only be stored in fuel trucks or on your person.<br /><br />
					
					<font color='#00FF00'>Where to Sell:</font><br />
					1.) Any kind of metal - Precious Metals<br />
					2.) Oil - Gas Station closest to DP 12 or Gas Station North Pyrgos<br />
					3.) Perfect Diamond (Excavated Item) - Diamond Trader<br />
					4.) Excavated Items - Market<br />
					5.) Any drug - Drug Dealer<br />
					6.) Any other manufactured goods - Designated Sales Person (Glass Trader for Glass, etc.)<br />
					7.) Any food item - Market<br />
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Item Guide",
				"
					<br />
					<font color='#00FF00'>Market Items:</font><br />
					1.) Water Bottle - For drinking<br />
					2.) Rabbit Meat - For eating<br />
					3.) Apple - For eating<br />
					4.) RedGull - For eating<br />
					5.) Peach - For eating<br />
					6.) Tactical Bacon - For eating<br />
					7.) Pickaxe - Used to mine diamonds, sand, etc.<br />
					8.) Fuel Can - Used on vehicles to refuel them<br />
					9.) Crab Pot - Used to get crabs<br />
					10.) Small Storage - Adds a 750 weight capacity virtual item storage and a small physical item storage to your house when used.<br />
					11.) Large Storage - Adds 1000 weight capacity virtual item storage and a large physical item storage to your house when used.<br />
					12.) Excavator - Used at shipwrecks.<br /><br />
					
					<font color='#00FF00'>Gang Outpost Items:</font><br />
					1.) Lock pick - For lock picking vehicles<br />
					2.) Blindfold - For blindfolding<br />
					3.) Vehicle Ammo - Ammo for the Armed Offroad<br />
					4.) Bolt Cutter- Bolt Cutter- Used to break into houses<br />
					5.) Blasting Charge - For breaking into the Federal Reserve<br />
					6.) Zip-Tie - Restrain people<br />
					7.) Lethal Injection - Used to kill players to full death<br />
					8.) Tracking Device - Used on people to track them with GPS<br />
					9.) Other - Sells food, water, fuel cans, and pickaxes.<br /><br />
					
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Deliver Package (DP) Missions",
				"
					You can start DP missions by going to a DP point. They are scattered across the map label as DP and then a number. The amount of money you earn is based upon the amount of distance you travel. The most money you can make is well over $4k for one delivery. The DP missions are not timed. If you wish to not do it, then just ignore it. It won't cause problems.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Getting Money & Getting Paid",
				"
					Every player has a regular pay check. These pay checks get deposited into your bank account automatically and occur every 5 minutes.<br /><br />
					
					To get money, you can sell apples to the market, sell illegal drugs, or sell weapons. How you make money is up to you. Read up on the 'Collection and Processing' guide to know where to sell and buy items as well as how to get them.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Lottery",
				"
					Lottery tickets for the Altis Lottery are purchasable at any DMV location. They cost $200 each and each ticket has an equal chance of winning the loterry, but the more tickets you buy the more likely your one of your tickets are to be picked.<br /><br />

					The lottery is initiated at the beginning of every server session and a drawing will be held every 2 hours automatically. If no one wins the lottery, the jackpot will roll over to the next drawing. The jackpot is persistent, and will keep building up across server sessions until someone wins. The jackpot will be displayed in the lower left corner each drawing, regardless of win or loss.<br /><br />
					
					Even if you are offline, your bank account will receive the winnings and you'll win the lottery. In the event that an admin will restart the server, they will always 'force' the lottery to draw using a special command, so you should never need to worry about wasted funds on tickets.<br /><br />
					
					If you are online and happen to be the winner, several messages will be displayed on your screen indicating how much you won.<br /><br />
					
					<font color='#00FF00'>The jackpot is composed of funds from ticket purchases only.</font>
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Sling Loading",
				"
					Helicopters can only sling load unlocked vehicles.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Vehicle Trunks",
				"
					To access the trunk of your vehicle, press T when you are next to it. This is a virtual item storage separate from your player's virtual inventory. You can place items in this trunk but be aware they will not save when you put the truck in a garage or on server restart.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Trucks",
				"
					Trucks are purchasable at the Truck Store. You need a Truck License to drive them legally and purchase one of your own. These vehicles are significantly more expensive than regular civilian vehicles but will increase the trunk space of your car. <br /><br />
					
					To read more on trunk space, read 'Vehicle Trunks'. You should be careful when using these vehicles because they are prime targets for a chop. To read more about chop shops, read the  'Chop Shop' tutorial.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Licenses/Processing List",
				"
					<br />
					<font color='#FF0000'>--Purchasable at the DMV</font>:<br />
					<font color='#00FF00'>1.) Driver's License [$50]</font>: Allows you to buy vehicles and legally drive them.<br />
					<font color='#00FF00'>2.) Boat License [$100]</font>: Allows you to buy and legally drive a boat.<br />
					<font color='#00FF00'>3.) Pilot's License [$2500]</font>: Allows you to buy Helicopters and legally fly them.<br />
					<font color='#00FF00'>4.) Truck License [$2000]</font>: Allows you to buy trucks and legally drive them.<br />
					<font color='#00FF00'>5.) Home Owners License [$10,000]</font>: Allows you to buy a house and personal garage.<br /><br />
					
					<font color='#FF0000'>--Purchasable at their Respective Processing Facilities</font>:<br />
					<font color='#00FF00'>1.) Meth Training [$2000]</font>: Allows you to process Ephedra, Hydrogen Sulphate, and Phosphorus into Meth.<br />
					<font color='#00FF00'>2.) Heroin Training [$1150]</font>: Allows you to process Heroin.<br />
					<font color='#00FF00'>3.) Marijuana Training [$600]</font>: Allows you to process Marijuana.<br />
					<font color='#00FF00'>4.) Cocaine Training [$1750]</font>: Allows you to process Cocaine.<br />
					<font color='#00FF00'>5.) Oil Processing [$1000]</font>: Allows you to process Oil into Refined Gasoline.<br />
					<font color='#00FF00'>6.) Diamond Processing [$1000]</font>: Allows you to process Diamonds.<br />
					<font color='#00FF00'>7.) Copper Processing [$650]</font>: Allows you to process Copper.<br />
					<font color='#00FF00'>8.) Iron Processing [$2000]</font>: Allows you to process Iron.<br />
					<font color='#00FF00'>9.) Sand Processing [$700]</font>: Allows you to process Sand into Glass.<br />
					<font color='#00FF00'>10.) Salt Processing [$750]</font>: Allows you to process Salt.<br />
					<font color='#00FF00'>11.) Cement Processing [$1150]</font>: Allows you to process rocks into cement.<br />
					<font color='#00FF00'>12.) Wood Processing [$1250]</font>: Allows you to process Wood into Lumber.<br />
					<font color='#00FF00'>13.) Gold Processing [$1850]</font>: Allows you to process Gold Ore into Gold Bars.<br />
					<font color='#00FF00'>14.) Steel Processing [$1250]</font>: Allows you to process Iron and Coal into Steel.<br /><br />
					
					<font color='#FF0000'>--Found at other places</font>:<br />
					<font color='#00FF00'>1.) Distillery Agreement [$950]</font>: Allows you to process Corn into Moonshine. Purchasable at the Distillery.<br />
					<font color='#00FF00'>2.) Minor Medical Training [$5000]</font>: Allows you to stablilize players with Health Kits. Purchasable at a Hospital.<br />
					<font color='#00FF00'>3.) Diver's License [$1000]</font>: Allows you to purchase Diving gear. Purchasable at the Diving Shop.<br />
					<font color='#00FF00'>4.) Firearms License [$2000]</font>: Allows you to purchase and legally hold firearms. Purchasable at the Gun Store. Revoked after an arrest.<br /><br />
					
					<font color='#FF0000'>--Can only have one of these at a time. Purchasing a different license will override the previous one</font>:<br />
					<font color='#00FF00'>1.) Gang Training [$7,500]</font>: Allows you to buy gang gear, weapons, vehicles, and clothing. Purchasable at a Gang Outpost.<br />
					<font color='#00FF00'>2.) Class 3 Weapons License [$10,000]</font>: Allows you to buy 5.56mm weapons and gear. Purchasable at Class 3 Weapons. Revoked after an arrest.<br />
					<font color='#00FF00'>3.) Bounty Hunter's License [$7,500]</font>: Allows you to buy Bounty Hunter gear, weapons, equipment, and clothing. Purchasable at Bounty Hunter Outpost. Revoked after an arrest.<br />
					
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Key Chain",
				"
					Every vehicle or house you own will have a place for a key in your Key Chain. To look at what keys you have, press Y and go press the Key Chain button. You can also share your keys with other persons. Sharing keys allows players to lock and unlock your vehicles and houses. This does not give ownership. Nobody can store your vehicle in the garage and get it into their garage.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Your First Car",
				"
					To get your first car, you will need a Driver's License. This license is available at the DMV. For more information on the DMV and licenses, read 'Licenses/Processing List'. To purchase a Driver's License, walk up to the DMV AI character and use the scroll wheel to interact.<br /><br />
					
					Once you have bought your Driver's License, open your map and locate the nearest car shop. The map legend is at the top left of the map. Head up to the Car Shop AI character and scroll wheel and open the car shop. Every vehicle can either be rented or bought permanently. Rented cars can not be saved into the garage and will be deleted upon server restart. If you purchase a vehicle permanently, you can store it in the garage. For more information on how the garage works, read the 'Garages' entry.<br /><br />
					
					Once you have picked a vehicle you like with a nice paint job, you can purchase the vehicle. Note: you need the money on your character to buy the vehicle.<br /><br />
					
					Every vehicle has a lock. To unlock your vehicle, press U. To lock it back up, press U again.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Taking Communications",
				"
					If you get zip-tied or arrested, your communications are ceased and you are not allowed to contact anyone. If you do contact people for help whilst your communications are ceased, you are 'breaking RP'.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Establishing Role Play (RP)",
				"
					Any time you wish to rob a person, shoot someone, or just simply have a friendly role play talk, you have to let the other person know what your intentions are and what you are going to do. This is also true for almost any RP interaction. <br /><br />
					
					In real life, you can just whack someone over the head and take all their money. This is a video game and we are all here to have fun. There is also the possibility of trolls on the server and the admins need a way of picking the trolls out and the players need to know they are going to be robbed or talked to, etc. A simple 'Put your hands up. This is a robbery.' will suffice for RP initiation. It is encouraged to add your own spice to the robbery as we are here to have fun. Originality keeps things fresh.<br /><br />
					
					Please read the rules on the forums at sealteamsloth.life to fully understand RP initiation.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Using the Cellphone",
				"
					To access your cellphone, press Y to open your personal menu. At the bottom right is a Cell Phone button. You can also open the cell phone by pressing shift+5. This is where you go to text any ingame player, the police, the admins, and the EMS. <br /><br />
					
					Spamming the admins and other players is not a good idea.
				"
		]
	];
	
	player createDiaryRecord["tutorial",
		[
			"Player Settings",
				"
					To change your view distance, press Y to open your personal menu. At the bottom there is a Settings button. Here you can slide toggle your view distance. This is also where you disable side chat and hide player tags.
				"
		]
	];
	
	player createDiaryRecord["tutorial",
		[
			"Syncing Player Data",
				"
					To forcefully sync your player data to the database, press Y to open your personal menu. At the bottom left there is a Sync Data button. It is a always a good idea to force sync your data before logging off. It is also a good practice to sync your data after any big purchase or when you are dealing with a significant money gain from a task.<br /><br />
					
					If any sync issues cause your belongings to be lost, file a compensation request on the forums at sealteamsloth.life. Please write down the time this occurred and, if you remember, the last time you logged off. Also write down your timezone. It is also sometimes necessary to give a backstory or a brief idea of what happened. <br /><br />
					
					The admins have to search through the logs by hand and any help that speeds up the process is beneficial to you and the admins.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Hunger, Thirst, and Health",
				"
					You can monitor your hunger, thirst, and health at the bottom right of your screen. You can only heal yourself if you have health below 75. To feed yourself or drink water, press Y to open your personal menu. Select the food item or water bottle and press Use. If you go too long without water or food, you will die. Read about death in the tutorial labelled 'Death'.<br /><br />
					
					If you go to a hospital, you can seek medical attention and get fully healed. You can also revive incapacitated players here. It costs $10 to do so.
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Your Bank and Inventory",
				"
					Your bank account balance, all virtual items, Houses, Personal Garages, and everything on your Arma 3 character is saved into a database. Any time you log off, your data is saved and synced into the database. I encourage you to read the next entry on syncing player data after you have read this entry.<br/><br/>
					
					To access your bank account, open the map and look for the ATM symbol. The map legend is at the top left of the map. There are several unmarked ATM's across Altis. Go to the nearest one and scroll wheel when you are next to it. Middle click the ATM option. Here you can deposit, withdraw, and wire transfer your bank account's money. No player can access your bank account except you. This is also the place to deposit money into your gang's account. No money can be taken out of your gang's account once deposited. <br /><br />
					
					Be aware that every wire transfer has a percent fee tied to it. 
				"
		]
	];
	player createDiaryRecord["tutorial",
		[
			"Introduction",
				"
					Welcome to the Seal Team Sloth server.<br /><br />
					
					Read the Rules. Ignorance is no excuse when you are in trouble with the admins.<br /><br />
					
					Altis Life is full of features scattered all across the map. There is a map legend at the very top left of the map. To access your wallet and personal menu, press Y. This shows all the licenses you have, your bank account balance (the house symbol), how much money you have on your character (the cash symbol), and the items in your inventory. This is also where you join, manage, and leave gangs, as well as access your cell phone and see what keys you have. All players get the same starting amount of cash in their bank accounts. <br/><br/>
					In the upper right corner is your virtual item capacity or carry weight. Every virtual item in Altis Life has a fixed weight. If you purchase a Backpack, the maximum weight you can carry will increase. <br/><br/>
					
					The number input bar with initial value 1 below your bank account balance allows you to give other players money in game without a fee. This will only transfer the money on your character. Using the selection bar beneath the input bar you can select a name to send it to. Only players near you will be selectable.<br/><br/>
					
					The other number input bar and name selection bar beneath Current Items does the same thing, except explicitly for items.<br/><br/>
					To remove items from your inventory, select an item from your Current Items list and press the Remove Button. Caution: You will not be able to pick the item back up! Some items are usable such as cocaine or a pickaxe. To use them, select the item and press the Use button.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["serverrules",
		[
			"STS Commandments", 
				"
				Admin decisions are final and must be obeyed without exception.<br/>
				Don't be a dick.<br/>
				No racism.<br/>
				All players must hold value to their life at all times.<br/>
				During roleplay, remain in character at all times.<br/>
				You shall not camp near ANY safe-zones.<br/>
				You shall not powergame or abuse glitches to gain an unfair advantage.<br/>
				If restrained before a restart, always return to the area and notify other participants.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord["serverrules",
		[
			"Safe Zones",
				"
					Roleplay cannot be initiated in safe zones.<br/><br/>
					
					Entering the Police HQ(airport) to check bounty does not exempt you from being arrested if the police ask you to leave.<br/>
					An engagement or Roleplay can be carried over to the safe zone areas, at which point they are no longer safe.<br/>
					Threatening or baiting others in safe-zones can be determined as initiation and may result in your death if considered a legitimate threat.<br/>
					Do not camp the jail’s spawn point with intent to initiate on a player fresh out of prison.<br/><br/>

				"
		]
	];
						
	player createDiaryRecord ["serverrules",
		[
			"Civilian/Criminal Guidelines", 
				"
				Do not spam other players with vehicle/house purchase offers.<br/>
				Civilians may not obstruct a medic’s job in attempts to force their enemy to bleed out - buy a lethal injection if you want to kill them!<br/>
				Civilians must have a legitimate roleplay reason in order to lethally inject a player.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["serverrules",
		[
			"Cop/ALE Guidelines", 
				"
				Active engagements taking place near a Police HQ must be completed before Officers may finalize arrests.<br/>
				ALE members may not be logged in AFK.<br/>
				All officers must be on TeamSpeak, in the respective police channels at all times when assuming the role of the ALE on the STS Life Server.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["serverrules",
		[
			"Civilian/Criminal Guidelines", 
				"
				Do not spam other players with vehicle/house purchase offers.<br/>
				Civilians may not obstruct a medic’s job in attempts to force their enemy to bleed out - buy a lethal injection if you want to kill them!<br/>
				Civilians must have a legitimate roleplay reason in order to lethally inject a player.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["serverrules",
		[
			"Vehicles", 
				"
				Vehicular deathmatching (VDM): the use of vehicles as a weapon, deliberately running people over<br/>
				Deliberately positioning yourself to get run over.<br/>
				Ramming another vehicle or structure in order to cause an explosion<br/>
				Stealing a vehicle purely to damage or destroy it.<br/>
				Exploiting the lock/unlock system to get into a vehicle before the owner can prevent it.<br/>
				Repeatedly flying aircraft below 150m altitude in built up areas/above cities.<br/>
				Abusing the Push Boat function to grief or cause damage.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["serverrules",
		[
			"Communication Rules", 
				"
				The responsibility falls upon you to have creative, good communications at all times.<br/><br/>
				
				Prior to any engagement, you must give a player at least 10 seconds to comply.<br/>
				You are exempt from the above only if the player is a clear threat on your life.<br/>
				You may not engage the pilot of an aircraft without first attempting to communicate with them via in-game cellphone usage.<br/>
				Do not misuse the direct message system (CTRL+T) as a lazy means to identify another player.<br/>
				Do not use Sidechat to convey in-character information.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["serverrules",
		[
			"Random Deathmatching (RDM)", 
				"
				RDM (Random Deathmatching) is strictly forbidden and must be avoided. Disobeying this rule may result in administrative action being taken.<br/><br/>
				
				You may only engage in combat with a player once a reasonable roleplay has been established.  <br/>
				Players may only engage one another lethally if they pose an immediate threat or are engaged in an ongoing role-play scenario.<br/>
				No player is assumed to be involved in an RP. Unless you were involved in the first contact, you must initiate RP before participating. This includes providing backup for your fellow gang members.<br/>
				You must contact or communicate with your victim and convey demands (robbery, kidnapping, etc.) before shooting OR knocking them out/using violent measures against them.<br/>
				Warning shots cannot be used to engage in RP.<br/>
				You may not shoot another player’s vehicle with intent to destroy it.<br/>
				Camping hospital/surrounding areas or repeatedly reviving other players in combat is not permitted.<br/><br/>
				"
		]
	];
	player createDiaryRecord ["serverrules",
		[
			"New Life Rule", 
				"
				The New Life Rule applies to police and civilians.<br/><br/>
				
				Items on this list may result in your removal from the server and/or ban, based on the admins discretion.<br/><br/>

				1. If you are killed you must wait 15 minutes before returning to the vicinity of your death.<br/>
				2. If you die during roleplay, you can not seek revenge.<br/>
				3. If you are RDM'd, it is not a new life.<br/>
				4. If you manually respawn, it is not a new life.<br/>
				5. If you purposefully kill yourself to avoid roleplay, it is not a new life.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["serverrules",
		[
			"Forbidden Actions", 
				"
				The following actions are forbidden, if witness to the following, contact an admin immediately:<br/>
				Cheating, usage of foreign scripts.<br/>
				Usage or possession of gear, items, or vehicles that otherwise would not be available eg. glitched gear.<br/>
				Disconnecting, aborting or killing oneself to avoid roleplay outside of restraints or being critically wounded.<br/>
				Vehicular combat storing - garaging a vehicle during an active role play in which you have the potential to lose said vehicle or its contents.<br/>
				Do not scam, grief, or bait someone into breaking the rules.<br/>
				Possession of cheated/exploited cash.<br/>
				Abusing bugs/animations/errors to gain any advantage, including shooting from shorelines/reeds.<br/>
				Harassing players outside of role-play scenario.<br/>
				Camping hospital/surrounding areas or excessively reviving oneself or another player in combat.<br/>
				Rape RP and/or racism of any kind. <br/>
				Advertising other communities while using STS services.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["serverrules",
		[
			"Full Rules", 
				"
				The full and most up to date list of rules is located on our website at sealteamsloth.life<br/>
				If any contradiction exists, the rules posted on our website supersede any elsewhere.<br/><br/>
				"
		]
	];
	
/* Police Section */

/* too much effort to keep this shit updated

	player createDiaryRecord ["policerules",
		[
			"Crisis Negotiation",
				"
				Crisis Negotiation must be handled by a Sergeant. If one is not available, the person with the next highest rank must handle the situation.<br/><br/>
				"
		]
	];
	player createDiaryRecord ["policerules",
		[
			"The Federal Reserve",
				"
				1. The Federal Reserve is illegal for civilians to enter, unless they have been given authorization. If civilians enter without authorization they are to be escorted off-site or arrested if they persist.
				2. Helicopters flying over the Federal Reserve may be asked to leave and disabled if they refuse.<br/>
				2. If the Federal Reserve is getting robbed, it is encouraged that all available officers move in to stop it.<br/>
				3. Nearby officers should immediately head to the Federal Reserve to assist. Petty crimes can be dropped during a robbery.<br/>
				4. Lethal force on bank robbers may be used if no other alternative is available. Every option to taze and arrest the person should be made first.<br/>
				5. Police may not fire blindly into the building.<br/>
				6. The police should evacuate the civilians from the building during a robbery.<br/>
				7. Any civilian who actively makes an attempt to block the police from entering the building may be treated as an accomplice.<br/>
				8. Supervisory officers may hire individuals or contract a group of people to work as security guards for the bank. See 'Contracting' section for more information.<br/><br/>
				"
		]
	];
	player createDiaryRecord ["policerules",
		[
			"Aviation",
				"
				1. No helicopter can land within city limits without authorization from the highest ranking officer online. (Exceptions being what is listed below.)<br/>
				Kavala: The hospital helipad (037129) or docks (031128).<br/>
				Athira: The sports field (138185) or behind the DMV (140188).<br/>
				Pyrgos: The fields North/East of DMV (170127)<br/>
				Sofia: Opposite the car shop (258214) or the fields Southeast of the garage (257212)<br/>
				Small towns: An appropriate location may be chosen. This is to be judged by officers on a case by case basis.<br/><br/>
				
				2. Helicopters may not land on roads.<br/>
				3. Police may temporarily forbid landing at  but it cannot remain closed for a long period of time.<br/>
				4. Helicopters cannot fly below 150m over the city without authorization.<br/>
				5. Helicopters cannot hover over the city. Cops may only hover over the city if there is an active police operation going on.<br/><br/>

				"
		]
	];
	
	player createDiaryRecord ["policerules",
		[
			"Illegal Areas", 
				"
				1. Gang areas are not considered illegal. Thus a cop may enter without a raid, but may not restrain or stop anyone inside without probable cause/illegal activity. (Talking to the gang NPC is NOT probable cause/illegal activity.)<br/>
				2. Do not enter an illegal area unless it is part of a raid. see Raiding/Camping.<br/>
				3. If you chase someone into an illegal area, call for backup.<br/>
				4. Under no circumstances is an officer allowed to camp any illegal area, although sting operations are allowed in special circumstances.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["policerules",
		[
			"Patrolling", 
				"
				1. Police may patrol the island's roads and towns searching for abandoned vehicles and criminal activity.<br/>
				2. Patrols can be done on foot inside of a town, or in a vehicle when outside.<br/>
				3. Patrols do not include illegal areas. See Raiding/Camping.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["policerules",
		[
			"Checkpoints", 
				"
				Cops are encouraged to setup checkpoints in strategic areas to help combat illegal activity and promote safety on the road.<br/><br/>
				
				1. A checkpoint must consist of 3 or more officers, utilizing 2 or more vehicles. An ATV does not count as one of the required vehicles, but may still be used.<br/>
				2. A checkpoint can not be setup within 300m of an illegal area. Basically, you cannot set one up on top of an illegal area.<br/>
				3. Checkpoints may only be setup on roads, but it does not have to be on a crossroad.<br/>
				4. Checkpoints do not have to be marked on the map.<br/>
				5. With the new ability to build customized checkpoints, cops are expected to use these new tools responsibly.<br/>


				Proper Checkpoint Procedure:<br/>
				1. Have the driver stop the vehicle at a safe distance and turn off the engine.<br/>
				2. Ask the driver and any passengers if they have any weapons.<br/>
				3. Ask the driver and any passengers to exit the vehicle. If they have weapons, do not immediately restrain them when they get out, tell them to lower their weapons and given them a reasonable amount of time to do so.<br/>
				4. Ask them where they are headed to and from.<br/>
				5. Ask if they will submit to a search.<br/>
				6. If they allow a search, you may restrain them and search them.<br/>
				7. If they do not submit to a search, you must let them go, unless there is probable cause.<br/>
				8. After the search is done, you may allow them to re-enter their vehicle and drive away.<br/>
				9. In case anything illegal is found, the person may be ticketed or arrested depending on the crime.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["policerules",
		[
			"Vehicles", 
				"
				1. Vehicles in the parking lot, or are reasonably parked elsewhere should be left alone.<br/>
				2. Vehicles that look abandoned, broken, with no driver, can be impounded.<br/>
				3. Boats should be parked reasonably on shore.<br/>
				4. Any vehicle that hasn't moved in a significant amount of time may be impounded.<br/>
				5. Impounding is an essential job for a cop, it helps keep the server clean and less laggy.<br/>
				6. If in doubt, always search the vehicle and message the owner(s) before impounding.<br/>
				7. Police speedboats or Ghosthawks may be used to assist in apprehending criminals. The weapon should be used to disable vehicles, not to blow them up.<br/>
				8. Illegal vehicles may be crushed, otherwise normally legal vehicles may only be crushed if they are involved in a serious crime.<br/><br/>
				"
		]
	];

	player createDiaryRecord ["policerules",
		[
			"Speeding", 
				"
				The following speeds are to be enforced by the Altis Police Force for the absolute safety of the citizens of Kavala and all travelling beyond the city.<br/><br/>
				
				Inside major cities:<br/>
				Small roads: 55km/h<br/>
				Main roads: 70km/h<br/>
				Outside major cities:<br/>
				Small roads: 90km/h<br/>
				Main roads: 120km/h<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["policerules",
		[
			"City Protocol", 
				"
				1. Officers may patrol major cities - Kavala, Athira, Pyrgos and Sofia.<br/>
				2. Officers may stop by the car shop to make sure there are no cars that need to be impounded.<br/>
				3. Officers may not stand around or loiter in the centre of town.<br/>
				4. Officers may enter the town in a large number should a rebellious act occur. After the area is clear, they need to leave the town again.<br/>
				5. Martial law may not be declared at any time.<br/>
				6. The Police HQ areas are illegal for civilians to enter without authorization, however it is NOT illegal for civilians to be nearby unless they are causing a nuisance.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["policerules",
		[
			"Arresting and Ticketing",
				"
				Arresting should be done to criminals who are considered a danger to themselves or others.<br/><br/>

				1. You may not arrest someone if you have given them a ticket and they paid it.<br/>
				2. You must tell the suspect why they are being arrested before you arrest them.<br/>
				3. If a civilian is wanted for jail-able offences, you may arrest them. Do not kill them, unless the situation falls under the 'Use of Lethal Force' section.<br/><br/>


				Ticketing a civilian is considered a warning for the civilian. If they break a law, but do not pose a threat to anyone, you may ticket a civilian.<br/><br/>

				1. Tickets must be a reasonable price.<br/>
				2. Ticket prices should be based off of the crimes committed.<br/>
				3. Refusal to pay a legit ticket is grounds for arrest.<br/>
				4. Giving a civilian and illegitimate ticket, higher than the prescribed cap(set by the superintendent), is not allowed and will result in your removal from the police department.<br/><br/>
				
				A complete list of all crimes and the appropriate punishments should be given to officers during training. If in doubt, or if you have not been trained, ask a higher ranking officer what to do.<br/><br/>
				
				The list is available on the police spreadsheet, see your CO for details.<br/><br/>
				"
		]
	];
		
	player createDiaryRecord ["policerules",
		[
			"Weapons", 
				"
				A cop is NEVER allowed to supply civilians with weapons. This will get you banned from the server and removed from being a cop.<br/><br/>

				Legal Weapons for Civilians to carry with a permit:<br/>
				1. P07<br/>
				2. Rook<br/>
				3. ACP-C2<br/>
				4. Zubr<br/>
				5. 4-five<br/>
				6. PDW2000<br/><br/>
				
				Legal Weapons for Civilians to carry with a CLASS 3 permit:<br/>
				1. MK20 series<br/>
				2. TRG series<br/>
				3. SDAR <br/>
				Note that these are otherwise considered illegal<br/><br/>

				Any other weapon (Including Silenced P07 [Considered a Police Weapon]) is illegal.<br/><br/>

				1. Civilians are not allowed to have a weapon out within the town limits.<br/>
				2. Civilians may have a gun out when they are not in the town. However they should submit to a license search if confronted by an officer and should have the gun lowered (Press Ctrl Twice).<br/>
				3. Use of a suppressor on any gun other than the PO-7 is against server rules.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["policerules",
		[
			"Use of Non-Lethal Force",
				"
				Nonlethal force includes rubber bullets from the sting, SDAR, or police rifles as well as Tazer ammunition for PO-7/SDAR<br/><br/>

				1. Taser should be used to incapacitate non complying civilians in order to restrain them.<br/>
				2. Do not discharge your weapon unless you intend to incapacitate a civilian, randomly discharging your weapon will result in your suspension.<br/>
				3. Only use your Taser in compliance with the laws and the rules, do NOT enforce your will on others.<br/>
				4. Rubber bullets are not to be used against unarmed civilians.
				5. Lethal bullets may not be used under any circumstances unless there is a credible threat to multiple police lives.<br/>
				Unless there is a gang army all armed with rifles against you, do not KILL your opponents.<br/><br/>
				"
		]
	];

	player createDiaryRecord ["policerules",
		[
			"Raiding/Camping",
				"
				Raiding is defined as a squad of police officers invading an area of high criminal activity in order to stop the criminals in illegal acts.<br/><br/>

				1. In order to raid an area, the cops must have at least 4 officers involved, one of which must be a Sergeant or above.<br/>
				2. All civilians in a raid area may be restrained and searched. If nothing illegal is found, you must let them go.<br/>
				3. If illegals are found during a search, you may proceed to arrest or fine as usual.<br/>
				5. Lethal force is only authorized as described under 'Use of Lethal Force'.<br/>
				6. After the area is secure, the officers must leave the area.<br/>
				7. An area cannot be raided again for 20 minutes after a previous raid.<br/>
				8. If the raid is a failure (All officers die), the 20 minute timer still applies to those officers.<br/>
				9. Backup may be called in, but it may not consist of fallen officers (see 'New Life Rule').<br/><br/>

				Camping is defined as the prolong stay of an officer in an area.<br/><br/>

				1. Checkpoints are not considered camping. See Checkpoint section for a definition of proper checkpoint procedures.<br/>
				2. Camping of illegal areas is staying longer than needed after a raid, or if officers do not conduct a raid but continue to watch and take action against civilians entering the area.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["policerules",
		[
			"Chain of Command",
				"
				The highest ranking officer on duty is in charge of the police force outside of admins currently online. The high ranking officer is expected to follow the rules and guidelines of his/her rank, and must report to the admin in case any action need be taken.<br/><br/>

				Police Chain of Command:<br/>
				1. Superintendent<br/>
				2. Deputy Superintendent<br/>
				3. Captain<br/>
				4. Lieutenant<br/>
				5. Sergeant<br/>
				6. Senior Patrol Officer<br/>
				7. Patrol Officer<br/>
				8. Cadet<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["policerules",
		[
			"Use of Lethal Force",
				"
				1. Use of Lethal force is only permitted for the protection of your life, another officers life, or a civilians life, if and only if non-lethal force would not be effective.<br/>
				2. Discharging of a weapon when not under threat or not during training exercises is not allowed. Officers caught in violation of this rule will be removed from the server and suspended from the ALE.<br/>
				3. Failure to follow proper weapons discipline and procedure will get you removed from the server and suspended from the ALE.<br/><br/>
				"
		]
	];
	
	player createDiaryRecord ["policerules",
		[
			"Teamspeak Rule",
				"
				1. All cops must be on Teamspeak 3 in a designated cop channel. Failure to be on Teamspeak during an admin check will result in your immediate dismissal from the server.<br/>
				2. Please join Teamspeak BEFORE you spawn in as a cop, heck, join Teamspeak before you even join the server.<br/><br/>
				"
		]
	]; */
	
	
	
/* Illegal Items Section */
		player createDiaryRecord ["illegalitems",
		[
			"Illegal Vehicles",
				"
				A civilian in control of the following prohibited vehicles is subject to the consequences defined in the unauthorized control of a prohibited vehicle law.<br/><br/>

				Any MRAP<br/>
				Armed Offroad<br/>
				Any marked police vehicle<br/><br/>
				"
		]
	];
	player createDiaryRecord ["illegalitems",
		[
			"Illegal Weapons",
				"
				The Firearms License or Class III Weapons License allow you to possess handguns or pistols in the following calibres:<br/>
				9mm<br/>
				.45<br/>
				Starter pistol<br/>
				and sub-machine guns in the following calibres:<br/>
				9mm<br/><br/>
				
				Possession of a Class III Weapons License also permits the possession of the following firearms:<br/>
				Mk20C 5.56mm rifle<br/>
				Mk20 5.56mm rifle<br/>
				TRG-20 5.56mm rifle<br/>
				TRG-21 5.56mm rifle<br/>
				SDAR 5.56mm rifle (using dual purpose ammunition)<br/>
				Vermin .45 SMG<br/>
				MXC 6.5mm rifle (tan)<br/><br/>
				
				Possession of a Bounty Hunting License allows the possession of the following firearms:<br/>
				P07 9mm pistol (silenced)<br/>
				SDAR 5.56 mm rifle (using dual purpose ammunition)<br/>
				Starter pistol<br/><br/>
				"
		]
	];
	player createDiaryRecord ["illegalitems",
		[
			"Illegal Items",
				"
				Cannabis<br/>
				Marijuana (5 items or more)<br/>
				Opium<br/>
				Heroin<br/>
				Coca Leaves<br/>
				Cocaine<br/>
				Moonshine<br/>
				Turtle Meat<br/>
				Small Male Crabs<br/>
				Pregnant Female Crabs<br/>
				Spike Strips<br/>
				Lethal Injections<br/>
				Lockpicks<br/>
				Zipties<br/>
				Meth<br/>
				Meth precursors<br/><br/>
				"
		]
	];
	player createDiaryRecord ["illegalitems",
		[
			"Speed Limits",
				"
				The speed limits for the roads of Altis are as follows:<br/>
				Minor roads within town: 45km/h<br/>
				Major roads within town: 65km/h<br/>
				Main road within in town: 75km/h<br/>
				Main road outside of town: 115km/h<br/>
				Major roads outside of town: 80km/h<br/>
				Dirt roads: 75km/h<br/><br/>
				"
		]
	];
	player createDiaryRecord ["illegalitems",
		[
			"Full Laws",
				"
				The full and most up to date list of laws is located on our website at sealteamsloth.life<br/>
				If any contradiction exists, the rights and laws posted on our website supersede any elsewhere.<br/><br/>
				"
		]
	];
	
/* Controls Section */
	player createDiaryRecord ["controls",
		[
			"Player Controls",
				"
				Y: Open Player Menu<br/>
				2: Surrender<br/>
				O: (Cop) opens police gates.
				U: Lock and unlock cars<br/>
				F: Siren (Cop/Medic)<br/>
				T: Vehicle Trunk<br/>
				Left Shift + R: Restrain<br/>
				Left Shift + H: Holster Weapon, CTRL + H to Unholster<br/>
				Left Shift + G: Knock out / stun (Civ Only, used for robbing)<br/>
				Left Windows: Main Interaction Key, can be rebound to Custom Action 10<br/>
				Left Shift + L: Activates cop siren lights (as a cop).<br/>
				Left Shift + 5: Pulls up the cell phone<br/>
				Custom Actions 1,2,3: Player animations (#2 requires handgun)<br/>
				Custom Action 5: Cruise Control in vehicle<br/>
				Custom Action 6: (Cop): Designate vehicle unit while inside vehicle<br/>
				Custom Action 7: (Cop): Speed Radar<br/>
				Custom Action 9: (Cop): Deploys a spikestrip if available.<br/>
				Custom Action 11: Decrease sound volume to 10% or increase back to 100% (helpful for holding conversations)<br/>
				Custom Action 12: Text the player or driver of the vehicle you are looking at (cursorTarget)<br/>
				Custom Action 13: (Cop): Honk the police horn.<br/>	
				CTRL+R: Mag Repacking<br/>	
				"
		]
	];