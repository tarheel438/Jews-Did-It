local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Rain-Design/Unnamed/main/Library.lua"))()
Library.Theme = "Tokyo Night"
local Flags = Library.Flags
local Window = Library:Window({Text = "FIAS | Cash App: alwayswayfaring — Grateful for all donations!"})
local MainTab = Window:Tab({Text = "Main"})
local CombatTab = Window:Tab({Text = "Combat"})
local HeavyTab = Window:Tab({Text = "Heavy Attacks"})
local EmotesTab = Window:Tab({Text = "Emotes"})
local MainSection = MainTab:Section({Text = "Main Features"})
local CombatSection = CombatTab:Section({Text = "Combat Settings"})
local HeavySection = HeavyTab:Section({Text = "Heavy Attacks"})
local EmotesSection = EmotesTab:Section({Text = "Emote List"})
local TeleportTab = Window:Tab({Text = "Teleport"})
local TeleportSection = TeleportTab:Section({Text = "Locations"})
local WeaponConfig = require(game:GetService("ReplicatedStorage").Weapons)
local StyleConfig = require(game:GetService("ReplicatedStorage").Classes)
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local currentTrack = nil
local espConnections = {}
local autoKillConnection = nil


local StylesTab = Window:Tab({Text = "Styles"})
local StylesSection = StylesTab:Section({Text = "Style Selection"})
local HitboxTab = Window:Tab({Text = "Hitbox"})
local HitboxSection = HitboxTab:Section({Text = "Hitbox Features"})

HitboxSection:Button(
    {
        Text = "Small Hitbox Extender",
        Callback = function()
            
            --[[
             Credit: USSIndustry
             ]]

            local rs = game:GetService("ReplicatedStorage")
local util = rs:WaitForChild("Utility")
local raycast = util:WaitForChild("RaycastHitboxV4")
local solvers = raycast:WaitForChild("Solvers")

local mult = 100 -- useless uppon 10 tbh

local function hookSolver(module)
    local req = require(module)
    local oldSolve = req.Solve
    
    req.Solve = function(self, point)
        local lastPos, direction = oldSolve(self, point)
        direction = direction * mult * mult
        if point.WorldSpace then
            point.WorldSpace = lastPos + direction
        end
        return lastPos, direction
    end
end

hookSolver(solvers:WaitForChild("Vector3"))
hookSolver(solvers:WaitForChild("LinkAttachments"))
hookSolver(solvers:WaitForChild("Bone"))
hookSolver(solvers:WaitForChild("Attachment"))

local caster = require(raycast:WaitForChild("HitboxCaster"))
local oldCast = caster.Cast

caster.Cast = function(self, origin, direction, ...)
    return oldCast(self, origin, direction * mult * mult, ...)
end

for _, v in pairs(getgc()) do
    if type(v) == "table" and rawget(v, "HitboxActive") then
        v.HitboxActive = true
        if v.HitboxHitList then
            table.clear(v.HitboxHitList)
        end
        if v.HitboxRaycastPoints then
            for _, point in pairs(v.HitboxRaycastPoints) do
                if point.LastPosition and point.WorldSpace then
                    local dir = point.WorldSpace - point.LastPosition
                    point.WorldSpace = point.LastPosition + (dir * mult)
                end
            end
        end
    end
end
        end
    }
)


local function changeClass(className)
	if LocalPlayer and LocalPlayer.leaderstats and LocalPlayer.leaderstats:FindFirstChild("Class") then
		LocalPlayer.leaderstats.Class.Value = className
	else
		print("LOOOOOOOOOOOL")
	end
end

local styles = {
	"Jeet Kune Do",
	"SAVAGE",
	"Karate",
	"Ninja",
	"Kicker",
	"Heavy Hitter",
	"Aggressive",
	"Hitman",
	"Hawk",
	"Bo Staff",
	"Muay Thai",
	"CRASH OUT",
	"Jaw Breaker",
	"Philly",
	"Stud",
	"Squabble",
	"Bones",
	"Peak A Boo",
	"Striker",
	"Boxer",
	"Slap Boxer",
	"Amateur",
	"Baddie"
}

for _, styleName in ipairs(styles) do
	StylesSection:Button({
		Text = styleName,
		Callback = function()
			changeClass(styleName)
		end
	})
end

