local Log = require("uic/log");
local Components = {};

--v function(component: CA_UIC, width: number, height: number)
function Components.resize(component, width, height)
    component:SetCanResizeHeight(true);
    component:SetCanResizeWidth(true);
    component:Resize(width, height);
    component:SetCanResizeHeight(false);
    component:SetCanResizeWidth(false);
end

--v function(component: CA_UIC, factor: number)
function Components.scale(component, factor)
    local width, height = component:Bounds();
    Components.resize(component, width * factor, height * factor);
end

--v function(component: CA_UIC, xMove: number, yMove: number)
function Components.move(component, xMove, yMove)
    local curX, curY = component:Position();
    component:MoveTo(curX + xMove, curY + yMove);
end

--v function(componentToMove: CA_UIC, relativeComponent: CA_UIC, xDiff: number, yDiff: number)    
function Components.positionRelativeToUiComponent(componentToMove, relativeComponent, xDiff, yDiff)
    local relX, relY = relativeComponent:Position();
    componentToMove:MoveTo(relX + xDiff, relY + yDiff);
end

--v function(component: CA_UIC | COMPONENT_TYPES) --> CA_UIC
function Components.getUiContentComponent(component)
    if is_uicomponent(component) then
        --# assume component: CA_UIC
        return component;
    else
        --# assume component: BUTTON
        return component:GetContentComponent();
    end
end

return {
    scale = Components.scale;
    move = Components.move;
    positionRelativeTo = Components.positionRelativeToUiComponent;
    resize = Components.resize;
    getUiContentComponent = Components.getUiContentComponent;
}