--[[BloxFruit]]--
local placeId = game.PlaceId
if placeId == 2753915549 or placeId == 4442272183 or placeId == 7449423635 then
    BloxFruit = true
end
task.spawn(function()
     while task.wait() do
     end
end)
local placeId = game.PlaceId
if placeId == 2753915549 then
	OldWorld = true
elseif placeId == 4442272183 then
	TwoWorld = true
elseif placeId == 7449423635 then
	ThreeWorld = true
end
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
     Title = "N1 Hub",
     SubTitle = "by dawid",
     TabWidth = 180,
     Size = UDim2.fromOffset(580, 480),
     Acrylic = false,                        -- The blur may be detectable, setting this to false disables blur entirely
     Theme = "Dark",
     MinimizeKey = Enum.KeyCode.RightControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
     Main = Window:AddTab({ Title = "Main", Icon = "home" }),
     Automatic = Window:AddTab({ Title = "Automatic", Icon = "sword" }),
     Stats = Window:AddTab({ Title = "Stats", Icon = "rbxassetid://12966432749" }),
     Shop = Window:AddTab({ Title = "Shop", Icon = "rbxassetid://11432839196" }),
     Misc = Window:AddTab({ Title = "Miscellaneous", Icon = "rbxassetid://12974196824" }),
     Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
     Fluent:Notify({
          Title = "Notification",
          Content = "This is a notification",
          SubContent = "SubContent", -- Optional
          Duration = 5               -- Set to nil to make the notification not disappear
     })
end
local section = Tabs.Main:AddSection("AutoFarm")
local Toggle = Tabs.Main:AddToggle("MyToggle", { Title = "AutoFarm", Default = false })

Toggle:OnChanged(function(Value)
_G.AutoFarm = Value
_G.FastAttack = Value
_G.AUTOHAKI = Value
_G.AutoEquip = Value
     if _G.AutoEquip then
          while _G.AutoEquip do task.wait()
               EquipSelectedWeapon()
          end
     end
end)

Options.MyToggle:SetValue(false)

--------------------------------------------[[EquipTool]]--------------------------------------------

function EquipItem(itemName)
     local player = game:GetService("Players").LocalPlayer
     local backpack = player.Backpack
     local character = player.Character
     if backpack:FindFirstChild(itemName) then
          local tool = backpack:FindFirstChild(itemName)
          tool.Parent = character
     end
end

--------------------------------------------[[Teleport]]--------------------------------------------

function TP(A)
     game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = A
end


--------------------------------------------[[Bypass]]--------------------------------------------

function Bypass(C)
     if _G.AutoFarm then
          pcall(function()
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = C
               game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("SetSpawnPoint")
               game.Players.LocalPlayer.Character.Humanoid.Health = 0
          end)
     end
end

--------------------------------------------[[Tween]]--------------------------------------------

function Tween(P)
     Distance = (P.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
     Speed = 360
     game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear), { CFrame = P }):Play()
end

--TP(CFrame.new(0,0,0))

--------------------------------------------[[Automatic]]--------------------------------------------

local section = Tabs.Automatic:AddSection("AutoNewWorld")
local Toggle = Tabs.Automatic:AddToggle("MyToggle", {Title = "AutoDressrosa", Default = false })
Toggle:OnChanged(function(Value)
_G.newworld = Value
_G.FastAttack = Value
_G.AUTOHAKI = Value
_G.AutoEquip = Value
     if _G.AutoEquip then
          while _G.AutoEquip do task.wait()
               EquipSelectedWeapon()
          end
     end
end)
Options.MyToggle:SetValue(false)

local section = Tabs.Automatic:AddSection("Sword")
local Toggle = Tabs.Automatic:AddToggle("MyToggle", {Title = "Autosaber", Default = false })
Toggle:OnChanged(function(Value)
_G.Autosaber = Value
end)
Options.MyToggle:SetValue(false)

--------------------------------------------[[AutoNewWorld]]--------------------------------------------

function newworld()
     Monpos = CFrame.new(4853.37549, 4.78490591, 717.703979, -0.453972578, 0, 0.891015649, 0, 1, 0, -0.891015649, 0, -0.453972578)
     Doorpos = CFrame.new(1347.6958, 37.3493462, -1325.87463, 0.519068599, -7.70531372e-08, 0.854732573, 6.44183729e-08, 1, 5.10283336e-08, -0.854732573, 2.85732771e-08, 0.519068599)
     Setpoint = CFrame.new(4857.47705, 4.35001707, 751.836121, 0.515462339, 0, 0.856912255, 0, 1, 0, -0.856912255, 0, 0.515462339)
     QuestMonName = "Ice Admiral"
end

