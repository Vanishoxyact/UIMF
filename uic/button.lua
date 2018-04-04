local Log = require("uic/log");
local Util = require("uic/util");
local Components = require("uic/components");
local Button = {} --# assume Button: BUTTON

local States = {
    "active", "hover", "down", 
    "selected", "selected_hover", "selected_down",
    "drop_down"
} --: vector<BUTTON_STATE>

--v function(name: string, parent: CA_UIC | COMPONENT_TYPE, buttonType: BUTTON_TYPE, imagePath: string) --> BUTTON
function Button.new(name, parent, buttonType, imagePath)
    local parentComponent = Components.getUiContentComponent(parent);
    local self = {};
    local button = nil --: CA_UIC
    if buttonType == "CIRCULAR" then
        button = Util.createComponent(name, parentComponent, "ui/templates/round_medium_button");
    elseif buttonType == "SQUARE" then
        button = Util.createComponent(name, parentComponent, "ui/templates/square_medium_button");
    elseif buttonType == "CIRCULAR_TOGGLE" then
        button = Util.createComponent(name, parentComponent, "ui/templates/round_medium_button_toggle");
    elseif buttonType == "SQUARE_TOGGLE" then
        button = Util.createComponent(name, parentComponent, "ui/templates/square_medium_button_toggle");
    else
        Log.write("Invalid button type:" .. buttonType);
    end

    button:SetImage(imagePath);
    
    setmetatable(self, {__index = Button});
    --# assume self: BUTTON
    self.uic = button --: const
    self.name = name --: const
    self.buttonType = buttonType --: const
    self.listeners = {} --: vector<string>
    Util.registerComponent(name, self); 
    return self;
end

-- Component functions

--v function(self: BUTTON, xPos: number, yPos: number)
function Button.MoveTo(self, xPos, yPos) 
    self.uic:MoveTo(xPos, yPos);
end

--v function(self: BUTTON, xMove: number, yMove: number)
function Button.Move(self, xMove, yMove)
    Components.move(self.uic, xMove, yMove);
end

--v function(self: BUTTON, component: CA_UIC | COMPONENT_TYPE, xDiff: number, yDiff: number)
function Button.PositionRelativeTo(self, component, xDiff, yDiff)
    Components.positionRelativeTo(self.uic, component, xDiff, yDiff);
end

--v function(self: BUTTON, factor: number)
function Button.Scale(self, factor)
    Components.scale(self.uic, factor);
end

--v function(self: BUTTON, width: number, height: number)
function Button.Resize(self, width, height)
    Components.resize(self.uic, width, height);
end

--v function(self: BUTTON) --> (number, number)
function Button.Position(self)
    return self.uic:Position();
end

--v function(self: BUTTON) --> (number, number)
function Button.Bounds(self)
    return self.uic:Bounds();
end

--v function(self: BUTTON) --> number
function Button.XPos(self)
    local xPos, yPos = self:Position();
    return xPos;
end

--v function(self: BUTTON) --> number
function Button.YPos(self)
    local xPos, yPos = self:Position();
    return yPos;
end

--v function(self: BUTTON) --> number
function Button.Width(self)
    local width, height = self:Bounds();
    return width;
end

--v function(self: BUTTON) --> number
function Button.Height(self)
    local width, height = self:Bounds();
    return height;
end

--v function(self: BUTTON, visible: boolean)
function Button.SetVisible(self, visible)
    return self.uic:SetVisible(visible);
end

--v function(self: BUTTON) --> boolean
function Button.Visible(self)
    return self.uic:Visible();
end

--v function(self: BUTTON) --> CA_UIC
function Button.GetContentComponent(self)
    return self.uic;
end

--v function(self: BUTTON) --> CA_UIC
function Button.GetPositioningComponent(self)
    return self.uic;
end

--v function(self: BUTTON)
function Button.Delete(self) 
    Util.delete(self.uic);
    Util.unregisterComponent(self.name);
    for i, listener in ipairs(self.listeners) do
        core:remove_listener(listener);
    end
end

-- Custom functions

--v function(self: BUTTON)
function Button.ClearSound(self)
    self.uic:ClearSound();
end

--v function(self: BUTTON, state: BUTTON_STATE)
function Button.SetState(self, state)
    self.uic:SetState(state);
end

--v function(self: BUTTON) --> BUTTON_STATE
function Button.CurrentState(self)
    return self.uic:CurrentState();
end

--v function(self: BUTTON) --> boolean
function Button.IsSelected(self)
    local state = self.uic:CurrentState();
    if state == "active" or state == "hover" or state == "down" then
        return false;
    else
        return true;
    end
end

--v function(button: BUTTON) --> string
local function calculateButtonListenerName(button)
    return button.name .. "ClickListener" .. #button.listeners;
end

--v function(self: BUTTON, callback: function(context: CA_UIContext), listenerName: string?)
function Button.RegisterForClick(self, callback, listenerName)
    local registerListenerName = nil --: string
    if not listenerName then
        registerListenerName = calculateButtonListenerName(self);
    else
        registerListenerName = listenerName;
    end
    Util.registerForClick(self.uic, registerListenerName, callback);
    table.insert(self.listeners, registerListenerName);
end

--v function(self: BUTTON, path: string)
function Button.SetImage(self, path)
    self.uic:SetImage(path);
end

--v function(self: BUTTON, disabled: boolean)
function Button.SetDisabled(self, disabled)
    Components.disableComponent(self.uic, disabled);
end

return {
    new = Button.new;
}
