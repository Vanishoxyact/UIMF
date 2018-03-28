FACTION_LORD_TYPES = {} --: map<string, vector<string>>
FACTION_LORD_TYPES["wh2_main_hef_eataine"] = {};
table.insert(FACTION_LORD_TYPES["wh2_main_hef_eataine"], "wh2_main_hef_prince");
table.insert(FACTION_LORD_TYPES["wh2_main_hef_eataine"], "wh2_main_hef_princess");

LORD_TYPE_NAMES = {} --: map<string, string>
LORD_TYPE_NAMES["wh2_main_hef_prince"] = "Prince";
LORD_TYPE_NAMES["wh2_main_hef_princess"] = "Princess";

LORD_SKILL_SETS = {} --: map<string, vector<string>>
LORD_SKILL_SETS["wh2_main_hef_prince"] = {};
table.insert(LORD_SKILL_SETS["wh2_main_hef_prince"], "wh2_main_trait_hef_prince_melee");
table.insert(LORD_SKILL_SETS["wh2_main_hef_prince"], "wh2_main_trait_hef_prince_magic");
LORD_SKILL_SETS["wh2_main_hef_princess"] = {};
table.insert(LORD_SKILL_SETS["wh2_main_hef_princess"], "wh2_main_trait_hef_princess_ranged");
table.insert(LORD_SKILL_SETS["wh2_main_hef_princess"], "wh2_main_trait_hef_princess_magic");

SKILL_SETS_NAMES = {} --: map<string, string>
SKILL_SETS_NAMES["wh2_main_trait_hef_prince_melee"] = "Melee";
SKILL_SETS_NAMES["wh2_main_trait_hef_prince_magic"] = "Magic";
SKILL_SETS_NAMES["wh2_main_trait_hef_princess_ranged"] = "Ranged";
SKILL_SETS_NAMES["wh2_main_trait_hef_princess_magic"] = "Magic";

SKILL_SET_SKILLS = {} --: map<string, vector<string>>
SKILL_SET_SKILLS["wh2_main_trait_hef_prince_melee"] = {};
table.insert(SKILL_SET_SKILLS["wh2_main_trait_hef_prince_melee"], "wh2_main_skill_hef_combat_graceful_strikes");
table.insert(SKILL_SET_SKILLS["wh2_main_trait_hef_prince_melee"], "module_wh2_main_skill_hef_combat_graceful_strikes");
table.insert(SKILL_SET_SKILLS["wh2_main_trait_hef_prince_melee"], "wh_main_skill_all_all_self_foe-seeker");
table.insert(SKILL_SET_SKILLS["wh2_main_trait_hef_prince_melee"], "module_wh_main_skill_all_all_self_foe-seeker");
table.insert(SKILL_SET_SKILLS["wh2_main_trait_hef_prince_melee"], "wh_main_skill_all_all_self_deadly_onslaught");
SKILL_SET_SKILLS["wh2_main_trait_hef_prince_magic"] = {};
table.insert(SKILL_SET_SKILLS["wh2_main_trait_hef_prince_magic"], "wh2_main_skill_all_magic_high_02_apotheosis");
table.insert(SKILL_SET_SKILLS["wh2_main_trait_hef_prince_magic"], "module_wh2_main_skill_all_magic_high_02_apotheosis");
table.insert(SKILL_SET_SKILLS["wh2_main_trait_hef_prince_magic"], "wh_main_skill_all_magic_all_06_evasion");
table.insert(SKILL_SET_SKILLS["wh2_main_trait_hef_prince_magic"], "module_wh_main_skill_all_magic_all_06_evasion");
table.insert(SKILL_SET_SKILLS["wh2_main_trait_hef_prince_magic"], "wh_main_skill_all_magic_all_11_arcane_conduit");

TRAITS = {} --: vector<string>
table.insert(TRAITS, "wh2_main_trait_defeated_teclis");
table.insert(TRAITS, "wh2_main_trait_defeated_tyrion");

