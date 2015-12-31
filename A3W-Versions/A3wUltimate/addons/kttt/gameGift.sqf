multiPlyWith = 1;
_i=0;
while {_i < 3} do
   {
   if ( _i == 1) then {
		_reward = (100 * multiPlyWith);
		player setVariable ["cmoney", ((player getVariable ["cmoney", 0]) + _reward), true];
	  _msg = parseText format ["<t align='center' color='#FFFFFF' shadow='2' size='1.75'>GameGift!</t><br/><t align='center' color='#17FF41'>------------------------------</t><br/><t align='center' color='#FFFFFF'>%1 Thank you for playing on our Server! You get %2$ as a present.</t>", name player, _reward];
      hint _msg;
      multiPlyWith = multiPlyWith + 1;
      _i = 0;
   };
   sleep 1200;
   _i = _i + 1;
   };