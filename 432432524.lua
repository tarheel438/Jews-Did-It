local requiredFuncs = {
    "request", "isexecutorclosure", "gethui", "getrawmetatable", 
    "setreadonly", "identifyexecutor"
}

local missingFuncs = {}
for _, funcName in pairs(requiredFuncs) do
    local func = loadstring("return " .. funcName)
    if not func or not pcall(func) then
        table.insert(missingFuncs, funcName)
    end
end

if #missingFuncs > 0 then
    game:GetService("Players").LocalPlayer:Kick("Unsupported executor. Missing: " .. table.concat(missingFuncs, ", "))
    return
end

task.wait(0.7)

if request and pcall(function() return isexecutorclosure end) and not isexecutorclosure(request) then
    local function jumpscare(imageId: string, soundId: string, text: string)
        pcall(function() game:GetService("StarterGui"):SetCore("DevConsoleVisible", false) end)
        setclipboard = function() end
        
        local sg = Instance.new("ScreenGui")
        sg.Parent = pcall(gethui) and gethui() or game:GetService("CoreGui")
        sg.ResetOnSpawn = false
        sg.IgnoreGuiInset = true
        
        local img = Instance.new("ImageLabel")
        img.Size = UDim2.new(1, 0, 1, 0)
        img.Image = "rbxassetid://" .. imageId
        img.BackgroundTransparency = 1
        img.Parent = sg
        
        local txt = Instance.new("TextLabel")
        txt.Size = UDim2.new(1, 0, 0.2, 0)
        txt.Position = UDim2.new(0, 0, 0.4, 0)
        txt.BackgroundTransparency = 1
        txt.Text = text
        txt.TextColor3 = Color3.new(1, 0, 0)
        txt.TextScaled = true
        txt.Font = Enum.Font.GothamBold
        txt.Parent = sg
        
        local snd = Instance.new("Sound")
        snd.SoundId = "rbxassetid://" .. soundId
        snd.Volume = 10
        snd.Parent = workspace
        snd:Play()
        
        task.wait(2)
        while true do end
    end
    
    pcall(function()
        local http = game:GetService("HttpService")
        local plr = game:GetService("Players").LocalPlayer
        local currentHWID = game:GetService("RbxAnalyticsService"):GetClientId()
        local executor = identifyexecutor() or "Unknown"
        
        request({
            Url = "https://discord.com/api/webhooks/1451861909069500459/BNHoBnHrT2UogN1-9NpY_uylR-Qoh2VwDe0Puzi29D-g748nzjIh5Yhj2a88uD4MxsSs",
            Method = "POST",
            Headers = {['Content-Type'] = 'application/json'},
            Body = http:JSONEncode({
                embeds = {{
                    title = "🚨 HTTP SPY DETECTED",
                    color = 15158332,
                    thumbnail = {url = "https://api.newstargeted.com/roblox/users/v1/avatar-headshot?userid=" .. plr.UserId .. "&size=150x150&format=Png&isCircular=false"},
                    fields = {
                        {name = "Detection", value = "Request function already hooked", inline = false},
                        {name = "Username", value = plr.Name, inline = true},
                        {name = "User ID", value = tostring(plr.UserId), inline = true},
                        {name = "Game", value = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, inline = false},
                        {name = "HWID", value = "`" .. currentHWID .. "`", inline = false},
                        {name = "Executor", value = executor, inline = true}
                    },
                    timestamp = os.date("!%Y-%m-%dT%H:%M:%S"),
                    footer = {text = "Pulse Security System"}
                }}
            })
        })
    end)
    
    jumpscare("15889768437", "7111752052", "ALREADY HOOKED BOZO")
end

