-- ╔══════════════════════════════════════════════════════════════════════════════╗
-- ║                            GARUDA HUB - BLOX FRUITS                          ║
-- ║                          Premium Tools Panel Loader                          ║
-- ║                        GitHub Dark Theme - Professional                      ║
-- ╚══════════════════════════════════════════════════════════════════════════════╝

-- Load UI Library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Create Main Window with GitHub Dark Theme
local Window = OrionLib:MakeWindow({
    Name = "🦅 GARUDA HUB | Blox Fruits Premium",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "GarudaHub",
    IntroEnabled = true,
    IntroText = "GARUDA HUB | Loading...",
    IntroIcon = "rbxassetid://4483345998",
    Icon = "rbxassetid://4483345998"
})

-- Global Variables
getgenv().GarudaHub = {
    AutoFarm = false,
    AutoQuest = false,
    AutoBuso = false,
    AutoKen = false,
    FastAttack = false,
    BringMob = false,
    AutoStats = false,
    SelectWeapon = "",
    SelectQuest = "",
    WalkSpeedValue = 16,
    JumpPowerValue = 50
}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Startup Notification
OrionLib:MakeNotification({
    Name = "🦅 GARUDA HUB",
    Content = "Successfully loaded! Welcome to the premium experience.",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- ═══════════════════════════════════════════════════════════════════════════════
--                                   MAIN TAB
-- ═══════════════════════════════════════════════════════════════════════════════

local MainTab = Window:MakeTab({
    Name = "🏠 Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local MainSection = MainTab:AddSection({
    Name = "🎯 Core Features"
})

-- Auto Farm Toggle
MainTab:AddToggle({
    Name = "⚡ Auto Farm Level",
    Default = false,
    Callback = function(Value)
        getgenv().GarudaHub.AutoFarm = Value
        if Value then
            spawn(function()
                while getgenv().GarudaHub.AutoFarm do
                    pcall(function()
                        -- Auto farm logic here
                        CheckLevel()
                        if getgenv().GarudaHub.AutoQuest then
                            GetQuest()
                        end
                        KillMonster()
                    end)
                    wait(0.1)
                end
            end)
        end
    end
})

-- Auto Quest Toggle
MainTab:AddToggle({
    Name = "📋 Auto Quest",
    Default = false,
    Callback = function(Value)
        getgenv().GarudaHub.AutoQuest = Value
    end
})

-- Fast Attack Toggle
MainTab:AddToggle({
    Name = "⚔️ Fast Attack",
    Default = false,
    Callback = function(Value)
        getgenv().GarudaHub.FastAttack = Value
        if Value then
            spawn(function()
                while getgenv().GarudaHub.FastAttack do
                    pcall(function()
                        local ac = CombatFramework.activeController
                        if ac and ac.equipped then
                            for i = 1, 1 do
                                local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
                                    Character,
                                    {Character.HumanoidRootPart},
                                    60
                                )
                                local cac = {}
                                local hash = {}
                                for k, v in pairs(bladehit) do
                                    if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                                        table.insert(cac, v.Parent.HumanoidRootPart)
                                        hash[v.Parent] = true
                                    end
                                end
                                bladehit = cac
                                if #bladehit > 0 then
                                    local u8 = debug.getupvalue(ac.attack, 5)
                                    local u9 = debug.getupvalue(ac.attack, 6)
                                    local u7 = debug.getupvalue(ac.attack, 4)
                                    local u10 = debug.getupvalue(ac.attack, 7)
                                    local u12 = (u8 * 798405 + u7 * 727595) % u9
                                    local u13 = u7 * 798405
                                    (function()
                                        u12 = (u12 * u9 + u13) % 1099511627776
                                        u8 = math.floor(u12 / u9)
                                        u7 = u12 - u8 * u9
                                    end)()
                                    u10 = u10 + 1
                                    debug.setupvalue(ac.attack, 5, u8)
                                    debug.setupvalue(ac.attack, 6, u9)
                                    debug.setupvalue(ac.attack, 4, u7)
                                    debug.setupvalue(ac.attack, 7, u10)
                                    if Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] then
                                        game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(Character:FindFirstChildOfClass("Tool").Name))
                                        game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
                                        game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "")
                                    end
                                end
                            end
                        end
                    end)
                    wait()
                end
            end)
        end
    end
})