spawn(function()
     while task.wait() do
          if _G.newworld then
               newworld()
               if game.Players.localPlayer.Data.Level.Value >= 700 then
                    if (Setpoint.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1600 then
                         Tween(Setpoint)
                    else
                         Bypass(Setpoint)
                    end
                    if (Monpos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1600 then
                         Tween(Monpos)
                    else
                         Bypass(Monpos)
                    end
                    if (Monpos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                         wait(.5)
                         game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("DressrosaQuestProgress","Detective")
                    end
                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Key") then
                         EquipItem("Key")
                    end
                    if (Doorpos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1600 then
                         Tween(Doorpos)
                    else
                         Tween(Doorpos)
                    end
                    if workspace.Enemies:FindFirstChild(QuestMonName) then
                         for i, v in pairs(workspace.Enemies:GetChildren()) do
                              if v.Name == QuestMonName then
                                   repeat task.wait()
                                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0))
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
                                   until not game.workspace.Enemies:FindFirstChild(QuestMonName) or _G.newworld == false
                              end
                         end
                    end
                    wait(3)
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("DressrosaQuestProgress","Dressrosa")
               end
          end
     end
end)
--------------------------------------------[[AutoSaber]]--------------------------------------------
spawn(function()
     while task.wait() do
          if _G.Autosaber then
               pcall(function()
               Bypass(CFrame.new(-1338.24963, 10.9499998, 498.668518, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247))
               if game.Players.localPlayer.Data.Level.Value >= 200 then
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("ProQuestProgress","Plate",1)
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("ProQuestProgress","Plate",2)
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("ProQuestProgress","Plate",3)
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("ProQuestProgress","Plate",4)
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("ProQuestProgress","Plate",5)
               wait(.5)
               Tween(CFrame.new(-1611, 12, 163))
               wait(3)
               EquipItem("Torch")
                    end
               end)
          end
     end
end)
--------------------------------------------[[AutoFarm]]--------------------------------------------
function chacklevel()
     if OldWorld then
     local lv = game:GetService("Players").LocalPlayer.Data.Level.Value
          if lv == 1 or lv <= 9 then
               MonName = "Bandit"
               QuestName = "BanditQuest1"
               QuestNumber = 1
               Qusetpos = CFrame.new(1059.37183, 16.1412621, 1550.4231, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544)
               SETPOINT = CFrame.new(971.943237, 15.3500061, 1410.79272, -0.777145505, 0, -0.629321039, 0, 1, 0, 0.629321039, 0, -0.777145505)
               ChackMon1 = CFrame.new(1146.17273, 79.8013916, 1620.93518, 0.9853369, -0.0126142949, 0.170152977,1.76843817e-09, 0.997263253, 0.0739321262, -0.17061992, -0.0728480518, 0.982640326)
          elseif lv == 10 or lv <= 14 then
               MonName = "Monkey"
               QuestName = "JungleQuest"
               QuestNumber = 1
               Qusetpos = CFrame.new(-1599.3938, 36.8521271, 153.684219, 0.00384947564, 4.6458787e-08, -0.999992609,-7.18324884e-08, 1, 4.61826133e-08, 0.999992609, 7.16541777e-08, 0.00384947564)
               SETPOINT = CFrame.new(-1338.24963, 10.9499998, 498.668518, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
               ChackMon1 = CFrame.new(-1691, 76, -36)
          elseif lv == 15 or lv <= 29 then
               MonName = "Gorilla"
               QuestName = "JungleQuest"
               QuestNumber = 2
               Qusetpos = CFrame.new(-1599.3938, 36.8521271, 153.684219, 0.00384947564, 4.6458787e-08, -0.999992609,-7.18324884e-08, 1, 4.61826133e-08, 0.999992609, 7.16541777e-08, 0.00384947564)
               ChackMon1 = CFrame.new(-1230, 53, -486)
          elseif lv == 30 or lv <= 39 then
               MonName = "Pirate"
               QuestName = "BuggyQuest1"
               QuestNumber = 1
               Qusetpos = CFrame.new(-1141, 5, 3830)
               SETPOINT = CFrame.new(-1188.51257, 3.85003138, 3817.83667, 0.961273968, -0, -0.275594592, 0, 1, -0, 0.275594592, 0, 0.961273968)
               ChackMon1 = CFrame.new(-1122.01147, 43.0832977, 3946.65112, 0.969741166, -0.0109664053, -0.243889034,-5.26546751e-10, 0.998990595, -0.0449193493, 0.244135454, 0.0435601398, 0.968762279)
          elseif lv == 40 or lv <= 59 then
               MonName = "Brute"
               QuestName = "BuggyQuest1"
               QuestNumber = 2
               Qusetpos = CFrame.new(-1141, 5, 3830)
               ChackMon1 = CFrame.new(-1142.11475, 94.4409103, 4319.72559, 0.94916445, 2.49591583e-08, -0.314780563,4.2021564e-09, 1, 9.19615104e-08, 0.314780563, -8.86093545e-08, 0.94916445)
          elseif lv == 60 or lv <= 74 then
               MonName = "Desert Bandit"
               QuestName = "DesertQuest"
               QuestNumber = 1
               Qusetpos = CFrame.new(895.060303, 6.43846273, 4391.21973, -0.830971718, 1.46621311e-08, 0.556314647,4.32375984e-08, 1, 3.82285315e-08, -0.556314647, 5.58205393e-08, -0.830971718)
               SETPOINT = CFrame.new(914.938843, 2.48001194, 4113.36572, 0.275584042, 0, 0.961277127, 0, 1, 0, -0.961277127, 0, 0.275584042)
               ChackMon1 = CFrame.new(931.648438, 47.1649513, 4488.71191, 0.60872674, 0.0566120259, 0.791357577,-2.94627389e-09, 0.997450948, -0.0713554993, -0.793379962, 0.0434359983, 0.607175052)
          elseif lv == 75 or lv <= 89 then
               MonName = "Desert Officer"
               QuestName = "DesertQuest"
               QuestNumber = 2
               Qusetpos = CFrame.new(895.060303, 6.43846273, 4391.21973, -0.830971718, 1.46621311e-08, 0.556314647,4.32375984e-08, 1, 3.82285315e-08, -0.556314647, 5.58205393e-08, -0.830971718)
               ChackMon1 = CFrame.new(1613.95972, 27.0537624, 4379.07666, 0.997716486, -0.00235532317, 0.0675004795,7.81264886e-10, 0.999391794, 0.0348721929, -0.067541562, -0.0347925611, 0.997109652)
          elseif lv == 90 or lv <= 99 then
               MonName = "Snow Bandit"
               QuestName = "SnowQuest"
               QuestNumber = 1
               Qusetpos = CFrame.new(1388.11609, 87.2727661, -1297.76306, 0.099959746, -1.76551644e-08, -0.994991481,-5.50864954e-08, 1, -2.32781865e-08, 0.994991481, 5.7137477e-08, 0.099959746)
               SETPOINT = CFrame.new(1104.80469, 6.40137196, -1167.79077, -0.707134247, 0, -0.707079291, 0, 1, 0, 0.707079291, 0, -0.707134247)
               ChackMon1 = CFrame.new(1301.86926, 130.062057, -1387.86096, 0.472290128, 0.0315165818, -0.880879521,1.18503118e-09, 0.999360561, 0.0357556604, 0.881443143, -0.0168870464, 0.471988112)
          elseif lv == 100 or lv <= 119 then
               MonName = "Snowman"
               QuestName = "SnowQuest"
               QuestNumber = 2
               Qusetpos = CFrame.new(1388.11609, 87.2727661, -1297.76306, 0.099959746, -1.76551644e-08, -0.994991481,-5.50864954e-08, 1, -2.32781865e-08, 0.994991481, 5.7137477e-08, 0.099959746)
               ChackMon1 = CFrame.new(1184.17297, 193.148605, -1501.44678, 0.830079734, -0.0770583078, 0.55229491,-3.36578959e-10, 0.990406394, 0.138185307, -0.557644725, -0.114704818, 0.822116256)
          elseif lv == 120 or lv <= 149 then --149
               MonName = "Chief Petty Officer"
               QuestName = "MarineQuest2"
               QuestNumber = 1
               Qusetpos = CFrame.new(-5039.58643, 27.3500385, 4324.68018, 0, 0, -1, 0, 1, 0, 1, 0, 0)
               SETPOINT = CFrame.new(-4925.57178, 40.3500137, 4426.08594, 0.325602472, -0, -0.945506752, 0, 1, -0, 0.945506752, 0, 0.325602472)
               ChackMon1 = CFrame.new(-4927.87891, 65.28302, 3993.74365, -0.342275828, -0.0131828887, 0.939507067, 0.00894175656, 0.999810576, 0.0172866601, -0.939556956, 0.0143176485, -0.34209311)
               -- ChackMon2 = CFrame.new(-4691.47168, 97.7189941, 4489.3833, 0.946013093, -0.0095107723, 0.323988855, 8.63156768e-10, 0.999569416, 0.0293426029, -0.324128419, -0.0277584866, 0.945605755)
          elseif lv == 150 or lv <= 174 then
               MonName = "Sky Bandit"
               QuestName = "SkyQuest"
               QuestNumber = 1
               Qusetpos = CFrame.new(-4839.51562, 716.670715, -2619.4165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
               SETPOINT = CFrame.new(-4920.20996, 716.769897, -2640.80493, -0.777145505, 0, -0.629321039, 0, 1, 0, 0.629321039, 0, -0.777145505)
               ChackMon1 = CFrame.new(-5025.28809, 324.944153, -2828.59619, 0.983840168, 0.00266311644, -0.179029062,-1.32528294e-10, 0.999889374, 0.0148736835, 0.179048866, -0.0146333277, 0.983731329)
          elseif lv == 175 or lv <= 189 then --189
               MonName = "Dark Master"
               QuestName = "SkyQuest"
               QuestNumber = 2
               Qusetpos = CFrame.new(-4839.51562, 716.670715, -2619.4165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412,0, 0.866007268)
               ChackMon1 = CFrame.new(-5262.27832, 448.675323, -2258.97241, 0.910784543, 0.00164514664, -0.412878662,3.98000834e-11, 0.999992073, 0.00398454489, 0.412881941, -0.00362906209, 0.91077733)
          elseif lv == 190 or lv <= 209 then
               MonName = "Prisoner"
               QuestName = "PrisonerQuest"
               QuestNumber = 1
               Qusetpos = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935,0, 0.0175017118)
               SETPOINT = CFrame.new(4857.47705, 4.35001707, 751.836121, 0.515462339, 0, 0.856912255, 0, 1, 0, -0.856912255, 0, 0.515462339)
               ChackMon1 = CFrame.new(5266.19775, 46.4375458, 398.862366, -0.397015303, -0.05177157, 0.916350663,-9.64795688e-10, 0.998407841, 0.0564075969, -0.91781199, 0.0223946795, -0.396383196)
               -- ChackMon2 = CFrame.new(5011.80029, 66.2090912, 549.098083, -0.588193357, 0.0150756342, 0.808579803, -0.0103892582, 0.999602854, -0.0261947419, -0.808653593, -0.0238081161, -0.587803125)
          elseif lv == 210 or lv <= 249 then
               MonName = "Dangerous Prisoner"
               QuestName = "PrisonerQuest"
               QuestNumber = 2
               Qusetpos = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935,0, 0.0175017118)
               ChackMon1 = CFrame.new(5526.27539, 62.7830849, 509.754547, -0.749680758, 0.00813186448, -0.661749661,-2.69122696e-10, 0.999924481, 0.0122875031, 0.66179961, 0.00921170507, -0.749624193)
          elseif lv == 250 or lv <= 274 then
               MonName = "Toga Warrior"
               QuestName = "ColosseumQuest"
               QuestNumber = 1
               Qusetpos = CFrame.new(-1580.04688, 7.20000267, -2986.47559, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721,0, -0.515037298)
               SETPOINT = CFrame.new(-1393.33777, 6.38246346, -2836.24414, -0.999848366, 0, 0.017436387, 0, 1, 0, -0.017436387, 0, -0.999848366)
               ChackMon1 = CFrame.new(-1659.17102, 60.7238083, -2789.45776, 0.0239013676, 0.00780060515, 0.999683917,7.38685588e-12, 0.999969542, -0.00780283427, -0.999714315, 0.000186498408, 0.0239006393)
          elseif lv == 275 or lv <= 299 then
               MonName = "Gladiator"
               QuestName = "ColosseumQuest"
               QuestNumber = 2
               Qusetpos = CFrame.new(-1580.04688, 7.20000267, -2986.47559, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721,0, -0.515037298)
               ChackMon1 = CFrame.new(-1296, 10, -3256)
               -- ChackMon2 = CFrame.new(-1371.89587, 61.4580231, -3384.56689, -0.833319247, 0.0151263466, -0.552585065, 0.00835157745, 0.999855936, 0.0147753488, 0.552728951, 0.00769762555, -0.833325505)
          elseif lv == 300 or lv <= 324 then
               MonName = "Military Soldier"
               QuestName = "MagmaQuest"
               QuestNumber = 1
               Qusetpos = CFrame.new(-5313.37012, 11.2500095, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813,0, -0.499959469)
               SETPOINT = CFrame.new(-5224.17969, 7.75000763, 8469.65332, 0.139430404, 0, 0.990231931, 0, 1, 0, -0.990231931, 0, 0.139430404)
               ChackMon1 = CFrame.new(-5545.14307, 77.7244568, 8384.71094, -0.503312826, -0.101919658, 0.858072639,1.11266569e-08, 0.99301976, 0.117948338, -0.864104271, 0.0593649186, -0.49979955)
          elseif lv == 325 or lv <= 374 then
               MonName = "Military Spy"
               QuestName = "MagmaQuest"
               QuestNumber = 2
               Qusetpos = CFrame.new(-5313.37012, 11.2500095, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813,0, -0.499959469)
               ChackMon1 = CFrame.new(-5860.77539, 125.605713, 8841.04004, 0.123171583, 0.0166577231, -0.992245555,-1.65192332e-10, 0.999859095, 0.0167855378, 0.992385387, -0.00206750119, 0.12315423)
          elseif lv == 375 or lv <= 399 then
               MonName = "Fishman Warrior"
               QuestName = "FishmanQuest"
               QuestNumber = 1
               Qusetpos = CFrame.new(61121.2695, 18.8742752, 1564.8844, -0.913477898, 0, -0.406888306, 0, 1, 0, 0.406888306, 0, -0.913477898)
               Warp = CFrame.new(4050.31055, -1.68844795, -1814.12366, -0.215326533, 0, 0.976540387, 0, 1, 0, -0.976540387, 0, -0.215326533)
               ChackMon1 = CFrame.new(60933, 64, 1636)
          elseif lv == 400 or lv <= 449 then
               MonName = "Fishman Commando"
               QuestName = "FishmanQuest"
               QuestNumber = 2
               Qusetpos = CFrame.new(61121.2695, 18.8742752, 1564.8844, -0.913477898, 0, -0.406888306, 0, 1, 0, 0.406888306, 0, -0.913477898)
               Warp = CFrame.new(4050.31055, -1.68844795, -1814.12366, -0.215326533, 0, 0.976540387, 0, 1, 0, -0.976540387, 0, -0.215326533)
               ChackMon1 = CFrame.new(61912, 72, 1475)
          elseif lv == 450 or lv <= 474 then
               MonName = "God's Guard"
               QuestName = "SkyExp1Quest"
               QuestNumber = 1
               Qusetpos = CFrame.new(-4721.95215, 844.174683, -1949.24341, 0.996191859, -0, -0.0871884301, 0, 1, -0, 0.0871884301, 0, 0.996191859)
               SETPOINT = CFrame.new(-4920.20996, 716.769897, -2640.80493, -0.777145505, 0, -0.629321039, 0, 1, 0, 0.629321039, 0, -0.777145505)
               ChackMon1 = CFrame.new(-4707, 885, -1894)
          elseif lv == 475 or lv <= 524 then
               MonName = "Shanda"
               QuestName = "SkyExp1Quest"
               QuestNumber = 2
               Qusetpos = CFrame.new(-7858.44043, 5544.49023, -381.782959, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998)
               SETPOINT = CFrame.new(-7871.68555, 5544.58984, -333.27121, 0.777145445, 0, 0.629321039, 0, 1, 0, -0.629321039, 0, 0.777145445)
               ChackMon1 = CFrame.new(-7654, 5572, -491)
          elseif lv == 525 or lv <= 549 then
               MonName = "Royal Squad"
               QuestName = "SkyExp2Quest"
               QuestNumber = 1
               Qusetpos = CFrame.new(-7904.68457, 5634.66113, -1409.96729, 0, 0, -1, 0, 1, 0, 1, 0, 0)
               SETPOINT = CFrame.new(-7871.68555, 5544.58984, -333.27121, 0.777145445, 0, 0.629321039, 0, 1, 0, -0.629321039, 0, 0.777145445)
               ChackMon1 = CFrame.new(-7600, 5647, -1444)
          elseif lv == 550 or lv <= 624 then
               MonName = "Royal Soldier"
               QuestName = "SkyExp2Quest"
               QuestNumber = 2
               Qusetpos = CFrame.new(-7904.68457, 5634.66113, -1409.96729, 0, 0, -1, 0, 1, 0, 1, 0, 0)
               SETPOINT = CFrame.new(-7871.68555, 5544.58984, -333.27121, 0.777145445, 0, 0.629321039, 0, 1, 0, -0.629321039, 0, 0.777145445)
               ChackMon1 = CFrame.new(-7797, 5652, -1761)
          elseif lv == 625 or lv <= 649 then
               MonName = "Galley Pirate"
               QuestName = "FountainQuest"
               QuestNumber = 1
               Qusetpos = CFrame.new(5259.77051, 37.7125168, 4050.0249, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
               SETPOINT = CFrame.new(5193.83838, 37.600029, 4145.69922, 0.515462339, 0, 0.856912255, 0, 1, 0, -0.856912255, 0, 0.515462339)
               ChackMon1 = CFrame.new(5554, 69, 3983)
          elseif lv == 650 or lv <= 699 then
               MonName = "Galley Captain"
               QuestName = "FountainQuest"
               QuestNumber = 2
               Qusetpos = CFrame.new(5259.77051, 37.7125168, 4050.0249, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
               SETPOINT = CFrame.new(5193.83838, 37.600029, 4145.69922, 0.515462339, 0, 0.856912255, 0, 1, 0, -0.856912255, 0, 0.515462339)
               ChackMon1 = CFrame.new(5581, 79, 4925)
          end
          if TwoWorld then
               if lv == 700 or lv <= 724 then
                    MonName = "Raider"
                    QuestName = "Area1Quest"
                    QuestNumber = 1
                    Qusetpos = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
                    SETPOINT = CFrame.new(-33.3725662, 28.3748226, 2762.01196, -0.990270376, 0, 0.13915664, 0, 1, 0, -0.13915664, 0, -0.990270376)
                    ChackMon1 = CFrame.new(-696, 93, 2376)
               elseif lv == 725 or lv <= 774 then
                    MonName = "Mercenary"
                    QuestName = "Area1Quest"
                    QuestNumber = 2
                    Qusetpos = CFrame.new(-429.417114, 72.1100006, 1836.21106, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
                    SETPOINT = CFrame.new(-33.3725662, 28.3748226, 2762.01196, -0.990270376, 0, 0.13915664, 0, 1, 0, -0.13915664, 0, -0.990270376)
                    ChackMon1 = CFrame.new(-1021, 153, 1391)
               elseif lv == 775 or lv <= 799 then
                    MonName = ""
                    QuestName = ""
                    QuestNumber = 1
                    Qusetpos = CFrame.new()
                    SETPOINT = CFrame.new()
                    ChackMon1 = CFrame.new()
               elseif lv == 800 or lv <= 874 then
                    MonName = ""
                    QuestName = ""
                    QuestNumber = 1
                    Qusetpos = CFrame.new()
                    SETPOINT = CFrame.new()
                    ChackMon1 = CFrame.new()
               elseif lv == 875 or lv <= 899 then
                    MonName = ""
                    QuestName = ""
                    QuestNumber = 1
                    Qusetpos = CFrame.new()
                    SETPOINT = CFrame.new()
                    ChackMon1 = CFrame.new()
               elseif lv == 900 or lv <= 949 then
                    MonName = ""
                    QuestName = ""
                    QuestNumber = 1
                    Qusetpos = CFrame.new()
                    SETPOINT = CFrame.new()
                    ChackMon1 = CFrame.new()
               end
          end
     end
end

---4627.80518, 848.034973, -1706.73511, 0.890994847, 0, 0.454013437, 0, 1, 0, -0.454013437, 0, 0.890994847


spawn(function()
     while task.wait() do
          if _G.AutoFarm then
               pcall(function()
                    chacklevel()
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                         if (Qusetpos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 2000 then
                              wait(.5)
                              Tween(Qusetpos)
                         else
                              wait(3)
                              Bypass(SETPOINT)
                         end
                         if (Qusetpos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 then
                              wait(.5)
                              game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("StartQuest", QuestName, QuestNumber)
                         end
                    elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                         if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, MonName) then
                              if workspace.Enemies:FindFirstChild(MonName) then
                                   for i, v in pairs(workspace.Enemies:GetChildren()) do
                                        if v.Name == MonName then
                                             repeat task.wait()
                                                  Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0))
                                                  v.Humanoid.WalkSpeed = 0
                                                  v.Humanoid.JumpPower = 0
                                                  v.HumanoidRootPart.CanCollide = false
                                                  v.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
                                             until game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false or v.Humanoid.Health <= 0 or not _G.AutoFarm or not game.workspace.Enemies:FindFirstChild(MonName)
                                        end
                                   end
                              else
                                   wait(.5)
                                   Tween(ChackMon1 * CFrame.new(math.random(-200, 200), 0, math.random(-200, 200)))
                              end
                         else
                              game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("AbandonQuest")
                         end
                    end
               end)
          end
     end
end)

coroutine.wrap(function()
     while task.wait() do
          if _G.AutoFarm then
               pcall(function()
                    chacklevel()
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                         wait(5)
                         if (Warp.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 2000 then
                              task.wait(.5)
                              Tween(Warp)
                         else
                              task.wait(.5)
                              Tween(Warp)
                         end
                         if (Qusetpos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 then
                              wait(.5)
                              game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("StartQuest", QuestName, QuestNumber)
                         end
                    elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                         if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, MonName) then
                              if workspace.Enemies:FindFirstChild(MonName) then
                                   for i, v in pairs(workspace.Enemies:GetChildren()) do
                                        if v.Name == MonName then
                                             repeat task.wait()
                                                  Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0))
                                                  v.Humanoid.WalkSpeed = 0
                                                  v.Humanoid.JumpPower = 0
                                                  v.HumanoidRootPart.CanCollide = false
                                                  v.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
                                             until game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false or v.Humanoid.Health <= 0 or not _G.AutoFarm or not game.workspace.Enemies:FindFirstChild(MonName)
                                        end
                                   end
                              else
                                   task.wait(.5)
                                   Tween(ChackMon1 * CFrame.new(math.random(-160, 160), 0, math.random(-160, 160)))
                              end
                         else
                              game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("AbandonQuest")
                         end
                    end
               end)
          end
     end
end)()

--------------------------------------------[[์Noclip]]--------------------------------------------

coroutine.wrap(function()
     while task.wait() do
          pcall(function()
               if _G.AutoFarm or _G.Autosaber or _G.newworld then
                    if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                        local Noclip = Instance.new("BodyVelocity")
                        Noclip.Name = "BodyClip"
                        Noclip.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                        Noclip.MaxForce = Vector3.new(10000000,10000000,10000000)
                        Noclip.Velocity = Vector3.new(0,0,0)
                    end
                else
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
                end
          end)
     end
end)()
coroutine.wrap(function()
     while task.wait() do
          pcall(function()
               if _G.AutoFarm or _G.Autosaber or _G.newworld then
                    for _, character in ipairs(game.Players:GetPlayers()) do
                         if character and character.Character then
                              for _, part in ipairs(character.Character:GetDescendants()) do
                                   if part:IsA("BasePart") then
                                   part.CanCollide = false
                                   elseif part:IsA("MeshPart") then
                                        part.CanCollide = false
                                   elseif part:IsA("Part") then
                                        part.CanCollide = false
                                   elseif part:IsA("Grass") then
                                        part.CanCollide = false
                                   elseif part:IsA("Lava") then
                                        part.CanCollide = false
                                   end
                              end
                         end
                    end
               end
          end)
     end
end)()

--------------------------------------------[[BringMob]]--------------------------------------------

coroutine.wrap(function()
     while task.wait() do
          pcall(function()
               if _G.AutoFarm then
                    chacklevel()
                         pcall(function()
                              for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                   for x,y in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                        if v.Name == MonName and y.Name == MonName then
                                        v.HumanoidRootPart.CFrame = y.HumanoidRootPart.CFrame
                                        y.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        y.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.HumanoidRootPart.CanCollide = false
                                        y.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.CanQuery = false
                                        y.HumanoidRootPart.CanQuery = false
                                        v.HumanoidRootPart.CanTouch = false
                                        y.HumanoidRootPart.CanTouch = false
                                        v.Humanoid.WalkSpeed = 0
                                        y.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                        y.Humanoid.JumpPower = 0
                                        if sethiddenproperty then
                                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                        end
                                   end
                              end
                         end
                    end)
               end
          end)
     end
end)()


coroutine.wrap(function()
     while task.wait() do
          pcall(function()
               if _G.AutoFarm then
                    chacklevel()
                    for i, v in pairs(workspace.Enemies:GetChildren()) do
                         if v.Name == MonName then
                              if v.Humanoid.Health == 0 then
                                   v:Destroy()
                              end
                         end
                    end
               end
          end)
     end
end)()

--------------------------------------------[[FastAttack]]--------------------------------------------

_G.FastAttackType = "Fast"

local ExamList = {}
for i = 1, 2 do
     for i = 1, 20 do
          table.insert(ExamList, "Option " .. i)
     end
     local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
     local CombatFrameworkR = getupvalues(CombatFramework)[2]
     local RigController = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
     local RigControllerR = getupvalues(RigController)[2]
     local realbhit = require(game.ReplicatedStorage.CombatFramework.RigLib)
     local cooldownfastattack = tick()

     function CurrentWeapon()
          local ac = CombatFrameworkR.activeController
          local ret = ac.blades[1]
          if not ret then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
          pcall(function()
               while ret.Parent ~= game.Players.LocalPlayer.Character do ret = ret.Parent end
          end)
          if not ret then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
          return ret
     end

     function getAllBladeHitsPlayers(Sizes)
          local Hits = {}
          local Client = game.Players.LocalPlayer
          local Characters = game:GetService("Workspace").Characters:GetChildren()
          for i = 1, #Characters do
               local v = Characters[i]
               local Human = v:FindFirstChildOfClass("Humanoid")
               if v.Name ~= game.Players.LocalPlayer.Name and Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes + 5 then
                    table.insert(Hits, Human.RootPart)
               end
          end
          return Hits
     end

     function getAllBladeHits(Sizes)
          local Hits = {}
          local Client = game.Players.LocalPlayer
          local Enemies = game:GetService("Workspace").Enemies:GetChildren()
          for i = 1, #Enemies do
               local v = Enemies[i]
               local Human = v:FindFirstChildOfClass("Humanoid")
               if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes + 5 then
                    table.insert(Hits, Human.RootPart)
               end
          end
          return Hits
     end

     function AttackFunction()
          local ac = CombatFrameworkR.activeController
          if ac and ac.equipped then
               for indexincrement = 1, 1 do
                    local bladehit = getAllBladeHits(50)
                    if #bladehit > 0 then
                         local AcAttack8 = debug.getupvalue(ac.attack, 5)
                         local AcAttack9 = debug.getupvalue(ac.attack, 6)
                         local AcAttack7 = debug.getupvalue(ac.attack, 4)
                         local AcAttack10 = debug.getupvalue(ac.attack, 7)
                         local NumberAc12 = (AcAttack8 * 798405 + AcAttack7 * 727595) % AcAttack9
                         local NumberAc13 = AcAttack7 * 798405
                         (function()
                              NumberAc12 = (NumberAc12 * AcAttack9 + NumberAc13) % 1099511627776
                              AcAttack8 = math.floor(NumberAc12 / AcAttack9)
                              AcAttack7 = NumberAc12 - AcAttack8 * AcAttack9
                         end)()
                         AcAttack10 = AcAttack10 + 1
                         debug.setupvalue(ac.attack, 5, AcAttack8)
                         debug.setupvalue(ac.attack, 6, AcAttack9)
                         debug.setupvalue(ac.attack, 4, AcAttack7)
                         debug.setupvalue(ac.attack, 7, AcAttack10)
                         for k, v in pairs(ac.animator.anims.basic) do
                              v:Play(0.1, 0.5, 0.2, 0.8)
                         end
                         if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] then
                              game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",
                                   tostring(CurrentWeapon()))
                              game.ReplicatedStorage.Remotes.Validator:FireServer(
                              math.floor(NumberAc12 / 1099511627776 * 16777215), AcAttack10)
                              game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "")
                         end
                    end
               end
          end
     end

     coroutine.wrap(function()
          while task.wait(.1) do
               local ac = CombatFrameworkR.activeController
               if ac and ac.equipped then
                    if _G.FastAttack then
                         AttackFunction()
                         if _G.FastAttackType == "Fast" then
                              if tick() - cooldownfastattack < task.wait() then task.wait() cooldownfastattack = tick()
                              end
                         elseif _G.FastAttackType == "Normal" then
                              if tick() - cooldownfastattack > 3 then task.wait(.3) cooldownfastattack = tick()
                              end
                         elseif _G.FastAttackType == "Safety" then
                              if tick() - cooldownfastattack > .5 then wait(.3) cooldownfastattack = tick()
                              end
                         end
                    elseif _G.FastAttack == false then
                    else
                         CombatFrameworkR.activeController:Destroy()
                         if ac.hitboxMagnitude ~= 40 then
                              ac.hitboxMagnitude = 40
                         end
                         ac:attack()
                    end
               end
          end
     end)()
