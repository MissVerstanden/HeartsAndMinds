
private ["_unit","_type"];

_unit = _this select 0;

_type = typeOf _unit;

diag_log format ["UNIT INIT : %1",[_this,side (_this select 0), btc_enemy_side]];

switch true do {
	case (side _unit isEqualTo btc_enemy_side) : {
		
		if (isServer) then {_unit spawn {sleep 0.5;_this call btc_fnc_mil_unit_create;};};
		
		if (!isDedicated) then {
			if (isNil "btc_actions_units") then {btc_actions_units = [];};
			if !(_type in btc_actions_units) then {
				btc_actions_units pushBack _type;

				_unit spawn {
					sleep 1;
					_action = ["Search_intel", "Search for intel", "", {(_this select 0) spawn btc_fnc_info_search_for_intel;}, {!Alive (_this select 0)}] call ace_interact_menu_fnc_createAction;
					[(typeOf _this), 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
					diag_log format ["ADD ACTION : %1",[_this,(typeOf _this), _action]];
				};
			};
		};
	};
	case (side _unit isEqualTo civilian) : {
	
		if (isServer) then {_unit spawn {sleep 0.5;_this call btc_fnc_civ_unit_create;};};
		
		if (!isDedicated) then {
			if (isNil "btc_actions_units") then {btc_actions_units = [];};
			if !(_type in btc_actions_units) then {
				btc_actions_units pushBack _type;
				
				_unit spawn {
					sleep 1;
					_action = ["Civil_Orders","Civil Orders","",{},{true}] call ace_interact_menu_fnc_createAction;
					[(typeOf _this), 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;
					_action = ["Civil_Stop", "Stop", "", {[1,(_this select 0)] call btc_fnc_int_orders;}, {Alive (_this select 0)}] call ace_interact_menu_fnc_createAction;
					[(typeOf _this), 0, ["ACE_MainActions","Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToClass;
					_action = ["Civil_Get_down", "Get down", "", {[2,(_this select 0)] call btc_fnc_int_orders;}, {Alive (_this select 0)}] call ace_interact_menu_fnc_createAction;
					[(typeOf _this), 0, ["ACE_MainActions","Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToClass;
					_action = ["Civil_Go_away", "Go away", "", {[3,(_this select 0)] call btc_fnc_int_orders;}, {Alive (_this select 0)}] call ace_interact_menu_fnc_createAction;
					[(typeOf _this), 0, ["ACE_MainActions","Civil_Orders"], _action] call ace_interact_menu_fnc_addActionToClass;
					_action = ["Ask_Info", "Ask info", "", {[(_this select 0)] spawn btc_fnc_info_ask;}, {Alive (_this select 0) && {side (_this select 0) isEqualTo civilian}}] call ace_interact_menu_fnc_createAction;
					[(typeOf _this), 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;			
				};			
			};
		};
	};
};