-- Bring Mob Toggle
MainTab:AddToggle({
    Name = "🧲 Bring Mob",
    Default = false,
    Callback = function(Value)
        getgenv().GarudaHub.BringMob = Value
    end
})

-- Auto Buso Toggle
MainTab:AddToggle({
    Name = "🛡️ Auto Buso Haki",
    Default = false,
    Callback = function(Value)
        getgenv().GarudaHub.AutoBuso = Value
        if Value then
            spawn(function()
                while getgenv().GarudaHub.AutoBuso do
                    pcall(function()
                        if not LocalPlayer.Character:FindFirstChild("HasBuso") then
                            local args = {"Buso"}
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        end
                    end)
                    wait(0.1)
                end
            end)
        end
    end
})

-- Auto Ken Toggle
MainTab:AddToggle({
    Name = "👁️ Auto Ken Haki",
    Default = false,
    Callback = function(Value)
        getgenv().GarudaHub.AutoKen = Value
        if Value then
            spawn(function()
                while getgenv().GarudaHub.AutoKen do
                    pcall(function()
                        if not LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                            local args = {"Ken", true}
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        end
                    end)
                    wait(0.1)
                end
            end)
        end
    end
})

-- ═══════════════════════════════════════════════════════════════════════════════
--                                 FARMING TAB
-- ═══════════════════════════════════════════════════════════════════════════════