table.insert(TRAITS, "wh2_main_skill_innate_all_aggressive");
table.insert(TRAITS, "wh2_main_skill_innate_all_confident");
table.insert(TRAITS, "wh2_main_skill_innate_all_cunning");
table.insert(TRAITS, "wh2_main_skill_innate_all_determined");
table.insert(TRAITS, "wh2_main_skill_innate_all_disciplined");
table.insert(TRAITS, "wh2_main_skill_innate_all_fleet_footed");
table.insert(TRAITS, "wh2_main_skill_innate_all_intelligent");
table.insert(TRAITS, "wh2_main_skill_innate_all_knowledgeable");
-- table.insert(TRAITS, "wh2_main_skill_innate_all_perceptive");
-- table.insert(TRAITS, "wh2_main_skill_innate_all_strategist");
-- table.insert(TRAITS, "wh2_main_skill_innate_all_strong");
-- table.insert(TRAITS, "wh2_main_skill_innate_all_tactician");
-- table.insert(TRAITS, "wh2_main_skill_innate_all_tough");
-- table.insert(TRAITS, "wh2_main_skill_innate_all_weapon_master");

--v function(buttons: vector<TEXT_BUTTON>)
function setUpSingleButtonSelectedGroup(buttons)
    for i, button in ipairs(buttons) do
        button:RegisterForClick(button.name .. "SelectListener",
            function(context)
                for i, otherButton in ipairs(buttons) do
                    if button.name == otherButton.name then
                        otherButton:SetState("selected_hover");
                    else
                        otherButton:SetState("active");
                    end
                end
            end
        );
    end
end

--v function(lordType: string, frame: FRAME) --> TEXT_BUTTON
function createLordTypeButton(lordType, frame)
    local lordTypeButton = TextButton.new(lordType .. "Button", frame, "TEXT_TOGGLE", LORD_TYPE_NAMES[lordType]);
    lordTypeButton:Resize(300, lordTypeButton:Height());
    lordTypeButton:SetState("active");
    return lordTypeButton;
end

--v function(currentFaction: string, frame: FRAME) --> map<string, TEXT_BUTTON>
function createLordTypeButtons(currentFaction, frame)
    local buttons = {} --: vector<TEXT_BUTTON>
    local buttonsMap = {} --: map<string, TEXT_BUTTON>
    for i, lordType in ipairs(FACTION_LORD_TYPES[currentFaction]) do
        local button = createLordTypeButton(lordType, frame);
        if i == 1 then
            button:SetState("selected");
        end
        buttonsMap[lordType] = button;
        table.insert(buttons, button);
    end
    setUpSingleButtonSelectedGroup(buttons);
    return buttonsMap;
end

--v function(skillSet: string, frame: FRAME) --> TEXT_BUTTON
function createSkillSetButton(skillSet, frame)
    local skillSetButton = TextButton.new(skillSet .. "Button", frame, "TEXT_TOGGLE", SKILL_SETS_NAMES[skillSet]);
    skillSetButton:Resize(300, skillSetButton:Height());
    skillSetButton:SetState("active");
    return skillSetButton;
end

--v function(lordType: string, frame: FRAME) --> map<string, TEXT_BUTTON>
function createSkillSetButtons(lordType, frame)
    local buttons = {} --: vector<TEXT_BUTTON>
    local buttonsMap = {} --: map<string, TEXT_BUTTON>
    for i, skillSet in ipairs(LORD_SKILL_SETS[lordType]) do
        local button = createSkillSetButton(skillSet, frame);
        if i == 1 then
            button:SetState("selected");
        end
        buttonsMap[skillSet] = button;
        table.insert(buttons, button);
    end
    setUpSingleButtonSelectedGroup(buttons);
    return buttonsMap;
end

