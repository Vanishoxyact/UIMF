local Log = require("uic/log");
local Components = require("uic/components");

local Util = {}; --# assume Util: UTIL
local ComponentsMapped = {} --: map<string, COMPONENT_TYPE>

function Util.init() 
    local root = core:get_ui_root();
    root:CreateComponent("Garbage", "UI/campaign ui/script_dummy");
    local component = root:Find("Garbage");
    if not component then
        Log.write("Garbage not found, Util init failed");
    else
        Util.garbage = UIComponent(component);
        Log.write("Util init completed");
    end
end

--v function(uic: CA_UIC)
function Util.delete(uic)
    Util.garbage:Adopt(uic:Address());
    Util.garbage:DestroyChildren();
end

--v function(uics: vector<CA_UIC>)
function Util.deleteVector(uics)
    for i, uic in ipairs(uics) do
        Util.delete(uic);
    end
end

--v function(name: string, component: COMPONENT_TYPE)
function Util.registerComponent(name, component)
    if not not ComponentsMapped[name] then
        Log.write("Failed to register component with name " .. name .. ", component with that name already registered.");
    else
        ComponentsMapped[name] = component;
    end
end

--v function(name: string)
function Util.unregisterComponent(name)
    if not ComponentsMapped[name] then
        Log.write("Failed to unregister component with name " .. name .. " as is it not registered.");
    else
        ComponentsMapped[name] = nil;
    end
end

--v function(name: string, parentComponent: CA_UIC, componentFilePath: string, ...:string) --> CA_UIC
function Util.createComponent(name, parentComponent, componentFilePath, ...)
    local component = nil --: CA_UIC
    local temp = nil --: CA_UIC
    if not ... then
        parentComponent:CreateComponent(name, componentFilePath);
        component = UIComponent(parentComponent:Find(name));
    else
        parentComponent:CreateComponent("UITEMP", componentFilePath);
        temp = UIComponent(parentComponent:Find("UITEMP"));
        component = find_uicomponent(temp, ...);
    end
    if not component then
        local completePath = componentFilePath;
        for i, v in ipairs{...} do
            completePath = completePath .. "/" .. tostring(v);
        end
        Log.write("Failed to create component "..name..", Path:" .. completePath);
        print_all_uicomponent_children(temp);
        Util.delete(temp);
        return nil;
    else
        parentComponent:Adopt(component:Address());
        component:PropagatePriority(parentComponent:Priority());
        if not not ... then
            Util.delete(temp);
        end
        Components.positionRelativeTo(component, parentComponent, 0, 0);
        Log.write("Created component "..name)
        return component;
    end
end

--v function(name: string) --> COMPONENT_TYPE
function Util.getComponentWithName(name)
    return ComponentsMapped[name];
end

--v function(component: CA_UIC, listenerName: string, callback: function(context: CA_UIContext))
function Util.registerForClick(component, listenerName, callback)
    core:add_listener(
        listenerName,
        "ComponentLClickUp",
        function(context)
            --# assume context : CA_UIContext
            return component == UIComponent(context.component);
        end,
        function(context)
            callback(context);
        end,
        true
    );
end

Util.digForComponent = nil --: function(startingComponent: CA_UIC, componentName: string) --> CA_UIC
--v function(startingComponent: CA_UIC, componentName: string) --> CA_UIC
function Util.digForComponent(startingComponent, componentName)
    local childCount = startingComponent:ChildCount();
    for i=0, childCount-1  do
        local child = UIComponent(startingComponent:Find(i));
        if child:Id() == componentName then
            return child;
        else
            local dugComponent = Util.digForComponent(child, componentName);
            if dugComponent then
                return dugComponent;
            end
        end
    end
    return nil;
end

--v function(componentToMove: CA_UIC | COMPONENT_TYPE | CONTAINER, componentToCentreOn: CA_UIC | COMPONENT_TYPE)
function Util.centreComponentOnComponent(componentToMove, componentToCentreOn)
    --# assume componentToMove: CA_UIC
    local componentToMoveWidth, componentToMoveHeight = componentToMove:Bounds();

    local uicToCentreOn = Components.getUiContentComponent(componentToCentreOn);
    local uicToCentreOnWidth, uicToCentreOnHeight = uicToCentreOn:Bounds();
    local uicToCentreOnX, uicToCentreOnY = uicToCentreOn:Position();
    
    componentToMove:MoveTo(
        uicToCentreOnWidth/2 - componentToMoveWidth/2 + uicToCentreOnX,
        uicToCentreOnHeight/2 - componentToMoveHeight/2 + uicToCentreOnY
    );
end

--v function(componentToMove: CA_UIC | COMPONENT_TYPE | CONTAINER)
function Util.centreComponentOnScreen(componentToMove)
    --# assume componentToMove: CA_UIC
    local componentToMoveWidth, componentToMoveHeight = componentToMove:Bounds();
    local screen_x, screen_y = core:get_screen_resolution();    

    componentToMove:MoveTo(
        screen_x/2 - componentToMoveWidth/2,
        screen_y/2 - componentToMoveHeight/2
    );
end

Util.recurseThroughChildrenApplyingFunction = nil --: function(parentUic: CA_UIC, runnable: function(child: CA_UIC))
--v function(parentUic: CA_UIC, runnable: function(child: CA_UIC))
function Util.recurseThroughChildrenApplyingFunction(parentUic, runnable)
    local childCount = parentUic:ChildCount();
    for i=0, childCount-1  do
        local child = UIComponent(parentUic:Find(i));
        runnable(child);
        Util.recurseThroughChildrenApplyingFunction(child, runnable);
    end
end

return {
    delete = Util.delete;
    init = Util.init;
    registerComponent = Util.registerComponent;
    unregisterComponent = Util.unregisterComponent;
    createComponent = Util.createComponent;
    getComponentWithName = Util.getComponentWithName;
    registerForClick = Util.registerForClick;
    digForComponent = Util.digForComponent;
    centreComponentOnComponent = Util.centreComponentOnComponent;
    centreComponentOnScreen = Util.centreComponentOnScreen;
    recurseThroughChildrenApplyingFunction = Util.recurseThroughChildrenApplyingFunction;
}