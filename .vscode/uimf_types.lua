--# assume global class BUTTON
--# assume global class TEXT
--# assume global class IMAGE
--# assume global class TEXT_BUTTON
--# assume global class FRAME

--# type global COMPONENT_TYPE = 
--# TEXT | IMAGE | BUTTON | TEXT_BUTTON | FRAME

--# type global BUTTON_TYPE = 
--# "CIRCULAR" | "SQUARE" | "CIRCULAR_TOGGLE" | "SQUARE_TOGGLE"

--# type global TEXT_BUTTON_TYPE = 
--# "TEXT" | "TEXT_TOGGLE"

--# type global TEXT_TYPE = 
--# "NORMAL" | "WRAPPED" | "TITLE"

--# assume BUTTON.GetContentComponent: method() --> CA_UIC
--# assume BUTTON.GetPositioningComponent: method() --> CA_UIC