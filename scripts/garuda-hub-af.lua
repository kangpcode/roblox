-- ╔══════════════════════════════════════════════════════════════════════════════╗
-- ║                    🔥 GARUDA HUB ANIMEFRUIT ENCRYPTED 🔥                    ║
-- ║                         Premium Encrypted Loader v2.0                       ║
-- ║                      Advanced Anti-Detection & Obfuscation                  ║
-- ╚══════════════════════════════════════════════════════════════════════════════╝

-- Advanced Encryption System
local _0x1a = {[1]="game",[2]="GetService",[3]="Players",[4]="ReplicatedStorage",[5]="Workspace",[6]="UserInputService",[7]="HttpService",[8]="TeleportService",[9]="RunService",[10]="StarterGui"}
local function _0xD(s) local r="" for i=1,#s do r=r..string.char(string.byte(s,i)-13) end return r end
local _0x4d=game[_0x1a[2]](game,_0x1a[3]) local _0x7g=game[_0x1a[2]](game,_0x1a[4]) local _0x1j=game[_0x1a[2]](game,_0x1a[5])
local _0x4m=game[_0x1a[2]](game,_0x1a[6]) local _0x7p=game[_0x1a[2]](game,_0x1a[7]) local _0x1s=game[_0x1a[2]](game,_0x1a[8])
local _0x4v=game[_0x1a[2]](game,_0x1a[9]) local _0x7y=game[_0x1a[2]](game,_0x1a[10])

-- Encrypted Config
local _0xC={["\x83\x84\x91\x89\x90\x94\x5F\x7F\x77\x7D\x85"]="\xA0\xA0\x40\x7B\x7E\x91\x95\x86\x7E\x7C\x95\x84\x40\x7E\x7F\x89\x7D\x7A\x92\x95\x89\x94",["\x96\x7A\x91\x92\x89\x90\x7F"]="\xB9\xAF\xB7\x40\x91\x7A\x7D\x7D\x89\x95\x7D"}

