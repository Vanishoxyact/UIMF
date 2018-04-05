local Log = require("uic/log");
local Util = require("uic/util");
local Components = require("uic/components");
local Container = require("uic/layout/container");
local Gap = require("uic/layout/gap");
local Dummy = require("uic/dummy");
local ListView = {} --# assume ListView: LIST_VIEW

--v function(name: string, parent: CA_UIC | COMPONENT_TYPE, scrollDirection: LIST_SCROLL_DIRECTION) --> LIST_VIEW
function ListView.new(name, parent, scrollDirection)
    local parentComponent = Components.getUiContentComponent(parent);    
    local listView = nil --: CA_UIC
    local listBox = nil --: CA_UIC
    local listContainer = nil --: CONTAINER
    if scrollDirection == "VERTICAL" then
        listView = Util.createComponent(
        name, parentComponent, "ui/campaign ui/finance_screen",
            "tab_trade", "trade", "exports", "trade_partners_list", "listview"
        );
        listBox = find_uicomponent(listView, "list_clip", "list_box");
        Util.delete(find_uicomponent(listView, "headers"));
        listContainer = Container.new(FlowLayout.VERTICAL);
    elseif scrollDirection == "HORIZONTAL" then
        listView = Util.createComponent(
            name, parentComponent, "ui/campaign ui/building_browser",
            "listview"
        );
        listBox = find_uicomponent(listView, "list_clip", "list_box");
        Util.delete(find_uicomponent(listBox, "building_tree"));
        listContainer = Container.new(FlowLayout.HORIZONTAL);
        print_all_uicomponent_children(listView);
    else
        Log.write("Invalid list scroll direction: " .. scrollDirection);
    end

    local self = {};
    setmetatable(self, {
        __index = ListView
    })
    --# assume self: LIST_VIEW
    self.uic = listView --: const
    self.name = name --: const
    self.listBox = listBox --: const
    self.listContainer = listContainer;
    Util.registerComponent(name, self);
    return self;
end

-- Component functions

--v function(self: LIST_VIEW, xPos: number, yPos: number)
function ListView.MoveTo(self, xPos, yPos) 
    self.uic:MoveTo(xPos, yPos);
    Components.positionRelativeTo(self.listContainer, self.uic, 0, 0);
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
    self.listContainer:Clear();
    Util.unregisterComponent(self.name);
end

-- Custom functions

--v function(self: LIST_VIEW, container: CONTAINER)    
function ListView.AddContainer(self, container)
    -- Create dummy and adopt all components and then add to list with size, rather than adding to list as adding to list 
    -- increases view size per component
    local dummy = Dummy.new(core:get_ui_root());
    local dummyUic = dummy.uic;
    local containerComponents = container:RecursiveRetrieveAllComponents();
    for i, component in ipairs(containerComponents) do
        local componentUic = nil --: CA_UIC
        if is_uicomponent(component) then
            --# assume component: CA_UIC
            componentUic = component;
        elseif Gap.isGap(component) then
            -- Do nothing
        else
            --# assume component: BUTTON
            componentUic = component.uic;
        end
        dummyUic:Adopt(componentUic:Address());
        -- Set un-resizable so resizing dummy doesnt effect inner components
        componentUic:SetCanResizeHeight(false);
        componentUic:SetCanResizeWidth(false);
    end

    dummyUic:SetCanResizeHeight(true);
    dummyUic:SetCanResizeWidth(true);

    dummyUic:Resize(container:Bounds());
    self.listBox:Adopt(dummyUic:Address());
    self.listContainer:AddComponent(container);
end

--v function(self: LIST_VIEW, component: CA_UIC | COMPONENT_TYPE | CONTAINER)
function ListView.AddComponent(self, component)
    if Container.isContainer(component) then
        --# assume component: CONTAINER
        self:AddContainer(component);
    else
        local wrapper = Container.new(FlowLayout.VERTICAL);
        wrapper:AddComponent(component);
        self:AddContainer(wrapper);
    end
end

return {
    new = ListView.new;
}
