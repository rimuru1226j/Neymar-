-- 🌟 neymarjr HUB - VERSIÓN COMPLETA (Con ESP de Bases)
-- Player: Salto Infinito + Anti Ragdoll (toggle)
-- Helper: Auto Steal + X-Ray + Anti-Bee + Auto Destroy Turrets + BEST BRAINROT ESP + ESP BASES (toggle)
-- Sonido +100M: DURACIÓN 1 SEGUNDO
-- Música ID: 140691414619561 | Inicio: segundo 3

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- ============================================
-- 🎵 MÚSICA DE INICIO
-- ============================================

local function playStartMusic()
    local music = Instance.new("Sound")
    music.SoundId = "rbxassetid://140691414619561"
    music.Volume = 0.8
    music.Looped = false
    music.Parent = SoundService
    music.TimePosition = 3
    music:Play()
    
    task.delay(6, function()
        if music and music.Parent then
            music:Stop()
            music:Destroy()
        end
    end)
end

if game:IsLoaded() then
    playStartMusic()
else
    game.Loaded:Wait()
    playStartMusic()
end

-- GUI PRINCIPAL
local gui = Instance.new("ScreenGui")
gui.Name = "neymarjr"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting
TweenService:Create(blur, TweenInfo.new(0.6), {Size = 18}):Play()

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 360)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
frame.BorderSizePixel = 0
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(170, 120, 255)
stroke.Transparency = 0.2
stroke.Parent = frame

frame.Size = UDim2.new(0,0,0,0)
TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0,320,0,360)}):Play()

-- TOP BAR
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1,0,0,45)
topBar.BackgroundColor3 = Color3.fromRGB(30,30,45)
topBar.Parent = frame
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0,16)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-60,1,0)
title.Position = UDim2.new(0,12,0,0)
title.BackgroundTransparency = 1
title.Text = "NEYMARJR HUB"
title.TextColor3 = Color3.fromRGB(240,240,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

-- CLOSE
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,35,0,30)
closeBtn.Position = UDim2.new(1,-45,0,7)
closeBtn.BackgroundColor3 = Color3.fromRGB(255,90,90)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.Parent = topBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,8)

-- MINI BUTTON
local mini = Instance.new("ImageButton")
mini.Size = UDim2.new(0,60,0,60)
mini.Position = UDim2.new(0.02,0,0.5,0)
mini.BackgroundTransparency = 1
mini.Visible = false
mini.Parent = gui
mini.Image = "rbxassetid://18622390193"
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

-- OPTIONS
local optionsFrame = Instance.new("Frame")
optionsFrame.Size = UDim2.new(1, -20, 0, 200)
optionsFrame.Position = UDim2.new(0,10,0,60)
optionsFrame.BackgroundTransparency = 1
optionsFrame.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,8)
layout.Parent = optionsFrame

local function createButton(name)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1,0,0,35)
	btn.BackgroundColor3 = Color3.fromRGB(35,35,55)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	btn.Parent = optionsFrame
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)
	return btn
end

local stealerBtn = createButton("Stealer")
local helperBtn = createButton("Helper")
local playerBtn = createButton("Player")
local discordBtn = createButton("Discord")

-- ============================================
-- 🦘 SALTO INFINITO PARA MÓVIL
-- ============================================

local infiniteJumpEnabled = false
local JumpData = {lastJumpTime = 0}
local infiniteJumpConnection = nil
local jumpRequestConnection = nil

local function setInfiniteJump(enabled)
    infiniteJumpEnabled = enabled
    
    if infiniteJumpConnection then
        infiniteJumpConnection:Disconnect()
        infiniteJumpConnection = nil
    end
    
    if jumpRequestConnection then
        jumpRequestConnection:Disconnect()
        jumpRequestConnection = nil
    end
    
    if not enabled then 
        print("🔴 Salto Infinito DESACTIVADO")
        return 
    end
    
    print("🟢 Salto Infinito ACTIVADO (fuerza: 55)")

    jumpRequestConnection = UserInputService.JumpRequest:Connect(function()
        if not infiniteJumpEnabled then return end
        local now = tick()
        if now - JumpData.lastJumpTime < 0.15 then return end
        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end
        JumpData.lastJumpTime = now
        hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, 55, hrp.AssemblyLinearVelocity.Z)
    end)
    
    infiniteJumpConnection = RunService.Heartbeat:Connect(function()
        if not infiniteJumpEnabled then return end
    end)
end

-- ============================================
-- 🐸 ANTI RAGDOLL V1
-- ============================================

local anti = {}
local antiMode = nil
local ragConns = {}
local charCache = {}

local function cacheChar()
    local c = player.Character
    if not c then return false end
    local h = c:FindFirstChildOfClass("Humanoid")
    local r = c:FindFirstChild("HumanoidRootPart")
    if not h or not r then return false end
    charCache = {
        char = c,
        hum = h,
        root = r
    }
    return true
end

local function killConns()
    for _, c in pairs(ragConns) do
        pcall(function() c:Disconnect() end)
    end
    ragConns = {}
end

local function isRagdoll()
    if not charCache.hum then return false end
    local s = charCache.hum:GetState()
    if s == Enum.HumanoidStateType.Physics or s == Enum.HumanoidStateType.Ragdoll or s == Enum.HumanoidStateType.FallingDown then
        return true
    end
    local et = player:GetAttribute("RagdollEndTime")
    if et then
        local n = workspace:GetServerTimeNow()
        if (et - n) > 0 then
            return true
        end
    end
    return false
end

local function removeCons()
    if not charCache.char then return end
    for _, d in pairs(charCache.char:GetDescendants()) do
        if d:IsA("BallSocketConstraint") or (d:IsA("Attachment") and string.find(d.Name, "RagdollAttachment")) then
            pcall(function() d:Destroy() end)
        end
    end
end

local function forceExit()
    if not charCache.hum or not charCache.root then return end
    pcall(function()
        player:SetAttribute("RagdollEndTime", workspace:GetServerTimeNow())
    end)
    if charCache.hum.Health > 0 then
        charCache.hum:ChangeState(Enum.HumanoidStateType.Running)
    end
    charCache.root.Anchored = false
    charCache.root.AssemblyLinearVelocity = Vector3.zero
end

local function antiLoop()
    while antiMode == "v1" and charCache.hum do
        task.wait()
        if isRagdoll() then
            removeCons()
            forceExit()
        end
    end
end

local function setupCam()
    if not charCache.hum then return end
    table.insert(ragConns, RunService.RenderStepped:Connect(function()
        if antiMode ~= "v1" then return end
        local c = workspace.CurrentCamera
        if c and charCache.hum and c.CameraSubject ~= charCache.hum then
            c.CameraSubject = charCache.hum
        end
    end))
end

local function onChar(c)
    task.wait(0.5)
    if not antiMode then return end
    if cacheChar() then
        if antiMode == "v1" then
            setupCam()
            task.spawn(antiLoop)
        end
    end
