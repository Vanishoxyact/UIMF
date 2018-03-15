local Log = require("uic/log");
local Util = require("uic/util");
require("uic/components");
local Image = {} --# assume Image: IMAGE


--v function(name: string, parent: CA_UIC, imagePath: string) --> IMAGE
function Image.new(name, parent, imagePath)
    local image = Util.createComponent(
        name, parent, "ui/campaign ui/clan",
        "main", "tab_children_parent", "Summary", "portrait_frame", "parchment_L", "details", "details_list", "tx_food", "dy_food", "food_icon"
    );
    --"TabGroup", "tab_victory_conditions", "tab_child", "tree_holder", "victory_type_tree", "slot_parent", "wh_main_victory_type_long"
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

return {
    new = Image.new;
}