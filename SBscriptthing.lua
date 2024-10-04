-- Script Variables
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait() -- Ensure the character is loaded
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local toggleButton = Instance.new("TextButton")
local title = Instance.new("TextLabel")
local closeButton = Instance.new("TextButton")
local connection = nil -- Stores the event connection for the bars.ChildAdded

-- GUI Properties
screenGui.Parent = plr.PlayerGui
screenGui.ResetOnSpawn = false

-- Frame properties (Main Container)
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

-- Toggle Button Properties
toggleButton.Size = UDim2.new(0, 220, 0, 40)
toggleButton.Position = UDim2.new(0, 15, 0, 60)
toggleButton.Text = "Enable Script"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 16
toggleButton.BorderSizePixel = 0
toggleButton.Parent = frame

-- Close Button Properties
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -45, 0, 5)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.BorderSizePixel = 0
closeButton.Parent = frame

-- Function to execute the desired script
local function activateRhythmScript()
	local glove = chr:FindFirstChild("Rhythm")
	if not glove then return end
	local bars = plr.PlayerGui.Rhythm.MainFrame.Bars
	
	connection = bars.ChildAdded:Connect(function()
		task.delay(1.75, function()
			glove:Activate()
		end)
	end)
end

-- Function to flash the button
local function flashButton()
	toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Flash white
	wait(0.5) -- Wait for 0.5 seconds
	toggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- Back to normal color
end

-- Toggling functionality
local function toggleScript()
	flashButton() -- Flash the button
	activateRhythmScript() -- Execute the script
end

-- Reset script on death or respawn
plr.CharacterAdded:Connect(function()
	if connection then
		connection:Disconnect()
		connection = nil
	end
end)

-- Close functionality
closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Connect button click
toggleButton.MouseButton1Click:Connect(toggleScript)