--v function(traitEffectProperties: map<string, string>) --> (string, string)
function calculateImageAndToolTipForTraitEffectProperties(traitEffectProperties)
    local traitImagePath = nil --: string
    local traitDescription = nil --: string
    local colour = nil --: string
    local traitEffect = traitEffectProperties["effect"];
    output("effect: " .. traitEffect);
    local effectValue = tonumber(traitEffectProperties["value"]);
    local effects = TABLES["effects_tables"][traitEffect] --: map<string, string>
    if effectValue > 0 then
        traitImagePath = "ui/campaign ui/effect_bundles/" .. effects["icon"];
    else
        traitImagePath = "ui/campaign ui/effect_bundles/" .. effects["icon_negative"];
    end

    if (effects["is_positive_value_good"] == "True") == (effectValue > 0) then
        colour = "dark_g";
    else
        colour = "dark_r";
    end
    output("colour: " .. colour);        

    output("traitImagePath: " .. traitImagePath);
    local effectDescriptionPath = "effects_description_" .. traitEffect;
    output("effectDescriptionPath: " .. effectDescriptionPath);
    traitDescription = effect.get_localised_string(effectDescriptionPath);
    output("traitDescription: " .. traitDescription);

    local effectSign = nil --: string
    if effectValue > 0 then
        effectSign = "+";
    else
        effectSign = "";
    end
    traitDescription = string.gsub(traitDescription, "%%%+n", effectSign .. tostring(effectValue));
    traitDescription = string.gsub(traitDescription, "%%%n", tostring(effectValue));    
    output("traitDescription replaced: " .. traitDescription);

    local traitEffectScope = traitEffectProperties["effect_scope"];
    output("traitEffectScope: " .. traitEffectScope);
    local traitEffectScopePath = "campaign_effect_scopes_localised_text_" .. traitEffectScope;
    output("traitEffectScopePath: " .. traitEffectScopePath);
    local traitEffectScopeDesc = effect.get_localised_string(traitEffectScopePath);        
    output("traitEffectScopeDesc: " .. traitEffectScopeDesc);

    traitDescription = "[[col:" .. colour .. "]]" .. traitDescription .. traitEffectScopeDesc .. "[[/col]]";
    output("traitDescription final: " .. traitDescription);

    return traitImagePath, traitDescription;
end

--v function(trait: string, frame: FRAME, buttonCreationFunction: function(trait:string) --> BUTTON) --> CONTAINER
function createTraitRow(trait, frame, buttonCreationFunction)
    output("createTraitRow: " .. trait);
    local traitRow = Container.new(FlowLayout.HORIZONTAL);
    local traitNameKey = "character_trait_levels_onscreen_name_" .. trait;
    output("traitNameKey: " .. traitNameKey);
    local traitName = effect.get_localised_string(traitNameKey);
    output("traitName: " .. traitName);
    local traitNameText = Text.new(trait .. "NameText", frame, "NORMAL", traitName);
    traitRow:AddComponent(traitNameText);
    local traitEffectsContainer = Container.new(FlowLayout.VERTICAL);
    local traitEffects = TABLES["trait_level_effects_tables"][trait] --: vector<map<string, string>>
    for i, traitEffectProperties in ipairs(traitEffects) do
        local traitEffectContainer = Container.new(FlowLayout.HORIZONTAL);
        local traitImagePath, traitDescription = calculateImageAndToolTipForTraitEffectProperties(traitEffectProperties);
        local traitImage = Image.new(trait .. i .. "Image", frame, traitImagePath);
        traitEffectContainer:AddComponent(traitImage);
        local traitDesc = Text.new(trait .. i .. "NameDesc", frame, "NORMAL", traitDescription);
        traitEffectContainer:AddComponent(traitDesc);
        traitEffectsContainer:AddComponent(traitEffectContainer);
    end
    traitRow:AddComponent(traitEffectsContainer);
    traitRow:AddComponent(buttonCreationFunction(trait));
    return traitRow;
end

