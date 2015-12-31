// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
#include "ktttstoreDefines.sqf"

#define ktttStoreButton_textSize (0.04 * TEXT_SCALE)

class ktttstored
{
	idd = ktttstore_DIALOG;
	movingEnable = true;
	enableSimulation = true;
	onLoad = "[[0], populatektttStore] execFSM 'call.fsm'";

	class ControlsBackground
	{
		#define ktttStoreMainBG_W (0.7333 * SZ_SCALE)
		#define ktttStoreMainBG_H (0.65 * SZ_SCALE)
		#define ktttStoreMainBG_X CENTER(1, ktttStoreMainBG_W)
		#define ktttStoreMainBG_Y CENTER(1, ktttStoreMainBG_H)

		class MainBackground: IGUIBack
		{
			idc = -1;
			colorBackground[] = {0, 0, 0, 0.6};
			moving = true;

			x = ktttStoreMainBG_X;
			y = ktttStoreMainBG_Y;
			w = ktttStoreMainBG_W;
			h = ktttStoreMainBG_H;
		};

		class TopBar: IGUIBack
		{
			idc = -1;
			colorBackground[] = {0.25, 0.51, 0.96, 0.8};

			#define ktttStoreTopBar_H (0.05 * SZ_SCALE)

			x = ktttStoreMainBG_X;
			y = ktttStoreMainBG_Y;
			w = ktttStoreMainBG_W;
			h = ktttStoreTopBar_H;
		};

		class DialogTitleText: w_RscTextCenter
		{
			idc = -1;
			text = "K-Town-Terror-Trupp";
			sizeEx = 0.06 * TEXT_SCALE;

			x = ktttStoreMainBG_X;
			y = ktttStoreMainBG_Y;
			w = ktttStoreMainBG_W;
			h = ktttStoreTopBar_H;
		};

		class ItemSelectedPrice: w_RscStructuredTextLeft
		{
			idc = ktttstore_item_TEXT;
			size = 0.04 * TEXT_SCALE;

			x = ktttStoreMainBG_X + (0.15 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.514 * SZ_SCALE);
			w = 0.119 * SZ_SCALE;
			h = 0.0689 * SZ_SCALE;
		};

		class SellSelectedPrice: w_RscStructuredTextLeft
		{
			idc = ktttstore_sell_TEXT;
			size = 0.04 * TEXT_SCALE;

			x = ktttStoreMainBG_X + (0.439 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.514 * SZ_SCALE);
			w = 0.119 * SZ_SCALE;
			h = 0.0689 * SZ_SCALE;
		};
	};

	class Controls
	{
		class SelectionList: w_RscList
		{
			idc = ktttstore_item_list;
			onLBSelChanged = "[] execVM 'client\systems\ktttStore\itemInfo.sqf'";
			sizeEx = 0.04 * TEXT_SCALE;
			rowHeight = 0.05 * TEXT_SCALE;

			x = ktttStoreMainBG_X + (0.1533 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.075 * SZ_SCALE);
			w = 0.276 * SZ_SCALE;
			h = 0.3382 * SZ_SCALE;
		};

		class ItemDescription: w_RscStructuredTextLeft
		{
			idc = ktttstore_item_desc;
			size = 0.04 * TEXT_SCALE;
			colorBackground[] = {0, 0, 0, 0.3};

			x = ktttStoreMainBG_X + (0.1533 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.417 * SZ_SCALE);
			w = 0.276 * SZ_SCALE;
			h = 0.088 * SZ_SCALE;
		};

		class SellList: w_RscList
		{
			idc = ktttstore_sell_list;
			onLBSelChanged = "[] execVM 'client\systems\ktttStore\sellInfo.sqf'";
			sizeEx = 0.04 * TEXT_SCALE;
			rowHeight = 0.05 * TEXT_SCALE;

			x = ktttStoreMainBG_X + (0.4433 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.075 * SZ_SCALE);
			w = 0.276 * SZ_SCALE;
			h = 0.4222 * SZ_SCALE;
		};

		class BuyItem: w_RscButton
		{
			idc = -1;
			action = "[0] execVM 'client\systems\ktttStore\buyItems.sqf'";
			text = "Buy";
			sizeEx = ktttStoreButton_textSize;

			x = ktttStoreMainBG_X + (0.334 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.507 * SZ_SCALE);
			w = 0.096 * SZ_SCALE;
			h = 0.040 * SZ_SCALE;
		};

		class SellItem: w_RscButton
		{
			idc = ktttstore_sell;
			action = "[0] execVM 'client\systems\ktttStore\sellItems.sqf'";
			text = "Sell";
			sizeEx = ktttStoreButton_textSize;

			x = ktttStoreMainBG_X + (0.6233 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.507 * SZ_SCALE);
			w = 0.096 * SZ_SCALE;
			h = 0.040 * SZ_SCALE;
		};

