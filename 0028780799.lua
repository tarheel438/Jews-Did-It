if request and not isexecutorclosure(request) then
    local function jumpscare(imageId: string, soundId: string, text: string)
        pcall(function() game:GetService("StarterGui"):SetCore("DevConsoleVisible", false) end)
        setclipboard = function() end
        
        local sg = Instance.new("ScreenGui")
        sg.Parent = game:GetService("CoreGui")
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
    sg.Parent = game:GetService("CoreGui")
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
            local info = debug.getinfo(currentMt.__namecall, "s")
            if info and not info.source:match("@Pulse") then
                jumpscare("15889768437", "7111752052", "CLOWN", "Namecall metamethod hooked")
            end
        end
    end
end)


local function isOwnError(msg: string): boolean
    return msg:match("BallEvent") 
        or msg:match("PlayerEvent") 
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
