function demo_uimf()
    local enableDemoUI = true;
    local enableRecuitmentDemo = true;
    local enableMortCultDemo = true;
    local enableFlowLayoutDemoUI = true;

    if enableDemoUI then
        core:add_listener(
            "createFrame",
            "ShortcutTriggered",
            function(context) return context.string == "camera_bookmark_view2"; end, --default F11
            function(context)
                local existingFrame = Util.getComponentWithName("MyFrame");
                if not existingFrame then
                    local myFrame = Frame.new("MyFrame");
                    myFrame:Scale(1.5);
                    myFrame:MoveTo(100, 100);
                    myFrame:AddCloseButton();

                    local images = Text.new("images", myFrame, "NORMAL", "Images");
                    images:PositionRelativeTo(myFrame, 20, 20);
                    local normalImage = Image.new("normalImage", myFrame, "ui/skins/default/advisor_beastmen_2d.png");
                    normalImage:PositionRelativeTo(images, 0, 20);
                    local smallImage = Image.new("smallImage", myFrame, "ui/skins/default/advisor_beastmen_2d.png");
                    smallImage:Scale(0.5);
                    smallImage:PositionRelativeTo(normalImage, 50, 0);
                    local rotatedImage = Image.new("rotatedImage", myFrame, "ui/skins/default/advisor_beastmen_2d.png");
                    rotatedImage:SetRotation(math.pi / 2);
                    rotatedImage:PositionRelativeTo(smallImage, 50, 0);
                    local transparentImage = Image.new("transparentImage", myFrame, "ui/skins/default/advisor_beastmen_2d.png");
                    transparentImage:SetOpacity(50);
                    transparentImage:PositionRelativeTo(rotatedImage, 50, 0);

                    local buttons = Text.new("buttons", myFrame, "NORMAL", "Buttons");
                    buttons:PositionRelativeTo(images, 0, 50);
                    local squareButton = Button.new("squareButton", myFrame, "SQUARE", "ui/skins/default/icon_end_turn.png");
                    squareButton:PositionRelativeTo(buttons, 0, 20);
                    local circularButton = Button.new("circularButton", myFrame, "CIRCULAR", "ui/skins/default/icon_end_turn.png");
                    circularButton:PositionRelativeTo(squareButton, 50, 0);
                    local textButton = TextButton.new("textButton", myFrame, "TEXT", "customText");
                    textButton:PositionRelativeTo(circularButton, 50, 0);

                    local resizedSquareButton = Button.new("resizedSquareButton", myFrame, "SQUARE", "ui/skins/default/icon_end_turn.png");
                    resizedSquareButton:Scale(0.5);
                    resizedSquareButton:PositionRelativeTo(squareButton, 0, 50);
                    local resizedCircularButton = Button.new("resizedCircularButton", myFrame, "CIRCULAR", "ui/skins/default/icon_end_turn.png");
                    resizedCircularButton:Scale(0.5);
                    resizedCircularButton:PositionRelativeTo(resizedSquareButton, 50, 0);
                    local resizedTextButton = TextButton.new("resizedTextButton", myFrame, "TEXT", "customText");
                    local width, height = resizedTextButton:Bounds();
                    resizedTextButton:Resize(250, height);
                    resizedTextButton:PositionRelativeTo(resizedCircularButton, 50, 0);

                    local toggleButtons = Text.new("toggleButtons", myFrame, "NORMAL", "Toggle Buttons");
                    toggleButtons:PositionRelativeTo(buttons, 0, 100);
                    local squareToggleButton = Button.new("squareToggleButton", myFrame, "SQUARE_TOGGLE", "ui/skins/default/icon_end_turn.png");
                    squareToggleButton:PositionRelativeTo(toggleButtons, 0, 20); 
                    local circularToggleButton = Button.new("circularToggleButton", myFrame, "CIRCULAR_TOGGLE", "ui/skins/default/icon_end_turn.png");
                    circularToggleButton:PositionRelativeTo(squareToggleButton, 50, 0); 
                    local textToggleButton = TextButton.new("textToggleButton", myFrame, "TEXT_TOGGLE", "customText");
                    textToggleButton:PositionRelativeTo(circularToggleButton, 50, 0); 

                    local buttonLogic = Text.new("buttonLogic", myFrame, "NORMAL", "Button Logic");
                    buttonLogic:PositionRelativeTo(toggleButtons, 0, 70);    
                    local incrementButton = TextButton.new("incrementButton", myFrame, "TEXT", "+");
                    incrementButton:Resize(100, 51);
                    incrementButton:PositionRelativeTo(buttonLogic, 0, 20);
                    local decrementButton = TextButton.new("decrementButton", myFrame, "TEXT", "-");
                    decrementButton:Resize(100, 51);
                    decrementButton:PositionRelativeTo(incrementButton, 100, 0);
                    local counterText = Text.new("CounterText", myFrame, "NORMAL", "0");
                    counterText:PositionRelativeTo(decrementButton, 100, 0);
                    incrementButton:RegisterForClick("incrementCounter",
                        function(context)
                            local number = tonumber(counterText:GetText());
                            if number < 8 then
                                local newText = tostring(number + 1);
                                counterText:SetText(newText);
                            end
                        end
                    );
                    decrementButton:RegisterForClick("decrementCounter",
                        function(context)
                            local number = tonumber(counterText:GetText());
                            if number > 0 then
                                local newText = tostring(number - 1);
                                counterText:SetText(newText);
                            end
                        end
                    );
                    local toggleTextButton = TextButton.new("toggleTextButton", myFrame, "TEXT_TOGGLE", "Custom text");
                    toggleTextButton:PositionRelativeTo(counterText, 50, 0);
                    toggleTextButton:RegisterForClick("toggleTestListener",
                        function(context)
                            cm:callback(
                                function()
                                    toggleTextButton:SetButtonText(tostring(toggleTextButton:IsSelected()));
                                end, 0.1, "toggleTextListenerText"
                            ) 
                        end
                    );
                    
                    local text = Text.new("text", myFrame, "NORMAL", "Text");
                    text:PositionRelativeTo(buttonLogic, 0, 100);    
                    local greenText = Text.new("greenText", myFrame, "NORMAL", "[[col:green]]This is green text[[/col]]");
                    greenText:PositionRelativeTo(text, 0, 20);  
                    local iconText = Text.new("iconText", myFrame, "NORMAL", "[[img:icon_arrow_up]][[/img]]This text has icons in[[img:icon_arrow_up]][[/img]]");
                    iconText:PositionRelativeTo(greenText, 0, 20);  
                    local resizedText = Text.new("resizedText", myFrame, "NORMAL", "Small text");
                    resizedText:Scale(0.5);
                    resizedText:PositionRelativeTo(iconText, 0, 20);
                    local wrappedText = Text.new("wrappedText", myFrame, "WRAPPED", "This is wrapped text. This is wrapped text. This is wrapped text. This is wrapped text. This is wrapped text. This is wrapped text. This is wrapped text. This is wrapped text. ");
                    wrappedText:Resize(500, 200);
                    wrappedText:PositionRelativeTo(resizedText, 0, 20);
                    local titleText = Text.new("titleText", myFrame, "TITLE", "This is title text");
                    titleText:PositionRelativeTo(wrappedText, 0, 70);

                    local textBox = TextBox.new("textBox", myFrame);
                    textBox:PositionRelativeTo(text, 0, 180);
                    local textBoxButton = Button.new("textBoxButton", myFrame, "CIRCULAR", "ui/skins/default/icon_check.png");
                    textBoxButton:PositionRelativeTo(textBox, 200, 0);
                    local textBoxButtonText = Text.new("textBoxButtonText", myFrame, "NORMAL", "CUSTOM_TEXT");
                    textBoxButtonText:PositionRelativeTo(textBoxButton, 50, 0);
                    textBoxButton:RegisterForClick("textBoxButtonListener",
                        function(context)
                            textBoxButtonText:SetText(textBox.uic:GetStateText());
                        end
                    );
                else
                    --# assume existingFrame: BUTTON
                    existingFrame:SetVisible(true);
                end
            end,
            true
        );
    end

    if enableMortCultDemo then
        core:add_listener(
            "mortcultclicked",
            "PanelOpenedCampaign",
            function(context) 
                return context.string == "mortuary_cult"; 
            end,
            function(context)
                local mortCult = find_uicomponent(core:get_ui_root(), "mortuary_cult");
                local myText = Text.new("myText", mortCult, "NORMAL", "Custom Text");
                myText:MoveTo(425, 85);
                local mortCultBox = find_uicomponent(core:get_ui_root(), "mortuary_cult", "listview", "list_clip", "list_box", "wh2_dlc09_ritual_crafting_tmb_army_capacity");
                local myImage = Image.new("uppercase", mortCultBox, "ui/skins/default/advisor_beastmen_2d.png");
                myImage:MoveTo(250, 200);
                local myButton = Button.new("mybtton", mortCult, "CIRCULAR", "ui/campaign ui/edicts/lzd_alignment_of_building.png");
                myButton:MoveTo(500, 200);
            end,
            true
        );
    end

    if enableRecuitmentDemo then
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
                    recruitText:PositionRelativeTo(recuitmentOption, 20, 20);
                end
                output("RECRUIT CALLBACK END");
            end,
            true
        );
    end

    if enableFlowLayoutDemoUI then
        core:add_listener(
            "createFlowLayoutFrame",
            "ShortcutTriggered",
            function(context) return context.string == "camera_bookmark_view3"; end, --default F12
            function(context)
                local existingFrame = Util.getComponentWithName("FlowLayoutDemo");
                if not existingFrame then
                    local myFrame = Frame.new("FlowLayoutDemo");
                    myFrame:Scale(1.5);
                    myFrame:MoveTo(100, 100);
                    myFrame:AddCloseButton();

                    local mainContainer = Container.new(FlowLayout.new("VERTICAL"));
                    local firstButton = TextButton.new("firstButton", myFrame, "TEXT", "Button One");
                    local secondButton = TextButton.new("secondButton", myFrame, "TEXT", "Button Two");
                    local thirdButton = TextButton.new("thirdButton", myFrame, "TEXT", "Button Three");
                    mainContainer:AddComponent(firstButton);
                    mainContainer:AddComponent(secondButton);
                    mainContainer:AddGap(100);
                    mainContainer:AddComponent(thirdButton);

                    local horozontalContainer = Container.new(FlowLayout.new("HOROZONTAL"));
                    local firstHoroButton = TextButton.new("firstHoroButton", myFrame, "TEXT", "Button Four");
                    local containedVerticalContainer = Container.new(FlowLayout.new("VERTICAL"));
                    local firstContainedButton = TextButton.new("firstContainedButton", myFrame, "TEXT", "Button Five");
                    local secondContainedButton = TextButton.new("secondContainedButton", myFrame, "TEXT", "Button Six");
                    containedVerticalContainer:AddComponent(firstContainedButton);
                    containedVerticalContainer:AddComponent(secondContainedButton);
                    horozontalContainer:AddComponent(firstHoroButton);
                    horozontalContainer:AddGap(100);
                    horozontalContainer:AddComponent(containedVerticalContainer);
                    mainContainer:AddComponent(horozontalContainer);

                    mainContainer:PositionRelativeTo(myFrame, 50, 50);
                else
                    --# assume existingFrame: BUTTON
                    existingFrame:SetVisible(true);
                end
            end,
            true
        );
    end
end