MainSection:Toggle(
    {
        Text = "Kill low health players",
        Callback = function(enabled)
            if enabled then
                local VirtualInputManager = game:GetService("VirtualInputManager")
                local RunService = game:GetService("RunService")
                local originalPosition = nil
                local function getPlayersBelowHealth()
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                            if player.Character.Humanoid.Health <= 20 and player.Character.Humanoid.Health > 0 then
                                return player
                            end
                        end
                    end
                    return nil
                end
                autoKillConnection =
                    RunService.Heartbeat:Connect(
                    function()
                        local target = getPlayersBelowHealth()
                        if target and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            if not originalPosition then
                                originalPosition = LocalPlayer.Character.HumanoidRootPart.CFrame
                            end
                            LocalPlayer.Character.HumanoidRootPart.CFrame =
                                target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                            LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                        elseif
                            originalPosition and LocalPlayer.Character and
                                LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                         then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = originalPosition
                            originalPosition = nil
                        end
                    end
                )
            else
                if autoKillConnection then
                    autoKillConnection:Disconnect()
                    autoKillConnection = nil
                end
                if
                    LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                        originalPosition
                 then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = originalPosition
                    originalPosition = nil
                end
            end
        end
    }
)

UserInputService.InputBegan:Connect(
    function(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.LeftShift then
            if currentTrack and currentTrack.IsPlaying then
                currentTrack:Stop()
            end
        end
    end
)

CombatSection:Button(
    {
        Text = "Faster punches",
        Callback = function()
            for i,v in pairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "CanAttack") then
                    game:GetService("RunService").Heartbeat:Connect(function()
                        v.CanAttack = true
                    end)
                end
            end
        end
    }
)

local heavyMoves = {
    "Flying Knee",
    "Truck",
    "Drop Kick",
    "Flying Kick",
    "Side Kick",
    "Hard Swing",
    "Strong Shove",
    "Heavy Haymaker"
}
for _, move in ipairs(heavyMoves) do
    HeavySection:Button(
        {
            Text = move,
            Callback = function()
                LocalPlayer.Server.Heavy.Value = move
            end
        }
    )
end

local emoteAnimations = {
    ["Sturdy"] = "117042914260311",
    ["UZI Dance"] = "85034347911052",
    ["Stretching"] = "136062824273742",
    ["Slat"] = "120763222024641",
    ["Scare Off"] = "100130267699800",
    ["Pointing"] = "109022328569818",
    ["Muscle Flex"] = "83146673889164",
    ["Look At Em"] = "129993522134701",
    ["L Dance"] = "119797830122478",
    ["Exum Shuffle"] = "120976231005418",
    ["Facepalm"] = "72183601488494",
    ["Windmill"] = "124610310313589"
}

for emoteName, animId in pairs(emoteAnimations) do
    EmotesSection:Button(
        {
            Text = emoteName,
            Callback = function()
                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                local humanoid = character:WaitForChild("Humanoid")
                local animator = humanoid:WaitForChild("Animator")
                if currentTrack and currentTrack.IsPlaying then
                    currentTrack:Stop()
                end
                local animation = Instance.new("Animation")
                animation.AnimationId = "rbxassetid://" .. animId
                currentTrack = animator:LoadAnimation(animation)
                currentTrack:Play()
            end
        }
    )
end

local grabSpeedMultiplier = 1
local targetAnimationIds = {
    18351831196,
    17843420785,
    17843420785,
    17843420785,
    18955267363,
    17843420785,
    18351831196,
    18684482857,
    17843420785,
    17843420785,
    17843420785,
    17843420785,
    17843420785,
    17843420785,
    18681899099,
    17843420785,
    18351831196,
    17843420785,
    17843420785,
    18667925797,
    17843420785
}

CombatSection:Slider(
    {
        Text = "Grab Speed",
        Default = 1,
        Minimum = 0,
        Maximum = 4,
        Callback = function(value)
            grabSpeedMultiplier = value

            local function adjustGrabSpeed(animator)
                animator.AnimationPlayed:Connect(
                    function(animTrack)
                        local animationId = tonumber(string.match(animTrack.Animation.AnimationId, "%d+"))
                        for _, targetId in ipairs(targetAnimationIds) do
                            if animationId == targetId then
                                task.wait()
                                animTrack:AdjustSpeed(grabSpeedMultiplier)
                                break
                            end
                        end
                    end
                )
            end

            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                local animator = LocalPlayer.Character.Humanoid:FindFirstChild("Animator")
                if animator then
                    adjustGrabSpeed(animator)
                end
            end

            LocalPlayer.CharacterAdded:Connect(
                function(char)
                    local animator = char:WaitForChild("Humanoid"):WaitForChild("Animator")
                    adjustGrabSpeed(animator)
                end
            )
        end
    }
)

local heavyAnimationIds = {
    121294253313428,
    72635433044267,
    121728603397386,
    101423708258453,
    93440471136854,
    99002133064133,
    123691014938028,
    101722801377520
}

