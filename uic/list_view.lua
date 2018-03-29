local Log = require("uic/log");
local Util = require("uic/util");
local Components = require("uic/components");
local Container = require("uic/layout/container");
local Dummy = require("uic/dummy");
local ListView = {} --# assume ListView: LIST_VIEW

--v function(name: string, parent: CA_UIC | COMPONENT_TYPE) --> LIST_VIEW
function ListView.new(name, parent)
    local parentComponent = Components.getUiContentComponent(parent);    
    local listView = Util.createComponent(
        name, parentComponent, "ui/campaign ui/finance_screen",
        "tab_trade", "trade", "exports", "trade_partners_list"
    );
    local listBox = find_uicomponent(listView, "listview", "list_clip", "list_box");
    Util.delete(find_uicomponent(listView, "listview", "headers"));
    Util.delete(find_uicomponent(listView, "tx_trade_partners"));
    Util.delete(find_uicomponent(listView, "tx_no_trade_partners"));

    local self = {};
    setmetatable(self, {
        __index = ListView
    })
    --# assume self: LIST_VIEW
    self.uic = listView --: const
    self.name = name --: const
    self.listBox = listBox --: const
    self.listContainer = Container.new(FlowLayout.VERTICAL);
    Util.registerComponent(name, self);    
    return self;
end

-- Component functions

--v function(self: LIST_VIEW, xPos: number, yPos: number)
function ListView.MoveTo(self, xPos, yPos) 
    self.uic:MoveTo(xPos, yPos);
    local offset = tonumber(0);
    for i, component in ipairs(self.listContainer.components) do
        if i == 1 then
            --# assume component: BUTTON
            local w, h = component:Bounds();
            offset = h;
        end
    end
    Components.positionRelativeTo(self.listContainer, self.uic, 0, offset);
end

--v function(self: LIST_VIEW, xMove: number, yMove: number)
function ListView.Move(self, xMove, yMove)
    Components.move(self.uic, xMove, yMove);
end

--v function(self: LIST_VIEW, component: CA_UIC | COMPONENT_TYPE, xDiff: number, yDiff: number)
function ListView.PositionRelativeTo(self, component, xDiff, yDiff)
    Components.positionRelativeTo(self.uic, component, xDiff, yDiff);
end

--v function(self: LIST_VIEW, factor: number)
function ListView.Scale(self, factor)
    Components.scale(self.uic, factor);
end

--v function(self: LIST_VIEW, width: number, height: number)
function ListView.Resize(self, width, height)
    Components.resize(self.uic, width, height);
end

--v function(self: LIST_VIEW) --> (number, number)
function ListView.Position(self)
    return self.uic:Position();
end

--v function(self: LIST_VIEW) --> (number, number)
function ListView.Bounds(self)
    return self.uic:Bounds();
end

--v function(self: LIST_VIEW) --> number
function ListView.XPos(self)
    local xPos, yPos = self:Position();
    return xPos;
end

--v function(self: LIST_VIEW) --> number
function ListView.YPos(self)
    local xPos, yPos = self:Position();
    return yPos;
end

--v function(self: LIST_VIEW) --> number
function ListView.Width(self)
    local width, height = self:Bounds();
    return width;
end

--v function(self: LIST_VIEW) --> number
function ListView.Height(self)
    local width, height = self:Bounds();
    return height;
end

--v function(self: LIST_VIEW, visible: boolean)
function ListView.SetVisible(self, visible)
    return self.uic:SetVisible(visible);
end

--v function(self: LIST_VIEW) --> boolean
function ListView.Visible(self)
    return self.uic:Visible();
end

--v function(self: LIST_VIEW) --> CA_UIC
function ListView.GetContentComponent(self)
    return self.listBox;
end

--v function(self: LIST_VIEW) --> CA_UIC
function ListView.GetPositioningComponent(self)
    return self.uic;
end

--v function(self: LIST_VIEW)
function ListView.Delete(self) 
    Util.delete(self.uic);
end

-- Custom functions

--v function(self: LIST_VIEW, component: CA_UIC | COMPONENT_TYPE)    
function ListView.AddComponent(self, component)
    self.listContainer:AddComponent(component);
end

--v function(self: LIST_VIEW, container: CONTAINER)    
function ListView.AddContainer(self, container)
    -- Create dummy and adopt all components and then add to list with row height, rather than adding to list as adding to list 
    -- increases view size per component
    local dummy = Dummy.new(core:get_ui_root());
    local dummyUic = dummy.uic;
    local containerComponents = container:RecursiveRetrieveAllComponents();
    for i, component in ipairs(containerComponents) do
        if is_uicomponent(component) then
            --# assume component: CA_UIC
            dummyUic:Adopt(component:Address());
        else
            --# assume component: BUTTON
            dummyUic:Adopt(component.uic:Address());
        end
    end
    -- Resizing width for some reason does not work!
    dummyUic:SetCanResizeHeight(true);
    dummyUic:SetCanResizeWidth(false);
    -- Maybe set first row to 0 size?
    dummyUic:Resize(container:Bounds());
    self.listBox:Adopt(dummyUic:Address());
    self.listContainer:AddComponent(container);

    --self.listBox:SetCanResizeHeight(true);
    --self.listBox:Resize(self.listContainer:Bounds());
end

return {
    new = ListView.new;
}
