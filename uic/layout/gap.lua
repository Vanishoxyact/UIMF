local Gap = {};
local GAP_TYPE = "GAP";

--v function(size: number) --> GAP
function Gap.new(size)
    local self = {};
    setmetatable(self, {
        __index = Gap,
        __tostring = function() return GAP_TYPE end
    });
    --# assume self: GAP
    self.size = size;
    return self;
end

--v function(component: any) --> boolean
function Gap.isGap(component)
    return tostring(component) == GAP_TYPE;
end

return {
    new = Gap.new,
    isGap = Gap.isGap;
}