MainSection:Toggle(
    {
        Text = "Auto Win Struggle",
        Callback = function(bool)
            if bool then
                getgenv().autoWinStruggleLoop =
                    task.spawn(
                    function()
                        local vim = game:GetService("VirtualInputManager")
                        local LocalPlayer = game.Players.LocalPlayer

                        while task.wait(0.1) do
                            if getgenv().autoWinStruggleLoop == nil then
                                break
                            end

                            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("StruggleStrength") then
                                if LocalPlayer.Character.StruggleStrength.Value > 0 then
                                    vim:SendKeyEvent(true, Enum.KeyCode.G, false, game)
                                end
                            end
                        end
                    end
                )
            else
                if getgenv().autoWinStruggleLoop then
                    task.cancel(getgenv().autoWinStruggleLoop)
                    getgenv().autoWinStruggleLoop = nil
                end
            end
        end
    }
)

MainSection:Toggle(
    {
        Text = "Anti Knockout",
        Callback = function(bool)
            if bool then
                local function nofall()
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") then
                        if char.Humanoid:GetState() == Enum.HumanoidStateType.Ragdoll then
                            char.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                        end
                    end
                end

                getgenv().nofall = game:GetService("RunService").Heartbeat:Connect(nofall)
            else
                if getgenv().nofall then
                    getgenv().nofall:Disconnect()
                    getgenv().nofall = nil
                end
            end
        end
    }
)

MainSection:Button(
    {
        Text = "Chain Multiple Hits",
        Callback = function()
            for i, v in pairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "Combo") then
                    game:GetService("RunService").Heartbeat:Connect(
                        function()
                            v.Combo = 1
                            v.MaxCombo = 900
                        end
                    )
                end
            end
        end
    }
)

MainSection:Button(
    {
        Text = "Infinite Stamina",
        Callback = function()
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")
            local animator = humanoid:WaitForChild("Animator")
            local sprintAnimation = Instance.new("Animation")
            sprintAnimation.AnimationId = "rbxassetid://18954159936"
            local sprintTrack = animator:LoadAnimation(sprintAnimation)
            while true do
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    local args = {[1] = "Sprint", [2] = false}
                    character.Core.Communicate:FindFirstChild(""):FireServer(unpack(args))
                    humanoid.WalkSpeed = 16
                    if not sprintTrack.IsPlaying then
                        sprintTrack:Play()
                    end
                else
                    humanoid.WalkSpeed = 8
                    if sprintTrack.IsPlaying then
                        sprintTrack:Stop()
                    end
                end
                task.wait()
            end
        end
    }
)

local teleportLocations = {
    ["Kitchen"] = Vector3.new(-439.49407958984375, 4.569596290588379, 122.98573303222656),
    ["Cafeteria"] = Vector3.new(-345.4385681152344, 4.570096969604492, 113.72958374023438),
    ["Room 1 Left"] = Vector3.new(-306.3485107421875, 4.570596694946289, 16.088790893554688),
    ["Room 2 Left"] = Vector3.new(-347.6636657714844, 5.003792762756348, 22.52052116394043),
    ["Room 3 Left"] = Vector3.new(-396.6827697753906, 5.224972724914551, 27.619699478149414),
    ["Gym"] = Vector3.new(-201.5467529296875, 4.588627815246582, -12.050016403198242),
    ["Outside"] = Vector3.new(-202.03684997558594, 4.579929351806641, -143.5444793701172),
    ["PVP Room"] = Vector3.new(-87.98230743408203, 4.569597244262695, -21.255481719970703),
    ["Library"] = Vector3.new(-138.91867065429688, 4.570096969604492, 121.71589660644531),
    ["Main Hall"] = Vector3.new(-199.87376403808594, 4.570596694946289, 185.21478271484375),
    ["Nurse Office"] = Vector3.new(-247.98841857910156, 4.569599151611328, 158.08201599121094),
    ["Office"] = Vector3.new(-257.621337890625, 4.570596694946289, 104.35652923583984),
    ["Room 1 Right"] = Vector3.new(-312.20550537109375, 4.570596694946289, 223.95562744140625),
    ["Room 2 Right"] = Vector3.new(-352.4250793457031, 4.570097923278809, 218.8118133544922),
    ["Room 3 Right"] = Vector3.new(-393.19036865234375, 4.570097923278809, 214.93446350097656),
    ["Main Girls Bathroom"] = Vector3.new(-252.99200439453125, 4.570096969604492, 239.705322265625),
    ["Main Boys Bathroom"] = Vector3.new(-211.94691467285156, 4.570096015930176, 241.4774627685547),
    ["Gym Boys Bathroom"] = Vector3.new(-312.3836975097656, 4.569594860076904, -16.49201011657715),
    ["Gym Girls Bathroom"] = Vector3.new(-312.1099853515625, 4.569581508636475, -57.6340446472168)
}

