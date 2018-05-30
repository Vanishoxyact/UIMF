local Gap = require("uic/layout/gap");
local Components = require("uic/components");
local Container = {} --# assume Container: CONTAINER
local CONTAINER_TYPE = "CONTAINER";

--v function(layout: LAYOUT) --> CONTAINER
function Container.new(layout)
    local self = {};
    setmetatable(self, {
        __index = Container,
        __tostring = function() return CONTAINER_TYPE end
    });
    --# assume self: CONTAINER
    self.components = {} --: vector<CA_UIC | COMPONENT_TYPE | GAP | CONTAINER>
    self.layout = layout;
    self.xPos = tonumber(0);
    self.yPos = tonumber(0);
    self.visible = true;
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

--v function(self: CONTAINER) --> (number, number)
function Container.Position(self)
    return self.xPos, self.yPos;
end

--v function(self: CONTAINER) --> boolean
function Container.Visible(self)
    return self.visible;
end

--v function(self: CONTAINER, visible: boolean)
function Container.SetVisible(self, visible)
    for i, component in ipairs(self.components) do
        if Gap.isGap(component) then
            -- Do nothing
        else
            --# assume component: CA_UIC
            component:SetVisible(visible);
        end
    end
    self.visible = visible;
end

--v function(self: CONTAINER, xPos: number, yPos: number)
function Container.MoveTo(self, xPos, yPos)
    local layout = self.layout;
    --# assume layout : FLOW_LAYOUT
    layout:PositionComponents(self.components, xPos, yPos);
    self.xPos = xPos;
    self.yPos = yPos;
end

--v function(self: CONTAINER, component: CA_UIC | COMPONENT_TYPE, xDiff: number, yDiff: number)
function Container.PositionRelativeTo(self, component, xDiff, yDiff)
    Components.positionRelativeTo(self, component, xDiff, yDiff);
end

--v function(component: any) --> boolean
function Container.isContainer(component)
    return tostring(component) == CONTAINER_TYPE;
end

--v function(self: CONTAINER)
function Container.Reposition(self)
    self:MoveTo(self:Position());
end

Container.RecursiveRetrieveAllComponents = nil --: function(self: CONTAINER) --> vector<CA_UIC | COMPONENT_TYPE>
--v function(self: CONTAINER) --> vector<CA_UIC | COMPONENT_TYPE>
function Container.RecursiveRetrieveAllComponents(self)
    local allComponents = {} --: vector<CA_UIC | COMPONENT_TYPE>
    for i, component in ipairs(self.components) do
        if Container.isContainer(component) then
            --# assume component: CONTAINER
            local containerComponents = component:RecursiveRetrieveAllComponents();
            for i, containerComponent in ipairs(containerComponents) do
                table.insert(allComponents, containerComponent);
            end
        elseif Gap.isGap(component) then
             -- Do nothing
        else
            table.insert(allComponents, component);
        end
    end
    return allComponents;
end

Container.Clear = nil --: function(self: CONTAINER)
--v function(self: CONTAINER)
function Container.Clear(self)
    for i, component in ipairs(self.components) do
        if is_uicomponent(component) then
            --# assume component: CA_UIC
            Util.delete(component);
        elseif Container.isContainer(component) then
            --# assume component: CONTAINER
            component:Clear();
        elseif Gap.isGap(component) then
            -- Do nothing
        else
            --# assume component: BUTTON
            component:Delete();
        end
    end
    self.components = {};
end

--v function(self: CONTAINER)
function Container.Empty(self)
    self.components = {};
end

return {
    new = Container.new;
    isContainer = Container.isContainer;
}