end

function anti.Enable(m)
    if m ~= "v1" then return end
    if antiMode == m then return end
    anti.Disable()
    if not cacheChar() then return end
    antiMode = m
    table.insert(ragConns, player.CharacterAdded:Connect(onChar))
    setupCam()
    task.spawn(antiLoop)
    print("🐸 Anti Ragdoll V1 ACTIVADO")
end

function anti.Disable()
    if not antiMode then return end
    antiMode = nil
    killConns()
    charCache = {}
    print("🐸 Anti Ragdoll V1 DESACTIVADO")
end

-- ============================================
-- 🎮 BOTÓN PLAYER (ACTIVA Salto + Anti Ragdoll)
-- ============================================

local playerModeEnabled = false

playerBtn.MouseButton1Click:Connect(function()
    if not playerModeEnabled then
        setInfiniteJump(true)
        anti.Enable("v1")
        playerModeEnabled = true
        playerBtn.Text = "✅ Player"
        playerBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        print("✅ Player Mode ACTIVADO (Salto Infinito + Anti Ragdoll V1)")
    else
        setInfiniteJump(false)
        anti.Disable()
        playerModeEnabled = false
        playerBtn.Text = "Player"
        playerBtn.BackgroundColor3 = Color3.fromRGB(35,35,55)
        print("❌ Player Mode DESACTIVADO")
    end
end)

-- ============================================
-- 🔘 BOTÓN STEALER (DECORATIVO - SIN FUNCIÓN)
-- ============================================

stealerBtn.MouseButton1Click:Connect(function()
    print("🔘 Stealer presionado (sin función - solo decorativo)")
end)

-- ============================================
-- 📦 AUTO STEAL MINI (PANEL COMPLETO) - Controlado por Helper
-- ============================================

local ThemeMini = {
    BG = Color3.fromRGB(8, 8, 12),
    Surface = Color3.fromRGB(18, 18, 24),
    Accent = Color3.fromRGB(0, 200, 255),
    Text = Color3.fromRGB(230, 230, 245),
    TextSec = Color3.fromRGB(130, 130, 150),
    Success = Color3.fromRGB(0, 200, 100),
    Error = Color3.fromRGB(255, 60, 80),
}

local FileName = "AutoStealPosition.json"
local savedPos = {X = 0.02, Y = 0.4}

if isfile and isfile(FileName) then
    pcall(function()
        local data = HttpService:JSONDecode(readfile(FileName))
        if data then
            savedPos.X = data.X or 0.02
            savedPos.Y = data.Y or 0.4
        end
    end)
end

local function savePosition(x, y)
    savedPos.X = x
    savedPos.Y = y
    if writefile then
        pcall(function()
            writefile(FileName, HttpService:JSONEncode({X = x, Y = y}))
        end)
    end
end

-- Auto Steal Core
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Datas = ReplicatedStorage:WaitForChild("Datas")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Utils = ReplicatedStorage:WaitForChild("Utils")

local Synchronizer = require(Packages:WaitForChild("Synchronizer"))
local AnimalsData = require(Datas:WaitForChild("Animals"))
local AnimalsShared = require(Shared:WaitForChild("Animals"))
local NumberUtils = require(Utils:WaitForChild("NumberUtils"))

local autoStealEnabled = true
local allAnimalsCache = {}
local PromptMemoryCache = {}
local InternalCache = {}

local function isMyBaseAnimal(animalData)
    if not animalData or not animalData.plot then return false end
    local plots = Workspace:FindFirstChild("Plots")
    if not plots then return false end
    local plot = plots:FindFirstChild(animalData.plot)
    if not plot then return false end
    local channel = Synchronizer:Get(plot.Name)
    if channel then
        local owner = channel:Get("Owner")
        if owner then
            if typeof(owner) == "Instance" and owner:IsA("Player") then return owner.UserId == player.UserId
            elseif typeof(owner) == "table" and owner.UserId then return owner.UserId == player.UserId end
        end
    end
    return false
end

local function findProximityPrompt(animalData)
    if not animalData then return nil end
    local cp = PromptMemoryCache[animalData.uid]
    if cp and cp.Parent then return cp end
    local plot = Workspace.Plots:FindFirstChild(animalData.plot)
    if not plot then return nil end
    local podiums = plot:FindFirstChild("AnimalPodiums")
    if not podiums then return nil end
    
    local podium = podiums:FindFirstChild(animalData.slot)
    if podium then
        local base = podium:FindFirstChild("Base")
        local spawn = base and base:FindFirstChild("Spawn")
        if spawn then
            local attach = spawn:FindFirstChild("PromptAttachment")
            if attach then
                for _, p in ipairs(attach:GetChildren()) do
                    if p:IsA("ProximityPrompt") and p.Enabled and p.ActionText == "Steal" then
                        PromptMemoryCache[animalData.uid] = p
                        return p
                    end
                end
            end
        end
    end
    return nil
end

local function getTopPets()
    local out = {}
    for _, a in ipairs(allAnimalsCache) do
        if a.genValue >= 1 and not isMyBaseAnimal(a) then
            table.insert(out, {
                name = a.name,
                value = a.genValue,
                valueText = a.genText,
                mutation = a.mutation,
                uid = a.uid,
                animalData = a
            })
        end
    end
    table.sort(out, function(a, b) return a.value > b.value end)
    return out
end

local function trySteal(prompt, petData)
    if not prompt or not prompt.Parent then return false end
    if InternalCache[prompt] then return false end
    InternalCache[prompt] = true
    task.spawn(function()
        pcall(function()
            local ok, conns = pcall(getconnections, prompt.PromptButtonHoldBegan)
            if ok then for _, c in pairs(conns or {}) do if c.Function then task.spawn(c.Function) end end end
        end)
        pcall(function()
            local ok, conns = pcall(getconnections, prompt.Triggered)
            if ok then for _, c in pairs(conns or {}) do if c.Function then task.spawn(c.Function) end end end
        end)
        task.wait(0.5)
        InternalCache[prompt] = nil
    end)
    return true
end

-- Scan plots
local lastHash = {}
local function getHash(al)
    if not al then return "" end
    local h = ""
    for slot, d in pairs(al) do if type(d) == "table" then h = h .. tostring(slot) .. tostring(d.Index) .. tostring(d.Mutation) end end
    return h
end

