local Log = require("uic/log");
local Util = require("uic/util");
require("uic/components");

local Text = {} --# assume Text: TEXT

--# type global TEXT_TYPE = 
--# "NORMAL" | "WRAPPED" | "TITLE"

-- "ui/campaign ui/objectives_screen","panel_title", "tx_objectives" -- Titles
-- "ui/campaign ui/clan","main", "tab_children_parent", "Summary", "portrait_frame", "parchment_L", "details", "details_list", "tx_home-region" -- Simple left aligned, no wrap
-- "event_dilemma_active", "dilemma", "main_holder", "details_holder" -- Different font

--v function(name: string, parent: CA_UIC, textType: TEXT_TYPE, textToDisplay: string) --> TEXT
function Text.new(name, parent, textType, textToDisplay)
    local text = nil --: CA_UIC
    if textType == "NORMAL" then
        text = Util.createComponent(
            name, parent, "ui/campaign ui/clan",
            "main", "tab_children_parent", "Summary", "portrait_frame", "parchment_L", "details", "details_list", "tx_home-region"
        );
    elseif textType == "WRAPPED" then
        text = Util.createComponent(
            name, parent, "ui/campaign ui/mission_details",
            "mission_details_child", "description_background", "description_view", "dy_description"
        );
    elseif textType == "TITLE" then
        text = Util.createComponent(
            name, parent, "ui/campaign ui/objectives_screen",
            "panel_title", "tx_objectives"
        );
    else
        Log.write("Invalid text type:" .. textType);
    end

    text:DestroyChildren();
    text:SetStateText(textToDisplay);

    local self = {};
    setmetatable(self, {
        __index = Text
    })
    --# assume self: TEXT
    self.uic = text --: const
    self.name = name --: const
    self.textType = textType --: const
    return self;
end

--v function(self: TEXT, x: number, y: number)
function Text.MoveTo(self, x, y) 
    self.uic:MoveTo(x, y);
end

--v function(self: TEXT) --> (number, number)
function Text.Position(self) 
    return self.uic:Position();
end

--v function(self: TEXT, w: number, h: number)
function Text.Resize(self, w, h)
    if self.textType == "WRAPPED" then
        Log.write("Cannot resize text of type : WRAPPED for : " .. self.name);
    else
        self.uic:Resize(w, h);
    end
end

--v function(self: TEXT, interactive: boolean)
function Text.SetInteractive(self, interactive) 
    self.uic:SetInteractive(interactive);
end

--v function(self: TEXT, visible: boolean)
function Text.SetVisible(self, visible)
    self.uic:SetVisible(visible);
end

--v function(self: TEXT, text: string)
function Text.SetText(self, text) 
    local xPos, yPos = self.uic:Position();
    self.uic:SetStateText(text);
    self.uic:MoveTo(xPos, yPos);
end

--v function(self: TEXT) --> string
function Text.GetStateText(self)
    return self.uic:GetStateText();
end

--v function(self: TEXT)
function Text.Delete(self) 
    Util.delete(self.uic);
end

return {
    new = Text.new;
}