--# assume global class BUTTON

local Log = require("uic/log");
local Util = require("uic/util");
local Button = {} --# assume Button: BUTTON

local States = {
    "active", "hover", "down", 
    "selected", "selected_hover", "selected_down",
    "drop_down"
} --: vector<string>

--# type global BUTTON_TYPE = 
--# "CIRCULAR" | "SQUARE" | "CIRCULAR_TOGGLE" | "SQUARE_TOGGLE"

--v function(name: string, parent: CA_UIC | COMPONENT_TYPES, buttonType: BUTTON_TYPE, imagePath: string) --> BUTTON
function Button.new(name, parent, buttonType, imagePath)
    local self = {};
    local button = nil --: CA_UIC
    if buttonType == "CIRCULAR" then
        button = Util.createComponent(
            name, parent, "ui/campaign ui/clan",
            "main", "button_ok"
        );
        button:SetImage(imagePath);
    elseif buttonType == "SQUARE" then
        button = Util.createComponent(
            name, parent, "ui/campaign ui/character_details_panel",
            "background", "bottom_buttons", "button_event_feed"
        );
        button:SetImage(imagePath);
    elseif buttonType == "CIRCULAR_TOGGLE" then
        Log.write(buttonType .. " not yet supported");
    elseif buttonType == "SQUARE_TOGGLE" then
        button = Util.createComponent(
            name, parent, "ui/campaign ui/objectives_screen",
            "TabGroup", "tab_victory_conditions", "tab_child", "tree_holder", "victory_type_tree", "slot_parent", "wh_main_victory_type_long"
        );
        button:SetImage(imagePath);
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

--v function(self: BUTTON) --> boolean
function Button.IsSelected(self)
    local state = self.uic:CurrentState();
    if state == "active" or state == "hover" or state == "down" then
        return false;
    else
        return true;
    end
end

--v function(self: BUTTON)
function Button.Delete(self) 
    Util.delete(self.uic);
end

--v function(self: BUTTON) --> CA_UIC
function Button.GetContentComponent(self)
    return self.uic;
end

return {
    new = Button.new;
}
