--# assume global class BUTTON

local Log = require("uic/log");
local Util = require("uic/util");
local Button = {} --# assume Button: BUTTON

--TODO
local States = {
    "active", "down", "drop_down",
    "hover", "inactive", "selected"
} --: vector<string>

--# type global BUTTON_TYPE = 
--# "CIRCULAR" | "SQUARE" | "TEXT" |
--# "CIRCULAR_TOGGLE" | "SQUARE_TOGGLE" | "TEXT_TOGGLE"

--v function(name: string, parent: CA_UIC, buttonType: BUTTON_TYPE, imagePathOrText: string) --> BUTTON
function Button.new(name, parent, buttonType, imagePathOrText)
    local self = {};
    self.buttonText = nil --: CA_UIC
    local button = nil --: CA_UIC
    if buttonType == "CIRCULAR" then
        button = Util.createComponent(
            name, parent, "ui/campaign ui/clan",
            "main", "button_ok"
        );
        button:SetImage(imagePathOrText);
    elseif buttonType == "SQUARE" then
        button = Util.createComponent(
            name, parent, "ui/campaign ui/character_details_panel",
            "background", "bottom_buttons", "button_event_feed"
        );
        button:SetImage(imagePathOrText);
    elseif buttonType == "TEXT" then
        button = Util.createComponent(
            name, parent, "ui/campaign ui/intrigue_panel",
            "button_improve"
        );
        local buttonText = UIComponent(button:Find("button_txt"));
        Util.delete(UIComponent(button:Find("att_frame")));
        Util.delete(UIComponent(button:Find("dy_cost")));
        self.buttonText = buttonText;
        buttonText:SetStateText(imagePathOrText);
    elseif buttonType == "CIRCULAR_TOGGLE" then
        Log.write(buttonType .. " not yet supported");
    elseif buttonType == "SQUARE_TOGGLE" then
        button = Util.createComponent(
            name, parent, "ui/campaign ui/objectives_screen",
            "TabGroup", "tab_victory_conditions", "tab_child", "tree_holder", "victory_type_tree", "slot_parent", "wh_main_victory_type_long"
        );
        button:SetImage(imagePathOrText);
    elseif buttonType == "TEXT_TOGGLE" then
        button = Util.createComponent(
            name, parent, "ui/campaign ui/finance_screen",
            "TabGroup", "tab_summary"
        );
        local buttonText = UIComponent(button:Find("tx_details"));
        Util.delete(UIComponent(button:Find("summary")));
        self.buttonText = buttonText;        
        buttonText:SetStateText(imagePathOrText);
    else
        Log.write("Invalid button type:" .. buttonType);
    end

    setmetatable(self, {__index = Button});
    --# assume self: BUTTON
    self.uic = button --: const
    self.name = name --: const
    self.buttonType = buttonType --: const
    return self;
end

--TODO
--v function(self: BUTTON)
function Button.ClearSound(self)
    self.uic:ClearSound();
end

--TODO
--v function(self: BUTTON, x: number, y: number)
function Button.MoveTo(self, x, y) 
    self.uic:MoveTo(x, y);
end

--TODO
--v function(self: BUTTON, state: string)
function Button.SetState(self, state) 
    self.uic:SetState(state);
end

--TODO
--v function(self: BUTTON, text: string)
function Button.SetTooltipText(self, text) 
    local saved = self.uic:CurrentState();
    
    -- Make sure the default tooltip "Cancel" will
    -- be replace by the custom one for each possible state
    for index, state in ipairs(States) do
        self:SetState(state);
        self.uic:SetTooltipText(text);
    end

    self:SetState(saved);
end

--v function(self: BUTTON)
function Button.Delete(self) 
    Util.delete(self.uic);
end


return {
    new = Button.new;
}
