local Log = require("uic/log");
local Util = require("uic/util");
local Components = require("uic/components");

local Text = {} --# assume Text: TEXT

--v function(name: string, parent: CA_UIC | COMPONENT_TYPE, textType: TEXT_TYPE, textToDisplay: string) --> TEXT
function Text.new(name, parent, textType, textToDisplay)
    local parentComponent = Components.getUiContentComponent(parent);
    local text = nil --: CA_UIC
    if textType == "NORMAL" then
        text = Util.createComponent(
            name, parentComponent, "ui/campaign ui/clan",
            "main", "tab_children_parent", "Summary", "portrait_frame", "parchment_L", "details", "details_list", "tx_home-region"
        );
    elseif textType == "WRAPPED" then
        text = Util.createComponent(
            name, parentComponent, "ui/campaign ui/mission_details",
            "mission_details_child", "description_background", "description_view", "dy_description"
        );
    elseif textType == "TITLE" then
        text = Util.createComponent(
            name, parentComponent, "ui/campaign ui/objectives_screen",
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
    Util.registerComponent(name, self); 
    return self;
end

-- Component functions

--v function(self: TEXT, xPos: number, yPos: number)
function Text.MoveTo(self, xPos, yPos) 
    self.uic:MoveTo(xPos, yPos);
end

--v function(self: TEXT, xMove: number, yMove: number)
function Text.Move(self, xMove, yMove)
    Components.move(self.uic, xMove, yMove);
end

--v function(self: TEXT, component: CA_UIC | COMPONENT_TYPE, xDiff: number, yDiff: number)
function Text.PositionRelativeTo(self, component, xDiff, yDiff)
    Components.positionRelativeTo(self.uic, component, xDiff, yDiff);
end

--v function(self: TEXT, factor: number)
function Text.Scale(self, factor)
    if self.textType == "WRAPPED" then
        Log.write("Cannot scale text of type : WRAPPED for : " .. self.name);
    else
        Components.scale(self.uic, factor);
    end
end

--v function(self: TEXT, width: number, height: number)
function Text.Resize(self, width, height)
    Components.resize(self.uic, width, height);
end

--v function(self: TEXT) --> (number, number)
function Text.Position(self)
    return self.uic:Position();
end

--v function(self: TEXT) --> (number, number)
function Text.Bounds(self)
    return self.uic:Bounds();
end

--v function(self: TEXT) --> number
function Text.XPos(self)
    local xPos, yPos = self:Position();
    return xPos;
end

--v function(self: TEXT) --> number
function Text.YPos(self)
    local xPos, yPos = self:Position();
    return yPos;
end

--v function(self: TEXT) --> number
function Text.Width(self)
    local width, height = self:Bounds();
    return width;
end

--v function(self: TEXT) --> number
function Text.Height(self)
    local width, height = self:Bounds();
    return height;
end

--v function(self: TEXT, visible: boolean)
function Text.SetVisible(self, visible)
    return self.uic:SetVisible(visible);
end

--v function(self: TEXT) --> CA_UIC
function Text.GetContentComponent(self)
    return self.uic;
end

--v function(self: TEXT) --> CA_UIC
function Text.GetPositioningComponent(self)
    return self.uic;
end

--v function(self: TEXT)
function Text.Delete(self) 
    Util.delete(self.uic);
end

-- Custom functions

--v function(self: TEXT, text: string)
function Text.SetText(self, text) 
    local xPos, yPos = self.uic:Position();
    self.uic:SetStateText(text);
    self.uic:MoveTo(xPos, yPos);
end

--v function(self: TEXT) --> string
function Text.GetText(self)
    return self.uic:GetStateText();
end

return {
    new = Text.new;
}