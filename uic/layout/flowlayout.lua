local Gap = require("uic/layout/gap");
local FlowLayout = {} --# assume FlowLayout: FLOW_LAYOUT

--v function(layoutType: FLOW_LAYOUT_TYPE) --> FLOW_LAYOUT
function FlowLayout.new(layoutType)
    local self = {};
    setmetatable(self, {__index = FlowLayout});
    --# assume self: FLOW_LAYOUT
    self.layoutType = layoutType;
    return self;
end

--v function(self: FLOW_LAYOUT, components: vector<CA_UIC | COMPONENT_TYPE | GAP | CONTAINER>) --> (number, number)
function FlowLayout.CalculateBounds(self, components)
    local width, height = tonumber(0), tonumber(0);
    for i, component in ipairs(components) do
        if self.layoutType == "VERTICAL" then
            if Gap.isGap(component) then
                --# assume component: GAP
                height = height + component.size;
            else
                --# assume component: CA_UIC
                if component:Visible() then
                    local componentWidth, componentHeight = component:Bounds();
                    height = height + componentHeight;
                    width = math.max(width, componentWidth);
                end
            end
        else
            if Gap.isGap(component) then
                --# assume component: GAP
                width = width + component.size;
            else
                --# assume component: CA_UIC
                if component:Visible() then
                    local componentWidth, componentHeight = component:Bounds();
                    width = width + componentWidth;
                    height = math.max(height, componentHeight);
                end
            end
        end
    end
    return width, height;
end

--v function(self: FLOW_LAYOUT, components: vector<CA_UIC | COMPONENT_TYPE | GAP | CONTAINER>, xPos: number, yPos: number) 
function FlowLayout.PositionComponents(self, components, xPos, yPos)
    local nextX, nextY = xPos, yPos;
    for i, component in ipairs(components) do
        if self.layoutType == "VERTICAL" then
            if Gap.isGap(component) then
                --# assume component: GAP
                nextY = nextY + component.size;
            else
                --# assume component: CA_UIC
                if component:Visible() then
                    local componentWidth, componentHeight = component:Bounds();
                    component:MoveTo(nextX, nextY);
                    nextY = nextY + componentHeight;
                end
            end
        else
            if Gap.isGap(component) then
                --# assume component: GAP
                nextX = nextX + component.size;
            else
                --# assume component: CA_UIC
                if component:Visible() then
                    local componentWidth, componentHeight = component:Bounds();
                    component:MoveTo(nextX, nextY);
                    nextX = nextX + componentWidth;
                end
            end
        end
    end
end

FlowLayout.VERTICAL = FlowLayout.new("VERTICAL");
FlowLayout.HORIZONTAL = FlowLayout.new("HORIZONTAL");

return {
    VERTICAL = FlowLayout.VERTICAL,
    HORIZONTAL = FlowLayout.HORIZONTAL
}