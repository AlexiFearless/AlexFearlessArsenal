--[[
╔═══════════════════════════════════════════════════════════════════════════╗
║                     AdvanceTech Arsenal Script v2.0                        ║
║                      Developed by: AdvanceFalling Team                     ║
║                            Guide: AlexFearless                             ║
╚═══════════════════════════════════════════════════════════════════════════╝
]]

--[[
⣿⠿⠿⠶⠿⢿⣿⣿⣿⣿⣦⣤⣄⢀⡅⢠⣾⣛⡉⠄⠄⠄⠸⢀⣿⠄ ⢀⡋⣡⣴⣶⣶⡀⠄⠄⠙⢿⣿⣿⣿⣿⣿⣴⣿⣿⣿⢃⣤⣄⣀⣥⣿⣿⠄
⢸⣇⠻⣿⣿⣿⣧⣀⢀⣠⡌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⠄⢸⣿⣷⣤⣤⣤⣬⣙⣛⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡍⠄⠄⢀⣤⣄⠉⠋⣰
⣖⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⢇⣿⣿⡷⠶⠶⢿⣿⣿⠇⢀⣤ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣷⣶⣥⣴⣿⡗ 
⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠄ ⣦⣌⣛⣻⣿⣿⣧⠙⠛⠛⡭⠅⠒⠦⠭⣭⡻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠄ 
⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠄⠄⠄⠄⠄⠄⠹⠈⢋⣽⣿⣿⣿⣿⣵⣾⠃⠄ ⣿⣿⣿⣿⣿⣿⣿⣿⠄⣴⣿⣶⣄⠄⣴⣶⠄⢀⣾⣿⣿⣿⣿⣿⣿⠃⠄⠄ 
⠈⠻⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⠄⣿⣿⡀⣾⣿⣿⣿⣿⣛⠛⠁⠄⠄⠄ ⠄⠄⠈⠛⢿⣿⣿⣿⠁⠞⢿⣿⣿⡄⢿⣿⡇⣸⣿⣿⠿⠛⠁⠄⠄⠄⠄⠄
⠄⠄⠄⠄⠄⠉⠻⣿⣿⣾⣦⡙⠻⣷⣾⣿⠃⠿⠋⠁⠄⠄⠄⠄⠄⢀⣠⣴ ⣿⣶⣶⣮⣥⣒⠲⢮⣝⡿⣿⣿⡆⣿⡿⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣠
]]

--[[
TODO:
 - Add aimbot
 - Need new ESP library
 - Other features to be added
]]--

-- ═══════════════════════════════════════════════════════════════════════
-- INITIALIZATION & SERVICES
-- ═══════════════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer

-- ═══════════════════════════════════════════════════════════════════════
-- NOTIFICATIONS
-- ═══════════════════════════════════════════════════════════════════════

StarterGui:SetCore("SendNotification", {
    Title = "AdvanceTech Arsenal",
    Text = "Working For Mobile and PC Executor",
    Duration = 8,
})

wait(1)

StarterGui:SetCore("SendNotification", {
    Title = "Made By:",
    Text = "AdvancedFalling Team | Guide: AlexFearless",
    Icon = "rbxthumb://type=Asset&id=13508183954&w=150&h=150",
    Duration = 8,
})

-- ═══════════════════════════════════════════════════════════════════════
-- FLY SYSTEM
-- ═══════════════════════════════════════════════════════════════════════

local flySettings = {
    fly = false,
    flyspeed = 50
}

local c, h, bv, bav, cam, flying
local p = LocalPlayer

local buttons = {
    W = false,
    S = false,
    A = false,
    D = false,
    Moving = false
}

local function startFly()
    if not p.Character or not p.Character.Head or flying then return end
    
    c = p.Character
    h = c.Humanoid
    h.PlatformStand = true
    cam = Workspace:WaitForChild('Camera')
    
    bv = Instance.new("BodyVelocity")
    bav = Instance.new("BodyAngularVelocity")
    
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.MaxForce = Vector3.new(10000, 10000, 10000)
    bv.P = 1000
    
    bav.AngularVelocity = Vector3.new(0, 0, 0)
    bav.MaxTorque = Vector3.new(10000, 10000, 10000)
    bav.P = 1000
    
    bv.Parent = c.Head
    bav.Parent = c.Head
    flying = true
    
    h.Died:Connect(function()
        flying = false
    end)
end

local function endFly()
    if not p.Character or not flying then return end
    
    h.PlatformStand = false
    if bv then bv:Destroy() end
    if bav then bav:Destroy() end
    flying = false
end

UserInputService.InputBegan:Connect(function(input, GPE)
    if GPE then return end
    
    for i, e in pairs(buttons) do
        if i ~= "Moving" and input.KeyCode == Enum.KeyCode[i] then
            buttons[i] = true
            buttons.Moving = true
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, GPE)
    if GPE then return end
    
    local a = false
    for i, e in pairs(buttons) do
        if i ~= "Moving" then
            if input.KeyCode == Enum.KeyCode[i] then
                buttons[i] = false
            end
            if buttons[i] then
                a = true
            end
        end
    end
    buttons.Moving = a
end)

local function setVec(vec)
    return vec * (flySettings.flyspeed / vec.Magnitude)
end

