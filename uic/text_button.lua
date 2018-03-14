--# assume global class TEXT_BUTTON

local Log = require("uic/log");
local Util = require("uic/util");
local TextButton = {} --# assume TextButton: TEXT_BUTTON

--TODO
local States = {
    "active", "down", "drop_down",
    "hover", "inactive", "selected"
} --: vector<string>

--# type global TEXT_BUTTON_TYPE = 
--# "TEXT" | "TEXT_TOGGLE"

--v function(name: string, parent: CA_UIC, buttonType: TEXT_BUTTON_TYPE, buttonText: string) --> TEXT_BUTTON
function TextButton.new(name, parent, buttonType, buttonText)
    local textButton = nil --: CA_UIC
    local textButtonText = nil --: CA_UIC
    if buttonType == "TEXT" then
        textButton = Util.createComponent(
            name, parent, "ui/campaign ui/intrigue_panel",
            "button_improve"
        );
        textButtonText = UIComponent(textButton:Find("button_txt"));
        Util.delete(UIComponent(textButton:Find("att_frame")));
        Util.delete(UIComponent(textButton:Find("dy_cost")));
    elseif buttonType == "TEXT_TOGGLE" then
        textButton = Util.createComponent(
            name, parent, "ui/campaign ui/finance_screen",
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
--v function(self: BUTTON)
function TextButton.ClearSound(self)
    self.uic:ClearSound();
end

--TODO
--v function(self: BUTTON, x: number, y: number)
function TextButton.MoveTo(self, x, y) 
    self.uic:MoveTo(x, y);
end

--TODO
--v function(self: BUTTON, state: string)
function TextButton.SetState(self, state) 
    self.uic:SetState(state);
end

--TODO
--v function(self: BUTTON, text: string)
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

--v function(self: BUTTON)
function TextButton.Delete(self) 
    Util.delete(self.uic);
end


return {
    new = TextButton.new;
}
