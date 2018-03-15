local Log = require("uic/log");
local Util = require("uic/util");
local Components = require("uic/components");
local TextButton = {} --# assume TextButton: TEXT_BUTTON

local States = {
    "active", "hover", "down", 
    "selected", "selected_hover", "selected_down",
    "drop_down"
} --: vector<BUTTON_STATE>

--v function(name: string, parent: CA_UIC | COMPONENT_TYPE, buttonType: TEXT_BUTTON_TYPE, buttonText: string) --> TEXT_BUTTON
function TextButton.new(name, parent, buttonType, buttonText)
    local parentComponent = Components.getUiContentComponent(parent);    
    local textButton = nil --: CA_UIC
    local textButtonText = nil --: CA_UIC
    if buttonType == "TEXT" then
        textButton = Util.createComponent(
            name, parentComponent, "ui/campaign ui/intrigue_panel",
            "button_improve"
        );
        textButtonText = UIComponent(textButton:Find("button_txt"));
        Util.delete(UIComponent(textButton:Find("att_frame")));
        Util.delete(UIComponent(textButton:Find("dy_cost")));
    elseif buttonType == "TEXT_TOGGLE" then
        textButton = Util.createComponent(
            name, parentComponent, "ui/campaign ui/finance_screen",
            "TabGroup", "tab_summary"
        );
        textButtonText = UIComponent(textButton:Find("tx_details"));
        Util.delete(UIComponent(textButton:Find("summary")));
    else
        Log.write("Invalid text button type:" .. buttonType);
    end

    textButtonText:SetStateText(buttonText);

    local self = {};
    setmetatable(self, {__index = TextButton});
    --# assume self: TEXT_BUTTON
    self.uic = textButton --: const
    self.name = name --: const
    self.buttonType = buttonType --: const
    self.textButtonText = textButtonText --: const
    return self;
end

--TODO
--v function(self: TEXT_BUTTON)
function TextButton.ClearSound(self)
    self.uic:ClearSound();
end

--TODO
--v function(self: TEXT_BUTTON, x: number, y: number)
function TextButton.MoveTo(self, x, y) 
    self.uic:MoveTo(x, y);
end

--TODO
--v function(self: TEXT_BUTTON, state: BUTTON_STATE)
function TextButton.SetState(self, state) 
    self.uic:SetState(state);
end

--TODO
--v function(self: TEXT_BUTTON, text: string)
function TextButton.SetTooltipText(self, text) 
    local saved = self.uic:CurrentState();
    
    -- Make sure the default tooltip "Cancel" will
    -- be replace by the custom one for each possible state
    for index, state in ipairs(States) do
        self:SetState(state);
        self.uic:SetTooltipText(text);
    end

    self:SetState(saved);
end

--v function(self: TEXT_BUTTON)
function TextButton.Delete(self) 
    Util.delete(self.uic);
end

--v function(self: TEXT_BUTTON) --> boolean
function TextButton.IsSelected(self)
    local state = self.uic:CurrentState();
    if state == "active" or state == "hover" or state == "down" then
        return false;
    else
        return true;
    end
end

--v function(self: TEXT_BUTTON, text: string)
function TextButton.SetButtonText(self, text)
    self.textButtonText:SetStateText(text);
end

--v function(self: TEXT_BUTTON) --> CA_UIC
function TextButton.GetContentComponent(self)
    return self.uic;
end

return {
    new = TextButton.new;
}
