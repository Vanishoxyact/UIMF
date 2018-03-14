local Console = require("core/console");
local Text = require("uic/text");
local Image = require("uic/image");
local Button = require("uic/button");
local Frame = require("uic/frame");
local Util = require ("uic/util");
local Components = require("uic/components");

_G.UIComponent = UIComponent;
_G.find_uicomponent = find_uicomponent;
_G.print_all_uicomponent_children = print_all_uicomponent_children;
_G.output = output;
_G.core = core;

function main()
    output("START");
    Console.write("START");

    output("UI CREATED NE");
    Console.write("UI CREATED NE");
    Util.init();
    output("UI CREATED END NE");
    Console.write("UI CREATED END NE");

    core:add_listener(
        "mortcultclicked",
        "PanelOpenedCampaign",
        function(context) 
            return context.string == "mortuary_cult"; 
        end,
         function(context)
            output("MORT OPENED");
            Console.write("MORT OPENED");
            cm:callback(
                function() 
                    output("MORT CALLBACK");
                    Console.write("MORT CALLBACK");
                    local mortCult = find_uicomponent(core:get_ui_root(), "mortuary_cult");
                    Console.write("MORT FOUND");
                    local player = Text.new("myText", mortCult, "Custom Text");
                    player:MoveTo(425, 85);
                    -- Image.new("uppercase", mortCult, core:get_ui_root(), uicomp, find_uicomponent_by_table_func);                    
                    output("MORT CALLBACK END");
                    Console.write("MORT CALLBACK END");                  
                    local mortCultBox = find_uicomponent(core:get_ui_root(), "mortuary_cult", "listview", "list_clip", "list_box", "wh2_dlc09_ritual_crafting_tmb_army_capacity");
                    if not mortCultBox then
                        Console.write("mortCultBox not found");
                    end
                    local myImage = Image.new("uppercase", mortCultBox, "ui/skins/default/advisor_beastmen_2d.png");
                    myImage:MoveTo(250, 200);
                    myImage:SetTooltip("My tooptip");
                    local myButton = Button.new("mybtton", mortCult, "CIRCULAR", "ui/campaign ui/edicts/lzd_alignment_of_building.png");
                    myButton:MoveTo(500, 200);

                    local found = Util.getComponentWithName("uppercase");
                    if not found then
                        output("Not found");
                    else
                        output("Found wrong");
                    end

                    --core:add_listener(
                    --    "click_listenr_vanish",
                    --    "ComponentLClickUp",
                    --    function(context)
                    --        return myImage:GetUIC() == UIComponent(context.component);
                    --    end,
                    --    function(context)
                    --        output("Image clicked.");
                    --    end,
                    --    true
                    --);

       --cm:repeat_callback(
        --    function()
        --    local random = math.random();
        --    output("rand"..random);
        --    player:SetStateText(""..random);
        --    end, 0.2, "test_asdasd"
        --    );         
                end,
                0.1,
                "UIBLOCK"
            );
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
            output("RECRUIT OPENED");
            Console.write("RECRUIT OPENED");
            cm:callback(
                function()
                    output("RECRUIT CALLBACK");
                    local recruitmentList = find_uicomponent(core:get_ui_root(), 
                        "units_panel", "main_units_panel", "recruitment_docker", "recruitment_options", "recruitment_listbox",
                        "local1", "unit_list", "listview", "list_clip", "list_box"
                    )
                    for i = 0, recruitmentList:ChildCount() - 1 do	
                        local recuitmentOption = UIComponent(recruitmentList:Find(i));
                        local recruitText = Text.new("abc" .. i, recuitmentOption, "ABC");
                        Components.positionRelativeTo(recruitText.uic, recuitmentOption, 20, 20);
                    end
                    output("RECRUIT CALLBACK END");
                end,
                0.1,
                "UIBLOCK2"
            );
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
                local parchment = UIComponent(myFrame.uic:Find("parchment"));
                --Components.scale(parchment, 0.5);
                --Components.scale(myFrame.uic, 0.5);
                myFrame.uic:MoveTo(100, 100);
                myFrame:AddCloseButton();

                local images = Text.new("images", myFrame.uic, "Images");
                Components.positionRelativeTo(images.uic, myFrame.uic, 50, 80);                
                local firstImage = Image.new("firstImage", myFrame.uic, "ui/skins/default/advisor_beastmen_2d.png");
                Components.positionRelativeTo(firstImage.uic, myFrame.uic, 50, 100);
                local secondImage = Image.new("secondImage", myFrame.uic, "ui/skins/default/advisor_beastmen_2d.png");
                Components.scale(secondImage.uic, 0.5);
                Components.positionRelativeTo(secondImage.uic, myFrame.uic, 100, 100);
                local thirdImage = Image.new("thirdImage", myFrame.uic, "ui/skins/default/advisor_beastmen_2d.png");
                Components.positionRelativeTo(thirdImage.uic, myFrame.uic, 150, 100);
                thirdImage.uic:SetImageRotation(0, math.pi / 2);
                local fourthImage = Image.new("fourthImage", myFrame.uic, "ui/skins/default/advisor_beastmen_2d.png");
                Components.positionRelativeTo(fourthImage.uic, myFrame.uic, 200, 100);
                fourthImage:SetTooltip("My tooltip");
                local fifthImage = Image.new("fifthImage", myFrame.uic, "ui/skins/default/advisor_beastmen_2d.png");
                Components.positionRelativeTo(fifthImage.uic, myFrame.uic, 250, 100);
                fifthImage:SetOpacity(50);

                local buttons = Text.new("buttons", myFrame.uic, "Buttons");
                Components.positionRelativeTo(buttons.uic, myFrame.uic, 50, 130);                
                local squareButton = Button.new("squareButton", myFrame.uic, "SQUARE", "ui/skins/default/icon_end_turn.png");
                Components.positionRelativeTo(squareButton.uic, myFrame.uic, 50, 150);
                local circularButton = Button.new("circularButton", myFrame.uic, "CIRCULAR", "ui/skins/default/icon_end_turn.png");
                Components.positionRelativeTo(circularButton.uic, myFrame.uic, 100, 150);
                local textButton = Button.new("textButton", myFrame.uic, "TEXT", "customText");
                Components.positionRelativeTo(textButton.uic, myFrame.uic, 150, 150);

                local resizedSquareButton = Button.new("resizedSquareButton", myFrame.uic, "SQUARE", "ui/skins/default/icon_end_turn.png");
                Components.scale(resizedSquareButton.uic, 0.5);
                Components.positionRelativeTo(resizedSquareButton.uic, myFrame.uic, 50, 200);
                local resizedCircularButton = Button.new("resizedCircularButton", myFrame.uic, "CIRCULAR", "ui/skins/default/icon_end_turn.png");
                Components.scale(resizedCircularButton.uic, 0.5);
                Components.positionRelativeTo(resizedCircularButton.uic, myFrame.uic, 100, 200);
                local resizedTextButton = Button.new("resizedTextButton", myFrame.uic, "TEXT", "customText");
                resizedTextButton.uic:ResizeTextResizingComponentToInitialSize(250, resizedTextButton.uic:Height())
                Components.positionRelativeTo(resizedTextButton.uic, myFrame.uic, 150, 200);

                local toggleButtons = Text.new("toggleButtons", myFrame.uic, "Toggle Buttons");
                Components.positionRelativeTo(toggleButtons.uic, myFrame.uic, 50, 230);                
                local squareToggleButton = Button.new("squareToggleButton", myFrame.uic, "SQUARE_TOGGLE", "ui/skins/default/icon_end_turn.png");
                Components.positionRelativeTo(squareToggleButton.uic, myFrame.uic, 50, 250);
                --local circularToggleButton = Button.new("circularToggleButton", myFrame.uic, "CIRCULAR_TOGGLE", "ui/skins/default/icon_end_turn.png");
                --Components.positionRelativeTo(circularToggleButton.uic, myFrame.uic, 50, 190);
                local textToggleButton = Button.new("textToggleButton", myFrame.uic, "TEXT_TOGGLE", "customText");
                Components.positionRelativeTo(textToggleButton.uic, myFrame.uic, 150, 250);

                local buttonLogic = Text.new("buttonLogic", myFrame.uic, "Button Logic");
                Components.positionRelativeTo(buttonLogic.uic, myFrame.uic, 50, 290);   
                local incrementButton = Button.new("incrementButton", myFrame.uic, "TEXT", "+");
                incrementButton.uic:ResizeTextResizingComponentToInitialSize(100, 51);
                Components.positionRelativeTo(incrementButton.uic, myFrame.uic, 50, 310);
                local decrementButton = Button.new("decrementButton", myFrame.uic, "TEXT", "-");
                decrementButton.uic:ResizeTextResizingComponentToInitialSize(100, 51);
                Components.positionRelativeTo(decrementButton.uic, myFrame.uic, 100, 310);
                local counterText = Text.new("CounterText", myFrame.uic, "0");
                Components.positionRelativeTo(counterText.uic, myFrame.uic, 200, 310);
                Util.registerForClick(incrementButton.uic, "incrementCounter",
                    function(context)
                        local number = tonumber(counterText.uic:GetStateText());
                        if number < 8 then
                            local newText = tostring(number + 1);
                            counterText.uic:SetStateText(newText);
                        end
                    end
                );
                Util.registerForClick(decrementButton.uic, "decrementCounter",
                    function(context)
                        local number = tonumber(counterText.uic:GetStateText());
                        if number > 0 then
                            local newText = tostring(number - 1);
                            counterText.uic:SetStateText(newText);
                        end
                    end
                );

                local greenText = Text.new("greenText", myFrame.uic, "[[col:green]]This is green text[[/col]]");
                Components.positionRelativeTo(greenText.uic, myFrame.uic, 50, 350);
                local iconText = Text.new("iconText", myFrame.uic, "[[img:icon_arrow_up]][[/img]]This text has icons in[[img:icon_arrow_up]][[/img]]");
                Components.positionRelativeTo(iconText.uic, myFrame.uic, 50, 370);
                local resizedText = Text.new("resizedText", myFrame.uic, "Small text");
                Components.scale(resizedText.uic, 0.5);
                Components.positionRelativeTo(resizedText.uic, myFrame.uic, 50, 390);
                
                local textOutside = Text.new("textOutside", parchment, "Im outside");
                Components.positionRelativeTo(textOutside.uic, parchment, 50, 800);
            else
                output("FRAME FOUND");
                existingFrame:SetVisible(true);
            end
            output("FRAME CREATE END");
		end,
		true
	);

    output("END");
    Console.write("END");
end