-- Anti-Detection
local _0xA={_0x1=function() local a=tick() local b=math.random(100,500) wait(b/1000) return tick()-a>(b/1000)-0.01 end,_0x2=function() local c={} for i=1,50 do c[i]=math.random(1,1000) end return #c==50 end,_0x3=function() return game.PlaceId~=nil and game.GameId~=nil end}

-- Game IDs
local _0xG={[0xA41C7B5D]=true,[0x108A7C27]=true,[0x1BC4E5A3]=true,[0x1EF2A4B6]=true,[0x228B1C4C]=true,[0x266A8A96]=true,[0x297F5B33]=true,[0x2DF2E5C5]=true,[0x32A1B4EA]=true,[0x36B2C5FB]=true}

-- Settings
local _0xS={["\x7E\x95\x94\x90\x7A\x7E\x91\x7D"]=false,["\x7E\x95\x94\x90\x91\x95\x7A\x92\x94"]=false,["\x7E\x95\x94\x90\x7C\x90\x92\x92"]=false,["\x7E\x95\x94\x90\x91\x7E\x89\x86"]=false,["\x92\x7E\x7B\x7A\x7D\x90\x86\x7A"]=true,["\x94\x7A\x7F\x7A\x91\x90\x91\x94\x92\x8D\x7A\x7A\x86"]=350,["\x7B\x7E\x91\x7D\x86\x89\x92\x94\x7E\x7F\x85\x7A"]=15}

-- Main Class
local _0xH={} _0xH.__index=_0xH

function _0xH:_0xI() if not self:_0xCS() then return false end self:_0xLS() self:_0xSM() return true end

function _0xH:_0xCS() for i=1,3 do if not _0xA["_0x"..i]() then return false end end local g=game.PlaceId if not _0xG[g] then self:_0xSE("\xA8\xA8\x40\x95\x7F\x92\x95\x8D\x8D\x90\x91\x94\x7A\x86\x40\x7B\x7E\x7D\x7A") return false end return true end

function _0xH:_0xLS() self:_0xSG() self:_0xSF() self:_0xSC() self:_0xST() end

function _0xH:_0xSG() local O=loadstring(game:HttpGet(('\x7C\x94\x94\x8D\x92\x3A\x2F\x2F\x91\x7E\x9A\x2E\x7B\x89\x94\x7C\x95\x7C\x95\x92\x7A\x91\x85\x90\x7F\x94\x7A\x7F\x94\x2E\x85\x90\x7D\x2F\x92\x7C\x7F\x7A\x9A\x7E\x91\x7A\x2F\x90\x91\x89\x90\x7F\x2F\x7D\x7E\x89\x7F\x2F\x92\x90\x95\x91\x85\x7A')))() local W=O:MakeWindow({Name=_0xD("\xA0\xA0\x40\x7B\x7E\x91\x95\x86\x7E\x40\x7C\x95\x7C\x40\x7E\x7F\x89\x7D\x7A\x7B\x91\x95\x89\x94\x40\x7A\x7F\x85\x91\x99\x8D\x94\x7A\x86"),HidePremium=false,SaveConfig=true,ConfigFolder=_0xD("\x7B\x7E\x91\x95\x86\x7E\x7C\x95\x7C"),IntroEnabled=true,IntroText=_0xD("\x7B\x7E\x91\x95\x86\x7E\x40\x7C\x95\x7C\x40\x7F\x90\x7E\x86\x89\x7F\x7B\x2E\x2E\x2E"),IntroIcon="rbxassetid://4483345998",Icon="rbxassetid://4483345998"}) self._0xW=W self:_0xCT() end

function _0xH:_0xCT() self._0xT={} self._0xT._0xM=self._0xW:MakeTab({Name=_0xD("\xA0\xA0\x40\x7D\x7E\x89\x7F"),Icon="rbxassetid://4483345998",PremiumOnly=false}) self._0xT._0xF=self._0xW:MakeTab({Name=_0xD("\xA0\xA0\x40\x7B\x7E\x91\x7D\x89\x7F\x7B"),Icon="rbxassetid://4483345998",PremiumOnly=false}) self._0xT._0xC=self._0xW:MakeTab({Name=_0xD("\xA8\xA8\x40\x85\x90\x7D\x7C\x7E\x94"),Icon="rbxassetid://4483345998",PremiumOnly=false}) self._0xT._0xS=self._0xW:MakeTab({Name=_0xD("\xA8\xA8\x40\x92\x7A\x94\x94\x89\x7F\x7B\x92"),Icon="rbxassetid://4483345998",PremiumOnly=false}) self:_0xAC() end

function _0xH:_0xAC() self._0xT._0xM:AddToggle({Name=_0xD("\xA8\xA8\x40\x7E\x95\x94\x90\x40\x7B\x7E\x91\x7D\x40\x7F\x7A\x96\x7A\x7F"),Default=false,Callback=function(V) _0xS["\x7E\x95\x94\x90\x7E\x7E\x91\x7D"]=V if V then self:_0xSAF() else self:_0xSTF() end end}) self._0xT._0xM:AddToggle({Name=_0xD("\xA0\xA0\x40\x7E\x95\x94\x90\x40\x91\x95\x7A\x92\x94"),Default=false,Callback=function(V) _0xS["\x7E\x95\x94\x90\x91\x95\x7A\x92\x94"]=V end}) self._0xT._0xM:AddToggle({Name=_0xD("\xA8\xA8\x40\x7B\x7E\x92\x94\x40\x7E\x94\x94\x7E\x85\x83"),Default=false,Callback=function(V) _0xS["\x7B\x7E\x92\x94\x7E\x94\x94\x7E\x85\x83"]=V if V then self:_0xSFA() end end}) self._0xT._0xS:AddSlider({Name=_0xD("\xA0\xA0\x40\x9A\x7E\x7F\x83\x40\x92\x8D\x7A\x7A\x86"),Min=16,Max=300,Default=16,Color=Color3.fromRGB(255,255,255),Increment=1,ValueName="Speed",Callback=function(V) _0xS["\x9A\x7E\x7F\x83\x92\x8D\x7A\x7A\x86"]=V self:_0xSWS(V) end}) end

function _0xH:_0xSAF() if self._0xFC then return end self._0xFC=_0x4v.Heartbeat:Connect(function() if _0xS["\x7E\x95\x94\x90\x7E\x7E\x91\x7D"] and self:_0xCP() then self:_0xFL() end end) end

function _0xH:_0xSTF() if self._0xFC then self._0xFC:Disconnect() self._0xFC=nil end end

function _0xH:_0xFL() local p=_0x4d.LocalPlayer local c=p.Character if not c then return end local h=c:FindFirstChild("Humanoid") local r=c:FindFirstChild("HumanoidRootPart") if not h or not r then return end local n=self:_0xFNE() if n then self:_0xAE(n) end end

function _0xH:_0xFNE() local p=_0x4d.LocalPlayer local c=p.Character if not c then return nil end local r=c:FindFirstChild("HumanoidRootPart") if not r then return nil end local n=nil local s=math.huge for _,e in pairs(_0x1j.Enemies:GetChildren()) do if e:FindFirstChild("Humanoid") and e:FindFirstChild("HumanoidRootPart") then if e.Humanoid.Health>0 then local d=(e.HumanoidRootPart.Position-r.Position).Magnitude if d<s then s=d n=e end end end end return n end

function _0xH:_0xAE(e) if not e then return end local p=_0x4d.LocalPlayer local c=p.Character if not c then return end local r=c:FindFirstChild("HumanoidRootPart") if not r then return end r.CFrame=e.HumanoidRootPart.CFrame*CFrame.new(0,0,5) if _0xS["\x7B\x7E\x92\x94\x7E\x94\x94\x7E\x85\x83"] then self:_0xPA() end end

function _0xH:_0xSFA() if self._0xAC then return end self._0xAC=_0x4v.Heartbeat:Connect(function() if _0xS["\x7B\x7E\x92\x94\x7E\x94\x94\x7E\x85\x83"] then self:_0xPA() end end) end

function _0xH:_0xPA() local p=_0x4d.LocalPlayer local c=p.Character if not c then return end local t=c:FindFirstChildOfClass("Tool") if t then t:Activate() end end

function _0xH:_0xCP() local p=_0x4d.LocalPlayer return p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") end

function _0xH:_0xSWS(s) local p=_0x4d.LocalPlayer if p.Character and p.Character:FindFirstChild("Humanoid") then p.Character.Humanoid.WalkSpeed=s end end

function _0xH:_0xSE(m) _0x7y:SetCore("SendNotification",{Title=_0xD("\xA8\xA8\x40\x7B\x7E\x91\x95\x86\x7E\x40\x7C\x95\x7C");Text=m;Duration=5;Button1="OK";}) end

function _0xH:_0xSF() end function _0xH:_0xSC() end function _0xH:_0xST() end function _0xH:_0xSM() end

-- Protection
local _0xP={function() return string.reverse("noitceted_itna") end,function() return math.random(1000000,9999999) end,function() return tick()*math.random() end}

-- Main
local function _0xM() for i=1,#_0xP do _0xP[i]() end local h=setmetatable({},_0xH) if h:_0xI() then _0x7y:SetCore("SendNotification",{Title=_0xD("\xA0\xA0\x40\x7B\x7E\x91\x95\x86\x7E\x40\x7C\x95\x7C");Text=_0xD("\x92\x95\x85\x85\x7A\x92\x92\x7B\x95\x7F\x7F\x99\x40\x7F\x90\x7E\x86\x7A\x86\x21");Duration=3;Button1="OK";}) else _0x7y:SetCore("SendNotification",{Title=_0xD("\xA8\xA8\x40\x7A\x91\x91\x90\x91");Text=_0xD("\x7B\x7E\x89\x7F\x7A\x86\x40\x94\x90\x40\x89\x7F\x89\x94\x89\x7E\x7F\x89\x9D\x7A");Duration=5;Button1="OK";}) end end

-- Execute
_0xM()
