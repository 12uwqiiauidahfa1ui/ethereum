local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zayn312142/Luna-Interface-Suite/refs/heads/main/source.lua", true))()

local HttpService = game:GetService("HttpService")

local configFile = "SterlingHubHaikyuuConfig.json"

local http = game:GetService("HttpService")
local userId = game.Players.LocalPlayer.UserId

local blacklist = {1131586622, 1225643250, 1918988070}
for _, id in pairs(blacklist) do
    if userId == id then
        game.Players.LocalPlayer:Kick("Access revoked from using Sterling Hub.")
    end
end

-- Default configuration
local config = {
    spikePower = 1,
    diveSpeed = 1,
    blockPower = 1,
    bumpPower = 1,
    servePower = 1,
    jumpPower = 1,
    speed = 1,
    setPower = 1,
    powerfulServeEnabled = false

    
}

-- Load configuration function
local function loadConfig()
    if isfile(configFile) then
        local data = readfile(configFile)
        local success, result = pcall(function()
            return game:GetService("HttpService"):JSONDecode(data)
        end)
        if success then
            for k, v in pairs(result) do
                config[k] = v  -- Update config fields directly
            end
        end
    end
end

local function saveConfig()
    local data = game:GetService("HttpService"):JSONEncode(config)  -- Encode the config directly
    writefile(configFile, data)
end

-- Save configuration function
local function saveConfig()
    local data = game:GetService("HttpService"):JSONEncode(config)  -- Encode the config directly
    writefile(configFile, data)
end

-- Auto-load configuration on script start
loadConfig()


local Window = Luna:CreateWindow({
    Name = "Sterling Hub",
    Subtitle = nil,
    LogoID = "90804827107744",
    LoadingEnabled = true,
    LoadingTitle = "Sterling Hub",
    LoadingSubtitle = "by DAN",
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "Sterling Hub"
    },
})

Window:CreateHomeTab({
    SupportedExecutors = {},
    DiscordInvite = "pvwpXmTmT7",
    Icon = 1,
})

local Tab = Window:CreateTab({
    Name = "Main",
    Icon = "autorenew",
    ImageSource = "Material",
    ShowTitle = true
})

Tab:CreateSection("Main")

local Button = Tab:CreateButton({
	Name = "Break The Match",
	Description = "Stops the match(must be serving)",
    	Callback = function()

local ohNil1 = nil
local ohNumber2 = 0.95

game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.7.0"].knit.Services.GameService.RF.Serve:InvokeServer(ohNil1, ohNumber2)
    	end
})

local UserInputService = game:GetService("UserInputService")

-- Create the toggle UI element
Tab:CreateToggle({
    Name = "Enable Powerful Serve",
    Description = "Press Z to Powerful Serve",
    CurrentValue = config.powerfulServe,
    Callback = function(State)
        powerfulServe = State
        config.powerfulServeEnabled = State
        saveConfig()  -- Save the config after toggling
    end
})

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.Z then
        if powerfulServe then
            game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.7.0"].knit.Services.GameService.RF.Serve:InvokeServer(Vector3.new(0, 0, 0), math.huge)
        end
    end
end)

Tab:CreateSection("Stat Changer")

local Slider = Tab:CreateSlider({
    Name = "Dive Speed",
    Range = {0, 5},
    Increment = 0.1,
    CurrentValue = config.diveSpeed,
    Callback = function(value)
        game.Players.LocalPlayer:SetAttribute("GameDiveSpeedMultiplier", value)
        print("Dive Speed updated to " .. value)
        config.diveSpeed = value 
        saveConfig()
    end
})


local Slider = Tab:CreateSlider({
    Name = "Spike Power",
    Range = {0, 500},
    Increment = 0.1,
    CurrentValue = config.spikePower,
    Callback = function(value)
        game.Players.LocalPlayer:SetAttribute("GameSpikePowerMultiplier", value)
        print("Spike Power updated to " .. value)
        config.spikePower = value 
        saveConfig()
    end
})

local Slider = Tab:CreateSlider({
    Name = "Speed",
    Range = {0, 5},
    Increment = 0.1,
    CurrentValue = config.speed,
    Callback = function(value)
        game.Players.LocalPlayer:SetAttribute("GameSpeedMultiplier", value)
        print("Speed updated to " .. value)
        config.speed = value
        saveConfig()
    end
})

