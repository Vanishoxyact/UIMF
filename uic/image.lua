local Log = require("uic/log");
local Util = require("uic/util");
local Components = require("uic/components");
local Image = {} --# assume Image: IMAGE

--v function(name: string, parent: CA_UIC | COMPONENT_TYPE, imagePath: string) --> IMAGE
function Image.new(name, parent, imagePath)
    local parentComponent = Components.getUiContentComponent(parent);    
    image = Util.createComponent(name, parentComponent, "ui/campaign ui/region_info_pip");
    image:SetImage(imagePath);

    local self = {};
    setmetatable(self, {
        __index = Image
    })
    --# assume self: IMAGE
    self.uic = image --: const
    self.name = name --: const
    Util.registerComponent(name, self); 
    return self;
end

-- Component functions

--v function(self: IMAGE, xPos: number, yPos: number)
function Image.MoveTo(self, xPos, yPos) 
    self.uic:MoveTo(xPos, yPos);
end

--v function(self: IMAGE, xMove: number, yMove: number)
function Image.Move(self, xMove, yMove)
    Components.move(self.uic, xMove, yMove);
end

--v function(self: IMAGE, component: CA_UIC | COMPONENT_TYPE, xDiff: number, yDiff: number)
function Image.PositionRelativeTo(self, component, xDiff, yDiff)
    Components.positionRelativeTo(self.uic, component, xDiff, yDiff);
end

--v function(self: IMAGE, factor: number)
function Image.Scale(self, factor)
    Components.scale(self.uic, factor);
end

--v function(self: IMAGE, width: number, height: number)
function Image.Resize(self, width, height)
    Components.resize(self.uic, width, height);
end

--v function(self: IMAGE) --> (number, number)
function Image.Position(self)
    return self.uic:Position();
end

--v function(self: IMAGE) --> (number, number)
function Image.Bounds(self)
    return self.uic:Bounds();
end

--v function(self: IMAGE) --> number
function Image.XPos(self)
    local xPos, yPos = self:Position();
    return xPos;
end

--v function(self: IMAGE) --> number
function Image.YPos(self)
    local xPos, yPos = self:Position();
    return yPos;
end

--v function(self: IMAGE) --> number
function Image.Width(self)
    local width, height = self:Bounds();
    return width;
end

--v function(self: IMAGE) --> number
function Image.Height(self)
    local width, height = self:Bounds();
    return height;
end

--v function(self: IMAGE, visible: boolean)
function Image.SetVisible(self, visible)
    return self.uic:SetVisible(visible);
end

--v function(self: IMAGE) --> boolean
function Image.Visible(self)
    return self.uic:Visible();
end

--v function(self: IMAGE) --> CA_UIC
function Image.GetContentComponent(self)
    return self.uic;
end

--v function(self: IMAGE) --> CA_UIC
function Image.GetPositioningComponent(self)
    return self.uic;
end

--v function(self: IMAGE)
function Image.Delete(self) 
    Util.delete(self.uic);
    Util.unregisterComponent(self.name);
end

-- Custom functions

--v function(self: IMAGE, path: string)
function Image.SetImage(self, path)
    self.uic:SetImage(path);
end

--v function(self: IMAGE, opacity: number)
function Image.SetOpacity(self, opacity)
    self.uic:SetOpacity(opacity);
end

--v function(self: IMAGE, rotation: number)
function Image.SetRotation(self, rotation)
    self.uic:SetImageRotation(0, rotation);
end

return {
    new = Image.new;
}