local FarmTab = Window:MakeTab({
    Name = "🌾 Farming",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local FarmSection = FarmTab:AddSection({
    Name = "🎯 Advanced Farming"
})

-- Mastery Farm Toggle
FarmTab:AddToggle({
    Name = "🎓 Auto Mastery Farm",
    Default = false,
    Callback = function(Value)
        getgenv().AutoMastery = Value
        if Value then
            spawn(function()
                while getgenv().AutoMastery do
                    pcall(function()
                        -- Mastery farming logic
                        if LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                            local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", 1)
                        end
                    end)
                    wait(0.1)
                end
            end)
        end
    end
})

-- Bone Farm Toggle
FarmTab:AddToggle({
    Name = "🦴 Auto Bone Farm",
    Default = false,
    Callback = function(Value)
        getgenv().AutoBone = Value
        if Value then
            spawn(function()
                while getgenv().AutoBone do
                    pcall(function()
                        -- Bone farming logic
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        AutoHaki()
                                        EquipWeapon(SelectWeapon)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.Head.CanCollide = false
                                        StartMagnet = true
                                        PosMonBone = v.HumanoidRootPart.CFrame
                                        topos(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                        game:GetService("VirtualUser"):CaptureController()
                                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                    until not getgenv().AutoBone or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        end
                    end)
                    wait()
                end
            end)
        end
    end
})

-- Cake Prince Farm
FarmTab:AddToggle({
    Name = "🍰 Auto Cake Prince",
    Default = false,
    Callback = function(Value)
        getgenv().AutoCakePrince = Value
        if Value then
            spawn(function()
                while getgenv().AutoCakePrince do
                    pcall(function()
                        if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Cake Prince" then
                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            AutoHaki()
                                            EquipWeapon(SelectWeapon)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                            topos(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                            game:GetService("VirtualUser"):CaptureController()
                                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                        until not getgenv().AutoCakePrince or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            end
                        end
                    end)
                    wait()
                end
            end)
        end
    end
})

-- ═══════════════════════════════════════════════════════════════════════════════
--                                 SETTINGS TAB
-- ═══════════════════════════════════════════════════════════════════════════════

local SettingsTab = Window:MakeTab({
    Name = "⚙️ Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local SettingsSection = SettingsTab:AddSection({
    Name = "🎮 Game Settings"
})

-- Walk Speed
SettingsTab:AddSlider({
    Name = "🏃 Walk Speed",
    Min = 16,
    Max = 300,
    Default = 16,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        getgenv().GarudaHub.WalkSpeedValue = Value
        LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

-- Jump Power
SettingsTab:AddSlider({
    Name = "🦘 Jump Power",
    Min = 50,
    Max = 300,
    Default = 50,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Power",
    Callback = function(Value)
        getgenv().GarudaHub.JumpPowerValue = Value
        LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

-- Anti AFK
SettingsTab:AddToggle({
    Name = "💤 Anti AFK",
    Default = true,
    Callback = function(Value)
        getgenv().AntiAFK = Value
        if Value then
            spawn(function()
                while getgenv().AntiAFK do
                    pcall(function()
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
                    end)
                    wait(300)
                end
            end)
        end
    end
})

-- No Clip
SettingsTab:AddToggle({
    Name = "👻 No Clip",
    Default = false,
    Callback = function(Value)
        getgenv().NoClip = Value
        if Value then
            spawn(function()
                while getgenv().NoClip do
                    pcall(function()
                        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                    end)
                    wait()
                end
            end)
        end
    end
})

-- ═══════════════════════════════════════════════════════════════════════════════
--                                UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════

-- Check Level Function
function CheckLevel()
    local Lv = LocalPlayer.Data.Level.Value
    if First_Sea then
        if Lv == 1 or Lv <= 9 then
            Ms = "Bandit"
            NameQuest = "BanditQuest1"
            QuestLv = 1
            NameMon = "Bandit"
            CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
            CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
        elseif Lv == 10 or Lv <= 14 then
            Ms = "Monkey"
            NameQuest = "JungleQuest"
            QuestLv = 1
            NameMon = "Monkey"
            CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameMon = CFrame.new(-1448.1446533203, 50.851993560791, 63.60718536377)
        -- Add more level checks as needed
        end
    end
end

-- Get Quest Function
function GetQuest()
    if getgenv().GarudaHub.AutoQuest then
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
        end)
    end
end

-- Kill Monster Function
function KillMonster()
    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v.Name == Ms then
            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                repeat task.wait()
                    if getgenv().GarudaHub.AutoBuso then
                        if not LocalPlayer.Character:FindFirstChild("HasBuso") then
                            local args = {"Buso"}
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        end
                    end
                    if getgenv().GarudaHub.BringMob then
                        v.HumanoidRootPart.CanCollide = false
                        v.Humanoid.WalkSpeed = 0
                        v.Head.CanCollide = false
                        v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                    end
                    LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,30,0)
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                until not getgenv().GarudaHub.AutoFarm or not v.Parent or v.Humanoid.Health <= 0
            end
        end
    end
end

-- Auto Haki Function
function AutoHaki()
    if not LocalPlayer.Character:FindFirstChild("HasBuso") then
        local args = {"Buso"}
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
end

-- Equip Weapon Function
function EquipWeapon(ToolSe)
    if LocalPlayer.Backpack:FindFirstChild(ToolSe) then
        local tool = LocalPlayer.Backpack:FindFirstChild(ToolSe)
        wait(0.4)
        LocalPlayer.Character.Humanoid:EquipTool(tool)
    end
end

-- Teleport Function
function topos(Pos)
    Distance = (Pos.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 25 then
        Speed = 10000
    elseif Distance < 50 then
        Speed = 2000
    elseif Distance < 150 then
        Speed = 800
    elseif Distance < 300 then
        Speed = 600
    elseif Distance < 500 then
        Speed = 400
    elseif Distance < 750 then
        Speed = 250
    elseif Distance >= 1000 then
        Speed = 200
    end
    game:GetService("TweenService"):Create(
        LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
        {CFrame = Pos}
    ):Play()
end

-- Sea Detection
First_Sea = false
Second_Sea = false
Third_Sea = false
local placeId = game.PlaceId
if placeId == 2753915549 then
    First_Sea = true
elseif placeId == 4442272183 then
    Second_Sea = true
elseif placeId == 7449423635 then
    Third_Sea = true
end

-- Initialize
OrionLib:Init()
