// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: catchFish.sqf 
//	@file Author: Tonic, [K-TTT] Randleman

private["_animal","_type", "_animalName"];
_animal = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(!(_animal isKindOf "Animal_Base_F")) exitWith {titleText ["no animal found", "PLAIN DOWN", 0.5];}; 
if(player distance _animal > 3.5) exitWith {titleText ["too far away", "PLAIN DOWN", 0.5];};

switch(true) do
{
	// FISHES
	case ((typeOf _animal) == "Salema_F"): 				{_type = "salema"; 			_animalName = "Fish (Salema)";};
	case ((typeOf _animal) == "Ornate_random_F") : 		{_type = "ornate"; 			_animalName = "Fish (Ornate)";};
	case ((typeOf _animal) == "Mackerel_F") : 			{_type = "mackerel"; 		_animalName = "Fish (Mackerel)";};
	case ((typeOf _animal) == "Tuna_F") : 				{_type = "tuna"; 			_animalName = "Fish (Tuna)";};
	case ((typeOf _animal) == "Mullet_F") : 			{_type = "mullet"; 			_animalName = "Fish (Mullet)";};
	case ((typeOf _animal) == "CatShark_F") : 			{_type = "catshark"; 		_animalName = "Fish (Catshark)";};
	// RABBIT
	case ((typeOf _animal) == "Rabbit_F") : 			{_type = "rabbit"; 			_animalName = "Rabbit";};
	// SNAKE
	case ((typeOf _animal) == "Snake_random_F") : 		{_type = "snake"; 			_animalName = "Snake";};
	// TURTLE
	case ((typeOf _animal) == "Turtle_F") : 			{_type = "turtle"; 			_animalName = "Turtle";};
	// FOWL
	case ((typeOf _animal) == "Hen_random_F") : 		{_type = "chickenhen"; 		_animalName = "Chicken Hen";};
	case ((typeOf _animal) == "Cock_random_F") : 		{_type = "chickencock"; 	_animalName = "Chicken Cock (random)";};
	// DOG "FIN"
	case ((typeOf _animal) == "Fin_sand_F") : 			{_type = "dogsand"; 		_animalName = "Dog (Sand)";};
	case ((typeOf _animal) == "Fin_blackwhite_F") : 	{_type = "dogblackwhite"; 	_animalName = "Dog (Blackwhite)";};
	case ((typeOf _animal) == "Fin_ocherwhite_F") :		{_type = "dogocherwhite"; 	_animalName = "Dog (Ocherwhite)";};
	case ((typeOf _animal) == "Fin_tricolour_F") : 		{_type = "dogtricolour"; 	_animalName = "Dog (Tricolour)";};
	case ((typeOf _animal) == "Fin_random_F") : 		{_type = "dograndom";	 	_animalName = "Dog (Random)";};
	// DOG "ALSATIAN"
	case ((typeOf _animal) == "Alsatian_Black_F") : 	{_type = "alsatianblack"; 	_animalName = "Alsatian (Black)";};
	case ((typeOf _animal) == "Alsatian_Random_F") :	{_type = "alsatianrandom"; 	_animalName = "Alsatian (Random)";};
	case ((typeOf _animal) == "Alsatian_Sand_F") : 		{_type = "alsatiansand"; 	_animalName = "Alsatian (Sand)";};
	case ((typeOf _animal) == "Alsatian_Sandblack_F") :	{_type = "alsatiansandblack";_animalName = "Alsatian (Sandblack)";};
	// GOAT
	case ((typeOf _animal) == "Goat_random_F") : 		{_type = "goat"; 			_animalName = "Goat";};
	// SHEEP
	case ((typeOf _animal) == "Sheep_random_F") : 		{_type = "sheep"; 			_animalName = "Sheep";};
	// DEFAULT	
	default {_type = ""};
};

if(_type == "") exitWith {titleText ["no item type", "PLAIN DOWN", 0.5];}; 

if(true) then {
	if (_type call mf_inventory_is_full) then {
		titleText[format["Can't take anymore %1 to inventory!",_animalName], "PLAIN DOWN", 0.5];
	} else {
			[_type, 1] call mf_inventory_add;
			deleteVehicle _animal;
			titleText[format["You catched a %1",_animalName], "PLAIN DOWN", 0.5];
			};
};