--v function(list: vector<string>, value: string) --> boolean
function listContains(list, value)
    for i, listValue in ipairs(list) do
        if listValue == value then
            return true;
        end
    end
    return false;
end

--v function(currentTraits: vector<string>, addTraitCallback: function(string)) --> FRAME
function createTraitSelectionFrame(currentTraits, addTraitCallback)
    local traitSelectionFrame = Frame.new("traitSelectionFrame");
    traitSelectionFrame:SetTitle("Select the Trait to Add");
    traitSelectionFrame:Scale(0.75);
    traitSelectionFrame:AddCloseButton();
    local traitSelectionFrameContainer = Container.new(FlowLayout.VERTICAL);
    for i, trait in ipairs(TRAITS) do
        local addTraitButtonFunction = function(
            trait --: string
        )
            local addTraitButton = Button.new("addTraitButton" .. trait, traitSelectionFrame, "SQUARE", "ui/skins/default/parchment_header_min.png");
            addTraitButton:RegisterForClick(
                "addTraitButton" .. trait .. "Listener" .. tostring(math.random()),
                function(context)
                    addTraitCallback(trait);
                    Util.delete(traitSelectionFrame.uic);
                end
            )
            return addTraitButton;
        end
        if not listContains(currentTraits, trait) then
            local traitRow = createTraitRow(trait, traitSelectionFrame, addTraitButtonFunction);
            traitSelectionFrameContainer:AddComponent(traitRow);
        end
    end
    Util.centreComponentOnComponent(traitSelectionFrameContainer, traitSelectionFrame);
    return traitSelectionFrame;
end

--v function(lordTypeButtonsMap: map<string, TEXT_BUTTON>) --> string
function findSelectedLordType(lordTypeButtonsMap)
    local selectedLordType = nil --: string
    for lordType, lordTypeButton in pairs(lordTypeButtonsMap) do
        if lordTypeButton:IsSelected() then
            selectedLordType = lordType;
        end
    end
    return selectedLordType;
end

--v function(skillSetButtonsMap: map<string, TEXT_BUTTON>) --> string
function findSelectedSkillSet(skillSetButtonsMap)
    local selectedSkillSet = nil --: string
    for skillSet, skillSetButton in pairs(skillSetButtonsMap) do
        if skillSetButton:IsSelected() then
            if skillSetButton:Visible() then
                selectedSkillSet = skillSet;
            end
        end
    end
    return selectedSkillSet;
end

--v function(traitButtonMap: map<string, TEXT_BUTTON>) --> string
function findSelectedTrait(traitButtonMap)
    local selectedTrait = nil --: string
    for trait, traitButton in pairs(traitButtonMap) do
        if traitButton:IsSelected() then
            selectedTrait = trait;
        end
    end
    return selectedTrait;
end

--v function(selectedSkillSet: string, selectedTrait: string, lordName: string)
function lordCreated(selectedSkillSet, selectedTrait, lordName)
    cm:force_add_trait_on_selected_character(selectedSkillSet);
    cm:force_add_trait_on_selected_character(selectedTrait);
    
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

    for i = 1, string.len(lordName) do
        textInput:SimulateKey(string.sub(lordName, i, i));
    end

    local popupOkButton = find_uicomponent(core:get_ui_root(), "popup_text_input", "ok_cancel_buttongroup", "button_ok");
    popupOkButton:SimulateLClick();
    find_uicomponent(core:get_ui_root(), "character_details_panel", "button_ok"):SimulateLClick();
end

--v function(xPos: number, yPos: number) --> boolean
function isValidSpawnPoint(xPos, yPos)
    local faction_list = cm:model():world():faction_list();
    for i = 0, faction_list:num_items() - 1 do
        local current_faction = faction_list:item_at(i);
        local char_list = current_faction:character_list();
        for i = 0, char_list:num_items() - 1 do
            local current_char = char_list:item_at(i);
            if current_char:logical_position_x() == xPos and current_char:logical_position_y() == yPos then
                return false;
            end;
        end;
    end;
    return true;