local function scanPlot(plot)
    pcall(function()
        local ch = Synchronizer:Get(plot.Name)
        if not ch then return end
        local al = ch:Get("AnimalList")
        local hash = getHash(al)
        if lastHash[plot.Name] == hash then return end
        lastHash[plot.Name] = hash
        
        for i = #allAnimalsCache, 1, -1 do if allAnimalsCache[i].plot == plot.Name then table.remove(allAnimalsCache, i) end end
        
        local owner = ch:Get("Owner")
        if not owner or not Players:FindFirstChild(owner.Name) then return end
        local ownerName = owner.Name
        
        if not al then return end
        for slot, ad in pairs(al) do
            if type(ad) == "table" then
                local aName, aInfo = ad.Index, AnimalsData[ad.Index]
                if aInfo then
                    local mut = ad.Mutation or "None"
                    if mut == "Yin Yang" then mut = "YinYang" end
                    local gv = AnimalsShared:GetGeneration(aName, ad.Mutation, ad.Traits, nil)
                    local gt = "$" .. NumberUtils:ToString(gv) .. "/s"
                    table.insert(allAnimalsCache, {
                        name = aInfo.DisplayName or aName,
                        genText = gt,
                        genValue = gv,
                        mutation = mut,
                        owner = ownerName,
                        plot = plot.Name,
                        slot = tostring(slot),
                        uid = plot.Name .. "_" .. tostring(slot)
                    })
                end
            end
        end
    end)
    table.sort(allAnimalsCache, function(a, b) return a.genValue > b.genValue end)
end

local function setupPlot(plot)
    local ch, tries = nil, 0
    while not ch and tries < 50 do
        local ok, r = pcall(function() return Synchronizer:Get(plot.Name) end)
        if ok and r then ch = r; break else tries = tries + 1; task.wait(0.1) end
    end
    if not ch then return end
    scanPlot(plot)
    plot.DescendantAdded:Connect(function() task.wait(0.1); scanPlot(plot) end)
end

local plotsFolder = Workspace:WaitForChild("Plots", 8)
if plotsFolder then
    for _, p in ipairs(plotsFolder:GetChildren()) do setupPlot(p) end
    plotsFolder.ChildAdded:Connect(function(p) task.wait(0.5); setupPlot(p) end)
end

-- Menú Auto Steal
local autoStealGui = Instance.new("ScreenGui")
autoStealGui.Name = "AutoStealMini"
autoStealGui.ResetOnSpawn = false
autoStealGui.Parent = player:WaitForChild("PlayerGui")
autoStealGui.Enabled = false

local mainFrameMini = Instance.new("Frame")
mainFrameMini.Size = UDim2.new(0, 180, 0, 150)
mainFrameMini.Position = UDim2.new(savedPos.X, 0, savedPos.Y, 0)
mainFrameMini.BackgroundColor3 = ThemeMini.BG
mainFrameMini.BackgroundTransparency = 0.05
mainFrameMini.BorderSizePixel = 0
mainFrameMini.Parent = autoStealGui
Instance.new("UICorner", mainFrameMini).CornerRadius = UDim.new(0, 8)
mainFrameMini.Active = true
mainFrameMini.Draggable = true

local strokeMini = Instance.new("UIStroke", mainFrameMini)
strokeMini.Color = ThemeMini.Accent
strokeMini.Thickness = 1
strokeMini.Transparency = 0.6

local dragToggleMini = false
local dragStartMini = nil
local startPosMini = nil

mainFrameMini.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggleMini = true
        dragStartMini = input.Position
        startPosMini = mainFrameMini.Position
    end
end)

mainFrameMini.InputEnded:Connect(function(input)
    if dragToggleMini and input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggleMini = false
        local parentSize = mainFrameMini.Parent.AbsoluteSize
        if parentSize.X > 0 and parentSize.Y > 0 then
            local absX = mainFrameMini.AbsolutePosition.X
            local absY = mainFrameMini.AbsolutePosition.Y
            local newX = absX / parentSize.X
            local newY = absY / parentSize.Y
            savePosition(newX, newY)
        end
    end
end)

mainFrameMini.InputChanged:Connect(function(input)
    if dragToggleMini and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartMini
        mainFrameMini.Position = UDim2.new(startPosMini.X.Scale, startPosMini.X.Offset + delta.X, startPosMini.Y.Scale, startPosMini.Y.Offset + delta.Y)
    end
end)

local headerMini = Instance.new("Frame", mainFrameMini)
headerMini.Size = UDim2.new(1, 0, 0, 28)
headerMini.BackgroundTransparency = 1

local titleMini = Instance.new("TextLabel", headerMini)
titleMini.Size = UDim2.new(0.6, 0, 1, 0)
titleMini.Position = UDim2.new(0, 6, 0, 0)
titleMini.BackgroundTransparency = 1
titleMini.Text = "⚡ AUTO"
titleMini.Font = Enum.Font.GothamBlack
titleMini.TextSize = 11
titleMini.TextColor3 = ThemeMini.Text
titleMini.TextXAlignment = Enum.TextXAlignment.Left

local toggleBtnMini = Instance.new("TextButton", headerMini)
toggleBtnMini.Size = UDim2.new(0, 35, 0, 18)
toggleBtnMini.Position = UDim2.new(1, -38, 0.5, -9)
toggleBtnMini.BackgroundColor3 = ThemeMini.Success
toggleBtnMini.Text = "ON"
toggleBtnMini.Font = Enum.Font.GothamBold
toggleBtnMini.TextSize = 9
toggleBtnMini.TextColor3 = Color3.new(0, 0, 0)
Instance.new("UICorner", toggleBtnMini).CornerRadius = UDim.new(0, 4)
toggleBtnMini.MouseButton1Click:Connect(function()
    autoStealEnabled = not autoStealEnabled
    toggleBtnMini.Text = autoStealEnabled and "ON" or "OFF"
    toggleBtnMini.BackgroundColor3 = autoStealEnabled and ThemeMini.Success or ThemeMini.Error
end)

local currentFrameMini = Instance.new("Frame", mainFrameMini)
currentFrameMini.Size = UDim2.new(1, -10, 0, 32)
currentFrameMini.Position = UDim2.new(0, 5, 0, 32)
currentFrameMini.BackgroundColor3 = ThemeMini.Surface
currentFrameMini.BackgroundTransparency = 0.5
Instance.new("UICorner", currentFrameMini).CornerRadius = UDim.new(0, 6)

local currentNameMini = Instance.new("TextLabel", currentFrameMini)
currentNameMini.Size = UDim2.new(1, -10, 0, 16)
currentNameMini.Position = UDim2.new(0, 5, 0, 4)
currentNameMini.BackgroundTransparency = 1
currentNameMini.Font = Enum.Font.GothamBold
currentNameMini.TextSize = 10
currentNameMini.TextColor3 = ThemeMini.Accent
currentNameMini.TextXAlignment = Enum.TextXAlignment.Left
currentNameMini.Text = "..."
currentNameMini.TextTruncate = Enum.TextTruncate.AtEnd

local currentValueMini = Instance.new("TextLabel", currentFrameMini)
currentValueMini.Size = UDim2.new(1, -10, 0, 12)
currentValueMini.Position = UDim2.new(0, 5, 0, 18)
currentValueMini.BackgroundTransparency = 1
currentValueMini.Font = Enum.Font.GothamMedium
currentValueMini.TextSize = 8
currentValueMini.TextColor3 = ThemeMini.TextSec
currentValueMini.TextXAlignment = Enum.TextXAlignment.Left
currentValueMini.Text = ""