RunService.Heartbeat:Connect(function(step)
    if flying and c and c.PrimaryPart then
        local pos = c.PrimaryPart.Position
        local cf = cam.CFrame
        local ax, ay, az = cf:toEulerAnglesXYZ()
        
        c:SetPrimaryPartCFrame(CFrame.new(pos.x, pos.y, pos.z) * CFrame.Angles(ax, ay, az))
        
        if buttons.Moving then
            local t = Vector3.new()
            if buttons.W then t = t + (setVec(cf.lookVector)) end
            if buttons.S then t = t - (setVec(cf.lookVector)) end
            if buttons.A then t = t - (setVec(cf.rightVector)) end
            if buttons.D then t = t + (setVec(cf.rightVector)) end
            
            c:TranslateBy(t * step)
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════
-- UI LIBRARY
-- ═══════════════════════════════════════════════════════════════════════

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bitef4/Recode/main/UI/Kavo_1.lua"))()
local Window = Library.CreateLib("AdvanceTech | Arsenal | v2.0", "BlueTheme")

-- ═══════════════════════════════════════════════════════════════════════
-- MAIN TAB
-- ═══════════════════════════════════════════════════════════════════════

local Welcome = Window:NewTab("Main")
local MainSection = Welcome:NewSection("Welcome To AdvanceTech | " .. LocalPlayer.Name)

-- ═══════════════════════════════════════════════════════════════════════
-- HITBOX SECTION
-- ═══════════════════════════════════════════════════════════════════════

local HitboxSection = Welcome:NewSection("> Hitbox Settings <")

local hitboxEnabled = false
local noCollisionEnabled = false
local hitbox_original_properties = {}
local hitboxSize = 21
local hitboxTransparency = 6
local teamCheck = "FFA"

local defaultBodyParts = {
    "UpperTorso",
    "Head",
    "HumanoidRootPart"
}

local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
local WarningText = Instance.new("TextLabel", ScreenGui)

WarningText.Size = UDim2.new(0, 200, 0, 50)
WarningText.TextSize = 16
WarningText.Position = UDim2.new(0.5, -150, 0, 0)
WarningText.Text = ""
WarningText.TextColor3 = Color3.new(1, 0, 0)
WarningText.BackgroundTransparency = 1
WarningText.Visible = false

-- Utility Functions
local function savedPart(player, part)
    if not hitbox_original_properties[player] then
        hitbox_original_properties[player] = {}
    end
    if not hitbox_original_properties[player][part.Name] then
        hitbox_original_properties[player][part.Name] = {
            CanCollide = part.CanCollide,
            Transparency = part.Transparency,
            Size = part.Size
        }
    end
end

local function restoredPart(player)
    if hitbox_original_properties[player] then
        for partName, properties in pairs(hitbox_original_properties[player]) do
            local part = player.Character and player.Character:FindFirstChild(partName)
            if part and part:IsA("BasePart") then
                part.CanCollide = properties.CanCollide
                part.Transparency = properties.Transparency
                part.Size = properties.Size
            end
        end
    end
end

local function findClosestPart(player, partName)
    if not player.Character then return nil end
    local characterParts = player.Character:GetChildren()
    for _, part in ipairs(characterParts) do
        if part:IsA("BasePart") and part.Name:lower():match(partName:lower()) then
            return part
        end
    end
    return nil
end

local function extendHitbox(player)
    for _, partName in ipairs(defaultBodyParts) do
        local part = player.Character and (player.Character:FindFirstChild(partName) or findClosestPart(player, partName))
        if part and part:IsA("BasePart") then
            savedPart(player, part)
            part.CanCollide = not noCollisionEnabled
            part.Transparency = hitboxTransparency / 10
            part.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
        end
    end
end

local function isEnemy(player)
    if teamCheck == "FFA" or teamCheck == "Everyone" then
        return true
    end
    local localPlayerTeam = LocalPlayer.Team
    return player.Team ~= localPlayerTeam
end

local function shouldExtendHitbox(player)
    return isEnemy(player)
end

local function updateHitboxes()
    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            if shouldExtendHitbox(v) then
                extendHitbox(v)
            else
                restoredPart(v)
            end
        end
    end
end

local function onCharacterAdded(character)
    task.wait(0.1)
    if hitboxEnabled then
        updateHitboxes()
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(onCharacterAdded)
    player.CharacterRemoving:Connect(function()
        restoredPart(player)
        hitbox_original_properties[player] = nil
    end)
end

local function checkForDeadPlayers()
    for player, properties in pairs(hitbox_original_properties) do
        if not player.Parent or not player.Character or not player.Character:IsDescendantOf(game) then
            restoredPart(player)
            hitbox_original_properties[player] = nil
        end
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)

for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

HitboxSection:NewButton("[CLICK THIS FIRST] Enable Hitbox", 'Initialize hitbox system', function()
    coroutine.wrap(function()
        while true do
            if hitboxEnabled then
                updateHitboxes()
                checkForDeadPlayers()
            end
            task.wait(0.1)
        end
    end)()
end)

HitboxSection:NewToggle("Enable Hitbox", 'Enable/disable hitbox expansion', function(enabled)
    hitboxEnabled = enabled
    if not enabled then
        for _, player in ipairs(Players:GetPlayers()) do
            restoredPart(player)
        end
        hitbox_original_properties = {}
    else
        updateHitboxes()
    end
end)

HitboxSection:NewSlider("Hitbox Size", 'Adjust hitbox size', 25, 1, function(value)
    hitboxSize = value
    if hitboxEnabled then
        updateHitboxes()
    end
end)

HitboxSection:NewSlider("Hitbox Transparency", 'Adjust hitbox visibility', 10, 1, function(value)
    hitboxTransparency = value
    if hitboxEnabled then
        updateHitboxes()
    end
end)

HitboxSection:NewDropdown("Team Check", 'Team check mode', {"FFA", "Team-Based", "Everyone"}, function(value)
    teamCheck = value
    if hitboxEnabled then
        updateHitboxes()
    end
end)

HitboxSection:NewToggle("No Collision", 'Disable hitbox collision', function(enabled)
    noCollisionEnabled = enabled
    WarningText.Visible = enabled
    coroutine.wrap(function()
        while noCollisionEnabled do
            if hitboxEnabled then
                updateHitboxes()
            end
            task.wait(0.01)
        end
        if hitboxEnabled then
            updateHitboxes()
        end
    end)()
end)

-- ═══════════════════════════════════════════════════════════════════════
-- AUTOFARM SECTION
-- ═══════════════════════════════════════════════════════════════════════

