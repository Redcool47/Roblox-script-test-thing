-- Variables
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local glove = chr:FindFirstChild("Rhythm") or chr:WaitForChild("Rhythm", 10)
local bars = nil
local scriptEnabled = false
local connection = nil

-- GUI setup
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local toggleButton = Instance.new("TextButton")
local title = Instance.new("TextLabel")
local closeButton = Instance.new("TextButton")

-- Check for Rhythm UI
local success, rhythmGui = pcall(function()
    return plr.PlayerGui:WaitForChild("Rhythm", 10)
end)

if not success or not rhythmGui then
    print("Failed to find Rhythm GUI!")
else
    print("Rhythm GUI found")
    bars = rhythmGui:WaitForChild("MainFrame"):WaitForChild("Bars", 10)
end

-- Check if glove is available
if not glove then
    print("Glove not found! Script will not work without the glove.")
else
    print("Glove found")
end

-- Ensure Bars is valid
if not bars then
    print("Bars UI not found! Script won't work.")
else
    print("Bars UI found")
end

-- Proceed if both glove and bars are found
if glove and bars then
    -- GUI Properties
    screenGui.Parent = plr.PlayerGui
    screenGui.ResetOnSpawn = false

    -- Frame properties
    frame.Size = UDim2.new(0, 250, 0, 150)
    frame.Position = UDim2.new(0.5, -125, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    frame.BorderSizePixel = 0
    frame.Draggable = true
    frame.Active = true
    frame.Selectable = true
    frame.Parent = screenGui

    -- Title label properties
    title.Size = UDim2.new(1, 0, 0, 50)
    title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    title.Text = "Rhythm Game🎵"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Parent = frame

    -- Toggle Button properties
    toggleButton.Size = UDim2.new(0, 220, 0, 40)
    toggleButton.Position = UDim2.new(0, 15, 0, 60)
    toggleButton.Text = "Enable Script"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.TextSize = 16
    toggleButton.BorderSizePixel = 0
    toggleButton.Parent = frame

    -- Close Button properties
    closeButton.Size = UDim2.new(0, 40, 0, 40)
    closeButton.Position = UDim2.new(1, -45, 0, 5)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 16
    closeButton.BorderSizePixel = 0
    closeButton.Parent = frame

    -- Function to turn on the script
    local function enableScript()
        if not connection then
            connection = bars.ChildAdded:Connect(function()
                task.delay(1.75, function()
                    if glove then
                        glove:Activate()
                        print("Glove activated!")
                    end
                end)
            end)
            print("Script Enabled")
        end
    end

    -- Function to turn off the script
    local function disableScript()
        if connection then
            connection:Disconnect()
            connection = nil
            print("Script Disabled")
        end
    end

    -- Toggle the script
    local function toggleScript()
        if scriptEnabled then
            scriptEnabled = false
            toggleButton.Text = "Enable Script"
            disableScript()
        else
            scriptEnabled = true
            toggleButton.Text = "Disable Script"
            enableScript()

            -- Flash the button white for 0.5 seconds
            local originalColor = toggleButton.BackgroundColor3
            toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            wait(0.5)
            toggleButton.BackgroundColor3 = originalColor
        end
    end

    -- Close Functionality
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    -- Toggle Button Click Connection
    toggleButton.MouseButton1Click:Connect(toggleScript)

    -- Print debug info to check if everything loaded
    print("Script initialized successfully")
else
    print("Script initialization failed. Ensure both glove and bars are loaded.")
end