local listFrameMini = Instance.new("Frame", mainFrameMini)
listFrameMini.Size = UDim2.new(1, -10, 0, 66)
listFrameMini.Position = UDim2.new(0, 5, 0, 68)
listFrameMini.BackgroundTransparency = 1

local MutationColorsMini = {Gold = Color3.fromRGB(255, 200, 0), Diamond = Color3.fromRGB(0, 255, 200), Rainbow = Color3.fromRGB(255, 100, 200), Cursed = Color3.fromRGB(200, 0, 0)}

local cardsMini = {}
for i = 1, 3 do
    local card = Instance.new("Frame", listFrameMini)
    card.Size = UDim2.new(1, 0, 0, 20)
    card.Position = UDim2.new(0, 0, 0, (i-1) * 21)
    card.BackgroundColor3 = ThemeMini.Surface
    card.BackgroundTransparency = 0.4
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 4)
    
    local rank = Instance.new("TextLabel", card)
    rank.Size = UDim2.new(0, 18, 1, 0)
    rank.BackgroundTransparency = 1
    rank.Text = i == 1 and "🥇" or (i == 2 and "🥈" or "🥉")
    rank.Font = Enum.Font.GothamBold
    rank.TextSize = 10
    
    local name = Instance.new("TextLabel", card)
    name.Size = UDim2.new(0.5, 0, 1, 0)
    name.Position = UDim2.new(0, 20, 0, 0)
    name.BackgroundTransparency = 1
    name.Font = Enum.Font.GothamBold
    name.TextSize = 9
    name.TextColor3 = ThemeMini.Text
    name.TextXAlignment = Enum.TextXAlignment.Left
    name.Text = "..."
    name.TextTruncate = Enum.TextTruncate.AtEnd
    
    local value = Instance.new("TextLabel", card)
    value.Size = UDim2.new(0.3, 0, 1, 0)
    value.Position = UDim2.new(0.5, 0, 0, 0)
    value.BackgroundTransparency = 1
    value.Font = Enum.Font.GothamMedium
    value.TextSize = 8
    value.TextColor3 = ThemeMini.TextSec
    value.TextXAlignment = Enum.TextXAlignment.Left
    value.Text = ""
    
    local stealBtn = Instance.new("TextButton", card)
    stealBtn.Size = UDim2.new(0, 32, 0, 16)
    stealBtn.Position = UDim2.new(1, -34, 0.5, -8)
    stealBtn.BackgroundColor3 = ThemeMini.Accent
    stealBtn.Text = "↓"
    stealBtn.Font = Enum.Font.GothamBold
    stealBtn.TextSize = 10
    stealBtn.TextColor3 = Color3.new(0, 0, 0)
    Instance.new("UICorner", stealBtn).CornerRadius = UDim.new(0, 4)
    
    cardsMini[i] = {card = card, name = name, value = value, btn = stealBtn, pet = nil}
end

local progressBgMini = Instance.new("Frame", mainFrameMini)
progressBgMini.Size = UDim2.new(1, -10, 0, 2)
progressBgMini.Position = UDim2.new(0, 5, 1, -4)
progressBgMini.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
progressBgMini.BorderSizePixel = 0
Instance.new("UICorner", progressBgMini).CornerRadius = UDim.new(1, 0)

local progressFillMini = Instance.new("Frame", progressBgMini)
progressFillMini.Size = UDim2.new(0, 0, 1, 0)
progressFillMini.BackgroundColor3 = ThemeMini.Accent
progressFillMini.BorderSizePixel = 0
Instance.new("UICorner", progressFillMini).CornerRadius = UDim.new(1, 0)

local currentPetMini = nil
local function updateUIMini()
    local pets = getTopPets()
    
    for i = 1, 3 do
        local card = cardsMini[i]
        if pets[i] then
            local pet = pets[i]
            card.pet = pet
            card.name.Text = pet.name:sub(1, 12)
            card.value.Text = pet.valueText
            local color = MutationColorsMini[pet.mutation] or ThemeMini.Accent
            card.btn.BackgroundColor3 = color
            
            card.btn.MouseButton1Click:Connect(function()
                if not autoStealEnabled then return end
                currentPetMini = pet
                currentNameMini.Text = pet.name:sub(1, 14)
                currentValueMini.Text = pet.valueText
                local prompt = findProximityPrompt(pet.animalData)
                if prompt then
                    trySteal(prompt, pet)
                    TweenService:Create(progressFillMini, TweenInfo.new(1, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()
                    task.delay(1, function()
                        TweenService:Create(progressFillMini, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 1, 0)}):Play()
                    end)
                end
            end)
        else
            card.name.Text = "---"
            card.value.Text = ""
            card.btn.BackgroundColor3 = ThemeMini.Surface
        end
    end
    
    if autoStealEnabled and pets[1] and (not currentPetMini or currentPetMini.uid ~= pets[1].uid) then
        currentPetMini = pets[1]
        if currentPetMini then
            currentNameMini.Text = currentPetMini.name:sub(1, 14)
            currentValueMini.Text = currentPetMini.valueText
        end
    end
end

task.spawn(function()
    while true do
        task.wait(0.3)
        if autoStealEnabled and currentPetMini then
            local prompt = findProximityPrompt(currentPetMini.animalData)
            if prompt then
                trySteal(prompt, currentPetMini)
                TweenService:Create(progressFillMini, TweenInfo.new(1, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()
                task.delay(1, function()
                    TweenService:Create(progressFillMini, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 1, 0)}):Play()
                end)
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        pcall(updateUIMini)
    end
end)

task.delay(2, updateUIMini)

-- ============================================
-- 🎵 SISTEMA DE SONIDO PARA ANIMALES +100M (DURACIÓN 1 SEGUNDO)
-- ============================================

local animalsSoundPlayed = {}
local soundCooldown = false

local jackpotSound = Instance.new("Sound")
jackpotSound.SoundId = "rbxassetid://84677981674776"
jackpotSound.Volume = 0.8
jackpotSound.Looped = false
jackpotSound.TimePosition = 0
jackpotSound.Parent = SoundService

local function formatNumber(n)
    if n >= 1e9 then return string.format("%.1fB", n / 1e9)
    elseif n >= 1e6 then return string.format("%.1fM", n / 1e6)
    elseif n >= 1e3 then return string.format("%.1fK", n / 1e3)
    else return tostring(n)
    end
end

