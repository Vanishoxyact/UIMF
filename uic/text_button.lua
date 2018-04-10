local Log = require("uic/log");
local Util = require("uic/util");
local Components = require("uic/components");
local TextButton = {} --# assume TextButton: TEXT_BUTTON

local States = {
    "active", "hover", "down", 
    "selected", "selected_hover", "selected_down",
    "drop_down"
} --: vector<BUTTON_STATE>

--v function(name: string, parent: CA_UIC | COMPONENT_TYPE, buttonType: TEXT_BUTTON_TYPE, buttonText: string) --> TEXT_BUTTON
function TextButton.new(name, parent, buttonType, buttonText)
    local parentComponent = Components.getUiContentComponent(parent);    
    local textButton = nil --: CA_UIC
    local textButtonText = nil --: CA_UIC
    if buttonType == "TEXT" then
        textButton = Util.createComponent(name, parentComponent, "ui/templates/square_large_text_button");
        textButtonText = UIComponent(textButton:Find("button_txt"));
    elseif buttonType == "TEXT_TOGGLE" then
        textButton = Util.createComponent(name, parentComponent, "ui/templates/square_large_text_button_toggle");
        textButtonText = UIComponent(textButton:Find("button_txt"));
    else
        Log.write("Invalid text button type:" .. buttonType);
    end

    textButtonText:SetStateText(buttonText);

    local self = {};
    setmetatable(self, {__index = TextButton});
    --# assume self: TEXT_BUTTON
    self.uic = textButton --: const
    self.name = name --: const
    self.buttonType = buttonType --: const
    self.textButtonText = textButtonText --: const
    self.listeners = {} --: vector<string>
    self.disabled = false;
    Util.registerComponent(name, self); 
    return self;
end

-- Component functions

--v function(self: TEXT_BUTTON, xPos: number, yPos: number)
function TextButton.MoveTo(self, xPos, yPos) 
    self.uic:MoveTo(xPos, yPos);
end

--v function(self: TEXT_BUTTON, xMove: number, yMove: number)
function TextButton.Move(self, xMove, yMove)
    Components.move(self.uic, xMove, yMove);
end

--v function(self: TEXT_BUTTON, component: CA_UIC | COMPONENT_TYPE, xDiff: number, yDiff: number)
function TextButton.PositionRelativeTo(self, component, xDiff, yDiff)
    Components.positionRelativeTo(self.uic, component, xDiff, yDiff);
end

--v function(self: TEXT_BUTTON, factor: number)
function TextButton.Scale(self, factor)
    local width, height = self.uic:Bounds();
    self.uic:ResizeTextResizingComponentToInitialSize(width * factor, height * factor); 
end

--v function(self: TEXT_BUTTON, width: number, height: number)
function TextButton.Resize(self, width, height)
    self.uic:ResizeTextResizingComponentToInitialSize(width, height); 
end

--v function(self: TEXT_BUTTON) --> (number, number)
function TextButton.Position(self)
    return self.uic:Position();
end

--v function(self: TEXT_BUTTON) --> (number, number)
function TextButton.Bounds(self)
    return self.uic:Bounds();
end

--v function(self: TEXT_BUTTON) --> number
function TextButton.XPos(self)
    local xPos, yPos = self:Position();
    return xPos;
end

--v function(self: TEXT_BUTTON) --> number
function TextButton.YPos(self)
    local xPos, yPos = self:Position();
    return yPos;
end

--v function(self: TEXT_BUTTON) --> number
function TextButton.Width(self)
    local width, height = self:Bounds();
    return width;
end

--v function(self: TEXT_BUTTON) --> number
function TextButton.Height(self)
    local width, height = self:Bounds();
    return height;
end

--v function(self: TEXT_BUTTON, visible: boolean)
function TextButton.SetVisible(self, visible)
    return self.uic:SetVisible(visible);
end

--v function(self: TEXT_BUTTON) --> boolean
function TextButton.Visible(self)
    return self.uic:Visible();
end

--v function(self: TEXT_BUTTON) --> CA_UIC
function TextButton.GetContentComponent(self)
    return self.uic;
end

--v function(self: TEXT_BUTTON) --> CA_UIC
function TextButton.GetPositioningComponent(self)
    return self.uic;
end

--v function(self: TEXT_BUTTON)
function TextButton.Delete(self) 
    Util.delete(self.uic);
    Util.unregisterComponent(self.name);
    for i, listener in ipairs(self.listeners) do
        core:remove_listener(listener);
    end
end

-- Custom functions

--v function(self: TEXT_BUTTON)
function TextButton.ClearSound(self)
    self.uic:ClearSound();
end

--v function(self: TEXT_BUTTON, state: BUTTON_STATE)
function TextButton.SetState(self, state) 
    self.uic:SetState(state);
end

--v function(self: TEXT_BUTTON) --> BUTTON_STATE
function TextButton.CurrentState(self)
    return self.uic:CurrentState();
end

--v function(self: TEXT_BUTTON) --> boolean
function TextButton.IsSelected(self)
    local state = self.uic:CurrentState();
    if state == "active" or state == "hover" or state == "down" then
        return false;
    else
        return true;
    end
end

--v function(button: TEXT_BUTTON) --> string
local function calculateButtonListenerName(button)
    return button.name .. "ClickListener" .. #button.listeners;
end

--v function(self: TEXT_BUTTON, callback: function(context: CA_UIContext), listenerName: string?)
function TextButton.RegisterForClick(self, callback, listenerName)
    local registerListenerName = nil --: string
    if not listenerName then
        registerListenerName = calculateButtonListenerName(self);
    else
        registerListenerName = listenerName;
    end
    Util.registerForClick(self.uic, registerListenerName, callback);
    table.insert(self.listeners, registerListenerName);
end

--v function(self: TEXT_BUTTON, text: string)
function TextButton.SetButtonText(self, text)
    self.textButtonText:SetStateText(text);
end

--v function(self: TEXT_BUTTON, disabled: boolean)
function TextButton.SetDisabled(self, disabled)
    if not(disabled == self.disabled) then
        if disabled then
            self:SetState("active");
        end
        Components.disableComponent(self.uic, disabled);
        self.disabled = disabled;
    end
end

return {
    new = TextButton.new;
}
