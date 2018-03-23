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

--v function(self: FLOW_LAYOUT, components: vector<CA_UIC | COMPONENT_TYPE | GAP>) --> (number, number)
function FlowLayout.CalculateBounds(self, components)
    local width, height = tonumber(0), tonumber(0);
    for i, v in ipairs(components) do
        if self.layoutType == "VERTICAL" then
            if Gap.isGap(v) then
                --# assume v: GAP
                height = height + v.size;
            else
                --# assume v: CA_UIC
                local componentWidth, componentHeight = v:Bounds();
                height = height + componentHeight;
                width = math.max(width, componentWidth);
            end
        else
            if Gap.isGap(v) then
                --# assume v: GAP
                width = width + v.size;
            else
                --# assume v: CA_UIC
                local componentWidth, componentHeight = v:Bounds();
                width = width + componentWidth;
                height = math.max(height, componentHeight);
            end
        end
    end
    return width, height;
end

--v function(self: FLOW_LAYOUT, components: vector<CA_UIC | COMPONENT_TYPE | GAP>, xPos: number, yPos: number) 
function FlowLayout.PositionComponents(self, components, xPos, yPos)
    local nextX, nextY = xPos, yPos;
    for i, v in ipairs(components) do
        if self.layoutType == "VERTICAL" then
            if Gap.isGap(v) then
                --# assume v: GAP
                nextY = nextY + v.size;
            else
                --# assume v: CA_UIC
                local componentWidth, componentHeight = v:Bounds();
                v:MoveTo(nextX, nextY);
                nextY = nextY + componentHeight;
            end
        else
            if Gap.isGap(v) then
                --# assume v: GAP
                nextX = nextX + v.size;
            else
                --# assume v: CA_UIC
                local componentWidth, componentHeight = v:Bounds();
                v:MoveTo(nextX, nextY);
                nextX = nextX + componentWidth;
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