local Log = require("uic/log");
local Util = require("uic/util");
local Components = require("uic/components");
local Dummy = {} --# assume Dummy: DUMMY
local DUMMY_COUNT = 0;

--v function(parent: CA_UIC | COMPONENT_TYPE) --> DUMMY
function Dummy.new(parent)
    local parentComponent = Components.getUiContentComponent(parent);
    local name = "DUMMY" .. DUMMY_COUNT;
    local dummy = Util.createComponent(name, parentComponent, "UI/campaign ui/script_dummy");
    DUMMY_COUNT = DUMMY_COUNT + 1;

    local self = {};
    setmetatable(self, {
        __index = Dummy
    })
    --# assume self: DUMMY
    self.uic = dummy --: const
    self.name = name --: const
    Util.registerComponent(name, self);    
    return self;
end

-- Component functions

--v function(self: DUMMY, xPos: number, yPos: number)
function Dummy.MoveTo(self, xPos, yPos) 
    self.uic:MoveTo(xPos, yPos);
end

--v function(self: DUMMY, xMove: number, yMove: number)
function Dummy.Move(self, xMove, yMove)
    Components.move(self.uic, xMove, yMove);
end

--v function(self: DUMMY, component: CA_UIC | COMPONENT_TYPE, xDiff: number, yDiff: number)
function Dummy.PositionRelativeTo(self, component, xDiff, yDiff)
    Components.positionRelativeTo(self.uic, component, xDiff, yDiff);
end

--v function(self: DUMMY, factor: number)
function Dummy.Scale(self, factor)
    Components.scale(self.uic, factor);
end

--v function(self: DUMMY, width: number, height: number)
function Dummy.Resize(self, width, height)
    Components.resize(self.uic, width, height);
end

--v function(self: DUMMY) --> (number, number)
function Dummy.Position(self)
    return self.uic:Position();
end

--v function(self: DUMMY) --> (number, number)
function Dummy.Bounds(self)
    return self.uic:Bounds();
end

--v function(self: DUMMY) --> number
function Dummy.XPos(self)
    local xPos, yPos = self:Position();
    return xPos;
end

--v function(self: DUMMY) --> number
function Dummy.YPos(self)
    local xPos, yPos = self:Position();
    return yPos;
end

--v function(self: DUMMY) --> number
function Dummy.Width(self)
    local width, height = self:Bounds();
    return width;
end

--v function(self: DUMMY) --> number
function Dummy.Height(self)
    local width, height = self:Bounds();
    return height;
end

--v function(self: DUMMY, visible: boolean)
function Dummy.SetVisible(self, visible)
    return self.uic:SetVisible(visible);
end

--v function(self: DUMMY) --> boolean
function Dummy.Visible(self)
    return self.uic:Visible();
end

--v function(self: DUMMY) --> CA_UIC
function Dummy.GetContentComponent(self)
    return self.uic;
end

--v function(self: DUMMY) --> CA_UIC
function Dummy.GetPositioningComponent(self)
    return self.uic;
end

--v function(self: DUMMY)
function Dummy.Delete(self) 
    Util.delete(self.uic);
    Util.unregisterComponent(self.name);
end

return {
    new = Dummy.new;
}