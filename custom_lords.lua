function createCustomLordFrame()
    local existingFrame = Util.getComponentWithName("customLordFrame");
    if not existingFrame then
        local customLordFrame = Frame.new("customLordFrame");
        local screen_x, screen_y = core:get_screen_resolution();
        local frameWidth, frameHeight = customLordFrame:Bounds();
        customLordFrame:MoveTo(screen_x/2 - frameWidth/2, 200);

        local contentWidth, contentHeight = customLordFrame.content:Bounds();
        local princeButton = TextButton.new("princeButton", customLordFrame, "TEXT_TOGGLE", "Prince");
        local buttonSize = 300;
        local gapSize = 100;

        princeButton:Resize(buttonSize, princeButton.uic:Height());
        princeButton:PositionRelativeTo(customLordFrame, contentWidth/2 - (buttonSize + gapSize/2), 50);
        princeButton.uic:SetState("selected");

        local princessButton = TextButton.new("princessButton", customLordFrame, "TEXT_TOGGLE", "Princess");
        princessButton:Resize(buttonSize, princessButton.uic:Height());
        princessButton:PositionRelativeTo(princeButton, buttonSize + gapSize, 0);
        princessButton.uic:SetState("active");

        princeButton:RegisterForClick("princeButtonListener",
            function(context)
                princessButton.uic:SetState("active");
            end
        );

        princessButton:RegisterForClick("princessButtonListener",
            function(context)
                princeButton.uic:SetState("active");
            end
        );

        local defaultSkillsButton = TextButton.new("defaultSkillsButton", customLordFrame, "TEXT_TOGGLE", "Default");        
        defaultSkillsButton:Resize(buttonSize, defaultSkillsButton.uic:Height());
        defaultSkillsButton:PositionRelativeTo(princeButton, 0, 50);
        defaultSkillsButton.uic:SetState("selected");

        local magicSkillsButton = TextButton.new("magicSkillsButton", customLordFrame, "TEXT_TOGGLE", "Magic");
        magicSkillsButton:Resize(buttonSize, magicSkillsButton.uic:Height());
        magicSkillsButton:PositionRelativeTo(princessButton, 0, 50);
        magicSkillsButton.uic:SetState("active");

        defaultSkillsButton:RegisterForClick("defaultSkillsButtonListener",
            function(context)
                magicSkillsButton.uic:SetState("active");
            end
        );

        magicSkillsButton:RegisterForClick("magicSkillsButtonListener",
            function(context)
                defaultSkillsButton.uic:SetState("active");
            end
        );

        local recuitButton = Button.new("recuitButton", customLordFrame, "CIRCULAR", "ui/campaign ui/edicts/lzd_alignment_of_building.png");
        local buttonWidth, buttonHeight = recuitButton.uic:Dimensions();
        recuitButton:PositionRelativeTo(customLordFrame, contentWidth/2 - buttonWidth/2, contentHeight - buttonHeight/2)

        local callBackFunction = function(context)
            if defaultSkillsButton:IsSelected() then
                cm:force_add_trait_on_selected_character("wh2_main_trait_hef_prince_melee");
            else
                cm:force_add_trait_on_selected_character("wh2_main_trait_hef_prince_magic");                
            end

            find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "units", "LandUnit 1"):SimulateLClick();
            find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "button_group_unit", "button_disband"):SimulateLClick();
            find_uicomponent(core:get_ui_root(), "dialogue_box", "both_group", "button_tick"):SimulateLClick();

            local generalButton = find_uicomponent(core:get_ui_root(), "layout", "info_panel_holder", "primary_info_panel_holder", "info_button_list", "button_general");
            generalButton:SimulateLClick();
            local renameButton = find_uicomponent(core:get_ui_root(), "character_details_panel", "background", "bottom_buttons", "button_rename");
            renameButton:SimulateLClick();
            find_uicomponent(core:get_ui_root(), "popup_text_input", "panel_title", "heading_txt"):SetStateText("Name your Lord");
            find_uicomponent(core:get_ui_root(), "popup_text_input", "text_input_list_parent", "text_input1"):SetStateText("Name your Lord");
            local textInput =  find_uicomponent(core:get_ui_root(), "popup_text_input", "text_input_list_parent", "text_input");
            textInput:SimulateKey("a");
            textInput:SimulateKey("b");
            local popupOkButton = find_uicomponent(core:get_ui_root(), "popup_text_input", "ok_cancel_buttongroup", "button_ok");
            popupOkButton:SimulateLClick();
            find_uicomponent(core:get_ui_root(), "character_details_panel", "button_ok"):SimulateLClick();
        end
        
        recuitButton:RegisterForClick("recuitButtonListener",
            function(context)
                if princeButton:IsSelected() then
                    cm:create_force_with_general(
                        "wh2_main_hef_eataine",
                        "wh2_main_skv_inf_clanrats_0",
                        "wh2_main_eataine_lothern",
                        217,
                        273,
                        "general",
                        "wh2_main_hef_prince",
                        "",
                        "",
                        "",
                        "",
                        "my_custom_lord",
                        false,
                        callBackFunction
                    );
                else
                    cm:create_force_with_general(
                        "wh2_main_hef_eataine",
                        "wh2_main_skv_inf_clanrats_0",
                        "wh2_main_eataine_lothern",
                        217,
                        273,
                        "general",
                        "wh2_main_hef_princess",
                        "",
                        "",
                        "",
                        "",
                        "my_custom_lord",
                        false,
                        callBackFunction
                    );
                end
                --cm:force_add_trait("character_cqi:"..character:cqi(), trait, true);
                --remove_all_units_from_character
                customLordFrame:SetVisible(false);
            end
        );
    else
        --# assume existingFrame: FRAME
        existingFrame:SetVisible(true); 
    end