MainSection:NewToggle("AutoFarm [Could get you banned]", "Automated farming system", function(bool)
    getgenv().AutoFarm = bool

    local runServiceConnection
    local mouseDown = false
    local player = LocalPlayer
    local camera = Workspace.CurrentCamera

    if ReplicatedStorage:FindFirstChild("wkspc") and ReplicatedStorage.wkspc:FindFirstChild("CurrentCurse") then
        ReplicatedStorage.wkspc.CurrentCurse.Value = bool and "Infinite Ammo" or ""
    end

    function closestplayer()
        local closestDistance = math.huge
        local closestPlayer = nil

        for _, enemyPlayer in pairs(Players:GetPlayers()) do
            if enemyPlayer ~= player and enemyPlayer.TeamColor ~= player.TeamColor and enemyPlayer.Character then
                local character = enemyPlayer.Character
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoidRootPart and humanoid and humanoid.Health > 0 then
                    local distance = (player.Character.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = enemyPlayer
                    end
                end
            end
        end

        return closestPlayer
    end

    local function AutoFarm()
        if ReplicatedStorage:FindFirstChild("wkspc") and ReplicatedStorage.wkspc:FindFirstChild("TimeScale") then
            ReplicatedStorage.wkspc.TimeScale.Value = 12
        end

        runServiceConnection = RunService.Stepped:Connect(function()
            if getgenv().AutoFarm then
                local closestPlayer = closestplayer()
                if closestPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local enemyRootPart = closestPlayer.Character.HumanoidRootPart

                    local targetPosition = enemyRootPart.Position - enemyRootPart.CFrame.LookVector * 2 + Vector3.new(0, 2, 0)
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)

                    if closestPlayer.Character:FindFirstChild("Head") then
                        local enemyHead = closestPlayer.Character.Head.Position
                        camera.CFrame = CFrame.new(camera.CFrame.Position, enemyHead)
                    end

                    if not mouseDown then
                        mouse1press()
                        mouseDown = true
                    end
                else
                    if mouseDown then
                        mouse1release()
                        mouseDown = false
                    end
                end
            else
                if runServiceConnection then
                    runServiceConnection:Disconnect()
                    runServiceConnection = nil
                end
                if mouseDown then
                    mouse1release()
                    mouseDown = false
                end
            end
        end)
    end

    local function onCharacterAdded(character)
        wait(0.5)
        AutoFarm()
    end

    player.CharacterAdded:Connect(onCharacterAdded)

    if bool then
        wait(0.5)
        AutoFarm()
    else
        if ReplicatedStorage:FindFirstChild("wkspc") then
            if ReplicatedStorage.wkspc:FindFirstChild("CurrentCurse") then
                ReplicatedStorage.wkspc.CurrentCurse.Value = ""
            end
            if ReplicatedStorage.wkspc:FindFirstChild("TimeScale") then
                ReplicatedStorage.wkspc.TimeScale.Value = 1
            end
        end
        getgenv().AutoFarm = false
        if runServiceConnection then
            runServiceConnection:Disconnect()
            runServiceConnection = nil
        end
        if mouseDown then
            mouse1release()
            mouseDown = false
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════
-- TRIGGERBOT SECTION
-- ═══════════════════════════════════════════════════════════════════════

local triggerbot = Welcome:NewSection("> Triggerbot <")

getgenv().triggerb = false
local teamcheck = "Team-Based"
local delay = 0.2
local isAlive = true

triggerbot:NewToggle("Enable Triggerbot", "Automatically shoot at enemies", function(state)
    getgenv().triggerb = state
end)

triggerbot:NewDropdown("Team Check Mode", "Team checking mode", {"FFA", "Team-Based", "Everyone"}, function(selected)
    teamcheck = selected
end)

triggerbot:NewSlider("Shot Delay", "Delay between shots (0.1-1.0)", 10, 1, function(value)
    delay = value / 10
end)

local function isEnemyTrigger(targetPlayer)
    if teamcheck == "FFA" then
        return true
    elseif teamcheck == "Everyone" then
        return targetPlayer ~= LocalPlayer
    elseif teamcheck == "Team-Based" then
        local localPlayerTeam = LocalPlayer.Team
        return targetPlayer.Team ~= localPlayerTeam
    end
    return false
end

local function checkhealth()
    local player = LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid.HealthChanged:Connect(function(health)
            isAlive = health > 0
        end)
    end
end

LocalPlayer.CharacterAdded:Connect(checkhealth)
checkhealth()

RunService.RenderStepped:Connect(function()
    if getgenv().triggerb and isAlive then
        local player = LocalPlayer
        local mouse = player:GetMouse()
        local target = mouse.Target
        if target and target.Parent:FindFirstChild("Humanoid") and target.Parent.Name ~= player.Name then
            local targetPlayer = Players:FindFirstChild(target.Parent.Name)
            if targetPlayer and isEnemyTrigger(targetPlayer) then
                mouse1press()
                wait(delay)
                mouse1release()
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════
-- GUN MODS TAB
-- ═══════════════════════════════════════════════════════════════════════

local Gun = Window:NewTab("Gun Modded")
local GunmodsSection = Gun:NewSection("> Overpower Gun <")

GunmodsSection:NewToggle("Infinite Ammo v1", "Infinite ammo method 1", function(v)
    if ReplicatedStorage:FindFirstChild("wkspc") and ReplicatedStorage.wkspc:FindFirstChild("CurrentCurse") then
        ReplicatedStorage.wkspc.CurrentCurse.Value = v and "Infinite Ammo" or ""
    end
end)

local SettingsInfinite = false
GunmodsSection:NewToggle("Infinite Ammo v2", "Infinite ammo method 2", function(K)
    SettingsInfinite = K
    if SettingsInfinite then
        RunService.Stepped:connect(function()
            pcall(function()
                if SettingsInfinite then
                    local playerGui = LocalPlayer.PlayerGui
                    if playerGui:FindFirstChild("GUI") and playerGui.GUI:FindFirstChild("Client") then
                        if playerGui.GUI.Client:FindFirstChild("Variables") then
                            if playerGui.GUI.Client.Variables:FindFirstChild("ammocount") then
                                playerGui.GUI.Client.Variables.ammocount.Value = 99
                            end
                            if playerGui.GUI.Client.Variables:FindFirstChild("ammocount2") then
                                playerGui.GUI.Client.Variables.ammocount2.Value = 99
                            end
                        end
                    end
                end
            end)
        end)
    end
end)

local originalValues = {
    FireRate = {},
    ReloadTime = {},
    EReloadTime = {},
    Auto = {},
    Spread = {},
    Recoil = {}
}

GunmodsSection:NewToggle("Fast Reload", "Faster reload time", function(x)
    for _, v in pairs(ReplicatedStorage.Weapons:GetChildren()) do
        if v:FindFirstChild("ReloadTime") then
            if x then
                if not originalValues.ReloadTime[v] then
                    originalValues.ReloadTime[v] = v.ReloadTime.Value
                end
                v.ReloadTime.Value = 0.01
            else
                if originalValues.ReloadTime[v] then
                    v.ReloadTime.Value = originalValues.ReloadTime[v]
                else
                    v.ReloadTime.Value = 0.8
                end
            end
        end
        if v:FindFirstChild("EReloadTime") then
            if x then
                if not originalValues.EReloadTime[v] then
                    originalValues.EReloadTime[v] = v.EReloadTime.Value
                end
                v.EReloadTime.Value = 0.01
            else
                if originalValues.EReloadTime[v] then
                    v.EReloadTime.Value = originalValues.EReloadTime[v]
                else
                    v.EReloadTime.Value = 0.8
                end
            end
        end
    end
end)

GunmodsSection:NewToggle("Fast Fire Rate", "Increase fire rate", function(state)
    for _, v in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
        if v.Name == "FireRate" or v.Name == "BFireRate" then
            if state then
                if not originalValues.FireRate[v] then
                    originalValues.FireRate[v] = v.Value
                end
                v.Value = 0.02
            else
                if originalValues.FireRate[v] then
                    v.Value = originalValues.FireRate[v]
                else
                    v.Value = 0.8
                end
            end
        end
    end
end)

GunmodsSection:NewToggle("Always Auto", "Make all guns automatic", function(state)
    for _, v in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
        if v.Name == "Auto" or v.Name == "AutoFire" or v.Name == "Automatic" or v.Name == "AutoShoot" or v.Name == "AutoGun" then
            if state then
                if not originalValues.Auto[v] then
                    originalValues.Auto[v] = v.Value
                end
                v.Value = true
            else
                if originalValues.Auto[v] then
                    v.Value = originalValues.Auto[v]
                else
                    v.Value = false
                end
            end
        end
    end
end)

GunmodsSection:NewToggle("No Spread", "Remove weapon spread", function(state)
    for _, v in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
        if v.Name == "MaxSpread" or v.Name == "Spread" or v.Name == "SpreadControl" then
            if state then
                if not originalValues.Spread[v] then
                    originalValues.Spread[v] = v.Value
                end
                v.Value = 0
            else
                if originalValues.Spread[v] then
                    v.Value = originalValues.Spread[v]
                else
                    v.Value = 1
                end
            end
        end
    end
end)

GunmodsSection:NewToggle("No Recoil", "Remove weapon recoil", function(state)
    for _, v in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
        if v.Name == "RecoilControl" or v.Name == "Recoil" then
            if state then
                if not originalValues.Recoil[v] then
                    originalValues.Recoil[v] = v.Value
                end
                v.Value = 0
            else
                if originalValues.Recoil[v] then
                    v.Value = originalValues.Recoil[v]
                else
                    v.Value = 1
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════
-- PLAYER TAB
-- ═══════════════════════════════════════════════════════════════════════

local Player = Window:NewTab("Player")
local PlayerSection = Player:NewSection("> Fly Hacks <")

PlayerSection:NewToggle("Fly", "Allows the player to fly", function(state)
    if state then
        startFly()
    else
        endFly()
    end
end)

PlayerSection:NewSlider("Fly Speed", "Adjust fly speed", 500, 1, function(s)
    flySettings.flyspeed = s
end)

-- Speed Section
PlayerSection:NewLabel("> Speed Power <")

local settings = {WalkSpeed = 16}
local isWalkSpeedEnabled = false

PlayerSection:NewToggle("Custom WalkSpeed", "Enable custom walkspeed", function(enabled)
    isWalkSpeedEnabled = enabled
end)

local walkMethods = {"Velocity", "Vector", "CFrame"}
local selectedWalkMethod = walkMethods[1]

PlayerSection:NewDropdown("Walk Method", "Choose walk method", walkMethods, function(selected)
    selectedWalkMethod = selected
end)

PlayerSection:NewSlider("Walkspeed Power", "Adjust walkspeed", 500, 16, function(value)
    settings.WalkSpeed = value
end)

local function wsm(player, deltaTime)
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")

    if humanoid and rootPart then
        local VS = humanoid.MoveDirection * settings.WalkSpeed
        if selectedWalkMethod == "Velocity" then
            rootPart.Velocity = Vector3.new(VS.X, rootPart.Velocity.Y, VS.Z)
        elseif selectedWalkMethod == "Vector" then
            local scaleFactor = 0.0001
            rootPart.CFrame = rootPart.CFrame + (VS * deltaTime * scaleFactor)
        elseif selectedWalkMethod == "CFrame" then
            local scaleFactor = 0.0001
            rootPart.CFrame = rootPart.CFrame + (humanoid.MoveDirection * settings.WalkSpeed * deltaTime * scaleFactor)
        else
            humanoid.WalkSpeed = settings.WalkSpeed
        end
    end
end

RunService.Stepped:Connect(function(deltaTime)
    if isWalkSpeedEnabled then
        local player = LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            wsm(player, deltaTime)
        end
    end
end)

-- Jump Section
PlayerSection:NewLabel("> JumpPower <")

local IJ = false
PlayerSection:NewToggle("Infinite Jump", "Enable infinite jump", function(state)
    IJ = state
end)

UserInputService.JumpRequest:Connect(function()
    if IJ then
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass('Humanoid')
            if humanoid then
                humanoid:ChangeState("Jumping")
            end
        end
    end
end)

local isJumpPowerEnabled = false

PlayerSection:NewToggle("Custom JumpPower", "Enable custom jumppower", function(enabled)
    isJumpPowerEnabled = enabled
end)

local jumpMethods = {"Velocity", "Vector", "CFrame"}
local selectedJumpMethod = jumpMethods[1]

PlayerSection:NewDropdown("Jump Method", "Choose jump method", jumpMethods, function(selected)
    selectedJumpMethod = selected
end)

PlayerSection:NewSlider("Change JumpPower", "Adjust jumppower", 500, 30, function(value)
    local player = LocalPlayer
    local character = player.Character
    if character then
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.UseJumpPower = true
        humanoid.Jumping:Connect(function(isActive)
            if isJumpPowerEnabled and isActive then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    if selectedJumpMethod == "Velocity" then
                        rootPart.Velocity = rootPart.Velocity * Vector3.new(1, 0, 1) + Vector3.new(0, value, 0)
                    elseif selectedJumpMethod == "Vector" then
                        rootPart.Velocity = Vector3.new(0, value, 0)
                    elseif selectedJumpMethod == "CFrame" then
                        character:SetPrimaryPartCFrame(character:GetPrimaryPartCFrame() + Vector3.new(0, value, 0))
                    end
                end
            end
        end)
    end
end)

-- Anti-Aim Section
PlayerSection:NewLabel("> Anti Aim <")

local spinSpeed = 10
local gyro

PlayerSection:NewToggle("Anti-Aim v1", "Enable anti-aim", function(value)
    local character = LocalPlayer.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    if value then
        if humanoidRootPart then
            local spin = Instance.new("BodyAngularVelocity")
            spin.Name = "AntiAimSpin"
            spin.AngularVelocity = Vector3.new(0, spinSpeed, 0)
            spin.MaxTorque = Vector3.new(0, math.huge, 0)
            spin.P = 500000
            spin.Parent = humanoidRootPart

            gyro = Instance.new("BodyGyro")
            gyro.Name = "AntiAimGyro"
            gyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            gyro.CFrame = humanoidRootPart.CFrame
            gyro.P = 3000
            gyro.Parent = humanoidRootPart
        end
    else
        if humanoidRootPart then
            local spin = humanoidRootPart:FindFirstChild("AntiAimSpin")
            if spin then
                spin:Destroy()
            end

            if gyro then
                gyro:Destroy()
                gyro = nil
            end
        end
    end
end)

PlayerSection:NewSlider("Spin Speed", "Adjust spin speed", 100, 10, function(value)
    spinSpeed = value

    local character = LocalPlayer.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        local spin = humanoidRootPart:FindFirstChild("AntiAimSpin")
        if spin then
            spin.AngularVelocity = Vector3.new(0, spinSpeed, 0)
        end
    end
end)

-- Object Teleport Section
PlayerSection:NewLabel("> Object Teleport <")

local debris_selected = "Both"
local debris_options = {"DeadHP", "DeadAmmo", "Both"}
local isCollecting = false

PlayerSection:NewToggle("Enable Collect debris", "Teleport items to you", function(enabled)
    isCollecting = enabled
    if enabled then
        managePickups()
    end
end)

PlayerSection:NewDropdown("Select Object", "Choose item type", debris_options, function(selection)
    debris_selected = selection
end)

function managePickups()
    spawn(function()
        while isCollecting do
            wait(0.1)
            pcall(function()
                local player = LocalPlayer
                local character = player.Character
                if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        local debris = Workspace:FindFirstChild("Debris")
                        if debris then
                            for _, v in pairs(debris:GetChildren()) do
                                if (debris_selected == "DeadHP" and v.Name == "DeadHP") or
                                   (debris_selected == "DeadAmmo" and v.Name == "DeadAmmo") or
                                   (debris_selected == "Both" and (v.Name == "DeadHP" or v.Name == "DeadAmmo")) then
                                    v.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 0.2, 0)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
end

-- Misc Section
PlayerSection:NewLabel("> Useful Cheat <")

PlayerSection:NewTextBox('TimeScale', 'Change game timescale', function(TimeScaleFR)
    if ReplicatedStorage:FindFirstChild("wkspc") and ReplicatedStorage.wkspc:FindFirstChild("TimeScale") then
        ReplicatedStorage.wkspc.TimeScale.Value = tonumber(TimeScaleFR) or 1
    end
end)

PlayerSection:NewLabel("> Misc <")

PlayerSection:NewSlider("FOV Arsenal", "Adjust field of view", 120, 0, function(num)
    if LocalPlayer.Settings and LocalPlayer.Settings:FindFirstChild("FOV") then
        LocalPlayer.Settings.FOV.Value = num
    end
end)

local isNoClipEnabled = false

PlayerSection:NewToggle("Toggle NoClip", "Walk through walls", function(enabled)
    isNoClipEnabled = enabled
    local player = LocalPlayer

    local function toggleNoClip()
        while isNoClipEnabled do
            local character = player.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
            RunService.Stepped:Wait()
        end

        local character = player.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end

    if isNoClipEnabled then
        spawn(toggleNoClip)
    end
end)

LocalPlayer.CharacterAdded:Connect(function(character)
    if isNoClipEnabled then
        spawn(function()
            while isNoClipEnabled do
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
                RunService.Stepped:Wait()
            end

            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end)
    end
end)

local xrayOn = false
PlayerSection:NewToggle("Toggle Xray", "See through walls", function(enabled)
    xrayOn = enabled

    if xrayOn then
        for _, descendant in pairs(Workspace:GetDescendants()) do
            if descendant:IsA("BasePart") then
                if not descendant:FindFirstChild("OriginalTransparency") then
                    local originalTransparency = Instance.new("NumberValue")
                    originalTransparency.Name = "OriginalTransparency"
                    originalTransparency.Value = descendant.Transparency
                    originalTransparency.Parent = descendant
                end
                descendant.Transparency = 0.5
            end
        end
    else
        for _, descendant in pairs(Workspace:GetDescendants()) do
            if descendant:IsA("BasePart") then
                if descendant:FindFirstChild("OriginalTransparency") then
                    descendant.Transparency = descendant.OriginalTransparency.Value
                    descendant.OriginalTransparency:Destroy()
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════
-- SKINS TAB
-- ═══════════════════════════════════════════════════════════════════════

local Skins = Window:NewTab("Color Skins")
local Random = Skins:NewSection("> Arm Skins <")

local function ak(al)
    return Vector3.new(al.R, al.G, al.B)
end

local am = "Plastic"
Random:NewDropdown("Arm Material", "Select arm material", {"Plastic", "ForceField", "Wood", "Grass"}, function(an)
    am = an
end)

local ao = Color3.new(50, 50, 50)
Random:NewColorPicker('Arm Color', "Select arm color", Color3.fromRGB(50, 50, 50), function(ap)
    ao = ap
end)

local aq = false
Random:NewToggle("Arm Charms", "Apply arm skin", function(L)
    aq = L
    if aq then
        spawn(function()
            while true do
                wait(.01)
                if not aq then
                    break
                else
                    local cameraArms = Workspace.Camera:FindFirstChild("Arms")
                    if cameraArms then
                        for ar, O in pairs(cameraArms:GetDescendants()) do
                            if O.Name == 'Right Arm' or O.Name == 'Left Arm' then
                                if O:IsA("BasePart") then
                                    O.Material = Enum.Material[am]
                                    O.Color = ao
                                end
                            elseif O:IsA("SpecialMesh") then
                                if O.TextureId == '' then
                                    O.TextureId = 'rbxassetid://0'
                                    O.VertexColor = ak(ao)
                                end
                            elseif O.Name == 'L' or O.Name == 'R' then
                                O:Destroy()
                            end
                        end
                    end
                end
            end
        end)
    end
end)

Random:NewLabel("> Gun Skin <")

local at = "Plastic"
Random:NewDropdown("Gun Material", "Select gun material", {"Plastic", "ForceField", "Wood", "Grass"}, function(an)
    at = an
end)

local au = Color3.new(50, 50, 50)
Random:NewColorPicker('Gun Color', "Select gun color", Color3.fromRGB(50, 50, 50), function(ap)
    au = ap
end)

local av = false
Random:NewToggle("Gun Charms", "Apply gun skin", function(L)
    av = L
    if av then
        spawn(function()
            while true do
                wait(.01)
                if not av then
                    break
                else
                    if not Workspace.Camera:FindFirstChild("Arms") then
                        wait()
                    else
                        for ar, O in pairs(Workspace.Camera.Arms:GetDescendants()) do
                            if O:IsA("MeshPart") then
                                O.Material = Enum.Material[at]
                                O.Color = au
                            end
                        end
                    end
                end
            end
        end)
    end
end)

Random:NewLabel("> Rainbow Gun <")

local rainbowEnabled = false
local c = 1

function zigzag(X)
    return math.acos(math.cos(X * math.pi)) / math.pi
end

Random:NewToggle("Rainbow Gun v1", "Rainbow gun effect v1", function(state)
    rainbowEnabled = state
end)

RunService.RenderStepped:Connect(function()
    if Workspace.Camera:FindFirstChild('Arms') and rainbowEnabled then
        for i, v in pairs(Workspace.Camera.Arms:GetDescendants()) do
            if v.ClassName == 'MeshPart' then
                v.Color = Color3.fromHSV(zigzag(c), 1, 1)
                c = c + .0001
            end
        end
    end
end)

local rainbowEnabled2 = false
local c2 = 0
local hueIncrement = 0.1

function updateColors()
    for i, v in pairs(Workspace.Camera.Arms:GetDescendants()) do
        if v.ClassName == 'MeshPart' then
            v.Color = Color3.fromHSV(c2, 1, 1)
        end
    end
end

Random:NewToggle("Rainbow Gun v2 [Fast Animation]", "Rainbow gun effect v2", function(state)
    rainbowEnabled2 = state
end)

RunService.RenderStepped:Connect(function()
    if Workspace.Camera:FindFirstChild('Arms') and rainbowEnabled2 then
        c2 = c2 + hueIncrement
        if c2 >= 1 then
            c2 = c2 % 1
        end
        updateColors()
    end
end)

-- ═══════════════════════════════════════════════════════════════════════
-- EXTRA TAB
-- ═══════════════════════════════════════════════════════════════════════

local Extra = Window:NewTab("Extra")
local ExtraSection = Extra:NewSection("Random")

local function enableParticles()
    for i, v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("Particle Area") then
                v.Parent = character["Particle Area"]
            end
        end
    end
end

local function disableParticles()
    for i, v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") then
            v.Parent = Workspace
        end
    end
end

ExtraSection:NewToggle("Mess up your screen lol", "Particle effects", function(state)
    if state then
        enableParticles()
    else
        disableParticles()
    end
end)

local original_stats = {Score = nil, Kills = nil}
ExtraSection:NewToggle("Max Level???", "Fake level/stats", function(bool)
    local stats = LocalPlayer.CareerStatsCache
    if stats then
        if bool then
            if not original_stats.Score then
                original_stats.Score = stats.Score.Value
            end
            if not original_stats.Kills then
                original_stats.Kills = stats.Kills.Value
            end
            stats.Score.Value = 1e18
            stats.Kills.Value = 1e14
        else
            if original_stats.Score and original_stats.Kills then
                stats.Score.Value = original_stats.Score
                stats.Kills.Value = original_stats.Kills
            end
        end
    end
end)

local original_names = {
    GUIName = nil,
    GUIName2 = nil,
    KillFeed = {},
    WinnerName = nil,
    ScorecardName = nil
}

local hidename = false
local runLoop = false

local function names()
    local edited_name = "AdvanceChan UwU"
    local edited_killfeed = "UwU im a horny femboy who needs a big BBC"

    local gui = LocalPlayer.PlayerGui
    if gui:FindFirstChild("GUI_Scorecard") then
        gui.GUI_Scorecard.Scorecard.Scrolling.Visible = false
    end
    if gui:FindFirstChild("Menew_Main") then
        gui.Menew_Main.Container.PlrName.Text = edited_name
        gui.Menew_Main.Container.PlrName2.Text = edited_name
    end
    
    local killFeed = Workspace:FindFirstChild("KillFeed")
    if killFeed then
        for i = 1, 6 do
            local feedItem = killFeed:FindFirstChild(tostring(i))
            if feedItem and feedItem:FindFirstChild("Killer") then
                feedItem.Killer.Value = edited_killfeed
            end
        end
    end
    
    if gui:FindFirstChild("GUI") and gui.GUI:FindFirstChild("Winner") then
        gui.GUI.Winner.Visible = false
    end
    if gui:FindFirstChild("GUI_Scorecard") then
        gui.GUI_Scorecard.Scorecard.PlayerCard.Username.Text = "AdvanceFalling Team"
    end
end

local function restores_name()
    local gui = LocalPlayer.PlayerGui

    if original_names.GUIName and gui:FindFirstChild("Menew_Main") then
        gui.Menew_Main.Container.PlrName.Text = original_names.GUIName
    end

    if original_names.GUIName2 and gui:FindFirstChild("Menew_Main") then
        gui.Menew_Main.Container.PlrName2.Text = original_names.GUIName2
    end

    local killFeed = Workspace:FindFirstChild("KillFeed")
    if killFeed then
        for i, v in pairs(original_names.KillFeed) do
            local feedItem = killFeed:FindFirstChild(tostring(i))
            if feedItem and feedItem:FindFirstChild("Killer") then
                feedItem.Killer.Value = v
            end
        end
    end

    if original_names.WinnerName ~= nil and gui:FindFirstChild("GUI") then
        gui.GUI.Winner.Visible = original_names.WinnerName
    end

    if original_names.ScorecardName and gui:FindFirstChild("GUI_Scorecard") then
        gui.GUI_Scorecard.Scorecard.PlayerCard.Username.Text = original_names.ScorecardName
    end
end

ExtraSection:NewToggle("change Name", "Change display name", function(enabled)
    hidename = enabled
    runLoop = enabled

    if hidename then
        local gui = LocalPlayer.PlayerGui
        if gui:FindFirstChild("Menew_Main") then
            original_names.GUIName = gui.Menew_Main.Container.PlrName.Text
            original_names.GUIName2 = gui.Menew_Main.Container.PlrName2.Text
        end
        if gui:FindFirstChild("GUI") and gui.GUI:FindFirstChild("Winner") then
            original_names.WinnerName = gui.GUI.Winner.Visible
        end
        if gui:FindFirstChild("GUI_Scorecard") then
            original_names.ScorecardName = gui.GUI_Scorecard.Scorecard.PlayerCard.Username.Text
        end

        local killFeed = Workspace:FindFirstChild("KillFeed")
        if killFeed then
            for i = 1, 6 do
                local feedItem = killFeed:FindFirstChild(tostring(i))
                if feedItem and feedItem:FindFirstChild("Killer") then
                    original_names.KillFeed[i] = feedItem.Killer.Value
                end
            end
        end

        spawn(function()
            while runLoop do
                pcall(names)
                wait(0.2)
            end
        end)
    else
        runLoop = false
        restores_name()
    end
end)

ExtraSection:NewLabel("Chat")

ExtraSection:NewToggle("IsChad", "Chat badge", function(x)
    if LocalPlayer:FindFirstChild('IsChad') then
        LocalPlayer.IsChad:Destroy()
        return
    end
    if x then
        local IsMod = Instance.new('IntValue', LocalPlayer)
        IsMod.Name = "IsChad"
    end
end)

ExtraSection:NewToggle("VIP", "Chat badge", function(x)
    if LocalPlayer:FindFirstChild('VIP') then
        LocalPlayer.VIP:Destroy()
        return
    end

    if x then
        local IsMod = Instance.new('IntValue', LocalPlayer)
        IsMod.Name = "VIP"
    end
end)

ExtraSection:NewToggle("OldVIP", "Chat badge", function(x)
    if LocalPlayer:FindFirstChild('OldVIP') then
        LocalPlayer.OldVIP:Destroy()
        return
    end
    if x then
        local IsMod = Instance.new('IntValue', LocalPlayer)
        IsMod.Name = "OldVIP"
    end
end)

ExtraSection:NewToggle("Romin", "Chat badge", function(x)
    if LocalPlayer:FindFirstChild('Romin') then
        LocalPlayer.Romin:Destroy()
        return
    end
    if x then
        local IsAdmin = Instance.new('IntValue', LocalPlayer)
        IsAdmin.Name = "Romin"
    end
end)

ExtraSection:NewToggle("IsAdmin", "Chat badge", function(x)
    if LocalPlayer:FindFirstChild('IsAdmin') then
        LocalPlayer.IsAdmin:Destroy()
        return
    end
    if x then
        local IsAdmin = Instance.new('IntValue', LocalPlayer)
        IsAdmin.Name = "IsAdmin"
    end
end)

-- ═══════════════════════════════════════════════════════════════════════
-- VISUALS TAB
-- ═══════════════════════════════════════════════════════════════════════

local Visual = Window:NewTab("Visuals")
local C = Visual:NewSection("> ESP V1 <")

local aj = loadstring(game:HttpGet("https://rawscript.vercel.app/api/raw/esp_1"))()

C:NewToggle("Enable Esp", "Enable ESP", function(K)
    aj:Toggle(K)
    aj.Players = K
end)

C:NewToggle("Tracers Esp", "Show tracers", function(K)
    aj.Tracers = K
end)

C:NewToggle("Name Esp", "Show names", function(K)
    aj.Names = K
end)

C:NewToggle("Boxes Esp", "Show boxes", function(K)
    aj.Boxes = K
end)

C:NewToggle("Team Coordinate", "Team color ESP", function(L)
    aj.TeamColor = L
end)

C:NewToggle("Teammates", "Show teammates", function(L)
    aj.TeamMates = L
end)

C:NewColorPicker("ESP Color", "ESP color", Color3.fromRGB(255, 255, 255), function(P)
    aj.Color = P
end)

local espSection = Visual:NewSection("> ESP Options <")
local esp_data = {}
local esp_title = 'dontask'

local function esps(parent, label)
    local BillboardGui = Instance.new('BillboardGui')
    local TextLabel = Instance.new('TextLabel')

    BillboardGui.Name = esp_title
    BillboardGui.Parent = parent
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Size = UDim2.new(0, 50, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)

    TextLabel.Parent = BillboardGui
    TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Text = label
    TextLabel.TextColor3 = Color3.new(1, 0, 0)
    TextLabel.TextScaled = false

    return BillboardGui
end

local function applyESP(object, label)
    if object:IsA('TouchTransmitter') then
        local parent = object.Parent
        if not parent:FindFirstChild(esp_title) then
            local newESP = esps(parent, label)
            esp_data[parent] = newESP
        end
    end
end

local function toggleESP(enable, name, label)
    if enable then
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA('TouchTransmitter') and v.Parent.Name == name then
                applyESP(v, label)
            end
        end

        Workspace.DescendantAdded:Connect(function(descendant)
            if descendant:IsA('TouchTransmitter') and descendant.Parent.Name == name then
                applyESP(descendant, label)
            end
        end)
    else
        for parent, espElement in pairs(esp_data) do
            if parent and espElement then
                espElement:Destroy()
                esp_data[parent] = nil
            end
        end
    end
end

espSection:NewToggle('Ammo Box ESP', 'Show ammo boxes', function(enabled)
    toggleESP(enabled, 'DeadAmmo', 'Ammo Box')
end)

espSection:NewToggle('HP Jug ESP', 'Show HP jars', function(enabled)
    toggleESP(enabled, 'DeadHP', 'HP Jar')
end)

-- ═══════════════════════════════════════════════════════════════════════
-- SETTINGS TAB
-- ═══════════════════════════════════════════════════════════════════════

local Setting = Window:NewTab("Setting")
local Section = Setting:NewSection("> Performance <")

local originalMaterials = {}
local originalDecalsTextures = {}
local originalLightingSettings = {
    GlobalShadows = game.Lighting.GlobalShadows,
    FogEnd = game.Lighting.FogEnd,
    Brightness = game.Lighting.Brightness
}
local originalTerrainSettings = {
    WaterWaveSize = Workspace.Terrain.WaterWaveSize,
    WaterWaveSpeed = Workspace.Terrain.WaterWaveSpeed,
    WaterReflectance = Workspace.Terrain.WaterReflectance,
    WaterTransparency = Workspace.Terrain.WaterTransparency
}
local originalEffects = {}

Section:NewToggle("Anti Lag", "Reduce lag", function(state)
    if state then
        for ai, O in pairs(Workspace:GetDescendants()) do
            if O:IsA("BasePart") and not O.Parent:FindFirstChild("Humanoid") then
                originalMaterials[O] = O.Material
                O.Material = Enum.Material.SmoothPlastic
                if O:IsA("Texture") then
                    table.insert(originalDecalsTextures, O)
                    O:Destroy()
                end
            end
        end
    else
        for O, material in pairs(originalMaterials) do
            if O and O:IsA("BasePart") then
                O.Material = material
            end
        end
        originalMaterials = {}
    end
end)

Section:NewToggle("FPS Boost", "Boost FPS", function(state)
    if state then
        local g = game
        local w = Workspace
        local l = g.Lighting
        local t = w.Terrain
        originalTerrainSettings.WaterWaveSize = t.WaterWaveSize
        originalTerrainSettings.WaterWaveSpeed = t.WaterWaveSpeed
        originalTerrainSettings.WaterReflectance = t.WaterReflectance
        originalTerrainSettings.WaterTransparency = t.WaterTransparency

        t.WaterWaveSize = 0
        t.WaterWaveSpeed = 0
        t.WaterReflectance = 0
        t.WaterTransparency = 0
        l.GlobalShadows = false
        l.FogEnd = 9e9
        l.Brightness = 0
        settings().Rendering.QualityLevel = "Level01"

        for i, v in pairs(g:GetDescendants()) do
            if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                originalMaterials[v] = v.Material
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                table.insert(originalDecalsTextures, v)
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                originalMaterials[v] = v.Material
                v.Material = "Plastic"
                v.Reflectance = 0
                v.TextureID = 10385902758728957
            end
        end

        for i, e in pairs(l:GetChildren()) do
            if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                originalEffects[e] = e.Enabled
                e.Enabled = false
            end
        end
    else
        local t = Workspace.Terrain
        t.WaterWaveSize = originalTerrainSettings.WaterWaveSize
        t.WaterWaveSpeed = originalTerrainSettings.WaterWaveSpeed
        t.WaterReflectance = originalTerrainSettings.WaterReflectance
        t.WaterTransparency = originalTerrainSettings.WaterTransparency

        game.Lighting.GlobalShadows = originalLightingSettings.GlobalShadows
        game.Lighting.FogEnd = originalLightingSettings.FogEnd
        game.Lighting.Brightness = originalLightingSettings.Brightness

        settings().Rendering.QualityLevel = "Automatic"

        for v, material in pairs(originalMaterials) do
            if v and v:IsA("BasePart") then
                v.Material = material
                v.Reflectance = 0
            end
        end
        originalMaterials = {}

        for e, enabled in pairs(originalEffects) do
            if e then
                e.Enabled = enabled
            end
        end
        originalEffects = {}

        for _, v in pairs(originalDecalsTextures) do
            if v and v.Parent then
                v.Transparency = 0
            end
        end
        originalDecalsTextures = {}
    end
end)

local fullBrightEnabled = false
Section:NewToggle("Full Bright", "Enable full bright", function(enabled)
    fullBrightEnabled = enabled

    local Light = game:GetService("Lighting")

    local function doFullBright()
        if fullBrightEnabled then
            Light.Ambient = Color3.new(1, 1, 1)
            Light.ColorShift_Bottom = Color3.new(1, 1, 1)
            Light.ColorShift_Top = Color3.new(1, 1, 1)
        else
            Light.Ambient = Color3.new(0.5, 0.5, 0.5)
            Light.ColorShift_Bottom = Color3.new(0, 0, 0)
            Light.ColorShift_Top = Color3.new(0, 0, 0)
        end
    end

    doFullBright()

    Light.LightingChanged:Connect(doFullBright)
end)

local Section = Setting:NewSection("> Server <")

Section:NewButton("Server Hop", "Join different server", function()
    local placeID = game.PlaceId
    local allIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local deleted = false
    local file = pcall(function()
        allIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
    end)

    if not file then
        table.insert(allIDs, actualHour)
        writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(allIDs))
    end

    function teleportReturner()
        local site
        if foundAnything == "" then
            site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' ..
                placeID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' ..
                placeID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end

        local serverID = ""

        if site.nextPageCursor and site.nextPageCursor ~= "null" and site.nextPageCursor ~= nil then
            foundAnything = site.nextPageCursor
        end

        local num = 0

        for i, v in pairs(site.data) do
            local possible = true
            serverID = tostring(v.id)

            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _, existing in pairs(allIDs) do
                    if num ~= 0 then
                        if serverID == tostring(existing) then
                            possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(existing) then
                            local delFile = pcall(function()
                                delfile("NotSameServers.json")
                                allIDs = {}
                                table.insert(allIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end

                if possible == true then
                    table.insert(allIDs, serverID)
                    wait()
                    pcall(function()
                        writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(allIDs))
                        wait()
                        TeleportService:TeleportToPlaceInstance(placeID, serverID, LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end

    function teleport()
        while wait() do
            pcall(function()
                teleportReturner()
                if foundAnything ~= "" then
                    teleportReturner()
                end
            end)
        end
    end

    teleport()
end)

Section:NewButton("Rejoin Server", "Rejoin current server", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

local keybindSection = Setting:NewSection("> Keybind <")
keybindSection:NewKeybind("Close UI", "Toggle UI", Enum.KeyCode.LeftControl, function()
    Library:ToggleUI()
end)

-- ═══════════════════════════════════════════════════════════════════════
-- CREDITS TAB
-- ═══════════════════════════════════════════════════════════════════════

local Credit = Window:NewTab("Credits")
local Section = Credit:NewSection("Credits")
local Section = Credit:NewSection("Script Developed by: AdvanceFalling Team")
local Section = Credit:NewSection("Guide & Assistance: AlexFearless")

Section:NewDropdown("Developer", "Select developer", {"YellowGreg", "WspBoy12", "MMSVon", "ShadowClark", "Frostbite", "AlexFearless"}, function(currentDeveloper)
    local creations = {
        YellowGreg = "Owner",
        WspBoy12 = "Head Developer",
        MMSVon = "Head Developer",
        ShadowClark = "Head Developer",
        Frostbite = "Head Developer",
        AlexFearless = "Guide & Contributor",
    }
    print(currentDeveloper .. " - " .. (creations[currentDeveloper] or "Team Member"))
end)

local Section = Credit:NewSection("UI Framework: Kavo.")
local Section = Credit:NewSection("Report Non-Functional Bugs on Discord")
Section:NewButton("Copy Discord Link", "Copy Discord invite", function()
    setclipboard("https://discord.com/invite/d2446gBjfq")
end)

-- ═══════════════════════════════════════════════════════════════════════
-- GUI TOGGLE BUTTON
-- ═══════════════════════════════════════════════════════════════════════

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
local frame = Instance.new("ImageLabel", gui)
local button = Instance.new("TextButton", frame)

frame.BackgroundTransparency = 1
frame.Position = UDim2.new(0, 0, 0.65, -100)
frame.Size = UDim2.new(0, 100, 0, 50)
frame.Image = "rbxassetid://3570695787"
frame.ImageColor3 = Color3.fromRGB(11, 18, 7)
frame.ImageTransparency = 0.2
frame.ScaleType = Enum.ScaleType.Slice
frame.SliceCenter = Rect.new(100, 100, 100, 100)
frame.SliceScale = 0.12

button.AnchorPoint = Vector2.new(0, 0.5)
button.BackgroundTransparency = 1
button.Position = UDim2.new(0.022, 0, 0.85, -20)
button.Size = UDim2.new(1, -10, 1, 0)
button.Font = Enum.Font.SourceSans
button.Text = "Toggle"
button.TextColor3 = Color3.fromRGB(0, 34, 255)
button.TextSize = 20
button.TextWrapped = true
button.ZIndex = 11

button.MouseButton1Down:Connect(function()
    Library:ToggleUI()
end)

local dragging, dragStart, startPos = false, nil, nil

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

button.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        update(input)
    end
end)

print("╔═══════════════════════════════════════════════════════════════════════════╗")
print("║           AdvanceTech Arsenal Script v2.0 Loaded Successfully!            ║")
print("║                      Guide: AlexFearless                                  ║")
print("╚═══════════════════════════════════════════════════════════════════════════╝")