local function playJackpotSound(animalName, value)
    if soundCooldown then return end
    soundCooldown = true
    
    jackpotSound.TimePosition = 0
    jackpotSound:Play()
    
    local notif = Instance.new("Frame", gui)
    notif.Size = UDim2.new(0, 280, 0, 50)
    notif.Position = UDim2.new(0.5, -140, 0.2, 0)
    notif.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    notif.BackgroundTransparency = 0.1
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 12)
    
    local strokeNotif = Instance.new("UIStroke", notif)
    strokeNotif.Thickness = 2
    strokeNotif.Color = Color3.fromRGB(255, 215, 0)
    
    local text = Instance.new("TextLabel", notif)
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = "🎉 " .. animalName .. " - $" .. formatNumber(value) .. " 🎉"
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.Font = Enum.Font.GothamBold
    text.TextSize = 16
    
    notif.Position = UDim2.new(0.5, -140, -0.1, 0)
    TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Bounce), {
        Position = UDim2.new(0.5, -140, 0.15, 0)
    }):Play()
    
    task.wait(1)
    TweenService:Create(notif, TweenInfo.new(0.2), {
        Position = UDim2.new(0.5, -140, -0.1, 0)
    }):Play()
    task.wait(0.2)
    notif:Destroy()
    
    task.wait(0.3)
    soundCooldown = false
end

-- Detector de animales (cada 1 segundo)
local function setupAnimalSoundDetector()
    local Packages = ReplicatedStorage:WaitForChild("Packages")
    local Datas = ReplicatedStorage:WaitForChild("Datas")
    local Shared = ReplicatedStorage:WaitForChild("Shared")
    
    local Synchronizer = require(Packages:WaitForChild("Synchronizer"))
    local AnimalsData = require(Datas:WaitForChild("Animals"))
    local AnimalsShared = require(Shared:WaitForChild("Animals"))
    
    task.spawn(function()
        while true do
            task.wait(1)
            
            local plots = Workspace:FindFirstChild("Plots")
            if not plots then continue end
            
            for _, plot in ipairs(plots:GetChildren()) do
                local channel = Synchronizer:Get(plot.Name)
                if not channel then continue end
                
                local animalList = channel:Get("AnimalList")
                if not animalList then continue end
                
                for slot, data in pairs(animalList) do
                    if type(data) == "table" then
                        local info = AnimalsData[data.Index]
                        if not info then continue end
                        
                        local gen = AnimalsShared:GetGeneration(data.Index, data.Mutation, data.Traits, nil)
                        local animalId = plot.Name .. "_" .. tostring(slot)
                        
                        if gen >= 100000000 and not animalsSoundPlayed[animalId] then
                            animalsSoundPlayed[animalId] = true
                            playJackpotSound(info.DisplayName or data.Index, gen)
                        end
                    end
                end
            end
        end
    end)
end

task.spawn(setupAnimalSoundDetector)

-- ============================================
-- 🚗 AUTO DESTROY TURRETS (Controlado por Helper)
-- ============================================

local autoDestroyActive = false
local autoDestroyConnection = nil

local function hasExclamation(target)
    for _, d in ipairs(target:GetDescendants()) do
        if d:IsA("BillboardGui") then
            local label = d:FindFirstChildWhichIsA("TextLabel", true)
            if label and label.Text:find("!") then
                return true
            end
        end
    end
    return false
end

local function applyVisuals(target)
    for _, d in ipairs(target:GetDescendants()) do
        if d:IsA("BasePart") and d ~= target then
            d.Transparency = 0.5
            d.CanCollide = false
            d.CanTouch = false
            d.CanQuery = false
        elseif d:IsA("BillboardGui") and d.Name ~= "SentryLabel" then
            d:Destroy()
        elseif d:IsA("Decal") or d:IsA("Texture") then
            d.Transparency = 0.5
        end
    end
    if target:IsA("BasePart") and target.Name ~= "ProxyVisual" then
        target.Transparency = 1
        target.CanCollide = false
    end
end

local function getClosestSentry()
    local char = player.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    
    local closest, shortestDist = nil, math.huge
    for _, inst in ipairs(Workspace:GetDescendants()) do
        if inst.Name:match("^Sentry_") then
            if hasExclamation(inst) then
                local root = inst:IsA("BasePart") and inst or inst:FindFirstChildWhichIsA("BasePart", true)
                if root then
                    local dist = (hrp.Position - root.Position).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        closest = inst
                    end
                end
            end
        end
    end
    return closest
end

local function startAutoDestroy()
    if autoDestroyConnection then return end
    
    autoDestroyConnection = RunService.Heartbeat:Connect(function()
        if not autoDestroyActive then return end
        
        if player:GetAttribute("Stealing") == true then
            return
        end
        
        local targetSentry = getClosestSentry()
        if targetSentry then
            task.spawn(function()
                local char = player.Character
                if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChild("Humanoid")
                if not hrp or not hum then return end
                
                local bat = player.Backpack:FindFirstChild("Bat") or char:FindFirstChild("Bat")
                
                applyVisuals(targetSentry)
                
                local offset = hrp.CFrame.LookVector * 4
                local targetCF = CFrame.new(hrp.Position + offset, hrp.Position)
                
                if targetSentry:IsA("Model") then
                    targetSentry:PivotTo(targetCF)
                elseif targetSentry:IsA("BasePart") then
                    targetSentry.CFrame = targetCF
                end
                
                if bat then
                    if bat.Parent ~= char then 
                        hum:EquipTool(bat) 
                    end
                    bat:Activate()
                end
            end)
        end
    end)
end

local function stopAutoDestroy()
    if autoDestroyConnection then
        autoDestroyConnection:Disconnect()
        autoDestroyConnection = nil
    end
end

-- ============================================
-- 👑 BEST BRAINROT ESP (Controlado por Helper)
-- ============================================

local brainrotESPActive = false
local currentBestBillboard = nil
local currentBestAdornee = nil
local hiddenOverhead = nil
local bestBrainrotCache = {}

local MUT_COLORS = {
    Cursed = Color3.fromRGB(255, 50, 50),
    Gold = Color3.fromRGB(255, 215, 0),
    Diamond = Color3.fromRGB(0, 255, 255),
    YinYang = Color3.fromRGB(220, 220, 220),
    Rainbow = Color3.fromRGB(255, 100, 200),
    Lava = Color3.fromRGB(255, 100, 20),
    Candy = Color3.fromRGB(255, 105, 180),
    Bloodrot = Color3.fromRGB(139, 0, 0),
    Radioactive = Color3.fromRGB(0, 255, 0),
    Divine = Color3.fromRGB(255, 255, 255)
}

local function findAdorneeGlobalESP(animalData)
    if not animalData then return nil end
    local plot = Workspace:FindFirstChild("Plots") and Workspace.Plots:FindFirstChild(animalData.plot)
    if plot then
        local podiums = plot:FindFirstChild("AnimalPodiums")
        if podiums then
            local podium = podiums:FindFirstChild(animalData.slot)
            if podium then
                local base = podium:FindFirstChild("Base")
                if base then
                    local spawn = base:FindFirstChild("Spawn")
                    if spawn then return spawn end
                    return base:FindFirstChildWhichIsA("BasePart") or base
                end
            end
        end
    end
    return nil
