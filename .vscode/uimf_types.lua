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
--# assume global class COMPONENTS
--# assume global class EVENT_MANAGER

--# type global COMPONENT_TYPE = 
--# TEXT | IMAGE | BUTTON | TEXT_BUTTON | FRAME | TEXT_BOX | LIST_VIEW | DUMMY

--# type global BUTTON_TYPE = 
--# "CIRCULAR" | "SQUARE" | "CIRCULAR_TOGGLE" | "SQUARE_TOGGLE"

--# type global TEXT_BUTTON_TYPE = 
--# "TEXT" | "TEXT_TOGGLE" | "TEXT_TOGGLE_SMALL"

--# type global TEXT_TYPE = 
--# "NORMAL" | "WRAPPED" | "TITLE" | "HEADER"

--# assume BUTTON.GetContentComponent: method() --> CA_UIC
--# assume BUTTON.GetPositioningComponent: method() --> CA_UIC

--# assume global class CONTAINER
--# assume global class GAP
--# assume global class FLOW_LAYOUT

--# type global LAYOUT = FLOW_LAYOUT

--# type global FLOW_LAYOUT_TYPE = "VERTICAL" | "HORIZONTAL"

--# type global LIST_SCROLL_DIRECTION = "VERTICAL" | "HORIZONTAL"

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
--# assume global EventManager: EVENT_MANAGER

--# assume global TABLES: map<string, map<string, WHATEVER>>
--# assume global write_log: boolean