local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zayn312142/Luna-Interface-Suite/refs/heads/main/source.lua", true))()

local HttpService = game:GetService("HttpService")

local configFile = "SterlingHubConfig.json"

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
		RootFolder = nil, -- The Root Folder Is Only If You Have A Hub With Multiple Game Scripts and u may remove it. DO NOT ADD A SLASH
		ConfigFolder = "Sterling Hub" -- The Name Of The Folder Where Luna Will Store Configs For This Script. DO NOT ADD A SLASH
    },
})

Window:CreateHomeTab({
	SupportedExecutors = {}, -- A Table Of Executors Your Script Supports. Add strings of the executor names for each executor.
	DiscordInvite = "pvwpXmTmT7", -- The Discord Invite Link. Do Not Include discord.gg/ | Only Include the code.
	Icon = 1, -- By Default, The Icon Is The Home Icon. If You would like to change it to dashboard, replace the interger with 2
})

local Tab = Window:CreateTab({
    Name = "Main",
    Icon = "settings_input_antenna",
    ImageSource = "Material",
    ShowTitle = true
})

local SliderValue = 0 -- Variable to store the slider value

-- Create the slider
local Slider = Tab:CreateSlider({
    Name = "Money Slider",
    Description = "Choose the amount of money to receive",
    Range = {0, 600000000}, -- Maximum value (600k)
    CurrentValue = 0, -- Default value
    Increment = 1, -- Increment step (to match the 1,400 reward per fire)
    Callback = function(Value)
        SliderValue = Value -- Store the selected value
    end
})

-- Create the button
local Button = Tab:CreateButton({
    Name = "Claim Money",
    Description = "Click to receive the selected amount of money",
    Callback = function()
        local timesToFire = SliderValue / 1400 -- Calculate how many times to fire the event
        for i = 1, timesToFire do
            game:GetService("ReplicatedStorage").packages.Net["RE/DailyReward/Claim"]:FireServer()
            task.wait(0.1) -- Add a short delay to avoid hitting rate limits
        end
    end
})