local Slider = Tab:CreateSlider({
    Name = "Set Power",
    Range = {0, 500},
    Increment = 0.1,
    CurrentValue = config.setPower,
    Callback = function(value)
        game.Players.LocalPlayer:SetAttribute("GameSetPowerMultiplier", value)
        print("Set Power updated to " .. value)
        config.setPower = value
        saveConfig()
    end
})

local Slider = Tab:CreateSlider({
    Name = "Serve Power",
    Range = {0, 500},
    Increment = 0.1,
    CurrentValue = config.servePower,
    Callback = function(value)
        game.Players.LocalPlayer:SetAttribute("GameServePowerMultiplier", value)
        print("Serve Power updated to " .. value)
        config.servePower = value
        saveConfig()
    end
})

local Slider = Tab:CreateSlider({
    Name = "Jump Power",
    Range = {0, 5},
    Increment = 0.1,
    CurrentValue = config.jumpPower,
    Callback = function(value)
        game.Players.LocalPlayer:SetAttribute("GameJumpPowerMultiplier", value)
        print("Jump Power updated to " .. value)
        config.jumpPower = value
        saveConfig()
    end
})

local Slider = Tab:CreateSlider({
    Name = "Bump Power",
    Range = {0, 500},
    Increment = 0.1,
    CurrentValue = config.bumpPower,
    Callback = function(value)
        game.Players.LocalPlayer:SetAttribute("GameBumpPowerMultiplier", value)
        print("Bump Power updated to " .. value)
        config.bumpPower = value
        saveConfig()    
    end
})

local Slider = Tab:CreateSlider({
    Name = "Block Power",
    Range = {0, 500},
    Increment = 0.1,
    CurrentValue = config.blockPower,
    Callback = function(value)
        game.Players.LocalPlayer:SetAttribute("GameBlockPowerMultiplier", value)
        print("Block Power updated to " .. value)
        config.blockPower = value
        saveConfig()    
    end
})

local Hitbox = Window:CreateTab({
    Name = "Hitboxes",
    Icon = "settings",
    ImageSource = "Material",
    ShowTitle = true
})

Hitbox:CreateSection("Hitbox Extender")

local Slider = Hitbox:CreateSlider({
    Name = "Spike Hitbox Size",
    Range = {1, 100}, -- Adjust the range as needed
    Increment = 0.1,
    CurrentValue = game:GetService("ReplicatedStorage").Assets.Hitboxes.Spike.Part.Size.X, 
    Callback = function(value)
        local spikeHitbox = game:GetService("ReplicatedStorage").Assets.Hitboxes.Spike
        local part = spikeHitbox:FindFirstChild("Part") -- Ensure we get the correct Part

        if part and part:IsA("BasePart") then
            -- Update the size of the part for all axes (X, Y, Z)
            part.Size = Vector3.new(value, value, value)
            print("Spike Part size updated to " .. tostring(part.Size))
        else
            warn("Part not found in Spike hitbox!")
        end
    end
})

local Slider = Hitbox:CreateSlider({
    Name = "Set Hitbox Size",
    Range = {1, 100}, -- Adjust the range as needed
    Increment = 0.1,
    CurrentValue = game:GetService("ReplicatedStorage").Assets.Hitboxes.Set.Part.Size.X,
    Callback = function(value)
        local setHitbox = game:GetService("ReplicatedStorage").Assets.Hitboxes.Set
        local part = setHitbox:FindFirstChild("Part") -- Ensure we get the correct Part

        if part and part:IsA("BasePart") then
            -- Update the size of the part for all axes (X, Y, Z)
            part.Size = Vector3.new(value, value, value)
            print("Set Part size updated to " .. tostring(part.Size))
        else
            warn("Part not found in Set hitbox!")
        end
    end
})

local Slider = Hitbox:CreateSlider({
    Name = "Serve Hitbox Size",
    Range = {1, 100}, -- Adjust the range as needed
    Increment = 0.1,
    CurrentValue = game:GetService("ReplicatedStorage").Assets.Hitboxes.Serve.Part.Size.X,
    Callback = function(value)
        local serveHitbox = game:GetService("ReplicatedStorage").Assets.Hitboxes.Serve
        local part = serveHitbox:FindFirstChild("Part") -- Ensure we get the correct Part

        if part and part:IsA("BasePart") then
            -- Update the size of the part for all axes (X, Y, Z)
            part.Size = Vector3.new(value, value, value)
            print("Serve Part size updated to " .. tostring(part.Size))
        else
            warn("Part not found in Serve hitbox!")
        end
    end
})

