-- Combined script with BigBaseplate loading first, then Mobile Buttons and Rayfield UI

-- First, execute the BigBaseplate script
loadstring(game:HttpGet("https://raw.githubusercontent.com/loading123599/Poisons-Hub-V1.1/refs/heads/main/BigBaseplate.lua"))()

-- Wait a moment to ensure BigBaseplate has loaded
wait(1)

-- Then create the mobile buttons
local function createMobileButtons()
    -- Check if the user is on mobile
    local UserInputService = game:GetService("UserInputService")
    local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

    -- Create the GUI
    local MobileButtonsGui = Instance.new("ScreenGui")
    MobileButtonsGui.Name = "MobileButtonsGui"
    MobileButtonsGui.ResetOnSpawn = false
    MobileButtonsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Parent the GUI to the appropriate location
    if game:GetService("RunService"):IsStudio() then
        MobileButtonsGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    else
        MobileButtonsGui.Parent = game.CoreGui
    end

    -- Only show for mobile users
    if not isMobile then
        -- Create a notification for non-mobile users
        local notification = Instance.new("TextLabel")
        notification.Size = UDim2.new(0, 200, 0, 50)
        notification.Position = UDim2.new(0.5, -100, 0.1, 0)
        notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notification.BackgroundTransparency = 0.5
        notification.TextColor3 = Color3.fromRGB(255, 255, 255)
        notification.Text = "Mobile buttons only available on mobile devices"
        notification.TextWrapped = true
        notification.Parent = MobileButtonsGui
        
        -- Remove notification after 5 seconds
        game:GetService("Debris"):AddItem(notification, 5)
        return
    end

    -- Create the B button
    local BButton = Instance.new("TextButton")
    BButton.Name = "BButton"
    BButton.Size = UDim2.new(0, 60, 0, 60)
    BButton.Position = UDim2.new(0.8, 0, 0.6, 0)
    BButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
    BButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
    BButton.Text = "B"
    BButton.TextSize = 24
    BButton.Font = Enum.Font.GothamBold
    BButton.Parent = MobileButtonsGui

    -- Create purple outline for B button
    local BOutline = Instance.new("UIStroke")
    BOutline.Color = Color3.fromRGB(128, 0, 128) -- Purple
    BOutline.Thickness = 3
    BOutline.Parent = BButton

    -- Round the corners
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0.2, 0)
    BCorner.Parent = BButton

    -- Create the Z button
    local ZButton = Instance.new("TextButton")
    ZButton.Name = "ZButton"
    ZButton.Size = UDim2.new(0, 60, 0, 60)
    ZButton.Position = UDim2.new(0.65, 0, 0.6, 0)
    ZButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
    ZButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
    ZButton.Text = "Z"
    ZButton.TextSize = 24
    ZButton.Font = Enum.Font.GothamBold
    ZButton.Parent = MobileButtonsGui

    -- Create purple outline for Z button
    local ZOutline = Instance.new("UIStroke")
    ZOutline.Color = Color3.fromRGB(128, 0, 128) -- Purple
    ZOutline.Thickness = 3
    ZOutline.Parent = ZButton

    -- Round the corners
    local ZCorner = Instance.new("UICorner")
    ZCorner.CornerRadius = UDim.new(0.2, 0)
    ZCorner.Parent = ZButton

    -- Create the toggle button
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Size = UDim2.new(0, 40, 0, 40)
    ToggleButton.Position = UDim2.new(0.9, 0, 0.1, 0)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
    ToggleButton.Text = "≡"
    ToggleButton.TextSize = 24
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Parent = MobileButtonsGui

    -- Create purple outline for toggle button
    local ToggleOutline = Instance.new("UIStroke")
    ToggleOutline.Color = Color3.fromRGB(128, 0, 128) -- Purple
    ToggleOutline.Thickness = 3
    ToggleOutline.Parent = ToggleButton

    -- Round the corners
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0.2, 0)
    ToggleCorner.Parent = ToggleButton

    -- Function to make a button draggable
    local function makeDraggable(button)
        local dragging = false
        local dragInput
        local dragStart
        local startPos
        
        button.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = button.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        
        button.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                button.Position = UDim2.new(
                    startPos.X.Scale, 
                    startPos.X.Offset + delta.X, 
                    startPos.Y.Scale, 
                    startPos.Y.Offset + delta.Y
                )
            end
        end)
    end

    -- Make buttons draggable
    makeDraggable(BButton)
    makeDraggable(ZButton)
    makeDraggable(ToggleButton)

    -- Function to simulate key press
    local function simulateKeyPress(keyCode)
        -- Fire virtual input events
        local vim = game:GetService("VirtualInputManager")
        
        -- Key down
        vim:SendKeyEvent(true, keyCode, false, game)
        
        -- Small delay
        wait(0.05)
        
        -- Key up
        vim:SendKeyEvent(false, keyCode, false, game)
    end

    -- Connect button press events
    BButton.MouseButton1Click:Connect(function()
        simulateKeyPress(Enum.KeyCode.B)
        
        -- Visual feedback
        BButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128) -- Purple flash
        wait(0.1)
        BButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Back to black
    end)

    ZButton.MouseButton1Click:Connect(function()
        simulateKeyPress(Enum.KeyCode.Z)
        
        -- Visual feedback
        ZButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128) -- Purple flash
        wait(0.1)
        ZButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Back to black
    end)

    -- Toggle button functionality
    local buttonsVisible = true
    ToggleButton.MouseButton1Click:Connect(function()
        buttonsVisible = not buttonsVisible
        
        BButton.Visible = buttonsVisible
        ZButton.Visible = buttonsVisible
        
        -- Visual feedback
        ToggleButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128) -- Purple flash
        wait(0.1)
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Back to black
    end)

    -- Notification that buttons are ready
    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0, 200, 0, 50)
    notification.Position = UDim2.new(0.5, -100, 0.1, 0)
    notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    notification.BackgroundTransparency = 0.5
    notification.TextColor3 = Color3.fromRGB(255, 255, 255)
    notification.Text = "Mobile buttons loaded! Drag to reposition."
    notification.TextWrapped = true
    notification.Parent = MobileButtonsGui

    -- Add purple outline to notification
    local notifOutline = Instance.new("UIStroke")
    notifOutline.Color = Color3.fromRGB(128, 0, 128) -- Purple
    notifOutline.Thickness = 2
    notifOutline.Parent = notification

    -- Round the corners
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0.2, 0)
    notifCorner.Parent = notification

    -- Remove notification after 5 seconds
    game:GetService("Debris"):AddItem(notification, 5)

    print("Mobile buttons loaded successfully!")