local function teleportTo(position)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

for locationName, position in pairs(teleportLocations) do
    TeleportSection:Button(
        {
            Text = locationName,
            Callback = function()
                teleportTo(position)
            end
        }
    )
end

MainSection:Button(
    {
        Text = "Grab Weapon",
        Callback = function()
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local rootPart = character:WaitForChild("HumanoidRootPart")

            local function teleportToRandomWeapon()
                local weaponDisplays = {}
                for _, item in pairs(workspace.Debris:GetChildren()) do
                    if item.Name == "WEAPON_DISPLAY" then
                        table.insert(weaponDisplays, item)
                    end
                end

                if #weaponDisplays == 0 then
                    return
                end

                local randomWeapon = weaponDisplays[math.random(1, #weaponDisplays)]

                local originalCFrame = rootPart.CFrame

                rootPart.CFrame = CFrame.new(randomWeapon.Position + Vector3.new(0, 3, 0))

                local proximityPrompt
                for _, descendant in ipairs(randomWeapon:GetDescendants()) do
                    if descendant:IsA("ProximityPrompt") then
                        proximityPrompt = descendant
                        break
                    end
                end

                if proximityPrompt then
                    local startTime = tick()
                    while tick() - startTime < 1.1 do
                        fireproximityprompt(proximityPrompt)
                        task.wait()
                    end
                else
                    task.wait(1.1)
                end

                rootPart.CFrame = originalCFrame
            end

            teleportToRandomWeapon()
        end
    }
)

MainSection:Button(
    {
        Text = "Slam/Shove No cooldown",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/USSIndustry/RoScripts/refs/heads/main/FightInASchoolSlamNGrabNoCooldown.lua"))() -- loadstring, esle moonsec shitty obfuscator would make this laggy.
        end
    }
)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Parties = ReplicatedStorage:FindFirstChild("Parties") or Instance.new("Folder")
Parties.Name = "Parties"
Parties.Parent = ReplicatedStorage

local partyColors = {}
local brightColors = {
    Color3.fromRGB(255, 0, 0), 
    Color3.fromRGB(0, 255, 0),   
    Color3.fromRGB(0, 0, 255),    
    Color3.fromRGB(255, 0, 255),   
    Color3.fromRGB(255, 255, 0),   
    Color3.fromRGB(0, 255, 255),  
    Color3.fromRGB(255, 128, 0),  
    Color3.fromRGB(128, 0, 255),   
    Color3.fromRGB(255, 0, 128),   
    Color3.fromRGB(0, 128, 255)    
}

local function getRandomBrightColor()
    return brightColors[math.random(1, #brightColors)]
end

local function highlightPartyMembers()
    for _, partyFolder in ipairs(Parties:GetChildren()) do
        if partyFolder:IsA("Folder") then
            if not partyColors[partyFolder] then
                partyColors[partyFolder] = getRandomBrightColor()
            end
            
            local partyColor = partyColors[partyFolder]
            
            for _, playerValue in ipairs(partyFolder:GetChildren()) do
                if playerValue:IsA("BoolValue") then
                    local playerName = playerValue.Name
                    local player = Players:FindFirstChild(playerName)
                    
                    if player then
                        local character = player.Character
                        if character then
                            local highlight = character:FindFirstChild("PartyHighlight") or Instance.new("Highlight")
                            highlight.Name = "PartyHighlight"
                            highlight.OutlineColor = partyColor
                            highlight.FillTransparency = 1
                            highlight.OutlineTransparency = 0
                            highlight.Parent = character
                        end
                    end
                end
            end
        end
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function()
        task.wait(1)
        if seePartiesEnabled then
            highlightPartyMembers()
        end
    end)
end

local function clearPartyHighlights()
    for _, player in ipairs(Players:GetPlayers()) do
        if player and player.Character then
            local highlight = player.Character:FindFirstChild("PartyHighlight")
            if highlight then
                highlight:Destroy()
            end
        end
    end
end

local seePartiesEnabled = false

MainSection:Toggle({
    Text = "Show Parties",
    Default = false,
    Callback = function(enabled)
        seePartiesEnabled = enabled

        if enabled then
            highlightPartyMembers()
        else
            clearPartyHighlights()
        end
    end
})

Players.PlayerAdded:Connect(onPlayerAdded)

for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

while task.wait(5) do
    if seePartiesEnabled then
        highlightPartyMembers()
    else
        clearPartyHighlights()
    end
end
MainTab:Select()