local Slider = Hitbox:CreateSlider({
    Name = "Dive Hitbox Size",
    Range = {1, 100}, -- Adjust the range as needed
    Increment = 0.1,
    CurrentValue = game:GetService("ReplicatedStorage").Assets.Hitboxes.Dive.Part.Size.X,
    Callback = function(value)
        local diveHitbox = game:GetService("ReplicatedStorage").Assets.Hitboxes.Dive
        local part = diveHitbox:FindFirstChild("Part") -- Ensure we get the correct Part

        if part and part:IsA("BasePart") then
            -- Update the size of the part for all axes (X, Y, Z)
            part.Size = Vector3.new(value, value, value)
            print("Dive Part size updated to " .. tostring(part.Size))
        else
            warn("Part not found in Dive hitbox!")
        end
    end
})

local Slider = Hitbox:CreateSlider({
    Name = "Bump Hitbox Size",
    Range = {1, 100}, -- Adjust the range as needed
    Increment = 0.1,
    CurrentValue = game:GetService("ReplicatedStorage").Assets.Hitboxes.Bump.Part.Size.X,
    Callback = function(value)
        local bumpHitbox = game:GetService("ReplicatedStorage").Assets.Hitboxes.Bump
        local part = bumpHitbox:FindFirstChild("Part") -- Ensure we get the correct Part

        if part and part:IsA("BasePart") then
            -- Update the size of the part for all axes (X, Y, Z)
            part.Size = Vector3.new(value, value, value)
            print("Bump Part size updated to " .. tostring(part.Size))
        else
            warn("Part not found in Bump hitbox!")
        end
    end
})

local Slider = Hitbox:CreateSlider({
    Name = "Block Hitbox Size",
    Range = {1, 100}, -- Adjust the range as needed
    Increment = 0.1,
    CurrentValue = game:GetService("ReplicatedStorage").Assets.Hitboxes.Block.Part.Size.X,
    Callback = function(value)
        local blockHitbox = game:GetService("ReplicatedStorage").Assets.Hitboxes.Block
        local part = blockHitbox:FindFirstChild("Part") -- Ensure we get the correct Part

        if part and part:IsA("BasePart") then
            -- Update the size of the part for all axes (X, Y, Z)
            part.Size = Vector3.new(value, value, value)
            print("Block Part size updated to " .. tostring(part.Size))
        else
            warn("Part not found in Block hitbox!")
        end
    end
})

local Spin = Window:CreateTab({
    Name = "Auto Spin",
    Icon = "shopping_cart",
    ImageSource = "Material",
    ShowTitle = true
})

local autoSpin = false 

local Toggle = Spin:CreateToggle({
	Name = "Auto Spin",
	Description = nil,
	CurrentValue = false,
	Callback = function(Value)
		autoSpin = Value 
		if autoSpin then
			print("Auto Spin Enabled")
			startAutoSpin()
		else
			print("Auto Spin Disabled")
		end
	end
})

local desiredStyle = "Hinata" 

local Dropdown = Spin:CreateDropdown({
	Name = "Select Desired Style",
	Description = "Choose your desired style",
	Options = {"Oikawa", "Bokuto", "Kageyama", "Sawamura", "Ushijima", "Kozume", "Kuroo", "Yamamoto", "Azumane", "Yaku", "Hinata"},
	CurrentOption = {"Hinata"},
	MultipleOptions = true,
	SpecialType = nil,
	Callback = function(Option)
		desiredStyle = Option -- Update the selected style
		print("Selected Style:", desiredStyle)
	end
})

-- Function to Display Notification
function showNotification(styleName)
	Luna:Notification({
		Title = "Style Obtained!",
		Icon = "check_circle", -- You can use other Material icons
		ImageSource = "Material",
		Content = "You successfully obtained the style: " .. styleName,
	})
end

-- Function to Perform Auto Spin
function startAutoSpin()
	coroutine.wrap(function()
		while autoSpin do
			local int1 = game:GetService("Players").LocalPlayer.PlayerGui.Interface.Lobby.Styles.TopPanel.DisplayName.Text
			if int1 == desiredStyle then
				print("STOP! You got:", int1)
				autoSpin = false -- Stop spinning automatically
				showNotification(int1) -- Show notification
				break
			else
				game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.7.0"].knit.Services.StylesService.RF.Roll:InvokeServer(false)
				print("Spinning... Current result:", int1)
				wait(0.5) -- Delay between spins
			end
		end
	end)()
end