		class StoreButton0: w_RscButton
		{
			idc = -1;
			action = "[0] call populatektttStore";
			text = "Headgear";
			sizeEx = ktttStoreButton_textSize;

			x = ktttStoreMainBG_X + (0.0167 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.075 * SZ_SCALE);
			w = 0.1173 * SZ_SCALE;
			h = 0.040 * SZ_SCALE;
		};

		class StoreButton1: w_RscButton
		{
			idc = -1;
			action = "[1] call populatektttStore";
			text = "Uniforms";
			sizeEx = ktttStoreButton_textSize;

			x = ktttStoreMainBG_X + (0.0167 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.125 * SZ_SCALE);
			w = 0.1173 * SZ_SCALE;
			h = 0.040 * SZ_SCALE;
		};

		class StoreButton2: w_RscButton
		{
			idc = -1;
			action = "[2] call populatektttStore";
			text = "Vests";
			sizeEx = ktttStoreButton_textSize;

			x = ktttStoreMainBG_X + (0.0167 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.175 * SZ_SCALE);
			w = 0.1173 * SZ_SCALE;
			h = 0.040 * SZ_SCALE;
		};

		class StoreButton3: w_RscButton
		{
			idc = -1;
			action = "[3] call populatektttStore";
			text = "Backpacks";
			sizeEx = ktttStoreButton_textSize;

			x = ktttStoreMainBG_X + (0.0167 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.225 * SZ_SCALE);
			w = 0.1173 * SZ_SCALE;
			h = 0.040 * SZ_SCALE;
		};

		class StoreButton4: w_RscButton
		{
			idc = -1;
			action = "[4] call populatektttStore";
			text = "Items";
			sizeEx = ktttStoreButton_textSize;

			x = ktttStoreMainBG_X + (0.0167 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.275 * SZ_SCALE);
			w = 0.1173 * SZ_SCALE;
			h = 0.040 * SZ_SCALE;
		};

		class StoreButton5: w_RscButton
		{
			idc = -1;
			action = "[5] call populatektttStore";
			text = "Supplies";
			sizeEx = ktttStoreButton_textSize;

			x = ktttStoreMainBG_X + (0.0167 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.325 * SZ_SCALE);
			w = 0.1173 * SZ_SCALE;
			h = 0.040 * SZ_SCALE;
		};

		class StoreButton6: w_RscButton
		{
			idc = -1;
			action = "[6] call populatektttStore";
			text = "Objects";
			sizeEx = ktttStoreButton_textSize;

			x = ktttStoreMainBG_X + (0.0167 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.375 * SZ_SCALE);
			w = 0.1173 * SZ_SCALE;
			h = 0.040 * SZ_SCALE;
		};

		class SellWeapon: w_RscButton
		{
			idc = -1;
			action = "[] execVM 'client\systems\selling\sellWeapon.sqf'";
			text = "Sell Weapon";
			sizeEx = ktttStoreButton_textSize;

			x = ktttStoreMainBG_X + (0.23 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.59 * SZ_SCALE);
			w = 0.1173 * SZ_SCALE;
			h = 0.040 * SZ_SCALE;
		};

		class SellUniform: w_RscButton
		{
			idc = -1;
			action = "[] execVM 'client\systems\selling\sellUniform.sqf'";
			text = "Sell Uniform";
			sizeEx = ktttStoreButton_textSize;

			x = ktttStoreMainBG_X + ((0.604 - 0.25) * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.59 * SZ_SCALE);
			w = 0.1173 * SZ_SCALE;
			h = 0.040 * SZ_SCALE;
		};

		class SellVest: w_RscButton
		{
			idc = -1;
			action = "[] execVM 'client\systems\selling\sellVest.sqf'";
			text = "Sell Vest";
			sizeEx = ktttStoreButton_textSize;

			x = ktttStoreMainBG_X + (0.478 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.59 * SZ_SCALE);
			w = 0.1173 * SZ_SCALE;
			h = 0.040 * SZ_SCALE;
		};

		class SellBackpack: w_RscButton
		{
			idc = -1;
			action = "[] execVM 'client\systems\selling\sellBackpack.sqf'";
			text = "Sell Backpack";
			sizeEx = ktttStoreButton_textSize;

			x = ktttStoreMainBG_X + (0.602 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.59 * SZ_SCALE);
			w = 0.1173 * SZ_SCALE;
			h = 0.040 * SZ_SCALE;
		};

		class CancelButton: w_RscButton
		{
			idc = -1;
			action = "closeDialog 0";
			text = "Cancel";
			sizeEx = ktttStoreButton_textSize;

			x = ktttStoreMainBG_X + (0.0167 * SZ_SCALE);
			y = ktttStoreMainBG_Y + (0.59 * SZ_SCALE);
			w = 0.096 * SZ_SCALE;
			h = 0.040 * SZ_SCALE;
		};
	};
};

