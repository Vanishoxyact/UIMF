function trade_goods()
    local playerFaction = get_faction(cm:get_local_faction());
    --local value = playerFaction:trade_value("res_rom_marble");
    --output("trade value:" .. value);
    -- for key,value in pairs(getmetatable(playerFaction)) do
    --     output("found member in faction " .. key);
    -- end

    -- for key,value in pairs(getmetatable(cm)) do
    --     output("found member in cm " .. key);
    -- end

    -- for key,value in pairs(getmetatable(cm:model())) do
    --     output("found member in model " .. key);
    -- end

    -- for key,value in pairs(getmetatable(cm:model():world())) do
    --     output("found member in world " .. key);
    -- end

    --cm:model():world():faction_list();
end

core:add_listener(
    "char_panel_openedasdasdsa",
    "PanelOpenedCampaign",
    function(context) 
        return context.string == "finance_screen"; 
    end,
    function(context)
        output("Diplo opened");
        --cm:enable_all_diplomacy(true);
        -- cm:callback(
        --     function()
        --         --local factions = find_uicomponent(core:get_ui_root(), "diplomacy_dropdown", "faction_panel", "sortable_list_factions");
        --         --print_all_uicomponent_children(factions);
        --         local diploContext = cm:get_diplomacy_panel_context();
        --         if not diploContext then
        --             output("no context");
        --         else
        --             output("diplo context:" .. tostring(diploContext));
        --                 for key,value in pairs(diploContext._index) do
        --             output("found member in diploContext " .. key);
        --             end
        --         end
        --     end, 2, "SDSADD"
        -- );

        -- local vamps = get_faction("wh_main_vmp_rival_sylvanian_vamps");
        -- if not vamps then
        --     output("Failed to find vamps");
        -- end
        -- local diploPanel = find_uicomponent(core:get_ui_root(), "diplomacy_dropdown");
        -- if not vamps then
        --     output("Failed to find diplo");
        -- end
        -- diploPanel:SetContextObject(vamps);
        -- output("Set context to vamps");
        local vamps = get_faction("wh2_main_hef_eataine");
        if not vamps then
            output("Failed to find vamps");
        end
        local diploPanel = find_uicomponent(core:get_ui_root(), "finance_screen");
        if not vamps then
            output("Failed to find diplo");
        end
        --diploPanel:SetContextObject(vamps);
        output("Set context to vamps");
    end, true
)