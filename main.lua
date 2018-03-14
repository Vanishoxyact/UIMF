local Log = require("uic/log");
local Text = require("uic/text");
local Image = require("uic/image");
local Button = require("uic/button");
local TextButton = require("uic/text_button");
local Frame = require("uic/frame");
local Util = require ("uic/util");
local Components = require("uic/components");

_G.UIComponent = UIComponent;
_G.find_uicomponent = find_uicomponent;
_G.print_all_uicomponent_children = print_all_uicomponent_children;
_G.output = output;
_G.core = core;

core:add_ui_created_callback(
    function()
        Util.init();
    end
);

function main()
    core:add_listener(
        "mortcultclicked",
        "PanelOpenedCampaign",
        function(context) 
            return context.string == "mortuary_cult"; 
        end,
         function(context)
            output("MORT OPENED");
            Log.write("MORT OPENED");
            output("MORT CALLBACK");
            Log.write("MORT CALLBACK");
            local mortCult = find_uicomponent(core:get_ui_root(), "mortuary_cult");
            Log.write("MORT FOUND");
            local player = Text.new("myText", mortCult, "NORMAL", "Custom Text");
            player:MoveTo(425, 85);
            -- Image.new("uppercase", mortCult, core:get_ui_root(), uicomp, find_uicomponent_by_table_func);                    
            output("MORT CALLBACK END");
            Log.write("MORT CALLBACK END");                  
            local mortCultBox = find_uicomponent(core:get_ui_root(), "mortuary_cult", "listview", "list_clip", "list_box", "wh2_dlc09_ritual_crafting_tmb_army_capacity");
            if not mortCultBox then
                Log.write("mortCultBox not found");
            end
            local myImage = Image.new("uppercase", mortCultBox, "ui/skins/default/advisor_beastmen_2d.png");
            myImage:MoveTo(250, 200);
            myImage:SetTooltip("My tooptip");
            local myButton = Button.new("mybtton", mortCult, "CIRCULAR", "ui/campaign ui/edicts/lzd_alignment_of_building.png");
            myButton:MoveTo(500, 200);
        end,
        true
    );

    core:add_listener(
        "rec_opened",
        "PanelOpenedCampaign",
        function(context) 
            return context.string == "units_recruitment"; 
        end,
        function(context)
            output("RECRUIT CALLBACK");
            local recruitmentList = find_uicomponent(core:get_ui_root(), 
                "units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "recruitment_listbox",
                "local1", "unit_list", "listview", "list_clip", "list_box"
            )
            for i = 0, recruitmentList:ChildCount() - 1 do	
                local recuitmentOption = UIComponent(recruitmentList:Find(i));
                local recruitText = Text.new("abc" .. i, recuitmentOption, "NORMAL", "ABC");
                Components.positionRelativeTo(recruitText.uic, recuitmentOption, 20, 20);
            end
            output("RECRUIT CALLBACK END");
        end,
        true
    );


    core:add_listener(
		"createFrame",
		"ShortcutTriggered",
		function(context) return context.string == "camera_bookmark_view2"; end,
        function(context)
            local existingFrame = Util.getComponentWithName("MyFrame");
            if not existingFrame then
                local myFrame = Frame.new("MyFrame", core:get_ui_root());
                myFrame:Scale(2);
                myFrame.uic:MoveTo(100, 100);
                myFrame:AddCloseButton();
                local contentPanel = myFrame:GetContentPanel();

                local images = Text.new("images", contentPanel, "NORMAL", "Images");
                myFrame:AddToContentPanel(images.uic, 50, 80);                
                local normalImage = Image.new("normalImage", contentPanel, "ui/skins/default/advisor_beastmen_2d.png");
                myFrame:AddToContentPanel(normalImage.uic, 50, 100);
                local smallImage = Image.new("smallImage", contentPanel, "ui/skins/default/advisor_beastmen_2d.png");
                Components.scale(smallImage.uic, 0.5);
                myFrame:AddToContentPanel(smallImage.uic, 100, 100);
                local rotatedImage = Image.new("rotatedImage", contentPanel, "ui/skins/default/advisor_beastmen_2d.png");
                myFrame:AddToContentPanel(rotatedImage.uic, 150, 100);
                rotatedImage.uic:SetImageRotation(0, math.pi / 2);
                local transparentImage = Image.new("transparentImage", contentPanel, "ui/skins/default/advisor_beastmen_2d.png");
                myFrame:AddToContentPanel(transparentImage.uic, 200, 100);
                transparentImage:SetOpacity(50);

                local buttons = Text.new("buttons", contentPanel, "NORMAL", "Buttons");
                myFrame:AddToContentPanel(buttons.uic, 50, 130);                
                local squareButton = Button.new("squareButton", contentPanel, "SQUARE", "ui/skins/default/icon_end_turn.png");
                myFrame:AddToContentPanel(squareButton.uic, 50, 150);
                local circularButton = Button.new("circularButton", contentPanel, "CIRCULAR", "ui/skins/default/icon_end_turn.png");
                myFrame:AddToContentPanel(circularButton.uic, 100, 150);
                local textButton = TextButton.new("textButton", contentPanel, "TEXT", "customText");
                myFrame:AddToContentPanel(textButton.uic, 150, 150);

                local resizedSquareButton = Button.new("resizedSquareButton", contentPanel, "SQUARE", "ui/skins/default/icon_end_turn.png");
                Components.scale(resizedSquareButton.uic, 0.5);
                myFrame:AddToContentPanel(resizedSquareButton.uic, 50, 200);
                local resizedCircularButton = Button.new("resizedCircularButton", contentPanel, "CIRCULAR", "ui/skins/default/icon_end_turn.png");
                Components.scale(resizedCircularButton.uic, 0.5);
                myFrame:AddToContentPanel(resizedCircularButton.uic, 100, 200);
                local resizedTextButton = TextButton.new("resizedTextButton", contentPanel, "TEXT", "customText");
                resizedTextButton.uic:ResizeTextResizingComponentToInitialSize(250, resizedTextButton.uic:Height())
                myFrame:AddToContentPanel(resizedTextButton.uic, 150, 200);

                local toggleButtons = Text.new("toggleButtons", contentPanel, "NORMAL", "Toggle Buttons");
                myFrame:AddToContentPanel(toggleButtons.uic, 50, 230);                
                local squareToggleButton = Button.new("squareToggleButton", contentPanel, "SQUARE_TOGGLE", "ui/skins/default/icon_end_turn.png");
                myFrame:AddToContentPanel(squareToggleButton.uic, 50, 250);
                --local circularToggleButton = Button.new("circularToggleButton", contentPanel, "CIRCULAR_TOGGLE", "ui/skins/default/icon_end_turn.png");
                --myFrame:AddToContentPanel(circularToggleButton.uic, 50, 190);
                local textToggleButton = TextButton.new("textToggleButton", contentPanel, "TEXT_TOGGLE", "customText");
                myFrame:AddToContentPanel(textToggleButton.uic, 150, 250);

                local buttonLogic = Text.new("buttonLogic", contentPanel, "NORMAL", "Button Logic");
                myFrame:AddToContentPanel(buttonLogic.uic, 50, 290);   
                local incrementButton = TextButton.new("incrementButton", contentPanel, "TEXT", "+");
                incrementButton.uic:ResizeTextResizingComponentToInitialSize(150, 51);
                myFrame:AddToContentPanel(incrementButton.uic, 50, 310);
                local decrementButton = TextButton.new("decrementButton", contentPanel, "TEXT", "-");
                decrementButton.uic:ResizeTextResizingComponentToInitialSize(150, 51);
                myFrame:AddToContentPanel(decrementButton.uic, 150, 310);
                local counterText = Text.new("CounterText", contentPanel, "NORMAL", "0");
                myFrame:AddToContentPanel(counterText.uic, 300, 310);
                Util.registerForClick(incrementButton.uic, "incrementCounter",
                    function(context)
                        local number = tonumber(counterText.uic:GetStateText());
                        if number < 8 then
                            local newText = tostring(number + 1);
                            counterText:SetText(newText);
                        end
                    end
                );
                Util.registerForClick(decrementButton.uic, "decrementCounter",
                    function(context)
                        local number = tonumber(counterText.uic:GetStateText());
                        if number > 0 then
                            local newText = tostring(number - 1);
                            counterText:SetText(newText);
                        end
                    end
                );
                local toggleButton = Button.new("toggleButton", contentPanel, "SQUARE_TOGGLE", "ui/skins/default/icon_end_turn.png");
                myFrame:AddToContentPanel(toggleButton.uic, 350, 310);
                local toggleText = Text.new("toggleText", contentPanel, "NORMAL", "0");
                myFrame:AddToContentPanel(toggleText.uic, 400, 310);
                toggleText:SetText(toggleButton.uic:CurrentState());
                Util.registerForClick(toggleButton.uic, "toggleListener",
                    function(context)
                        toggleText:SetText(toggleButton.uic:CurrentState());
                    end
                );
                
                local text = Text.new("text", contentPanel, "NORMAL", "Text");
                myFrame:AddToContentPanel(text.uic, 50, 350);
                local greenText = Text.new("greenText", contentPanel, "NORMAL", "[[col:green]]This is green text[[/col]]");
                myFrame:AddToContentPanel(greenText.uic, 50, 370);
                local iconText = Text.new("iconText", contentPanel, "NORMAL", "[[img:icon_arrow_up]][[/img]]This text has icons in[[img:icon_arrow_up]][[/img]]");
                myFrame:AddToContentPanel(iconText.uic, 50, 390);
                local resizedText = Text.new("resizedText", contentPanel, "NORMAL", "Small text");
                Components.scale(resizedText.uic, 0.5);
                myFrame:AddToContentPanel(resizedText.uic, 50, 410);
                local wrappedText = Text.new("wrappedText", contentPanel, "WRAPPED", "This is wrapped text. This is wrapped text. This is wrapped text. This is wrapped text. This is wrapped text. This is wrapped text. This is wrapped text. This is wrapped text. ");
                Components.resize(wrappedText.uic, 500, 200);
                myFrame:AddToContentPanel(wrappedText.uic, 50, 430);
                local titleText = Text.new("titleText", contentPanel, "TITLE", "This is title text");
                myFrame:AddToContentPanel(titleText.uic, 50, 500);
                
                local textOutside = Text.new("textOutside", contentPanel, "NORMAL", "Im outside");
                myFrame:AddToContentPanel(textOutside.uic, 50, 800);
            else
                existingFrame:SetVisible(true);
            end
		end,
		true
	);
end