end

local function hideDefaultOverheadESP(overhead)
    if overhead and overhead.Parent and not hiddenOverhead then
        hiddenOverhead = overhead.Enabled
        overhead.Enabled = false
    end
end

local function showDefaultOverheadESP(overhead)
    if overhead and hiddenOverhead ~= nil then
        overhead.Enabled = hiddenOverhead
        hiddenOverhead = nil
    end
end

local function createBrainrotBillboardESP(data)
    local bb = Instance.new("BillboardGui")
    bb.Name = "BestBrainrotESP"
    bb.Size = UDim2.new(0, 180, 0, 50)
    bb.StudsOffset = Vector3.new(0, 2.5, 0)
    bb.AlwaysOnTop = true
    bb.LightInfluence = 0
    bb.MaxDistance = 3000
    bb.ResetOnSpawn = false
    
    local hasMut = data.mutation and data.mutation ~= "None" and data.mutation ~= "N/A"
    local color = hasMut and (MUT_COLORS[data.mutation] or Color3.fromRGB(200, 100, 255)) or Color3.fromRGB(0, 255, 150)
    
    local container = Instance.new("Frame", bb)
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    container.BackgroundTransparency = 0.55
    container.BorderSizePixel = 0
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)
    
    local stroke = Instance.new("UIStroke", container)
    stroke.Color = color
    stroke.Thickness = 2
    stroke.Transparency = 0.2
    
    local crownLabel = Instance.new("TextLabel", container)
    crownLabel.Size = UDim2.new(0, 20, 0, 20)
    crownLabel.Position = UDim2.new(0, 5, 0, 2)
    crownLabel.BackgroundTransparency = 1
    crownLabel.Font = Enum.Font.GothamBlack
    crownLabel.TextSize = 16
    crownLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    crownLabel.Text = "👑"
    crownLabel.TextXAlignment = Enum.TextXAlignment.Center
    
    local nameLabel = Instance.new("TextLabel", container)
    nameLabel.Size = UDim2.new(1, -30, 0, 22)
    nameLabel.Position = UDim2.new(0, 28, 0, 2)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Font = Enum.Font.GothamBlack
    nameLabel.TextSize = 14
    nameLabel.TextColor3 = color
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Text = data.name or data.petName or "???"
    nameLabel.TextXAlignment = Enum.TextXAlignment.Center
    
    local genLabel = Instance.new("TextLabel", container)
    genLabel.Size = UDim2.new(1, -10, 0, 18)
    genLabel.Position = UDim2.new(0, 5, 0, 26)
    genLabel.BackgroundTransparency = 1
    genLabel.Font = Enum.Font.GothamBold
    genLabel.TextSize = 12
    genLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    genLabel.TextStrokeTransparency = 0
    genLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    genLabel.Text = "🏆 BEST: " .. (data.genText or "")
    genLabel.TextXAlignment = Enum.TextXAlignment.Center
    
    if hasMut then
        local mutBadge = Instance.new("TextLabel", bb)
        mutBadge.Size = UDim2.new(0, 70, 0, 16)
        mutBadge.Position = UDim2.new(0.5, -35, 0, -20)
        mutBadge.BackgroundColor3 = color
        mutBadge.BackgroundTransparency = 0.25
        mutBadge.Font = Enum.Font.GothamBlack
        mutBadge.TextSize = 10
        mutBadge.TextColor3 = Color3.fromRGB(255, 255, 255)
        mutBadge.TextStrokeTransparency = 0
        mutBadge.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        mutBadge.Text = "✨ " .. data.mutation:upper() .. " ✨"
        Instance.new("UICorner", mutBadge).CornerRadius = UDim.new(0, 5)
    end
    
    return bb
end

local function clearBestBrainrotESP()
    if currentBestBillboard and currentBestBillboard.Parent then
        pcall(function() currentBestBillboard:Destroy() end)
    end
    currentBestBillboard = nil
    currentBestAdornee = nil
    if hiddenOverhead ~= nil then
        showDefaultOverheadESP(currentBestAdornee and currentBestAdornee.Parent)
    end
end

local function updateBestBrainrotCache()
    if not brainrotESPActive then return end
    
    local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
    local AnimalsData = require(ReplicatedStorage.Datas.Animals)
    local AnimalsShared = require(ReplicatedStorage.Shared.Animals)
    local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
    
    local plots = Workspace:FindFirstChild("Plots")
    if not plots then return end
    
    local newCache = {}
    
    for _, plot in ipairs(plots:GetChildren()) do
        pcall(function()
            local ch = Synchronizer:Get(plot.Name)
            if not ch then return end
            local al = ch:Get("AnimalList")
            if not al then return end
            
            local owner = ch:Get("Owner")
            local ownerName = owner and owner.Name or "Unknown"
            
            for slot, ad in pairs(al) do
                if type(ad) == "table" then
                    local aName, aInfo = ad.Index, AnimalsData[ad.Index]
                    if aInfo then
                        local mut = ad.Mutation or "None"
                        if mut == "Yin Yang" then mut = "YinYang" end
                        local gv = AnimalsShared:GetGeneration(aName, ad.Mutation, ad.Traits, nil)
                        local gt = NumberUtils:ToString(gv) .. "/s"
                        
                        table.insert(newCache, {
                            name = aInfo.DisplayName or aName,
                            petName = aInfo.DisplayName or aName,
                            genText = gt,
                            genValue = gv,
                            mutation = mut,
                            owner = ownerName,
                            plot = plot.Name,
                            slot = tostring(slot),
                            uid = plot.Name .. "_" .. tostring(slot)
                        })
                    end
                end
            end
        end)
    end
    
    table.sort(newCache, function(a,b) return (a.genValue or 0) > (b.genValue or 0) end)
    bestBrainrotCache = newCache
end

local function refreshBestBrainrotESP()
    if not brainrotESPActive then return end
    if not bestBrainrotCache or #bestBrainrotCache == 0 then
        clearBestBrainrotESP()
        return
    end
    
    local best = bestBrainrotCache[1]
    if not best or best.genValue < 1000000 then
        clearBestBrainrotESP()
        return
    end
    
    local adornee = findAdorneeGlobalESP(best)
    
    if not adornee then
        return
    end
    
    if currentBestAdornee ~= adornee or not currentBestBillboard then
        clearBestBrainrotESP()
        
        local overhead = nil
        local model = adornee.Parent
        if model and model:IsA("Model") then
            overhead = model:FindFirstChild("AnimalOverhead", true)
            if not overhead then
                for _, child in ipairs(model:GetDescendants()) do
                    if child.Name == "AnimalOverhead" and child:IsA("BillboardGui") then
                        overhead = child
                        break
                    end
                end
            end
            if overhead then
                hideDefaultOverheadESP(overhead)
            end
        end
        
        local bb = createBrainrotBillboardESP(best)
        bb.Adornee = adornee
        bb.Parent = adornee
        currentBestBillboard = bb
        currentBestAdornee = adornee
    end
