local Log = require("uic/log");
local Components = {}; --# assume Components: COMPONENTS

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
    --# assume component: CA_UIC
    local width, height = component:Bounds();
    Components.resize(component, width * factor, height * factor);
end

--v function(component: CA_UIC | CONTAINER | COMPONENT_TYPE, xMove: number, yMove: number)
function Components.move(component, xMove, yMove)
    --# assume component: CA_UIC
    local curX, curY = component:Position();
    component:MoveTo(curX + xMove, curY + yMove);
end

--v function(componentToMove: CA_UIC | CONTAINER, relativeComponent: CA_UIC | COMPONENT_TYPE, xDiff: number, yDiff: number)    
function Components.positionRelativeToUiComponent(componentToMove, relativeComponent, xDiff, yDiff)
    local uic = nil  --: CA_UIC
    if is_uicomponent(relativeComponent) then
        --# assume relativeComponent: CA_UIC
        uic = relativeComponent;
    else
        --# assume relativeComponent: BUTTON
        uic = relativeComponent:GetPositioningComponent();
    end
    local relX, relY = uic:Position();
    --# assume componentToMove: CA_UIC
    componentToMove:MoveTo(relX + xDiff, relY + yDiff);
end

--v function(component: CA_UIC | COMPONENT_TYPE) --> CA_UIC
function Components.getUiContentComponent(component)
    if is_uicomponent(component) then
        --# assume component: CA_UIC
        return component;
    else
        --# assume component: BUTTON
        return component:GetContentComponent();
    end
end

--v function(component: CA_UIC, disabled: boolean)
function Components.disableComponent(component, disabled)
    component:SetDisabled(disabled);
    if disabled then
        component:SetOpacity(50);
    else
        component:SetOpacity(255);
    end
end

return {
    scale = Components.scale;
    move = Components.move;
    positionRelativeTo = Components.positionRelativeToUiComponent;
    resize = Components.resize;
    getUiContentComponent = Components.getUiContentComponent;
    disableComponent = Components.disableComponent;
}