end

-- Then load the Rayfield UI
local function loadRayfieldUI()
    print("Loading Rayfield UI...")
    
    local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua'))()

    local Window = Rayfield:CreateWindow({
       Name = "Poison's Hub ",
       Icon = 0,
       LoadingTitle = "Welcome. To Poison's Hub",
       LoadingSubtitle = "by Alex and Co Dev & 9'9",
       Theme = {
               TextColor = Color3.fromRGB(0, 0, 0),
               Background = Color3.fromRGB(5, 5, 5),
               Topbar = Color3.fromRGB(138, 43, 226),
               Shadow = Color3.fromRGB(138, 43, 226),

               NotificationBackground = Color3.fromRGB(138, 43, 226),
               NotificationActionsBackground = Color3.fromRGB(138, 43, 226),

               TabBackground = Color3.fromRGB(138, 43, 226),
               TabStroke = Color3.fromRGB(138, 43, 226),
               TabBackgroundSelected = Color3.fromRGB(138, 43, 226),
               TabTextColor = Color3.fromRGB(0, 0, 0),

               SelectedTabTextColor = Color3.fromRGB(255, 255, 255),
               ElementBackground = Color3.fromRGB(138, 43, 226),
               ElementBackgroundHover = Color3.fromRGB(138, 43, 226),
               SecondaryElementBackground = Color3.fromRGB(138, 43, 226),
               ElementStroke = Color3.fromRGB(0, 0, 0),
               SecondaryElementStroke = Color3.fromRGB(138, 43, 226),

               SliderBackground = Color3.fromRGB(5, 5, 5),
               SliderProgress = Color3.fromRGB(138, 43, 226),
               SliderStroke = Color3.fromRGB(138, 43, 226),

               ToggleBackground = Color3.fromRGB(138, 43, 226),
               ToggleEnabled = Color3.fromRGB(138, 43, 226),
               ToggleDisabled = Color3.fromRGB(0, 0, 0),
               ToggleEnabledStroke = Color3.fromRGB(138, 43, 226),
               ToggleDisabledStroke = Color3.fromRGB(0, 0, 0),
               ToggleEnabledOuterStroke = Color3.fromRGB(138, 43, 226),
               ToggleDisabledOuterStroke = Color3.fromRGB(138, 43, 226),

               DropdownSelected = Color3.fromRGB(5, 5, 5),
               DropdownUnselected = Color3.fromRGB(0, 0, 0),

               InputBackground = Color3.fromRGB(0, 0, 0),
               InputStroke = Color3.fromRGB(138, 43, 226),
               PlaceholderColor = Color3.fromRGB(138, 43, 226)
           },
       DisableRayfieldPrompts = false,
       DisableBuildWarnings = false,

       ConfigurationSaving = {
          Enabled = true,
          FolderName = nil,
          FileName = "Poison's Hub"
       },

       Discord = {
          Enabled = true, 
          Invite = "nil", 
          RememberJoins = false
       },

       KeySystem = true,
       KeySettings = {
          Title = "Enter Key Below",
          Subtitle = "Key System",
          Note = "key is poison", 
          FileName = "Key", 
          SaveKey = true,
          GrabKeyFromSite = false,  
          Key = {"poison"}
       }
    })

    local Tab = Window:CreateTab("Main", "home")
    local Slider = Tab:CreateSlider({
       Name = "WalkSpeed",
       Range = {0, 210},
       Increment = 10,
       Suffix = "speed",
       CurrentValue = 10,
       Flag = "speed",
       Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value    
       end,
    })

    local Divider = Tab:CreateDivider()

    local Tab = Window:CreateTab("Universal", "rewind")
    local Button = Tab:CreateButton({
        Name = "Infinite Yield",
        Callback = function()
           loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        end,
    })
    
    local Button = Tab:CreateButton({
        Name = "Vc Unban",
        Callback = function()
             loadstring(game:HttpGet("https://raw.githubusercontent.com/platinumicy/unsuspend/refs/heads/main/unsuspend"))()
        end,
    })

    local Button = Tab:CreateButton({
        Name = "Poison Hub (System Broken Remade)",
        Callback = function()
             loadstring(game:HttpGet("https://raw.githubusercontent.com/loading123599/Poisons-Hub-V1.1/refs/heads/main/Custom%20System%20Broken"))()
        end,
    })

    local Button = Tab:CreateButton({
        Name = "Flash Step",
        Callback = function()
             loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe/main/obf_11l7Y131YqJjZ31QmV5L8pI23V02b3191sEg26E75472Wl78Vi8870jRv5txZyL1.lua.txt"))()
        end,
    })

    local Button = Tab:CreateButton({
        Name = "Jerk Off Tool",
        Callback = function()
             loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
        end,
    })
    
    local Button = Tab:CreateButton({
        Name = "Face Fuck",
        Callback = function()
             loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/bruhlolw/refs/heads/main/face_bang_script.lua'))()
        end,
    })

    local Button = Tab:CreateButton({
        Name = "Tp Tool",
        Callback = function()
            local player = game.Players.LocalPlayer 
            local mouse = player:GetMouse() 

            local tool = Instance.new("Tool") 
            tool.Name = "Teleport Tool" 
            tool.RequiresHandle = false 
            tool.Parent = player.Backpack 

            local function teleportToClick() 
                local character = player.Character or player.CharacterAdded:Wait() 
                local rootPart = character:FindFirstChild("HumanoidRootPart") 

                if rootPart and mouse.Target then 
                    local targetPosition = mouse.Hit.Position 
                    rootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0)) 
                end
            end

            tool.Activated:Connect(teleportToClick) 
        end 
    }) 

    local Divider = Tab:CreateDivider()

    local Tab = Window:CreateTab("Visuals", "eye")
    local Divider = Tab:CreateDivider()

    local Tab = Window:CreateTab("ReAnimation", "user")
    local Divider = Tab:CreateDivider()

    local Tab = Window:CreateTab("Settings", "settings")
    local Divider = Tab:CreateDivider()

    local Tab = Window:CreateTab("Copy Animation", "pen")
    local Divider = Tab:CreateDivider()
    
    print("Rayfield UI loaded successfully!")
end

-- Execute in sequence with proper timing
print("Starting execution sequence...")
print("1. Loading BigBaseplate (already executed)...")
wait(1.5) -- Give BigBaseplate time to initialize

print("2. Creating mobile buttons...")
createMobileButtons()
wait(1) -- Give mobile buttons time to initialize

print("3. Loading Rayfield UI...")
loadRayfieldUI()

print("All components loaded successfully!")
