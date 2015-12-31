//	@file Version: 1.0
//	@file Name: customUniforms.sqf
//	@file Author: wiking.at
//	Allow custom uniforms for clan's regulary playing on our server

//if (isServer) exitWith{}; 

// K-TTT Members
_ktttUIDs =[
		// Put player UIDs here
		"76561197979340780", // Razor
		"76561198102014597", // Achilles
		"76561198101752132"  // Patrick

		];
		
	
		

// Check if Player is in Indi and KTTT

if (playerSide == independent && (getPlayerUID player in _ktttUIDs))  then
 { 
	[] spawn  // Uniform
	{
		while {true} do
		{
			waitUntil {uniform player == "U_I_CombatUniform"}; 
			player setObjectTextureGlobal [0,"addons\customuniforms\textures\kttt_uniform_indep.jpg"];
			waitUntil {uniform player != "U_I_CombatUniform"};  //If player changes Uniform go to the top of the while loop
		};
	};
};


