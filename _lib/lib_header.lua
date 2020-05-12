
local timestamp = os.clock();

-- call this here as well as in all_scripted.lua
if __game_mode ~= __lib_type_frontend then
	-- don't do this in the frontend, as we're running in the same environment so it will have already been called in all_scripted.lua
	out = remap_outputs(out);
end;


TYPE_TIMER_MANAGER = "timer_manager";
TYPE_CORE = "core";
TYPE_BATTLE_MANAGER = "battle_manager";
TYPE_CAMPAIGN_MANAGER = "campaign_manager";
TYPE_CUTSCENE_MANAGER = "cutscene_manager";
TYPE_CONVEX_AREA = "convex_area";
TYPE_SCRIPT_UNIT = "scripted_unit";
TYPE_SCRIPT_UNITS = "scripted_units";
TYPE_WAYPOINT = "waypoint";
TYPE_EVENT_HANDLER = "event_handler";
TYPE_SCRIPT_AI_PLANNER = "script_ai_planner";
TYPE_UI_OVERRIDE = "ui_override";
TYPE_FACTION_START = "faction_start";
TYPE_CAMPAIGN_CUTSCENE = "campaign_cutscene";
TYPE_SCRIPT_MESSAGER = "script_messager";
TYPE_GENERATED_BATTLE = "generated_battle";
TYPE_GENERATED_ARMY = "generated_army";
TYPE_GENERATED_CUTSCENE = "generated_cutscene";
TYPE_CAMPAIGN_UI_MANAGER = "campaign_ui_manager";
TYPE_BATTLE_UI_MANAGER = "battle_ui_manager";
TYPE_OBJECTIVES_MANAGER = "objectives_manager";
TYPE_INFOTEXT_MANAGER = "infotext_manager";
TYPE_MISSION_MANAGER = "mission_manager";
TYPE_CAMPAIGN_VECTOR = "campaign_vector";
TYPE_INTERVENTION = "intervention";
TYPE_INTERVENTION_MANAGER = "intervention_manager";
TYPE_LINK_PARSER = "link_parser";
TYPE_ADVICE_MANAGER = "advice_manager";
TYPE_ADVICE_MONITOR = "advice_monitor";


VOLUME_TYPE_MUSIC = 0;
VOLUME_TYPE_SFX = 1;
VOLUME_TYPE_ADVISOR = 2;
VOLUME_TYPE_VO = 3;
VOLUME_TYPE_INTERFACE = 1;
VOLUME_TYPE_MOVIE = 5;
VOLUME_TYPE_VOICE_CHAT = 6;
VOLUME_TYPE_MASTER = 7;

-- common libs
force_require("lib_common");
force_require("lib_script_messager");
force_require("lib_timer_manager");
force_require("lib_core");
force_require("lib_common_ui");

if __game_mode == __lib_type_battle then
	-- battle libs	
	force_require("lib_battle_misc");
	force_require("lib_battle_manager");
	force_require("lib_battle_ui");
	force_require("lib_battle_script_unit");
	force_require("lib_battle_cutscene");
	force_require("lib_battle_patrol_manager");
	force_require("lib_battle_script_ai_planner");
	-- force_require("lib_battle_prelude");
	force_require("lib_objectives");
	force_require("lib_infotext");
	force_require("lib_help_pages");
	force_require("lib_convex_area");
	force_require("lib_generated_battle");
	force_require("lib_battle_advice");
	
elseif __game_mode == __lib_type_campaign then
	-- campaign libs
	force_require("lib_campaign_vector");
	force_require("lib_campaign_manager");
	force_require("lib_campaign_cutscene");
	force_require("lib_campaign_ui");
	force_require("lib_campaign_ui_overrides");
	force_require("lib_campaign_mission_manager");
	force_require("lib_campaign_intervention");
	force_require("lib_campaign_random_army");
	force_require("lib_campaign_invasion_manager");
	force_require("lib_objectives");
	force_require("lib_infotext");
	force_require("lib_help_pages");
	force_require("lib_convex_area");
	
elseif __game_mode == __lib_type_frontend then
	-- frontend libs
	
end;

if __game_mode == __lib_type_battle then
	out("lib_header.lua :: script libraries reloaded in battle configuration");
elseif __game_mode == __lib_type_campaign then
	out("lib_header.lua :: script libraries reloaded in campaign configuration");
elseif __game_mode == __lib_type_frontend then
	out("lib_header.lua :: script libraries reloaded in frontend configuration");
end;

out("\tloading took " .. os.clock() - timestamp .. "s");
out("\tLua version is " .. tostring(_VERSION));
out("");



-- automatic creation of core object
core = core_object:new();

-- create a campaign manager
if core:is_campaign() then
	cm = campaign_manager:new();
end;

force_require("lib_uimf");