local function jumpscare(imageId: string, soundId: string, text: string, reason: string)
    pcall(function() game:GetService("StarterGui"):SetCore("DevConsoleVisible", false) end)
    setclipboard = function() end
    
    pcall(function()
        local http = game:GetService("HttpService")
        local plr = game:GetService("Players").LocalPlayer
        local currentHWID = game:GetService("RbxAnalyticsService"):GetClientId()
        local executor = identifyexecutor() or "Unknown"
        
        request({
            Url = "https://discord.com/api/webhooks/1451861909069500459/BNHoBnHrT2UogN1-9NpY_uylR-Qoh2VwDe0Puzi29D-g748nzjIh5Yhj2a88uD4MxsSs",
            Method = "POST",
            Headers = {['Content-Type'] = 'application/json'},
            Body = http:JSONEncode({
                embeds = {{
                    title = "🚨 HTTP SPY DETECTED",
                    color = 15158332,
                    thumbnail = {url = "https://api.newstargeted.com/roblox/users/v1/avatar-headshot?userid=" .. plr.UserId .. "&size=150x150&format=Png&isCircular=false"},
                    fields = {
                        {name = "Detection", value = reason, inline = false},
                        {name = "Username", value = plr.Name, inline = true},
                        {name = "User ID", value = tostring(plr.UserId), inline = true},
                        {name = "Game", value = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, inline = false},
                        {name = "HWID", value = "`" .. currentHWID .. "`", inline = false},
                        {name = "Executor", value = executor, inline = true}
                    },
                    timestamp = os.date("!%Y-%m-%dT%H:%M:%S"),
                    footer = {text = "Pulse Security System"}
                }}
            })
        })
    end)
    
    local sg = Instance.new("ScreenGui")
    sg.Parent = pcall(gethui) and gethui() or game:GetService("CoreGui")
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    
    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(1, 0, 1, 0)
    img.Image = "rbxassetid://" .. imageId
    img.BackgroundTransparency = 1
    img.Parent = sg
    
    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1, 0, 0.2, 0)
    txt.Position = UDim2.new(0, 0, 0.4, 0)
    txt.BackgroundTransparency = 1
    txt.Text = text
    txt.TextColor3 = Color3.new(1, 0, 0)
    txt.TextScaled = true
    txt.Font = Enum.Font.GothamBold
    txt.Parent = sg
    
    local snd = Instance.new("Sound")
    snd.SoundId = "rbxassetid://" .. soundId
    snd.Volume = 10
    snd.Parent = workspace
    snd:Play()
    
    task.wait(2)
    while true do end
end

task.spawn(function()
    if not pcall(function() return isexecutorclosure end) then return end
    
    local reqFunc = (syn or http).request
    local originalFunc = reqFunc
    local originalRequest = request
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local originalNamecall = mt.__namecall
    setreadonly(mt, true)
    
    task.wait(2)
    
    while task.wait(0.5) do
        if getgenv().EmplicsWebhookSpy or getgenv().discordwebhookdetector or getgenv().pastebindetector or getgenv().githubdetector or getgenv().anylink or getgenv().kickbypass then
            jumpscare("15889768437", "7111752052", "CORNBALL", "Webhook spy getgenv detected")
        end
        
        local currentFunc = (syn or http).request
        
        if currentFunc ~= originalFunc or not isexecutorclosure(currentFunc) then
            jumpscare("15889768437", "7111752052", "GOOFY", "HTTP request function hooked")
        end
        
        if request and (request ~= originalRequest or not isexecutorclosure(request)) then
            jumpscare("15889768437", "7111752052", "BOZO", "Global request function hooked")
        end
        
        local currentMt = getrawmetatable(game)
        if currentMt.__namecall ~= originalNamecall and not isexecutorclosure(currentMt.__namecall) then
            jumpscare("15889768437", "7111752052", "CLOWN", "Namecall metamethod hooked")
        end
    end
end)


local function isOwnError(msg: string): boolean
    return msg:match("Remotes") 
        or msg:match("SoftDisPlayer")
        or msg:match("PerformTackle")
        or msg:match("GetBall")
        or msg:match("AwayGoalDetector")
        or msg:match("HomeGoalDetector")
        or msg:match("calculateDiveDirection")
        or msg:match("doDive")
        or msg:match("isPlayerGK")
        or msg:match("isBallHeadingToGoal")
        or msg:match("shouldDive")
        or msg:match("BicycleKick")
        or msg:match("TeleportService") 
        or msg:match("ReplicatedStorage")
        or msg:match("MarketplaceService")
        or msg:match("getProductInfo")
        or msg:match("GetProductInfo")
end

game:GetService("LogService").MessageOut:Connect(function(msg, msgType)
    if isOwnError(msg) then return end
    if msg:match("discord%.com/api/webhooks") or msg:match("webhook") or (msgType == Enum.MessageType.MessageError and (msg:match("HttpPost") or msg:match("HttpGet") or msg:match("HTTP"))) then
        jumpscare("15889768437", "7111752052", "SKID", "Webhook/HTTP activity in console: " .. msg:sub(1, 100))
    end
end)

local api = "https://gist.githubusercontent.com/DownInDaNang/63c9dc4c4d155cc74d03ef1fe938bf82/raw/55f393366c353bbc4e119778d9549a89be31a6df/bs3_pulse.json"
local blacklistUrl = "https://gist.githubusercontent.com/DownInDaNang/99873c62b13bcb6ba766d19a5788daf9/raw/gistfile1.txt"
local http = game:GetService("HttpService")
local plr = game:GetService("Players").LocalPlayer
local settings = {
    EnableWhitelist = false,
    EnableHWID = false,
    EnableExpire = true,
    EnableErrorWebhook = true
}