end

--v function(xPos: number, yPos: number) --> (number, number)
function calculateSpawnPoint(xPos, yPos)
    for i = 1, 5 do
        for j = 1, 5 do
            local newX = xPos + i;
            local newY = yPos + j;
            if isValidSpawnPoint(newX, newY) then
                return newX, newY;
            end
        end
    end
    return xPos, yPos;
end

--v function(selectedLordType: string, lordCreatedCallback: function(CA_CQI))
function createLord(selectedLordType, lordCreatedCallback)
    local region = string.sub(tostring(cm:get_campaign_ui_manager().settlement_selected), 12);
    local settlement = get_region(region):settlement();
    local xPos, yPos = calculateSpawnPoint(settlement:logical_position_x(), settlement:logical_position_y());
    cm:create_force_with_general(
        cm:get_local_faction(),
        "wh2_main_skv_inf_clanrats_0",
        region,
        xPos,
        yPos,
        "general",
        selectedLordType,
        "",
        "",
        "",
        "",
        "my_custom_lord",
        false,
        lordCreatedCallback
    );
end

--v function(list: vector<string>, toRemove: string)
function removeFromList(list, toRemove)
    for i, value in ipairs(list) do
        if value == toRemove then
            table.remove(list, i);
            return;
        end
    end
end

