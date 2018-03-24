function createCustomLordFrame()
    local existingFrame = Util.getComponentWithName("customLordFrame");
    if not existingFrame then
        local customLordFrame = Frame.new("customLordFrame");
        customLordFrame:SetTitle("Create your custom Lord");
        local screen_x, screen_y = core:get_screen_resolution();
        local frameWidth, frameHeight = customLordFrame:Bounds();
        customLordFrame:MoveTo(screen_x/2 - frameWidth/2, 200);

        local contentWidth, contentHeight = customLordFrame.content:Bounds();

        local lordName = Text.new("lordName", customLordFrame, "NORMAL", "Name your Lord");
        lordName:PositionRelativeTo(customLordFrame, 20, 20);
        local lordNameTextBox = TextBox.new("lordNameTextBox", customLordFrame);
        lordNameTextBox:PositionRelativeTo(lordName, 0, 20);



        local lordNameTextBoxWidth, lordNameTextBoxHeight = lordNameTextBox:Bounds();
        local lordTypeText = Text.new("lordTypeText", customLordFrame, "NORMAL", "Select your Lord type");
        lordTypeText:PositionRelativeTo(lordNameTextBox, 0, lordNameTextBoxHeight + 20);

        local princeButton = TextButton.new("princeButton", customLordFrame, "TEXT_TOGGLE", "Prince");
        local buttonSize = 300;
        local gapSize = 100;
        princeButton:Resize(buttonSize, princeButton:Height());
        princeButton:PositionRelativeTo(customLordFrame, contentWidth/2 - (buttonSize + gapSize/2), 0);
        princeButton:Move(0, lordNameTextBoxHeight + 80);
        princeButton:SetState("selected");

        local princessButton = TextButton.new("princessButton", customLordFrame, "TEXT_TOGGLE", "Princess");
        princessButton:Resize(buttonSize, princessButton:Height());
        princessButton:PositionRelativeTo(princeButton, buttonSize + gapSize, 0);
        princessButton:SetState("active");

        princeButton:RegisterForClick("princeButtonListener",
            function(context)
                princessButton:SetState("active");
            end
        );

        princessButton:RegisterForClick("princessButtonListener",
            function(context)
                princeButton:SetState("active");
            end
        );

        local princeButtonWidth, princeButtonHeight = princeButton:Bounds();
        local skillSetText = Text.new("lordTypeText", customLordFrame, "NORMAL", "Select your Lord skill-set");
        skillSetText:PositionRelativeTo(lordTypeText, 0, princeButtonHeight + 20);
        local defaultSkillsButton = TextButton.new("defaultSkillsButton", customLordFrame, "TEXT_TOGGLE", "Default");        
        defaultSkillsButton:Resize(buttonSize, defaultSkillsButton:Height());
        defaultSkillsButton:PositionRelativeTo(princeButton, 0, princeButtonHeight + 20);
        defaultSkillsButton:SetState("selected");

        local magicSkillsButton = TextButton.new("magicSkillsButton", customLordFrame, "TEXT_TOGGLE", "Magic");
        magicSkillsButton:Resize(buttonSize, magicSkillsButton:Height());
        magicSkillsButton:PositionRelativeTo(princessButton, 0, princeButtonHeight + 20);
        magicSkillsButton:SetState("active");

        defaultSkillsButton:RegisterForClick("defaultSkillsButtonListener",
            function(context)
                magicSkillsButton:SetState("active");
            end
        );

        magicSkillsButton:RegisterForClick("magicSkillsButtonListener",
            function(context)
                defaultSkillsButton:SetState("active");
            end
        );

        local customTraitText = Text.new("customTraitText", customLordFrame, "NORMAL", "Select your Lords traits");
        customTraitText:PositionRelativeTo(skillSetText, 0, princeButtonHeight + 20);
        local firstTraitButton = TextButton.new("firstTraitButton", customLordFrame, "TEXT_TOGGLE", "First Trait");     
        firstTraitButton:Resize(buttonSize, firstTraitButton:Height());
        firstTraitButton:PositionRelativeTo(defaultSkillsButton, 0, princeButtonHeight + 20);
        firstTraitButton:SetState("active");        
        local secondTraitButton = TextButton.new("secondTraitButton", customLordFrame, "TEXT_TOGGLE", "Second Trait");     
        secondTraitButton:Resize(buttonSize, secondTraitButton:Height());
        secondTraitButton:PositionRelativeTo(magicSkillsButton, 0, princeButtonHeight + 20);
        secondTraitButton:SetState("active");  
        
        local recuitButton = Button.new("recuitButton", customLordFrame, "CIRCULAR", "ui/skins/default/icon_check.png");
        local buttonWidth, buttonHeight = recuitButton:Bounds();
        recuitButton:PositionRelativeTo(customLordFrame, contentWidth/2 - buttonWidth/2, contentHeight - buttonHeight/2)

        local callBackFunction = function(
            context --:CA_CQI
        )
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

            local lordNameFromTextBox = lordNameTextBox.uic:GetStateText();
            for i = 1, string.len(lordNameFromTextBox) do
                textInput:SimulateKey(string.sub(lordNameFromTextBox, i, i));
            end

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
                    local region = string.sub(tostring(cm:get_campaign_ui_manager().settlement_selected), 12);
                    local settlement = get_region(region):settlement();
                    output(settlement:logical_position_x());
                    output(settlement:logical_position_y());
                    
                    createCustomLordFrame();
                    characterPanel:SetVisible(false);
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
            local chain = find_uicomponent(core:get_ui_root(), "character_details_panel", "background", "skills_subpanel", "listview", "list_clip", "list_box", "chain2", "chain");
            if not not chain then
                local childCount = chain:ChildCount();
                for i=0, childCount-1  do
                    local child = UIComponent(chain:Find(i));
                    output(child:Id());
                    
                    local char = cm:get_campaign_ui_manager():get_char_selected();
                    local cqi = string.sub(char, 15);
                    output("cqi:"..cqi);
                    --# assume cqi: CA_CQI
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
        end, 
        true
    );
end