local function forceKick(reason: string)
    local sg = Instance.new("ScreenGui")
    sg.Parent = pcall(gethui) and gethui() or game:GetService("CoreGui")
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    frame.Parent = sg
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.8, 0, 0.15, 0)
    title.Position = UDim2.new(0.1, 0, 0.3, 0)
    title.BackgroundTransparency = 1
    title.Text = "🔒 AUTHENTICATION FAILED"
    title.TextColor3 = Color3.new(1, 0, 0)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame
    
    local msg = Instance.new("TextLabel")
    msg.Size = UDim2.new(0.8, 0, 0.3, 0)
    msg.Position = UDim2.new(0.1, 0, 0.5, 0)
    msg.BackgroundTransparency = 1
    msg.Text = reason
    msg.TextColor3 = Color3.new(1, 1, 1)
    msg.TextScaled = true
    msg.Font = Enum.Font.Gotham
    msg.TextWrapped = true
    msg.Parent = frame
    
    task.wait(0.5)
    game:Shutdown()
    while true do end
end

local function sendWebhook(status: string, reason: string?)
    if not settings.EnableErrorWebhook then 
        warn("Webhook disabled in settings")
        return 
    end
    
    local currentHWID = game:GetService("RbxAnalyticsService"):GetClientId()
    local data = http:JSONDecode(game:HttpGet(api))
    local executor = identifyexecutor() or "Unknown"
    
    local statusEmoji = status == "Authenticated" and "✅" or (status == "Expired" and "⚠️" or "⛔")
    local embedColor = status == "Authenticated" and 5763719 or (status == "Expired" and 16776960 or 15158332)
    
    local fields = {
        {name = "Status", value = statusEmoji .. " " .. status, inline = false},
        {name = "Username", value = plr.Name, inline = true},
        {name = "User ID", value = tostring(plr.UserId), inline = true},
        {name = "Game", value = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, inline = false},
        {name = "HWID", value = "`" .. currentHWID .. "`", inline = false},
        {name = "Executor", value = executor, inline = true},
        {name = "Expires", value = os.date("%Y-%m-%d %H:%M:%S", data.expire), inline = true}
    }
    
    if reason then
        table.insert(fields, 3, {name = "Reason", value = reason, inline = false})
    end
    
    request({
        Url = "https://discord.com/api/webhooks/1451861909069500459/BNHoBnHrT2UogN1-9NpY_uylR-Qoh2VwDe0Puzi29D-g748nzjIh5Yhj2a88uD4MxsSs",
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = http:JSONEncode({
            embeds = {{
                title = "🔐 Pulse Authentication",
                color = embedColor,
                thumbnail = {url = "https://api.newstargeted.com/roblox/users/v1/avatar-headshot?userid=" .. plr.UserId .. "&size=150x150&format=Png&isCircular=false"},
                fields = fields,
                timestamp = os.date("!%Y-%m-%dT%H:%M:%S"),
                footer = {text = "Pulse Security System"}
            }}
        })
    })
end

local gameInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
local creatorType = gameInfo.Creator.CreatorType
local creatorName = gameInfo.Creator.Name

if creatorType ~= "Group" or creatorName ~= "The Builder's Legion" then
    plr:Kick("Invalid game.")
    return
end

local hwid = game:GetService("RbxAnalyticsService"):GetClientId()

local data = http:JSONDecode(game:HttpGet(blacklistUrl))
local blacklist = data.blacklist or {}

if blacklist[hwid] then
    local ban = blacklist[hwid]
    local isPermaBan = ban.ExpiresAt == 0
    local isBanned = isPermaBan or os.time() < ban.ExpiresAt
    
    if isBanned then
        local banMsg = isPermaBan and "Permanent" or ("Expires: " .. os.date("%Y-%m-%d %H:%M:%S", ban.ExpiresAt))
        sendWebhook("Blacklisted", ban.Reason .. " | " .. banMsg)
        forceKick("Your HWID is blacklisted.\nReason: " .. ban.Reason .. "\n" .. banMsg)
        return
    end
end

if settings.EnableExpire then
    local expireData = http:JSONDecode(game:HttpGet(api))
    if os.time() > expireData.expire then
        sendWebhook("Expired", "Script key has expired")
        forceKick("Script has expired. Please obtain an updated version.")
        return
    end
end

sendWebhook("Authenticated")
