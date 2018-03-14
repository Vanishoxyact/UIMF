--# assume global class TEXT

local Log = require("uic/log");
local Util = require("uic/util");

local Text = {} --# assume Text: TEXT

--v function(name: string, parent: CA_UIC, textToDisplay: string) --> TEXT
function Text.new(name, parent, textToDisplay)
    --centered?
    --local text = Util.createComponent(
    --    name, parent, "ui/campaign ui/objectives_screen",
    --    "panel_title", "tx_objectives"
    --);

    --weird font, left aligned
    --local text = Util.createComponent(
    --    name, parent, "ui/campaign ui/clan",
    --    "main", "tab_children_parent", "Summary", "portrait_frame", "parchment_L", "details"
    --);
    --default test, left aligned
    local text = Util.createComponent(
        name, parent, "ui/campaign ui/clan",
        "main", "tab_children_parent", "Summary", "portrait_frame", "parchment_L", "details", "details_list", "tx_home-region"
    );
    text:DestroyChildren();


    --root:CreateComponent("MagaTemp", "ui/campaign ui/events");
    --text = find_uicomponent_by_table(temp,
    --    "event_dilemma_active", "dilemma", "main_holder", "title_holder"
    --)
    --text = find_uicomponent(temp,
    --    "event_dilemma_active", "dilemma", "main_holder", "details_holder"
    --)
    text:SetStateText(textToDisplay);

    local self = {};
    setmetatable(self, {
        __index = Text
    })
    --# assume self: TEXT
    self.uic = text --: const
    self.name = name --: const
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
    self.uic:Resize(w, h);
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
function Text.SetStateText(self, text) 
    self.uic:SetStateText(text);
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