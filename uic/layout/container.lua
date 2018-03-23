local Gap = require("uic/layout/gap");
local Components = require("uic/components");
local Container = {} --# assume Container: CONTAINER

--v function(layout: LAYOUT) --> CONTAINER
function Container.new(layout)
    local self = {};
    setmetatable(self, {__index = Container});
    --# assume self: CONTAINER
    self.components = {} --: vector<CA_UIC | COMPONENT_TYPE | GAP>
    self.layout = layout;
    return self;
end

--v function(self: CONTAINER, component: CA_UIC | COMPONENT_TYPE | CONTAINER)    
function Container.AddComponent(self, component)
    table.insert(self.components, component);
end

--v function(self: CONTAINER, gapSize: number)    
function Container.AddGap(self, gapSize)
    table.insert(self.components, Gap.new(gapSize));
end

--v function(self: CONTAINER) --> (number, number)
function Container.Bounds(self)
    local layout = self.layout;
    --# assume layout : FLOW_LAYOUT
    return layout:CalculateBounds(self.components);
end

--v function(self: CONTAINER, xPos: number, yPos: number)
function Container.MoveTo(self, xPos, yPos)
    local layout = self.layout;
    --# assume layout : FLOW_LAYOUT
    layout:PositionComponents(self.components, xPos, yPos);
end

--v function(self: CONTAINER, component: CA_UIC | COMPONENT_TYPE, xDiff: number, yDiff: number)
function Container.PositionRelativeTo(self, component, xDiff, yDiff)
    Components.positionRelativeTo(self, component, xDiff, yDiff);
end

return {
    new = Container.new;
}