end
coroutine.wrap(function()
     while task.wait() do
          if _G.AUTOHAKI then
               if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
               end
          end
     end
end)()

--------------------------------------------[[SelectWeapon]]--------------------------------------------

Weapon = {
     "Melee",
     "Sword",
     "BloxFruit"
}

coroutine.wrap(function()
     while wait() do
          pcall(function()
               if SelectWeapon == "Melee" then
                    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                         if v.ToolTip == "Melee" then
                              if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                                   _G.Settings.Configs["Select Weapon"] = v.Name
                              end
                         end
                    end
               elseif SelectWeapon == "Sword" then
                    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                         if v.ToolTip == "Sword" then
                              if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                                   _G.Settings.Configs["Select Weapon"] = v.Name
                              end
                         end
                    end
               elseif SelectWeapon == "Fruit" then
                    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                         if v.ToolTip == "Blox Fruit" then
                              if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                                   _G.Settings.Configs["Select Weapon"] = v.Name
                              end
                         end
                    end
               else
                    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                         if v.ToolTip == "Melee" then
                              if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                                   _G.Settings.Configs["Select Weapon"] = v.Name
                              end
                         end
                    end
               end
          end)
     end
end)()




local Dropdown = Tabs.Main:AddDropdown("Dropdown", {
     Title = "SelectWeapon",
     Values = Weapon,
     Multi = false,
     Default = 1,
})