end

-- Iniciar loops del Brainrot ESP
task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(updateBestBrainrotCache)
    end
end)

task.spawn(function()
    while true do
        task.wait(0.3)
        pcall(refreshBestBrainrotESP)
    end
end)

-- ============================================
-- 🏠 ESP DE BASES (Controlado por Helper)
-- ============================================

local baseEspActive = false
local baseEspInstances = {}
local FIRST_FLOOR_HEIGHT = 3.5

local function cleanTimeText(rawText)
    if not rawText or rawText == "" then
        return "???"
    end
    
    if rawText:match("%x+%-%x+%-%x+%-%x+%-%x+") then
        return "???"
    end
    
    local seconds = rawText:match("%d+")
    if seconds then
        return seconds .. "s"
    end
    
    return rawText
end

local function createBaseESP(plot, mainPart, timeText)
    local espKey = tostring(plot)
    
    if baseEspInstances[espKey] then
        if baseEspInstances[espKey].billboard then baseEspInstances[espKey].billboard:Destroy() end
        if baseEspInstances[espKey].anchor then baseEspInstances[espKey].anchor:Destroy() end
        baseEspInstances[espKey] = nil
    end
    
    local anchor = Instance.new("Part")
    anchor.Name = "GroundESP_Base"
    anchor.Size = Vector3.new(2, 0.2, 2)
    anchor.Transparency = 1
    anchor.CanCollide = false
    anchor.Anchored = true
    anchor.Position = Vector3.new(mainPart.Position.X, FIRST_FLOOR_HEIGHT, mainPart.Position.Z)
    anchor.Parent = plot
    
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 70, 0, 20)
    billboard.StudsOffset = Vector3.new(0, 0.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Adornee = anchor
    billboard.MaxDistance = 400
    billboard.Parent = anchor
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(20, 15, 25)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = billboard
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(255, 200, 80)
    stroke.Transparency = 0.3
    stroke.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = Enum.Font.GothamMedium
    label.TextColor3 = Color3.fromRGB(255, 220, 100)
    label.TextStrokeTransparency = 0.4
    label.Text = "🤑 " .. timeText
    label.Parent = frame
    
    baseEspInstances[espKey] = {billboard = billboard, anchor = anchor, plot = plot}
    return billboard
end

local function updateBaseESP()
    if not baseEspActive then return end
    
    local plotsFolder = Workspace:FindFirstChild("Plots")
    if not plotsFolder then return end
    
    for _, plot in ipairs(plotsFolder:GetChildren()) do
        local purchases = plot:FindFirstChild("Purchases")
        local plotBlock = purchases and purchases:FindFirstChild("PlotBlock")
        local mainPart = plotBlock and plotBlock:FindFirstChild("Main")
        
        if mainPart then
            local timeLabel = mainPart:FindFirstChild("BillboardGui")
            if timeLabel then
                timeLabel = timeLabel:FindFirstChild("RemainingTime")
            end
            
            local rawTimeText = timeLabel and timeLabel.Text or "???"
            local cleanText = cleanTimeText(rawTimeText)
            local espKey = tostring(plot)
            
            if not baseEspInstances[espKey] then
                createBaseESP(plot, mainPart, cleanText)
            else
                local data = baseEspInstances[espKey]
                local label = data.billboard and data.billboard:FindFirstChildWhichIsA("Frame"):FindFirstChildWhichIsA("TextLabel")
                local anchor = data.anchor
                
                if anchor and mainPart then
                    anchor.Position = Vector3.new(mainPart.Position.X, FIRST_FLOOR_HEIGHT, mainPart.Position.Z)
                end
                
                if label then
                    local seconds = tonumber(cleanText:match("%d+"))
                    
                    if seconds then
                        if seconds <= 10 then
                            label.Text = "⚡ " .. cleanText .. " ⚡"
                            label.TextColor3 = Color3.fromRGB(255, 100, 120)
                        elseif seconds <= 30 then
                            label.Text = "🤑 " .. cleanText .. " 🤑"
                            label.TextColor3 = Color3.fromRGB(255, 190, 80)
                        else
                            label.Text = "💛 " .. cleanText
                            label.TextColor3 = Color3.fromRGB(255, 220, 120)
                        end
                    else
                        label.Text = "🤑 " .. cleanText
                    end
                end
            end
        end
    end
    
    for key, data in pairs(baseEspInstances) do
        if not data.plot or not data.plot.Parent then
            if data.billboard then data.billboard:Destroy() end
            if data.anchor then data.anchor:Destroy() end
            baseEspInstances[key] = nil
        end
    end
end

local baseEspConnection = RunService.RenderStepped:Connect(updateBaseESP)

-- ============================================
-- 🌙 X-RAY + ANTI-BEE (BOTÓN HELPER - Toggle)
-- ============================================

local helperActive = false
local wallsModified = {}
local xrayHeartbeat = nil
local xrayConnection = nil
local antiBeeConnections = {}
local originalMoveFunction = nil
local controlsProtected = false
local BAD_LIGHTING_NAMES = { Blue = true, DiscoEffect = true, BeeBlur = true, ColorCorrection = true }
local WALL_TRANSPARENCY = 0.85

local function isWallOnly(obj)
    if not obj:IsA("BasePart") then return false end
    if not obj.Anchored then return false end
    
    local name = obj.Name:lower()
    local parentName = (obj.Parent and obj.Parent.Name:lower()) or ""
    
    return (name:find("wall") or 
            name:find("base") or
            parentName:find("wall") or
            parentName:find("base")) and
            not name:find("floor") and
            not name:find("ground") and
            not parentName:find("floor") and
            not parentName:find("ground")
end

local function saveOriginal(obj)
    if not wallsModified[obj] then
        wallsModified[obj] = obj.Transparency
    end
end

local function applyToWall(obj)
    if not isWallOnly(obj) then return end
    saveOriginal(obj)
    obj.Transparency = WALL_TRANSPARENCY
end

local function restoreOriginal(obj)
    local original = wallsModified[obj]
    if original ~= nil then
        obj.Transparency = original
    end
    wallsModified[obj] = nil
end

local function enableXrayOnly()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if isWallOnly(obj) then
            applyToWall(obj)
        end
    end
    
    Lighting.Ambient = Color3.fromRGB(20, 18, 35)
    Lighting.OutdoorAmbient = Color3.fromRGB(25, 22, 40)
    Lighting.Brightness = 0.5
    Lighting.GlobalShadows = true
    Lighting.FogEnd = 350
    Lighting.FogColor = Color3.fromRGB(28, 25, 42)
    
    xrayConnection = Workspace.DescendantAdded:Connect(function(obj)
        if helperActive and isWallOnly(obj) then
            applyToWall(obj)
        end
    end)
    
    xrayHeartbeat = RunService.Heartbeat:Connect(function()
        if not helperActive then return end
        for obj in pairs(wallsModified) do
            if obj and obj.Parent and isWallOnly(obj) then
                if obj.Transparency ~= WALL_TRANSPARENCY then
                    obj.Transparency = WALL_TRANSPARENCY
                end
            end
        end
    end)
end

local function disableXrayOnly()
    if xrayConnection then
        xrayConnection:Disconnect()
        xrayConnection = nil
    end
    
    if xrayHeartbeat then
        xrayHeartbeat:Disconnect()
        xrayHeartbeat = nil
    end
    
    for obj in pairs(wallsModified) do
        if obj and obj.Parent then
            restoreOriginal(obj)
        end
    end
    wallsModified = {}
    
    Lighting.Ambient = Color3.fromRGB(0, 0, 0)
    Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
    Lighting.Brightness = 1
    Lighting.FogEnd = 100000
end

local function antiBeeNuke(obj)
    if not obj or not obj.Parent then return end
    if BAD_LIGHTING_NAMES[obj.Name] then
        pcall(function() obj:Destroy() end)
    end
end

local function antiBeeDisconnectAll()
    for _, conn in ipairs(antiBeeConnections) do
        if typeof(conn) == "RBXScriptConnection" then conn:Disconnect() end
    end
    antiBeeConnections = {}
end

local function protectControls()
    if controlsProtected then return end
    pcall(function()
        local PlayerScripts = player.PlayerScripts
        local PlayerModule = PlayerScripts:FindFirstChild("PlayerModule")
        if not PlayerModule then return end
        local Controls = require(PlayerModule):GetControls()
        if not Controls then return end
        if not originalMoveFunction then originalMoveFunction = Controls.moveFunction end
        local function protectedMoveFunction(self, moveVector, relativeToCamera)
            if originalMoveFunction then originalMoveFunction(self, moveVector, relativeToCamera) end
        end
        local controlCheckConn = RunService.Heartbeat:Connect(function()
            if not helperActive then return end
            if Controls.moveFunction ~= protectedMoveFunction then
                Controls.moveFunction = protectedMoveFunction
            end
        end)
        table.insert(antiBeeConnections, controlCheckConn)
        Controls.moveFunction = protectedMoveFunction
        controlsProtected = true
    end)
end

local function blockBuzzingSound()
    pcall(function()
        local beeScript = player.PlayerScripts:FindFirstChild("Bee", true)
        if beeScript then
            local buzzing = beeScript:FindFirstChild("Buzzing")
            if buzzing and buzzing:IsA("Sound") then buzzing:Stop(); buzzing.Volume = 0 end
        end
    end)
end

local function enableAntiBee()
    for _, inst in ipairs(Lighting:GetDescendants()) do antiBeeNuke(inst) end
    table.insert(antiBeeConnections, Lighting.DescendantAdded:Connect(function(obj)
        if helperActive then antiBeeNuke(obj) end
    end))
    protectControls()
    table.insert(antiBeeConnections, RunService.Heartbeat:Connect(function()
        if helperActive then blockBuzzingSound() end
    end))
end

local function disableAntiBee()
    antiBeeDisconnectAll()
    pcall(function()
        local PlayerModule = player.PlayerScripts:FindFirstChild("PlayerModule")
        if PlayerModule then
            local Controls = require(PlayerModule):GetControls()
            if Controls and originalMoveFunction then
                Controls.moveFunction = originalMoveFunction
                controlsProtected = false
            end
        end
    end)
end

-- ========== BOTÓN HELPER (Controla TODO) ==========
helperBtn.MouseButton1Click:Connect(function()
    helperActive = not helperActive
    
    if helperActive then
        autoStealGui.Enabled = true
        enableXrayOnly()
        enableAntiBee()
        autoDestroyActive = true
        startAutoDestroy()
        brainrotESPActive = true
        baseEspActive = true
        helperBtn.Text = "✅ Helper"
        helperBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        print("🌙 Helper ACTIVADO (Auto Steal + X-Ray + Anti-Bee + Auto Destroy Turrets + BEST BRAINROT ESP + ESP BASES)")
    else
        autoStealGui.Enabled = false
        disableXrayOnly()
        disableAntiBee()
        autoDestroyActive = false
        stopAutoDestroy()
        brainrotESPActive = false
        baseEspActive = false
        for _, data in pairs(baseEspInstances) do
            if data.billboard then data.billboard:Destroy() end
            if data.anchor then data.anchor:Destroy() end
        end
        baseEspInstances = {}
        helperBtn.Text = "Helper"
        helperBtn.BackgroundColor3 = Color3.fromRGB(35,35,55)
        print("🌙 Helper DESACTIVADO")
    end
end)

-- 🔴 CLOSE FIX
closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(frame, TweenInfo.new(0.25), {
        Size = UDim2.new(0,0,0,0)
    }):Play()

    task.wait(0.25)

    frame.Visible = false
    mini.Visible = true

    TweenService:Create(blur, TweenInfo.new(0.3), {
        Size = 0
    }):Play()
end)

