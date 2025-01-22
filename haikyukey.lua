-- Fluent UI Setup
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local http = game:GetService("HttpService")
local userId = game.Players.LocalPlayer.UserId

local blacklist = {1131586622, 1225643250, 1918988070, 1965498239}
for _, id in pairs(blacklist) do
    if userId == id then
        game.Players.LocalPlayer:Kick("Access revoked from using Sterling Hub.")
    end
end

local key = ""

-- Filepath for SterlingHubKey.json
local configFilePath = "SterlingHubKey.json"

local hwidFilePath = "SterlingHubHWID.json"

-- Load and Save HWID to JSON File
local function loadHWIDFromFile()
    local success, data = pcall(function()
        return game:GetService("HttpService"):JSONDecode(readfile(hwidFilePath))
    end)
    if success and data then
        return data
    else
        return nil
    end
end

local function saveHWIDToFile(key, hwid)
    local data = loadHWIDFromFile() or {}
    data[key] = hwid
    local success, err = pcall(function()
        writefile(hwidFilePath, game:GetService("HttpService"):JSONEncode(data))
    end)
    if success then
        print("HWID saved for key:", key)
    else
        print("Failed to save HWID:", err)
    end
end

-- Load and Save Key to JSON File
local function loadKeyFromFile()
    local success, data = pcall(function()
        return game:GetService("HttpService"):JSONDecode(readfile(configFilePath))
    end)
    if success and data then
        return data.key
    else
        return nil
    end
end

local function saveKeyToFile(key)
    local data = { key = key }
    local success, err = pcall(function()
        writefile(configFilePath, game:GetService("HttpService"):JSONEncode(data))
    end)
    if success then
        print("Key saved to file: SterlingHubKey.json")
    else
        print("Failed to save key to file:", err)
    end
end

-- Load saved key if it exists
local savedKey = loadKeyFromFile()
if savedKey then
    key = savedKey
    print("Loaded saved key:", key)
end

-- Plato API Setup
local service = 1095  -- Your service ID
local secret = "92a9fbaf-cc2d-4afc-89f5-d0d0c8392241"  -- Your secret key
local host = "https://api.platoboost.com"

-- Helper Functions
local fRequest = request or http.request or http_request or syn.request
local fToString = tostring
local fGetHwid = gethwid or function() return game:GetService("Players").LocalPlayer.UserId end
local fOsTime = os.time

-- Plato Cache Setup
local cachedLink, cachedTime = "", 0

local function cacheLink()
    if cachedTime + (10 * 60) < fOsTime() then
        local response = fRequest({
            Url = host .. "/public/start",
            Method = "POST",
            Body = game:GetService('HttpService'):JSONEncode({
                service = service,
                identifier = fGetHwid()
            }),
            Headers = {
                ["Content-Type"] = "application/json"
            }
        })

        if response.StatusCode == 200 then
            local decoded = game:GetService('HttpService'):JSONDecode(response.Body)
            if decoded.success then
                cachedLink = decoded.data.url
                cachedTime = fOsTime()
                return true, cachedLink
            else
                print("API Error:", decoded.message)
                return false, decoded.message
            end
        else
            print("HTTP Request Failed: Status Code", response.StatusCode)
            return false, "Failed to cache link"
        end
    else
        return true, cachedLink
    end
end


local function generateNonce()
    local str = ""
    for _ = 1, 16 do
        str = str .. string.char(math.floor(math.random() * (122 - 97 + 1)) + 97)
    end
    return str
end

-- Whitelist keys
local whitelist = {
    "KEY_crip213",
    "KEY_ego213",
    "KEY_dan521",
    "KEY_yonkiers721",
    "KEY_tetsuo876",
    "KEY_kuan213",
    "KEY_neko732",
    "KEY_buyer98388",
    "KEY_givelofetime2883",
    "KEY_lofevive0983"
    
}