Dropdown:SetValue()

Dropdown:OnChanged(function(Value)
     SelectWeapon = Value
end)


function EquipSelectedWeapon()
     if not SelectWeapon then
          warn("Please select a weapon.")
          return
     end
     for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
          if tool:IsA("Tool") and tool.ToolTip == SelectWeapon then
               local humanoid = game.Players.LocalPlayer.Character and
               game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
               if humanoid then
                    humanoid:EquipTool(tool)
                    print("Equipped weapon:", tool.Name)
               else
                    warn("Unable to find humanoid.")
               end
               return
          end
     end
end
--------------------------------------------[[Redeemcode]]--------------------------------------------

Tabs.Main:AddButton({
     Title = "RedeemAllCode",
     Callback = function()
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("TRIPLEABUSE")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("SEATROLLING")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("24NOADMIN")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("REWARDFUN")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("NEWTROLL")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("SECRET_ADMIN")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("KITT_RESET")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("CHANDLER")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("Sub2CaptainMaui")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("kittgaming")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("Sub2Fer999")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("Enyu_is_Pro")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("Magicbus")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("JCWK")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("Starcodeheo")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("Bluxxy")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("fudd10_v2")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("SUB2GAMERROBOT_EXP1")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("SUB2GAMERROBOT_RESET1")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("Sub2UncleKizaru")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("Axiore")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("Sub2Daigrock")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("Bignews")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("Sub2NoobMaster123")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("StrawHatMaine")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("TantaiGaming")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("Fudd10")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("TheGreatAce")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("Sub2OfficialNoobie")
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem"):InvokeServer("krazydares")
     end
})

