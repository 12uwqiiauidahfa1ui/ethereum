local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zayn312142/Luna-Interface-Suite/refs/heads/main/source.lua", true))()

local http = game:GetService("HttpService")
local userId = game.Players.LocalPlayer.UserId

local blacklist = {1131586622, 1225643250, 1918988070}
for _, id in pairs(blacklist) do
    if userId == id then
        game.Players.LocalPlayer:Kick("Access revoked from using Sterling Hub.")
    end
end

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
    Icon = "settings_input_antenna",
    ImageSource = "Material",
    ShowTitle = true
})

-- 🛠️ Slider for Points
local Slider = Tab:CreateSlider({
    Name = "Points to Give",
    Range = {0, 250000}, -- Set the range to 0 - 250,000
    Increment = 1000, -- Increments of 1,000 points
    CurrentValue = 0, -- Start at 0
    Callback = function(value)
        print("Selected points:", value)
    end
}, "PointsSlider")

-- 🛠️ Button to Send Points
Tab:CreateButton({
    Name = "Give Points",
    Description = "Give the selected amount of points to the player.",
    Callback = function()
        local pointsToGive = Slider.CurrentValue -- Get slider value

        if pointsToGive > 0 and pointsToGive <= 250000 then
            game:GetService("ReplicatedStorage").CarRelated.DataStores.AddPoints:FireServer(pointsToGive)

            -- Success Notification
            Luna:Notification({
                Title = "Points Given",
                Icon = "check_circle",
                ImageSource = "Material",
                Content = "Successfully gave " .. pointsToGive .. " points!",
            })
        else
            -- Error Notification
            Luna:Notification({
                Title = "Error",
                Icon = "error",
                ImageSource = "Material",
                Content = "Invalid points amount! Please select a value between 1 and 250,000.",
            })
        end
    end
})

Tab:CreateSection("Tuning")

-- 🛠️ Slider for Acceleration
local accelerationSlider = Tab:CreateSlider({
    Name = "Acceleration",
    Range = {0, 100}, -- Set the range to 0 - 100
    Increment = 1, -- Increments by 1
    CurrentValue = game:GetService("Players").LocalPlayer.LocalFolder.Acceleration.Value, -- Corrected access to .Value
    Callback = function(value)
        game:GetService("Players").LocalPlayer.LocalFolder.Acceleration.Value = value -- Corrected access to .Value
    end
}, "Acceleration")

-- 🛠️ Slider for Deceleration
local decelerationSlider = Tab:CreateSlider({
    Name = "Deceleration",
    Range = {0, 100}, -- Set the range to 0 - 100
    Increment = 1, -- Increments by 1
    CurrentValue = game:GetService("Players").LocalPlayer.LocalFolder.Deceleration.Value, -- Corrected access to .Value
    Callback = function(value)
        game:GetService("Players").LocalPlayer.LocalFolder.Deceleration.Value = value -- Corrected access to .Value
    end
}, "Deceleration")

-- 🛠️ Slider for Grip
local gripSlider = Tab:CreateSlider({
    Name = "Grip",
    Range = {0, 2}, -- Set the range to 0 - 100
    Increment = 1, -- Increments by 1
    CurrentValue = game:GetService("Players").LocalPlayer.LocalFolder.Grip.Value, -- Corrected access to .Value
    Callback = function(value)
        game:GetService("Players").LocalPlayer.LocalFolder.Grip.Value = value -- Corrected access to .Value
    end
}, "Grip")

-- 🛠️ Slider for Max Speed
local maxSpeedSlider = Tab:CreateSlider({
    Name = "Max Speed",
    Range = {0, 100}, -- Set the range to 0 - 100
    Increment = 1, -- Increments by 1
    CurrentValue = game:GetService("Players").LocalPlayer.LocalFolder.MaxSpeed.Value, -- Corrected access to .Value
    Callback = function(value)
        game:GetService("Players").LocalPlayer.LocalFolder.MaxSpeed.Value = value -- Corrected access to .Value
    end
}, "MaxSpeed")

-- 🛠️ Slider for Responsiveness
local responsivenessSlider = Tab:CreateSlider({
    Name = "Responsiveness",
    Range = {0, 6}, -- Set the range to 0 - 100
    Increment = 1, -- Increments by 1
    CurrentValue = game:GetService("Players").LocalPlayer.LocalFolder.Responsiveness.Value, -- Corrected access to .Value
    Callback = function(value)
        game:GetService("Players").LocalPlayer.LocalFolder.Responsiveness.Value = value -- Corrected access to .Value
    end
}, "Responsiveness")
