local Log = require("uic/log");
local Util = require("uic/util");
local Components = require("uic/components");
local Button = require("uic/button");
local Container = require("uic/layout/container");
local Frame = {} --# assume Frame: FRAME

--v function(name: string) --> FRAME
function Frame.new(name)
    local frame = Util.createComponent(name, core:get_ui_root(), "ui/campaign ui/objectives_screen");

    Util.delete(UIComponent(frame:Find("TabGroup")));
    Util.delete(UIComponent(frame:Find("button_info")));
    local title = find_uicomponent(frame, "panel_title", "tx_objectives");
    title:SetStateText(name);
    local parchment = UIComponent(frame:Find("parchment"));

    local self = {};
    setmetatable(self, {
        __index = Frame
    })
    --# assume self: FRAME
    self.uic = frame --: const
    self.name = name --: const
    self.title = title --: const
    self.content = parchment --: const
    self.components = {} --: vector<CA_UIC | COMPONENT_TYPE | CONTAINER>
    self.closeButton = nil --: BUTTON
    Util.registerComponent(name, self);    
    return self;
end

-- Component functions

--v function(self: FRAME, xPos: number, yPos: number)
function Frame.MoveTo(self, xPos, yPos) 
    self.uic:MoveTo(xPos, yPos);
end

--v function(self: FRAME, xMove: number, yMove: number)
function Frame.Move(self, xMove, yMove)
    Components.move(self.uic, xMove, yMove);
end

--v function(self: FRAME, component: CA_UIC | COMPONENT_TYPE, xDiff: number, yDiff: number)
function Frame.PositionRelativeTo(self, component, xDiff, yDiff)
    Components.positionRelativeTo(self.uic, component, xDiff, yDiff);
end

--v function(self: FRAME, factor: number)
function Frame.Scale(self, factor)
    self.content:SetCanResizeHeight(true);
    self.content:SetCanResizeWidth(true);
    Components.scale(self.uic, factor);
    self.content:SetCanResizeHeight(false);
    self.content:SetCanResizeWidth(false);
end

--v function(self: FRAME, width: number, height: number)
function Frame.Resize(self, width, height)
    self.content:SetCanResizeHeight(true);
    self.content:SetCanResizeWidth(true);
    Components.resize(self.uic, width, height);
    self.content:SetCanResizeHeight(false);
    self.content:SetCanResizeWidth(false);
end

--v function(self: FRAME) --> (number, number)
function Frame.Position(self)
    return self.uic:Position();
end

--v function(self: FRAME) --> (number, number)
function Frame.Bounds(self)
    return self.uic:Bounds();
end

--v function(self: FRAME) --> number
function Frame.XPos(self)
    local xPos, yPos = self:Position();
    return xPos;
end

--v function(self: FRAME) --> number
function Frame.YPos(self)
    local xPos, yPos = self:Position();
    return yPos;
end

--v function(self: FRAME) --> number
function Frame.Width(self)
    local width, height = self:Bounds();
    return width;
end

--v function(self: FRAME) --> number
function Frame.Height(self)
    local width, height = self:Bounds();
    return height;
end

--v function(self: FRAME, visible: boolean)
function Frame.SetVisible(self, visible)
    for i, component in ipairs(self.components) do
        --# assume component: CA_UIC
        component:SetVisible(visible);
    end
    return self.uic:SetVisible(visible);
end

--v function(self: FRAME) --> boolean
function Frame.Visible(self)
    return self.uic:Visible();
end

--v function(self: FRAME) --> CA_UIC
function Frame.GetContentComponent(self)
    return self.content;
end

--v function(self: FRAME) --> CA_UIC
function Frame.GetPositioningComponent(self)
    return self.content;
end

--v function(self: FRAME)
function Frame.Delete(self) 
    Util.delete(self.uic);
    Util.unregisterComponent(self.name);
    for i, component in pairs(self.components) do
        if is_uicomponent(component) then
            --# assume component: CA_UIC
            Util.delete(component);
        elseif Container.isContainer(component) then
            --# assume component: CONTAINER
            component:Clear();
        else
            --# assume component: BUTTON
            component:Delete();
        end
    end
    self.components = {};
end

-- Custom functions

--v function(self: FRAME, component: CA_UIC | COMPONENT_TYPE | CONTAINER)
function Frame.AddComponent(self, component)
    table.insert(self.components, component);
end

--v function(self: FRAME, callback: function?, cross: boolean?, hideInstead: boolean?)
function Frame.AddCloseButton(self, callback, cross, hideInstead)
    local imagePath --: string
    if cross then
        imagePath = "ui/skins/warhammer2/icon_cross.png";
    else
        imagePath = "ui/skins/warhammer2/icon_check.png";
    end
    local closeButton = Button.new(self.name .. "CloseButton", self.uic, "CIRCULAR", imagePath);
    self.closeButton = closeButton;
    self:AddComponent(closeButton);

    local width, height = self.uic:Dimensions();
    local buttonWidth, buttonHeight = closeButton.uic:Dimensions();
    Components.positionRelativeTo(closeButton.uic, self.uic, width/2 - buttonWidth/2, height - buttonHeight/2);
    
    Util.registerForClick(closeButton.uic, self.name .. "CloseButtonListener",
        function(context)
            if not not callback then
                --# assume callback: function()
                callback();
            end
            if hideInstead then
                self:SetVisible(false);
            else
                self:Delete();
            end
        end
    );
end

--v function(self: FRAME, title: string)
function Frame.SetTitle(self, title)
    self.title:SetStateText(title);
end

--v function(self: FRAME) --> CA_UIC
function Frame.GetContentPanel(self)
    return self.content;
end

return {
    new = Frame.new;
}