--------------------------------------------[[AutoCombat]]--------------------------------------------

local section = Tabs.Main:AddSection("AutoCombat")
local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "AutoSuperHuman", Default = false })

Toggle:OnChanged(function(Value)
     Superhuman = Value
     if Value then
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
     end
end)
Options.MyToggle:SetValue(false)

local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "AutoSuperHuman [Full]", Default = false })

Toggle:OnChanged(function(Value)
     SuperhumanFull = Value
end)
Options.MyToggle:SetValue(false)

local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "AutoDeathStep", Default = false })

Toggle:OnChanged(function(Value)
     DeathStep = Value
     if Value then
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
     end
end)
Options.MyToggle:SetValue(false)

local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "AutoDargonTalon", Default = false })

Toggle:OnChanged(function(Value)
     DargonTalon = Value
     if Value then
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
     end
end)
Options.MyToggle:SetValue(false)

local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "AutoElectricClow", Default = false })

Toggle:OnChanged(function(Value)
     Electricclow = Value
     if Value then
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
     end
end)
Options.MyToggle:SetValue(false)


coroutine.wrap(function()
     while task.wait() do
          if Superhuman or SuperhumanFull and game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then 
               if game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") or game.Players.LocalPlayer.Character:FindFirstChild("Combat") then
                    local args = {
                         [1] = "BuyElectro"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
               end
               if game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") or game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman") then
                    SelectToolWeapon = "Superhuman"
               end
               if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value <= 299  then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
               end
               if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value <= 299  then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
               end
               if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate").Level.Value <= 299  then
                    SelectToolWeapon = "Fishman Karate"
               end
               if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value <= 299  then
                    SelectToolWeapon = "Dragon Claw"
               end
               if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 300  then
                    local args = {
                         [1] = "BuyFishmanKarate"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
               end
               if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 300  then
                    local args = {
                         [1] = "BuyFishmanKarate"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
               end
               if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 100  then
                    local args = {
                         [1] = "BuyBlackLeg"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
               end
               if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 300  then
                    local args = {
                         [1] = "BuyBlackLeg"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
               end
               if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate").Level.Value >= 300  then
                    if SuperhumanFull and game.Players.LocalPlayer.Data.Fragments.Value < 1500 then
                         if game.Players.LocalPlayer.Data.Level.Value > 1100 then
                              RaidsSelected = "Flame"
                              AutoRaids = true
                              RaidsArua = true
                         end
                    else
                         AutoRaids = false
                         RaidsArua = false
                         local args = {
                              [1] = "BlackbeardReward",
                              [2] = "DragonClaw",
                              [3] = "2"
                         }
                         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                    end
               end
               if game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate").Level.Value >= 300  then
                    if SuperhumanFull and game.Players.LocalPlayer.Data.Fragments.Value < 1500 then
                         if game.Players.LocalPlayer.Data.Level.Value > 1100 then
                              RaidsSelected = "Flame"
                              AutoRaids = true
                              RaidsArua = true
                         end
                    else
                         AutoRaids = false
                         RaidsArua = false
                         local args = {
                              [1] = "BlackbeardReward",
                              [2] = "DragonClaw",
                              [3] = "2"
                         }
                         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                    end
               end
               if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value >= 300  then
                    local args = {
                         [1] = "BuySuperhuman"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
               end
               if game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value >= 300  then
                    local args = {
                         [1] = "BuySuperhuman"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
               end
          end
          if DeathStep and game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
               if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 400 then
                    local args = {
                         [1] = "BuyDeathStep"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                    SelectToolWeapon = "Death Step"
               end  
               if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 400 then
                    local args = {
                         [1] = "BuyDeathStep"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                    
                    SelectToolWeapon = "Death Step"
               end  
               if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value < 400 then
                    SelectToolWeapon = "Black Leg"
               end 
          end
          if DargonTalon and game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
               if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value <= 399 and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
                    SelectToolWeapon = "Dragon Claw"
               end
               if game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value <= 399 and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
                    SelectToolWeapon = "Dragon Claw"
               end

               if game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value >= 400 and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
                    SelectToolWeapon = "Dragon Claw"
                    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 3 then
                         local string_1 = "Bones";
                         local string_2 = "Buy";
                         local number_1 = 1;
                         local number_2 = 1;
                         local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                         Target:InvokeServer(string_1, string_2, number_1, number_2);

                         local string_1 = "BuyDragonTalon";
                         local bool_1 = true;
                         local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                         Target:InvokeServer(string_1, bool_1);
                    elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 1 then
                         game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon")
                    else
                         local string_1 = "BuyDragonTalon";
                         local bool_1 = true;
                         local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                         Target:InvokeServer(string_1, bool_1);
                         local string_1 = "BuyDragonTalon";
                         local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                         Target:InvokeServer(string_1);
                    end 
               end
          end
          if Electricclow and game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
               if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value < 400 then
                    SelectToolWeapon = "Electro"
               end  
               if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value < 400 then
                    SelectToolWeapon = "Electro"
               end  
               if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 400 then
                    local v175 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw", true);
                    if v175 == 4 then
                         local v176 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start");
                         if v176 == nil then
                              game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-12548, 337, -7481)
                         end
                    else
                         local string_1 = "BuyElectricClaw";
                         local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                         Target:InvokeServer(string_1);
                    end
               end
               if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 400 then
                    local v175 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw", true);
                    if v175 == 4 then
                         local v176 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start");
                         if v176 == nil then
                              game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-12548, 337, -7481)
                         end
                    else
                         local string_1 = "BuyElectricClaw";
                         local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                         Target:InvokeServer(string_1);
                    end
               end
          end
     end
end)()

--------------------------------------------[[AutoStats]]--------------------------------------------

local Toggle = Tabs.Stats:AddToggle("MyToggle", { Title = "Melee", Default = false })
Toggle:OnChanged(function(Value)
_G.Melee = Value
     for i = 1, 500 do
          while _G.Melee do
               task.wait()
               game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(
               "AddPoint", "Melee", point)
          end
     end
end)
Options.MyToggle:SetValue(false)

local Toggle = Tabs.Stats:AddToggle("MyToggle", { Title = "Defense", Default = false })

Toggle:OnChanged(function(Value)
_G.Defense = Value
     for i = 1, 500 do
          while _G.Defense do
               task.wait()
               game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(
               "AddPoint", "Defense", point)
          end
     end
end)
Options.MyToggle:SetValue(false)

local Toggle = Tabs.Stats:AddToggle("MyToggle", { Title = "Sword", Default = false })
Toggle:OnChanged(function(Value)
_G.Sword = Value
     while _G.Sword do
          task.wait()
          for i = 1, 500 do
               game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("AddPoint", "Sword", point)
          end
     end
end)
Options.MyToggle:SetValue(false)

local Toggle = Tabs.Stats:AddToggle("MyToggle", { Title = "Gun", Default = false })
Toggle:OnChanged(function(Value)
_G.Gun = Value
     while _G.Gun do
          task.wait()
          for i = 1, 500 do
               game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("AddPoint", "Gun", point)
          end
     end
end)
Options.MyToggle:SetValue(false)

local Toggle = Tabs.Stats:AddToggle("MyToggle", { Title = "BloxFruit", Default = false })
Toggle:OnChanged(function(Value)
_G.BloxFruit = Value
     while _G.BloxFruit do
          task.wait()
          for i = 1, 500 do
               game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("AddPoint", "Demon Fruit", point)
          end
     end
end)
Options.MyToggle:SetValue(false)

local Slider = Tabs.Stats:AddSlider("Slider", {
     Title = "Point",
     Default = 10,
     Min = 1,
     Max = 100,
     Rounding = 0,
     Callback = function(Value)
          point = Value
     end
})
Slider:SetValue(10)

--------------------------------------------[[Shop]]--------------------------------------------

local section = Tabs.Shop:AddSection("CombatStore")
Tabs.Shop:AddButton({
     Title = "BuyBlackLeg",
     Description = "Buy BuyBlackLeg 150,000 Beli",
     Callback = function()
     game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("BuyBlackLeg")
     end
})
Tabs.Shop:AddButton({
     Title = "BuyElectro",
     Description = "Buy BuyElectro 500,000 Beli",
     Callback = function()
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("BuyElectro")
     end
})

--------------------------------------------[[Misc]]--------------------------------------------

Tabs.Misc:AddButton({
     Title = "EastBlue",
     Description = "Teleport You To EastBlue",
     Callback = function()
          Window:Dialog({
               Title = "Are You Sure?",
               Content = "Teleport You To EastBlue",
               Buttons = {
                    {
                         Title = "Yes!",
                         Callback = function()
                              game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
                         end
                    },
                    {
                         Title = "No!",
                         Callback = function()
                              warn("FuckYou")
                         end
                    }
               }
          })
     end
})
Tabs.Misc:AddButton({
     Title = "Dressrosa",
     Description = "Teleport You To Dressrosa",
     Callback = function()
          Window:Dialog({
               Title = "Are You Sure?",
               Content = "Teleport You To Dressrosa",
               Buttons = {
                    {
                         Title = "Yes!",
                         Callback = function()
                              game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                         end
                    },
                    {
                         Title = "No!",
                         Callback = function()
                              warn("FuckYou")
                         end
                    }
               }
          })
     end
})
Tabs.Misc:AddButton({
     Title = "Zou",
     Description = "Teleport You To Zou",
     Callback = function()
          Window:Dialog({
               Title = "Are You Sure?",
               Content = "Teleport You To Zou",
               Buttons = {
                    {
                         Title = "Yes!",
                         Callback = function()
                              game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
                         end
                    },
                    {
                         Title = "No!",
                         Callback = function()
                              warn("FuckYou")
                         end
                    }
               }
          })
     end
})
--------------------------------------------[[Setting]]--------------------------------------------
Tabs.Settings:AddButton({
     Title = "Rejoin",
     Description = "",
     Callback = function()
          game.Players.LocalPlayer:Kick(" Rejoining ...")
          local ts = game:GetService("TeleportService")
          local p = game:GetService("Players").LocalPlayer
          ts:Teleport(game.PlaceId, p)
     end
})
Tabs.Settings:AddButton({
     Title = "FpsBoots",
     Description = "",
     Callback = function()
          local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
          local g = game
          local w = g.Workspace
          local l = g.Lighting
          local t = w.Terrain
          sethiddenproperty(l, "Technology", 2)
          sethiddenproperty(t, "Decoration", false)
          t.WaterWaveSize = 0
          t.WaterWaveSpeed = 0
          t.WaterReflectance = 0
          t.WaterTransparency = 0
          l.GlobalShadows = 0
          l.FogEnd = 9e9
          l.Brightness = 0
          settings().Rendering.QualityLevel = "Level01"
          for i, v in pairs(w:GetDescendants()) do
               if v:IsA("BasePart") and not v:IsA("MeshPart") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
               elseif (v:IsA("Decal") or v:IsA("Texture")) and decalsyeeted then
                    v.Transparency = 1
               elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Lifetime = NumberRange.new(0)
               elseif v:IsA("Explosion") then
                    v.BlastPressure = 1
                    v.BlastRadius = 1
               elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                    v.Enabled = false
               elseif v:IsA("MeshPart") and decalsyeeted then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                    v.TextureID = 10385902758728957
               elseif v:IsA("SpecialMesh") and decalsyeeted then
                    v.TextureId = 0
               elseif v:IsA("ShirtGraphic") and decalsyeeted then
                    v.Graphic = 0
               elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
                    v[v.ClassName .. "Template"] = 0
               end
          end
          for i = 1, #l:GetChildren() do
               e = l:GetChildren()[i]
               if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                    e.Enabled = false
               end
          end
          w.DescendantAdded:Connect(function(v)
               wait() --prevent errors and shit
               if v:IsA("BasePart") and not v:IsA("MeshPart") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
               elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                    v.Transparency = 1
               elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Lifetime = NumberRange.new(0)
               elseif v:IsA("Explosion") then
                    v.BlastPressure = 1
                    v.BlastRadius = 1
               elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                    v.Enabled = false
               elseif v:IsA("MeshPart") and decalsyeeted then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                    v.TextureID = 10385902758728957
               elseif v:IsA("SpecialMesh") and decalsyeeted then
                    v.TextureId = 0
               elseif v:IsA("ShirtGraphic") and decalsyeeted then
                    v.ShirtGraphic = 0
               elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
                    v[v.ClassName .. "Template"] = 0
               end
         end)
     end
})
-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()

repeat wait() until game.CoreGui:FindFirstChild('RobloxPromptGui')
 
local lp,po,ts = game:GetService('Players').LocalPlayer,game.CoreGui.RobloxPromptGui.promptOverlay,game:GetService('TeleportService')
 
po.ChildAdded:connect(function(a)
     if a.Name == 'ErrorPrompt' then
          repeat
               ts:Teleport(game.PlaceId)
               wait(2)
          until false
     end
end)