-- Original verifyKey function with HWID lock integration
local function verifyKey(key)
    -- Check whitelisted keys first
    for _, whitelistedKey in ipairs(whitelist) do
        if key == whitelistedKey then
            -- Get current HWID
            local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
            local savedHWIDData = loadHWIDFromFile()

            -- If HWID is already associated with this key, check if it matches
            if savedHWIDData and savedHWIDData[key] then
                if savedHWIDData[key] == HWID then
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/Zayn312142/thing/refs/heads/main/haikyu"))()
                    print("Whitelisted key detected. HWID matches. Access granted!")
                    return true
                else
                    print("This key is locked to a different HWID.")
                    return false
                end
            else
                -- First time entering the key, save the HWID
                saveHWIDToFile(key, HWID)
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Zayn312142/thing/refs/heads/main/haikyu"))()
                print("Whitelisted key detected. HWID locked. Access granted!")
                return true
            end
        end
    end

    -- Continue with your external verification if key is not whitelisted
    local nonce = generateNonce()
    local endpoint = host .. "/public/whitelist/" .. fToString(service) .. "?identifier=" .. fGetHwid() .. "&key=" .. key

    local response = fRequest({
        Url = endpoint,
        Method = "GET",
    })

    if response.StatusCode == 200 then
        local decoded = game:GetService('HttpService'):JSONDecode(response.Body)
        if decoded.success then
            if decoded.data.valid then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Zayn312142/thing/refs/heads/main/haikyu"))()
                print("Valid key detected. Access granted!")
                saveKeyToFile(key)
                return true
            else
                print("Key is invalid.")
                return false
            end
        else
            print("API Error:", decoded.message)
            return false
        end
    else
        print("Server error. Status Code:", response.StatusCode)
        return false
    end
end

-- Fluent UI Setup
local Window = Fluent:CreateWindow({
    Title = "Key System",
    SubTitle = "SterlingHub",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 340),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    KeySys = Window:AddTab({ Title = "Key System", Icon = "key" }),
}

-- Add the check for Luna UI and destroy Fluent UI if necessary
local function checkForLunaUIAndDestroyFluent()
    for _, gui in ipairs(game:GetService("CoreGui"):GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Name == "Luna UI" then  -- Replace "Luna UI" with the actual name of the Luna UI
            print("Luna UI detected. Destroying Fluent UI.")
            local fluentGui = nil
            for _, child in ipairs(game:GetService("CoreGui"):GetChildren()) do
                if child:IsA("ScreenGui") and child.Name == "ScreenGui" then
                    if child:FindFirstChild("Frame") then  -- Adjust this if needed based on Fluent UI's structure
                        fluentGui = child
                        break
                    end
                end
            end
            if fluentGui then
                fluentGui:Destroy()
                print("Fluent UI has been destroyed.")
            else
                print("Fluent UI not found.")
            end
            break  -- Stop checking after Luna UI is found
        end
    end
end

-- Call this function after Fluent UI initialization
checkForLunaUIAndDestroyFluent()

-- Create the Key Input Box
local Entkey = Tabs.KeySys:AddInput("Input", {
    Title = "Enter Key",
    Description = "Enter Key Here",
    Default = savedKey or "",
    Placeholder = "Enter key…",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        key = Value
        saveKeyToFile(key)  -- Save the key whenever the user enters it
    end
})

-- "Check Key" Button
Tabs.KeySys:AddButton({
    Title = "Check Key",
    Description = "Enter Key before pressing this button",
    Callback = function()
        if verifyKey(key) then
            print("Key is valid!")

            -- Wait a short period for the UI to finish loading
            wait(1)

            -- Search for Fluent UI ScreenGui in CoreGui
            local fluentGui = nil
            for _, gui in ipairs(game:GetService("CoreGui"):GetChildren()) do
                if gui:IsA("ScreenGui") and gui.Name == "ScreenGui" then
                    print("Found ScreenGui in CoreGui:", gui)  -- Debugging: Confirm if it's found
                    if gui:FindFirstChild("Frame") then
                        fluentGui = gui
                        break
                    end
                end
            end

            -- If Fluent UI ScreenGui is found, destroy it
            if fluentGui then
                fluentGui:Destroy()
                print("Fluent UI has been removed.")
            else
                print("Fluent UI ScreenGui not found or missing Frame.")
            end

        else
            print("Key is invalid")
            game:GetService('StarterGui'):SetCore('SendNotification', {
                Title = 'Invalid Key',
                Text = 'The entered key is not valid.',
                Duration = 5
            })
        end
    end
})



-- "Get Key" Button
Tabs.KeySys:AddButton({
    Title = "Get Key",
    Description = "Get Key here",
    Callback = function()
        local success, link = cacheLink()
        if success then
            print("Key Link:", link)
            setclipboard(link)
            game:GetService('StarterGui'):SetCore('SendNotification', {
                Title = 'Key Link Copied',
                Text = 'Key link copied to clipboard.',
                Duration = 5
            })
        else
            print("Failed to generate key link.")
            game:GetService('StarterGui'):SetCore('SendNotification', {
                Title = 'Error',
                Text = 'Failed to generate key link.',
                Duration = 5
            })
        end
    end
})

Window:SelectTab(1)

-- Auto-check the loaded key if available
if savedKey then
    print("Auto-checking saved key:", savedKey)
    verifyKey(savedKey)
end
