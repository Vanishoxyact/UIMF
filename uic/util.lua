local Log = require("uic/log");

local Util = {};
local Components = {} --: map<string, COMPONENT_TYPE>
local InitCallbacks = {} --: vector<function()>

function Util.init() 
    local root = core:get_ui_root();
    root:CreateComponent("Garbage", "UI/campaign ui/script_dummy");
    local component = root:Find("Garbage");
    if not component then
        Log.write("Garbage not found, Util init failed");
    else
        Util.garbage =  UIComponent(component);
        Log.write("Util init completed");
        for _,v in ipairs(InitCallbacks) do
            v();
        end
    end
end

--v function(callback: function())
function Util.registerForInitialisation(callback)
    if not Util.garbage then
        table.insert(InitCallbacks, callback);
    else
        callback();
    end
end

--v function(uic: CA_UIC)
function Util.delete(uic)
    Util.garbage:Adopt(uic:Address());
    Util.garbage:DestroyChildren();
end

--v function(name: string, component: COMPONENT_TYPE)
function Util.registerComponent(name, component)
    if not not Components[name] then
        Log.write("Failed to register component with name " .. name .. ", component with that name already registered.");
    else
        Components[name] = component;
    end
end

--v function(name: string, parentComponent: CA_UIC, componentFilePath: string, ...:string) --> CA_UIC
function Util.createComponent(name, parentComponent, componentFilePath, ...)
    local root = core:get_ui_root();
    root:CreateComponent("UITEMP", componentFilePath);
    local temp = UIComponent(root:Find("UITEMP"));
    local component = find_uicomponent(temp, ...);
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
        Util.delete(temp);
        Log.write("Created component "..name)
        return component;
    end
end

--v function(name: string) --> COMPONENT_TYPE
function Util.getComponentWithName(name)
    return Components[name];
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

--v [NO_CHECK] function(startingComponent: CA_UIC, componentName: string) --> CA_UIC
function Util.digForComponent(startingComponent, componentName)
    local childCount = startingComponent:ChildCount();
    for i=0, childCount-1  do
        local child = UIComponent(startingComponent:Find(i));
        if child:Id() == componentName then
            return child;
        else
            return Util.digForComponent(child, componentName);
        end
    end
end

return {
    delete = Util.delete;
    init = Util.init;
    registerComponent = Util.registerComponent;
    createComponent = Util.createComponent;
    getComponentWithName = Util.getComponentWithName;
    registerForClick = Util.registerForClick;
    digForComponent = Util.digForComponent;
}