function createCustomLordFrame()
    local blocker = nil --: COMPONENT_TYPE
    cm:callback(
        function()
            output("BLOCKER CALLBACK");
            blocker = Util.getComponentWithName("Blocker");
            --# assume blocker : IMAGE
            if not blocker then
                output("NEW BLOCKER");
                blocker = Image.new("Blocker", core:get_ui_root(), "ui/skins/default/icon_end_turn.png");
                blocker:Resize(5000, 5000);
                blocker:MoveTo(-500, -500);
                blocker:SetOpacity(0);
                blocker.uic:PropagatePriority(5);
            else
                output("BLOCKER FOUND");
                blocker:SetVisible(true);
            end
        end, 0.01, "asdasdasd"
    );

    local existingFrame = Util.getComponentWithName("customLordFrame");
    if not existingFrame then
        local customLordFrame = Frame.new("customLordFrame");
        customLordFrame:SetTitle("Create your custom Lord");
        customLordFrame:Resize(customLordFrame:Width(), customLordFrame:Height() * 1.5);
        --Util.centreComponentOnScreen(customLordFrame);
        customLordFrame:MoveTo(50, 100);

        local frameContainer = Container.new(FlowLayout.VERTICAL);        
        local lordName = Text.new("lordName", customLordFrame, "NORMAL", "Name your Lord");
        frameContainer:AddComponent(lordName);
        local lordNameTextBox = TextBox.new("lordNameTextBox", customLordFrame);
        frameContainer:AddComponent(lordNameTextBox);

        local lordTypeText = Text.new("lordTypeText", customLordFrame, "NORMAL", "Select your Lord type");
        frameContainer:AddComponent(lordTypeText);

        local lordTypeButtons = createLordTypeButtons(cm:get_local_faction(), customLordFrame);
        local buttonContainer = Container.new(FlowLayout.HORIZONTAL);
        for i, button in pairs(lordTypeButtons) do
            buttonContainer:AddComponent(button);
        end
        frameContainer:AddComponent(buttonContainer);

        local skillSetText = Text.new("skillSetText", customLordFrame, "NORMAL", "Select your Lord skill-set");
        frameContainer:AddComponent(skillSetText);

        local skillSetButtonsContainer = Container.new(FlowLayout.HORIZONTAL);
        local lordTypeToSkillSetButtons = {} --: map<string, vector<TEXT_BUTTON>>
        local skillSetToButtonMap = {} --: map<string, TEXT_BUTTON>
        for lordType, lordTypeButton in pairs(lordTypeButtons) do
            lordTypeToSkillSetButtons[lordType] = {};
            local skillSetButtons = createSkillSetButtons(lordType, customLordFrame);
            for skillSet, skillSetButton in pairs(skillSetButtons) do
                skillSetButtonsContainer:AddComponent(skillSetButton);
                table.insert(lordTypeToSkillSetButtons[lordType], skillSetButton);
                skillSetToButtonMap[skillSet] = skillSetButton;
                if lordTypeButton:CurrentState() == "selected" then
                    skillSetButton:SetVisible(true);
                else
                    skillSetButton:SetVisible(false);
                end
            end
        end
        for lordType, lordTypeButton in pairs(lordTypeButtons) do
            lordTypeButton:RegisterForClick(lordTypeButton.name .. "SkillSetListener",
                function(context)
                    for otherLordType, skillSetButtons in pairs(lordTypeToSkillSetButtons) do
                        for i, skillSetButton in ipairs(skillSetButtons) do
                            if otherLordType == lordType then
                                skillSetButton:SetVisible(true);
                            else
                                skillSetButton:SetVisible(false);
                            end
                        end
                    end
                    Util.centreComponentOnComponent(frameContainer, customLordFrame);
                end
            );
        end
        frameContainer:AddComponent(skillSetButtonsContainer);

        local traitsText = Text.new("traitsText", customLordFrame, "NORMAL", "Select your Lord traits");
        frameContainer:AddComponent(traitsText);

        local selectedTraits = {} --: vector<string>
        table.insert(selectedTraits, "wh2_main_trait_defeated_teclis");
        local traitToRow = {} --: map<string, CONTAINER>            

        local removeTraitButtonFunction = function(
            trait --: string
        )
            local removeTraitButton = Button.new("removeTraitButton" .. trait .. tostring(math.random()), customLordFrame, "SQUARE", "ui/skins/default/parchment_header_max.png");
            removeTraitButton:RegisterForClick(
                "removeTraitButton" .. trait .. "Listener" .. tostring(math.random()),
                function(context)
                    removeFromList(selectedTraits, trait);
                    traitToRow[trait]:SetVisible(false);
                    Util.centreComponentOnComponent(frameContainer, customLordFrame);
                end
            )
            return removeTraitButton;
        end

        local traitRowsContainer = Container.new(FlowLayout.VERTICAL);
        for i, trait in ipairs(selectedTraits) do
            local traitRow = createTraitRow(trait, customLordFrame, removeTraitButtonFunction);
            traitRowsContainer:AddComponent(traitRow);
            traitToRow[trait] = traitRow;
        end
        frameContainer:AddComponent(traitRowsContainer);

        local addTraitButton = TextButton.new("addTraitButton", customLordFrame, "TEXT", "Add Trait");
        addTraitButton:RegisterForClick(
            "addTraitButtonClickListener", 
            function(context)
                local traitSelectionFrame = createTraitSelectionFrame(selectedTraits, 
                    function(addedTrait)
                        output("trait added: " .. addedTrait);
                        local traitRow = createTraitRow(addedTrait, customLordFrame, removeTraitButtonFunction);
                        traitRowsContainer:AddComponent(traitRow);
                        traitToRow[addedTrait] = traitRow;
                        table.insert(selectedTraits, addedTrait);
                        Util.centreComponentOnComponent(frameContainer, customLordFrame);
                    end
                );
                customLordFrame.uic:Adopt(traitSelectionFrame.uic:Address());
                traitSelectionFrame:PositionRelativeTo(customLordFrame, customLordFrame:Width(), 0);
            end
        );
        frameContainer:AddComponent(addTraitButton);

        Util.centreComponentOnComponent(frameContainer, customLordFrame);


        local lordCreatedCallback = function(
            context --:CA_CQI
        )
            lordCreated(findSelectedSkillSet(skillSetToButtonMap), selectedTraits[1], lordNameTextBox.uic:GetStateText());
        end

        local region = string.sub(tostring(cm:get_campaign_ui_manager().settlement_selected), 12);
        local settlement = get_region(region):settlement();
        customLordFrame:AddCloseButton(
            function()
                createLord(findSelectedLordType(lordTypeButtons), lordCreatedCallback);
                --# assume blocker: IMAGE
                blocker.uic:SetVisible(false);
            end
        );

        customLordFrame.uic:PropagatePriority(100);
    else
        --# assume existingFrame: FRAME
        existingFrame:SetVisible(true); 
    end
