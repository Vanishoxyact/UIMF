--# assume global class LOG
--# assume global class BUTTON
--# assume global class TEXT
--# assume global class IMAGE
--# assume global class TEXT_BUTTON
--# assume global class FRAME
--# assume global class TEXT_BOX
--# assume global class LIST_VIEW
--# assume global class DUMMY
--# assume global class UTIL

--# type global COMPONENT_TYPE = 
--# TEXT | IMAGE | BUTTON | TEXT_BUTTON | FRAME | TEXT_BOX | LIST_VIEW | DUMMY

--# type global BUTTON_TYPE = 
--# "CIRCULAR" | "SQUARE" | "CIRCULAR_TOGGLE" | "SQUARE_TOGGLE"

--# type global TEXT_BUTTON_TYPE = 
--# "TEXT" | "TEXT_TOGGLE"

--# type global TEXT_TYPE = 
--# "NORMAL" | "WRAPPED" | "TITLE" | "HEADER"

--# assume BUTTON.GetContentComponent: method() --> CA_UIC
--# assume BUTTON.GetPositioningComponent: method() --> CA_UIC

--# assume global class CONTAINER
--# assume global class GAP
--# assume global class FLOW_LAYOUT

--# type global LAYOUT = FLOW_LAYOUT

--# type global FLOW_LAYOUT_TYPE = "VERTICAL" | "HORIZONTAL"

--# assume UTIL.getComponentWithName: function(name: string) --> COMPONENT_TYPE
--# assume UTIL.centreComponentOnComponent: function(componentToMove: CA_UIC | COMPONENT_TYPE | CONTAINER, componentToCentreOn: CA_UIC | COMPONENT_TYPE)
--# assume UTIL.centreComponentOnScreen: function(component: CA_UIC | COMPONENT_TYPE | CONTAINER)
--# assume UTIL.registerForClick: function(component: CA_UIC, listenerName: string, callback: function(context: CA_UIContext))
--# assume UTIL.delete: function(component: CA_UIC)
--# assume UTIL.recurseThroughChildrenApplyingFunction: function(parentUic: CA_UIC, runnable: function(child: CA_UIC))
        
--# assume global Log: LOG
--# assume global Text: TEXT
--# assume global Image: IMAGE
--# assume global Button: BUTTON
--# assume global TextButton: TEXT_BUTTON
--# assume global Frame: FRAME
--# assume global TextBox: TEXT_BOX
--# assume global ListView: LIST_VIEW
--# assume global Util: UTIL
--# assume global FlowLayout: FLOW_LAYOUT
--# assume global Dummy: DUMMY
--# assume global Container: CONTAINER

--# assume global TABLES: map<string, map<string, WHATEVER>>
--# assume global write_log: boolean