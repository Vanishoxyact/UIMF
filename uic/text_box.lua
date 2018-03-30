local Log = require("uic/log");
local Util = require("uic/util");
local Components = require("uic/components");
local TextBox = {} --# assume TextBox: TEXT_BOX

--v function(name: string, parent: CA_UIC | COMPONENT_TYPE) --> TEXT_BOX
function TextBox.new(name, parent)
    local parentComponent = Components.getUiContentComponent(parent);
    local textBox = Util.createComponent(name, parentComponent, "ui/common ui/text_box");
    
    local self = {};
    setmetatable(self, {
        __index = TextBox
    })
    --# assume self: TEXT_BOX
    self.uic = textBox --: const
    self.name = name --: const
    Util.registerComponent(name, self);    
    return self;
end

-- Component functions

--v function(self: TEXT_BOX, xPos: number, yPos: number)
function TextBox.MoveTo(self, xPos, yPos) 
    self.uic:MoveTo(xPos, yPos);
end

--v function(self: TEXT_BOX, xMove: number, yMove: number)
function TextBox.Move(self, xMove, yMove)
    Components.move(self.uic, xMove, yMove);
end

--v function(self: TEXT_BOX, component: CA_UIC | COMPONENT_TYPE, xDiff: number, yDiff: number)
function TextBox.PositionRelativeTo(self, component, xDiff, yDiff)
    Components.positionRelativeTo(self.uic, component, xDiff, yDiff);
end

--v function(self: TEXT_BOX, factor: number)
function TextBox.Scale(self, factor)
    Components.scale(self.uic, factor);
end

--v function(self: TEXT_BOX, width: number, height: number)
function TextBox.Resize(self, width, height)
    Components.resize(self.uic, width, height);
end

--v function(self: TEXT_BOX) --> (number, number)
function TextBox.Position(self)
    return self.uic:Position();
end

--v function(self: TEXT_BOX) --> (number, number)
function TextBox.Bounds(self)
    return self.uic:Bounds();
end

--v function(self: TEXT_BOX) --> number
function TextBox.XPos(self)
    local xPos, yPos = self:Position();
    return xPos;
end

--v function(self: TEXT_BOX) --> number
function TextBox.YPos(self)
    local xPos, yPos = self:Position();
    return yPos;
end

--v function(self: TEXT_BOX) --> number
function TextBox.Width(self)
    local width, height = self:Bounds();
    return width;
end

--v function(self: TEXT_BOX) --> number
function TextBox.Height(self)
    local width, height = self:Bounds();
    return height;
end

--v function(self: TEXT_BOX, visible: boolean)
function TextBox.SetVisible(self, visible)
    return self.uic:SetVisible(visible);
end

--v function(self: TEXT_BOX) --> boolean
function TextBox.Visible(self)
    return self.uic:Visible();
end

--v function(self: TEXT_BOX) --> CA_UIC
function TextBox.GetContentComponent(self)
    return self.uic;
end

--v function(self: TEXT_BOX) --> CA_UIC
function TextBox.GetPositioningComponent(self)
    return self.uic;
end

--v function(self: TEXT_BOX)
function TextBox.Delete(self) 
    Util.delete(self.uic);
    Util.unregisterComponent(self.name);
end

-- Custom functions

--v function(self: TEXT_BOX) --> string
function TextBox.GetText(self)
    return self.uic:GetStateText();
end

return {
    new = TextBox.new;
}