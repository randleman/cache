// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: init.sqf
//	@file Author: [K-TTT] Randleman

// FISHES ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
MF_ITEMS_FISH_SALEMA = "salema";
MF_ITEMS_FISH_ORNATE = "ornate";
MF_ITEMS_FISH_MACKEREL = "mackerel";
MF_ITEMS_FISH_TUNA = "tuna";
MF_ITEMS_FISH_MULLET = "mullet";
MF_ITEMS_FISH_CATSHARK = "catshark";

[MF_ITEMS_FISH_SALEMA, "Fish (Salema)", {25 call mf_items_survival_eat}, "Salema_F","client\icons\animals\animal_salema.paa", 5] call mf_inventory_create;
[MF_ITEMS_FISH_ORNATE, "Fish (Ornate)", {20 call mf_items_survival_eat}, "Ornate_random_F","client\icons\animals\animal_ornate.paa", 5] call mf_inventory_create;
[MF_ITEMS_FISH_MACKEREL, "Fish (Mackerel)", {40 call mf_items_survival_eat}, "Mackerel_F","client\icons\animals\animal_mackerel.paa", 5] call mf_inventory_create;
[MF_ITEMS_FISH_TUNA, "Fish (Tuna)", {70 call mf_items_survival_eat}, "Tuna_F","client\icons\animals\animal_tuna.paa", 5] call mf_inventory_create;
[MF_ITEMS_FISH_MULLET, "Fish (Mullet)", {45 call mf_items_survival_eat}, "Mullet_F","client\icons\animals\animal_mullet.paa", 5] call mf_inventory_create;
[MF_ITEMS_FISH_CATSHARK, "Fish (Catshark)", {50 call mf_items_survival_eat}, "CatShark_F","client\icons\animals\animal_catshark.paa", 5] call mf_inventory_create;

// RABBIT ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
MF_ITEMS_RABBIT = "rabbit";

[MF_ITEMS_RABBIT, "Rabbit", {25 call mf_items_survival_eat}, "Rabbit_F","client\icons\animals\animal_rabbit.paa", 5] call mf_inventory_create;

// SNAKE ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
MF_ITEMS_SNAKE = "snake";

[MF_ITEMS_SNAKE, "Snake", {10 call mf_items_survival_eat}, "Snake_random_F","client\icons\animals\animal_snake.paa", 5] call mf_inventory_create;

// TURTLE ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
MF_ITEMS_TURTLE = "turtle";

[MF_ITEMS_TURTLE, "Turtle", {25 call mf_items_survival_eat}, "Turtle_F","client\icons\animals\animal_turtle.paa", 5] call mf_inventory_create;

/// ------> NOT NEEDED NOW - MAYBE IN FUTURE :P 
// FOWL ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
MF_ITEMS_FOWL_HEN = "chickenhen";
MF_ITEMS_FOWL_COCK = "chickencock";

[MF_ITEMS_FOWL_HEN, "Chicken (Hen)", {55 call mf_items_survival_eat}, "Hen_random_F","client\icons\animals\animal_hen.paa", 3] call mf_inventory_create;
[MF_ITEMS_FOWL_COCK, "Chicken (Cock)", {60 call mf_items_survival_eat}, "Cock_random_F","client\icons\animals\animal_cock.paa", 3] call mf_inventory_create;

// DOG "FIN" ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
MF_ITEMS_DOG_SAND = "dogsand";
MF_ITEMS_DOG_BLACKWHITE = "dogblackwhite";
MF_ITEMS_DOG_ORCHERWHITE = "dogocherwhite";
MF_ITEMS_DOG_TRICOLOUR = "dogtricolour";
MF_ITEMS_DOG_RANDOM = "dograndom";

[MF_ITEMS_DOG_SAND, "Dog (Sand)", {25 call mf_items_survival_eat}, "Fin_sand_F","client\icons\animals\animal_dogsand.paa", 1] call mf_inventory_create;
[MF_ITEMS_DOG_BLACKWHITE, "Dog (Blackwhite)", {25 call mf_items_survival_eat}, "Fin_blackwhite_F","client\icons\animals\animal_dogblackwhite.paa", 1] call mf_inventory_create;
[MF_ITEMS_DOG_ORCHERWHITE, "Dog (Ocherwhite)", {25 call mf_items_survival_eat}, "Fin_ocherwhite_F","client\icons\animals\animal_dogocherwhite.paa", 1] call mf_inventory_create;
[MF_ITEMS_DOG_TRICOLOUR, "Dog (Tricolour)", {25 call mf_items_survival_eat}, "Fin_tricolour_F","client\icons\animals\animal_dogtricolour.paa", 1] call mf_inventory_create;
[MF_ITEMS_DOG_RANDOM, "Dog (Random)", {25 call mf_items_survival_eat}, "Fin_random_F","client\icons\animals\animal_dogsand.paa", 1] call mf_inventory_create;

// DOG "ALSATIAN" ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
MF_ITEMS_ALSATIAN_BLACK = "alsatianblack";
MF_ITEMS_ALSATIAN_RANDOM = "alsatianrandom";
MF_ITEMS_ALSATIAN_SAND = "alsatiansand";
MF_ITEMS_ALSATIAN_SANDBLACK = "alsatiansandblack";

[MF_ITEMS_ALSATIAN_BLACK, "Alsatian (Black)", {25 call mf_items_survival_eat}, "Alsatian_Black_F","client\icons\animals\animal_alsatianblack.paa", 1] call mf_inventory_create;
[MF_ITEMS_ALSATIAN_RANDOM, "Alsatian (Random)", {25 call mf_items_survival_eat}, "Alsatian_Random_F","client\icons\animals\animal_alsatianblack.paa", 1] call mf_inventory_create;
[MF_ITEMS_ALSATIAN_SAND, "Alsatian (Sand)", {25 call mf_items_survival_eat}, "Alsatian_Sand_F","client\icons\animals\animal_alsatiansand.paa", 1] call mf_inventory_create;
[MF_ITEMS_ALSATIAN_SANDBLACK, "Alsatian (Sandblack)", {25 call mf_items_survival_eat}, "Alsatian_Sandblack_F","client\icons\animals\animal_alsatiansandblack.paa", 1] call mf_inventory_create;

// GOAT ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
MF_ITEMS_GOAT = "goat";

[MF_ITEMS_GOAT, "Goat", {75 call mf_items_survival_eat}, "Goat_random_F","client\icons\animals\animal_goat.paa", 1] call mf_inventory_create;

// SHEEP ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
MF_ITEMS_SHEEP = "sheep";

[MF_ITEMS_GOAT, "Sheep", {80 call mf_items_survival_eat}, "Sheep_random_F","client\icons\animals\animal_sheep.paa", 1] call mf_inventory_create;	
