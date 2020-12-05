local EventManager = {} --# assume EventManager: EVENT_MANAGER
EventManager.__index = EventManager;

--v function() --> EVENT_MANAGER
function EventManager.new()
    local em = {};
    setmetatable(em, EventManager);
    --# assume em: EVENT_MANAGER
    em.callbacks = {} --: map<string, vector<function(context: WHATEVER?)>>
    em.regId = 0;
    return em
end

--v function(self: EVENT_MANAGER, eventType: string)
function EventManager.RegisterForEventType(self, eventType)
    if not self.callbacks[eventType] then
        self.callbacks[eventType] = {};
    end
end

--v function(self: EVENT_MANAGER, eventType: string) --> vector<function(context: WHATEVER?)>
function EventManager.GetCallbacksForEventType(self, eventType)
    if not self.callbacks[eventType] then
        return {};
    else
        return self.callbacks[eventType];
    end
end

function EventManager.GetAllCallbacksForEventType(self, eventType)
    if not self.callbacks[eventType] then
        return {};
    else
        local allCallbacks = {};
        for regId, callbackTable in spairs(self.callbacks[eventType], function(t, a, b) return a < b end) do
            out("callback: " .. tostring(regId) .. " " .. eventType);
            table.insert(allCallbacks, callbackTable);
        end
        return allCallbacks;
    end
end

--v function(self: EVENT_MANAGER, eventType: string, callback: function(context: WHATEVER?))
function EventManager.RegisterForEvent(self, eventType, callback)
    self:RegisterForEventType(eventType);
    self.regId = self.regId + 1;
    local regId = self.regId;
    local eventCallbacks = self:GetCallbacksForEventType(eventType);
    eventCallbacks[regId] = callback;
    return regId;
end

--v function(self: EVENT_MANAGER, eventType: string, context: WHATEVER?)
function EventManager.NotifyEvent(self, eventType, context)
    local eventCallbacks = self:GetAllCallbacksForEventType(eventType);
    for i, callback in ipairs(eventCallbacks) do
        callback(context);
    end
end

function EventManager.UnregisterForEvent(self, regId)
    for _, callbackTable in pairs(self.callbacks) do
        for callbackRegId, _ in pairs(callbackTable) do
            if callbackRegId == regId then
                callbackTable[callbackRegId] = nil;
            end
        end
    end
end

--v [NO_CHECK] function(t: WHATEVER, order: function(WHATEVER, WHATEVER, WHATEVER) --> boolean)
function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

return {
    new = EventManager.new
}