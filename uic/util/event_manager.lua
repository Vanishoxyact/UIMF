local EventManager = {} --# assume EventManager: EVENT_MANAGER
EventManager.__index = EventManager;

--v function() --> EVENT_MANAGER
function EventManager.new()
    local em = {};
    setmetatable(em, EventManager);
    --# assume em: EVENT_MANAGER
    em.callbacks = {} --: map<string, vector<function(context: WHATEVER?)>>
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

--v function(self: EVENT_MANAGER, eventType: string, callback: function(context: WHATEVER?))
function EventManager.RegisterForEvent(self, eventType, callback)
    self:RegisterForEventType(eventType);
    local eventCallbacks = self:GetCallbacksForEventType(eventType);
    table.insert(eventCallbacks, callback);
end

--v function(self: EVENT_MANAGER, eventType: string, context: WHATEVER?)
function EventManager.NotifyEvent(self, eventType, context)
    local eventCallbacks = self:GetCallbacksForEventType(eventType);
    for i, callback in ipairs(eventCallbacks) do
        callback(context);
    end
end

return {
    new = EventManager.new
}