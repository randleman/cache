//	@file Version: 1.0
//	@file Name: loadingscreen.hpp
//	@file Author: wiking.at
//	www.armajunkies.de
//	Definition of custom loadingscreen display.

titles[] = {"loadingscreen"};

class loadingscreen {
  idd = -1;
  movingEnable = 0;
  duration = 1e+011;
  fadein = 0;
  fadeout = 0;
  name="loadingscreen";
 

  controls[]={"loadingPicture"};
  class loadingPicture {
  
    x=safezonex; y=safezoney; w=safezonew; h=safezoneh;
	style=48 + 0x800;
    text="addons\kttt\kttt_loadingscreen.jpg";
    sizeEx = -1;
    type=0;
    idc=-1;
    colorBackground[]={0,0,0,0};
    colorText[]={1,1,1,1};
    font="TahomaB";
  };
};