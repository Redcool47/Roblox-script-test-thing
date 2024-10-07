-- Variables
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local glove = chr:WaitForChild("Rhythm", 5)  -- Added wait to ensure glove loads
local bars = plr.PlayerGui:WaitForChild("Rhythm").MainFrame:WaitForChild("Bars")
local scriptEnabled = false
local RhythmSpam = false
local RhythmNoteSpam = false
local connection = nil

-- GUI setup
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local toggleButton = Instance.new("TextButton")
local rhythmSpamButton = Instance.new("TextButton")
local rhythmNoteSpamButton = Instance.new("TextButton")
local title = Instance.new("TextLabel")
local closeButton = Instance.new("TextButton")

-- GUI Properties
screenGui.Parent = plr.PlayerGui
screenGui.ResetOnSpawn = false

-- Frame properties
frame.Size = UDim2.new(0, 250, 0, 250)
frame.Position = UDim2.new(0.5, -125, 0.5, -125)
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

-- Toggle Button (Auto Play Rhythm Game) properties
toggleButton.Size = UDim2.new(0, 220, 0, 40)
toggleButton.Position = UDim2.new(0, 15, 0, 60)
toggleButton.Text = "Autoplay Rhythm Game"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 16
toggleButton.BorderSizePixel = 0
toggleButton.Parent = frame

-- Rhythm Explosion Spam Button properties
rhythmSpamButton.Size = UDim2.new(0, 220, 0, 40)
rhythmSpamButton.Position = UDim2.new(0, 15, 0, 110)
rhythmSpamButton.Text = "Rhythm Explosion Spam (very risky)"
rhythmSpamButton.TextColor3 = Color3.fromRGB(255, 255, 255)
rhythmSpamButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
rhythmSpamButton.Font = Enum.Font.GothamBold
rhythmSpamButton.TextSize = 16
rhythmSpamButton.BorderSizePixel = 0
rhythmSpamButton.Parent = frame

-- Rhythm Note Spam Button properties
rhythmNoteSpamButton.Size = UDim2.new(0, 220, 0, 40)
rhythmNoteSpamButton.Position = UDim2.new(0, 15, 0, 160)
rhythmNoteSpamButton.Text = "Rhythm Note Spam + Auto Press (fast but risky)"
rhythmNoteSpamButton.TextColor3 = Color3.fromRGB(255, 255, 255)
rhythmNoteSpamButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
rhythmNoteSpamButton.Font = Enum.Font.GothamBold
rhythmNoteSpamButton.TextSize = 16
rhythmNoteSpamButton.BorderSizePixel = 0
rhythmNoteSpamButton.Parent = frame

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

-- Function to turn on the "Autoplay Rhythm Game" script
local function enableScript()
	if not connection then
		connection = bars.ChildAdded:Connect(function()
			task.delay(1.75, function()
				if glove then
					glove:Activate()
				end
			end)
		end)
		print("Autoplay Enabled")
	end
end

-- Function to turn off the "Autoplay Rhythm Game" script
local function disableScript()
	if connection then
		connection:Disconnect()
		connection = nil
		print("Autoplay Disabled")
	end
end

-- Toggle the "Autoplay Rhythm Game" script
local function toggleScript()
	if scriptEnabled then
		scriptEnabled = false
		toggleButton.Text = "Autoplay Rhythm Game"
		disableScript()
	else
		scriptEnabled = true
		toggleButton.Text = "Stop Autoplay Rhythm Game"
		enableScript()
		-- Flash the button white for 0.5 seconds
		local originalColor = toggleButton.BackgroundColor3
		toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		wait(0.5)
		toggleButton.BackgroundColor3 = originalColor
	end
end

-- Function to start the rhythm explosion spam
local function startRhythmExplosionSpam()
	RhythmSpam = true
	while RhythmSpam do
		if game:GetService("ReplicatedStorage"):FindFirstChild("rhythmevent") then
			game:GetService("ReplicatedStorage").rhythmevent:FireServer("AoeExplosion", 0)
		else
			warn("Event 'rhythmevent' not found in ReplicatedStorage.")
			break
		end
		task.wait(0.1) -- Adding a small delay to avoid spamming too fast
	end
end

-- Function to stop the rhythm explosion spam
local function stopRhythmExplosionSpam()
	RhythmSpam = false
	print("Rhythm Explosion Spam Stopped")
end

-- Toggle the "Rhythm Explosion Spam" script
local function toggleRhythmExplosionSpam()
	if RhythmSpam then
		stopRhythmExplosionSpam()
		rhythmSpamButton.Text = "Rhythm Explosion Spam (very risky)"
	else
		rhythmSpamButton.Text = "Stop Rhythm Explosion Spam"
		startRhythmExplosionSpam()
	end
end

-- Function to start the rhythm note spam
local function startRhythmNoteSpam()
	RhythmNoteSpam = true
	if game.Players.LocalPlayer.leaderstats and game.Players.LocalPlayer.leaderstats.Glove then
		if game.Players.LocalPlayer.leaderstats.Glove.Value == "Rhythm" then
			while RhythmNoteSpam do
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("Rhythm") then
					local rhythmScript = game.Players.LocalPlayer.PlayerGui.Rhythm:FindFirstChild("LocalScript")
					if rhythmScript then
						rhythmScript.Disabled = false
						rhythmScript.Disabled = true
						game.Players.LocalPlayer.Character.Rhythm:Activate()
					else
					 warn("LocalScript not found in Rhythm.")
					break
					end
				else
					warn("Rhythm GUI not found.")
					break
				end
				task.wait(0.1) -- Adding a small delay to avoid spamming too fast
			end
		else
			warn("You don't have Rhythm equipped.")
		end
	else
		warn("Leaderstats or Glove not found.")
	end
end

-- Function to stop the rhythm note spam
local function stopRhythmNoteSpam()
	RhythmNoteSpam = false
	print("Rhythm Note Spam Stopped")
end

-- Toggle the "Rhythm Note Spam" script
local function toggleRhythmNoteSpam()
	if RhythmNoteSpam then
		stopRhythmNoteSpam()
		rhythmNoteSpamButton.Text = "Rhythm Note Spam + Auto Press (fast but risky)"
	else
		rhythmNoteSpamButton.Text = "Stop Rhythm Note Spam"
		startRhythmNoteSpam()
	end
end

-- Close Functionality
closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Connect buttons to their functions
toggleButton.MouseButton1Click:Connect(toggleScript)
rhythmSpamButton.MouseButton1Click:Connect(toggleRhythmExplosionSpam)
rhythmNoteSpamButton.MouseButton1Click:Connect(toggleRhythmNoteSpam)
