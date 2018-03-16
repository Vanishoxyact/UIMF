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

        princeButton:RegisterForClick("princessButtonListener",
            function(context)
                princessButton.uic:SetState("active");
            end
        );

        princessButton:RegisterForClick("princessButtonListener",
            function(context)
                princeButton.uic:SetState("active");
            end
        );

        local recuitButton = Button.new("recuitButton", customLordFrame, "CIRCULAR", "ui/campaign ui/edicts/lzd_alignment_of_building.png");
        local buttonWidth, buttonHeight = recuitButton.uic:Dimensions();
        recuitButton:PositionRelativeTo(customLordFrame, contentWidth/2 - buttonWidth/2, contentHeight - buttonHeight/2)

        local callBackFunction = function(context)
            remove_all_units_from_character(get_character_by_cqi(context));
            local generalButton = find_uicomponent(core:get_ui_root(), "layout", "info_panel_holder", "primary_info_panel_holder", "info_button_list", "button_general");
            generalButton:SimulateLClick();
            local renameButton = find_uicomponent(core:get_ui_root(), "character_details_panel", "background", "bottom_buttons", "button_rename");
            renameButton:SimulateLClick();
            find_uicomponent(core:get_ui_root(), "character_details_panel"):SetVisible(false);
            find_uicomponent(core:get_ui_root(), "popup_text_input", "panel_title", "heading_txt"):SetStateText("Name your Lord");
            local popupOkButton = find_uicomponent(core:get_ui_root(), "popup_text_input", "ok_cancel_buttongroup", "button_ok");
            Util.registerForClick(popupOkButton, "popupOkButtonListener",
                function(context)
                    find_uicomponent(core:get_ui_root(), "character_details_panel"):SetVisible(true);
                    cm:callback(
                        function()
                            find_uicomponent(core:get_ui_root(), "character_details_panel", "button_ok"):SimulateLClick();
                        end, 0, "closeasdasd"
                    );
                end
            );
        end
        
        recuitButton:RegisterForClick("recuitButtonListener",
            function(context)
                if princeButton:IsSelected() then
                    cm:create_force_with_general(
                        "wh2_main_hef_eataine",
                        "wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_clanrats_0",
                        "wh2_main_eataine_lothern",
                        210,
                        280,
                        "general",
                        "wh2_main_hef_prince",
                        "forname",
                        "clan_name",
                        "family_name",
                        "other_name",
                        "my_custom_lord",
                        false,
                        callBackFunction
                    );
                else
                    cm:create_force_with_general(
                        "wh2_main_hef_eataine",
                        "wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_clanrats_0",
                        "wh2_main_eataine_lothern",
                        210,
                        280,
                        "general",
                        "wh2_main_hef_princess",
                        "forname",
                        "clan_name",
                        "family_name",
                        "other_name",
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
end