end

function attachButtonToLordRecuitment()
    core:add_listener(
        "CustomLordButtonAdder",
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
                    createCustomLordFrame();
                end
            );

            createCustomLordButton:SetVisible(raiseForcesButton:Visible());

            local createArmyButton = find_uicomponent(core:get_ui_root(), "layout", "hud_center_docker", "hud_center", "small_bar", "button_group_settlement", "button_create_army");
            local agentsButton = find_uicomponent(core:get_ui_root(), "layout", "hud_center_docker", "hud_center", "small_bar", "button_group_settlement", "button_agents");
            core:remove_listener("createArmyButtonListener");
            Util.registerForClick(
                createArmyButton, "createArmyButtonListener", 
                function(context)
                    createCustomLordButton:SetVisible(true);
                end
            );
            core:remove_listener("agentsButtonListener");
            Util.registerForClick(
                agentsButton, "agentsButtonListener", 
                function(context)
                    createCustomLordButton:SetVisible(false);
                end
            );
        end,
        true
    );
end

--v function() --> map<string, vector<string>>
function createSkillToSkillSetMap()
    local skillToSkillSetMap = {} --: map<string, vector<string>>
    for skillSet, skillSetSkills in pairs(SKILL_SET_SKILLS) do
        for i, currentSkillSetSkill in ipairs(skillSetSkills) do
            local skillSkillSets = skillToSkillSetMap[currentSkillSetSkill];
            if not skillSkillSets then
                skillSkillSets = {};
                skillToSkillSetMap[currentSkillSetSkill] = skillSkillSets;
            end
            table.insert(skillSkillSets, skillSet);
        end
    end
    return skillToSkillSetMap;
end

--v function() --> CA_CHAR
function getSelectedChar()
    local char = cm:get_campaign_ui_manager():get_char_selected();
    local cqi = string.sub(char, 15);
    --# assume cqi: CA_CQI
    return get_character_by_cqi(cqi);
end

function custom_lords()
    attachButtonToLordRecuitment();
    core:add_listener(
        "CustomLordsSkillHider",
        "PanelOpenedCampaign",
        function(context) 
            return context.string == "character_details_panel"; 
        end,
        function(context)
            local skillToSkillSetMap = createSkillToSkillSetMap();
            local selectedChar = getSelectedChar();
            local chain = find_uicomponent(core:get_ui_root(), "character_details_panel", "background", "skills_subpanel", "listview", "list_clip", "list_box", "chain2", "chain");
            if chain then
                local childCount = chain:ChildCount();
                for i=0, childCount-1  do
                    local child = UIComponent(chain:Find(i));
                    local skillSetFound = false;
                    local skillSkillSet = skillToSkillSetMap[child:Id()];
                    if skillSkillSet then
                        for i, skillSet in ipairs(skillToSkillSetMap[child:Id()]) do
                            if selectedChar:has_trait(skillSet) then
                                skillSetFound = true;
                            end
                        end
                        if not skillSetFound then
                            child:SetVisible(false);
                        end
                    end
                end
            end
        end, 
        true
    );
end

--tooltip generation
--trait --> character_trait_levels --> trait_level_effects --> effects
--                                 --> campaign_effect_scopes

-- build_frame_cross.png
-- icon_cross_square_red.png
-- parchment_header_min.png
-- parchment_header_max.png