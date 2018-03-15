local Log = require("uic/log");
local Util = require("uic/util");
local Components = require("uic/components");
local Button = require("uic/button");
local Frame = {} --# assume Frame: FRAME

--v function(name: string, parent: CA_UIC) --> FRAME
function Frame.new(name, parent)
    local root = core:get_ui_root();
    root:CreateComponent(name, "ui/campaign ui/objectives_screen");
    local frame = UIComponent(root:Find(name));
    Util.registerComponent(name, frame);

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
    Log.write("Create Frame "..name);
    return self;
end

--v function(self: FRAME)
function Frame.AddCloseButton(self)
    local closeButton = Button.new(self.name .. "CloseButton", self.uic, "CIRCULAR", "ui/campaign ui/edicts/lzd_alignment_of_building.png");
    self.closeButton = closeButton;

    local width, height = self.uic:Dimensions();
    local buttonWidth, buttonHeight = closeButton.uic:Dimensions();
    Components.positionRelativeTo(closeButton.uic, self.uic, width/2 - buttonWidth/2, height - buttonHeight/2);
    
    Util.registerForClick(closeButton.uic, self.name .. "CloseButtonListener",
        function(context)
            self.uic:SetVisible(false);
        end
    );
end

--v function(self: FRAME, title: string)
function Frame.SetTitle(self, title)
    self.title:SetStateText(title);
end

--v function(self: FRAME, w: number, h: number)
function Frame.Resize(self, w, h)
    self.uic:Resize(w, h);
end

--v function(self: FRAME, factor: number)
function Frame.Scale(self, factor)
    self.content:SetCanResizeHeight(true);
    self.content:SetCanResizeWidth(true);
    Components.scale(self.uic, 1.5);
    self.content:SetCanResizeHeight(false);
    self.content:SetCanResizeWidth(false);
end

--v function(self: FRAME, component: CA_UIC, xOffset: number, yOffset: number)
function Frame.AddToContentPanel(self, component, xOffset, yOffset)
    Components.positionRelativeTo(component, self.content, xOffset, yOffset);    
end

--v function(self: FRAME) --> CA_UIC
function Frame.GetContentPanel(self)
    return self.content;
end

--v function(self: FRAME)
function Frame.Delete(self)
    Util.delete(self.uic);
end

return {
    new = Frame.new;
}
