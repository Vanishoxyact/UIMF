local Log = require("uic/log");
local Util = require("uic/util");
local Components = require("uic/components");
local Image = {} --# assume Image: IMAGE


--v function(name: string, parent: CA_UIC | COMPONENT_TYPE, imagePath: string) --> IMAGE
function Image.new(name, parent, imagePath)
    local parentComponent = Components.getUiContentComponent(parent);    
    local image = Util.createComponent(
        name, parentComponent, "ui/campaign ui/clan",
        "main", "tab_children_parent", "Summary", "portrait_frame", "parchment_L", "details", "details_list", "tx_food", "dy_food", "food_icon"
    );
    image:SetImage(imagePath);

    local self = {};
    setmetatable(self, {
        __index = Image
    })
    --# assume self: IMAGE
    self.uic = image --: const
    self.name = name --: const
    return self;
end


--v function(self: IMAGE, x: number, y: number)
function Image.MoveTo(self, x, y)
    self.uic:MoveTo(x, y);
end

--v function(self: IMAGE) --> (number, number)
function Image.Position(self) 
    return self.uic:Position();
end

--v function(self: IMAGE, path: string)
function Image.SetImage(self, path)
    self.uic:SetImage(path);
end

--v function(self: IMAGE, tooltip: string)
function Image.SetTooltip(self, tooltip)
    self.uic:SetTooltipText(tooltip, true);
end

--v function(self: IMAGE, tooltip: string)
function Image.DisableTooltip(self, tooltip)
    self.uic:SetTooltipText("", true);
end

--v function(self: IMAGE, w: number, h: number)
function Image.Resize(self, w, h)
    self.uic:SetCanResizeHeight(true);
    self.uic:SetCanResizeWidth(true);
    self.uic:Resize(w, h);
    self.uic:SetCanResizeHeight(false);
    self.uic:SetCanResizeWidth(false);
end

--v function(self: IMAGE, opacity: number)
function Image.SetOpacity(self, opacity)
    self.uic:SetOpacity(opacity);
end

--v function(self: IMAGE, visible: boolean)
function Image.SetVisible(self, visible) 
    self.uic:SetVisible(visible);
end

--v function(self: IMAGE)
function Image.Delete(self) 
    Util.delete(self.uic);
end

--v function(self: IMAGE) --> CA_UIC
function Image.GetContentComponent(self)
    return self.uic;
end

return {
    new = Image.new;
}