end

function attachButtonToLordRecuitment()
    core:add_listener(
        "char_panel_opened",
        "PanelOpenedCampaign",
        function(context) 
            return context.string == "character_panel"; 
        end,
        function(context)
            local characterPanel = find_uicomponent(core:get_ui_root(), "character_panel");
            local raiseForces = find_uicomponent(characterPanel, "raise_forces_options");
            local raiseForcesButton = find_uicomponent(raiseForces, "button_raise");
            
            local createCustomLordButton = TextButton.new("createCustomLordButton", raiseForces, "TEXT", "Custom");
            createCustomLordButton:Resize(raiseForcesButton:Bounds());

            local rfWidth, rfHeight = raiseForcesButton:Bounds();
            local rfXPos, rfYPos = raiseForcesButton:Position();
            local gap = 20;
            raiseForcesButton:MoveTo(rfXPos - (rfWidth / 2 + gap / 2), rfYPos);
            createCustomLordButton:PositionRelativeTo(raiseForcesButton, gap + rfWidth, 0);
            
            createCustomLordButton:RegisterForClick(
                "createCustomLordButtonListener", 
                function(context)
                    output("Selected settlement:"..cm:get_campaign_ui_manager().settlement_selected);  
                    local region = string.sub(tostring(cm:get_campaign_ui_manager().settlement_selected), 12);
                    output("Selected region:"..region);                      
                    local settlement = get_region(region):settlement();
                    output(settlement:logical_position_x());
                    output(settlement:logical_position_y());
                    
                    createCustomLordFrame();
                    characterPanel:SetVisible(false);
                    --find_uicomponent(core:get_ui_root(), "layout", "hud_center_docker"):SetVisible(false);
                    --find_uicomponent(core:get_ui_root(), "layout", "info_panel_holder"):SetVisible(false);
                end
            );

        end,
        true
    );
end

function custom_lords()
    attachButtonToLordRecuitment();
    core:add_listener(
        "char_panel_openeddfgfdg",
        "PanelOpenedCampaign",
        function(context) 
            return context.string == "character_details_panel"; 
        end,
        function(context)
            --cm:callback(function()
                local chain = find_uicomponent(core:get_ui_root(), "character_details_panel", "background", "skills_subpanel", "listview", "list_clip", "list_box", "chain2", "chain");
                if not not chain then
                    local childCount = chain:ChildCount();
                    for i=0, childCount-1  do
                        local child = UIComponent(chain:Find(i));
                        output(child:Id());
                        --wh2_main_skill_innate_hef_prince_melee
                        --wh2_main_skill_innate_hef_prince_magic
                        
                        local char = cm:get_campaign_ui_manager():get_char_selected();
                        local cqi = string.sub(char, 15);
                        output("cqi:"..cqi);
                        local realChar = get_character_by_cqi(cqi);
                        local id = child:Id();
                        if id == "wh2_main_skill_hef_combat_graceful_strikes" 
                        or id == "module_wh2_main_skill_hef_combat_graceful_strikes" 
                        or id == "wh_main_skill_all_all_self_foe-seeker" 
                        or id == "module_wh_main_skill_all_all_self_foe-seeker" 
                        or id == "wh_main_skill_all_all_self_deadly_onslaught" then
                            if not realChar:has_trait("wh2_main_trait_hef_prince_melee") then
                                output("assdd");
                                child:SetVisible(false);
                                output("hid skill");
                            else
                                output("has skill melee");
                            end
                        end
                        if id == "wh2_main_skill_all_magic_high_02_apotheosis" 
                        or id == "module_wh2_main_skill_all_magic_high_02_apotheosis" 
                        or id == "wh_main_skill_all_magic_all_06_evasion" 
                        or id == "module_wh_main_skill_all_magic_all_06_evasion" 
                        or id == "wh_main_skill_all_magic_all_11_arcane_conduit" then
                            output("dfgfdg")
                            if not realChar:has_trait("wh2_main_trait_hef_prince_magic") then
                                output("dfgfdgdfg")
                                child:SetVisible(false);
                                output("hid skill");
                            else
                                output("has skill magic");
                            end
                        end
                    end
                end
            --end, 1.0, "SADD");
        end, 
        true
    );
end