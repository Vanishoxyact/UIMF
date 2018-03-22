local Log = require("uic/log");
local Util = require("uic/util");
local Components = require("uic/components");
local TextBox = {} --# assume TextBox: TEXT_BOX

--v function(name: string, parent: CA_UIC | COMPONENT_TYPE) --> TEXT_BOX
function TextBox.new(name, parent)
    local parentComponent = Components.getUiContentComponent(parent);
    parentComponent:CreateComponent(name, "ui/common ui/text_box");
    local textBox = UIComponent(parentComponent:Find(name));

    local self = {};
    setmetatable(self, {
        __index = TextBox
    })
    --# assume self: TEXT_BOX
    self.uic = textBox --: const
    self.name = name --: const
    Util.registerComponent(name, self);    
    Log.write("Created component "..name);
    return self;
end

--v function(self: TEXT_BOX, component: CA_UIC | COMPONENT_TYPE, xDiff: number, yDiff: number)
function TextBox.PositionRelativeTo(self, component, xDiff, yDiff)
    Components.positionRelativeTo(self.uic, component, xDiff, yDiff);
end

--v function(self: TEXT_BOX) --> CA_UIC
function TextBox.GetContentComponent(self)
    return self.uic;
end

--v function(self: TEXT_BOX) --> CA_UIC
function TextBox.GetPositioningComponent(self)
    return self.uic;
end

return {
    new = TextBox.new;
}