-- 🟢 OPEN FIX
mini.MouseButton1Click:Connect(function()
    frame.Visible = true
    mini.Visible = false

    frame.Size = UDim2.new(0,0,0,0)

    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
        Size = UDim2.new(0,320,0,360)
    }):Play()

    TweenService:Create(blur, TweenInfo.new(0.3), {
        Size = 18
    }):Play()
end)

-- DRAG
local dragging=false
local dragStart,startPos

topBar.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        dragging=true
        dragStart=i.Position
        startPos=frame.Position
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        dragging=false
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if dragging then
        local d=i.Position-dragStart
        frame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
    end
end)

-- ❄️ SNOW
task.spawn(function()
    while true do
        local c=Instance.new("Frame",gui)
        c.Size=UDim2.new(0,3,0,3)
        c.Position=UDim2.new(math.random(),0,-0.1,0)
        c.BackgroundColor3=Color3.fromRGB(180,200,255)
        c.BackgroundTransparency=0.4
        TweenService:Create(c,TweenInfo.new(6),{Position=UDim2.new(c.Position.X.Scale,0,1.2,0)}):Play()
        task.wait(0.12)
    end
end)

print("✅ neymarjr HUB - VERSIÓN COMPLETA cargada")
print("🎵 Música de inicio ID: 140691414619561 | Inicio: segundo 3")
print("🔊 Sonido +100M: DURACIÓN 1 SEGUNDO - ID 84677981674776")
print("🎮 Player: Salto Infinito + Anti Ragdoll V1 (toggle)")
print("🌙 Helper: Auto Steal + X-Ray + Anti-Bee + Auto Destroy Turrets + BEST BRAINROT ESP + ESP BASES (toggle)")
print("🔘 Stealer: Decorativo")
