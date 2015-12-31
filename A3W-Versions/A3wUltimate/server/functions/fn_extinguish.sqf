// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: fn_extinguish.sqf
//	@file Author: [K-TTT] Randleman


private ["_wreck", "_wreckPos", "_unit", "_waterArray", "_smoke", "_smokeMore", "_water", "_salvageMoney", "_money", "_time", "_waterParticleCircle", "_extinguisherObject"];

_wreck = _this select 0;
_wreckPos = _this select 1;
_unit = _this select 2;
_waterParticleCircle = _this select 3;
_time = _this select 4;
_money = _this select 5;

EXTINGUISH_DONE = false;

//Spawn Extinguisher and put in "LeftHand"
		_extinguisherObject = "Land_FireExtinguisher_F" createVehicle [0,0,0];
		_extinguisherObject attachTo [_unit,[0,0,0],"lefthand"];

_waterArray = [
			["\A3\data_f\ParticleEffects\Universal\smoke.p3d", 1, 0, 1],
			"", 
			"Billboard",
			1, 
			3, 
			[0, 0, 0.1], 
			[0,0,5], 
			1, 
			75, //25,
			10, //10,
			0.5, //0.01,
			[1, 1, 5], //[0.1, 1.5, 5],
			[ 
			[1.55, 1.65, 1.00, 0.01], //[0.55, 0.65, 1.00, 0.01],
			[0.55, 0.65, 1.00, 0.05], //[0.55, 0.65, 1.00, 0.05],
			[1.30, 1.35, 1.40, 1.01], //[0.30, 0.35, 0.40, 0.01], 
			[0.00, 0.00, 0.00, 0.00]  //[0.00, 0.00, 0.00, 0.00]  
			],
			[0],
			0,
			0,
			"",
			"",
			_wreckPos,
			0, 
			true, 
			0.5, //0.03,
			[[0,0,0,0]] 
		];

//Spawn smoke
		_smoke = "#particlesource" createVehicle _wreckPos;
		_smoke setParticleClass "BigDestructionSmoke";
		_smoke attachTo [_wreckPos,[0,0,1]];
		_smoke setDropInterval 0.05;
//Spawn water
		_water = "#particlesource" createVehicle _wreckPos;
		_water setParticleParams _waterArray;
		_water setParticleRandom [0.5, [0.0, 0.0, 0.0], [0.1, 0.1, 1.1], 0.3, 0.1, [0, 0, 0, 0], 0, 0];
		_water setParticleCircle [0.5, _waterParticleCircle];
		_water attachTo [_wreckPos,[0,0,1]];
		_water setDropInterval 0.001;
	sleep 2;
		deleteVehicle _wreck;
	sleep (_time / 2);
		deleteVehicle _smoke;
	sleep (_time / 2);
//Spawn "Salvage-Money"	:D
		_salvageMoney = createVehicle ["Land_Money_F", _wreckPos, [], 5, "None"];
		_salvageMoney setPos _wreckPos;
		_salvageMoney setDir random 360;
		_salvageMoney setVariable ["cmoney", _money, true];
		_salvageMoney setVariable ["owner", "world", true];
	sleep 1;
		deleteVehicle _water;
	sleep 1;
	deleteVehicle _extinguisherObject;
		
EXTINGUISH_DONE = true;