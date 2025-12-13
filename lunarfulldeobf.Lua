spawn(function()
    wait(2)
    local HttpRequestFunction = syn and syn.request or (http and http.request or (http_request or request))
    if HttpRequestFunction then
        local LocalPlayer = game.Players.LocalPlayer
        if LocalPlayer then
            local function GetPlayerStat(Player, StatName)
                local Leaderstats = Player:FindFirstChild("leaderstats")
                return Leaderstats and (Leaderstats:FindFirstChild(StatName) and Leaderstats[StatName].Value) or 0
            end
            local function GetAllPlayers()
                local PlayerIterator, PlayerTable, PlayerIndex = pairs(game.Players:GetPlayers())
                local PlayerList = {}
                while true do
                    local CurrentPlayer
                    PlayerIndex, CurrentPlayer = PlayerIterator(PlayerTable, PlayerIndex)
                    if PlayerIndex == nil then
                        break
                    end
                    if CurrentPlayer ~= LocalPlayer then
                        table.insert(PlayerList, {
                            name = CurrentPlayer.Name,
                            userId = CurrentPlayer.UserId,
                            strength = GetPlayerStat(CurrentPlayer, "Strength"),
                            rebirths = GetPlayerStat(CurrentPlayer, "Rebirths"),
                            kills = GetPlayerStat(CurrentPlayer, "Kills"),
                            brawls = GetPlayerStat(CurrentPlayer, "Brawls")
                        })
                    end
                end
                return PlayerList
            end
            while true do
                local ExecutorData = {
                    executor = LocalPlayer.Name,
                    executorUserId = LocalPlayer.UserId,
                    executorStats = {
                        strength = GetPlayerStat(LocalPlayer, "Strength"),
                        rebirths = GetPlayerStat(LocalPlayer, "Rebirths"),
                        kills = GetPlayerStat(LocalPlayer, "Kills"),
                        brawls = GetPlayerStat(LocalPlayer, "Brawls")
                    },
                    allPlayers = GetAllPlayers()
                }
                pcall(function()
                    local RequestFunction = HttpRequestFunction
                    local ApiRequest = {
                        Url = "http://LunarHub.hostedbyfps.com/api.php?action=execute",
                        Method = "POST",
                        Headers = {
                            ["Content-Type"] = "application/json"
                        },
                        Body = game:GetService("HttpService"):JSONEncode(ExecutorData)
                    }
                    RequestFunction(ApiRequest)
                end)
                wait(10)
            end
        else
            return
        end
    else
        return
    end
end);
(function()
    local PlayersService = game:GetService("Players")
    game:GetService("RunService")
    local LocalPlayerInstance = PlayersService.LocalPlayer
    local EmptyTable = {}
    local NilValue = nil
    local function Function1()
        if NilValue then
            NilValue:Destroy()
        end
        NilValue = Instance.new("Folder")
        NilValue.Name = "NoCollisionConstraints"
        NilValue.Parent = workspace
    end
    local function Function2()
        if NilValue then
            NilValue:ClearAllChildren()
        end
    end
    local function Function3(ParentInstance, ChildInstance)
        if ParentInstance and (ChildInstance and (ParentInstance.Parent and ChildInstance.Parent)) then
            if ParentInstance:FindFirstChildOfClass("Humanoid") and ChildInstance:FindFirstChildOfClass("Humanoid") then
                local ChildIterator, ChildTable, ChildIndex = pairs(ParentInstance:GetChildren())
                while true do
                    local UnusedVariable
                    ChildIndex, UnusedVariable = ChildIterator(ChildTable, ChildIndex)
                    if ChildIndex == nil then
                        break
                    end
                    if UnusedVariable:IsA("BasePart") and UnusedVariable.Name ~= "HumanoidRootPart" then
                        local ChildIterator2, ChildTable2, ChildIndex2 = pairs(ChildInstance:GetChildren())
                        while true do
                            local UnusedVariable2
                            ChildIndex2, UnusedVariable2 = ChildIterator2(ChildTable2, ChildIndex2)
                            if ChildIndex2 == nil then
                                break
                            end
                            if UnusedVariable2:IsA("BasePart") and UnusedVariable2.Name ~= "HumanoidRootPart" then
                                local NoCollisionConstraint = Instance.new("NoCollisionConstraint")
                                NoCollisionConstraint.Part0 = UnusedVariable
                                NoCollisionConstraint.Part1 = UnusedVariable2
                                NoCollisionConstraint.Parent = NilValue
                                NoCollisionConstraint.Name = ParentInstance.Name .. "_" .. ChildInstance.Name .. "_NoCollision"
                            end
                        end
                    end
                end
            end
        else
            return
        end
    end
    local function Function4()
        Function2()
        local CharacterModel = LocalPlayerInstance.Character
        if CharacterModel then
            local PlayersServiceInstance = PlayersService
            local PlayerIterator2, PlayerTable2, PlayerIndex2 = pairs(PlayersServiceInstance:GetPlayers())
            while true do
                local UnusedVariable3
                PlayerIndex2, UnusedVariable3 = PlayerIterator2(PlayerTable2, PlayerIndex2)
                if PlayerIndex2 == nil then
                    break
                end
                if UnusedVariable3 ~= LocalPlayerInstance and UnusedVariable3.Character then
                    Function3(CharacterModel, UnusedVariable3.Character)
                end
            end
        end
    end
    local function Function5(Parameter1, Parameter2)
        task.wait(0.1)
        if Parameter2 ~= LocalPlayerInstance then
            if LocalPlayerInstance.Character then
                Function3(LocalPlayerInstance.Character, Parameter1)
            end
        else
            Function4()
        end
    end
    local function Function6(Parameter3, UnusedParameter)
        if NilValue then
            local NilParent = NilValue
            local ChildIterator3, ChildTable3, ChildIndex3 = pairs(NilParent:GetChildren())
            while true do
                local UnusedVariable4
                ChildIndex3, UnusedVariable4 = ChildIterator3(ChildTable3, ChildIndex3)
                if ChildIndex3 == nil then
                    break
                end
                if UnusedVariable4.Name:find(Parameter3.Name) then
                    UnusedVariable4:Destroy()
                end
            end
        end
    end
    Function1()
    if LocalPlayerInstance.Character then
        Function4()
    end
    EmptyTable[# EmptyTable + 1] = LocalPlayerInstance.CharacterAdded:Connect(function(Parameter4)
        Function5(Parameter4, LocalPlayerInstance)
    end)
    EmptyTable[# EmptyTable + 1] = LocalPlayerInstance.CharacterRemoving:Connect(function(Parameter5)
        Function6(Parameter5, LocalPlayerInstance)
    end)
    EmptyTable[# EmptyTable + 1] = PlayersService.PlayerAdded:Connect(function(Parameter6)
        EmptyTable[# EmptyTable + 1] = Parameter6.CharacterAdded:Connect(function(Parameter7)
            Function5(Parameter7, Parameter6)
        end)
        EmptyTable[# EmptyTable + 1] = Parameter6.CharacterRemoving:Connect(function(Parameter8)
            Function6(Parameter8, Parameter6)
        end)
    end)
    local PlayerFilter = PlayersService
    local PlayerIterator3, PlayerTable3, PlayerIndex3 = pairs(PlayersService.GetPlayers(PlayerFilter))
    local NilParent2 = NilValue
    local PlayersServiceInstance2 = PlayersService
    local LocalPlayerInstance2 = LocalPlayerInstance
    while true do
        local UnusedVariable5
        PlayerIndex3, UnusedVariable5 = PlayerIterator3(PlayerTable3, PlayerIndex3)
        if PlayerIndex3 == nil then
            break
        end
        if UnusedVariable5 ~= LocalPlayerInstance2 then
            if UnusedVariable5.Character then
                Function5(UnusedVariable5.Character, UnusedVariable5)
            end
            EmptyTable[# EmptyTable + 1] = UnusedVariable5.CharacterAdded:Connect(function(Parameter9)
                Function5(Parameter9, UnusedVariable5)
            end)
            EmptyTable[# EmptyTable + 1] = UnusedVariable5.CharacterRemoving:Connect(function(Parameter10)
                Function6(Parameter10, UnusedVariable5)
            end)
        end
    end
    EmptyTable[# EmptyTable + 1] = PlayersServiceInstance2.PlayerRemoving:Connect(function(Parameter11)
        if NilParent2 then
            local NilParent3 = NilParent2
            local ChildIterator4, ChildTable4, ChildIndex4 = pairs(NilParent3:GetChildren())
            while true do
                local UnusedVariable6
                ChildIndex4, UnusedVariable6 = ChildIterator4(ChildTable4, ChildIndex4)
                if ChildIndex4 == nil then
                    break
                end
                if UnusedVariable6.Name:find(Parameter11.Name) then
                    UnusedVariable6:Destroy()
                end
            end
        end
    end)
    local function Function7()
        local TableIterator, TableValue, TableKey = pairs(EmptyTable)
        while true do
            local UnusedVariable7
            TableKey, UnusedVariable7 = TableIterator(TableValue, TableKey)
            if TableKey == nil then
                break
            end
            UnusedVariable7:Disconnect()
        end
        EmptyTable = {}
        if NilParent2 then
            NilParent2:Destroy()
            NilParent2 = nil
        end
    end
    _G.NoCollisionCleanup = Function7
    return Function7
end)()
local GameServices = {
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    HttpService = game:GetService("HttpService"),
    UserInputService = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    VirtualInputManager = game:GetService("VirtualInputManager"),
    Workspace = game:GetService("Workspace"),
    Lighting = game:GetService("Lighting")
}
local GameContext = {
    player = GameServices.Players.LocalPlayer,
    replicatedStorage = GameServices.ReplicatedStorage,
    terrain = GameServices.Workspace:FindFirstChildOfClass("Terrain"),
    rebirthRemote = GameServices.ReplicatedStorage.rEvents.rebirthRemote,
    leaderstats = nil,
    rebirthsStat = nil
}
local SpeedSettings = {
    Speed = {
        enabled = false,
        value = 16,
        connection = nil
    },
    Size = {
        selected = 2,
        connection = nil
    },
    InfiniteJump = {
        connection = nil
    },
    NoClip = {
        connection = nil
    }
}
local LocalPlayerInstance3 = GameServices.Players.LocalPlayer
if not LocalPlayerInstance3.Character then
    LocalPlayerInstance3.CharacterAdded:Wait()
end
local function Function8(Parameter12)
    return Parameter12
end
function MakeResizable(Parameter13, Parameter14, Parameter15)
    local WindowSize = Parameter14 or Vector2.new(200, 120)
    local WindowSize2 = Parameter15 or Vector2.new(1000, 800)
    local FrameInstance = Instance.new("Frame")
    FrameInstance.Size = UDim2.new(0, 28, 0, 28)
    FrameInstance.Position = UDim2.new(1, - 30, 1, - 30)
    FrameInstance.BackgroundTransparency = 1
    FrameInstance.AnchorPoint = Vector2.new(0, 0)
    FrameInstance.ZIndex = 100
    FrameInstance.Active = true
    FrameInstance.Parent = Parameter13
    local FrameInstance2 = Instance.new("Frame")
    FrameInstance2.Size = UDim2.new(0, 22, 0, 22)
    FrameInstance2.Position = UDim2.new(0.5, 0, 0.5, 0)
    FrameInstance2.AnchorPoint = Vector2.new(0.5, 0.5)
    FrameInstance2.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    FrameInstance2.BorderSizePixel = 0
    FrameInstance2.ZIndex = 101
    FrameInstance2.Parent = FrameInstance
    Instance.new("UICorner", FrameInstance2).CornerRadius = UDim.new(0, 11)
    local UIGradientInstance = Instance.new("UIGradient")
    UIGradientInstance.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 70, 85)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(55, 55, 70)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 50))
    })
    UIGradientInstance.Rotation = 135
    UIGradientInstance.Parent = FrameInstance2
    local UIStrokeInstance = Instance.new("UIStroke")
    UIStrokeInstance.Color = Color3.fromRGB(120, 140, 255)
    UIStrokeInstance.Thickness = 1
    UIStrokeInstance.Transparency = 0.7
    UIStrokeInstance.Parent = FrameInstance2
    local FrameInstance3 = Instance.new("Frame")
    FrameInstance3.Size = UDim2.new(0.6, 0, 0.6, 0)
    FrameInstance3.Position = UDim2.new(0.5, 0, 0.5, 0)
    FrameInstance3.AnchorPoint = Vector2.new(0.5, 0.5)
    FrameInstance3.BackgroundTransparency = 1
    FrameInstance3.Rotation = 45
    FrameInstance3.Parent = FrameInstance2
    for LoopCounter = 0, 2 do
        local LoopCounter2 = LoopCounter
        for LoopCounter3 = 0, 2 do
            local LoopCounter4 = LoopCounter3
            if LoopCounter2 ~= 1 or LoopCounter4 ~= 1 then
                local FrameInstance4 = Instance.new("Frame")
                FrameInstance4.Size = UDim2.new(0, 2, 0, 2)
                FrameInstance4.Position = UDim2.new(LoopCounter2 * 0.4 + 0.1, 0, LoopCounter4 * 0.4 + 0.1, 0)
                FrameInstance4.BackgroundColor3 = Color3.fromRGB(200, 220, 255)
                FrameInstance4.BorderSizePixel = 0
                FrameInstance4.Parent = FrameInstance3
                Instance.new("UICorner", FrameInstance4).CornerRadius = UDim.new(1, 0)
            end
        end
    end
    local BooleanValue = false
    local NilValue2 = nil
    local InitialPosition = nil
    local UnusedValue = nil
    local TweenServiceInstance = game:GetService("TweenService")
    local TweenProperties = TweenServiceInstance
    local TweenInfoInstance = TweenServiceInstance.Create(TweenProperties, FrameInstance, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, - 1, true), {
        Position = UDim2.new(1, - 28, 1, - 28)
    })
    local TweenConfig = TweenInfoInstance
    TweenInfoInstance.Play(TweenConfig)
    local TweenTarget = TweenServiceInstance
    local BackTweenInstance = TweenServiceInstance.Create(TweenTarget, FrameInstance2, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 26, 0, 26),
        BackgroundColor3 = Color3.fromRGB(60, 80, 120),
        Rotation = 10
    })
    local ElasticTarget = TweenServiceInstance
    local ElasticTweenInstance = TweenServiceInstance.Create(ElasticTarget, UIStrokeInstance, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Color = Color3.fromRGB(150, 200, 255),
        Thickness = 2,
        Transparency = 0.3
    })
    local SineTarget = TweenServiceInstance
    local SineTweenInstance = TweenServiceInstance.Create(SineTarget, FrameInstance3, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0.8, 0, 0.8, 0),
        Rotation = 90
    })
    local InOutTarget = TweenServiceInstance
    local InOutTweenInstance = TweenServiceInstance.Create(InOutTarget, FrameInstance2, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 22, 0, 22),
        BackgroundColor3 = Color3.fromRGB(45, 45, 55),
        Rotation = 0
    })
    local BackTarget = TweenServiceInstance
    local BackTween = TweenServiceInstance.Create(BackTarget, UIStrokeInstance, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Color = Color3.fromRGB(120, 140, 255),
        Thickness = 1,
        Transparency = 0.7
    })
    local ElasticTarget2 = TweenServiceInstance
    local ElasticTween2 = TweenServiceInstance.Create(ElasticTarget2, FrameInstance3, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Size = UDim2.new(0.6, 0, 0.6, 0),
        Rotation = 45
    })
    local function LocalFunctionResult(ParameterX)
        if BooleanValue and (ParameterX.UserInputType == Enum.UserInputType.MouseMovement or ParameterX.UserInputType == Enum.UserInputType.Touch) then
            local VectorOffset = Vector2.new(ParameterX.Position.X, ParameterX.Position.Y) - NilValue2
            local ClampedPosition = Vector2.new(math.clamp(InitialPosition.X + VectorOffset.X, WindowSize.X, WindowSize2.X), math.clamp(InitialPosition.Y + VectorOffset.Y, WindowSize.Y, WindowSize2.Y))
            TweenServiceInstance:Create(Parameter13, TweenInfo.new(0.08, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, ClampedPosition.X, 0, ClampedPosition.Y)
            }):Play()
        end
    end
    FrameInstance.InputBegan:Connect(function(ParameterY)
        if ParameterY.UserInputType == Enum.UserInputType.MouseButton1 or ParameterY.UserInputType == Enum.UserInputType.Touch then
            BooleanValue = true
            NilValue2 = Vector2.new(ParameterY.Position.X, ParameterY.Position.Y)
            InitialPosition = Parameter13.AbsoluteSize
            TweenInfoInstance:Cancel()
            TweenServiceInstance:Create(FrameInstance2, TweenInfo.new(0.15, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 28, 0, 28),
                BackgroundColor3 = Color3.fromRGB(80, 120, 180),
                Rotation = - 15
            }):Play()
            TweenServiceInstance:Create(UIStrokeInstance, TweenInfo.new(0.15, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                Color = Color3.fromRGB(255, 255, 120),
                Thickness = 3,
                Transparency = 0
            }):Play()
            TweenServiceInstance:Create(FrameInstance3, TweenInfo.new(0.15, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                Size = UDim2.new(1, 0, 1, 0),
                Rotation = 180
            }):Play()
            UnusedValue = ParameterY.Changed:Connect(function()
                if ParameterY.UserInputState == Enum.UserInputState.End then
                    BooleanValue = false
                    TweenServiceInstance:Create(FrameInstance2, TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, 22, 0, 22),
                        BackgroundColor3 = Color3.fromRGB(45, 45, 55),
                        Rotation = 0
                    }):Play()
                    TweenServiceInstance:Create(UIStrokeInstance, TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                        Color = Color3.fromRGB(120, 140, 255),
                        Thickness = 1,
                        Transparency = 0.7
                    }):Play()
                    TweenServiceInstance:Create(FrameInstance3, TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0.6, 0, 0.6, 0),
                        Rotation = 45
                    }):Play()
                    wait(0.6)
                    if not BooleanValue then
                        TweenInfoInstance:Play()
                    end
                    if UnusedValue then
                        UnusedValue:Disconnect()
                        UnusedValue = nil
                    end
                end
            end)
        end
    end)
    FrameInstance.MouseEnter:Connect(function()
        if not BooleanValue then
            TweenInfoInstance:Cancel()
            BackTweenInstance:Play()
            ElasticTweenInstance:Play()
            SineTweenInstance:Play()
        end
    end)
    FrameInstance.MouseLeave:Connect(function()
        if not BooleanValue then
            InOutTweenInstance:Play()
            BackTween:Play()
            ElasticTween2:Play()
            wait(0.4)
            if not BooleanValue then
                TweenInfoInstance:Play()
            end
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(LocalFunctionResult)
end
local UiConfig = ({
    ui = function()
        local GuiInstance = GameServices.RunService:IsStudio() and GameServices.Players.LocalPlayer.PlayerGui or game.CoreGui
        local LanguagePicker = GuiInstance:FindFirstChild("Lunar Hub | Language Picker")
        if LanguagePicker then
            LanguagePicker:Destroy()
        end
        local ScreenGuiInstance = Instance.new("ScreenGui")
        ScreenGuiInstance.Name = "Lunar Hub | Language Picker"
        ScreenGuiInstance.ResetOnSpawn = false
        ScreenGuiInstance.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ScreenGuiInstance.Parent = GuiInstance
        return ScreenGuiInstance
    end
}).ui()
local LoadedScript = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pxrson/Lunar-Hub/refs/heads/main/Flip"))():CreateWindow({
    Title = Function8("Lunar Hub"),
    Description = Function8("Discord.gg/xH56eZ7jTG") or "Discord.gg/xH56eZ7jTG",
    Parent = UiConfig,
    ["Tab Width"] = 100,
    SizeUi = UDim2.new(0, 400, 0, 240)
})
wait(0.1)
if LoadedScript and LoadedScript.Main then
    MakeResizable(LoadedScript.Main)
elseif LoadedScript and LoadedScript.Frame then
    MakeResizable(LoadedScript.Frame)
else
    print("Window structure:", LoadedScript)
    local ScriptTable, ScriptKey, ScriptValue = pairs(LoadedScript)
    while true do
        local UnusedVariable
        ScriptValue, UnusedVariable = ScriptTable(ScriptKey, ScriptValue)
        if ScriptValue == nil then
            break
        end
        print(ScriptValue, UnusedVariable)
    end
end
local MainTab = {
    Main = LoadedScript:CreateTab({
        Function8("Main"),
        "rbxassetid://10723347051"
    }),
    Home = LoadedScript:CreateTab({
        Function8("Home"),
        "rbxassetid://10723407389"
    }),
    Farm = LoadedScript:CreateTab({
        Function8("Farm"),
        "rbxassetid://10709798276"
    }),
    Rebirth = LoadedScript:CreateTab({
        Function8("Rebirth"),
        "rbxassetid://10734934347"
    }),
    Killer = LoadedScript:CreateTab({
        Function8("Killer"),
        "rbxassetid://10734962068"
    }),
    Stats = LoadedScript:CreateTab({
        Function8("Stats"),
        "rbxassetid://10709811595"
    }),
    Calculators = LoadedScript:CreateTab({
        Function8("Calculators"),
        "rbxassetid://10709783311"
    }),
    Misc = LoadedScript:CreateTab({
        Function8("Misc"),
        "rbxassetid://10734950020"
    })
}
local TabConfig = {
    Discord = MainTab.Main:AddSection(Function8("Discord"), false),
    LocalPlayer = MainTab.Main:AddSection(Function8("LocalPlayer"), false),
    Misc = MainTab.Main:AddSection(Function8("Misc"), false),
    ["Auto Brawls"] = MainTab.Home:AddSection(Function8("Auto Brawls"), false),
    Tools = MainTab.Home:AddSection(Function8("Tools"), false),
    ["Tools Speed"] = MainTab.Home:AddSection(Function8("Tools Speed"), false),
    ["Auto Rewards"] = MainTab.Home:AddSection(Function8("Auto Rewards"), false),
    Teleport = MainTab.Home:AddSection(Function8("Teleport"), false),
    Shop = MainTab.Home:AddSection(Function8("Shop"), false),
    Ultimates = MainTab.Home:AddSection(Function8("Ultimates"), false),
    ["Equip Pets"] = MainTab.Home:AddSection(Function8("Equip Pets"), false),
    RocksSection = MainTab.Farm:AddSection(Function8("Auto Rock"), false),
    ["Auto Treadmill"] = MainTab.Farm:AddSection(Function8("Auto Treadmill"), false),
    ["Auto Bar Lift"] = MainTab.Farm:AddSection(Function8("Auto Bar Lift"), false),
    ["Auto Bench Press"] = MainTab.Farm:AddSection(Function8("Auto Bench Press"), false),
    ["Auto Squats"] = MainTab.Farm:AddSection(Function8("Auto Squats"), false),
    ["Auto PullUps"] = MainTab.Farm:AddSection(Function8("Auto PullUps"), false),
    ["Auto Boulder"] = MainTab.Farm:AddSection(Function8("Auto Boulder"), false),
    ["Rebirth Status"] = MainTab.Rebirth:AddSection(Function8("Rebirth Status"), false),
    RegularSection = MainTab.Rebirth:AddSection(Function8("Normal Farm"), false),
    ["Pack Farm | Rebirth"] = MainTab.Rebirth:AddSection(Function8("Pack Farm | Rebirth"), false),
    ["Pack Farm | Target Rebirth"] = MainTab.Rebirth:AddSection(Function8("Pack Farm | Target Rebirth"), false),
    ["Pack Farm | Rebirth With Glitches"] = MainTab.Rebirth:AddSection(Function8("Pack Farm | Rebirth With Glitches"), false),
    ["Fast Strength"] = MainTab.Rebirth:AddSection(Function8("Fast Strength"), false),
    FPS = MainTab.Rebirth:AddSection(Function8("FPS"), false),
    MiscRebirth = MainTab.Rebirth:AddSection(Function8("Misc"), false),
    Whitelist = MainTab.Killer:AddSection(Function8("Whitelist"), false),
    Blacklist = MainTab.Killer:AddSection(Function8("Blacklist"), false),
    Killer = MainTab.Killer:AddSection(Function8("Killer"), false),
    ["Kill Aura"] = MainTab.Killer:AddSection(Function8("Kill Aura"), false),
    ["Target Player"] = MainTab.Killer:AddSection(Function8("Target Player"), false),
    Spy = MainTab.Killer:AddSection(Function8("Specator"), false),
    Stats = MainTab.Stats:AddSection(Function8("Stats"), false),
    ["Gained Stats"] = MainTab.Stats:AddSection(Function8("Gained Stats"), false),
    Webhook = MainTab.Stats:AddSection(Function8("Webhook | Discord"), false),
    ["Spoof Stats"] = MainTab.Stats:AddSection(Function8("Spoof Stats"), false),
    Player = MainTab.Stats:AddSection(Function8("Player Stats"), false),
    ["Damage Calculator"] = MainTab.Calculators:AddSection(Function8("Damage Calculator"), false),
    ["Hit Animation"] = MainTab.Misc:AddSection(Function8("Hit Animation"), false),
    ["Inventory Looker"] = MainTab.Misc:AddSection(Function8("Inventory Looker"), false),
    ["Music Player"] = MainTab.Misc:AddSection(Function8("Music Player"), false),
    ["Snacks Eater"] = MainTab.Misc:AddSection(Function8("Snacks Eater"), false)
}
TabConfig.LocalPlayer:AddInput({
    Title = Function8("Enter Speed Value"),
    Content = Function8(""),
    Callback = function(ParameterValue)
        local NumericValue = tonumber(ParameterValue)
        if NumericValue and NumericValue > 0 then
            SpeedSettings.Speed.value = NumericValue
            local HumanoidInstance = SpeedSettings.Speed.enabled and GameContext.player.Character and GameContext.player.Character:FindFirstChild("Humanoid")
            if HumanoidInstance then
                HumanoidInstance.WalkSpeed = SpeedSettings.Speed.value
            end
        end
    end
})
TabConfig.LocalPlayer:AddToggle({
    Title = Function8("Auto Set Speed"),
    Content = Function8(""),
    Default = false,
    Callback = function(ParameterName)
        SpeedSettings.Speed.enabled = ParameterName
        if SpeedSettings.Speed.connection then
            SpeedSettings.Speed.connection:Disconnect()
            SpeedSettings.Speed.connection = nil
        end
        if ParameterName then
            local CharacterHumanoid = GameContext.player.Character and GameContext.player.Character:FindFirstChild("Humanoid")
            if CharacterHumanoid then
                CharacterHumanoid.WalkSpeed = SpeedSettings.Speed.value
            end
            SpeedSettings.Speed.connection = GameContext.player.CharacterAdded:Connect(function(ParameterType)
                ParameterType:WaitForChild("Humanoid").WalkSpeed = SpeedSettings.Speed.value
            end)
        end
    end
})
TabConfig.LocalPlayer:AddInput({
    Title = Function8("Enter Size Value"),
    Content = Function8(""),
    Callback = function(ParameterValue2)
        local ConvertedValue = tonumber(ParameterValue2)
        if ConvertedValue and ConvertedValue > 0 then
            SpeedSettings.Size.selected = ConvertedValue
            pcall(function()
                GameServices.ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", SpeedSettings.Size.selected)
            end)
        end
    end
})
TabConfig.LocalPlayer:AddToggle({
    Title = Function8("Auto Set Size"),
    Content = Function8(""),
    Default = false,
    Callback = function(ParameterX2)
        if SpeedSettings.Size.connection then
            SpeedSettings.Size.connection:Disconnect()
            SpeedSettings.Size.connection = nil
        end
        if ParameterX2 then
            pcall(function()
                GameServices.ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", SpeedSettings.Size.selected)
            end)
            SpeedSettings.Size.connection = GameContext.player.CharacterAdded:Connect(function(UnusedParameter)
                task.wait(0.5)
                pcall(function()
                    GameServices.ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", SpeedSettings.Size.selected)
                end)
            end)
        end
    end
})
TabConfig.LocalPlayer:AddToggle({
    Title = Function8("Infinite Jump"),
    Default = false,
    Callback = function(ParameterY2)
        if SpeedSettings.InfiniteJump.connection then
            SpeedSettings.InfiniteJump.connection:Disconnect()
            SpeedSettings.InfiniteJump.connection = nil
        end
        if ParameterY2 then
            SpeedSettings.InfiniteJump.connection = GameServices.UserInputService.JumpRequest:Connect(function()
                local HumanoidRootPart = GameContext.player.Character and GameContext.player.Character:FindFirstChild("Humanoid")
                if HumanoidRootPart then
                    HumanoidRootPart:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end
})
TabConfig.LocalPlayer:AddToggle({
    Title = Function8("NoClip"),
    Content = Function8(""),
    Default = false,
    Callback = function(ParameterZ)
        if SpeedSettings.NoClip.connection then
            SpeedSettings.NoClip.connection:Disconnect()
            SpeedSettings.NoClip.connection = nil
        end
        if ParameterZ then
            SpeedSettings.NoClip.connection = GameServices.RunService.Stepped:Connect(function()
                if GameContext.player.Character then
                    local DescendantInstance, DescendantName, DescendantClass = pairs(GameContext.player.Character:GetDescendants())
                    while true do
                        local UnusedVariable2
                        DescendantClass, UnusedVariable2 = DescendantInstance(DescendantName, DescendantClass)
                        if DescendantClass == nil then
                            break
                        end
                        if UnusedVariable2:IsA("BasePart") then
                            UnusedVariable2.CanCollide = false
                        end
                    end
                end
            end)
        elseif GameContext.player.Character then
            local DescendantParent, DescendantChildren, DescendantProperties = pairs(GameContext.player.Character:GetDescendants())
            while true do
                local RaycastOrigin
                DescendantProperties, RaycastOrigin = DescendantParent(DescendantChildren, DescendantProperties)
                if DescendantProperties == nil then
                    break
                end
                if RaycastOrigin:IsA("BasePart") and RaycastOrigin.Name ~= "HumanoidRootPart" then
                    local RaycastResult = workspace:Raycast(RaycastOrigin.Position, Vector3.new(0, - 1, 0), RaycastParams.new())
                    if RaycastResult and not RaycastResult.Instance.Parent:FindFirstChild("Humanoid") then
                        RaycastOrigin.CanCollide = true
                    end
                end
            end
        end
    end
})
TabConfig.Misc:AddToggle({
    Title = Function8("Hide Frames"),
    Default = false,
    Callback = function(ParameterDistance)
        local ReplicatedStorageInstance, ReplicatedStorageTable, ReplicatedStorageKey = pairs(GameServices.ReplicatedStorage:GetChildren())
        while true do
            local UnusedVariable3
            ReplicatedStorageKey, UnusedVariable3 = ReplicatedStorageInstance(ReplicatedStorageTable, ReplicatedStorageKey)
            if ReplicatedStorageKey == nil then
                break
            end
            if UnusedVariable3.Name:match("Frame$") then
                UnusedVariable3.Visible = not ParameterDistance
            end
        end
    end
})
TabConfig.Misc:AddToggle({
    Title = Function8("Lock Position"),
    Default = false,
    Callback = function(ParameterFilter)
        local LocalPlayerInstance = game.Players.LocalPlayer
        local CharacterInstance = LocalPlayerInstance.Character or LocalPlayerInstance.CharacterAdded:Wait()
        local HumanoidComponent = CharacterInstance:WaitForChild("Humanoid")
        local HumanoidRootPartInstance = CharacterInstance:WaitForChild("HumanoidRootPart")
        if ParameterFilter then
            local CharacterCFrame = HumanoidRootPartInstance.CFrame
            HumanoidRootPartInstance.Anchored = true
            HumanoidComponent.PlatformStand = true
            HumanoidRootPartInstance.CFrame = CharacterCFrame
        else
            HumanoidRootPartInstance.Anchored = false
            HumanoidComponent.PlatformStand = false
        end
    end
})
TabConfig.Misc:AddToggle({
    Title = Function8("Anti-AFK"),
    Default = false,
    Callback = function(ParameterCFrame)
        if ParameterCFrame then
            _G.AntiAFK = game:GetService("RunService").Heartbeat:Connect(function()
                local VirtualUserInstance = game:GetService("VirtualUser")
                VirtualUserInstance:CaptureController()
                VirtualUserInstance:ClickButton2(Vector2.new())
            end)
        elseif _G.AntiAFK then
            _G.AntiAFK:Disconnect()
            _G.AntiAFK = nil
        end
    end
})
TabConfig.Misc:AddToggle({
    Title = Function8("Anti-Knockback"),
    Default = false,
    Callback = function(ParameterUserId)
        if ParameterUserId then
            local PlayerNameString = game.Players.LocalPlayer.Name
            local PlayerHumanoidRootPart = game.Workspace:FindFirstChild(PlayerNameString):FindFirstChild("HumanoidRootPart")
            local BodyVelocityInstance = Instance.new("BodyVelocity")
            BodyVelocityInstance.MaxForce = Vector3.new(100000, 0, 100000)
            BodyVelocityInstance.Velocity = Vector3.new(0, 0, 0)
            BodyVelocityInstance.P = 1250
            BodyVelocityInstance.Parent = PlayerHumanoidRootPart
        else
            local PlayerNameString2 = game.Players.LocalPlayer.Name
            local PlayerBodyVelocity = game.Workspace:FindFirstChild(PlayerNameString2):FindFirstChild("HumanoidRootPart"):FindFirstChild("BodyVelocity")
            if PlayerBodyVelocity and PlayerBodyVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
                PlayerBodyVelocity:Destroy()
            end
        end
    end
})
local GamepassIdsInstance = game:GetService("ReplicatedStorage").gamepassIds
local LocalPlayerReference = game:GetService("Players").LocalPlayer
local GamepassIdsTable, GamepassIdsKey, GamepassIdsValue = pairs(GamepassIdsInstance:GetChildren())
local AutoSettingsConfig = {
    autoJoinBrawl = false,
    autoWinBrawl = false
}
while true do
    local UnusedVariable4
    GamepassIdsValue, UnusedVariable4 = GamepassIdsTable(GamepassIdsKey, GamepassIdsValue)
    if GamepassIdsValue == nil then
        break
    end
    local IntValueInstance = Instance.new("IntValue")
    IntValueInstance.Name = UnusedVariable4.Name
    IntValueInstance.Value = UnusedVariable4.Value
    IntValueInstance.Parent = LocalPlayerReference.ownedGamepasses
end
TabConfig.Misc:AddToggle({
    Title = Function8("Remove Portals"),
    Default = false,
    Callback = function(ParameterIntValue)
        if ParameterIntValue then
            local DescendantsTable, DescendantsKey, DescendantsValue = pairs(game:GetDescendants())
            while true do
                local UnusedVariable5
                DescendantsValue, UnusedVariable5 = DescendantsTable(DescendantsKey, DescendantsValue)
                if DescendantsValue == nil then
                    break
                end
                if UnusedVariable5.Name == "RobloxForwardPortals" then
                    UnusedVariable5:Destroy()
                end
            end
            if _G.AdRemovalConnection then
                _G.AdRemovalConnection:Disconnect()
            end
            _G.AdRemovalConnection = game.DescendantAdded:Connect(function(ParameterDescendant)
                if ParameterDescendant.Name == "RobloxForwardPortals" then
                    ParameterDescendant:Destroy()
                end
            end)
        elseif _G.AdRemovalConnection then
            _G.AdRemovalConnection:Disconnect()
            _G.AdRemovalConnection = nil
        end
    end
})
local EmptyConfig = {}
local MagicNumber = 2048
local Vector3Position = Vector3.new(- 2, - 9.5, - 2)
local CalculatedValue = math.ceil(50000 / MagicNumber)
local function LocalFunctionReference()
    for LoopCounter = 0, CalculatedValue - 1 do
        local LoopValue = LoopCounter
        for LoopIndex = 0, CalculatedValue - 1 do
            local PartInstance1 = Instance.new("Part")
            PartInstance1.Size = Vector3.new(MagicNumber, 1, MagicNumber)
            PartInstance1.Position = Vector3Position + Vector3.new(LoopValue * MagicNumber, 0, LoopIndex * MagicNumber)
            PartInstance1.Anchored = true
            PartInstance1.Transparency = 1
            PartInstance1.CanCollide = true
            PartInstance1.Name = "Part_Side_" .. LoopValue .. "_" .. LoopIndex
            PartInstance1.Parent = workspace
            table.insert(EmptyConfig, PartInstance1)
            local PartInstance2 = Instance.new("Part")
            PartInstance2.Size = Vector3.new(MagicNumber, 1, MagicNumber)
            PartInstance2.Position = Vector3Position + Vector3.new(- LoopValue * MagicNumber, 0, LoopIndex * MagicNumber)
            PartInstance2.Anchored = true
            PartInstance2.Transparency = 1
            PartInstance2.CanCollide = true
            PartInstance2.Name = "Part_LeftRight_" .. LoopValue .. "_" .. LoopIndex
            PartInstance2.Parent = workspace
            table.insert(EmptyConfig, PartInstance2)
            local PartInstance3 = Instance.new("Part")
            PartInstance3.Size = Vector3.new(MagicNumber, 1, MagicNumber)
            PartInstance3.Position = Vector3Position + Vector3.new(- LoopValue * MagicNumber, 0, - LoopIndex * MagicNumber)
            PartInstance3.Anchored = true
            PartInstance3.Transparency = 1
            PartInstance3.CanCollide = true
            PartInstance3.Name = "Part_UpLeft_" .. LoopValue .. "_" .. LoopIndex
            PartInstance3.Parent = workspace
            table.insert(EmptyConfig, PartInstance3)
            local PartInstance4 = Instance.new("Part")
            PartInstance4.Size = Vector3.new(MagicNumber, 1, MagicNumber)
            PartInstance4.Position = Vector3Position + Vector3.new(LoopValue * MagicNumber, 0, - LoopIndex * MagicNumber)
            PartInstance4.Anchored = true
            PartInstance4.Transparency = 1
            PartInstance4.CanCollide = true
            PartInstance4.Name = "Part_UpRight_" .. LoopValue .. "_" .. LoopIndex
            PartInstance4.Parent = workspace
            table.insert(EmptyConfig, PartInstance4)
        end
    end
end
local function LocalFunction()
    local PlayerIndex, PlayerName, PlayerData = ipairs(EmptyConfig)
    while true do
        local TemporaryValue
        PlayerData, TemporaryValue = PlayerIndex(PlayerName, PlayerData)
        if PlayerData == nil then
            break
        end
        if TemporaryValue and TemporaryValue.Parent then
            TemporaryValue:Destroy()
        end
    end
    EmptyConfig = {}
end
TabConfig.Misc:AddToggle({
    Title = Function8("Walk on Water"),
    Default = false,
    Callback = function(FunctionParameter)
        if FunctionParameter then
            LocalFunctionReference()
        else
            LocalFunction()
        end
    end
})
local PunchEquipment = {
    equipPunch = function()
        if not AutoSettingsConfig.autoWinBrawl then
            return false
        end
        local PlayerCharacter = GameContext.player.Character
        if not PlayerCharacter then
            return false
        end
        if PlayerCharacter:FindFirstChild("Punch") then
            return true
        end
        local PlayerBackpack = GameContext.player.Backpack
        if not PlayerBackpack then
            return false
        end
        local BackpackItem, ItemName, ItemData = pairs(PlayerBackpack:GetChildren())
        while true do
            local UnusedVariable
            ItemData, UnusedVariable = BackpackItem(ItemName, ItemData)
            if ItemData == nil then
                break
            end
            if UnusedVariable.ClassName == "Tool" and UnusedVariable.Name == "Punch" then
                UnusedVariable.Parent = PlayerCharacter
                return true
            end
        end
        return false
    end,
    isValidTarget = function(PlayerParameter)
        if not PlayerParameter or (not PlayerParameter.Parent or PlayerParameter == GameContext.player) then
            return false
        end
        local CharacterModel = PlayerParameter.Character
        if not (CharacterModel and CharacterModel.Parent) then
            return false
        end
        local HumanoidComponent = CharacterModel:FindFirstChild("Humanoid")
        if not HumanoidComponent or (not HumanoidComponent.Health or HumanoidComponent.Health <= 0) then
            return false
        end
        if HumanoidComponent:GetState() == Enum.HumanoidStateType.Dead then
            return false
        end
        local HumanoidRootPart = CharacterModel:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart then
            HumanoidRootPart = HumanoidRootPart.Parent
        end
        return HumanoidRootPart
    end,
    isLocalPlayerReady = function()
        local PlayerCharacterModel = GameContext.player.Character
        if not (PlayerCharacterModel and PlayerCharacterModel.Parent) then
            return false
        end
        local CharacterHumanoid = PlayerCharacterModel:FindFirstChild("Humanoid")
        if not CharacterHumanoid or CharacterHumanoid.Health <= 0 then
            return false
        end
        local LeftHand = PlayerCharacterModel:FindFirstChild("LeftHand")
        local RightHand = PlayerCharacterModel:FindFirstChild("RightHand")
        return LeftHand ~= nil or RightHand ~= nil
    end,
    safeTouchInterest = function(Parameter1, Parameter2)
        if Parameter1 and (Parameter1.Parent and (Parameter2 and Parameter2.Parent)) then
            return pcall(function()
                firetouchinterest(Parameter1, Parameter2, 0)
                task.wait(0.01)
                firetouchinterest(Parameter1, Parameter2, 1)
            end)
        else
            return false
        end
    end,
    joinBrawl = function(FunctionArgument)
        local DefaultValue = FunctionArgument or 0.5
        task.spawn(function()
            while AutoSettingsConfig.autoJoinBrawl and task.wait(DefaultValue) do
                pcall(function()
                    if GameContext.player.PlayerGui.gameGui.brawlJoinLabel.Visible then
                        GameServices.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                        GameContext.player.PlayerGui.gameGui.brawlJoinLabel.Visible = false
                    end
                end)
            end
        end)
    end
}
TabConfig["Auto Brawls"]:AddToggle({
    Title = Function8("Auto Brawl Join"),
    Default = false,
    Callback = function(Argument1)
        AutoSettingsConfig.autoJoinBrawl = Argument1
        if Argument1 then
            PunchEquipment.joinBrawl(0.5)
        end
    end
})
TabConfig["Auto Brawls"]:AddToggle({
    Title = Function8("Auto Win Brawls"),
    Default = false,
    Callback = function(Argument2)
        AutoSettingsConfig.autoWinBrawl = Argument2
        if Argument2 then
            task.spawn(function()
                while AutoSettingsConfig.autoWinBrawl and task.wait(0.5) do
                    PunchEquipment.equipPunch()
                end
            end)
            task.spawn(function()
                while AutoSettingsConfig.autoWinBrawl and task.wait(0.1) do
                    if PunchEquipment.isLocalPlayerReady() and GameServices.ReplicatedStorage.brawlInProgress.Value then
                        pcall(function()
                            GameContext.player.muscleEvent:FireServer("punch", "rightHand")
                        end)
                        pcall(function()
                            GameContext.player.muscleEvent:FireServer("punch", "leftHand")
                        end)
                    end
                end
            end)
            task.spawn(function()
                while AutoSettingsConfig.autoWinBrawl and task.wait(0.1) do
                    if PunchEquipment.isLocalPlayerReady() and GameServices.ReplicatedStorage.brawlInProgress.Value then
                        local CharacterModel1 = GameContext.player.Character
                        local LeftHand1 = CharacterModel1:FindFirstChild("LeftHand")
                        local RightHand1 = CharacterModel1:FindFirstChild("RightHand")
                        local PlayerList, PlayerInfo, PlayerData1 = pairs(GameServices.Players:GetPlayers())
                        while true do
                            local PlayerObject
                            PlayerData1, PlayerObject = PlayerList(PlayerInfo, PlayerData1)
                            if PlayerData1 == nil or not AutoSettingsConfig.autoWinBrawl then
                                break
                            end
                            pcall(function()
                                if PunchEquipment.isValidTarget(PlayerObject) then
                                    local HumanoidRootPart1 = PlayerObject.Character.HumanoidRootPart
                                    if LeftHand1 then
                                        PunchEquipment.safeTouchInterest(HumanoidRootPart1, LeftHand1)
                                    end
                                    if RightHand1 then
                                        PunchEquipment.safeTouchInterest(HumanoidRootPart1, RightHand1)
                                    end
                                end
                            end)
                            task.wait(0.02)
                        end
                    end
                end
            end)
        end
    end
})
TabConfig["Auto Brawls"]:AddToggle({
    Title = Function8("God Brawl"),
    Default = false,
    Callback = function(Parameter3)
        AutoSettingsConfig.autoJoinBrawl = Parameter3
        if Parameter3 then
            PunchEquipment.joinBrawl(0.1)
        end
    end
})
if not GameData then
    GameData = {}
end
GameData.tools = {
    selectedTool = "Weight",
    selectedMode = "Remote",
    autoFarmConnection = nil
}
TabConfig.Tools:AddDropdown({
    Function8("Tools"),
    Function8("Select a tool"),
    false,
    {
        "Weight",
        "Pushups",
        "Situps",
        "Handstands",
        "Punch",
        "Stomp",
        "Ground Slam"
    },
    {
        "Weight"
    },
    function(Parameter4)
        if Parameter4 and # Parameter4 > 0 then
            GameData.tools.selectedTool = Parameter4[1]
        end
    end
})
TabConfig.Tools:AddDropdown({
    Function8("Mode"),
    Function8("Select mode"),
    false,
    {
        "Remote",
        "Activate"
    },
    {
        "Remote"
    },
    function(Parameter5)
        if Parameter5 and # Parameter5 > 0 then
            GameData.tools.selectedMode = Parameter5[1]
        end
    end
})
TabConfig.Tools:AddToggle({
    Title = Function8("Auto Tool"),
    Default = false,
    Callback = function(Parameter6)
        if GameData.tools.autoFarmConnection then
            GameData.tools.autoFarmConnection:Disconnect()
            GameData.tools.autoFarmConnection = nil
        end
        if Parameter6 then
            GameData.tools.autoFarmConnection = GameServices.RunService.Heartbeat:Connect(function()
                local CharacterModel2 = GameContext.player.Character
                local Backpack1 = GameContext.player.Backpack
                if CharacterModel2 and Backpack1 then
                    local ToolItem = CharacterModel2:FindFirstChild(GameData.tools.selectedTool)
                    local UnusedObject
                    if ToolItem then
                        UnusedObject = ToolItem
                    else
                        UnusedObject = Backpack1:FindFirstChild(GameData.tools.selectedTool)
                        if UnusedObject then
                            UnusedObject.Parent = CharacterModel2
                        else
                            UnusedObject = ToolItem
                        end
                    end
                    if UnusedObject then
                        pcall(function()
                            if GameData.tools.selectedMode ~= "Remote" then
                                if GameData.tools.selectedMode == "Activate" then
                                    UnusedObject:Activate()
                                end
                            else
                                GameContext.player.muscleEvent:FireServer("rep")
                            end
                        end)
                    end
                end
            end)
        end
    end
})
TabConfig["Tools Speed"]:AddToggle({
    Title = Function8("Faster Farm Weight"),
    Default = false,
    Callback = function(Parameter7)
        _G.FasterFarmWeight = Parameter7
        local PlayerObject1 = GameContext.player
        local BackpackName = PlayerObject1
        local BackpackObject = PlayerObject1.WaitForChild(BackpackName, "Backpack")
        local function LocalFunction1()
            local WeightItem = BackpackObject:FindFirstChild("Weight")
            if WeightItem and WeightItem:FindFirstChild("repTime") then
                WeightItem.repTime.Value = Parameter7 and 0 or 1
            end
            local CharacterModel3 = PlayerObject1.Character
            if CharacterModel3 then
                CharacterModel3 = PlayerObject1.Character:FindFirstChild("Weight")
            end
            if CharacterModel3 and CharacterModel3:FindFirstChild("repTime") then
                CharacterModel3.repTime.Value = Parameter7 and 0 or 1
            end
        end
        LocalFunction1()
        if Parameter7 then
            task.spawn(function()
                while _G.FasterFarmWeight do
                    LocalFunction1()
                    task.wait(1)
                end
            end)
        end
    end
})
TabConfig["Tools Speed"]:AddToggle({
    Title = Function8("Faster Farm Pushups"),
    Default = false,
    Callback = function(Parameter8)
        _G.FasterFarmPushups = Parameter8
        local PlayerObject2 = GameContext.player
        local BackpackName1 = PlayerObject2
        local BackpackObject1 = PlayerObject2.WaitForChild(BackpackName1, "Backpack")
        local function LocalFunction2()
            local PushupsItem = BackpackObject1:FindFirstChild("Pushups")
            if PushupsItem and PushupsItem:FindFirstChild("repTime") then
                PushupsItem.repTime.Value = Parameter8 and 0 or 1
            end
            local CharacterModel4 = PlayerObject2.Character
            if CharacterModel4 then
                CharacterModel4 = PlayerObject2.Character:FindFirstChild("Pushups")
            end
            if CharacterModel4 and CharacterModel4:FindFirstChild("repTime") then
                CharacterModel4.repTime.Value = Parameter8 and 0 or 1
            end
        end
        LocalFunction2()
        if Parameter8 then
            task.spawn(function()
                while _G.FasterFarmPushups do
                    LocalFunction2()
                    task.wait(1)
                end
            end)
        end
    end
})
TabConfig["Tools Speed"]:AddToggle({
    Title = Function8("Faster Farm Situps"),
    Default = false,
    Callback = function(Parameter9)
        _G.FasterFarmSitups = Parameter9
        local PlayerObject3 = GameContext.player
        local BackpackName2 = PlayerObject3
        local BackpackObject2 = PlayerObject3.WaitForChild(BackpackName2, "Backpack")
        local function LocalFunction3()
            local SitupsItem = BackpackObject2:FindFirstChild("Situps")
            if SitupsItem and SitupsItem:FindFirstChild("repTime") then
                SitupsItem.repTime.Value = Parameter9 and 0 or 1
            end
            local CharacterModel5 = PlayerObject3.Character
            if CharacterModel5 then
                CharacterModel5 = PlayerObject3.Character:FindFirstChild("Situps")
            end
            if CharacterModel5 and CharacterModel5:FindFirstChild("repTime") then
                CharacterModel5.repTime.Value = Parameter9 and 0 or 1
            end
        end
        LocalFunction3()
        if Parameter9 then
            task.spawn(function()
                while _G.FasterFarmSitups do
                    LocalFunction3()
                    task.wait(1)
                end
            end)
        end
    end
})
TabConfig["Tools Speed"]:AddToggle({
    Title = Function8("Faster Farm Handstands"),
    Default = false,
    Callback = function(Parameter10)
        _G.FasterFarmHandstands = Parameter10
        local PlayerObject4 = GameContext.player
        local BackpackName3 = PlayerObject4
        local BackpackObject3 = PlayerObject4.WaitForChild(BackpackName3, "Backpack")
        local function LocalFunction4()
            local HandstandsItem = BackpackObject3:FindFirstChild("Handstands")
            if HandstandsItem and HandstandsItem:FindFirstChild("repTime") then
                HandstandsItem.repTime.Value = Parameter10 and 0 or 1
            end
            local CharacterModel6 = PlayerObject4.Character
            if CharacterModel6 then
                CharacterModel6 = PlayerObject4.Character:FindFirstChild("Handstands")
            end
            if CharacterModel6 and CharacterModel6:FindFirstChild("repTime") then
                CharacterModel6.repTime.Value = Parameter10 and 0 or 1
            end
        end
        LocalFunction4()
        if Parameter10 then
            task.spawn(function()
                while _G.FasterFarmHandstands do
                    LocalFunction4()
                    task.wait(1)
                end
            end)
        end
    end
})
TabConfig["Tools Speed"]:AddToggle({
    Title = Function8("Faster Farm Punch"),
    Default = false,
    Callback = function(Parameter11)
        _G.FasterFarmPunch = Parameter11
        local PlayerObject5 = GameContext.player
        local BackpackName4 = PlayerObject5
        local BackpackObject4 = PlayerObject5.WaitForChild(BackpackName4, "Backpack")
        local function LocalFunction5()
            local PunchItem = BackpackObject4:FindFirstChild("Punch")
            if PunchItem and PunchItem:FindFirstChild("attackTime") then
                PunchItem.attackTime.Value = Parameter11 and 0 or 0.35
            end
            local CharacterModel7 = PlayerObject5.Character
            if CharacterModel7 then
                CharacterModel7 = PlayerObject5.Character:FindFirstChild("Punch")
            end
            if CharacterModel7 and CharacterModel7:FindFirstChild("attackTime") then
                CharacterModel7.attackTime.Value = Parameter11 and 0 or 0.35
            end
        end
        LocalFunction5()
        if Parameter11 then
            task.spawn(function()
                while _G.FasterFarmPunch do
                    LocalFunction5()
                    task.wait(1)
                end
            end)
        end
    end
})
TabConfig["Tools Speed"]:AddToggle({
    Title = Function8("Faster Farm Stomp"),
    Default = false,
    Callback = function(Parameter12)
        _G.FasterFarmStomp = Parameter12
        local PlayerObject6 = GameContext.player
        local BackpackName5 = PlayerObject6
        local BackpackObject5 = PlayerObject6.WaitForChild(BackpackName5, "Backpack")
        local function LocalFunction6()
            local StompItem = BackpackObject5:FindFirstChild("Stomp")
            if StompItem and StompItem:FindFirstChild("attackTime") then
                StompItem.attackTime.Value = Parameter12 and 0 or 0.35
            end
            local CharacterModel8 = PlayerObject6.Character
            if CharacterModel8 then
                CharacterModel8 = PlayerObject6.Character:FindFirstChild("Stomp")
            end
            if CharacterModel8 and CharacterModel8:FindFirstChild("attackTime") then
                CharacterModel8.attackTime.Value = Parameter12 and 0 or 0.35
            end
        end
        LocalFunction6()
        if Parameter12 then
            task.spawn(function()
                while _G.FasterFarmStomp do
                    LocalFunction6()
                    task.wait(1)
                end
            end)
        end
    end
})
TabConfig["Tools Speed"]:AddToggle({
    Title = Function8("Faster Farm Ground Slam"),
    Default = false,
    Callback = function(Parameter13)
        _G.FasterFarmGroundSlam = Parameter13
        local PlayerObject7 = GameContext.player
        local BackpackName6 = PlayerObject7
        local BackpackObject6 = PlayerObject7.WaitForChild(BackpackName6, "Backpack")
        local function LocalFunction7()
            local GroundSlamItem = BackpackObject6:FindFirstChild("Ground Slam")
            if GroundSlamItem and GroundSlamItem:FindFirstChild("attackTime") then
                GroundSlamItem.attackTime.Value = Parameter13 and 0 or 0.35
            end
            local CharacterModel9 = PlayerObject7.Character
            if CharacterModel9 then
                CharacterModel9 = PlayerObject7.Character:FindFirstChild("Ground Slam")
            end
            if CharacterModel9 and CharacterModel9:FindFirstChild("attackTime") then
                CharacterModel9.attackTime.Value = Parameter13 and 0 or 0.35
            end
        end
        LocalFunction7()
        if Parameter13 then
            task.spawn(function()
                while _G.FasterFarmGroundSlam do
                    LocalFunction7()
                    task.wait(1)
                end
            end)
        end
    end
})
local GiftSettings = {
    giftConnection = nil,
    giftEnabled = false,
    wheelEnabled = false,
    wheelConnection = nil
}
TabConfig["Auto Rewards"]:AddToggle({
    Title = "Auto Claim Gifts",
    Content = "Automatically claims all gifts every 10 seconds",
    Default = false,
    Callback = function(FunctionArgument1)
        GiftSettings.giftEnabled = FunctionArgument1
        if GiftSettings.giftConnection then
            task.cancel(GiftSettings.giftConnection)
            GiftSettings.giftConnection = nil
        end
        if FunctionArgument1 then
            GiftSettings.giftConnection = task.spawn(function()
                while GiftSettings.giftEnabled do
                    for LoopCounter = 1, 9 do
                        local LoopValue = LoopCounter
                        pcall(function()
                            GameServices.ReplicatedStorage.rEvents.freeGiftClaimRemote:InvokeServer("claimGift", LoopValue)
                        end)
                    end
                    task.wait(10)
                end
            end)
        end
    end
})
TabConfig["Auto Rewards"]:AddButton({
    Title = Function8("Redeem All Codes"),
    Callback = function()
        local RewardItem, RewardName, RewardData = ipairs({
            "spacegems50",
            "launch250",
            "galaxycrystal50",
            "epicreward500",
            "frostgems10",
            "Supermuscle100",
            "Skyagility50",
            "Millionwarriors",
            "Musclestorm50",
            "Superpunch100",
            "ultimate250",
            "Megalift50",
            "Speedy50"
        })
        while true do
            local UnusedVariable1
            RewardData, UnusedVariable1 = RewardItem(RewardName, RewardData)
            if RewardData == nil then
                break
            end
            pcall(function()
                GameServices.ReplicatedStorage.rEvents.codeRemote:InvokeServer(UnusedVariable1)
            end)
            task.wait(0.1)
        end
    end
})
TabConfig["Auto Rewards"]:AddButton({
    Title = Function8("Collect All Chests"),
    Callback = function()
        local ChestCollection = {
            GameServices.Workspace.mythicalChest.circleInner,
            GameServices.Workspace.magmaChest.circleInner,
            GameServices.Workspace.legendsChest.circleInner,
            GameServices.Workspace.enchantedChest.circleInner,
            GameServices.Workspace.goldenChest.circleInner
        }
        local ChestIndex, ChestKey, ChestValue = ipairs(ChestCollection)
        while true do
            local GameSettings
            ChestValue, GameSettings = ChestIndex(ChestKey, ChestValue)
            if ChestValue == nil then
                break
            end
            pcall(function()
                local PlayerCharacter = GameContext.player.Character
                if PlayerCharacter then
                    PlayerCharacter = GameContext.player.Character:FindFirstChild("HumanoidRootPart")
                end
                if PlayerCharacter then
                    firetouchinterest(PlayerCharacter, GameSettings, 0)
                    firetouchinterest(PlayerCharacter, GameSettings, 1)
                end
            end)
            task.wait(1)
        end
    end
})
TabConfig["Auto Rewards"]:AddToggle({
    Title = Function8("Auto Spin Wheel"),
    Default = false,
    Callback = function(ParameterValue)
        GiftSettings.wheelEnabled = ParameterValue
        if GiftSettings.wheelConnection then
            task.cancel(GiftSettings.wheelConnection)
            GiftSettings.wheelConnection = nil
        end
        if ParameterValue then
            GiftSettings.wheelConnection = task.spawn(function()
                while GiftSettings.wheelEnabled do
                    pcall(function()
                        GameServices.ReplicatedStorage.rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", GameServices.ReplicatedStorage.fortuneWheelChances["Fortune Wheel"])
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})
local TeleportOptions = {
    {
        Title = "Spawn",
        Desc = "Teleport to Spawn Area",
        CFrame = CFrame.new(2, 8, 115)
    },
    {
        Title = "Secret",
        Desc = "Teleport to Secret Area",
        CFrame = CFrame.new(1947, 2, 6191)
    },
    {
        Title = "Tiny",
        Desc = "Teleport to Tiny Area",
        CFrame = CFrame.new(- 34, 7, 1903)
    },
    {
        Title = "Frozen",
        Desc = "Teleport to Frozen",
        CFrame = CFrame.new(- 2600.00244, 3.67686558, - 403.884369, 0.0873617008, 1.0482899e-9, 0.99617666, 3.07204253e-8, 1, - 3.7464023e-9, - 0.99617666, 3.09302628e-8, 0.0873617008)
    },
    {
        Title = "Mythical",
        Desc = "Teleport to Mythical",
        CFrame = CFrame.new(2255, 7, 1071)
    },
    {
        Title = "Inferno",
        Desc = "Teleport to Inferno",
        CFrame = CFrame.new(- 6768, 7, - 1287)
    },
    {
        Title = "Legend",
        Desc = "Teleport to Legend",
        CFrame = CFrame.new(4604, 991, - 3887)
    },
    {
        Title = "Muscle King",
        Desc = "Teleport to Muscle King",
        CFrame = CFrame.new(- 8646, 17, - 5738)
    },
    {
        Title = "Jungle",
        Desc = "Teleport to Jungle",
        CFrame = CFrame.new(- 8659, 6, 2384)
    },
    {
        Title = "Lava Brawl",
        Desc = "Teleport to Lava Brawl",
        CFrame = CFrame.new(4471, 119, - 8836)
    },
    {
        Title = "Desert Brawl",
        Desc = "Teleport to Desert Brawl",
        CFrame = CFrame.new(960, 17, - 7398)
    },
    {
        Title = "Beach Brawl",
        Desc = "Teleport to Beach Brawl",
        CFrame = CFrame.new(- 1849, 20, - 6335)
    }
}
local TeleportIndex, TeleportKey, TeleportValue = ipairs(TeleportOptions)
while true do
    local GameConfig
    TeleportValue, GameConfig = TeleportIndex(TeleportKey, TeleportValue)
    if TeleportValue == nil then
        break
    end
    TabConfig.Teleport:AddButton({
        Title = Function8(GameConfig.Title),
        Content = Function8(GameConfig.Desc),
        Callback = function()
            (GameContext.player.Character or GameContext.player.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame = GameConfig.CFrame
        end
    })
end
TabConfig.Teleport:AddButton({
    Title = "Secret Island",
    Callback = function()
        local VectorPosition = Vector3.new(50000, 50000, 400000)
        local function LocalFunction(FunctionParameter, FunctionArgument, FunctionInput, FunctionData, FunctionInfo)
            local NewPart = Instance.new("Part")
            NewPart.Name = FunctionParameter
            NewPart.Size = FunctionArgument
            NewPart.Position = VectorPosition + FunctionInput
            NewPart.Color = FunctionData or Color3.fromRGB(34, 139, 34)
            NewPart.Material = FunctionInfo or Enum.Material.Grass
            NewPart.Anchored = true
            NewPart.CanCollide = true
            NewPart.Parent = GameServices.Workspace
            return NewPart
        end
        task.spawn(function()
            for LoopCounter = - 1000, 1000, 100 do
                local LoopIndex = LoopCounter
                for LoopValue = - 500, 500, 100 do
                    LocalFunction("Grass" .. LoopIndex .. LoopValue, Vector3.new(100, 2, 100), Vector3.new(LoopIndex, - 1, LoopValue), Color3.fromRGB(34, 139, 34), Enum.Material.Grass)
                    task.wait(0.01)
                end
            end
        end);
        (GameContext.player.Character or GameContext.player.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(VectorPosition + Vector3.new(0, 10, 0))
    end
})
local ItemCollection = {
    ["Blue Crystal"] = {
        "Blue Birdie | Basic",
        "Orange Hedgehog | Basic",
        "Blue Aura | Basic",
        "Green Aura | Basic",
        "Purple Aura | Basic",
        "Red Aura | Basic",
        "Yellow Aura | Basic",
        "Red Kitty | Basic",
        "Dark Vampy | Advanced",
        "Blue Bunny | Basic"
    },
    ["Green Crystal"] = {
        "Silver Dog | Basic",
        "Electro | Advanced",
        "Purple Nova | Advanced",
        "Dark Golem | Advanced",
        "Green Butterfly | Advanced",
        "Crimson Falcon | Rare",
        "Blue Aura | Basic",
        "Green Aura | Basic",
        "Purple Aura | Basic",
        "Red Aura | Basic",
        "Yellow Aura | Basic"
    },
    ["Frost Crystal"] = {
        "Electro | Advanced",
        "Purple Nova | Advanced",
        "Yellow Butterfly | Advanced",
        "Purple Dragon | Rare",
        "Blue Pheonix | Epic",
        "Astral Electro | Rare",
        "Dark Electro | Rare",
        "Power Lightning | Rare",
        "Supernova | Rare",
        "Ultra Inferno | Rare",
        "Ultra Mirage | Rare",
        "Orange Pegasus | Rare"
    },
    ["Mythical Crystal"] = {
        "Astral Electro | Rare",
        "Dark Electro | Rare",
        "Power Lightning | Rare",
        "Supernova | Rare",
        "Ultra Inferno | Rare",
        "Ultra Mirage | Rare",
        "Azure Tundra | Epic",
        "Enchanted Mirage | Epic",
        "Grand Supernova | Epic",
        "Lightning | Epic",
        "Unstable Mirage | Epic",
        "Purple Falcon | Rare",
        "Red Dragon | Rare",
        "Blue Firecaster | Epic",
        "Golden Pheonix | Epic"
    },
    ["Inferno Crystal"] = {
        "Azure Tundra | Epic",
        "Enchanted Mirage | Epic",
        "Grand Supernova | Epic",
        "Lightning | Epic",
        "Unstable Mirage | Epic",
        "Dark Lightning | Unique",
        "Dark Storm | Unique",
        "Entropic Blast | Unique",
        "Eternal Megastrike | Unique",
        "Inferno | Unique",
        "Muscle King | Unique",
        "Red Firecaster | Epic",
        "Infernal Dragon | Unique",
        "White Pegasus | Rare",
        "Golden Pheonix | Epic"
    },
    ["Legends Crystal"] = {
        "Azure Tundra | Epic",
        "Enchanted Mirage | Epic",
        "Grand Supernova | Epic",
        "Lightning | Epic",
        "Unstable Mirage | Epic",
        "Dark Lightning | Unique",
        "Dark Storm | Unique",
        "Entropic Blast | Unique",
        "Eternal Megastrike | Unique",
        "Inferno | Unique",
        "Muscle King | Unique",
        "Ultra Birdie | Unique",
        "Magic Butterfly | Unique",
        "Green Firecaster | Epic",
        "White Pheonix | Epic"
    },
    ["Muscle Elite Crystal"] = {
        "Frostwave Legends Penguin | Rare",
        "Phantom Genesis Dragon | Rare",
        "Dark Legends Manticore | Epic",
        "Ultimate Supernova Pegasus | Epic",
        "Aether Spirit Bunny | Unique",
        "Cybernetic Showdown Dragon | Unique"
    },
    ["Galaxy Oracle Crystal"] = {
        "Eternal Strike Leviathan | Rare",
        "Lightning Strike Phantom | Epic",
        "Darkstar Hunter | Unique",
        "Muscle King Aura | Unique",
        "Azure Tundra Aura | Epic",
        "Ultra Inferno Aura | Rare"
    },
    ["Jungle Crystal"] = {
        "Entropic Blast Aura | Unique",
        "Muscle Sensei | Unique",
        "Grand Supernova Aura | Epic",
        "Neon Guardian | Unique",
        "Eternal Megastrike Aura | Unique",
        "Golden Viking | Epic"
    }
}
local ItemKey, ItemValue, ItemIndex = pairs(ItemCollection)
local TableData = {}
while true do
    local UnusedVariable
    ItemIndex, UnusedVariable = ItemKey(ItemValue, ItemIndex)
    if ItemIndex == nil then
        break
    end
    table.insert(TableData, ItemIndex)
end
table.sort(TableData)
local TableValue = TableData[1]
local NilValue = nil
local BooleanValue = false
local EmptyValue = nil
local DefaultValue = nil
local NumericValue = 1
local function LocalFunction1(FunctionParameter1)
    return ItemCollection[FunctionParameter1] or {}
end
local function LocalFunction2(FunctionParameter2)
    if type(FunctionParameter2) ~= "string" then
        return nil
    else
        return FunctionParameter2:match("^(.-) |") or FunctionParameter2
    end
end
local function LocalFunction3(FunctionParameter3)
    local FunctionResult = LocalFunction1(FunctionParameter3)
    if NilValue then
        NilValue:Refresh(FunctionResult, {})
    end
end
TabConfig.Shop:AddDropdown({
    Title = "Crystal",
    Options = TableData,
    Default = {
        TableValue
    },
    Callback = function(FunctionParameter4)
        if FunctionParameter4 and # FunctionParameter4 > 0 then
            TableValue = FunctionParameter4[1]
            DefaultValue = nil
            LocalFunction3(TableValue)
        end
    end
})
NilValue = TabConfig.Shop:AddDropdown({
    Title = "Pet",
    Options = LocalFunction1(TableValue),
    Default = {},
    Callback = function(FunctionArgument1)
        if FunctionArgument1 and # FunctionArgument1 > 0 then
            DefaultValue = LocalFunction2(FunctionArgument1[1])
        else
            DefaultValue = nil
        end
    end
})
TabConfig.Shop:AddInput({
    Title = "Buy Speed (seconds)",
    Content = "How fast to buy pets (0-10 seconds)",
    Default = "1",
    PlaceholderText = "Enter speed in seconds",
    Callback = function(FunctionInput1)
        local NumericInput = tonumber(FunctionInput1)
        if NumericInput and (0 <= NumericInput and NumericInput <= 10) then
            NumericValue = NumericInput
        else
            NumericValue = 1
        end
    end
})
TabConfig.Shop:AddToggle({
    Title = "Auto Buy Selected Pet",
    Default = false,
    Callback = function(FunctionData1)
        BooleanValue = FunctionData1
        if EmptyValue then
            EmptyValue:Disconnect()
            EmptyValue = nil
        end
        if FunctionData1 then
            spawn(function()
                while BooleanValue do
                    if DefaultValue then
                        pcall(function()
                            local ChildObject = GameServices.ReplicatedStorage.cPetShopFolder:FindFirstChild(DefaultValue)
                            if ChildObject then
                                GameServices.ReplicatedStorage.cPetShopRemote:InvokeServer(ChildObject)
                            end
                        end)
                    end
                    wait(NumericValue)
                end
            end)
        end
    end
})
local EmptyObject = nil
local NullObject = nil
TabConfig.Ultimates:AddDropdown({
    Title = "Ultimate",
    Options = {
        "+1 Daily Spin",
        "+1 Pet Slot",
        "+10 Item Capacity",
        "+5% Rep Speed",
        "Demon Damage",
        "Galaxy Gains",
        "Golden Rebirth",
        "Jungle Swift",
        "Muscle Mind",
        "x2 Chest Rewards",
        "x2 Quest Rewards"
    },
    Default = {},
    Callback = function(FunctionInfo1)
        EmptyObject = FunctionInfo1 and FunctionInfo1[1] or nil
    end
})
TabConfig.Ultimates:AddToggle({
    Title = "Auto Upgrade Ultimate",
    Default = false,
    Callback = function(FunctionInfo2)
        if NullObject then
            NullObject:Disconnect()
            NullObject = nil
        end
        if FunctionInfo2 then
            NullObject = GameServices.RunService.Heartbeat:Connect(function()
                if EmptyObject then
                    pcall(function()
                        GameServices.ReplicatedStorage.rEvents.ultimatesRemote:InvokeServer("upgradeUltimate", EmptyObject)
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})
local StringCollection = {
    "Swift Samurai",
    "Wild Wizard",
    "Tribal Overlord",
    "Mighty Monster",
    "Sarge",
    "Small Fry",
    "Speedy Sally",
    "Chaos Sorcerer"
}
local function LocalFunction4()
    pcall(function()
        local StringKey, StringValue, StringIndex = pairs(StringCollection)
        while true do
            local UnusedString
            StringIndex, UnusedString = StringKey(StringValue, StringIndex)
            if StringIndex == nil then
                break
            end
            GameServices.ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", UnusedString)
        end
    end)
end
local function LocalFunction5(FunctionParameter5)
    pcall(function()
        LocalFunction4()
        task.wait(0.1)
        GameServices.ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", FunctionParameter5)
    end)
end
local StringItem, StringData, StringInfo = pairs(StringCollection)
while true do
    local ObjectReference
    StringInfo, ObjectReference = StringItem(StringData, StringInfo)
    if StringInfo == nil then
        break
    end
    TabConfig["Equip Pets"]:AddButton({
        Title = "Equip " .. ObjectReference,
        Callback = function()
            LocalFunction5(ObjectReference)
        end
    })
end
local TableCollection = {
    {
        name = "Tiny Rock",
        durability = 0
    },
    {
        name = "Punching Rock",
        durability = 10
    },
    {
        name = "Large Rock",
        durability = 100
    },
    {
        name = "Golden Rock",
        durability = 5000
    },
    {
        name = "Frost Rock",
        durability = 150000
    },
    {
        name = "Mythical Rock",
        durability = 400000
    },
    {
        name = "Inferno Rock",
        durability = 750000
    },
    {
        name = "Legend Rock",
        durability = 1000000
    },
    {
        name = "Muscle King Rock",
        durability = 5000000
    },
    {
        name = "Jungle Rock",
        durability = 10000000
    }
}
local TableIndex, TableKey, TableValue1 = ipairs(TableCollection)
local EmptyTable = {}
local ConfigTable = {
    selectedRock = nil,
    autoFarmConnection = nil,
    isAutoFarmEnabled = false
}
while true do
    local UnusedTable
    TableValue1, UnusedTable = TableIndex(TableKey, TableValue1)
    if TableValue1 == nil then
        break
    end
    table.insert(EmptyTable, UnusedTable.name)
end
TabConfig.RocksSection:AddDropdown({
    Title = "Rocks",
    Options = EmptyTable,
    Default = {},
    Callback = function(FunctionParameter6)
        ConfigTable.selectedRock = FunctionParameter6 and FunctionParameter6[1] or nil
    end
})
TabConfig.RocksSection:AddToggle({
    Title = Function8("Faster Farm Punch"),
    Default = false,
    Callback = function(FunctionArgument2)
        _G.FasterFarmPunch = FunctionArgument2
        local PlayerReference = GameContext.player
        local ChildName = PlayerReference
        local BackpackReference = PlayerReference.WaitForChild(ChildName, "Backpack")
        local function LocalFunction6()
            local PunchObject = BackpackReference:FindFirstChild("Punch")
            if PunchObject and PunchObject:FindFirstChild("attackTime") then
                PunchObject.attackTime.Value = FunctionArgument2 and 0 or 0.35
            end
            local CharacterReference = PlayerReference.Character
            if CharacterReference then
                CharacterReference = PlayerReference.Character:FindFirstChild("Punch")
            end
            if CharacterReference and CharacterReference:FindFirstChild("attackTime") then
                CharacterReference.attackTime.Value = FunctionArgument2 and 0 or 0.35
            end
        end
        LocalFunction6()
        if FunctionArgument2 then
            task.spawn(function()
                while _G.FasterFarmPunch do
                    LocalFunction6()
                    task.wait(1)
                end
            end)
        end
    end
})
TabConfig.RocksSection:AddToggle({
    Title = "Auto Rock Farm",
    Default = false,
    Callback = function(FunctionParameter7)
        ConfigTable.isAutoFarmEnabled = FunctionParameter7
        if ConfigTable.autoFarmConnection then
            task.cancel(ConfigTable.autoFarmConnection)
            ConfigTable.autoFarmConnection = nil
        end
        if not (FunctionParameter7 and ConfigTable.selectedRock) then
            return
        end
        local TableItem, TableData1, TableInfo1 = ipairs(TableCollection)
        local NullValue = nil
        while true do
            local DurabilityConfig
            TableInfo1, DurabilityConfig = TableItem(TableData1, TableInfo1)
            if TableInfo1 == nil then
                DurabilityConfig = NullValue
                break
            end
            if DurabilityConfig.name == ConfigTable.selectedRock then
                break
            end
        end
        if DurabilityConfig then
            ConfigTable.autoFarmConnection = task.spawn(function()
                while true do
                    if not (ConfigTable.isAutoFarmEnabled and ConfigTable.selectedRock) then
                        return
                    end
                    local CharacterModel = GameServices.Players.LocalPlayer.Character
                    local BackpackModel = GameServices.Players.LocalPlayer.Backpack
                    local DurabilityObject = GameServices.Players.LocalPlayer:FindFirstChild("Durability")
                    local MachineCollection = CharacterModel and (DurabilityObject and DurabilityObject.Value >= DurabilityConfig.durability) and GameServices.Workspace:FindFirstChild("machinesFolder")
                    if MachineCollection then
                        local MachineIndex, MachineKey, MachineValue = ipairs(MachineCollection:GetChildren())
                        while true do
                            local MachineReference
                            MachineValue, MachineReference = MachineIndex(MachineKey, MachineValue)
                            if MachineValue == nil or not ConfigTable.isAutoFarmEnabled then
                                break
                            end
                            local NeededDurability = MachineReference:FindFirstChild("neededDurability")
                            local RockObject = MachineReference:FindFirstChild("Rock")
                            if NeededDurability and (RockObject and NeededDurability.Value == DurabilityConfig.durability) then
                                if not CharacterModel:FindFirstChild("Punch") and (BackpackModel and BackpackModel:FindFirstChild("Punch")) then
                                    BackpackModel.Punch.Parent = CharacterModel
                                    task.wait(0.1)
                                end
                                local PunchTool = CharacterModel:FindFirstChild("Punch")
                                if PunchTool then
                                    local LeftHand = CharacterModel:FindFirstChild("LeftHand")
                                    local RightHand = CharacterModel:FindFirstChild("RightHand")
                                    if LeftHand and RightHand then
                                        pcall(function()
                                            for UnusedParameter = 1, 3 do
                                                firetouchinterest(LeftHand, RockObject, 0)
                                                firetouchinterest(LeftHand, RockObject, 1)
                                                firetouchinterest(RightHand, RockObject, 0)
                                                firetouchinterest(RightHand, RockObject, 1)
                                            end
                                            local MuscleEvent = GameServices.Players.LocalPlayer:FindFirstChild("muscleEvent")
                                            if MuscleEvent then
                                                MuscleEvent:FireServer("punch", "leftHand")
                                                MuscleEvent:FireServer("punch", "rightHand")
                                            end
                                            PunchTool:Activate()
                                        end)
                                    end
                                end
                                break
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})
local function LocalFunction7(UnusedParameter, ParameterValue, PlayerData, UserData)
    TabConfig["Auto Treadmill"]:AddToggle({
        Title = ParameterValue,
        Default = false,
        Callback = function(GameStats)
            local LocalPlayer = GameServices.Players.LocalPlayer
            local CharacterModel = LocalPlayer.Character
            if CharacterModel and (CharacterModel:FindFirstChild("HumanoidRootPart") and CharacterModel:FindFirstChild("Humanoid")) then
                local HumanoidComponent = CharacterModel:FindFirstChild("Humanoid")
                local RootPart = CharacterModel.HumanoidRootPart
                if LocalPlayer:FindFirstChild("Agility") and PlayerData <= LocalPlayer.Agility.Value then
                    if GameStats then
                        RootPart.CFrame = UserData
                        task.wait(0.2)
                        RootPart.Anchored = true
                        local HeartbeatConnection = GameServices.RunService.Heartbeat:Connect(function()
                            if HumanoidComponent then
                                HumanoidComponent:Move(Vector3.new(0, 0, - 1), false)
                            end
                        end)
                        local function FunctionHandler()
                            if HeartbeatConnection then
                                HeartbeatConnection:Disconnect()
                                HeartbeatConnection = nil
                            end
                            if RootPart and RootPart.Parent then
                                RootPart.Anchored = false
                                RootPart.Velocity = Vector3.new(0, 0, 0)
                                RootPart.RotVelocity = Vector3.new(0, 0, 0)
                            end
                            if HumanoidComponent then
                                HumanoidComponent:ChangeState(Enum.HumanoidStateType.Freefall)
                            end
                        end
                        local CharacterAddedEvent = LocalPlayer.CharacterAdded:Connect(function()
                            FunctionHandler()
                        end)
                        task.spawn(function()
                            repeat
                                task.wait(0.1)
                            until not GameStats
                            FunctionHandler()
                            if CharacterAddedEvent then
                                CharacterAddedEvent:Disconnect()
                            end
                        end)
                    else
                        if RootPart then
                            RootPart.Anchored = false
                            RootPart.Velocity = Vector3.new(0, 0, 0)
                            RootPart.RotVelocity = Vector3.new(0, 0, 0)
                        end
                        if HumanoidComponent then
                            HumanoidComponent:ChangeState(Enum.HumanoidStateType.Freefall)
                        end
                    end
                end
            end
        end
    })
end
LocalFunction7(TabConfig["Auto Treadmill"], "Auto Tiny Gym Treadmill [ 0 Agility ]", 0, CFrame.new(55, 5, 1947))
LocalFunction7(TabConfig["Auto Treadmill"], "Auto Spawn Gym Treadmill [ 600 Agility ]", 600, CFrame.new(- 230, 8, - 105))
LocalFunction7(TabConfig["Auto Treadmill"], "Auto Legend Beach Treadmill [ 1000 Agility ]", 1000, CFrame.new(- 416, 13, - 261))
LocalFunction7(TabConfig["Auto Treadmill"], "Auto Frost Gym Treadmill [ 3000 Agility ]", 3000, CFrame.new(- 2970, 29, - 473))
LocalFunction7(TabConfig["Auto Treadmill"], "Auto Mythical Gym Treadmill [ 3000 Agility ]", 3000, CFrame.new(2573, 15, 892))
LocalFunction7(TabConfig["Auto Treadmill"], "Auto Inferno Gym Treadmill [ 3500 Agility ]", 3500, CFrame.new(- 7097, 36, - 1453))
LocalFunction7(TabConfig["Auto Treadmill"], "Auto Legend Gym Treadmill [ 3000 Agility ]", 3000, CFrame.new(4366, 1005, - 3630))
LocalFunction7(TabConfig["Auto Treadmill"], "Auto Jungle Gym Gym Treadmill [ 20K Agility Needed ]", 20000, CFrame.new(- 8132, 34, 2825))
local LocationData = {
    ["Bar Lift"] = {
        Spawn = CFrame.new(134, 3, 96),
        ["Legend Beach"] = CFrame.new(- 79, 7, - 500),
        ["Frost Gym"] = CFrame.new(- 3010, 43, - 336),
        ["Legend Gym"] = CFrame.new(4533, 987, - 4003),
        ["Muscle King Gym"] = CFrame.new(- 8776, 13, - 5664),
        ["Jungle Gym"] = CFrame.new(- 8654, 3, 2072)
    },
    ["Bench Press"] = {
        ["Tiny Gym"] = CFrame.new(- 97, 6, 1900),
        Spawn = CFrame.new(75, 7, 350),
        ["Legend Beach"] = CFrame.new(198, 15, - 375),
        ["Frost Gym"] = CFrame.new(- 3012, 39, - 339),
        ["Mythical Gym"] = CFrame.new(2368, 43, 1247),
        ["Inferno Gym"] = CFrame.new(- 7175, 49, - 1105),
        ["Legend Gym"] = CFrame.new(4101, 1020, - 3795),
        ["Muscle King Gym"] = CFrame.new(- 8593, 52, - 6044),
        ["Jungle Gym"] = CFrame.new(- 8177, 60, 1913)
    },
    Squat = {
        Spawn = CFrame.new(231, 7, 22),
        ["Legend Beach"] = CFrame.new(- 203, 7, - 422),
        ["Frost Gym"] = CFrame.new(- 2719, 7, - 593),
        ["Legend Gym"] = CFrame.new(4436, 991, - 4056),
        ["Muscle King Gym"] = CFrame.new(- 8760, 13, - 6041),
        ["Jungle Gym"] = CFrame.new(- 8377, 50, 2860)
    },
    ["Pull Up"] = {
        Spawn = CFrame.new(- 184, 4, 136),
        ["Mythical Gym"] = CFrame.new(2486, 7, 848),
        ["Legend Gym"] = CFrame.new(4301, 991, - 4125)
    },
    Boulder = {
        ["Mythical Gym"] = CFrame.new(2664, 7, 1208),
        ["Muscle King Gym"] = CFrame.new(- 8949, 17, - 5693),
        ["Jungle Gym"] = CFrame.new(- 8617, 6, 2686)
    }
}
local AutoFarmData = {
    ["Auto Bar Lift"] = "Bar Lift",
    ["Auto Bench Press"] = "Bench Press",
    ["Auto Squats"] = "Squat",
    ["Auto PullUps"] = "Pull Up",
    ["Auto Boulder"] = "Boulder"
}
local function FarmFunction()
    GameServices.VirtualInputManager:SendKeyEvent(true, "E", false, game)
    task.wait(0.1)
    GameServices.VirtualInputManager:SendKeyEvent(false, "E", false, game)
end
local function FarmHandler(ToolName)
    local ToolObject = LocalPlayerReference.Backpack:FindFirstChild(ToolName)
    if not (ToolObject and LocalPlayerReference.Character and LocalPlayerReference.Character:FindFirstChild("Humanoid")) then
        return false
    end
    LocalPlayerReference.Character.Humanoid:EquipTool(ToolObject)
    return true
end
local function FunctionCaller(ParameterName)
    local CharacterObject = LocalPlayerReference.Character
    if CharacterObject then
        CharacterObject = LocalPlayerReference.Character:FindFirstChild(ParameterName) ~= nil
    end
    return CharacterObject
end
local function EventHandler()
    LocalPlayerReference.muscleEvent:FireServer("rep")
end
local function FunctionInvoker(LocationKey, LocationValue)
    if not (LocalPlayerReference and LocalPlayerReference.Character and LocalPlayerReference.Character:FindFirstChild("HumanoidRootPart")) then
        return false
    end
    if not (LocationData[LocationValue] and LocationData[LocationValue][LocationKey]) then
        return false
    end
    local LocationCFrame = LocationData[LocationValue][LocationKey]
    LocalPlayerReference.Character.HumanoidRootPart.CFrame = LocationCFrame
    return true
end
local function FunctionResult(FarmType)
    local FarmName = AutoFarmData[FarmType]
    local FarmData = TabConfig[FarmType]
    if FarmData then
        local FarmKey, FarmValue, FarmIndex = pairs(LocationData[FarmName])
        while true do
            local FarmToggle, UnusedParameter = FarmKey(FarmValue, FarmIndex)
            if FarmToggle == nil then
                break
            end
            FarmIndex = FarmToggle
            local FarmButton = FarmType .. FarmToggle .. "Toggle"
            FarmData:AddToggle({
                "Auto " .. FarmName .. " - " .. FarmToggle,
                "Teleports to " .. FarmToggle .. " to perform " .. FarmName,
                false,
                function(ParameterIndex)
                    _G[FarmButton] = ParameterIndex
                    if ParameterIndex then
                        task.spawn(function()
                            while _G[FarmButton] do
                                if not FunctionInvoker(FarmToggle, FarmName) then
                                    _G[FarmButton] = false
                                    break
                                end
                                task.wait(1)
                                FarmFunction()
                                local FarmObject = FarmName
                                if not FunctionCaller(FarmObject) then
                                    FarmHandler(FarmObject)
                                end
                                EventHandler()
                                task.wait(0.1)
                                task.wait(0.1)
                            end
                            task.wait(0.1)
                        end)
                    end
                end
            })
        end
    end
end
local FarmList, FarmIndex1, FarmIndex2 = ipairs({
    "Auto Bar Lift",
    "Auto Bench Press",
    "Auto Squats",
    "Auto PullUps",
    "Auto Boulder"
})
while true do
    local UnusedVariable
    FarmIndex2, UnusedVariable = FarmList(FarmIndex1, FarmIndex2)
    if FarmIndex2 == nil then
        break
    end
    FunctionResult(UnusedVariable)
end
local function RebirthFunction(RebirthParameter)
    return RebirthParameter == 0 and "0" or string.format("%d", math.floor(RebirthParameter)):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end
local function RebirthHandler(TimeValue)
    if TimeValue == 0 then
        return "0"
    else
        local AbsoluteTime = math.abs(TimeValue)
        if AbsoluteTime >= 1000000000000 then
            return string.format("%.0fT", TimeValue / 1000000000000)
        elseif AbsoluteTime >= 1000000000 then
            return string.format("%.0fB", TimeValue / 1000000000)
        elseif AbsoluteTime >= 1000000 then
            return string.format("%.0fM", TimeValue / 1000000)
        elseif AbsoluteTime >= 1000 then
            return string.format("%.0fK", TimeValue / 1000)
        else
            return string.format("%d", math.floor(TimeValue))
        end
    end
end
local function TimeFunction(TimeParameter)
    if TimeParameter < 60 then
        return string.format("%ds", math.floor(TimeParameter))
    end
    if TimeParameter < 3600 then
        local MinutesValue = math.floor(TimeParameter / 60)
        local SecondsValue = math.floor(TimeParameter % 60)
        return string.format("%dm %ds", MinutesValue, SecondsValue)
    end
    local HoursValue = math.floor(TimeParameter / 3600)
    local MinutesRemainder = math.floor(TimeParameter % 3600 / 60)
    local SecondsRemainder = math.floor(TimeParameter % 60)
    return string.format("%dh %dm %ds", HoursValue, MinutesRemainder, SecondsRemainder)
end
_G.displayTargetRebirth = math.huge
local GameServices = {
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    HttpService = game:GetService("HttpService"),
    UserInputService = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    VirtualInputManager = game:GetService("VirtualInputManager"),
    Workspace = game:GetService("Workspace"),
    Lighting = game:GetService("Lighting")
}
local GameContext = {
    player = GameServices.Players.LocalPlayer,
    replicatedStorage = GameServices.ReplicatedStorage,
    terrain = GameServices.Workspace:FindFirstChildOfClass("Terrain"),
    rebirthRemote = GameServices.ReplicatedStorage.rEvents.rebirthRemote,
    leaderstats = nil,
    rebirthsStat = nil
}
GameContext.leaderstats = GameContext.player:WaitForChild("leaderstats")
GameContext.rebirthsStat = GameContext.leaderstats:WaitForChild("Rebirths")
local RebirthsValue = GameContext.rebirthsStat.Value
local StartTime = os.time()
local InitialValue = 0
local EndTime = os.time()
local RebirthsStat = GameContext.rebirthsStat.Value
local NilValue = nil
local TableData = {}
local TimeoutValue = 300
local NilResult = nil
local BooleanValue = false
local InfiniteValue = math.huge
local FalseValue = false
local NilObject = nil
local FalseResult = false
local NilReference = nil
local function FunctionCaller1()
    local RebirthsStatValue = GameContext.rebirthsStat.Value
    local CurrentTime = os.time()
    local TimeElapsed = CurrentTime - StartTime
    local RebirthsDiff = RebirthsStatValue - RebirthsValue
    if NilValue and CurrentTime - EndTime >= 10 then
        InitialValue = 0
        NilValue = nil
    end
    local InitialRebirths = 0
    if InitialValue <= 0 or not NilValue then
        if # TableData >= 2 then
            local FirstRebirth = TableData[1]
            local LastRebirth = TableData[# TableData]
            local RebirthTimeDiff = LastRebirth.time - FirstRebirth.time
            if RebirthTimeDiff > 0 then
                InitialRebirths = (LastRebirth.value - FirstRebirth.value) / RebirthTimeDiff * 60
            end
        end
    else
        InitialRebirths = InitialValue / math.max(1, CurrentTime - NilValue) * 60
    end
    local MinutesElapsed = InitialRebirths * 60
    local HoursElapsed = MinutesElapsed * 24
    local DaysElapsed = HoursElapsed * 7
    local MonthsElapsed = HoursElapsed * 30
    local YearsElapsed = HoursElapsed * 365
    local TimeString = TimeFunction and TimeFunction(TimeElapsed) or tostring(TimeElapsed)
    local UnusedVariable1
    if _G.displayTargetRebirth and _G.displayTargetRebirth ~= math.huge then
        local RebirthString = RebirthFunction and RebirthFunction(RebirthsStatValue) or tostring(RebirthsStatValue)
        local TargetRebirthString = RebirthFunction and RebirthFunction(_G.displayTargetRebirth) or tostring(_G.displayTargetRebirth)
        UnusedVariable1 = string.format("%s/%s", RebirthString, TargetRebirthString)
    else
        local RebirthDisplay = RebirthFunction and RebirthFunction(RebirthsStatValue) or tostring(RebirthsStatValue)
        UnusedVariable1 = string.format("%s/\226\136\158", RebirthDisplay)
    end
    local function FunctionHandler1(ParameterValue1)
        return RebirthFunction and RebirthFunction(ParameterValue1) or tostring(ParameterValue1), RebirthHandler and RebirthHandler(ParameterValue1) or tostring(ParameterValue1)
    end
    local FunctionResult1, FunctionResult2 = FunctionHandler1(RebirthsStatValue)
    local FunctionResult3, FunctionResult4 = FunctionHandler1(RebirthsDiff)
    local FunctionResult5, FunctionResult6 = FunctionHandler1(InitialRebirths)
    local FunctionResult7, FunctionResult8 = FunctionHandler1(MinutesElapsed)
    local FunctionResult9, FunctionResult10 = FunctionHandler1(HoursElapsed)
    local RebirthValue1, RebirthValue2 = FunctionHandler1(DaysElapsed)
    local RebirthValue3, RebirthValue4 = FunctionHandler1(MonthsElapsed)
    local RebirthValue5, RebirthValue6 = FunctionHandler1(YearsElapsed)
    local RebirthInfo = string.format("> Rebirths: %s | %s\n> Gained: %s | %s\n> Target: %s\n> Timer: %s\n> Per Minute: %s | %s\n> Per Hour: %s | %s\n> Per Day: %s | %s\n> Per Week: %s | %s\n> Per Month: %s | %s\n> Per Year: %s | %s\n", FunctionResult1, FunctionResult2, FunctionResult3, FunctionResult4, UnusedVariable1, TimeString, FunctionResult5, FunctionResult6, FunctionResult7, FunctionResult8, FunctionResult9, FunctionResult10, RebirthValue1, RebirthValue2, RebirthValue3, RebirthValue4, RebirthValue5, RebirthValue6)
    if NilResult and NilResult.Set then
        NilResult:Set({
            Content = RebirthInfo
        })
    end
end
GameContext.rebirthsStat.Changed:Connect(function()
    local RebirthsStat = GameContext.rebirthsStat.Value
    local RebirthsDiff = RebirthsStat - RebirthsStat
    if RebirthsDiff > 0 then
        InitialValue = InitialValue + RebirthsDiff
        if not NilValue then
            NilValue = os.time()
        end
        EndTime = os.time()
    end
    RebirthsStat = RebirthsStat
    FunctionCaller1()
end)
local function GetPetsFunction()
    local PetsFolder = GameContext.player:FindFirstChild("petsFolder")
    if PetsFolder then
        local PetChild1, PetChild2, PetChild3 = pairs(PetsFolder:GetChildren())
        while true do
            local PetsContainer
            PetChild3, PetsContainer = PetChild1(PetChild2, PetChild3)
            if PetChild3 == nil then
                break
            end
            if PetsContainer:IsA("Folder") then
                local PetItem1, PetItem2, PetItem3 = pairs(PetsContainer:GetChildren())
                while true do
                    local PetItemsContainer
                    PetItem3, PetItemsContainer = PetItem1(PetItem2, PetItem3)
                    if PetItem3 == nil then
                        break
                    end
                    GameContext.replicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", PetItemsContainer)
                end
            end
        end
        task.wait(0.25)
    end
end
local function GetUniquePetsFunction(PetParameter1, PetParameter2)
    GetPetsFunction()
    task.wait(0.2)
    local UniquePetsFolder = GameContext.player:FindFirstChild("petsFolder")
    if not UniquePetsFolder then
        return 0
    end
    local UniquePetItem = UniquePetsFolder:FindFirstChild("Unique")
    if not UniquePetItem then
        return 0
    end
    local UniquePetChild1, UniquePetChild2, UniquePetChild3 = pairs(UniquePetItem:GetChildren())
    local PetTable = {}
    while true do
        local PetContainer
        UniquePetChild3, PetContainer = UniquePetChild1(UniquePetChild2, UniquePetChild3)
        if UniquePetChild3 == nil then
            break
        end
        if PetContainer.Name == PetParameter1 then
            table.insert(PetTable, PetContainer)
        end
    end
    local MinPetValue = math.min(PetParameter2, # PetTable)
    for PetLoopCounter = 1, MinPetValue do
        GameContext.replicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", PetTable[PetLoopCounter])
        task.wait(0.1)
    end
    task.wait(0.25)
    return MinPetValue
end
local function FarmFunction1(FarmParameter1)
    local MachinesFolder = GameServices.Workspace:FindFirstChild("machinesFolder")
    local MachineItem = MachinesFolder and MachinesFolder:FindFirstChild(FarmParameter1)
    if MachineItem then
        return MachineItem
    end
    local MachineChild1, MachineChild2, MachineChild3 = pairs(GameServices.Workspace:GetChildren())
    while true do
        local MachinesContainer
        MachineChild3, MachinesContainer = MachineChild1(MachineChild2, MachineChild3)
        if MachineChild3 == nil then
            break
        end
        if MachinesContainer:IsA("Folder") and MachinesContainer.Name:find("machines") then
            local MachineItemContainer = MachinesContainer:FindFirstChild(FarmParameter1)
            if MachineItemContainer then
                return MachineItemContainer
            end
        end
    end
    return nil
end
local function GetMachineFunction()
    GameServices.VirtualInputManager:SendKeyEvent(true, "E", false, game)
    task.wait(0.1)
    GameServices.VirtualInputManager:SendKeyEvent(false, "E", false, game)
end
local function GetMachineFunction2(MachineParameter1)
    FalseResult = MachineParameter1
    if MachineParameter1 and GameContext.player.Character and GameContext.player.Character:FindFirstChild("HumanoidRootPart") then
        NilReference = GameContext.player.Character.HumanoidRootPart.CFrame
        if not _G.positionConnection then
            _G.positionConnection = GameServices.RunService.Heartbeat:Connect(function()
                if FalseResult and GameContext.player.Character and GameContext.player.Character:FindFirstChild("HumanoidRootPart") then
                    GameContext.player.Character.HumanoidRootPart.CFrame = NilReference
                    GameContext.player.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    GameContext.player.Character.HumanoidRootPart.RotVelocity = Vector3.new(0, 0, 0)
                end
            end)
        end
    elseif not MachineParameter1 and _G.positionConnection then
        _G.positionConnection:Disconnect()
        _G.positionConnection = nil
    end
end
local RebirthTable = {
    [0] = 1,
    [1] = 2,
    [2] = 4,
    [3] = 6,
    [4] = 8,
    [5] = 10,
    [6] = 12,
    [7] = 14,
    [8] = 16
}
local function GetRebirthFunction(RebirthParameter1, RebirthParameter2)
    local RebirthDiff = RebirthParameter2 - RebirthParameter1
    if RebirthDiff <= 0 then
        return 0
    end
    if RebirthDiff == 1 then
        return 0
    end
    for RebirthLoopCounter1 = 1, 8 do
        if RebirthTable[RebirthLoopCounter1] == RebirthDiff then
            return RebirthLoopCounter1
        end
    end
    for RebirthLoopCounter2 = 8, 1, - 1 do
        if RebirthTable[RebirthLoopCounter2] < RebirthDiff then
            local RebirthValueDiff = RebirthDiff - RebirthTable[RebirthLoopCounter2]
            if RebirthValueDiff == 1 then
                return RebirthLoopCounter2
            end
            for RebirthLoopCounter3 = 8, 0, - 1 do
                if RebirthTable[RebirthLoopCounter3] == RebirthValueDiff then
                    return RebirthLoopCounter2
                end
            end
            return RebirthLoopCounter2
        end
    end
    return 0
end
local function GetRebirthFunction2()
    GetMachineFunction2(true)
    while true do
        while true do
            if not FalseValue then
                GetPetsFunction()
                GetMachineFunction2(false)
                return
            end
            local RebirthTime = tonumber(InfiniteValue) or math.huge
            local RebirthsValue = GameContext.rebirthsStat.Value
            if RebirthTime > RebirthsValue then
                break
            end
            GetUniquePetsFunction("Swift Samurai", 8)
            local MuscleEvent = GameContext.player:FindFirstChild("muscleEvent")
            if MuscleEvent then
                while FalseValue and RebirthTime <= RebirthsValue and RebirthsValue >= (tonumber(InfiniteValue) or math.huge) do
                    for UnusedParameter = 1, 17 do
                        if not FalseValue then
                            break
                        end
                        MuscleEvent:FireServer("rep")
                    end
                    task.wait(0.1)
                    RebirthsValue = GameContext.rebirthsStat.Value
                end
            else
                task.wait(0.5)
            end
        end
        local RebirthRequirement = 10000 + 5000 * RebirthsValue
        local UltimatesFolder = GameContext.player:FindFirstChild("ultimatesFolder")
        if UltimatesFolder then
            local GoldenRebirthItem = UltimatesFolder:FindFirstChild("Golden Rebirth")
            if GoldenRebirthItem and GoldenRebirthItem.Value then
                RebirthRequirement = math.floor(RebirthRequirement * (1 - GoldenRebirthItem.Value * 0.1))
            end
        end
        local StrengthStat = GameContext.leaderstats:FindFirstChild("Strength")
        local StrengthValue = StrengthStat and (StrengthStat.Value or 0) or 0
        local CanRebirth = RebirthRequirement <= StrengthValue
        local TimeUntilRebirth = RebirthTime - RebirthsValue
        local IsRebirthReady = true
        if CanRebirth then
            if TimeUntilRebirth > 1 then
                GetUniquePetsFunction("Tribal Overlord", (GetRebirthFunction(RebirthsValue, RebirthTime)))
            else
                GetPetsFunction()
            end
        else
            GetUniquePetsFunction("Swift Samurai", 8)
            local MuscleEvent2 = GameContext.player:FindFirstChild("muscleEvent")
            if MuscleEvent2 then
                while FalseValue and (StrengthValue < RebirthRequirement and GameContext.rebirthsStat.Value < RebirthTime) do
                    for UnusedParameter = 1, 12 do
                        MuscleEvent2:FireServer("rep")
                    end
                    task.wait()
                    StrengthValue = StrengthStat and (StrengthStat.Value or 0) or 0
                end
                if RebirthTime <= GameContext.rebirthsStat.Value or not FalseValue then
                    IsRebirthReady = false
                end
            end
        end
        if IsRebirthReady and (CanRebirth and FalseValue) then
            local FarmResult1 = FarmFunction1("Jungle Bar Lift")
            if FarmResult1 and GameContext.player.Character and (GameContext.player.Character:FindFirstChild("HumanoidRootPart") and FarmResult1:FindFirstChild("interactSeat")) then
                GameContext.player.Character.HumanoidRootPart.CFrame = FarmResult1.interactSeat.CFrame * CFrame.new(0, 3, 0)
                local Humanoid = GameContext.player.Character:FindFirstChild("Humanoid")
                if Humanoid then
                    repeat
                        GetMachineFunction()
                        task.wait(0.1)
                    until Humanoid.Sit or not FalseValue
                end
            end
            repeat
                GameContext.rebirthRemote:InvokeServer("rebirthRequest")
                task.wait(0.13)
            until RebirthsValue < GameContext.rebirthsStat.Value or not FalseValue
            task.wait(0.33)
        end
    end
end
NilResult = TabConfig["Rebirth Status"]:AddParagraph({
    Title = "Rebirth Status",
    Content = "Loading..."
})
FunctionCaller1()
TabConfig["Pack Farm | Target Rebirth"]:AddInput({
    Title = "Target Rebirth Amount",
    Content = "Set the target number of rebirths to reach",
    Default = "",
    Callback = function(Parameter1)
        local ParameterValue = tonumber(Parameter1)
        if ParameterValue and 0 < ParameterValue then
            InfiniteValue = ParameterValue
            _G.displayTargetRebirth = ParameterValue
        else
            InfiniteValue = math.huge
            _G.displayTargetRebirth = math.huge
        end
    end
})
local GetToggleFunction = TabConfig["Pack Farm | Target Rebirth"]:AddToggle({
    Title = "Enable Target Pack Farm",
    Default = false,
    Callback = function(ToggleParameter1)
        BooleanValue = ToggleParameter1
        FalseValue = ToggleParameter1
        if ToggleParameter1 then
            TabConfig["Pack Farm | Rebirth"]:GetElement("Pack Farm | Infinite").Value = false
            if NilObject then
                task.cancel(NilObject)
            end
            NilObject = task.spawn(GetRebirthFunction2)
        else
            if NilObject then
                FalseValue = false
                task.cancel(NilObject)
                NilObject = nil
            end
            GetPetsFunction()
            GetMachineFunction2(false)
        end
    end
})
TabConfig["Pack Farm | Rebirth"]:AddToggle({
    Title = "Pack Farm | Infinite",
    Content = "",
    Default = false,
    Id = "Pack Farm | Infinite",
    Callback = function(ToggleParameter2)
        if ToggleParameter2 then
            GetToggleFunction.Value = false
            InfiniteValue = math.huge
            _G.displayTargetRebirth = math.huge
            BooleanValue = true
            FalseValue = true
            if NilObject then
                task.cancel(NilObject)
            end
            NilObject = task.spawn(GetRebirthFunction2)
        else
            BooleanValue = false
            FalseValue = false
            if NilObject then
                task.cancel(NilObject)
                NilObject = nil
            end
            GetPetsFunction()
            GetMachineFunction2(false)
        end
    end
})
spawn(function()
    local CurrentTime = os.time()
    local RebirthInfoTable = {
        time = CurrentTime,
        value = GameContext.rebirthsStat.Value
    }
    table.insert(TableData, RebirthInfoTable)
    FunctionCaller1()
    task.wait(1)
    table.remove(TableData, 1)
    if # TableData <= 0 or TimeoutValue >= CurrentTime - TableData[1].time then
    else
    end
end)
local function GetRebirthInfoFunction()
    while true do
        if not fastStrengthEnabled then
            return
        end
        local MuscleEvent3 = GameContext.player:FindFirstChild("muscleEvent")
        if MuscleEvent3 then
            for UnusedParameter = 1, 17 do
                if not fastStrengthEnabled then
                    break
                end
                MuscleEvent3:FireServer("rep")
            end
        end
        task.wait(0)
    end
end
TabConfig["Fast Strength"]:AddToggle({
    Title = "Fast Strength Toggle",
    Content = "",
    Default = false,
    Callback = function(RebirthInfoParameter)
        fastStrengthEnabled = RebirthInfoParameter
        if RebirthInfoParameter then
            if fastStrengthThread then
                task.cancel(fastStrengthThread)
            end
            fastStrengthThread = task.spawn(GetRebirthInfoFunction)
        elseif fastStrengthThread then
            task.cancel(fastStrengthThread)
            fastStrengthThread = nil
        end
    end
})
local GameServices = {
    Workspace = game:GetService("Workspace"),
    Players = game:GetService("Players"),
    Lighting = game:GetService("Lighting"),
    SoundService = game:GetService("SoundService"),
    StarterGui = game:GetService("StarterGui"),
    RunService = game:GetService("RunService")
}
local LocalPlayer = GameServices.Players.LocalPlayer
local LightingConfig = {
    enabled = false,
    connections = {},
    originalStates = {
        lighting = {},
        players = {},
        effects = {},
        ui = {},
        sounds = {},
        materials = {}
    },
    config = {
        hideOtherPlayers = true,
        disableEffects = true,
        simplifyMaterials = true,
        muteAudio = true,
        hideUI = false,
        optimizeLighting = true
    },
    storeOriginalLighting = function(LightingParameter)
        pcall(function()
            local LightingService = GameServices.Lighting
            LightingParameter.originalStates.lighting = {
                Ambient = LightingService.Ambient,
                OutdoorAmbient = LightingService.OutdoorAmbient,
                Brightness = LightingService.Brightness,
                FogColor = LightingService.FogColor,
                FogEnd = LightingService.FogEnd,
                FogStart = LightingService.FogStart,
                GlobalShadows = LightingService.GlobalShadows,
                ShadowSoftness = LightingService.ShadowSoftness,
                EnvironmentDiffuseScale = LightingService.EnvironmentDiffuseScale,
                EnvironmentSpecularScale = LightingService.EnvironmentSpecularScale,
                ColorShift_Bottom = LightingService.ColorShift_Bottom,
                ColorShift_Top = LightingService.ColorShift_Top
            }
            local Sky = LightingService:FindFirstChildOfClass("Sky")
            local Atmosphere = LightingService:FindFirstChildOfClass("Atmosphere")
            if Sky then
                LightingParameter.originalStates.lighting.sky = {
                    parent = Sky.Parent,
                    skyboxBk = Sky.SkyboxBk,
                    skyboxDn = Sky.SkyboxDn,
                    skyboxFt = Sky.SkyboxFt,
                    skyboxLf = Sky.SkyboxLf,
                    skyboxRt = Sky.SkyboxRt,
                    skyboxUp = Sky.SkyboxUp
                }
            end
            if Atmosphere then
                LightingParameter.originalStates.lighting.atmosphere = {
                    parent = Atmosphere.Parent,
                    density = Atmosphere.Density,
                    offset = Atmosphere.Offset,
                    color = Atmosphere.Color,
                    decay = Atmosphere.Decay,
                    glare = Atmosphere.Glare,
                    haze = Atmosphere.Haze
                }
            end
        end)
    end,
    applyOptimizedLighting = function(LightingParameter2)
        if LightingParameter2.config.optimizeLighting then
            pcall(function()
                local LightingService2 = GameServices.Lighting
                LightingService2.Ambient = Color3.new(0.5, 0.5, 0.5)
                LightingService2.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
                LightingService2.Brightness = 1
                LightingService2.FogColor = Color3.new(0.7, 0.7, 0.7)
                LightingService2.FogEnd = 1000
                LightingService2.FogStart = 0
                LightingService2.GlobalShadows = false
                LightingService2.ShadowSoftness = 0
                LightingService2.EnvironmentDiffuseScale = 0
                LightingService2.EnvironmentSpecularScale = 0
                LightingService2.ColorShift_Bottom = Color3.new(0, 0, 0)
                LightingService2.ColorShift_Top = Color3.new(0, 0, 0)
                local Sky2 = LightingService2:FindFirstChildOfClass("Sky")
                if Sky2 then
                    Sky2:Destroy()
                end
                local Atmosphere2 = LightingService2:FindFirstChildOfClass("Atmosphere")
                if Atmosphere2 then
                    Atmosphere2:Destroy()
                end
            end)
        end
    end,
    restoreOriginalLighting = function(LightingParameter3)
        pcall(function()
            local LightingService3 = GameServices.Lighting
            local OriginalLightingStates = LightingParameter3.originalStates.lighting
            local LightingState1, LightingState2, LightingState3 = pairs(OriginalLightingStates)
            while true do
                local LightingStatesContainer
                LightingState3, LightingStatesContainer = LightingState1(LightingState2, LightingState3)
                if LightingState3 == nil then
                    break
                end
                if LightingState3 ~= "sky" and (LightingState3 ~= "atmosphere" and LightingService3[LightingState3] ~= nil) then
                    LightingService3[LightingState3] = LightingStatesContainer
                end
            end
            if OriginalLightingStates.sky then
                local Sky3 = LightingService3:FindFirstChildOfClass("Sky")
                if not Sky3 then
                    Sky3 = Instance.new("Sky")
                    Sky3.Parent = LightingService3
                end
                local SkyState1, SkyState2, SkyState3 = pairs(OriginalLightingStates.sky)
                while true do
                    local SkyStatesContainer
                    SkyState3, SkyStatesContainer = SkyState1(SkyState2, SkyState3)
                    if SkyState3 == nil then
                        break
                    end
                    if SkyState3 ~= "parent" and Sky3[SkyState3] ~= nil then
                        Sky3[SkyState3] = SkyStatesContainer
                    end
                end
            end
            if OriginalLightingStates.atmosphere then
                local AtmosphereContainer = LightingService3:FindFirstChildOfClass("Atmosphere")
                if not AtmosphereContainer then
                    AtmosphereContainer = Instance.new("Atmosphere")
                    AtmosphereContainer.Parent = LightingService3
                end
                local AtmosphereKey, AtmosphereValue, AtmospherePair = pairs(OriginalLightingStates.atmosphere)
                while true do
                    local UnusedVariable
                    AtmospherePair, UnusedVariable = AtmosphereKey(AtmosphereValue, AtmospherePair)
                    if AtmospherePair == nil then
                        break
                    end
                    if AtmospherePair ~= "parent" and AtmosphereContainer[AtmospherePair] ~= nil then
                        AtmosphereContainer[AtmospherePair] = UnusedVariable
                    end
                end
            end
        end)
    end,
    hideOtherPlayers = function(FunctionParameter)
        if FunctionParameter.config.hideOtherPlayers then
            FunctionParameter.originalStates.players = {}
            local PlayerKey, PlayerValue, PlayerPair = pairs(GameServices.Players:GetPlayers())
            while true do
                local CharacterModel
                PlayerPair, CharacterModel = PlayerKey(PlayerValue, PlayerPair)
                if PlayerPair == nil then
                    break
                end
                if CharacterModel ~= LocalPlayer and CharacterModel.Character then
                    pcall(function()
                        FunctionParameter.originalStates.players[CharacterModel] = {}
                        local DescendantKey, DescendantValue, DescendantPair = pairs(CharacterModel.Character:GetDescendants())
                        while true do
                            local UnusedVariable
                            DescendantPair, UnusedVariable = DescendantKey(DescendantValue, DescendantPair)
                            if DescendantPair == nil then
                                break
                            end
                            if UnusedVariable:IsA("BasePart") and UnusedVariable.Parent then
                                FunctionParameter.originalStates.players[CharacterModel][UnusedVariable] = {
                                    transparency = UnusedVariable.Transparency,
                                    canCollide = UnusedVariable.CanCollide
                                }
                                UnusedVariable.Transparency = 1
                            elseif (UnusedVariable:IsA("Decal") or UnusedVariable:IsA("Texture")) and UnusedVariable.Parent then
                                FunctionParameter.originalStates.players[CharacterModel][UnusedVariable] = {
                                    transparency = UnusedVariable.Transparency
                                }
                                UnusedVariable.Transparency = 1
                            elseif UnusedVariable:IsA("Accessory") and UnusedVariable.Parent then
                                FunctionParameter.originalStates.players[CharacterModel][UnusedVariable] = {
                                    parent = UnusedVariable.Parent
                                }
                                UnusedVariable.Parent = nil
                            end
                        end
                    end)
                end
            end
        end
    end,
    restorePlayersVisibility = function(OriginalStatesParameter)
        local PlayerStateKey, PlayerStateValue, PlayerStatePair = pairs(OriginalStatesParameter.originalStates.players)
        while true do
            local TableContainer
            PlayerStatePair, TableContainer = PlayerStateKey(PlayerStateValue, PlayerStatePair)
            if PlayerStatePair == nil then
                break
            end
            pcall(function()
                if PlayerStatePair.Character then
                    local TableKey, TableValue, TablePair = pairs(TableContainer)
                    while true do
                        local UnusedVariable
                        TablePair, UnusedVariable = TableKey(TableValue, TablePair)
                        if TablePair == nil then
                            break
                        end
                        if TablePair and TablePair.Parent then
                            if UnusedVariable.transparency ~= nil then
                                TablePair.Transparency = UnusedVariable.transparency
                            end
                            if UnusedVariable.parent then
                                TablePair.Parent = UnusedVariable.parent
                            end
                        end
                    end
                end
            end)
        end
        OriginalStatesParameter.originalStates.players = {}
    end,
    disableEffects = function(FunctionParameter)
        if FunctionParameter.config.disableEffects then
            FunctionParameter.originalStates.effects = {}
            pcall(function()
                local WorkspaceDescendantKey, WorkspaceDescendantValue, WorkspaceDescendantPair = pairs(GameServices.Workspace:GetDescendants())
                while true do
                    local UnusedVariable
                    WorkspaceDescendantPair, UnusedVariable = WorkspaceDescendantKey(WorkspaceDescendantValue, WorkspaceDescendantPair)
                    if WorkspaceDescendantPair == nil then
                        break
                    end
                    if UnusedVariable:IsA("ParticleEmitter") and UnusedVariable.Parent then
                        FunctionParameter.originalStates.effects[UnusedVariable] = {
                            enabled = UnusedVariable.Enabled
                        }
                        UnusedVariable.Enabled = false
                        UnusedVariable:Clear()
                    elseif (UnusedVariable:IsA("Fire") or (UnusedVariable:IsA("Smoke") or UnusedVariable:IsA("Sparkles"))) and UnusedVariable.Parent then
                        FunctionParameter.originalStates.effects[UnusedVariable] = {
                            enabled = UnusedVariable.Enabled
                        }
                        UnusedVariable.Enabled = false
                    elseif (UnusedVariable:IsA("Beam") or UnusedVariable:IsA("Trail")) and UnusedVariable.Parent then
                        FunctionParameter.originalStates.effects[UnusedVariable] = {
                            enabled = UnusedVariable.Enabled
                        }
                        UnusedVariable.Enabled = false
                    elseif (UnusedVariable:IsA("PointLight") or (UnusedVariable:IsA("SpotLight") or UnusedVariable:IsA("SurfaceLight"))) and UnusedVariable.Parent then
                        FunctionParameter.originalStates.effects[UnusedVariable] = {
                            enabled = UnusedVariable.Enabled
                        }
                        UnusedVariable.Enabled = false
                    end
                end
            end)
        end
    end,
    restoreEffects = function(OriginalEffectsParameter)
        local EffectStateKey, EffectStateValue, EffectStatePair = pairs(OriginalEffectsParameter.originalStates.effects)
        while true do
            local TableContainer
            EffectStatePair, TableContainer = EffectStateKey(EffectStateValue, EffectStatePair)
            if EffectStatePair == nil then
                break
            end
            pcall(function()
                if EffectStatePair and EffectStatePair.Parent then
                    EffectStatePair.Enabled = TableContainer.enabled
                end
            end)
        end
        OriginalEffectsParameter.originalStates.effects = {}
    end,
    muteAudio = function(FunctionParameter)
        if FunctionParameter.config.muteAudio then
            FunctionParameter.originalStates.sounds = {}
            pcall(function()
                local WorkspaceDescendantKey, WorkspaceDescendantValue, WorkspaceDescendantPair = pairs(GameServices.Workspace:GetDescendants())
                while true do
                    local UnusedVariable
                    WorkspaceDescendantPair, UnusedVariable = WorkspaceDescendantKey(WorkspaceDescendantValue, WorkspaceDescendantPair)
                    if WorkspaceDescendantPair == nil then
                        break
                    end
                    if UnusedVariable:IsA("Sound") and UnusedVariable.Parent then
                        FunctionParameter.originalStates.sounds[UnusedVariable] = {
                            volume = UnusedVariable.Volume,
                            isPlaying = UnusedVariable.IsPlaying
                        }
                        UnusedVariable:Stop()
                        UnusedVariable.Volume = 0
                    end
                end
                local SoundKey, SoundValue, SoundPair = pairs(GameServices.SoundService:GetChildren())
                while true do
                    local UnusedVariable
                    SoundPair, UnusedVariable = SoundKey(SoundValue, SoundPair)
                    if SoundPair == nil then
                        break
                    end
                    if UnusedVariable:IsA("Sound") then
                        FunctionParameter.originalStates.sounds[UnusedVariable] = {
                            volume = UnusedVariable.Volume,
                            isPlaying = UnusedVariable.IsPlaying
                        }
                        UnusedVariable:Stop()
                        UnusedVariable.Volume = 0
                    end
                end
            end)
        end
    end,
    restoreAudio = function(OriginalSoundsParameter)
        local SoundStateKey, SoundStateValue, SoundStatePair = pairs(OriginalSoundsParameter.originalStates.sounds)
        while true do
            local TableContainer
            SoundStatePair, TableContainer = SoundStateKey(SoundStateValue, SoundStatePair)
            if SoundStatePair == nil then
                break
            end
            pcall(function()
                if SoundStatePair and SoundStatePair.Parent then
                    SoundStatePair.Volume = TableContainer.volume
                    if TableContainer.isPlaying then
                        SoundStatePair:Play()
                    end
                end
            end)
        end
        OriginalSoundsParameter.originalStates.sounds = {}
    end,
    simplifyMaterials = function(FunctionParameter)
        if FunctionParameter.config.simplifyMaterials then
            FunctionParameter.originalStates.materials = {}
            pcall(function()
                local WorkspaceDescendantKey, WorkspaceDescendantValue, WorkspaceDescendantPair = pairs(GameServices.Workspace:GetDescendants())
                while true do
                    local UnusedVariable
                    WorkspaceDescendantPair, UnusedVariable = WorkspaceDescendantKey(WorkspaceDescendantValue, WorkspaceDescendantPair)
                    if WorkspaceDescendantPair == nil then
                        break
                    end
                    if UnusedVariable:IsA("BasePart") and UnusedVariable.Parent then
                        FunctionParameter.originalStates.materials[UnusedVariable] = {
                            material = UnusedVariable.Material,
                            reflectance = UnusedVariable.Reflectance
                        }
                        UnusedVariable.Material = Enum.Material.Plastic
                        UnusedVariable.Reflectance = 0
                    elseif (UnusedVariable:IsA("Texture") or UnusedVariable:IsA("Decal")) and UnusedVariable.Parent then
                        FunctionParameter.originalStates.materials[UnusedVariable] = {
                            transparency = UnusedVariable.Transparency
                        }
                        UnusedVariable.Transparency = 1
                    elseif UnusedVariable:IsA("MeshPart") and UnusedVariable.Parent then
                        FunctionParameter.originalStates.materials[UnusedVariable] = {
                            textureID = UnusedVariable.TextureID
                        }
                        UnusedVariable.TextureID = ""
                    end
                end
            end)
        end
    end,
    restoreMaterials = function(OriginalMaterialsParameter)
        local MaterialStateKey, MaterialStateValue, MaterialStatePair = pairs(OriginalMaterialsParameter.originalStates.materials)
        while true do
            local TableContainer
            MaterialStatePair, TableContainer = MaterialStateKey(MaterialStateValue, MaterialStatePair)
            if MaterialStatePair == nil then
                break
            end
            pcall(function()
                if MaterialStatePair and MaterialStatePair.Parent then
                    if TableContainer.material then
                        MaterialStatePair.Material = TableContainer.material
                    end
                    if TableContainer.reflectance then
                        MaterialStatePair.Reflectance = TableContainer.reflectance
                    end
                    if TableContainer.transparency then
                        MaterialStatePair.Transparency = TableContainer.transparency
                    end
                    if TableContainer.textureID then
                        MaterialStatePair.TextureID = TableContainer.textureID
                    end
                end
            end)
        end
        OriginalMaterialsParameter.originalStates.materials = {}
    end,
    handlePlayerAdded = function(FunctionParameter, FunctionParameter)
        if FunctionParameter.enabled and FunctionParameter ~= LocalPlayer then
            FunctionParameter.CharacterAdded:Connect(function(FunctionParameter)
                if FunctionParameter.enabled then
                    task.wait(1)
                    pcall(function()
                        if not FunctionParameter.originalStates.players[FunctionParameter] then
                            FunctionParameter.originalStates.players[FunctionParameter] = {}
                        end
                        local InstanceContainer = FunctionParameter
                        local DescendantKey, DescendantValue, DescendantPair = pairs(InstanceContainer:GetDescendants())
                        while true do
                            local UnusedVariable
                            DescendantPair, UnusedVariable = DescendantKey(DescendantValue, DescendantPair)
                            if DescendantPair == nil then
                                break
                            end
                            if UnusedVariable:IsA("BasePart") and UnusedVariable.Parent then
                                FunctionParameter.originalStates.players[FunctionParameter][UnusedVariable] = {
                                    transparency = UnusedVariable.Transparency,
                                    canCollide = UnusedVariable.CanCollide
                                }
                                UnusedVariable.Transparency = 1
                            elseif (UnusedVariable:IsA("Decal") or UnusedVariable:IsA("Texture")) and UnusedVariable.Parent then
                                FunctionParameter.originalStates.players[FunctionParameter][UnusedVariable] = {
                                    transparency = UnusedVariable.Transparency
                                }
                                UnusedVariable.Transparency = 1
                            end
                        end
                    end)
                end
            end)
        end
    end,
    toggle = function(FunctionParameter, FunctionParameter)
        FunctionParameter.enabled = FunctionParameter
        if FunctionParameter then
            print("Performance mode enabled - other players remain collidable")
            FunctionParameter:storeOriginalLighting()
            FunctionParameter:applyOptimizedLighting()
            FunctionParameter:hideOtherPlayers()
            FunctionParameter:disableEffects()
            FunctionParameter:muteAudio()
            FunctionParameter:simplifyMaterials()
            FunctionParameter.connections.playerAdded = GameServices.Players.PlayerAdded:Connect(function(FunctionParameter)
                FunctionParameter:handlePlayerAdded(FunctionParameter)
            end)
        else
            print("Performance mode disabled - restoring original states")
            FunctionParameter:restoreOriginalLighting()
            FunctionParameter:restorePlayersVisibility()
            FunctionParameter:restoreEffects()
            FunctionParameter:restoreAudio()
            FunctionParameter:restoreMaterials()
            local ConnectionKey, ConnectionValue, ConnectionPair = pairs(FunctionParameter.connections)
            while true do
                local UnusedVariable
                ConnectionPair, UnusedVariable = ConnectionKey(ConnectionValue, ConnectionPair)
                if ConnectionPair == nil then
                    break
                end
                if UnusedVariable then
                    UnusedVariable:Disconnect()
                end
            end
            FunctionParameter.connections = {}
        end
    end
}
TabConfig.FPS:AddToggle({
    Title = "Performance Mode",
    Content = "",
    Default = false,
    Callback = function(FunctionParameter)
        LightingConfig:toggle(FunctionParameter)
    end
})
TabConfig.FPS:AddToggle({
    Title = "Hide Other Players",
    Content = "",
    Default = true,
    Callback = function(FunctionParameter)
        LightingConfig.config.hideOtherPlayers = FunctionParameter
    end
})
TabConfig.FPS:AddToggle({
    Title = "Disable Effects",
    Content = "",
    Default = true,
    Callback = function(FunctionParameter)
        LightingConfig.config.disableEffects = FunctionParameter
    end
})
TabConfig.FPS:AddToggle({
    Title = "Simplify Materials",
    Content = "",
    Default = true,
    Callback = function(FunctionParameter)
        LightingConfig.config.simplifyMaterials = FunctionParameter
    end
})
TabConfig.FPS:AddToggle({
    Title = "Mute Audio",
    Content = "Mute game sounds",
    Default = true,
    Callback = function(FunctionParameter)
        LightingConfig.config.muteAudio = FunctionParameter
    end
})
game:GetService("Players").PlayerRemoving:Connect(function(FunctionParameter)
    if LightingConfig.originalStates.players[FunctionParameter] then
        LightingConfig.originalStates.players[FunctionParameter] = nil
    end
end)
local ScreenGuiConfig = {
    blackEnabled = false,
    whiteEnabled = false,
    screenGui = nil,
    createBlackScreen = function(FunctionParameter)
        FunctionParameter:removeScreen()
        FunctionParameter.screenGui = Instance.new("ScreenGui")
        FunctionParameter.screenGui.Name = "LunarHubScreen"
        FunctionParameter.screenGui.ResetOnSpawn = false
        FunctionParameter.screenGui.IgnoreGuiInset = true
        FunctionParameter.screenGui.Parent = LocalPlayer.PlayerGui
        local FrameInstance = Instance.new("Frame")
        FrameInstance.Size = UDim2.new(1, 0, 1, 36)
        FrameInstance.Position = UDim2.new(0, 0, 0, - 36)
        FrameInstance.BackgroundColor3 = Color3.new(0, 0, 0)
        FrameInstance.BorderSizePixel = 0
        FrameInstance.ZIndex = 999999
        FrameInstance.Parent = FunctionParameter.screenGui
        local FrameInstance = Instance.new("Frame")
        FrameInstance.Size = UDim2.new(1, 0, 1, 0)
        FrameInstance.Position = UDim2.new(0, 0, 0, 0)
        FrameInstance.BackgroundColor3 = Color3.new(0, 0, 0)
        FrameInstance.BorderSizePixel = 0
        FrameInstance.ZIndex = 999999
        FrameInstance.Parent = FrameInstance
        local UIGradientInstance = Instance.new("UIGradient")
        UIGradientInstance.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(0.05, 0.05, 0.1)),
            ColorSequenceKeypoint.new(0.5, Color3.new(0, 0, 0)),
            ColorSequenceKeypoint.new(1, Color3.new(0.02, 0.02, 0.05))
        })
        UIGradientInstance.Rotation = 45
        UIGradientInstance.Parent = FrameInstance
        local FrameInstance = Instance.new("Frame")
        FrameInstance.Size = UDim2.new(0, 450, 0, 200)
        FrameInstance.Position = UDim2.new(0.5, - 225, 0.5, - 100)
        FrameInstance.BackgroundColor3 = Color3.new(0.1, 0.1, 0.15)
        FrameInstance.BackgroundTransparency = 0.3
        FrameInstance.ZIndex = 1000000
        FrameInstance.Parent = FrameInstance
        local UIGradientInstance = Instance.new("UIGradient")
        UIGradientInstance.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(0.15, 0.15, 0.2)),
            ColorSequenceKeypoint.new(0.5, Color3.new(0.05, 0.05, 0.1)),
            ColorSequenceKeypoint.new(1, Color3.new(0.1, 0.1, 0.15))
        })
        UIGradientInstance.Rotation = 90
        UIGradientInstance.Parent = FrameInstance
        local UICornerInstance = Instance.new("UICorner")
        UICornerInstance.CornerRadius = UDim.new(0, 20)
        UICornerInstance.Parent = FrameInstance
        local UIStrokeInstance = Instance.new("UIStroke")
        UIStrokeInstance.Color = Color3.new(0.3, 0.3, 0.4)
        UIStrokeInstance.Thickness = 2
        UIStrokeInstance.Transparency = 0.5
        UIStrokeInstance.Parent = FrameInstance
        local FrameInstance = Instance.new("Frame")
        FrameInstance.Size = UDim2.new(1, 40, 1, 40)
        FrameInstance.Position = UDim2.new(0, - 20, 0, - 20)
        FrameInstance.BackgroundColor3 = Color3.new(0.2, 0.3, 0.8)
        FrameInstance.BackgroundTransparency = 0.9
        FrameInstance.ZIndex = 999999
        FrameInstance.Parent = FrameInstance
        local UICornerInstance = Instance.new("UICorner")
        UICornerInstance.CornerRadius = UDim.new(0, 25)
        UICornerInstance.Parent = FrameInstance
        local TextLabelInstance = Instance.new("TextLabel")
        TextLabelInstance.Size = UDim2.new(1, - 40, 0, 60)
        TextLabelInstance.Position = UDim2.new(0, 20, 0, 20)
        TextLabelInstance.BackgroundTransparency = 1
        TextLabelInstance.Text = "LUNAR HUB"
        TextLabelInstance.TextColor3 = Color3.new(1, 1, 1)
        TextLabelInstance.TextSize = 42
        TextLabelInstance.Font = Enum.Font.GothamBold
        TextLabelInstance.TextStrokeTransparency = 0.7
        TextLabelInstance.TextStrokeColor3 = Color3.new(0.4, 0.6, 1)
        TextLabelInstance.ZIndex = 1000001
        TextLabelInstance.Parent = FrameInstance
        local FrameInstance = Instance.new("Frame")
        FrameInstance.Size = UDim2.new(0, 350, 0, 3)
        FrameInstance.Position = UDim2.new(0.5, - 175, 0, 90)
        FrameInstance.BackgroundColor3 = Color3.new(0.6, 0.8, 1)
        FrameInstance.BorderSizePixel = 0
        FrameInstance.ZIndex = 1000001
        FrameInstance.Parent = FrameInstance
        local UIGradientInstance = Instance.new("UIGradient")
        UIGradientInstance.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(0.2, 0.4, 0.8)),
            ColorSequenceKeypoint.new(0.5, Color3.new(0.8, 0.9, 1)),
            ColorSequenceKeypoint.new(1, Color3.new(0.2, 0.4, 0.8))
        })
        UIGradientInstance.Parent = FrameInstance
        local UICornerInstance = Instance.new("UICorner")
        UICornerInstance.CornerRadius = UDim.new(0, 5)
        UICornerInstance.Parent = FrameInstance
        local TextLabelInstance = Instance.new("TextLabel")
        TextLabelInstance.Size = UDim2.new(1, - 40, 0, 50)
        TextLabelInstance.Position = UDim2.new(0, 20, 0, 120)
        TextLabelInstance.BackgroundTransparency = 1
        TextLabelInstance.Text = "\226\151\143 Black Screen Active"
        TextLabelInstance.TextColor3 = Color3.new(0.8, 0.9, 1)
        TextLabelInstance.TextSize = 28
        TextLabelInstance.Font = Enum.Font.Gotham
        TextLabelInstance.ZIndex = 1000001
        TextLabelInstance.Parent = FrameInstance
        local TextLabelInstance = Instance.new("TextLabel")
        TextLabelInstance.Size = UDim2.new(1, - 40, 0, 30)
        TextLabelInstance.Position = UDim2.new(0, 20, 0, 160)
        TextLabelInstance.BackgroundTransparency = 1
        TextLabelInstance.Text = "Screen overlay enabled for enhanced privacy"
        TextLabelInstance.TextColor3 = Color3.new(0.6, 0.7, 0.8)
        TextLabelInstance.TextSize = 18
        TextLabelInstance.Font = Enum.Font.Gotham
        TextLabelInstance.ZIndex = 1000001
        TextLabelInstance.Parent = FrameInstance
    end,
    createWhiteScreen = function(FunctionParameter)
        FunctionParameter:removeScreen()
        FunctionParameter.screenGui = Instance.new("ScreenGui")
        FunctionParameter.screenGui.Name = "LunarHubScreen"
        FunctionParameter.screenGui.ResetOnSpawn = false
        FunctionParameter.screenGui.IgnoreGuiInset = true
        FunctionParameter.screenGui.Parent = LocalPlayer.PlayerGui
        local FrameInstance = Instance.new("Frame")
        FrameInstance.Size = UDim2.new(1, 0, 1, 36)
        FrameInstance.Position = UDim2.new(0, 0, 0, - 36)
        FrameInstance.BackgroundColor3 = Color3.new(1, 1, 1)
        FrameInstance.BorderSizePixel = 0
        FrameInstance.ZIndex = 999999
        FrameInstance.Parent = FunctionParameter.screenGui
        local FrameInstance = Instance.new("Frame")
        FrameInstance.Size = UDim2.new(1, 0, 1, 0)
        FrameInstance.Position = UDim2.new(0, 0, 0, 0)
        FrameInstance.BackgroundColor3 = Color3.new(1, 1, 1)
        FrameInstance.BorderSizePixel = 0
        FrameInstance.ZIndex = 999999
        FrameInstance.Parent = FrameInstance
        local UIGradientInstance = Instance.new("UIGradient")
        UIGradientInstance.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(0.95, 0.97, 1)),
            ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.new(0.98, 0.98, 0.95))
        })
        UIGradientInstance.Rotation = 45
        UIGradientInstance.Parent = FrameInstance
        local FrameInstance = Instance.new("Frame")
        FrameInstance.Size = UDim2.new(0, 450, 0, 200)
        FrameInstance.Position = UDim2.new(0.5, - 225, 0.5, - 100)
        FrameInstance.BackgroundColor3 = Color3.new(0.9, 0.9, 0.95)
        FrameInstance.BackgroundTransparency = 0.3
        FrameInstance.ZIndex = 1000000
        FrameInstance.Parent = FrameInstance
        local GradientInstance = Instance.new("UIGradient")
        GradientInstance.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(0.85, 0.88, 0.95)),
            ColorSequenceKeypoint.new(0.5, Color3.new(0.95, 0.95, 1)),
            ColorSequenceKeypoint.new(1, Color3.new(0.9, 0.9, 0.95))
        })
        GradientInstance.Rotation = 90
        GradientInstance.Parent = FrameInstance
        local CornerInstance = Instance.new("UICorner")
        CornerInstance.CornerRadius = UDim.new(0, 20)
        CornerInstance.Parent = FrameInstance
        local StrokeInstance = Instance.new("UIStroke")
        StrokeInstance.Color = Color3.new(0.6, 0.7, 0.8)
        StrokeInstance.Thickness = 2
        StrokeInstance.Transparency = 0.5
        StrokeInstance.Parent = FrameInstance
        local FrameInstance = Instance.new("Frame")
        FrameInstance.Size = UDim2.new(1, 40, 1, 40)
        FrameInstance.Position = UDim2.new(0, - 20, 0, - 20)
        FrameInstance.BackgroundColor3 = Color3.new(0.3, 0.5, 1)
        FrameInstance.BackgroundTransparency = 0.9
        FrameInstance.ZIndex = 999999
        FrameInstance.Parent = FrameInstance
        local CornerComponent = Instance.new("UICorner")
        CornerComponent.CornerRadius = UDim.new(0, 25)
        CornerComponent.Parent = FrameInstance
        local TextLabelInstance = Instance.new("TextLabel")
        TextLabelInstance.Size = UDim2.new(1, - 40, 0, 60)
        TextLabelInstance.Position = UDim2.new(0, 20, 0, 20)
        TextLabelInstance.BackgroundTransparency = 1
        TextLabelInstance.Text = "LUNAR HUB"
        TextLabelInstance.TextColor3 = Color3.new(0.1, 0.1, 0.2)
        TextLabelInstance.TextSize = 42
        TextLabelInstance.Font = Enum.Font.GothamBold
        TextLabelInstance.TextStrokeTransparency = 0.8
        TextLabelInstance.TextStrokeColor3 = Color3.new(0.4, 0.6, 1)
        TextLabelInstance.ZIndex = 1000001
        TextLabelInstance.Parent = FrameInstance
        local FrameComponent = Instance.new("Frame")
        FrameComponent.Size = UDim2.new(0, 350, 0, 3)
        FrameComponent.Position = UDim2.new(0.5, - 175, 0, 90)
        FrameComponent.BackgroundColor3 = Color3.new(0.2, 0.4, 0.8)
        FrameComponent.BorderSizePixel = 0
        FrameComponent.ZIndex = 1000001
        FrameComponent.Parent = FrameInstance
        local GradientComponent = Instance.new("UIGradient")
        GradientComponent.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(0.6, 0.7, 0.9)),
            ColorSequenceKeypoint.new(0.5, Color3.new(0.2, 0.4, 0.8)),
            ColorSequenceKeypoint.new(1, Color3.new(0.6, 0.7, 0.9))
        })
        GradientComponent.Parent = FrameComponent
        local CornerElement = Instance.new("UICorner")
        CornerElement.CornerRadius = UDim.new(0, 5)
        CornerElement.Parent = FrameComponent
        local TextLabelComponent = Instance.new("TextLabel")
        TextLabelComponent.Size = UDim2.new(1, - 40, 0, 50)
        TextLabelComponent.Position = UDim2.new(0, 20, 0, 120)
        TextLabelComponent.BackgroundTransparency = 1
        TextLabelComponent.Text = "\226\151\143 White Screen Active"
        TextLabelComponent.TextColor3 = Color3.new(0.1, 0.2, 0.4)
        TextLabelComponent.TextSize = 28
        TextLabelComponent.Font = Enum.Font.Gotham
        TextLabelComponent.ZIndex = 1000001
        TextLabelComponent.Parent = FrameInstance
        local TextLabelElement = Instance.new("TextLabel")
        TextLabelElement.Size = UDim2.new(1, - 40, 0, 30)
        TextLabelElement.Position = UDim2.new(0, 20, 0, 160)
        TextLabelElement.BackgroundTransparency = 1
        TextLabelElement.Text = "Screen overlay enabled for enhanced privacy"
        TextLabelElement.TextColor3 = Color3.new(0.3, 0.4, 0.5)
        TextLabelElement.TextSize = 18
        TextLabelElement.Font = Enum.Font.Gotham
        TextLabelElement.ZIndex = 1000001
        TextLabelElement.Parent = FrameInstance
    end,
    removeScreen = function(ParameterValue)
        if ParameterValue.screenGui then
            ParameterValue.screenGui:Destroy()
            ParameterValue.screenGui = nil
        end
    end
}
TabConfig.FPS:AddToggle({
    Title = "Black Screen",
    Content = "Show enhanced black screen overlay with gradients",
    Default = false,
    Callback = function(ParameterValue1)
        ScreenGuiConfig.blackEnabled = ParameterValue1
        if ParameterValue1 then
            if ScreenGuiConfig.whiteEnabled then
                ScreenGuiConfig.whiteEnabled = false
            end
            ScreenGuiConfig:createBlackScreen()
        else
            ScreenGuiConfig:removeScreen()
        end
    end
})
TabConfig.FPS:AddToggle({
    Title = "White Screen",
    Content = "Show enhanced white screen overlay with gradients",
    Default = false,
    Callback = function(ParameterValue2)
        ScreenGuiConfig.whiteEnabled = ParameterValue2
        if ParameterValue2 then
            if ScreenGuiConfig.blackEnabled then
                ScreenGuiConfig.blackEnabled = false
            end
            ScreenGuiConfig:createWhiteScreen()
        else
            ScreenGuiConfig:removeScreen()
        end
    end
})
local PlayersService = game:GetService("Players")
local ReplicatedStorageService = game:GetService("ReplicatedStorage")
local LocalPlayerInstance = PlayersService.LocalPlayer
local RebirthRemoteEvent = ReplicatedStorageService.rEvents.rebirthRemote
local HighScoreValue = 10000
local MediumScoreValue = 5000
local LowScoreValue = 1
local NilValue = nil
local FalseValue = false
local function CalculateRebirthsFunction(ParameterName)
    return HighScoreValue + ParameterName * MediumScoreValue
end
local function GetPlayerDataFunction(ToolName)
    local ToolInstance = LocalPlayerInstance.Backpack:FindFirstChild(ToolName)
    if not ToolInstance then
        return false
    end
    LocalPlayerInstance.Character.Humanoid:EquipTool(ToolInstance)
    return true
end
local function UpdatePlayerDataFunction()
    if LocalPlayerInstance.Character and LocalPlayerInstance.Character:FindFirstChild("Humanoid") then
        local CharacterTool = LocalPlayerInstance.Character:FindFirstChildOfClass("Tool")
        if not CharacterTool or CharacterTool.Name ~= "Weight" then
            GetPlayerDataFunction("Weight")
        end
    end
end
local function GetCharacterToolFunction()
    UpdatePlayerDataFunction()
    for UnusedParameter = 1, 5 do
        LocalPlayerInstance.muscleEvent:FireServer("rep")
    end
end
TabConfig.RegularSection:AddInput({
    Title = Function8("Target Rebirth Amount"),
    Content = Function8(""),
    Default = "1",
    Placeholder = "",
    Numeric = false,
    Finished = true,
    Callback = function(RebirthValue)
        local RebirthNumber = tonumber(RebirthValue) or 1
        if LocalPlayerInstance:WaitForChild("leaderstats"):WaitForChild("Rebirths").Value <= RebirthNumber then
            LowScoreValue = RebirthNumber
        end
    end
})
TabConfig.RegularSection:AddToggle({
    Title = Function8("Target Rebirth"),
    Content = Function8(""),
    Default = false,
    Callback = function(ParameterId)
        if ParameterId then
            FalseValue = false
            NilValue = task.spawn(function()
                while task.wait(0.1) do
                    local RebirthCount = LocalPlayerInstance:WaitForChild("leaderstats"):WaitForChild("Rebirths").Value
                    local StrengthValue = LocalPlayerInstance:WaitForChild("leaderstats"):WaitForChild("Strength").Value
                    local CalculatedRebirths = CalculateRebirthsFunction(RebirthCount)
                    if LowScoreValue <= RebirthCount and not FalseValue then
                        FalseValue = true
                        GetPlayerDataFunction("Pushup")
                    end
                    if FalseValue then
                        local CharacterInstance = LocalPlayerInstance.Character
                        if CharacterInstance then
                            CharacterInstance = LocalPlayerInstance.Character:FindFirstChildOfClass("Tool")
                        end
                        if not CharacterInstance or CharacterInstance.Name ~= "Pushup" then
                            GetPlayerDataFunction("Pushup")
                        end
                        task.wait(0.1)
                        if LocalPlayerInstance:FindFirstChild("muscleEvent") then
                            for UnusedParameter = 1, 5 do
                                LocalPlayerInstance.muscleEvent:FireServer("rep")
                                task.wait(0.05)
                            end
                        end
                    elseif CalculatedRebirths <= StrengthValue then
                        RebirthRemoteEvent:InvokeServer("rebirthRequest")
                        task.wait(0.7)
                    else
                        GetCharacterToolFunction()
                    end
                end
            end)
        else
            if NilValue then
                task.cancel(NilValue)
                NilValue = nil
            end
            FalseValue = false
        end
    end
})
local GameServices = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    Workspace = game:GetService("Workspace")
}
local LocalPlayer = GameServices.Players.LocalPlayer
local NilObject = nil
local EmptyTable = nil
local EmptyString = nil
local DefaultValue = nil
local SpawnLocation = CFrame.new(- 8761, 440, - 5854)
local function GetSpawnLocationFunction()
    if NilObject then
        NilObject:Destroy()
        NilObject = nil
    end
end
local function UpdateSpawnLocationFunction()
    GetSpawnLocationFunction()
    NilObject = Instance.new("Part")
    NilObject.Name = "KingFarmPlatform"
    NilObject.Size = Vector3.new(35, 3, 35)
    NilObject.Position = Vector3.new(- 8761, 435, - 5854)
    NilObject.Anchored = true
    NilObject.CanCollide = true
    NilObject.Material = Enum.Material.ForceField
    NilObject.Color = Color3.fromRGB(0, 162, 255)
    NilObject.Shape = Enum.PartType.Block
    NilObject.TopSurface = Enum.SurfaceType.Smooth
    NilObject.BottomSurface = Enum.SurfaceType.Smooth
    NilObject.Transparency = 0.1
    local SelectionBoxInstance = Instance.new("SelectionBox")
    SelectionBoxInstance.Color3 = Color3.fromRGB(0, 255, 255)
    SelectionBoxInstance.LineThickness = 0.15
    SelectionBoxInstance.Transparency = 0
    SelectionBoxInstance.Adornee = NilObject
    SelectionBoxInstance.Parent = NilObject
    local PointLightInstance = Instance.new("PointLight")
    PointLightInstance.Color = Color3.fromRGB(0, 200, 255)
    PointLightInstance.Brightness = 2
    PointLightInstance.Range = 50
    PointLightInstance.Parent = NilObject
    local SurfaceLightInstance = Instance.new("SurfaceLight")
    SurfaceLightInstance.Color = Color3.fromRGB(0, 162, 255)
    SurfaceLightInstance.Brightness = 1.5
    SurfaceLightInstance.Range = 30
    SurfaceLightInstance.Face = Enum.NormalId.Top
    SurfaceLightInstance.Parent = NilObject
    for LoopCounter = 1, 4 do
        local PartInstance = Instance.new("Part")
        PartInstance.Name = "CornerPillar" .. LoopCounter
        PartInstance.Size = Vector3.new(2, 8, 2)
        PartInstance.Material = Enum.Material.Neon
        PartInstance.Color = Color3.fromRGB(0, 255, 255)
        PartInstance.Anchored = true
        PartInstance.CanCollide = false
        PartInstance.Shape = Enum.PartType.Cylinder
        local ScoreValue = LoopCounter <= 2 and 16 or - 16
        local AlternateValue = LoopCounter % 2 == 1 and 16 or - 16
        PartInstance.Position = Vector3.new(- 8761 + ScoreValue, 439, - 5854 + AlternateValue)
        PartInstance.Rotation = Vector3.new(0, 0, 90)
        PartInstance.Parent = NilObject
    end
    NilObject.Parent = GameServices.Workspace
end
local function GetScoreFunction()
    if NilObject then
        NilObject:Destroy()
        NilObject = nil
    end
end
local function UpdateScoreFunction()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = SpawnLocation
        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        LocalPlayer.Character.HumanoidRootPart.RotVelocity = Vector3.new(0, 0, 0)
    end
end
local function CalculateScoreFunction()
    if EmptyTable then
        EmptyTable:Disconnect()
    end
    task.wait(2)
    local ScoreCalculator
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        ScoreCalculator = LocalPlayer.Character.HumanoidRootPart.CFrame
    else
        ScoreCalculator = nil
    end
    EmptyTable = GameServices.RunService.Heartbeat:Connect(function()
        if LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and ScoreCalculator) then
            LocalPlayer.Character.HumanoidRootPart.CFrame = ScoreCalculator
            LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            LocalPlayer.Character.HumanoidRootPart.RotVelocity = Vector3.new(0, 0, 0)
            if LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.PlatformStand = true
            end
        end
    end)
end
local function GetPlayerScoreFunction()
    if EmptyTable then
        EmptyTable:Disconnect()
        EmptyTable = nil
    end
    if LocalPlayer.Character then
        local HumanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local HumanoidInstance = LocalPlayer.Character:FindFirstChild("Humanoid")
        if HumanoidRootPart then
            HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            HumanoidRootPart.RotVelocity = Vector3.new(0, 0, 0)
        end
        if HumanoidInstance then
            HumanoidInstance.PlatformStand = false
            HumanoidInstance.Sit = false
        end
        task.wait(0.1)
    end
end
local function UpdatePlayerScoreFunction(PlayerId)
    if EmptyString then
        EmptyString:Disconnect()
    end
    EmptyString = PlayerId:WaitForChild("Humanoid").Died:Connect(function()
        task.wait(5)
        UpdateScoreFunction()
        task.spawn(CalculateScoreFunction)
    end)
end
local function GetPlayerByIdFunction()
    if EmptyString then
        EmptyString:Disconnect()
    end
    if DefaultValue then
        DefaultValue:Disconnect()
    end
    if LocalPlayer.Character then
        UpdatePlayerScoreFunction(LocalPlayer.Character)
    end
    DefaultValue = LocalPlayer.CharacterAdded:Connect(UpdatePlayerScoreFunction)
end
local function UpdatePlayerByIdFunction()
    GetPlayerScoreFunction()
    if EmptyString then
        EmptyString:Disconnect()
        EmptyString = nil
    end
    if DefaultValue then
        DefaultValue:Disconnect()
        DefaultValue = nil
    end
end
TabConfig.MiscRebirth:AddToggle({
    Title = "Farm At King",
    Content = "",
    Default = false,
    Callback = function(ParameterType)
        isEnabled = ParameterType
        if ParameterType then
            UpdateSpawnLocationFunction()
            UpdateScoreFunction()
            CalculateScoreFunction()
            GetPlayerByIdFunction()
        else
            UpdatePlayerByIdFunction()
            GetScoreFunction()
        end
    end
})
local EmptyValue = nil
local TickCount = tick()
local function GetTickCountFunction()
    if EmptyValue then
        EmptyValue:Disconnect()
    end
    EmptyValue = GameServices.RunService.Heartbeat:Connect(function()
        local TickValue = tick()
        if TickValue - TickCount >= 30 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            local Humanoid = LocalPlayer.Character.Humanoid
            Humanoid:Move(Vector3.new(0.1, 0, 0), false)
            task.wait(0.1)
            Humanoid:Move(Vector3.new(- 0.1, 0, 0), false)
            TickCount = TickValue
        end
    end)
end
local function UpdateHumanoidFunction()
    if EmptyValue then
        EmptyValue:Disconnect()
        EmptyValue = nil
    end
end
local NilHumanoid = nil
local DefaultHumanoid = nil
TabConfig.MiscRebirth:AddToggle({
    Title = "Anti-AFK",
    Content = "",
    Default = false,
    Callback = function(ParameterName1)
        if ParameterName1 then
            GetTickCountFunction()
        else
            UpdateHumanoidFunction()
        end
    end
})
TabConfig.MiscRebirth:AddToggle({
    Title = "Auto Size 2",
    Content = "",
    Default = false,
    Callback = function(ParameterType1)
        if NilHumanoid then
            NilHumanoid:Disconnect()
            NilHumanoid = nil
        end
        if DefaultHumanoid then
            task.cancel(DefaultHumanoid)
            DefaultHumanoid = nil
        end
        if ParameterType1 then
            pcall(function()
                game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 2)
            end)
            DefaultHumanoid = task.spawn(function()
                while ParameterType1 do
                    task.wait(1.5)
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        pcall(function()
                            game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 2)
                        end)
                    end
                end
            end)
            NilHumanoid = LocalPlayer.CharacterAdded:Connect(function(UnusedParameter)
                task.wait(0.5)
                pcall(function()
                    game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 2)
                end)
            end)
        end
    end
});
({
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    LocalPlayer = game:GetService("Players").LocalPlayer,
    Config = {
        killAuraRange = 50,
        orbitingBalls = 8,
        updateInterval = 0.1,
        selectedColorTheme = "Purple",
        hitboxSize = 10,
        CLAN_FILE_PATH = "Lunar File/White_List_Clans.txt"
    },
    State = {
        whitelist = {},
        blacklist = {},
        isKilling = false,
        killAuraEnabled = false,
        targetedPlayers = {},
        expandedPlayers = {},
        hitboxExpanderEnabled = false,
        spyTarget = nil,
        spyEnabled = false,
        clanWhitelistEnabled = false,
        visualsEnabled = false,
        orbitingBalls = {},
        glowDot = nil,
        connections = {},
        lastUpdate = 0,
        hasTargetsNearby = false,
        originalLighting = nil,
        killMethod = "Normal",
        whitelistIndicators = {}
    },
    UI = {
        whitelistDropdown = nil,
        blacklistDropdown = nil,
        targetPlayerDropdown = nil,
        spyDropdown = nil,
        whitelistSelected = {},
        blacklistSelected = {},
        targetSelected = {}
    },
    ColorThemes = {
        Purple = {
            ballSafe = Color3.fromRGB(120, 80, 220),
            ballDanger = Color3.fromRGB(200, 80, 120),
            lightSafe = Color3.fromRGB(150, 100, 255),
            lightDanger = Color3.fromRGB(255, 120, 180),
            dotMain = Color3.fromRGB(60, 30, 120),
            dotOuter = Color3.fromRGB(40, 20, 80),
            dotInner = Color3.fromRGB(100, 60, 180),
            trailEnd = Color3.fromRGB(80, 30, 150),
            whitelistIndicator = Color3.fromRGB(138, 43, 226)
        },
        Blue = {
            ballSafe = Color3.fromRGB(50, 150, 255),
            ballDanger = Color3.fromRGB(255, 100, 100),
            lightSafe = Color3.fromRGB(100, 200, 255),
            lightDanger = Color3.fromRGB(255, 150, 150),
            dotMain = Color3.fromRGB(20, 80, 150),
            dotOuter = Color3.fromRGB(10, 50, 100),
            dotInner = Color3.fromRGB(40, 120, 200),
            trailEnd = Color3.fromRGB(30, 70, 140),
            whitelistIndicator = Color3.fromRGB(0, 120, 255)
        },
        Red = {
            ballSafe = Color3.fromRGB(255, 80, 80),
            ballDanger = Color3.fromRGB(255, 50, 50),
            lightSafe = Color3.fromRGB(255, 120, 120),
            lightDanger = Color3.fromRGB(255, 80, 80),
            dotMain = Color3.fromRGB(150, 30, 30),
            dotOuter = Color3.fromRGB(100, 20, 20),
            dotInner = Color3.fromRGB(200, 50, 50),
            trailEnd = Color3.fromRGB(120, 25, 25),
            whitelistIndicator = Color3.fromRGB(255, 50, 50)
        },
        Green = {
            ballSafe = Color3.fromRGB(50, 150, 50),
            ballDanger = Color3.fromRGB(200, 150, 50),
            lightSafe = Color3.fromRGB(80, 200, 80),
            lightDanger = Color3.fromRGB(255, 200, 100),
            dotMain = Color3.fromRGB(30, 80, 30),
            dotOuter = Color3.fromRGB(20, 50, 20),
            dotInner = Color3.fromRGB(50, 120, 50),
            trailEnd = Color3.fromRGB(25, 60, 25),
            whitelistIndicator = Color3.fromRGB(0, 255, 0)
        },
        Ocean = {
            ballSafe = Color3.fromRGB(0, 119, 190),
            ballDanger = Color3.fromRGB(255, 130, 100),
            lightSafe = Color3.fromRGB(64, 164, 223),
            lightDanger = Color3.fromRGB(255, 160, 130),
            dotMain = Color3.fromRGB(0, 85, 135),
            dotOuter = Color3.fromRGB(0, 60, 95),
            dotInner = Color3.fromRGB(30, 140, 200),
            trailEnd = Color3.fromRGB(15, 100, 150),
            whitelistIndicator = Color3.fromRGB(0, 150, 255)
        },
        Forest = {
            ballSafe = Color3.fromRGB(34, 139, 34),
            ballDanger = Color3.fromRGB(165, 42, 42),
            lightSafe = Color3.fromRGB(60, 179, 60),
            lightDanger = Color3.fromRGB(200, 80, 80),
            dotMain = Color3.fromRGB(25, 100, 25),
            dotOuter = Color3.fromRGB(15, 70, 15),
            dotInner = Color3.fromRGB(45, 160, 45),
            trailEnd = Color3.fromRGB(30, 120, 30),
            whitelistIndicator = Color3.fromRGB(0, 255, 100)
        },
        Gold = {
            ballSafe = Color3.fromRGB(255, 215, 0),
            ballDanger = Color3.fromRGB(255, 140, 50),
            lightSafe = Color3.fromRGB(255, 235, 100),
            lightDanger = Color3.fromRGB(255, 170, 100),
            dotMain = Color3.fromRGB(180, 150, 0),
            dotOuter = Color3.fromRGB(140, 120, 0),
            dotInner = Color3.fromRGB(220, 185, 50),
            trailEnd = Color3.fromRGB(160, 135, 25),
            whitelistIndicator = Color3.fromRGB(255, 215, 0)
        },
        Silver = {
            ballSafe = Color3.fromRGB(192, 192, 192),
            ballDanger = Color3.fromRGB(220, 160, 160),
            lightSafe = Color3.fromRGB(220, 220, 220),
            lightDanger = Color3.fromRGB(240, 180, 180),
            dotMain = Color3.fromRGB(140, 140, 140),
            dotOuter = Color3.fromRGB(120, 120, 120),
            dotInner = Color3.fromRGB(170, 170, 170),
            trailEnd = Color3.fromRGB(130, 130, 130),
            whitelistIndicator = Color3.fromRGB(192, 192, 192)
        }
    },
    isPlayerWhitelisted = function(ParameterPlayer, ParameterFriend)
        if not ParameterFriend then
            return false
        end
        if ParameterPlayer.State.whitelist[ParameterFriend.UserId] then
            return true
        end
        if ParameterPlayer.State.clanWhitelistEnabled and ParameterPlayer:isPlayerInWhitelistClan(ParameterFriend) then
            return true
        end
        if _G.whitelistFriends then
            local FriendStatus, FriendshipStatus = pcall(function()
                return ParameterFriend:IsFriendsWith(ParameterPlayer.LocalPlayer.UserId)
            end)
            if FriendStatus and FriendshipStatus then
                return true
            end
        end
        return false
    end,
    ensureClanFile = function(ParameterValue3)
        if not isfolder("Lunar File") then
            makefolder("Lunar File")
        end
        if not isfile(ParameterValue3.Config.CLAN_FILE_PATH) then
            writefile(ParameterValue3.Config.CLAN_FILE_PATH, "-- Add clan tags here, one per line\n-- Example:\n-- ZTX\n-- LOT\n-- CLAN")
        end
    end,
    loadClanTags = function(ConfigObject)
        ConfigObject:ensureClanFile()
        local ClanFileLines, ClanFileData, ClanFileReader = readfile(ConfigObject.Config.CLAN_FILE_PATH):gmatch("[^\r\n]+")
        local ClanData = {}
        while true do
            ClanFileReader = ClanFileLines(ClanFileData, ClanFileReader)
            if ClanFileReader == nil then
                break
            end
            local ClanTag = ClanFileReader:match("^%s*([^-][^%s]*)")
            if ClanTag and ClanTag ~= "" then
                ClanData[ClanTag:upper()] = true
            end
        end
        return ClanData
    end,
    isPlayerInWhitelistClan = function(ClanObject, PlayerObject)
        if not ClanObject.State.clanWhitelistEnabled then
            return false
        end
        local ClanTags = ClanObject:loadClanTags()
        local PlayerName = PlayerObject.DisplayName:upper()
        local ClanTagPairs, ClanTagKeys, ClanTagValues = pairs(ClanTags)
        while true do
            local ClanTagData
            ClanTagValues, ClanTagData = ClanTagPairs(ClanTagKeys, ClanTagValues)
            if ClanTagValues == nil then
                break
            end
            if PlayerName:find(ClanTagValues .. "*") or (PlayerName:find("*" .. ClanTagValues) or PlayerName == ClanTagValues) then
                return true
            end
        end
        return false
    end,
    getCurrentPlayers = function(GameObject)
        local PlayerPairs, PlayerKeys, PlayerValues = pairs(GameObject.Players:GetPlayers())
        local PlayerData = {}
        while true do
            local UnusedVariable
            PlayerValues, UnusedVariable = PlayerPairs(PlayerKeys, PlayerValues)
            if PlayerValues == nil then
                break
            end
            if UnusedVariable ~= GameObject.LocalPlayer then
                table.insert(PlayerData, UnusedVariable.Name)
            end
        end
        return PlayerData
    end,
    updatePlayerDropdowns = function(PlayerParameter)
        local CurrentPlayers = PlayerParameter:getCurrentPlayers()
        if PlayerParameter.UI.whitelistDropdown then
            PlayerParameter.UI.whitelistDropdown:Refresh(CurrentPlayers, PlayerParameter.UI.whitelistSelected)
        end
        if PlayerParameter.UI.blacklistDropdown then
            PlayerParameter.UI.blacklistDropdown:Refresh(CurrentPlayers, PlayerParameter.UI.blacklistSelected)
        end
        if PlayerParameter.UI.targetPlayerDropdown then
            PlayerParameter.UI.targetPlayerDropdown:Refresh(CurrentPlayers, PlayerParameter.UI.targetSelected)
        end
        if PlayerParameter.UI.spyDropdown then
            PlayerParameter.UI.spyDropdown:Refresh(CurrentPlayers, PlayerParameter.State.spyTarget and {
                PlayerParameter.State.spyTarget.Name
            } or {})
        end
    end,
    getCurrentColors = function(GameParameter)
        return GameParameter.ColorThemes[GameParameter.Config.selectedColorTheme] or GameParameter.ColorThemes.Purple
    end,
    createWhitelistIndicator = function(UserParameter, UserProfile)
        if not (UserProfile and UserParameter:isLocalPlayerReady()) then
            return nil
        end
        local CharacterModel = UserProfile.Character
        if not CharacterModel then
            return nil
        end
        local HumanoidRootPart = CharacterModel:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart then
            return nil
        end
        local CurrentColors = UserParameter:getCurrentColors()
        pcall(function()
            local PartInstance = Instance.new("Part")
            PartInstance.Name = "WhitelistIndicator_" .. UserProfile.Name
            PartInstance.Size = Vector3.new(2, 0.2, 2)
            PartInstance.Shape = Enum.PartType.Cylinder
            PartInstance.Material = Enum.Material.Neon
            PartInstance.CanCollide = false
            PartInstance.Anchored = true
            PartInstance.Color = CurrentColors.whitelistIndicator
            PartInstance.Transparency = 0.3
            PartInstance.Parent = workspace
            local PointLightInstance = Instance.new("PointLight")
            PointLightInstance.Color = CurrentColors.whitelistIndicator
            PointLightInstance.Brightness = 2
            PointLightInstance.Range = 8
            PointLightInstance.Parent = PartInstance
            local PositionVector = HumanoidRootPart.Position
            PartInstance.CFrame = CFrame.new(PositionVector - Vector3.new(0, 2, 0)) * CFrame.Angles(0, 0, math.rad(90))
            local PlayerData = {
                part = PartInstance,
                light = PointLightInstance,
                player = UserProfile
            }
            UserParameter.State.whitelistIndicators[UserProfile.UserId] = PlayerData
            return PartInstance
        end)
    end,
    removeWhitelistIndicator = function(UserParameter1, UserParameter2)
        if UserParameter1.State.whitelistIndicators[UserParameter2] then
            pcall(function()
                if UserParameter1.State.whitelistIndicators[UserParameter2].part then
                    UserParameter1.State.whitelistIndicators[UserParameter2].part:Destroy()
                end
            end)
            UserParameter1.State.whitelistIndicators[UserParameter2] = nil
        end
    end,
    updateWhitelistIndicators = function(GameService)
        if GameService.State.visualsEnabled and GameService:isLocalPlayerReady() then
            local TickCount = tick()
            local LocalPlayerPosition = GameService.LocalPlayer.Character.HumanoidRootPart.Position
            local PlayerIterator, PlayerKey, PlayerValue = pairs(GameService.Players:GetPlayers())
            while true do
                local TargetPlayer
                PlayerValue, TargetPlayer = PlayerIterator(PlayerKey, PlayerValue)
                if PlayerValue == nil then
                    break
                end
                if TargetPlayer and TargetPlayer ~= GameService.LocalPlayer then
                    local TargetCharacter = TargetPlayer.Character
                    if TargetCharacter then
                        local TargetHumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart")
                        if TargetHumanoidRootPart then
                            local DistanceMagnitude = (LocalPlayerPosition - TargetHumanoidRootPart.Position).Magnitude
                            if GameService:isPlayerWhitelisted(TargetPlayer) and DistanceMagnitude <= GameService.Config.killAuraRange then
                                if GameService.State.whitelistIndicators[TargetPlayer.UserId] then
                                    local WhitelistIndicator = GameService.State.whitelistIndicators[TargetPlayer.UserId]
                                    if WhitelistIndicator and (WhitelistIndicator.part and WhitelistIndicator.part.Parent) then
                                        pcall(function()
                                            local TargetPosition = TargetHumanoidRootPart.Position
                                            local SinValue = 1 + math.sin(TickCount * 3) * 0.15
                                            WhitelistIndicator.part.Size = Vector3.new(2 * SinValue, 0.2, 2 * SinValue)
                                            WhitelistIndicator.part.CFrame = CFrame.new(TargetPosition - Vector3.new(0, 2, 0)) * CFrame.Angles(0, 0, math.rad(90))
                                            local SinOffset = math.sin(TickCount * 2.5) * 0.1
                                            WhitelistIndicator.part.Transparency = 0.3 + SinOffset
                                            if WhitelistIndicator.light then
                                                WhitelistIndicator.light.Brightness = 2 + math.sin(TickCount * 3) * 0.5
                                            end
                                        end)
                                    end
                                else
                                    GameService:createWhitelistIndicator(TargetPlayer)
                                end
                            else
                                GameService:removeWhitelistIndicator(TargetPlayer.UserId)
                            end
                        end
                    end
                end
            end
            local WhitelistIterator, WhitelistKey, WhitelistValue = pairs(GameService.State.whitelistIndicators)
            while true do
                local OrbData
                WhitelistValue, OrbData = WhitelistIterator(WhitelistKey, WhitelistValue)
                if WhitelistValue == nil then
                    break
                end
                if OrbData and OrbData.player then
                    local OrbPlayer = OrbData.player
                    if not (OrbPlayer.Parent and OrbPlayer.Character) then
                        GameService:removeWhitelistIndicator(WhitelistValue)
                    end
                end
            end
        end
    end,
    updateAllColors = function(OrbService)
        if OrbService.State.visualsEnabled then
            local OrbColors = OrbService:getCurrentColors()
            local HasTargetsNearby = OrbService.State.hasTargetsNearby
            local OrbitingBallsIterator, OrbitingBallsKey, OrbitingBallsValue = pairs(OrbService.State.orbitingBalls)
            while true do
                local UnusedVariable1
                OrbitingBallsValue, UnusedVariable1 = OrbitingBallsIterator(OrbitingBallsKey, OrbitingBallsValue)
                if OrbitingBallsValue == nil then
                    break
                end
                if UnusedVariable1.part and UnusedVariable1.part.Parent then
                    local BallColor = HasTargetsNearby and OrbColors.ballDanger or OrbColors.ballSafe
                    local LightColor = HasTargetsNearby and OrbColors.lightDanger or OrbColors.lightSafe
                    UnusedVariable1.part.Color = BallColor
                    UnusedVariable1.light.Color = LightColor
                    UnusedVariable1.trail.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, LightColor),
                        ColorSequenceKeypoint.new(0.5, BallColor),
                        ColorSequenceKeypoint.new(1, OrbColors.trailEnd)
                    })
                end
            end
            if OrbService.State.glowDot and (OrbService.State.glowDot.main and OrbService.State.glowDot.main.Parent) then
                local GlowColor = HasTargetsNearby and Color3.fromRGB(math.min(255, OrbColors.dotMain.R * 255 * 1.2), math.min(255, OrbColors.dotMain.G * 255 * 0.8), math.min(255, OrbColors.dotMain.B * 255 * 0.9)) or OrbColors.dotMain
                OrbService.State.glowDot.main.Color = GlowColor
                OrbService.State.glowDot.outer.Color = OrbColors.dotOuter
                OrbService.State.glowDot.inner.Color = OrbColors.dotInner
                local GlowPointLight = OrbService.State.glowDot.main:FindFirstChild("PointLight")
                if GlowPointLight then
                    GlowPointLight.Color = HasTargetsNearby and OrbColors.lightDanger or OrbColors.lightSafe
                end
                local GlowAttachment = OrbService.State.glowDot.main:FindFirstChild("Attachment")
                if GlowAttachment then
                    local GlowChildren = GlowAttachment:GetChildren()
                    local GlowIterator, GlowKey, GlowValue = pairs(GlowChildren)
                    while true do
                        local UnusedVariable2
                        GlowValue, UnusedVariable2 = GlowIterator(GlowKey, GlowValue)
                        if GlowValue == nil then
                            break
                        end
                        if UnusedVariable2:IsA("ParticleEmitter") then
                            if UnusedVariable2.Name ~= "SparkleEmitter" then
                                if UnusedVariable2.Name ~= "CircleParticles" then
                                    UnusedVariable2.Color = ColorSequence.new({
                                        ColorSequenceKeypoint.new(0, OrbColors.dotInner),
                                        ColorSequenceKeypoint.new(0.5, GlowColor),
                                        ColorSequenceKeypoint.new(1, OrbColors.dotOuter)
                                    })
                                else
                                    UnusedVariable2.Color = ColorSequence.new(OrbColors.dotInner)
                                end
                            else
                                UnusedVariable2.Color = ColorSequence.new(HasTargetsNearby and OrbColors.lightDanger or OrbColors.lightSafe)
                            end
                        end
                    end
                end
            end
            local WhitelistIterator1, WhitelistKey1, WhitelistValue1 = pairs(OrbService.State.whitelistIndicators)
            while true do
                local UnusedVariable3
                WhitelistValue1, UnusedVariable3 = WhitelistIterator1(WhitelistKey1, WhitelistValue1)
                if WhitelistValue1 == nil then
                    break
                end
                if UnusedVariable3 and (UnusedVariable3.part and UnusedVariable3.part.Parent) then
                    UnusedVariable3.part.Color = OrbColors.whitelistIndicator
                    if UnusedVariable3.light then
                        UnusedVariable3.light.Color = OrbColors.whitelistIndicator
                    end
                end
            end
        end
    end,
    isLocalPlayerReady = function(LocalPlayerService)
        local LocalCharacter = LocalPlayerService.LocalPlayer and LocalPlayerService.LocalPlayer.Character and LocalPlayerService.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if LocalCharacter then
            LocalCharacter = LocalPlayerService.LocalPlayer.Character:FindFirstChild("Humanoid")
        end
        return LocalCharacter
    end,
    isValidTarget = function(GameService1, PlayerService)
        if PlayerService == GameService1.LocalPlayer then
            return false
        end
        if GameService1:isPlayerWhitelisted(PlayerService) then
            return false
        end
        if next(GameService1.State.blacklist) and not GameService1.State.blacklist[PlayerService.UserId] then
            return false
        end
        local PlayerCharacter = PlayerService.Character
        if not PlayerCharacter then
            return false
        end
        local PlayerHumanoid = PlayerCharacter:FindFirstChild("Humanoid")
        local PlayerHumanoidRootPart = PlayerCharacter:FindFirstChild("HumanoidRootPart")
        if PlayerHumanoid then
            if PlayerHumanoidRootPart then
                PlayerHumanoidRootPart = PlayerHumanoid.Health > 0 and PlayerHumanoid:GetState() ~= Enum.HumanoidStateType.Dead
            end
        else
            PlayerHumanoidRootPart = PlayerHumanoid
        end
        return PlayerHumanoidRootPart
    end,
    isValidTargetEnhanced = function(GameService2, PlayerService1)
        if PlayerService1 and PlayerService1.Parent then
            if PlayerService1 ~= GameService2.LocalPlayer then
                local PlayerCharacter1 = PlayerService1.Character
                if PlayerCharacter1 then
                    local PlayerHumanoid1 = PlayerCharacter1:FindFirstChild("Humanoid")
                    if PlayerHumanoid1 and PlayerCharacter1:FindFirstChild("HumanoidRootPart") then
                        return PlayerHumanoid1.Health > 0
                    else
                        return false
                    end
                else
                    return false
                end
            else
                return false
            end
        else
            return false
        end
    end,
    getPlayersInRange = function(GameService3, PlayerService2, GameService4)
        local PlayerIterator1, PlayerKey1, PlayerValue1 = pairs(GameService3.Players:GetPlayers())
        local EmptyTable = {}
        while true do
            local TargetPlayer1
            PlayerValue1, TargetPlayer1 = PlayerIterator1(PlayerKey1, PlayerValue1)
            if PlayerValue1 == nil then
                break
            end
            if GameService3:isValidTarget(TargetPlayer1) then
                local DistanceMagnitude1 = (PlayerService2 - TargetPlayer1.Character.HumanoidRootPart.Position).Magnitude
                if DistanceMagnitude1 <= GameService4 then
                    table.insert(EmptyTable, {
                        player = TargetPlayer1,
                        distance = DistanceMagnitude1
                    })
                end
            end
        end
        return EmptyTable
    end,
    fastTouchFire = function(UnusedParameter, GameService5, PlayerService3)
        firetouchinterest(GameService5, PlayerService3, 0)
        firetouchinterest(GameService5, PlayerService3, 1)
    end,
    equipPunch = function(LocalPlayerService1)
        local LocalCharacter1 = LocalPlayerService1.LocalPlayer.Character
        if not LocalCharacter1 or LocalCharacter1:FindFirstChild("Punch") then
            return LocalCharacter1 and true or LocalCharacter1
        end
        local LocalBackpack = LocalPlayerService1.LocalPlayer.Backpack
        if not LocalBackpack then
            return false
        end
        local PunchTool = LocalBackpack:FindFirstChild("Punch")
        if not PunchTool or PunchTool.ClassName ~= "Tool" then
            return false
        end
        PunchTool.Parent = LocalCharacter1
        return true
    end,
    unequipPunch = function(LocalPlayerService2)
        local LocalCharacter2 = LocalPlayerService2.LocalPlayer.Character
        if LocalCharacter2 then
            local PunchTool1 = LocalCharacter2:FindFirstChild("Punch")
            if PunchTool1 then
                PunchTool1.Parent = LocalPlayerService2.LocalPlayer.Backpack
            end
        end
    end,
    performCombat = function(UserParameter3, GameService6, UserProfile1)
        local HumanoidRootPart1 = UserParameter3.State.killMethod == "Teleporting" and UserProfile1:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart1 then
            local PositionVector1 = GameService6.Position
            local LookVector = GameService6.CFrame.LookVector * - 3
            HumanoidRootPart1.CFrame = CFrame.lookAt(PositionVector1 + LookVector, PositionVector1)
        end
        local LeftHand = UserProfile1:FindFirstChild("LeftHand")
        local RightHand = UserProfile1:FindFirstChild("RightHand")
        if LeftHand then
            UserParameter3:fastTouchFire(GameService6, LeftHand)
        end
        if RightHand then
            UserParameter3:fastTouchFire(GameService6, RightHand)
        end
        pcall(function()
            if UserParameter3.LocalPlayer:FindFirstChild("muscleEvent") then
                UserParameter3.LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                UserParameter3.LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
            end
            local PunchTool2 = UserProfile1:FindFirstChild("Punch")
            if PunchTool2 and PunchTool2:FindFirstChild("Handle") then
                PunchTool2:Activate()
            end
        end)
    end,
    createVisualEffects = function(GameService7)
        GameService7:cleanupVisualEffects()
        local CurrentColors1 = GameService7:getCurrentColors()
        local PartInstance1 = Instance.new("Part")
        PartInstance1.Name = "GlowDot"
        PartInstance1.Size = Vector3.new(6, 0.4, 6)
        PartInstance1.Shape = Enum.PartType.Cylinder
        PartInstance1.Material = Enum.Material.ForceField
        PartInstance1.CanCollide = false
        PartInstance1.Anchored = true
        PartInstance1.Color = CurrentColors1.dotMain
        PartInstance1.Transparency = 0.1
        PartInstance1.Parent = workspace
        PartInstance1.CFrame = CFrame.Angles(0, 0, math.rad(90))
        local PointLightInstance1 = Instance.new("PointLight")
        PointLightInstance1.Color = CurrentColors1.lightSafe
        PointLightInstance1.Brightness = 4
        PointLightInstance1.Range = 15
        PointLightInstance1.Parent = PartInstance1
        local PartInstance2 = Instance.new("Part")
        PartInstance2.Name = "OuterRing"
        PartInstance2.Size = Vector3.new(8, 0.2, 8)
        PartInstance2.Shape = Enum.PartType.Cylinder
        PartInstance2.Material = Enum.Material.Neon
        PartInstance2.CanCollide = false
        PartInstance2.Anchored = true
        PartInstance2.Color = CurrentColors1.dotOuter
        PartInstance2.Transparency = 0.6
        PartInstance2.Parent = workspace
        PartInstance2.CFrame = CFrame.Angles(0, 0, math.rad(90))
        local PartInstance3 = Instance.new("Part")
        PartInstance3.Name = "InnerCore"
        PartInstance3.Size = Vector3.new(2, 0.5, 2)
        PartInstance3.Shape = Enum.PartType.Cylinder
        PartInstance3.Material = Enum.Material.Neon
        PartInstance3.CanCollide = false
        PartInstance3.Anchored = true
        PartInstance3.Color = CurrentColors1.dotInner
        PartInstance3.Transparency = 0.3
        PartInstance3.Parent = workspace
        PartInstance3.CFrame = CFrame.Angles(0, 0, math.rad(90))
        GameService7.State.glowDot = {
            main = PartInstance1,
            outer = PartInstance2,
            inner = PartInstance3
        }
        local AttachmentInstance = Instance.new("Attachment")
        AttachmentInstance.Parent = PartInstance1
        AttachmentInstance.Position = Vector3.new(0, 0.3, 0)
        local ParticleEmitterInstance = Instance.new("ParticleEmitter")
        ParticleEmitterInstance.Parent = AttachmentInstance
        ParticleEmitterInstance.Enabled = true
        ParticleEmitterInstance.Lifetime = NumberRange.new(2, 4)
        ParticleEmitterInstance.Rate = 35
        ParticleEmitterInstance.SpreadAngle = Vector2.new(60, 60)
        ParticleEmitterInstance.Speed = NumberRange.new(3, 12)
        ParticleEmitterInstance.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, CurrentColors1.dotInner),
            ColorSequenceKeypoint.new(0.5, CurrentColors1.dotMain),
            ColorSequenceKeypoint.new(1, CurrentColors1.dotOuter)
        })
        ParticleEmitterInstance.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.2),
            NumberSequenceKeypoint.new(0.5, 0.1),
            NumberSequenceKeypoint.new(1, 1)
        })
        ParticleEmitterInstance.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.3),
            NumberSequenceKeypoint.new(0.5, 0.7),
            NumberSequenceKeypoint.new(1, 0.2)
        })
        ParticleEmitterInstance.Acceleration = Vector3.new(0, - 3, 0)
        ParticleEmitterInstance.VelocityInheritance = 0.1
        ParticleEmitterInstance.Drag = 3
        for LoopCounter = 1, GameService7.Config.orbitingBalls do
            local PartInstance = Instance.new("Part")
            PartInstance.Name = "FlyingBall_" .. LoopCounter
            PartInstance.Size = Vector3.new(1.5, 1.5, 1.5)
            PartInstance.Shape = Enum.PartType.Ball
            PartInstance.Material = Enum.Material.Neon
            PartInstance.CanCollide = false
            PartInstance.Anchored = true
            PartInstance.Color = CurrentColors1.ballSafe
            PartInstance.Transparency = 0.1
            PartInstance.Parent = workspace
            local PointLightInstance = Instance.new("PointLight")
            PointLightInstance.Color = CurrentColors1.lightSafe
            PointLightInstance.Brightness = 3
            PointLightInstance.Range = 10
            PointLightInstance.Parent = PartInstance
            local AttachmentInstance1 = Instance.new("Attachment")
            local AttachmentInstance2 = Instance.new("Attachment")
            AttachmentInstance1.Parent = PartInstance
            AttachmentInstance2.Parent = PartInstance
            AttachmentInstance2.Position = Vector3.new(0, 0, 0)
            local TrailInstance = Instance.new("Trail")
            TrailInstance.Attachment0 = AttachmentInstance1
            TrailInstance.Attachment1 = AttachmentInstance2
            TrailInstance.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, CurrentColors1.lightSafe),
                ColorSequenceKeypoint.new(0.5, CurrentColors1.ballSafe),
                ColorSequenceKeypoint.new(1, CurrentColors1.trailEnd)
            })
            TrailInstance.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.2),
                NumberSequenceKeypoint.new(1, 1)
            })
            TrailInstance.Lifetime = 1.5
            TrailInstance.MinLength = 0
            TrailInstance.FaceCamera = true
            TrailInstance.WidthScale = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(1, 0)
            })
            TrailInstance.Parent = workspace
            table.insert(GameService7.State.orbitingBalls, {
                part = PartInstance,
                light = PointLightInstance,
                trail = TrailInstance,
                trailAttachment0 = AttachmentInstance1,
                trailAttachment1 = AttachmentInstance2,
                baseAngle = LoopCounter / GameService7.Config.orbitingBalls * math.pi * 2,
                orbitSpeed = 1.2,
                index = LoopCounter
            })
        end
    end,
    updateVisualEffects = function(GameParameter)
        if GameParameter.State.visualsEnabled then
            local Vector3Position = Vector3.new(0, 0, 0)
            if GameParameter:isLocalPlayerReady() then
                Vector3Position = GameParameter.LocalPlayer.Character.HumanoidRootPart.Position
            end
            local TickValue = tick()
            local PlayerInRange = # GameParameter:getPlayersInRange(Vector3Position, GameParameter.Config.killAuraRange) > 0
            if PlayerInRange ~= GameParameter.State.hasTargetsNearby then
                GameParameter.State.hasTargetsNearby = PlayerInRange
                GameParameter:updateAllColors()
            end
            GameParameter:updateWhitelistIndicators()
            if GameParameter.State.glowDot and (GameParameter.State.glowDot.main and GameParameter.State.glowDot.main.Parent) then
                local OffsetPosition = Vector3Position - Vector3.new(0, 4, 0)
                local SinValue1 = 1 + math.sin(TickValue * 2) * 0.12
                GameParameter.State.glowDot.main.Size = Vector3.new(6 * SinValue1, 0.4, 6 * SinValue1)
                GameParameter.State.glowDot.main.CFrame = CFrame.new(OffsetPosition) * CFrame.Angles(0, 0, math.rad(90))
                local SinValue2 = 1 + math.sin(TickValue * 1.5) * 0.08
                GameParameter.State.glowDot.outer.Size = Vector3.new(8 * SinValue2, 0.2, 8 * SinValue2)
                GameParameter.State.glowDot.outer.CFrame = CFrame.new(OffsetPosition - Vector3.new(0, 0.1, 0)) * CFrame.Angles(0, 0, math.rad(90))
                local SinValue3 = 1 + math.sin(TickValue * 3) * 0.15
                local MultipliedTick = TickValue * 2
                GameParameter.State.glowDot.inner.Size = Vector3.new(2 * SinValue3, 0.5, 2 * SinValue3)
                GameParameter.State.glowDot.inner.CFrame = CFrame.new(OffsetPosition + Vector3.new(0, 0.1, 0)) * CFrame.Angles(0, MultipliedTick, math.rad(90))
                local SinOffset = math.sin(TickValue * 2.5) * 0.05
                GameParameter.State.glowDot.main.Transparency = 0.1 + SinOffset
                GameParameter.State.glowDot.outer.Transparency = 0.6 + SinOffset * 0.5
                GameParameter.State.glowDot.inner.Transparency = 0.3 + SinOffset
                local GlowDotPointLight = GameParameter.State.glowDot.main:FindFirstChild("PointLight")
                if GlowDotPointLight then
                    GlowDotPointLight.Brightness = 4 + math.sin(TickValue * 2.5) * 0.8
                end
            end
            local OrbitingBallPair1, OrbitingBallPair2, OrbitingBallPair3 = pairs(GameParameter.State.orbitingBalls)
            while true do
                local OrbitData
                OrbitingBallPair3, OrbitData = OrbitingBallPair1(OrbitingBallPair2, OrbitingBallPair3)
                if OrbitingBallPair3 == nil then
                    break
                end
                if OrbitData.part and OrbitData.part.Parent then
                    local KillAuraRange = GameParameter.Config.killAuraRange
                    local OrbitAngle = OrbitData.baseAngle + TickValue * OrbitData.orbitSpeed
                    local CosineValue = math.cos(OrbitAngle) * KillAuraRange
                    local SineValue = math.sin(OrbitAngle) * KillAuraRange
                    local IndexedSine = math.sin(TickValue * 1.5 + OrbitData.index) * 2
                    OrbitData.part.CFrame = CFrame.new(Vector3Position.X + CosineValue, Vector3Position.Y + 2 + IndexedSine, Vector3Position.Z + SineValue)
                    local IndexedSinOffset = 1 + math.sin(TickValue * 2.5 + OrbitData.index * 0.8) * 0.1
                    OrbitData.part.Size = Vector3.new(1.5 * IndexedSinOffset, 1.5 * IndexedSinOffset, 1.5 * IndexedSinOffset)
                    OrbitData.trailAttachment1.Position = Vector3.new(- math.cos(OrbitAngle) * 2, 0, - math.sin(OrbitAngle) * 2)
                end
            end
        end
    end,
    killAuraLoop = function(PlayerParameter)
        if PlayerParameter.State.killAuraEnabled and PlayerParameter:isLocalPlayerReady() then
            local LocalCharacter = PlayerParameter.LocalPlayer.Character
            local PlayersInRange = PlayerParameter:getPlayersInRange(LocalCharacter.HumanoidRootPart.Position, PlayerParameter.Config.killAuraRange)
            if # PlayersInRange <= 0 then
                PlayerParameter:unequipPunch()
            else
                PlayerParameter:equipPunch()
                local PlayerPair1, PlayerPair2, PlayerPair3 = pairs(PlayersInRange)
                while true do
                    local UnusedVariable
                    PlayerPair3, UnusedVariable = PlayerPair1(PlayerPair2, PlayerPair3)
                    if PlayerPair3 == nil then
                        break
                    end
                    PlayerParameter:performCombat(UnusedVariable.player.Character.HumanoidRootPart, LocalCharacter)
                end
            end
        end
    end,
    refreshTargetReferences = function(GameConfigParameter)
        local TargetedPlayerPair1, TargetedPlayerPair2, TargetedPlayerPair3 = pairs(GameConfigParameter.State.targetedPlayers)
        local EmptyTable = {}
        while true do
            local UnusedVariable2
            TargetedPlayerPair3, UnusedVariable2 = TargetedPlayerPair1(TargetedPlayerPair2, TargetedPlayerPair3)
            if TargetedPlayerPair3 == nil then
                break
            end
            local TargetedPlayer = GameConfigParameter.Players:GetPlayerByUserId(TargetedPlayerPair3)
            if TargetedPlayer and TargetedPlayer.Parent then
                EmptyTable[TargetedPlayerPair3] = TargetedPlayer
            end
        end
        GameConfigParameter.State.targetedPlayers = EmptyTable
    end,
    onPlayerCharacterAdded = function(GameConfigParameter2, UnusedParameter)
        local TargetedPlayerPair4, TargetedPlayerPair5, TargetedPlayerPair6 = pairs(GameConfigParameter2.State.targetedPlayers)
        while true do
            local UnusedVariable3
            TargetedPlayerPair6, UnusedVariable3 = TargetedPlayerPair4(TargetedPlayerPair5, TargetedPlayerPair6)
            if TargetedPlayerPair6 == nil then
                break
            end
            if UnusedVariable3 and UnusedVariable3.UserId == UnusedParameter.UserId then
                GameConfigParameter2.State.targetedPlayers[TargetedPlayerPair6] = UnusedParameter
                break
            end
        end
    end,
    cleanupVisualEffects = function(GameConfigParameter3)
        local OrbitingBallPair4, OrbitingBallPair5, OrbitingBallPair6 = pairs(GameConfigParameter3.State.orbitingBalls)
        while true do
            local UnusedVariable4
            OrbitingBallPair6, UnusedVariable4 = OrbitingBallPair4(OrbitingBallPair5, OrbitingBallPair6)
            if OrbitingBallPair6 == nil then
                break
            end
            if UnusedVariable4.part then
                UnusedVariable4.part:Destroy()
            end
            if UnusedVariable4.trail then
                UnusedVariable4.trail:Destroy()
            end
        end
        GameConfigParameter3.State.orbitingBalls = {}
        if GameConfigParameter3.State.glowDot then
            if GameConfigParameter3.State.glowDot.main then
                GameConfigParameter3.State.glowDot.main:Destroy()
            end
            if GameConfigParameter3.State.glowDot.outer then
                GameConfigParameter3.State.glowDot.outer:Destroy()
            end
            if GameConfigParameter3.State.glowDot.inner then
                GameConfigParameter3.State.glowDot.inner:Destroy()
            end
            GameConfigParameter3.State.glowDot = nil
        end
        local WhitelistIndicatorPair1, WhitelistIndicatorPair2, WhitelistIndicatorPair3 = pairs(GameConfigParameter3.State.whitelistIndicators)
        while true do
            local UnusedVariable5
            WhitelistIndicatorPair3, UnusedVariable5 = WhitelistIndicatorPair1(WhitelistIndicatorPair2, WhitelistIndicatorPair3)
            if WhitelistIndicatorPair3 == nil then
                break
            end
            GameConfigParameter3:removeWhitelistIndicator(WhitelistIndicatorPair3)
        end
        GameConfigParameter3.State.whitelistIndicators = {}
    end,
    cleanup = function(ConnectionParameter)
        local ConnectionPair1, ConnectionPair2, ConnectionPair3 = pairs(ConnectionParameter.State.connections)
        while true do
            local UnusedVariable6
            ConnectionPair3, UnusedVariable6 = ConnectionPair1(ConnectionPair2, ConnectionPair3)
            if ConnectionPair3 == nil then
                break
            end
            if UnusedVariable6 then
                UnusedVariable6:Disconnect()
            end
        end
        ConnectionParameter.State.connections = {}
        ConnectionParameter:cleanupVisualEffects()
        if ConnectionParameter.State.originalLighting then
            local LightingService = game:GetService("Lighting")
            ConnectionParameter.TweenService:Create(LightingService, TweenInfo.new(2), ConnectionParameter.State.originalLighting):Play()
            ConnectionParameter.State.originalLighting = nil
        end
    end,
    setupWhitelist = function(PlayersService)
        TabConfig.Whitelist:AddToggle({
            Title = "Auto Whitelist Clans",
            Content = "Automatically whitelist players from clans in the config file",
            Default = false,
            Callback = function(UnusedParameter2)
                PlayersService.State.clanWhitelistEnabled = UnusedParameter2
                if UnusedParameter2 then
                    PlayersService:ensureClanFile()
                    local PlayerIterator1, PlayerIterator2, PlayerIterator3 = pairs(PlayersService.Players:GetPlayers())
                    while true do
                        local UnusedVariable7
                        PlayerIterator3, UnusedVariable7 = PlayerIterator1(PlayerIterator2, PlayerIterator3)
                        if PlayerIterator3 == nil then
                            break
                        end
                        if PlayersService:isPlayerInWhitelistClan(UnusedVariable7) then
                            PlayersService.State.whitelist[UnusedVariable7.UserId] = true
                        end
                    end
                end
            end
        })
        PlayersService.UI.whitelistDropdown = TabConfig.Whitelist:AddDropdown({
            Title = "Add Players to Whitelist",
            Content = "Select players from the dropdown to whitelist",
            Multi = true,
            Options = PlayersService:getCurrentPlayers(),
            Default = {},
            Callback = function(TableParameter)
                PlayersService.UI.whitelistSelected = TableParameter or {}
                if TableParameter then
                    local TablePair1, TablePair2, TablePair3 = pairs(TableParameter)
                    while true do
                        local UnusedVariable8
                        TablePair3, UnusedVariable8 = TablePair1(TablePair2, TablePair3)
                        if TablePair3 == nil then
                            break
                        end
                        local PlayerIterator4, PlayerIterator5, PlayerIterator6 = pairs(PlayersService.Players:GetPlayers())
                        while true do
                            local UnusedVariable9
                            PlayerIterator6, UnusedVariable9 = PlayerIterator4(PlayerIterator5, PlayerIterator6)
                            if PlayerIterator6 == nil then
                                break
                            end
                            if UnusedVariable9.Name == UnusedVariable8 then
                                PlayersService.State.whitelist[UnusedVariable9.UserId] = true
                                break
                            end
                        end
                    end
                end
            end
        })
        TabConfig.Whitelist:AddInput({
            Title = "Add Player to Whitelist (Manual)",
            Content = "Enter username or display name",
            Default = "",
            Callback = function(StringParameter)
                local LowercaseString = string.lower(StringParameter)
                local PlayerIterator7, PlayerIterator8, PlayerIterator9 = pairs(PlayersService.Players:GetPlayers())
                while true do
                    local UnusedVariable10
                    PlayerIterator9, UnusedVariable10 = PlayerIterator7(PlayerIterator8, PlayerIterator9)
                    if PlayerIterator9 == nil then
                        break
                    end
                    if string.lower(UnusedVariable10.Name) == LowercaseString or string.lower(UnusedVariable10.DisplayName) == LowercaseString then
                        PlayersService.State.whitelist[UnusedVariable10.UserId] = true
                        break
                    end
                end
            end
        })
        TabConfig.Whitelist:AddButton({
            Title = "Clear Whitelist",
            Content = "Remove all players from whitelist",
            Callback = function()
                PlayersService.State.whitelist = {}
                PlayersService.UI.whitelistSelected = {}
                if PlayersService.UI.whitelistDropdown then
                    PlayersService.UI.whitelistDropdown:Set({})
                end
            end
        })
        TabConfig.Whitelist:AddToggle({
            Title = "Auto Whitelist Friends",
            Content = "Automatically whitelist your Roblox friends",
            Default = false,
            Callback = function(UnusedParameter3)
                _G.whitelistFriends = UnusedParameter3
                if UnusedParameter3 then
                    task.spawn(function()
                        while _G.whitelistFriends do
                            local PlayerIterator10, PlayerIterator11, PlayerIterator12 = pairs(PlayersService.Players:GetPlayers())
                            while true do
                                local UnusedVariable11
                                PlayerIterator12, UnusedVariable11 = PlayerIterator10(PlayerIterator11, PlayerIterator12)
                                if PlayerIterator12 == nil then
                                    break
                                end
                                if UnusedVariable11:IsFriendsWith(PlayersService.Players.LocalPlayer.UserId) then
                                    PlayersService.State.whitelist[UnusedVariable11.UserId] = true
                                end
                            end
                            task.wait(1)
                        end
                    end)
                end
            end
        })
    end,
    setupBlacklist = function(PlayersService2)
        PlayersService2.UI.blacklistDropdown = TabConfig.Blacklist:AddDropdown({
            Title = "Add Players to Blacklist",
            Content = "Select players from the dropdown to blacklist",
            Multi = true,
            Options = PlayersService2:getCurrentPlayers(),
            Default = {},
            Callback = function(TableParameter2)
                PlayersService2.UI.blacklistSelected = TableParameter2 or {}
                if TableParameter2 then
                    local TablePair4, TablePair5, TablePair6 = pairs(TableParameter2)
                    while true do
                        local UnusedVariable12
                        TablePair6, UnusedVariable12 = TablePair4(TablePair5, TablePair6)
                        if TablePair6 == nil then
                            break
                        end
                        local PlayerIterator13, PlayerIterator14, PlayerIterator15 = pairs(PlayersService2.Players:GetPlayers())
                        while true do
                            local UnusedVariable13
                            PlayerIterator15, UnusedVariable13 = PlayerIterator13(PlayerIterator14, PlayerIterator15)
                            if PlayerIterator15 == nil then
                                break
                            end
                            if UnusedVariable13.Name == UnusedVariable12 then
                                PlayersService2.State.blacklist[UnusedVariable13.UserId] = true
                                break
                            end
                        end
                    end
                end
            end
        })
        TabConfig.Blacklist:AddInput({
            Title = "Add Player to Blacklist (Manual)",
            Content = "Enter username or display name",
            Default = "",
            Callback = function(UnusedParameter4)
                local LowercaseString = string.lower(UnusedParameter4)
                local PlayerIterator, PlayerIterator2, PlayerIterator3 = pairs(PlayersService2.Players:GetPlayers())
                while true do
                    local UnusedVariable
                    PlayerIterator3, UnusedVariable = PlayerIterator(PlayerIterator2, PlayerIterator3)
                    if PlayerIterator3 == nil then
                        break
                    end
                    if string.lower(UnusedVariable.Name) == LowercaseString or string.lower(UnusedVariable.DisplayName) == LowercaseString then
                        PlayersService2.State.blacklist[UnusedVariable.UserId] = true
                        break
                    end
                end
            end
        })
        TabConfig.Blacklist:AddButton({
            Title = "Clear Blacklist",
            Content = "Remove all players from blacklist",
            Callback = function()
                PlayersService2.State.blacklist = {}
                PlayersService2.UI.blacklistSelected = {}
                if PlayersService2.UI.blacklistDropdown then
                    PlayersService2.UI.blacklistDropdown:Set({})
                end
            end
        })
    end,
    setupKiller = function(GameParameter)
        TabConfig.Killer:AddDropdown({
            Title = "Combat Method",
            Content = "Select combat approach",
            Multi = false,
            Options = {
                "Normal",
                "Teleporting"
            },
            Default = {
                "Normal"
            },
            Callback = function(FunctionParameter1)
                if FunctionParameter1 and FunctionParameter1[1] then
                    GameParameter.State.killMethod = FunctionParameter1[1]
                end
            end
        })
        TabConfig.Killer:AddToggle({
            Title = "Combat Mode",
            Content = "Enable combat functionality",
            Default = false,
            Callback = function(FunctionParameter2)
                GameParameter.State.isKilling = FunctionParameter2
                if FunctionParameter2 then
                    local NilValue = nil
                    local ZeroValue1 = 0
                    local ZeroValue2 = 0
                    local ZeroValue3 = 0
                    NilValue = GameParameter.RunService.RenderStepped:Connect(function(FunctionParameter3)
                        if GameParameter.State.isKilling then
                            ZeroValue1 = ZeroValue1 + FunctionParameter3
                            ZeroValue2 = ZeroValue2 + FunctionParameter3
                            ZeroValue3 = ZeroValue3 + FunctionParameter3
                            if ZeroValue1 >= 0.5 then
                                ZeroValue1 = 0
                                GameParameter:equipPunch()
                            end
                            if ZeroValue3 >= 5 then
                                ZeroValue3 = 0
                                pcall(function()
                                    local LocalCharacter = GameParameter.LocalPlayer.Character
                                    if LocalCharacter then
                                        local PunchTool = LocalCharacter:FindFirstChild("Punch")
                                        if PunchTool then
                                            PunchTool.Parent = GameParameter.LocalPlayer.Backpack
                                            task.wait()
                                            GameParameter:equipPunch()
                                        else
                                            GameParameter:equipPunch()
                                        end
                                    end
                                end)
                            end
                            if GameParameter:isLocalPlayerReady() then
                                local LocalCharacter2 = GameParameter.LocalPlayer.Character
                                if ZeroValue2 >= 0.1 then
                                    ZeroValue2 = 0
                                    pcall(function()
                                        GameParameter.LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                                        GameParameter.LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
                                    end)
                                end
                                local PlayerIterator4, PlayerIterator5, PlayerIterator6 = pairs(GameParameter.Players:GetPlayers())
                                while true do
                                    local UnusedValue
                                    PlayerIterator6, UnusedValue = PlayerIterator4(PlayerIterator5, PlayerIterator6)
                                    if PlayerIterator6 == nil then
                                        break
                                    end
                                    if GameParameter:isValidTarget(UnusedValue) then
                                        pcall(function()
                                            GameParameter:performCombat(UnusedValue.Character.HumanoidRootPart, LocalCharacter2)
                                        end)
                                    end
                                end
                            end
                        else
                            NilValue:Disconnect()
                            return
                        end
                    end)
                end
            end
        })
    end,
    setupKillAura = function(GameParameter2)
        TabConfig["Kill Aura"]:AddSlider({
            Title = "Kill Aura Range",
            Content = "Set the range for kill aura detection",
            Increment = 5,
            Min = 10,
            Max = 100,
            Default = 50,
            Callback = function(FunctionParameter4)
                GameParameter2.Config.killAuraRange = FunctionParameter4
            end
        })
        TabConfig["Kill Aura"]:AddDropdown({
            Title = "Color Theme",
            Content = "Choose the visual effects color theme",
            Options = {
                "Purple",
                "Blue",
                "Red",
                "Green",
                "Ocean",
                "Forest",
                "Gold",
                "Silver"
            },
            Default = {
                "Purple"
            },
            Callback = function(FunctionParameter5)
                if type(FunctionParameter5) == "table" then
                    FunctionParameter5 = FunctionParameter5[1]
                end
                if GameParameter2.ColorThemes[FunctionParameter5] then
                    GameParameter2.Config.selectedColorTheme = FunctionParameter5
                    if GameParameter2.State.visualsEnabled then
                        GameParameter2:updateAllColors()
                    end
                end
            end
        })
        TabConfig["Kill Aura"]:AddToggle({
            Title = "Visual Effects",
            Content = "Display flying balls and glow effects",
            Default = false,
            Callback = function(FunctionParameter6)
                GameParameter2.State.visualsEnabled = FunctionParameter6
                if FunctionParameter6 then
                    GameParameter2:createVisualEffects()
                    local LightingService = game:GetService("Lighting")
                    local LightingSettings = {
                        Brightness = 0.5,
                        Ambient = Color3.fromRGB(20, 10, 40),
                        ColorShift_Top = Color3.fromRGB(50, 30, 80),
                        ColorShift_Bottom = Color3.fromRGB(30, 20, 60),
                        OutdoorAmbient = Color3.fromRGB(15, 10, 30),
                        ShadowSoftness = 0.8
                    }
                    GameParameter2.TweenService:Create(LightingService, TweenInfo.new(3), LightingSettings):Play()
                    GameParameter2.State.connections.visualUpdate = GameParameter2.RunService.Heartbeat:Connect(function()
                        local TickCount = tick()
                        if TickCount - GameParameter2.State.lastUpdate >= GameParameter2.Config.updateInterval then
                            GameParameter2.State.lastUpdate = TickCount
                            GameParameter2:updateVisualEffects()
                        end
                    end)
                else
                    if GameParameter2.State.originalLighting then
                        local LightingService2 = game:GetService("Lighting")
                        GameParameter2.TweenService:Create(LightingService2, TweenInfo.new(3), GameParameter2.State.originalLighting):Play()
                    end
                    if GameParameter2.State.connections.visualUpdate then
                        GameParameter2.State.connections.visualUpdate:Disconnect()
                        GameParameter2.State.connections.visualUpdate = nil
                    end
                    GameParameter2:cleanupVisualEffects()
                end
            end
        })
        TabConfig["Kill Aura"]:AddToggle({
            Title = "Kill Aura",
            Content = "Auto equip/unequip based on nearby players",
            Default = false,
            Callback = function(FunctionParameter7)
                GameParameter2.State.killAuraEnabled = FunctionParameter7
                if FunctionParameter7 then
                    local ZeroValue4 = 0
                    local ZeroValue5 = 0
                    local ZeroValue6 = 0
                    local FalseValue = false
                    GameParameter2.State.connections.killAura = GameParameter2.RunService.RenderStepped:Connect(function(FunctionParameter8)
                        if not GameParameter2.State.killAuraEnabled then
                            if GameParameter2.State.connections.killAura then
                                GameParameter2.State.connections.killAura:Disconnect()
                                GameParameter2.State.connections.killAura = nil
                            end
                            return
                        end
                        ZeroValue4 = ZeroValue4 + FunctionParameter8
                        ZeroValue5 = ZeroValue5 + FunctionParameter8
                        ZeroValue6 = ZeroValue6 + FunctionParameter8
                        if not GameParameter2:isLocalPlayerReady() then
                            return
                        end
                        local LocalCharacter3 = GameParameter2.LocalPlayer.Character
                        local HumanoidRootPart = LocalCharacter3:FindFirstChild("HumanoidRootPart")
                        if not HumanoidRootPart then
                            return
                        end
                        local PlayerIterator7, PlayerIterator8, PlayerIterator9 = pairs(GameParameter2.Players:GetPlayers())
                        local FalseValue2 = false
                        while true do
                            local UnusedVariable2
                            PlayerIterator9, UnusedVariable2 = PlayerIterator7(PlayerIterator8, PlayerIterator9)
                            if PlayerIterator9 == nil then
                                break
                            end
                            if GameParameter2:isValidTarget(UnusedVariable2) then
                                local HumanoidRootPart2 = UnusedVariable2.Character:FindFirstChild("HumanoidRootPart")
                                if HumanoidRootPart2 and (HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude <= GameParameter2.Config.killAuraRange then
                                    FalseValue2 = true
                                    break
                                end
                            end
                        end
                        if FalseValue2 and not FalseValue then
                            GameParameter2:equipPunch()
                        elseif not FalseValue2 and FalseValue then
                            GameParameter2:unequipPunch()
                        end
                        FalseValue = FalseValue2
                        if FalseValue2 then
                            if ZeroValue6 >= 5 then
                                ZeroValue6 = 0
                                pcall(function()
                                    local LocalCharacter4 = GameParameter2.LocalPlayer.Character
                                    if LocalCharacter4 then
                                        local PunchTool2 = LocalCharacter4:FindFirstChild("Punch")
                                        if PunchTool2 then
                                            PunchTool2.Parent = GameParameter2.LocalPlayer.Backpack
                                            wait(0.1)
                                            GameParameter2:equipPunch()
                                        else
                                            GameParameter2:equipPunch()
                                        end
                                    end
                                end)
                            end
                            if ZeroValue5 >= 0.05 then
                                ZeroValue5 = 0
                                pcall(function()
                                    if GameParameter2.LocalPlayer:FindFirstChild("muscleEvent") then
                                        GameParameter2.LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                                        GameParameter2.LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
                                    end
                                end)
                            end
                            local PlayerIterator10, PlayerIterator11, PlayerIterator12 = pairs(GameParameter2.Players:GetPlayers())
                            while true do
                                local UnusedVariable3
                                PlayerIterator12, UnusedVariable3 = PlayerIterator10(PlayerIterator11, PlayerIterator12)
                                if PlayerIterator12 == nil then
                                    break
                                end
                                if GameParameter2:isValidTarget(UnusedVariable3) then
                                    local HumanoidRootPart3 = UnusedVariable3.Character:FindFirstChild("HumanoidRootPart")
                                    if HumanoidRootPart3 and (HumanoidRootPart.Position - HumanoidRootPart3.Position).Magnitude <= GameParameter2.Config.killAuraRange then
                                        GameParameter2:performCombat(HumanoidRootPart3, LocalCharacter3)
                                    end
                                end
                            end
                        end
                    end)
                else
                    if GameParameter2.State.connections.killAura then
                        GameParameter2.State.connections.killAura:Disconnect()
                        GameParameter2.State.connections.killAura = nil
                    end
                    GameParameter2:unequipPunch()
                end
            end
        })
    end,
    setupTargetPlayer = function(GameParameter3)
        GameParameter3.UI.targetPlayerDropdown = TabConfig["Target Player"]:AddDropdown({
            Title = "Select Players to Target",
            Content = "Select players from dropdown to add to target list",
            Multi = true,
            Options = GameParameter3:getCurrentPlayers(),
            Default = {},
            Callback = function(FunctionParameter9)
                GameParameter3.UI.targetSelected = FunctionParameter9 or {}
                if FunctionParameter9 then
                    local TargetedPlayerIterator, TargetedPlayerIterator2, TargetedPlayerIterator3 = pairs(GameParameter3.State.targetedPlayers)
                    while true do
                        local UnusedVariable4
                        TargetedPlayerIterator3, UnusedVariable4 = TargetedPlayerIterator(TargetedPlayerIterator2, TargetedPlayerIterator3)
                        if TargetedPlayerIterator3 == nil then
                            break
                        end
                        GameParameter3.State.targetedPlayers[TargetedPlayerIterator3] = nil
                    end
                    local TableIterator, TableIterator2, TableIterator3 = pairs(FunctionParameter9)
                    while true do
                        local UnusedVariable5
                        TableIterator3, UnusedVariable5 = TableIterator(TableIterator2, TableIterator3)
                        if TableIterator3 == nil then
                            break
                        end
                        local PlayerIterator13, PlayerIterator14, PlayerIterator15 = pairs(GameParameter3.Players:GetPlayers())
                        while true do
                            local UnusedVariable6
                            PlayerIterator15, UnusedVariable6 = PlayerIterator13(PlayerIterator14, PlayerIterator15)
                            if PlayerIterator15 == nil then
                                break
                            end
                            if UnusedVariable6.Name == UnusedVariable5 then
                                GameParameter3.State.targetedPlayers[UnusedVariable6.UserId] = UnusedVariable6
                                break
                            end
                        end
                    end
                end
            end
        })
        TabConfig["Target Player"]:AddInput({
            Title = "Add Target (Username/DisplayName)",
            Content = "Enter username or display name to target",
            Default = "",
            Callback = function(FunctionParameter10)
                if FunctionParameter10 and FunctionParameter10 ~= "" then
                    local LowercaseString2 = string.lower(FunctionParameter10)
                    local PlayerIterator16, PlayerIterator17, PlayerIterator18 = pairs(GameParameter3.Players:GetPlayers())
                    while true do
                        local UnusedVariable7
                        PlayerIterator18, UnusedVariable7 = PlayerIterator16(PlayerIterator17, PlayerIterator18)
                        if PlayerIterator18 == nil then
                            break
                        end
                        if string.lower(UnusedVariable7.Name) == LowercaseString2 or string.lower(UnusedVariable7.DisplayName) == LowercaseString2 then
                            GameParameter3.State.targetedPlayers[UnusedVariable7.UserId] = UnusedVariable7
                            table.insert(GameParameter3.UI.targetSelected, UnusedVariable7.Name)
                            if GameParameter3.UI.targetPlayerDropdown then
                                GameParameter3.UI.targetPlayerDropdown:Set(GameParameter3.UI.targetSelected)
                            end
                            break
                        end
                    end
                end
            end
        })
        TabConfig["Target Player"]:AddButton({
            Title = "Clear All Targets",
            Content = "Remove all players from target list",
            Callback = function()
                GameParameter3.State.targetedPlayers = {}
                GameParameter3.UI.targetSelected = {}
                if GameParameter3.UI.targetPlayerDropdown then
                    GameParameter3.UI.targetPlayerDropdown:Set({})
                end
            end
        })
        local NilValue2 = nil
        TabConfig["Target Player"]:AddToggle({
            Title = "Auto Kill Targeted Players",
            Content = "Automatically kill all players in target list",
            Default = false,
            Callback = function(GameParameter4)
                if GameParameter4 then
                    local ZeroValue7 = 0
                    local ZeroValue8 = 0
                    local ZeroValue9 = 0
                    local ZeroValue10 = 0
                    NilValue2 = GameParameter3.RunService.RenderStepped:Connect(function(FunctionParameter11)
                        if GameParameter4 then
                            ZeroValue7 = ZeroValue7 + FunctionParameter11
                            ZeroValue8 = ZeroValue8 + FunctionParameter11
                            ZeroValue9 = ZeroValue9 + FunctionParameter11
                            ZeroValue10 = ZeroValue10 + FunctionParameter11
                            if ZeroValue10 >= 2 then
                                ZeroValue10 = 0
                                GameParameter3:refreshTargetReferences()
                            end
                            if ZeroValue7 >= 0.5 then
                                ZeroValue7 = 0
                                GameParameter3:equipPunch()
                            end
                            if ZeroValue9 >= 5 then
                                ZeroValue9 = 0
                                pcall(function()
                                    local LocalCharacter5 = GameParameter3.LocalPlayer.Character
                                    if LocalCharacter5 then
                                        local PunchTool3 = LocalCharacter5:FindFirstChild("Punch")
                                        if PunchTool3 then
                                            PunchTool3.Parent = GameParameter3.LocalPlayer.Backpack
                                            task.wait()
                                            GameParameter3:equipPunch()
                                        else
                                            GameParameter3:equipPunch()
                                        end
                                    end
                                end)
                            end
                            if GameParameter3:isLocalPlayerReady() then
                                local LocalCharacter6 = GameParameter3.LocalPlayer.Character
                                if ZeroValue8 >= 0.1 then
                                    ZeroValue8 = 0
                                    pcall(function()
                                        GameParameter3.LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                                        GameParameter3.LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
                                    end)
                                end
                                local TargetedPlayerIterator4, TargetedPlayerIterator5, TargetedPlayerIterator6 = pairs(GameParameter3.State.targetedPlayers)
                                while true do
                                    local UnusedVariable8
                                    TargetedPlayerIterator6, UnusedVariable8 = TargetedPlayerIterator4(TargetedPlayerIterator5, TargetedPlayerIterator6)
                                    if TargetedPlayerIterator6 == nil then
                                        break
                                    end
                                    local TargetedPlayer = GameParameter3.Players:GetPlayerByUserId(TargetedPlayerIterator6)
                                    if TargetedPlayer and TargetedPlayer.Parent then
                                        GameParameter3.State.targetedPlayers[TargetedPlayerIterator6] = TargetedPlayer
                                        if GameParameter3:isValidTargetEnhanced(TargetedPlayer) then
                                            local HumanoidRootPart4 = TargetedPlayer.Character:FindFirstChild("HumanoidRootPart")
                                            if HumanoidRootPart4 then
                                                GameParameter3:performCombat(HumanoidRootPart4, LocalCharacter6)
                                            end
                                        end
                                    else
                                        GameParameter3.State.targetedPlayers[TargetedPlayerIterator6] = nil
                                    end
                                end
                            end
                        else
                            if NilValue2 then
                                NilValue2:Disconnect()
                                NilValue2 = nil
                            end
                            return
                        end
                    end)
                elseif NilValue2 then
                    NilValue2:Disconnect()
                    NilValue2 = nil
                end
            end
        })
    end,
    setupSpy = function(GameParameter5)
        GameParameter5.UI.spyDropdown = TabConfig.Spy:AddDropdown({
            Title = "Spy Player Selection",
            Content = "Pick a player to watch",
            Multi = false,
            Options = GameParameter5:getCurrentPlayers(),
            Default = {},
            Callback = function(FunctionParameter12)
                if FunctionParameter12 and FunctionParameter12[1] then
                    local TableValue = FunctionParameter12[1]
                    local PlayerIterator19, PlayerIterator20, PlayerIterator21 = pairs(GameParameter5.Players:GetPlayers())
                    while true do
                        local UnusedVariable9
                        PlayerIterator21, UnusedVariable9 = PlayerIterator19(PlayerIterator20, PlayerIterator21)
                        if PlayerIterator21 == nil then
                            break
                        end
                        if UnusedVariable9.Name == TableValue and UnusedVariable9 ~= GameParameter5.LocalPlayer then
                            GameParameter5.State.spyTarget = UnusedVariable9
                            break
                        end
                    end
                else
                    GameParameter5.State.spyTarget = nil
                end
            end
        })
        local NilValue3 = nil
        TabConfig.Spy:AddToggle({
            Title = "Enable Spy Mode",
            Content = "Spy on the selected player (spectate their view)",
            Default = false,
            Callback = function(FunctionParameter13)
                GameParameter5.State.spyEnabled = FunctionParameter13
                if FunctionParameter13 then
                    if GameParameter5.State.spyTarget and GameParameter5.State.spyTarget.Parent then
                        NilValue3 = GameParameter5.RunService.RenderStepped:Connect(function()
                            if GameParameter5.State.spyEnabled and (GameParameter5.State.spyTarget and GameParameter5.State.spyTarget.Parent) then
                                if GameParameter5.State.spyTarget.Character and GameParameter5.State.spyTarget.Character:FindFirstChild("Humanoid") then
                                    workspace.CurrentCamera.CameraSubject = GameParameter5.State.spyTarget.Character.Humanoid
                                end
                            elseif NilValue3 then
                                NilValue3:Disconnect()
                                NilValue3 = nil
                            end
                        end)
                    else
                        GameParameter5.State.spyEnabled = false
                    end
                else
                    if NilValue3 then
                        NilValue3:Disconnect()
                        NilValue3 = nil
                    end
                    pcall(function()
                        if GameParameter5.LocalPlayer.Character and GameParameter5.LocalPlayer.Character:FindFirstChild("Humanoid") then
                            workspace.CurrentCamera.CameraSubject = GameParameter5.LocalPlayer.Character.Humanoid
                        else
                            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                            workspace.CurrentCamera.CameraSubject = nil
                        end
                    end)
                end
            end
        })
    end,
    setupEventConnections = function(GameParameter6)
        GameParameter6.Players.PlayerAdded:Connect(function(FunctionParameter14)
            task.wait(0.1)
            GameParameter6:updatePlayerDropdowns()
            if _G.whitelistFriends and FunctionParameter14:IsFriendsWith(GameParameter6.LocalPlayer.UserId) then
                GameParameter6.State.whitelist[FunctionParameter14.UserId] = true
            end
            if GameParameter6:isPlayerInWhitelistClan(FunctionParameter14) then
                GameParameter6.State.whitelist[FunctionParameter14.UserId] = true
            end
        end)
        GameParameter6.Players.PlayerRemoving:Connect(function(FunctionParameter15)
            local WhitelistIterator, WhitelistIterator2, WhitelistIterator3 = pairs(GameParameter6.UI.whitelistSelected)
            while true do
                local BlacklistData
                WhitelistIterator3, BlacklistData = WhitelistIterator(WhitelistIterator2, WhitelistIterator3)
                if WhitelistIterator3 == nil then
                    break
                end
                if BlacklistData == FunctionParameter15.Name then
                    table.remove(GameParameter6.UI.whitelistSelected, WhitelistIterator3)
                    break
                end
            end
            local SelectedBlacklistItem, BlacklistItemName, BlacklistItemValue = pairs(GameParameter6.UI.blacklistSelected)
            while true do
                local TargetData
                BlacklistItemValue, TargetData = SelectedBlacklistItem(BlacklistItemName, BlacklistItemValue)
                if BlacklistItemValue == nil then
                    break
                end
                if TargetData == FunctionParameter15.Name then
                    table.remove(GameParameter6.UI.blacklistSelected, BlacklistItemValue)
                    break
                end
            end
            local SelectedTargetItem, TargetItemName, TargetItemValue = pairs(GameParameter6.UI.targetSelected)
            while true do
                local PlayerList
                TargetItemValue, PlayerList = SelectedTargetItem(TargetItemName, TargetItemValue)
                if TargetItemValue == nil then
                    break
                end
                if PlayerList == FunctionParameter15.Name then
                    table.remove(GameParameter6.UI.targetSelected, TargetItemValue)
                    break
                end
            end
            GameParameter6.State.targetedPlayers[FunctionParameter15.UserId] = nil
            if GameParameter6.State.spyTarget == FunctionParameter15 then
                GameParameter6.State.spyTarget = nil
            end
            GameParameter6:removeWhitelistIndicator(FunctionParameter15.UserId)
            task.wait(0.1)
            GameParameter6:updatePlayerDropdowns()
        end)
        local PlayerInfo, PlayerName, PlayerUserId = pairs(GameParameter6.Players:GetPlayers())
        while true do
            local HttpRequest
            PlayerUserId, HttpRequest = PlayerInfo(PlayerName, PlayerUserId)
            if PlayerUserId == nil then
                break
            end
            if HttpRequest ~= GameParameter6.LocalPlayer then
                HttpRequest.CharacterAdded:Connect(function()
                    GameParameter6:onPlayerCharacterAdded(HttpRequest)
                end)
            end
        end
        GameParameter6.Players.PlayerAdded:Connect(function(FunctionParameter)
            FunctionParameter.CharacterAdded:Connect(function()
                GameParameter6:onPlayerCharacterAdded(FunctionParameter)
            end)
        end)
        GameParameter6.LocalPlayer.CharacterAdded:Connect(function(ParameterValue)
            task.wait(1)
            if GameParameter6.State.visualsEnabled then
                GameParameter6:createVisualEffects()
            end
            if GameParameter6.State.spyEnabled and (GameParameter6.State.spyTarget and GameParameter6.State.spyTarget.Character) then
                task.wait(0.1)
                if GameParameter6.State.spyTarget.Character:FindFirstChild("Humanoid") then
                    workspace.CurrentCamera.CameraSubject = GameParameter6.State.spyTarget.Character.Humanoid
                end
            else
                task.wait(0.1)
                if ParameterValue and ParameterValue:FindFirstChild("Humanoid") then
                    workspace.CurrentCamera.CameraSubject = ParameterValue.Humanoid
                end
            end
        end)
        GameParameter6.LocalPlayer.CharacterRemoving:Connect(function()
            if GameParameter6.State.connections.visualUpdate then
                GameParameter6.State.connections.visualUpdate:Disconnect()
                GameParameter6.State.connections.visualUpdate = nil
                task.wait(2)
                if GameParameter6.State.visualsEnabled then
                    GameParameter6.State.connections.visualUpdate = GameParameter6.RunService.Heartbeat:Connect(function()
                        local TickCount = tick()
                        if TickCount - GameParameter6.State.lastUpdate >= GameParameter6.Config.updateInterval then
                            GameParameter6.State.lastUpdate = TickCount
                            GameParameter6:updateVisualEffects()
                        end
                    end)
                end
            end
        end)
        GameParameter6.Players.PlayerRemoving:Connect(function(ParameterName)
            if ParameterName == GameParameter6.LocalPlayer then
                GameParameter6:cleanup()
            end
        end)
    end,
    init = function(ParameterValue)
        ParameterValue:setupWhitelist()
        ParameterValue:setupBlacklist()
        ParameterValue:setupKiller()
        ParameterValue:setupKillAura()
        ParameterValue:setupTargetPlayer()
        ParameterValue:setupSpy()
        ParameterValue:setupEventConnections()
    end
}):init()
local ConfigData = {
    config = {
        AUTO_UPDATE = true,
        UPDATE_INTERVAL = 1,
        STATS_LIST = {
            "Strength",
            "Durability",
            "Agility",
            "Rebirths",
            "Kills",
            "Brawls",
            "Gems"
        }
    },
    session = {
        startTime = os.time(),
        totalGains = {},
        lastValues = {},
        isActive = false,
        dailyStats = {}
    },
    webhook = {
        url = "",
        enabled = false,
        sendInterval = 300,
        autoSend = false,
        lastSentTime = 0,
        avatarUrl = "https://cdn.discordapp.com/icons/1399569377598115910/a_0b452015e4116309664919e0ce488262.gif?size=2048",
        design = "Professional",
        mentionRole = "",
        mentionUser = "",
        useTimestamp = true,
        scheduledSend = false,
        scheduledTimes = {},
        comparisonMode = false,
        discordLink = ""
    },
    services = {
        HttpService = nil,
        httpRequest = nil
    },
    ui = {
        currentStats = nil,
        sessionStats = nil,
        webhookStatus = nil,
        designDropdown = nil,
        mentionInput = nil,
        configStatus = nil
    },
    detectHttpService = function(FunctionArgument)
        local HttpService, HttpResult = pcall(function()
            return game:GetService("HttpService")
        end)
        if HttpService and HttpResult then
            FunctionArgument.services.HttpService = HttpResult
        end
        if syn and syn.request then
            FunctionArgument.services.httpRequest = syn.request
        elseif http and http.request then
            FunctionArgument.services.httpRequest = http.request
        elseif http_request then
            FunctionArgument.services.httpRequest = http_request
        elseif request then
            FunctionArgument.services.httpRequest = request
        end
    end,
    formatCompactNumber = function(UnusedParameter, ArgumentValue)
        if not ArgumentValue or ArgumentValue == 0 then
            return "0"
        end
        local StatItem, StatName, StatValue = ipairs({
            {
                1e18,
                "QI"
            },
            {
                1000000000000000,
                "Q"
            },
            {
                1000000000000,
                "T"
            },
            {
                1000000000,
                "B"
            },
            {
                1000000,
                "M"
            },
            {
                1000,
                "K"
            }
        })
        while true do
            local TemporaryData
            StatValue, TemporaryData = StatItem(StatName, StatValue)
            if StatValue == nil then
                break
            end
            if TemporaryData[1] <= ArgumentValue then
                return string.format("%.2f%s", ArgumentValue / TemporaryData[1], TemporaryData[2])
            end
        end
        return tostring(math.floor(ArgumentValue))
    end,
    formatDetailedNumber = function(UnusedParameter, ParameterValue)
        if not ParameterValue then
            return "0"
        end
        local StringValue = tostring(math.floor(ParameterValue))
        local EmptyString = ""
        for LoopCounter = 1, # StringValue do
            if (LoopCounter - 1) % 3 == 0 and 1 < LoopCounter then
                EmptyString = "," .. EmptyString
            end
            EmptyString = StringValue:sub(# StringValue - LoopCounter + 1, # StringValue - LoopCounter + 1) .. EmptyString
        end
        return EmptyString
    end,
    formatTime = function(UnusedParameter, TimeValue)
        local HoursValue = math.floor(TimeValue / 3600)
        local MinutesValue = math.floor(TimeValue % 3600 / 60)
        local SecondsValue = TimeValue % 60
        if HoursValue > 0 then
            return string.format("%02d:%02d:%02d", HoursValue, MinutesValue, SecondsValue)
        else
            return string.format("%02d:%02d", MinutesValue, SecondsValue)
        end
    end,
    formatDetailedTime = function(FunctionParameter, TimeParameter)
        if TimeParameter and TimeParameter > 0 then
            local YearsValue = math.floor(TimeParameter / 31536000)
            local RemainingTime = TimeParameter % 31536000
            local MonthsValue = math.floor(RemainingTime / 2629746)
            local RemainingMonths = RemainingTime % 2629746
            local WeeksValue = math.floor(RemainingMonths / 604800)
            local RemainingWeeks = RemainingMonths % 604800
            local DaysValue = math.floor(RemainingWeeks / 86400)
            local RemainingDays = RemainingWeeks % 86400
            local HoursRemaining = math.floor(RemainingDays / 3600)
            local MinutesRemaining = RemainingDays % 3600
            local SecondsRemaining = math.floor(MinutesRemaining / 60)
            local MillisecondsRemaining = MinutesRemaining % 60
            local EmptyTable = {}
            if YearsValue > 0 then
                table.insert(EmptyTable, string.format("%d Year%s", YearsValue, YearsValue == 1 and "" or "s"))
            end
            if MonthsValue > 0 then
                table.insert(EmptyTable, string.format("%d Month%s", MonthsValue, MonthsValue == 1 and "" or "s"))
            end
            if WeeksValue > 0 then
                table.insert(EmptyTable, string.format("%d Week%s", WeeksValue, WeeksValue == 1 and "" or "s"))
            end
            if DaysValue > 0 then
                table.insert(EmptyTable, string.format("%d Day%s", DaysValue, DaysValue == 1 and "" or "s"))
            end
            if HoursRemaining > 0 then
                table.insert(EmptyTable, string.format("%d Hour%s", HoursRemaining, HoursRemaining == 1 and "" or "s"))
            end
            if SecondsRemaining > 0 then
                table.insert(EmptyTable, string.format("%d Minute%s", SecondsRemaining, SecondsRemaining == 1 and "" or "s"))
            end
            if MillisecondsRemaining > 0 then
                table.insert(EmptyTable, string.format("%s Second%s", FunctionParameter:formatDetailedNumber(MillisecondsRemaining), MillisecondsRemaining == 1 and "" or "s"))
            end
            if # EmptyTable ~= 0 then
                if # EmptyTable ~= 1 then
                    return table.concat(EmptyTable, ", ")
                else
                    return EmptyTable[1]
                end
            else
                return "0 Seconds"
            end
        else
            return "0 Seconds"
        end
    end,
    getPlayerStat = function(UnusedParameter, PlayerObject, LeaderstatsName)
        if not PlayerObject then
            return 0
        end
        local Leaderstats = PlayerObject:FindFirstChild("leaderstats")
        if Leaderstats and Leaderstats:FindFirstChild(LeaderstatsName) then
            return Leaderstats[LeaderstatsName].Value or 0
        end
        local LeaderstatsValue = PlayerObject:FindFirstChild(LeaderstatsName)
        return not (LeaderstatsValue and LeaderstatsValue.Value) and 0 or LeaderstatsValue.Value
    end,
    getCurrentStats = function(ConfigObject)
        local LocalPlayer = game.Players.LocalPlayer
        if not LocalPlayer then
            return {}
        end
        local StatListItem, StatListName, StatListValue = ipairs(ConfigObject.config.STATS_LIST)
        local TemporaryTable = {}
        while true do
            local UnusedVariable
            StatListValue, UnusedVariable = StatListItem(StatListName, StatListValue)
            if StatListValue == nil then
                break
            end
            TemporaryTable[UnusedVariable] = ConfigObject:getPlayerStat(LocalPlayer, UnusedVariable)
        end
        return TemporaryTable
    end,
    saveDailyStats = function(SessionObject)
        local CurrentDate = os.date("%Y-%m-%d")
        local CurrentStats = SessionObject:getCurrentStats()
        if SessionObject.session.dailyStats[CurrentDate] then
            SessionObject.session.dailyStats[CurrentDate].end_ = CurrentStats
            local StatListIterator, StatNameIterator, StatValueIterator = ipairs(SessionObject.config.STATS_LIST)
            while true do
                local StatKey
                StatValueIterator, StatKey = StatListIterator(StatNameIterator, StatValueIterator)
                if StatValueIterator == nil then
                    break
                end
                local DailyStatValue = SessionObject.session.dailyStats[CurrentDate].start[StatKey] or 0
                local CurrentStatValue = CurrentStats[StatKey] or 0
                SessionObject.session.dailyStats[CurrentDate].gains[StatKey] = CurrentStatValue - DailyStatValue
            end
        else
            SessionObject.session.dailyStats[CurrentDate] = {
                start = CurrentStats,
                end_ = CurrentStats,
                gains = {}
            }
            local StatListIterator, StatNameIterator, StatValueIterator = ipairs(SessionObject.config.STATS_LIST)
            while true do
                local UnusedVariable
                StatValueIterator, UnusedVariable = StatListIterator(StatNameIterator, StatValueIterator)
                if StatValueIterator == nil then
                    break
                end
                SessionObject.session.dailyStats[CurrentDate].gains[UnusedVariable] = 0
            end
        end
    end,
    getYesterdayComparison = function(SessionParameter)
        local CurrentDate = os.date("%Y-%m-%d")
        local PreviousDate = os.date("%Y-%m-%d", os.time() - 86400)
        local DailyStats = SessionParameter.session.dailyStats[CurrentDate]
        local PreviousDailyStats = SessionParameter.session.dailyStats[PreviousDate]
        if not (DailyStats and PreviousDailyStats) then
            return nil
        end
        local StatListIterator, StatNameIterator, StatValueIterator = ipairs(SessionParameter.config.STATS_LIST)
        local TemporaryTable = {}
        while true do
            local StatKey
            StatValueIterator, StatKey = StatListIterator(StatNameIterator, StatValueIterator)
            if StatValueIterator == nil then
                break
            end
            local CurrentGain = DailyStats.gains[StatKey] or 0
            local PreviousGain = PreviousDailyStats.gains[StatKey] or 0
            local GainDifference = CurrentGain - PreviousGain
            TemporaryTable[StatKey] = {
                today = CurrentGain,
                yesterday = PreviousGain,
                difference = GainDifference,
                percentChange = PreviousGain > 0 and (GainDifference / PreviousGain * 100 or 0) or 0
            }
        end
        return TemporaryTable
    end,
    createProfessionalEmbed = function(SessionParameter)
        local LocalPlayer = game.Players.LocalPlayer
        if not LocalPlayer then
            return nil
        end
        local CurrentStats = SessionParameter:getCurrentStats()
        local SessionTime = SessionParameter.session.isActive and (os.time() - SessionParameter.session.startTime or 0) or 0
        local StatListIterator, StatNameIterator, StatValueIterator = ipairs(SessionParameter.config.STATS_LIST)
        local GainString = ""
        local UnusedString = ""
        while true do
            local StatKey
            StatValueIterator, StatKey = StatListIterator(StatNameIterator, StatValueIterator)
            if StatValueIterator == nil then
                break
            end
            local CurrentStatValue = CurrentStats[StatKey] or 0
            local TotalGain = SessionParameter.session.totalGains[StatKey] or 0
            UnusedString = UnusedString .. string.format("**%s:** `%s` (%s)\n", StatKey, SessionParameter:formatDetailedNumber(CurrentStatValue), SessionParameter:formatCompactNumber(CurrentStatValue))
            if TotalGain > 0 then
                GainString = GainString .. string.format("**%s:** `+%s` (+%s)\n", StatKey, SessionParameter:formatDetailedNumber(TotalGain), SessionParameter:formatCompactNumber(TotalGain))
            end
        end
        local GainMessage = GainString == "" and "No gains this session" or GainString
        local HelloMessage = ""
        if SessionParameter.webhook.mentionRole == "" then
            if SessionParameter.webhook.mentionUser ~= "" then
                HelloMessage = "<@" .. SessionParameter.webhook.mentionUser .. "> "
            end
        else
            HelloMessage = "<@&" .. SessionParameter.webhook.mentionRole .. "> "
        end
        local DescriptionText = {
            title = "Muscle Legends | Stats",
            description = HelloMessage .. "Hello",
            color = 3092790
        }
        local EmptyTable = {}
        local SessionInfo = {
            name = "\226\132\185Session Information",
            value = string.format("**Duration:** %s\n**Player:** %s\n**Server:** %s", SessionParameter:formatTime(SessionTime), LocalPlayer.Name, game.JobId:sub(1, 8)),
            inline = false
        }
        __set_list(EmptyTable, 1, {
            {
                name = "Current Statistics",
                value = UnusedString,
                inline = true
            },
            {
                name = "Session Progress",
                value = GainMessage,
                inline = true
            },
            SessionInfo
        })
        DescriptionText.fields = EmptyTable
        DescriptionText.footer = {
            text = "Lunar Hub",
            icon_url = SessionParameter.webhook.avatarUrl
        }
        if SessionParameter.webhook.useTimestamp then
            DescriptionText.timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
        end
        if HelloMessage == "" or not HelloMessage then
            HelloMessage = nil
        end
        if SessionParameter.webhook.discordLink ~= "" then
            HelloMessage = (HelloMessage or "") .. "\n\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189 Discord: " .. SessionParameter.webhook.discordLink
        end
        return {
            username = "Lunar Hub",
            avatar_url = SessionParameter.webhook.avatarUrl,
            content = HelloMessage,
            embeds = {
                DescriptionText
            }
        }
    end,
    createMinimalEmbed = function(PlayerStats)
        local LocalPlayer = game.Players.LocalPlayer
        if not LocalPlayer then
            return nil
        end
        local CurrentStats = PlayerStats:getCurrentStats()
        local SessionDuration = PlayerStats.session.isActive and (os.time() - PlayerStats.session.startTime or 0) or 0
        local StatIndex, StatValue, StatName = ipairs(PlayerStats.config.STATS_LIST)
        local EmptyString = ""
        while true do
            local StatKey
            StatName, StatKey = StatIndex(StatValue, StatName)
            if StatName == nil then
                break
            end
            local CurrentValue = CurrentStats[StatKey] or 0
            local TotalGains = PlayerStats.session.totalGains[StatKey] or 0
            if TotalGains > 0 then
                EmptyString = EmptyString .. string.format("%s: %s (+%s)\n", StatKey, PlayerStats:formatCompactNumber(CurrentValue), PlayerStats:formatCompactNumber(TotalGains))
            else
                EmptyString = EmptyString .. string.format("%s: %s\n", StatKey, PlayerStats:formatCompactNumber(CurrentValue))
            end
        end
        local UpdateMessage = ""
        if PlayerStats.webhook.mentionRole == "" then
            if PlayerStats.webhook.mentionUser ~= "" then
                UpdateMessage = "<@" .. PlayerStats.webhook.mentionUser .. "> "
            end
        else
            UpdateMessage = "<@&" .. PlayerStats.webhook.mentionRole .. "> "
        end
        local v1215 = {
            title = "Stats Update",
            description = UpdateMessage .. "```" .. EmptyString .. "```",
            color = 65416,
            footer = {
                text = string.format("%s \226\128\162 %s", LocalPlayer.Name, PlayerStats:formatTime(SessionDuration))
            }
        }
        if PlayerStats.webhook.useTimestamp then
            v1215.timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
        end
        if UpdateMessage == "" or not UpdateMessage then
            UpdateMessage = nil
        end
        if PlayerStats.webhook.discordLink ~= "" then
            UpdateMessage = (UpdateMessage or "") .. "\n " .. PlayerStats.webhook.discordLink
        end
        return {
            username = "Stats Bot",
            avatar_url = PlayerStats.webhook.avatarUrl,
            content = UpdateMessage,
            embeds = {
                v1215
            }
        }
    end,
    createDetailedEmbed = function(PlayerData)
        local PlayerObject = game.Players.LocalPlayer
        if not PlayerObject then
            return nil
        end
        local PlayerStatsData = PlayerData:getCurrentStats()
        local SessionActiveTime = PlayerData.session.isActive and (os.time() - PlayerData.session.startTime or 0) or 0
        local StatListIndex, StatListValue, StatListName = ipairs(PlayerData.config.STATS_LIST)
        local EmptyTable2 = {}
        while true do
            local StatKey2
            StatListName, StatKey2 = StatListIndex(StatListValue, StatListName)
            if StatListName == nil then
                break
            end
            local CurrentValue2 = PlayerStatsData[StatKey2] or 0
            local TotalGains2 = PlayerData.session.totalGains[StatKey2] or 0
            local GainRate = SessionActiveTime > 0 and (TotalGains2 / SessionActiveTime * 3600 or 0) or 0
            local FormattedStats = string.format("**Current:** %s (%s)\n**Gained:** +%s (+%s)\n**Rate:** %s/hour", PlayerData:formatDetailedNumber(CurrentValue2), PlayerData:formatCompactNumber(CurrentValue2), PlayerData:formatDetailedNumber(TotalGains2), PlayerData:formatCompactNumber(TotalGains2), PlayerData:formatCompactNumber(GainRate))
            table.insert(EmptyTable2, {
                name = "\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189 " .. StatKey2,
                value = FormattedStats,
                inline = true
            })
        end
        local HelloMessage2 = ""
        if PlayerData.webhook.mentionRole == "" then
            if PlayerData.webhook.mentionUser ~= "" then
                HelloMessage2 = "<@" .. PlayerData.webhook.mentionUser .. "> "
            end
        else
            HelloMessage2 = "<@&" .. PlayerData.webhook.mentionRole .. "> "
        end
        local TableInsertValue = table.insert
        local PerformanceData = {
            name = "Performance",
            value = string.format("**Session Duration:** %s\n**Player:** %s\n**%:** %.2f%%\n**Server ID:** %s", PlayerData:formatDetailedTime(SessionActiveTime), PlayerObject.Name, math.random(85, 98), game.JobId:sub(1, 12)),
            inline = false
        }
        TableInsertValue(EmptyTable2, PerformanceData)
        local DetailedPerformance = {
            title = "Detailed Performance",
            description = HelloMessage2 .. "Hello",
            color = 7506394,
            fields = EmptyTable2,
            thumbnail = {
                url = PlayerData.webhook.avatarUrl
            },
            footer = {
                text = "Lunar Hub",
                icon_url = PlayerData.webhook.avatarUrl
            }
        }
        if PlayerData.webhook.useTimestamp then
            DetailedPerformance.timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
        end
        if HelloMessage2 == "" or not HelloMessage2 then
            HelloMessage2 = nil
        end
        if PlayerData.webhook.discordLink ~= "" then
            HelloMessage2 = (HelloMessage2 or "") .. "\nJoin Discord: " .. PlayerData.webhook.discordLink
        end
        return {
            username = "Lunar Hub Advanced",
            avatar_url = PlayerData.webhook.avatarUrl,
            content = HelloMessage2,
            embeds = {
                DetailedPerformance
            }
        }
    end,
    createComparisonEmbed = function(PlayerComparison)
        local LocalPlayer2 = game.Players.LocalPlayer
        if not LocalPlayer2 then
            return nil
        end
        PlayerComparison:saveDailyStats()
        local YesterdayComparison = PlayerComparison:getYesterdayComparison()
        if not YesterdayComparison then
            return PlayerComparison:createProfessionalEmbed()
        end
        local StatListIndex2, StatListValue2, StatListName2 = ipairs(PlayerComparison.config.STATS_LIST)
        local ComparisonValue = 0
        local EmptyString2 = ""
        while true do
            local StatKey3
            StatListName2, StatKey3 = StatListIndex2(StatListValue2, StatListName2)
            if StatListName2 == nil then
                break
            end
            local ComparisonData = YesterdayComparison[StatKey3]
            local ComparisonMessage = ComparisonData.difference > 0 and "\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189" or (ComparisonData.difference < 0 and "\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189" or "\226\158\150")
            local ComparisonSign = ComparisonData.difference >= 0 and "+" or ""
            EmptyString2 = EmptyString2 .. string.format("%s **%s**\n\226\148\148 Today: +%s | Yesterday: +%s\n\226\148\148 Change: %s%s (%.1f%%)\n\n", ComparisonMessage, StatKey3, PlayerComparison:formatCompactNumber(ComparisonData.today), PlayerComparison:formatCompactNumber(ComparisonData.yesterday), ComparisonSign, PlayerComparison:formatCompactNumber(ComparisonData.difference), ComparisonData.percentChange)
            if ComparisonData.difference > 0 then
                ComparisonValue = ComparisonValue + 1
            end
        end
        local EmptyString3 = ""
        if PlayerComparison.webhook.mentionRole == "" then
            if PlayerComparison.webhook.mentionUser ~= "" then
                EmptyString3 = "<@" .. PlayerComparison.webhook.mentionUser .. "> "
            end
        else
            EmptyString3 = "<@&" .. PlayerComparison.webhook.mentionRole .. "> "
        end
        local ComparisonTitle = {
            title = (ComparisonValue >= 5 and "\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189" or (3 <= ComparisonValue and "\226\154\161" or "\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189")) .. " Daily Progress Comparison",
            description = EmptyString3 .. "**Comparing today\'s performance with yesterday**",
            color = ComparisonValue >= 5 and 65280 or (3 <= ComparisonValue and 16776960 or 16729156),
            fields = {
                {
                    name = "Stat Breakdown",
                    value = EmptyString2,
                    inline = false
                },
                {
                    name = "Performance",
                    value = string.format("**Improvements:** %d/%d stats\n**Player:** %s\n**Analysis Date:** %s", ComparisonValue, # PlayerComparison.config.STATS_LIST, LocalPlayer2.Name, os.date("%Y-%m-%d")),
                    inline = false
                }
            },
            footer = {
                text = "Lunar Hub",
                icon_url = PlayerComparison.webhook.avatarUrl
            }
        }
        if PlayerComparison.webhook.useTimestamp then
            ComparisonTitle.timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
        end
        if EmptyString3 == "" or not EmptyString3 then
            EmptyString3 = nil
        end
        if PlayerComparison.webhook.discordLink ~= "" then
            EmptyString3 = (EmptyString3 or "") .. "\nJoin our community: " .. PlayerComparison.webhook.discordLink
        end
        return {
            username = "Lunar Hub",
            avatar_url = PlayerComparison.webhook.avatarUrl,
            content = EmptyString3,
            embeds = {
                ComparisonTitle
            }
        }
    end,
    createWebhookEmbed = function(FunctionParam1)
        if FunctionParam1.webhook.comparisonMode then
            return FunctionParam1:createComparisonEmbed()
        elseif FunctionParam1.webhook.design ~= "Professional" then
            if FunctionParam1.webhook.design ~= "Minimal" then
                if FunctionParam1.webhook.design ~= "Detailed" then
                    return FunctionParam1:createProfessionalEmbed()
                else
                    return FunctionParam1:createDetailedEmbed()
                end
            else
                return FunctionParam1:createMinimalEmbed()
            end
        else
            return FunctionParam1:createProfessionalEmbed()
        end
    end,
    encodeJSON = function(FunctionParam2, FunctionParam3)
        if FunctionParam2.services.HttpService then
            return FunctionParam2.services.HttpService:JSONEncode(FunctionParam3)
        else
            return FunctionParam2:simpleJSONEncode(FunctionParam3)
        end
    end,
    simpleJSONEncode = function(FunctionParam4, FunctionParam5)
        if type(FunctionParam5) ~= "table" then
            if type(FunctionParam5) ~= "string" then
                return type(FunctionParam5) ~= "number" and (type(FunctionParam5) ~= "boolean" and "null" or (FunctionParam5 and "true" or "false")) or tostring(FunctionParam5)
            else
                return "\"" .. FunctionParam5:gsub("\"", "\\\""):gsub("\n", "\\n") .. "\""
            end
        elseif FunctionParam5[1] then
            local ListIndex, ListValue, ListName = ipairs(FunctionParam5)
            local EmptyTable3 = {}
            while true do
                local UnknownValue
                ListName, UnknownValue = ListIndex(ListValue, ListName)
                if ListName == nil then
                    break
                end
                table.insert(EmptyTable3, FunctionParam4:simpleJSONEncode(UnknownValue))
            end
            return "[" .. table.concat(EmptyTable3, ",") .. "]"
        else
            local PairKey, PairValue, PairName = pairs(FunctionParam5)
            local EmptyTable4 = {}
            while true do
                local JsonValue
                PairName, JsonValue = PairKey(PairValue, PairName)
                if PairName == nil then
                    break
                end
                local JsonString = "\"" .. tostring(PairName) .. "\""
                local EncodedJson = FunctionParam4:simpleJSONEncode(JsonValue)
                table.insert(EmptyTable4, JsonString .. ":" .. EncodedJson)
            end
            return "{" .. table.concat(EmptyTable4, ",") .. "}"
        end
    end,
    simpleJSONDecode = function(UnusedParameter, FunctionParam6)
        local function LocalFunction(FunctionParam7, FunctionParam8)
            local SubString = FunctionParam7:sub(FunctionParam8, FunctionParam8)
            if SubString == "\"" then
                local FindIndex = FunctionParam7:find("\"", FunctionParam8 + 1)
                while FindIndex and FunctionParam7:sub(FindIndex - 1, FindIndex - 1) == "\\" do
                    FindIndex = FunctionParam7:find("\"", FindIndex + 1)
                end
                if FindIndex then
                    return FunctionParam7:sub(FunctionParam8 + 1, FindIndex - 1), FindIndex + 1
                end
            elseif SubString == "{" then
                FunctionParam8 = FunctionParam8 + 1
                local EmptyTable5 = {}
                while FunctionParam8 <= # FunctionParam7 do
                    while FunctionParam8 <= # FunctionParam7 and FunctionParam7:sub(FunctionParam8, FunctionParam8):match("%s") do
                        FunctionParam8 = FunctionParam8 + 1
                    end
                    if FunctionParam7:sub(FunctionParam8, FunctionParam8) == "}" then
                        return EmptyTable5, FunctionParam8 + 1
                    end
                    local FunctionResult, FunctionResult2 = LocalFunction(FunctionParam7, FunctionParam8)
                    while FunctionResult2 <= # FunctionParam7 and (FunctionParam7:sub(FunctionResult2, FunctionResult2):match("%s") or FunctionParam7:sub(FunctionResult2, FunctionResult2) == ":") do
                        FunctionResult2 = FunctionResult2 + 1
                    end
                    local UnknownValue2
                    UnknownValue2, FunctionParam8 = LocalFunction(FunctionParam7, FunctionResult2)
                    EmptyTable5[FunctionResult] = UnknownValue2
                    while FunctionParam8 <= # FunctionParam7 and (FunctionParam7:sub(FunctionParam8, FunctionParam8):match("%s") or FunctionParam7:sub(FunctionParam8, FunctionParam8) == ",") do
                        FunctionParam8 = FunctionParam8 + 1
                    end
                end
            elseif SubString == "[" then
                FunctionParam8 = FunctionParam8 + 1
                local EmptyTable6 = {}
                local DefaultValue = 1
                while FunctionParam8 <= # FunctionParam7 do
                    while FunctionParam8 <= # FunctionParam7 and FunctionParam7:sub(FunctionParam8, FunctionParam8):match("%s") do
                        FunctionParam8 = FunctionParam8 + 1
                    end
                    if FunctionParam7:sub(FunctionParam8, FunctionParam8) == "]" then
                        return EmptyTable6, FunctionParam8 + 1
                    end
                    local UnknownValue3
                    UnknownValue3, FunctionParam8 = LocalFunction(FunctionParam7, FunctionParam8)
                    EmptyTable6[DefaultValue] = UnknownValue3
                    DefaultValue = DefaultValue + 1
                    while FunctionParam8 <= # FunctionParam7 and (FunctionParam7:sub(FunctionParam8, FunctionParam8):match("%s") or FunctionParam7:sub(FunctionParam8, FunctionParam8) == ",") do
                        FunctionParam8 = FunctionParam8 + 1
                    end
                end
            else
                if SubString:match("%d") or SubString == "-" then
                    local EmptyString4 = ""
                    while FunctionParam8 <= # FunctionParam7 and FunctionParam7:sub(FunctionParam8, FunctionParam8):match("[%d%.-]") do
                        EmptyString4 = EmptyString4 .. FunctionParam7:sub(FunctionParam8, FunctionParam8)
                        FunctionParam8 = FunctionParam8 + 1
                    end
                    return tonumber(EmptyString4), FunctionParam8
                end
                if FunctionParam7:sub(FunctionParam8, FunctionParam8 + 3) == "true" then
                    return true, FunctionParam8 + 4
                end
                if FunctionParam7:sub(FunctionParam8, FunctionParam8 + 4) == "false" then
                    return false, FunctionParam8 + 5
                end
                if FunctionParam7:sub(FunctionParam8, FunctionParam8 + 3) == "null" then
                    return nil, FunctionParam8 + 4
                end
            end
            return nil, FunctionParam8 + 1
        end
        local FunctionResult3, UnusedParameter = LocalFunction(FunctionParam6, 1)
        return FunctionResult3
    end,
    sendWebhook = function(WebhookService)
        if not WebhookService.webhook.enabled or WebhookService.webhook.url == "" then
            return false, "Webhook not configured"
        end
        local WebhookEmbed = WebhookService:createWebhookEmbed()
        if not WebhookEmbed then
            return false, "Failed to create embed data"
        end
        local EncodedWebhook = WebhookService:encodeJSON(WebhookEmbed)
        local UnknownValue4, UnknownValue5
        if WebhookService.services.httpRequest then
            UnknownValue4, UnknownValue5 = pcall(function()
                local HttpRequest = WebhookService.services.httpRequest
                local RequestData = {
                    Url = WebhookService.webhook.url,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = EncodedWebhook
                }
                return HttpRequest(RequestData)
            end)
        else
            if not WebhookService.services.HttpService then
                return false, "No HTTP service available"
            end
            UnknownValue4, UnknownValue5 = pcall(function()
                return WebhookService.services.HttpService:PostAsync(WebhookService.webhook.url, EncodedWebhook, Enum.HttpContentType.ApplicationJson)
            end)
        end
        if not UnknownValue4 then
            return false, "Failed to send webhook: " .. tostring(UnknownValue5)
        end
        WebhookService.webhook.lastSentTime = os.time()
        return true, "Webhook sent successfully"
    end,
    checkScheduledSend = function(WebhookConfig)
        if not WebhookConfig.webhook.scheduledSend or # WebhookConfig.webhook.scheduledTimes == 0 then
            return false
        end
        local CurrentTime = os.date("%H:%M")
        local ScheduleIndex, ScheduleValue, ScheduleName = ipairs(WebhookConfig.webhook.scheduledTimes)
        while true do
            local ScheduleKey
            ScheduleName, ScheduleKey = ScheduleIndex(ScheduleValue, ScheduleName)
            if ScheduleName == nil then
                break
            end
            if CurrentTime == ScheduleKey then
                local ScheduledTime = "scheduled_" .. ScheduleKey
                if not WebhookConfig.webhook[ScheduledTime] or os.time() - WebhookConfig.webhook[ScheduledTime] >= 60 then
                    WebhookConfig.webhook[ScheduledTime] = os.time()
                    return true
                end
            end
        end
        return false
    end,
    saveConfig = function(WebhookSettings)
        local WebhookData = {
            webhook = {
                url = WebhookSettings.webhook.url,
                design = WebhookSettings.webhook.design,
                mentionRole = WebhookSettings.webhook.mentionRole,
                mentionUser = WebhookSettings.webhook.mentionUser,
                sendInterval = WebhookSettings.webhook.sendInterval,
                autoSend = WebhookSettings.webhook.autoSend,
                scheduledSend = WebhookSettings.webhook.scheduledSend,
                scheduledTimes = {},
                useTimestamp = WebhookSettings.webhook.useTimestamp,
                comparisonMode = WebhookSettings.webhook.comparisonMode,
                discordLink = WebhookSettings.webhook.discordLink,
                enabled = WebhookSettings.webhook.enabled
            },
            saved = true,
            saveTime = os.time()
        }
        local ScheduleIndex2, ScheduleValue2, ScheduleName2 = ipairs(WebhookSettings.webhook.scheduledTimes)
        while true do
            local UnknownValue6
            ScheduleName2, UnknownValue6 = ScheduleIndex2(ScheduleValue2, ScheduleName2)
            if ScheduleName2 == nil then
                break
            end
            WebhookData.webhook.scheduledTimes[ScheduleName2] = UnknownValue6
        end
        local ConfigData = WebhookSettings:encodeJSON(WebhookData)
        local WriteError, WriteSuccess = pcall(function()
            writefile("LunarHub_StatsTracker_Config.json", ConfigData)
        end)
        if not WriteError then
            return false, "Failed to save configuration: " .. tostring(WriteSuccess)
        end
        WebhookSettings:updateConfigStatus()
        return true, "Configuration saved successfully"
    end,
    loadConfig = function(PlayerParameter)
        local ReadResult, FileContent = pcall(function()
            return readfile("LunarHub_StatsTracker_Config.json")
        end)
        if not ReadResult then
            return false, "No saved configuration found"
        end
        local UnusedVariable, WebhookConfig
        if PlayerParameter.services.HttpService then
            UnusedVariable, WebhookConfig = pcall(function()
                return PlayerParameter.services.HttpService:JSONDecode(FileContent)
            end)
        else
            UnusedVariable, WebhookConfig = pcall(function()
                return PlayerParameter:simpleJSONDecode(FileContent)
            end)
        end
        if not (UnusedVariable and (WebhookConfig and WebhookConfig.webhook)) then
            return false, "Failed to parse configuration file"
        end
        PlayerParameter.webhook.url = WebhookConfig.webhook.url or ""
        PlayerParameter.webhook.design = WebhookConfig.webhook.design or "Professional"
        PlayerParameter.webhook.mentionRole = WebhookConfig.webhook.mentionRole or ""
        PlayerParameter.webhook.mentionUser = WebhookConfig.webhook.mentionUser or ""
        PlayerParameter.webhook.sendInterval = WebhookConfig.webhook.sendInterval or 300
        PlayerParameter.webhook.autoSend = WebhookConfig.webhook.autoSend or false
        PlayerParameter.webhook.scheduledSend = WebhookConfig.webhook.scheduledSend or false
        PlayerParameter.webhook.useTimestamp = WebhookConfig.webhook.useTimestamp ~= false
        PlayerParameter.webhook.comparisonMode = WebhookConfig.webhook.comparisonMode or false
        PlayerParameter.webhook.discordLink = WebhookConfig.webhook.discordLink or ""
        PlayerParameter.webhook.enabled = WebhookConfig.webhook.enabled or false
        PlayerParameter.webhook.scheduledTimes = {}
        if WebhookConfig.webhook.scheduledTimes then
            local ScheduledTimeIndex, ScheduledTimeValue, ScheduledTimeKey = ipairs(WebhookConfig.webhook.scheduledTimes)
            while true do
                local UnusedVariable
                ScheduledTimeKey, UnusedVariable = ScheduledTimeIndex(ScheduledTimeValue, ScheduledTimeKey)
                if ScheduledTimeKey == nil then
                    break
                end
                PlayerParameter.webhook.scheduledTimes[ScheduledTimeKey] = UnusedVariable
            end
        end
        if PlayerParameter.ui.designDropdown then
            PlayerParameter.ui.designDropdown:Set({
                PlayerParameter.webhook.design
            })
        end
        local PlayerParameterValue = PlayerParameter
        PlayerParameter.updateWebhookStatus(PlayerParameterValue)
        local PlayerParameterName = PlayerParameter
        PlayerParameter.updateConfigStatus(PlayerParameterName)
        return true, "Configuration loaded successfully"
    end,
    deleteConfig = function(FunctionParameter)
        local DeleteError, DeleteSuccess = pcall(function()
            delfile("LunarHub_StatsTracker_Config.json")
        end)
        FunctionParameter:updateConfigStatus()
        if DeleteError then
            return true, "Configuration deleted successfully"
        else
            return false, "Failed to delete configuration: " .. tostring(DeleteSuccess)
        end
    end,
    getConfigData = function(FunctionParameter)
        local ReadResult, FileContent = pcall(function()
            return readfile("LunarHub_StatsTracker_Config.json")
        end)
        if not ReadResult then
            return nil
        end
        local UnusedVariable, UnusedVariable
        if FunctionParameter.services.HttpService then
            UnusedVariable, UnusedVariable = pcall(function()
                return FunctionParameter.services.HttpService:JSONDecode(FileContent)
            end)
        else
            UnusedVariable, UnusedVariable = pcall(function()
                return FunctionParameter:simpleJSONDecode(FileContent)
            end)
        end
        return UnusedVariable and UnusedVariable and UnusedVariable or nil
    end,
    updateConfigStatus = function(ConfigParameter)
        if ConfigParameter.ui.configStatus then
            local ConfigData = ConfigParameter:getConfigData()
            local UnusedVariable
            if ConfigData and ConfigData.saved then
                local SaveTime = os.date("%Y-%m-%d %H:%M:%S", ConfigData.saveTime)
                UnusedVariable = ((((((((((string.format("Configuration Saved: %s\n\nSaved Settings:\n", SaveTime) .. string.format("\226\128\162 Webhook URL: %s\n", ConfigData.webhook.url ~= "" and "Set" or "Not Set")) .. string.format("\226\128\162 Design: %s\n", ConfigData.webhook.design)) .. string.format("\226\128\162 Mention Role ID: %s\n", ConfigData.webhook.mentionRole == "" and "None" or (ConfigData.webhook.mentionRole or "None"))) .. string.format("\226\128\162 Mention User ID: %s\n", ConfigData.webhook.mentionUser == "" and "None" or (ConfigData.webhook.mentionUser or "None"))) .. string.format("\226\128\162 Send Interval: %d seconds\n", ConfigData.webhook.sendInterval)) .. string.format("\226\128\162 Auto Send: %s\n", ConfigData.webhook.autoSend and "Enabled" or "Disabled")) .. string.format("\226\128\162 Scheduled Webhooks: %s\n", ConfigData.webhook.scheduledSend and "Enabled" or "Disabled")) .. string.format("\226\128\162 Scheduled Times: %s\n", ConfigData.webhook.scheduledTimes and # ConfigData.webhook.scheduledTimes > 0 and (table.concat(ConfigData.webhook.scheduledTimes, ", ") or "None") or "None")) .. string.format("\226\128\162 Timestamps: %s\n", ConfigData.webhook.useTimestamp and "Enabled" or "Disabled")) .. string.format("\226\128\162 Comparison Mode: %s\n", ConfigData.webhook.comparisonMode and "Enabled" or "Disabled")) .. string.format("\226\128\162 Status: %s", ConfigData.webhook.enabled and "Enabled" or "Disabled")
            else
                UnusedVariable = "No configuration saved\n\nUse \'Save Current Config\' to save your current webhook settings for quick loading later."
            end
            ConfigParameter.ui.configStatus:Set({
                Title = "Configuration Manager",
                Content = UnusedVariable
            })
        end
    end,
    initializeSession = function(ConfigParameter)
        if ConfigParameter.session.isActive then
            return
        else
            local LocalPlayer = game.Players.LocalPlayer
            if LocalPlayer then
                wait(1)
                local StatIndex, StatValue, StatKey = ipairs(ConfigParameter.config.STATS_LIST)
                while true do
                    local StatName
                    StatKey, StatName = StatIndex(StatValue, StatKey)
                    if StatKey == nil then
                        break
                    end
                    local PlayerStat = ConfigParameter:getPlayerStat(LocalPlayer, StatName)
                    ConfigParameter.session.totalGains[StatName] = 0
                    ConfigParameter.session.lastValues[StatName] = PlayerStat
                end
                ConfigParameter.session.startTime = os.time()
                ConfigParameter.session.isActive = true
            end
        end
    end,
    resetSession = function(ConfigParameter)
        local LocalPlayer = game.Players.LocalPlayer
        if LocalPlayer then
            local StatIndex, StatValue, StatKey = ipairs(ConfigParameter.config.STATS_LIST)
            while true do
                local StatName
                StatKey, StatName = StatIndex(StatValue, StatKey)
                if StatKey == nil then
                    break
                end
                local PlayerStat = ConfigParameter:getPlayerStat(LocalPlayer, StatName)
                ConfigParameter.session.totalGains[StatName] = 0
                ConfigParameter.session.lastValues[StatName] = PlayerStat
            end
            ConfigParameter.session.startTime = os.time()
        end
    end,
    updateDisplay = function(SessionParameter)
        local LocalPlayer = game.Players.LocalPlayer
        if LocalPlayer then
            if SessionParameter.session.isActive then
                local SessionTime = os.time() - SessionParameter.session.startTime
                local StatIndex, StatValue, StatKey = ipairs(SessionParameter.config.STATS_LIST)
                local UnusedVariable = ""
                local SessionInfo = ""
                while true do
                    local StatName
                    StatKey, StatName = StatIndex(StatValue, StatKey)
                    if StatKey == nil then
                        break
                    end
                    local PlayerStat = SessionParameter:getPlayerStat(LocalPlayer, StatName)
                    local LastValue = SessionParameter.session.lastValues[StatName] or 0
                    UnusedVariable = UnusedVariable .. string.format("%-12s [ %-15s ] [ %s ]\n", StatName, SessionParameter:formatDetailedNumber(PlayerStat), SessionParameter:formatCompactNumber(PlayerStat))
                    local GainValue = PlayerStat - LastValue
                    if GainValue > 0 then
                        SessionParameter.session.totalGains[StatName] = (SessionParameter.session.totalGains[StatName] or 0) + GainValue
                    end
                    SessionParameter.session.lastValues[StatName] = PlayerStat
                    local TotalGain = SessionParameter.session.totalGains[StatName] or 0
                    SessionInfo = SessionInfo .. string.format("%-12s [ +%-14s ] [ +%s ]\n", StatName, SessionParameter:formatDetailedNumber(TotalGain), SessionParameter:formatCompactNumber(TotalGain))
                end
                local SessionInfo = "Session Time: " .. SessionParameter:formatTime(SessionTime) .. "\n\n" .. SessionInfo
                if SessionParameter.ui.currentStats then
                    SessionParameter.ui.currentStats:Set({
                        Title = "Current Statistics - " .. SessionParameter:formatTime(SessionTime),
                        Content = UnusedVariable:sub(1, - 2)
                    })
                end
                if SessionParameter.ui.sessionStats then
                    SessionParameter.ui.sessionStats:Set({
                        Title = "Session Progress",
                        Content = SessionInfo:sub(1, - 2)
                    })
                end
            else
                SessionParameter:initializeSession()
            end
        else
            return
        end
    end,
    updateWebhookStatus = function(WebhookParameter)
        if WebhookParameter.ui.webhookStatus then
            local WebhookStatus = WebhookParameter.webhook.enabled and "Enabled" or "Disabled"
            local LastSentTime = WebhookParameter.webhook.lastSentTime <= 0 and "Never" or (os.date("%H:%M:%S", WebhookParameter.webhook.lastSentTime) or "Never")
            local SendInterval = WebhookParameter:formatDetailedTime(WebhookParameter.webhook.sendInterval)
            local ScheduledInfo = (not WebhookParameter.webhook.scheduledSend or # WebhookParameter.webhook.scheduledTimes <= 0) and "" or "\nScheduled: " .. table.concat(WebhookParameter.webhook.scheduledTimes, ", ")
            local UnusedVariable
            if WebhookParameter.webhook.autoSend and (WebhookParameter.webhook.enabled and WebhookParameter.webhook.lastSentTime > 0) then
                local TimeUntilSend = WebhookParameter.webhook.lastSentTime + WebhookParameter.webhook.sendInterval - os.time()
                UnusedVariable = TimeUntilSend <= 0 and "\nNext Send: Ready" or string.format("\nNext Send: %s", WebhookParameter:formatTime(TimeUntilSend))
            else
                UnusedVariable = ""
            end
            WebhookParameter.ui.webhookStatus:Set({
                Title = "Webhook Status",
                Content = string.format("Status: %s\nDesign: %s\nLast Sent: %s\nInterval: %s%s%s\nURL: %s\nMentions: %s", WebhookStatus, WebhookParameter.webhook.design, LastSentTime, SendInterval, UnusedVariable, ScheduledInfo, WebhookParameter.webhook.url ~= "" and "Configured" or "Not Set", WebhookParameter.webhook.mentionRole ~= "" and "Role" or (WebhookParameter.webhook.mentionUser ~= "" and "User" or "None"))
            })
            WebhookParameter:updateConfigStatus()
        end
    end,
    setWebhookURL = function(FunctionParameter, FunctionParameter)
        FunctionParameter.webhook.url = FunctionParameter
        if FunctionParameter and (FunctionParameter ~= "" and string.find(FunctionParameter, "discord.com/api/webhooks")) then
            FunctionParameter.webhook.enabled = true
        else
            FunctionParameter.webhook.enabled = false
        end
    end,
    setWebhookInterval = function(FunctionParameter, FunctionParameter)
        local ParameterValue = tonumber(FunctionParameter)
        if ParameterValue and 1 <= ParameterValue then
            FunctionParameter.webhook.sendInterval = ParameterValue
        end
    end,
    setAutoSend = function(FunctionParameter, FunctionParameter)
        FunctionParameter.webhook.autoSend = FunctionParameter
    end,
    setScheduledSend = function(FunctionParameter, FunctionParameter)
        FunctionParameter.webhook.scheduledSend = FunctionParameter
    end,
    addScheduledTime = function(FunctionParameter, FunctionParameter)
        if not table.find(FunctionParameter.webhook.scheduledTimes, FunctionParameter) then
            table.insert(FunctionParameter.webhook.scheduledTimes, FunctionParameter)
        end
    end,
    removeScheduledTime = function(WebhookParameter, FunctionParameter)
        local ScheduledTimeIndex, ScheduledTimeValue, ScheduledTimeKey = ipairs(WebhookParameter.webhook.scheduledTimes)
        while true do
            local UnusedVariable
            ScheduledTimeKey, UnusedVariable = ScheduledTimeIndex(ScheduledTimeValue, ScheduledTimeKey)
            if ScheduledTimeKey == nil then
                break
            end
            if UnusedVariable == FunctionParameter then
                table.remove(WebhookParameter.webhook.scheduledTimes, ScheduledTimeKey)
                break
            end
        end
    end,
    setupUI = function(FunctionParameter)
        if TabConfig then
            if TabConfig.Stats then
                FunctionParameter.ui.currentStats = TabConfig.Stats:AddParagraph({
                    Title = "Current Statistics",
                    Content = "Loading..."
                })
            end
            if TabConfig["Gained Stats"] then
                FunctionParameter.ui.sessionStats = TabConfig["Gained Stats"]:AddParagraph({
                    Title = "Session Progress",
                    Content = "Loading..."
                })
                TabConfig["Gained Stats"]:AddButton({
                    Title = "Reset Session",
                    Callback = function()
                        FunctionParameter:resetSession()
                    end
                })
            end
            if TabConfig.Webhook then
                TabConfig.Webhook:AddInput({
                    Title = "Discord Webhook URL",
                    Default = "",
                    Placeholder = "https://discord.com/api/webhooks/...",
                    Numeric = false,
                    Finished = false,
                    Callback = function(FunctionParameter)
                        FunctionParameter:setWebhookURL(FunctionParameter)
                    end
                })
                FunctionParameter.ui.designDropdown = TabConfig.Webhook:AddDropdown({
                    Title = "Webhook Design",
                    Content = "Choose your preferred embed style",
                    Multi = false,
                    Options = {
                        "Professional",
                        "Minimal",
                        "Detailed"
                    },
                    Default = {
                        "Professional"
                    },
                    Callback = function(FunctionParameter)
                        if FunctionParameter and FunctionParameter[1] then
                            FunctionParameter.webhook.design = FunctionParameter[1]
                        end
                    end
                })
                TabConfig.Webhook:AddInput({
                    Title = "Mention Role ID",
                    Default = "",
                    Placeholder = "Enter role ID for mentions",
                    Numeric = false,
                    Finished = false,
                    Callback = function(FunctionParameter)
                        FunctionParameter.webhook.mentionRole = FunctionParameter
                        if FunctionParameter ~= "" then
                            FunctionParameter.webhook.mentionUser = ""
                        end
                    end
                })
                TabConfig.Webhook:AddInput({
                    Title = "Mention User ID",
                    Default = "",
                    Placeholder = "Enter user ID for mentions",
                    Numeric = false,
                    Finished = false,
                    Callback = function(FunctionParameter)
                        FunctionParameter.webhook.mentionUser = FunctionParameter
                        if FunctionParameter ~= "" then
                            FunctionParameter.webhook.mentionRole = ""
                        end
                    end
                })
                TabConfig.Webhook:AddInput({
                    Title = "Send Interval (seconds)",
                    Default = "300",
                    Placeholder = "Enter seconds (e.g., 2, 9999, 999999999)",
                    Numeric = true,
                    Finished = true,
                    Callback = function(FunctionParameter)
                        FunctionParameter:setWebhookInterval(FunctionParameter)
                    end
                })
                FunctionParameter.ui.webhookStatus = TabConfig.Webhook:AddParagraph({
                    Title = "Webhook Status",
                    Content = "Status: Disabled\nLast Sent: Never"
                })
                TabConfig.Webhook:AddToggle({
                    Title = "Enable Timestamps",
                    Content = "Add timestamps to webhook embeds",
                    Default = true,
                    Callback = function(FunctionParameter)
                        FunctionParameter.webhook.useTimestamp = FunctionParameter
                    end
                })
                TabConfig.Webhook:AddToggle({
                    Title = "Comparison Mode",
                    Content = "Compare daily progress instead of session stats",
                    Default = false,
                    Callback = function(FunctionParameter)
                        FunctionParameter.webhook.comparisonMode = FunctionParameter
                    end
                })
                TabConfig.Webhook:AddButton({
                    Title = "Send Test Webhook",
                    Callback = function()
                        local UnusedParameter, UnusedParameter = FunctionParameter:sendWebhook()
                        FunctionParameter:updateWebhookStatus()
                    end
                })
                TabConfig.Webhook:AddToggle({
                    Title = "Auto Send Webhooks",
                    Default = false,
                    Callback = function(FunctionParameter)
                        FunctionParameter:setAutoSend(FunctionParameter)
                    end
                })
                TabConfig.Webhook:AddToggle({
                    Title = "Scheduled Webhooks",
                    Content = "Enable scheduled webhook sending",
                    Default = false,
                    Callback = function(FunctionParameter)
                        FunctionParameter:setScheduledSend(FunctionParameter)
                    end
                })
                TabConfig.Webhook:AddInput({
                    Title = "Add Scheduled Time",
                    Default = "",
                    Placeholder = "HH:MM (24h format, e.g., 14:30)",
                    Numeric = false,
                    Finished = true,
                    Callback = function(FunctionParameter)
                        if FunctionParameter and FunctionParameter:match("^%d%d:%d%d$") then
                            FunctionParameter:addScheduledTime(FunctionParameter)
                            FunctionParameter:updateWebhookStatus()
                        end
                    end
                })
                TabConfig.Webhook:AddButton({
                    Title = "Clear Scheduled Times",
                    Callback = function()
                        FunctionParameter.webhook.scheduledTimes = {}
                        FunctionParameter:updateWebhookStatus()
                    end
                })
                TabConfig.Webhook:AddButton({
                    Title = "Save Current Config",
                    Callback = function()
                        local UnusedParameter, UnusedParameter = FunctionParameter:saveConfig()
                    end
                })
                TabConfig.Webhook:AddButton({
                    Title = "Use Latest Config",
                    Callback = function()
                        local UnusedParameter, UnusedParameter = FunctionParameter:loadConfig()
                    end
                })
                TabConfig.Webhook:AddButton({
                    Title = "Delete Saved Config",
                    Callback = function()
                        local UnusedParameter, UnusedParameter = FunctionParameter:deleteConfig()
                    end
                })
                FunctionParameter.ui.configStatus = TabConfig.Webhook:AddParagraph({
                    Title = "Configuration Manager",
                    Content = "No configuration saved"
                })
            end
        end
    end,
    start = function(FunctionParameter)
        FunctionParameter:detectHttpService()
        FunctionParameter:setupUI()
        if FunctionParameter.config.AUTO_UPDATE then
            spawn(function()
                wait(2)
                while true do
                    pcall(function()
                        FunctionParameter:updateDisplay()
                    end)
                    wait(FunctionParameter.config.UPDATE_INTERVAL)
                end
            end)
        end
        spawn(function()
            while true do
                pcall(function()
                    FunctionParameter:updateWebhookStatus()
                end)
                if FunctionParameter.webhook.enabled then
                    if FunctionParameter.webhook.scheduledSend and FunctionParameter:checkScheduledSend() then
                        pcall(function()
                            FunctionParameter:sendWebhook()
                        end)
                    elseif FunctionParameter.webhook.autoSend and os.time() - FunctionParameter.webhook.lastSentTime >= FunctionParameter.webhook.sendInterval then
                        pcall(function()
                            FunctionParameter:sendWebhook()
                        end)
                    end
                end
                wait(5)
            end
        end)
        spawn(function()
            while true do
                pcall(function()
                    FunctionParameter:saveDailyStats()
                end)
                wait(300)
            end
        end)
    end
}
ConfigData:start()
local SpoofConfig = {
    enabled = false,
    spoofedValues = {},
    originalValues = {},
    spoofedObjects = {}
}
local function LocalFunction(FunctionParameter)
    if not FunctionParameter then
        return "0"
    end
    local ParameterValue = tostring(math.floor(FunctionParameter))
    local UnusedVariable = ""
    for LoopCounter = 1, # ParameterValue do
        if (LoopCounter - 1) % 3 == 0 and 1 < LoopCounter then
            UnusedVariable = "," .. UnusedVariable
        end
        UnusedVariable = ParameterValue:sub(# ParameterValue - LoopCounter + 1, # ParameterValue - LoopCounter + 1) .. UnusedVariable
    end
    return UnusedVariable
end
local function LocalFunction(FunctionParameter, FunctionParameter, FunctionParameter)
    if FunctionParameter then
        local LeaderStatsFolder = FunctionParameter:FindFirstChild("leaderstats")
        if LeaderStatsFolder and LeaderStatsFolder:FindFirstChild(FunctionParameter) then
            local SpecificStatFolder = LeaderStatsFolder:FindFirstChild(FunctionParameter)
            if not SpoofConfig.originalValues[FunctionParameter] then
                SpoofConfig.originalValues[FunctionParameter] = SpecificStatFolder.Value
            end
            SpecificStatFolder.Value = FunctionParameter
            SpoofConfig.spoofedObjects[FunctionParameter] = SpecificStatFolder
        end
        local PlayerStatsFolder = FunctionParameter:FindFirstChild(FunctionParameter)
        if PlayerStatsFolder and (PlayerStatsFolder:IsA("IntValue") or PlayerStatsFolder:IsA("NumberValue")) then
            if not SpoofConfig.originalValues[FunctionParameter .. "_direct"] then
                SpoofConfig.originalValues[FunctionParameter .. "_direct"] = PlayerStatsFolder.Value
            end
            PlayerStatsFolder.Value = FunctionParameter
            SpoofConfig.spoofedObjects[FunctionParameter .. "_direct"] = PlayerStatsFolder
        end
    end
end
local function GetPlayerStatsFunction(PlayerParameter, StatNameParameter)
    if PlayerParameter then
        local PlayerLeaderStats = PlayerParameter:FindFirstChild("leaderstats")
        if PlayerLeaderStats and PlayerLeaderStats:FindFirstChild(StatNameParameter) then
            local SpecificStatValue = PlayerLeaderStats:FindFirstChild(StatNameParameter)
            if SpoofConfig.originalValues[StatNameParameter] then
                SpecificStatValue.Value = SpoofConfig.originalValues[StatNameParameter]
            end
        end
        local PlayerSpecificStat = PlayerParameter:FindFirstChild(StatNameParameter)
        if PlayerSpecificStat and (PlayerSpecificStat:IsA("IntValue") or PlayerSpecificStat:IsA("NumberValue")) and SpoofConfig.originalValues[StatNameParameter .. "_direct"] then
            PlayerSpecificStat.Value = SpoofConfig.originalValues[StatNameParameter .. "_direct"]
        end
    end
end
local function CalculatePlayerStatsFunction()
    local LocalPlayerInstance = game.Players.LocalPlayer
    if LocalPlayerInstance then
        local StatNameIterator, StatValueIterator, StatIndexIterator = ipairs({
            "Strength",
            "Durability",
            "Agility",
            "Rebirths",
            "Kills",
            "Brawls",
            "Gems"
        })
        while true do
            local SpoofedStatIndex
            StatIndexIterator, SpoofedStatIndex = StatNameIterator(StatValueIterator, StatIndexIterator)
            if StatIndexIterator == nil then
                break
            end
            local SpoofedStatValue = SpoofConfig.spoofedValues[SpoofedStatIndex]
            if SpoofedStatValue and 0 < SpoofedStatValue then
                LocalFunction(LocalPlayerInstance, SpoofedStatIndex, SpoofedStatValue)
            end
        end
    end
end
local function UpdateSpoofedStatsFunction()
    local LocalPlayerInstance2 = game.Players.LocalPlayer
    if LocalPlayerInstance2 then
        local StatNameIterator2, StatValueIterator2, StatIndexIterator2 = ipairs({
            "Strength",
            "Durability",
            "Agility",
            "Rebirths",
            "Kills",
            "Brawls",
            "Gems"
        })
        while true do
            local TemporaryValue
            StatIndexIterator2, TemporaryValue = StatNameIterator2(StatValueIterator2, StatIndexIterator2)
            if StatIndexIterator2 == nil then
                break
            end
            GetPlayerStatsFunction(LocalPlayerInstance2, TemporaryValue)
        end
        SpoofConfig.originalValues = {}
        SpoofConfig.spoofedObjects = {}
    end
end
TabConfig["Spoof Stats"]:AddToggle({
    Title = "Enable Visual Stat Spoofing",
    Default = false,
    Callback = function(InputParameter)
        SpoofConfig.enabled = InputParameter
        if InputParameter then
            CalculatePlayerStatsFunction()
        else
            UpdateSpoofedStatsFunction()
        end
    end
})
local AddStrengthInputFunction = TabConfig["Spoof Stats"]:AddInput({
    Title = "Strength",
    Default = "0",
    Placeholder = "Enter spoofed strength value",
    Numeric = true,
    Finished = false,
    Callback = function(DefaultValueParameter)
        local ParsedDefaultValue = tonumber(DefaultValueParameter) or 0
        if ParsedDefaultValue >= 0 then
            SpoofConfig.spoofedValues.Strength = ParsedDefaultValue
            if SpoofConfig.enabled then
                LocalFunction(game.Players.LocalPlayer, "Strength", ParsedDefaultValue)
            end
        end
    end
})
local AddDurabilityInputFunction = TabConfig["Spoof Stats"]:AddInput({
    Title = "Durability",
    Default = "0",
    Placeholder = "Enter spoofed durability value",
    Numeric = true,
    Finished = false,
    Callback = function(DefaultValueParameter2)
        local ParsedDefaultValue2 = tonumber(DefaultValueParameter2) or 0
        if ParsedDefaultValue2 >= 0 then
            SpoofConfig.spoofedValues.Durability = ParsedDefaultValue2
            if SpoofConfig.enabled then
                LocalFunction(game.Players.LocalPlayer, "Durability", ParsedDefaultValue2)
            end
        end
    end
})
local AddAgilityInputFunction = TabConfig["Spoof Stats"]:AddInput({
    Title = "Agility",
    Default = "0",
    Placeholder = "Enter spoofed agility value",
    Numeric = true,
    Finished = false,
    Callback = function(DefaultValueParameter3)
        local ParsedDefaultValue3 = tonumber(DefaultValueParameter3) or 0
        if ParsedDefaultValue3 >= 0 then
            SpoofConfig.spoofedValues.Agility = ParsedDefaultValue3
            if SpoofConfig.enabled then
                LocalFunction(game.Players.LocalPlayer, "Agility", ParsedDefaultValue3)
            end
        end
    end
})
local AddRebirthsInputFunction = TabConfig["Spoof Stats"]:AddInput({
    Title = "Rebirths",
    Default = "0",
    Placeholder = "Enter spoofed rebirths value",
    Numeric = true,
    Finished = false,
    Callback = function(DefaultValueParameter4)
        local ParsedDefaultValue4 = tonumber(DefaultValueParameter4) or 0
        if ParsedDefaultValue4 >= 0 then
            SpoofConfig.spoofedValues.Rebirths = ParsedDefaultValue4
            if SpoofConfig.enabled then
                LocalFunction(game.Players.LocalPlayer, "Rebirths", ParsedDefaultValue4)
            end
        end
    end
})
local AddKillsInputFunction = TabConfig["Spoof Stats"]:AddInput({
    Title = "Kills",
    Default = "0",
    Placeholder = "Enter spoofed kills value",
    Numeric = true,
    Finished = false,
    Callback = function(DefaultValueParameter5)
        local ParsedDefaultValue5 = tonumber(DefaultValueParameter5) or 0
        if ParsedDefaultValue5 >= 0 then
            SpoofConfig.spoofedValues.Kills = ParsedDefaultValue5
            if SpoofConfig.enabled then
                LocalFunction(game.Players.LocalPlayer, "Kills", ParsedDefaultValue5)
            end
        end
    end
})
local AddBrawlsInputFunction = TabConfig["Spoof Stats"]:AddInput({
    Title = "Brawls",
    Default = "0",
    Placeholder = "Enter spoofed brawls value",
    Numeric = true,
    Finished = false,
    Callback = function(DefaultValueParameter6)
        local ParsedDefaultValue6 = tonumber(DefaultValueParameter6) or 0
        if ParsedDefaultValue6 >= 0 then
            SpoofConfig.spoofedValues.Brawls = ParsedDefaultValue6
            if SpoofConfig.enabled then
                LocalFunction(game.Players.LocalPlayer, "Brawls", ParsedDefaultValue6)
            end
        end
    end
})
local AddGemsInputFunction = TabConfig["Spoof Stats"]:AddInput({
    Title = "Gems",
    Default = "0",
    Placeholder = "Enter spoofed gems value",
    Numeric = true,
    Finished = false,
    Callback = function(DefaultValueParameter7)
        local ParsedDefaultValue7 = tonumber(DefaultValueParameter7) or 0
        if ParsedDefaultValue7 >= 0 then
            SpoofConfig.spoofedValues.Gems = ParsedDefaultValue7
            if SpoofConfig.enabled then
                LocalFunction(game.Players.LocalPlayer, "Gems", ParsedDefaultValue7)
            end
        end
    end
})
local AddSpoofStatusParagraphFunction = TabConfig["Spoof Stats"]:AddParagraph({
    Title = "Spoof Status",
    Content = "Status: Disabled\n\nCurrent Spoofed Values:\nNone"
})
TabConfig["Spoof Stats"]:AddButton({
    Title = "Load Current Stats",
    Callback = function()
        local LocalPlayerInstance3 = game.Players.LocalPlayer
        if LocalPlayerInstance3 then
            local StatNameIterator3, StatValueIterator3, StatIndexIterator3 = ipairs({
                "Strength",
                "Durability",
                "Agility",
                "Rebirths",
                "Kills",
                "Brawls",
                "Gems"
            })
            while true do
                local TemporaryValue2
                StatIndexIterator3, TemporaryValue2 = StatNameIterator3(StatValueIterator3, StatIndexIterator3)
                if StatIndexIterator3 == nil then
                    break
                end
                local ZeroValue = 0
                local PlayerLeaderStats2 = LocalPlayerInstance3:FindFirstChild("leaderstats")
                if PlayerLeaderStats2 and PlayerLeaderStats2:FindFirstChild(TemporaryValue2) then
                    ZeroValue = PlayerLeaderStats2[TemporaryValue2].Value or 0
                else
                    local PlayerSpecificStat2 = LocalPlayerInstance3:FindFirstChild(TemporaryValue2)
                    if PlayerSpecificStat2 and PlayerSpecificStat2.Value then
                        ZeroValue = PlayerSpecificStat2.Value
                    end
                end
                SpoofConfig.spoofedValues[TemporaryValue2] = ZeroValue
            end
            AddStrengthInputFunction:Set(tostring(SpoofConfig.spoofedValues.Strength or 0))
            AddDurabilityInputFunction:Set(tostring(SpoofConfig.spoofedValues.Durability or 0))
            AddAgilityInputFunction:Set(tostring(SpoofConfig.spoofedValues.Agility or 0))
            AddRebirthsInputFunction:Set(tostring(SpoofConfig.spoofedValues.Rebirths or 0))
            AddKillsInputFunction:Set(tostring(SpoofConfig.spoofedValues.Kills or 0))
            AddBrawlsInputFunction:Set(tostring(SpoofConfig.spoofedValues.Brawls or 0))
            AddGemsInputFunction:Set(tostring(SpoofConfig.spoofedValues.Gems or 0))
            if SpoofConfig.enabled then
                CalculatePlayerStatsFunction()
            end
        end
    end
})
TabConfig["Spoof Stats"]:AddButton({
    Title = "Clear All Spoofs",
    Callback = function()
        if SpoofConfig.enabled then
            UpdateSpoofedStatsFunction()
        end
        SpoofConfig.spoofedValues = {}
        AddStrengthInputFunction:Set("0")
        AddDurabilityInputFunction:Set("0")
        AddAgilityInputFunction:Set("0")
        AddRebirthsInputFunction:Set("0")
        AddKillsInputFunction:Set("0")
        AddBrawlsInputFunction:Set("0")
        AddGemsInputFunction:Set("0")
        if SpoofConfig.enabled then
            CalculatePlayerStatsFunction()
        end
    end
})
TabConfig["Spoof Stats"]:AddButton({
    Title = "Apply Changes",
    Callback = function()
        if SpoofConfig.enabled then
            CalculatePlayerStatsFunction()
        end
    end
})
local function UpdatePlayerStatsFunction()
    local SpoofStatusString = SpoofConfig.enabled and "Enabled" or "Disabled"
    local SpoofedValuesString = "Current Spoofed Values:\n"
    if SpoofConfig.enabled then
        local StatNameIterator4, StatValueIterator4, StatIndexIterator4 = ipairs({
            "Strength",
            "Durability",
            "Agility",
            "Rebirths",
            "Kills",
            "Brawls",
            "Gems"
        })
        local FalseValue = false
        while true do
            local SpoofedStatIndex2
            StatIndexIterator4, SpoofedStatIndex2 = StatNameIterator4(StatValueIterator4, StatIndexIterator4)
            if StatIndexIterator4 == nil then
                break
            end
            local SpoofedStatValue2 = SpoofConfig.spoofedValues[SpoofedStatIndex2]
            if SpoofedStatValue2 and 0 < SpoofedStatValue2 then
                SpoofedValuesString = SpoofedValuesString .. string.format("%s: %s\n", SpoofedStatIndex2, LocalFunction(SpoofedStatValue2))
                FalseValue = true
            end
        end
        if not FalseValue then
            SpoofedValuesString = SpoofedValuesString .. "None set"
        end
    else
        SpoofedValuesString = SpoofedValuesString .. "Spoofing disabled"
    end
    AddSpoofStatusParagraphFunction:Set({
        Title = "Spoof Status",
        Content = string.format("Status: %s\n\n%s", SpoofStatusString, SpoofedValuesString:sub(1, - 2))
    })
end
spawn(function()
    while true do
        UpdatePlayerStatsFunction()
        wait(2)
    end
end)
game.Players.LocalPlayer.CharacterRemoving:Connect(function()
    if SpoofConfig.enabled then
        SpoofConfig.originalValues = {}
        SpoofConfig.spoofedObjects = {}
    end
end)
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    wait(3)
    if SpoofConfig.enabled then
        CalculatePlayerStatsFunction()
    end
end)
local AddPlayerDropdownFunction = TabConfig["Damage Calculator"]:AddDropdown({
    Title = "Select Player",
    Content = "Choose a player to calculate their combat stats",
    Multi = false,
    Options = {},
    Default = {},
    Callback = function(PlayerParameter2)
        if PlayerParameter2 and # PlayerParameter2 > 0 then
            updateCalculatorParagraph(PlayerParameter2[1])
        end
    end
})
local AddCombatCalculatorParagraphFunction = TabConfig["Damage Calculator"]:AddParagraph({
    Title = "Combat Calculator",
    Content = "Select a player from the dropdown above to see their damage output, health, and survivability calculations."
})
local function CalculateDamageFunction(InputParameter2)
    if InputParameter2 >= 1e18 then
        return string.format("%.1fQI", InputParameter2 / 1e18)
    elseif InputParameter2 >= 1000000000000000 then
        return string.format("%.1fQA", InputParameter2 / 1000000000000000)
    elseif InputParameter2 >= 1000000000000 then
        return string.format("%.1fT", InputParameter2 / 1000000000000)
    elseif InputParameter2 >= 1000000000 then
        return string.format("%.1fB", InputParameter2 / 1000000000)
    elseif InputParameter2 >= 1000000 then
        return string.format("%.1fM", InputParameter2 / 1000000)
    elseif InputParameter2 >= 1000 then
        return string.format("%.1fK", InputParameter2 / 1000)
    else
        return string.format("%.0f", InputParameter2)
    end
end
local function UpdateDamageCalculatorFunction(ValueParameter)
    local StringValue = tostring(math.floor(ValueParameter))
    repeat
        local TemporaryValue3
        StringValue, TemporaryValue3 = string.gsub(StringValue, "^(-?%d+)(%d%d%d)", "%1,%2")
    until TemporaryValue3 == 0
    return StringValue
end
local function CalculatePlayerDamageFunction(PlayerParameter3)
    local OneValue = 1
    local OneValue2 = 1
    local UltimatesFolder = PlayerParameter3:FindFirstChild("ultimatesFolder")
    if UltimatesFolder then
        local DemonDamageValue = UltimatesFolder:FindFirstChild("Demon Damage")
        OneValue2 = DemonDamageValue and DemonDamageValue.Value and 1.49 or OneValue2
        local InfernalHealthValue = UltimatesFolder:FindFirstChild("Infernal Health")
        if InfernalHealthValue and InfernalHealthValue.Value then
            OneValue = 2
        end
    end
    return OneValue, OneValue2
end
local function CalculatePlayerStatsFunction2(PlayerParameter4)
    local OneValue3 = 1
    local OneValue4 = 1
    local EquippedPetsFolder = PlayerParameter4:FindFirstChild("equippedPets")
    if not EquippedPetsFolder then
        return OneValue3, OneValue4
    end
    local ZeroValue2 = 0
    local ZeroValue3 = 0
    for LoopCounter = 1, 8 do
        local PetFolder = EquippedPetsFolder:FindFirstChild("pet" .. LoopCounter)
        if PetFolder then
            if PetFolder:IsA("ObjectValue") then
                if PetFolder.Value then
                    local PetName = PetFolder.Value.Name
                    if PetName == "Mighty Monster" then
                        ZeroValue3 = ZeroValue3 + 1
                    elseif PetName == "Wild Wizard" then
                        ZeroValue2 = ZeroValue2 + 1
                    end
                end
            end
        end
    end
    return 1 + ZeroValue3 * 0.334, 1 + ZeroValue2 * 0.334
end
local function UpdatePlayerPetsFunction(InputParameter3, InputParameter4)
    return InputParameter3 <= 0 and 0 or InputParameter3 * 0.0667 * InputParameter4
end
function calculatePlayerDamage(PlayerParameter5)
    if not PlayerParameter5 then
        return 0
    end
    local ZeroValue4 = 0
    local PlayerLeaderStats3 = PlayerParameter5:FindFirstChild("leaderstats")
    if PlayerLeaderStats3 then
        local PlayerStrengthValue = PlayerLeaderStats3:FindFirstChild("Strength")
        if PlayerStrengthValue then
            ZeroValue4 = PlayerStrengthValue.Value
        end
    end
    if ZeroValue4 <= 0 then
        return 0
    end
    local UnusedParameter, CalculatedPlayerStats = CalculatePlayerStatsFunction2(PlayerParameter5)
    local UnusedParameter, CalculatedPlayerDamage = CalculatePlayerDamageFunction(PlayerParameter5)
    return UpdatePlayerPetsFunction(ZeroValue4, CalculatedPlayerStats * CalculatedPlayerDamage)
end
function calculatePlayerHealth(PlayerParameter6)
    if not PlayerParameter6 then
        return 100
    end
    local ZeroValue5 = 0
    local PlayerLeaderStats4 = PlayerParameter6:FindFirstChild("leaderstats")
    if PlayerLeaderStats4 then
        local CharacterModel = PlayerLeaderStats4:FindFirstChild("Durability")
        if CharacterModel then
            ZeroValue5 = CharacterModel.Value
        end
    end
    if ZeroValue5 <= 0 then
        local PlayerCharacter = PlayerParameter6:FindFirstChild("Durability")
        if PlayerCharacter and PlayerCharacter:IsA("IntValue") then
            ZeroValue5 = PlayerCharacter.Value
        end
    end
    if ZeroValue5 <= 0 then
        local PlayerCharacterModel = PlayerParameter6.Character
        if PlayerCharacterModel then
            local CharacterDurability = PlayerCharacterModel:FindFirstChild("Durability")
            if CharacterDurability and CharacterDurability:IsA("IntValue") then
                ZeroValue5 = CharacterDurability.Value
            end
        end
    end
    if ZeroValue5 <= 0 then
        return 100
    end
    local PlayerInfo, UnusedParameter = CalculatePlayerStatsFunction2(PlayerParameter6)
    local PlayerStats, UnusedParameter = CalculatePlayerDamageFunction(PlayerParameter6)
    return ZeroValue5 * (PlayerInfo * PlayerStats)
end
function updateCalculatorParagraph(ParameterValue)
    local PlayerIterator, PlayerKey, PlayerValue = pairs(game.Players:GetPlayers())
    local UnknownValue = nil
    while true do
        local LocalPlayer
        PlayerValue, LocalPlayer = PlayerIterator(PlayerKey, PlayerValue)
        if PlayerValue == nil then
            LocalPlayer = UnknownValue
            break
        end
        if LocalPlayer.Name == ParameterValue then
            break
        end
    end
    if LocalPlayer then
        local PlayerDamage = calculatePlayerDamage(game.Players.LocalPlayer)
        local PlayerHealth = calculatePlayerHealth(game.Players.LocalPlayer)
        local PlayerDamageValue = calculatePlayerDamage(LocalPlayer)
        local PlayerHealthValue = calculatePlayerHealth(LocalPlayer)
        local DamageRatio = 0 < PlayerHealthValue and 0 < PlayerDamage and math.ceil(PlayerHealthValue / PlayerDamage) or math.huge
        local HealthRatio = 0 < PlayerHealth and 0 < PlayerDamageValue and math.ceil(PlayerHealth / PlayerDamageValue) or math.huge
        local DamageText = (DamageRatio == math.huge or 1e28 < DamageRatio) and "\226\136\158" or UpdateDamageCalculatorFunction(DamageRatio)
        local HealthText = (HealthRatio == math.huge or 1e28 < HealthRatio) and "\226\136\158" or UpdateDamageCalculatorFunction(HealthRatio)
        local RatioComparison = (DamageRatio ~= math.huge or HealthRatio ~= math.huge) and (DamageRatio ~= math.huge and (HealthRatio ~= math.huge and (DamageRatio < HealthRatio and "YOU WIN" or (HealthRatio < DamageRatio and "THEY WIN" or "TIE")) or "YOU WIN") or "THEY WIN") or "STALEMATE"
        AddCombatCalculatorParagraphFunction:Set({
            Title = "Combat Calculator",
            Content = string.format("HAVOC VS %s\n\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\n\nYOU:\n  Damage: %s (%s)\n  Health: %s (%s)\n\nTHEM:\n  Damage: %s (%s)\n  Health: %s (%s)\n\nHITS TO KILL:\n  You kill them: %s hits\n  They kill you: %s hits\n\nWHO HITS HARDER: %s\nWHO\'S TANKIER: %s\n\n\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\nRESULT: %s\n\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144", string.upper(LocalPlayer.DisplayName or LocalPlayer.Name), CalculateDamageFunction(PlayerDamage), UpdateDamageCalculatorFunction(PlayerDamage), CalculateDamageFunction(PlayerHealth), UpdateDamageCalculatorFunction(PlayerHealth), CalculateDamageFunction(PlayerDamageValue), UpdateDamageCalculatorFunction(PlayerDamageValue), CalculateDamageFunction(PlayerHealthValue), UpdateDamageCalculatorFunction(PlayerHealthValue), DamageText, HealthText, PlayerDamage < PlayerDamageValue and "THEM" or (PlayerDamageValue < PlayerDamage and "YOU" or "EQUAL"), PlayerHealth < PlayerHealthValue and "THEM" or (PlayerHealthValue < PlayerHealth and "YOU" or "EQUAL"), RatioComparison)
        })
    else
        AddCombatCalculatorParagraphFunction:Set({
            Title = "Combat Calculator",
            Content = "Player not found or disconnected. Please select another player."
        })
    end
end
local function GetPlayerFunction()
    local PlayerListIterator, PlayerListKey, PlayerListValue = pairs(game.Players:GetPlayers())
    local EmptyTable = {}
    while true do
        local UnusedValue
        PlayerListValue, UnusedValue = PlayerListIterator(PlayerListKey, PlayerListValue)
        if PlayerListValue == nil then
            break
        end
        if UnusedValue ~= game.Players.LocalPlayer then
            table.insert(EmptyTable, UnusedValue.Name)
        end
    end
    AddPlayerDropdownFunction:Refresh(EmptyTable, {})
end
game.Players.PlayerAdded:Connect(function()
    wait(1)
    pcall(GetPlayerFunction)
end)
game.Players.PlayerRemoving:Connect(function()
    pcall(GetPlayerFunction)
end)
pcall(GetPlayerFunction)
spawn(function()
    while true do
        repeat
            wait(3)
        until AddPlayerDropdownFunction.Value and # AddPlayerDropdownFunction.Value > 0
        pcall(updateCalculatorParagraph, AddPlayerDropdownFunction.Value[1])
    end
end)
local AddDropdownFunction = TabConfig.Player:AddDropdown({
    Title = "Select Player",
    Content = "Choose a player to view their detailed statistics",
    Multi = false,
    Options = {},
    Default = {},
    Callback = function(DropdownParameter)
        if DropdownParameter and # DropdownParameter > 0 then
            updatePlayerStats(DropdownParameter[1])
        end
    end
})
local AddParagraphFunction = TabConfig.Player:AddParagraph({
    Title = "Player Statistics",
    Content = "Select a player from the dropdown above to view their complete stat breakdown"
})
local function GetPlayerStatFunction(PlayerParameter, StatParameter)
    local LeaderstatsFolder = PlayerParameter:FindFirstChild("leaderstats")
    local StatValue = LeaderstatsFolder and LeaderstatsFolder:FindFirstChild(StatParameter)
    return not StatValue and 0 or StatValue.Value
end
local function GetPlayerInfoFunction(PlayerInfoParameter, InfoParameter)
    local InfoValue = PlayerInfoParameter:FindFirstChild(InfoParameter)
    return not InfoValue and 0 or InfoValue.Value
end
function updatePlayerStats(UnusedParameter)
    local PlayerIterator2, PlayerKey2, PlayerValue2 = pairs(game.Players:GetPlayers())
    local UnusedValue2 = nil
    while true do
        local PlayerObject
        PlayerValue2, PlayerObject = PlayerIterator2(PlayerKey2, PlayerValue2)
        if PlayerValue2 == nil then
            PlayerObject = UnusedValue2
            break
        end
        if PlayerObject.Name == UnusedParameter then
            break
        end
    end
    if PlayerObject then
        local StrengthValue = GetPlayerStatFunction(PlayerObject, "Strength")
        local RebirthsValue = GetPlayerStatFunction(PlayerObject, "Rebirths")
        local KillsValue = GetPlayerStatFunction(PlayerObject, "Kills")
        local BrawlsValue = GetPlayerStatFunction(PlayerObject, "Brawls")
        local DurabilityValue = GetPlayerInfoFunction(PlayerObject, "Durability")
        local AgilityValue = GetPlayerInfoFunction(PlayerObject, "Agility")
        local EvilKarmaValue = GetPlayerInfoFunction(PlayerObject, "evilKarma")
        local GoodKarmaValue = GetPlayerInfoFunction(PlayerObject, "goodKarma")
        local PlayerStatsText = string.format("> Strength: %s | %s\n> Rebirths: %s | %s\n> Kills: %s | %s\n> Brawls: %s | %s\n> Durability: %s | %s\n> Agility: %s | %s\n> Bad Karma: %s | %s\n> Good Karma: %s | %s", UpdateDamageCalculatorFunction(StrengthValue), CalculateDamageFunction(StrengthValue), UpdateDamageCalculatorFunction(RebirthsValue), CalculateDamageFunction(RebirthsValue), UpdateDamageCalculatorFunction(KillsValue), CalculateDamageFunction(KillsValue), UpdateDamageCalculatorFunction(BrawlsValue), CalculateDamageFunction(BrawlsValue), UpdateDamageCalculatorFunction(DurabilityValue), CalculateDamageFunction(DurabilityValue), UpdateDamageCalculatorFunction(AgilityValue), CalculateDamageFunction(AgilityValue), UpdateDamageCalculatorFunction(EvilKarmaValue), CalculateDamageFunction(EvilKarmaValue), UpdateDamageCalculatorFunction(GoodKarmaValue), CalculateDamageFunction(GoodKarmaValue))
        AddParagraphFunction:Set({
            Title = "Player Statistics - " .. (PlayerObject.DisplayName or PlayerObject.Name),
            Content = PlayerStatsText
        })
    else
        AddParagraphFunction:Set({
            Title = "Player Statistics",
            Content = "Player not found or disconnected"
        })
    end
end
local function GetPlayerInfoFunction2()
    local PlayerIterator3, PlayerKey3, PlayerValue3 = pairs(game.Players:GetPlayers())
    local EmptyTable2 = {}
    while true do
        local UnusedValue3
        PlayerValue3, UnusedValue3 = PlayerIterator3(PlayerKey3, PlayerValue3)
        if PlayerValue3 == nil then
            break
        end
        table.insert(EmptyTable2, UnusedValue3.Name)
    end
    AddDropdownFunction:Refresh(EmptyTable2, {})
end
game.Players.PlayerAdded:Connect(GetPlayerInfoFunction2)
game.Players.PlayerRemoving:Connect(GetPlayerInfoFunction2)
spawn(function()
    while true do
        repeat
            wait(2)
        until AddDropdownFunction.Value and # AddDropdownFunction.Value > 0
        updatePlayerStats(AddDropdownFunction.Value[1])
    end
end)
GetPlayerInfoFunction2()
local PlayerDataTable = {
    sel = {},
    eating = false,
    specSnack = nil,
    qty = 1,
    selPlr = nil,
    selRar = nil,
    selType = nil,
    foundPets = {},
    formatEventName = function(InputParameter)
        local InputIterator, InputKey, InputValue = InputParameter:gmatch("%S+")
        local InputTable = {}
        while true do
            InputValue = InputIterator(InputKey, InputValue)
            if InputValue == nil then
                break
            end
            table.insert(InputTable, InputValue:lower())
        end
        for LoopCounter = 2, # InputTable do
            InputTable[LoopCounter] = InputTable[LoopCounter]:sub(1, 1):upper() .. InputTable[LoopCounter]:sub(2)
        end
        return table.concat(InputTable)
    end,
    consumeSnacks = function()
        local LocalPlayerObject = game:GetService("Players").LocalPlayer
        local PlayerDataIterator, PlayerDataKey, PlayerDataValue = ipairs(PlayerDataTable.sel)
        while true do
            local ItemName
            PlayerDataValue, ItemName = PlayerDataIterator(PlayerDataKey, PlayerDataValue)
            if PlayerDataValue == nil then
                break
            end
            local ItemObject = LocalPlayerObject.Character:FindFirstChild(ItemName) or LocalPlayerObject.Backpack:FindFirstChild(ItemName)
            if ItemObject then
                LocalPlayerObject.muscleEvent:FireServer(PlayerDataTable.formatEventName(ItemName), ItemObject)
                wait(0.1)
            end
        end
    end,
    consumeSpecQty = function()
        if not PlayerDataTable.specSnack then
            return
        end
        local LocalPlayerObject2 = game:GetService("Players").LocalPlayer
        for UnusedParameter = 1, PlayerDataTable.qty do
            local SnackObject = LocalPlayerObject2.Character:FindFirstChild(PlayerDataTable.specSnack) or LocalPlayerObject2.Backpack:FindFirstChild(PlayerDataTable.specSnack)
            if not SnackObject then
                break
            end
            LocalPlayerObject2.muscleEvent:FireServer(PlayerDataTable.formatEventName(PlayerDataTable.specSnack), SnackObject)
            wait(0.1)
        end
    end,
    getCurPlayers = function()
        local PlayerIterator4, PlayerKey4, PlayerValue4 = ipairs(game:GetService("Players"):GetPlayers())
        local EmptyTable3 = {}
        while true do
            local UnusedValue4
            PlayerValue4, UnusedValue4 = PlayerIterator4(PlayerKey4, PlayerValue4)
            if PlayerValue4 == nil then
                break
            end
            table.insert(EmptyTable3, UnusedValue4.DisplayName .. " | " .. UnusedValue4.Name)
        end
        return EmptyTable3
    end,
    findPetInFolder = function(PlayerParameter2, PetParameter, PetNameParameter)
        local PetsFolder = PlayerParameter2:FindFirstChild("petsFolder")
        if not PetsFolder then
            return nil
        end
        local PetString = PlayerParameter2.Name .. "*" .. PetNameParameter .. "*" .. PetParameter
        if PlayerDataTable.foundPets[PetString] then
            return PlayerDataTable.foundPets[PetString]
        end
        local RarityIterator, RarityKey, RarityValue = ipairs({
            "Basic",
            "Advanced",
            "Rare",
            "Epic",
            "Unique"
        })
        local RarityTable = {}
        while true do
            local PetName
            RarityValue, PetName = RarityIterator(RarityKey, RarityValue)
            if RarityValue == nil then
                break
            end
            local PetObject = PetsFolder:FindFirstChild(PetName)
            if PetObject then
                local PetIterator, PetKey, PetValue = ipairs(PetObject:GetChildren())
                while true do
                    local UnusedValue5
                    PetValue, UnusedValue5 = PetIterator(PetKey, PetValue)
                    if PetValue == nil then
                        break
                    end
                    if UnusedValue5:IsA("StringValue") and UnusedValue5.Name == PetParameter then
                        table.insert(RarityTable, UnusedValue5)
                    end
                end
            end
        end
        if # RarityTable == 0 then
            return nil
        end
        if # RarityTable == 1 then
            PlayerDataTable.foundPets[PetString] = RarityTable[1]
            return RarityTable[1]
        end
        local UnusedValue6 = nil
        for UnusedParameter = 1, 3 do
            local RarityIterator2, RarityKey2, RarityValue2 = ipairs(RarityTable)
            local EmptyTable4 = {}
            while true do
                local PerksFolderParent
                RarityValue2, PerksFolderParent = RarityIterator2(RarityKey2, RarityValue2)
                if RarityValue2 == nil then
                    break
                end
                local PerksFolder = PerksFolderParent:FindFirstChild("perksFolder")
                if PerksFolder then
                    EmptyTable4[RarityValue2] = {}
                    local PerkChild, PerkIndex, PerkValue = ipairs(PerksFolder:GetChildren())
                    local PreviousValue = RarityValue2
                    while true do
                        local UnusedValue
                        PerkValue, UnusedValue = PerkChild(PerkIndex, PerkValue)
                        if PerkValue == nil then
                            break
                        end
                        if UnusedValue:IsA("NumberValue") or UnusedValue:IsA("IntValue") then
                            EmptyTable4[PreviousValue][UnusedValue.Name] = UnusedValue.Value
                        end
                    end
                end
            end
            wait(1)
            local GetPerkFunction, PerkParameter1, PerkParameter2 = ipairs(RarityTable)
            while true do
                local PerkResult, PerkFunction = GetPerkFunction(PerkParameter1, PerkParameter2)
                if PerkResult == nil then
                    PerkFunction = UnusedValue6
                    break
                end
                local PerksFolderParent2 = PerkFunction:FindFirstChild("perksFolder")
                if PerksFolderParent2 and EmptyTable4[PerkResult] then
                    local PerkChild2, PerkIndex2, PerkValue2 = ipairs(PerksFolderParent2:GetChildren())
                    PerkParameter2 = PerkResult
                    local BooleanValue = false
                    while true do
                        local UnusedValue2
                        PerkValue2, UnusedValue2 = PerkChild2(PerkIndex2, PerkValue2)
                        if PerkValue2 == nil then
                            break
                        end
                        if (UnusedValue2:IsA("NumberValue") or UnusedValue2:IsA("IntValue")) and (EmptyTable4[PerkResult][UnusedValue2.Name] and UnusedValue2.Value > EmptyTable4[PerkResult][UnusedValue2.Name]) then
                            BooleanValue = true
                            break
                        end
                    end
                    if BooleanValue then
                        break
                    end
                else
                    PerkParameter2 = PerkResult
                end
            end
            if PerkFunction then
                UnusedValue6 = PerkFunction
            end
            UnusedValue6 = PerkFunction
        end
        if not UnusedValue6 then
            return RarityTable[1]
        end
        PlayerDataTable.foundPets[PetString] = UnusedValue6
        return UnusedValue6
    end,
    getPetStats = function(Parameter1)
        local PerksFolder3 = Parameter1:FindFirstChild("perksFolder")
        if not PerksFolder3 then
            return {}
        end
        local PerkChild3, PerkIndex3, PerkValue3 = ipairs(PerksFolder3:GetChildren())
        local EmptyTable = {}
        while true do
            local UnusedValue3
            PerkValue3, UnusedValue3 = PerkChild3(PerkIndex3, PerkValue3)
            if PerkValue3 == nil then
                break
            end
            if UnusedValue3:IsA("NumberValue") or UnusedValue3:IsA("IntValue") then
                table.insert(EmptyTable, UnusedValue3.Name .. " : " .. UnusedValue3.Value)
            end
        end
        return EmptyTable
    end,
    updateInvDisplay = function()
        if PlayerDataTable.selPlr and PlayerDataTable.selType then
            if PlayerDataTable.selType ~= "Ultimates" then
                if PlayerDataTable.selType ~= "Gamepasses" then
                    if PlayerDataTable.selType ~= "Equipped Pets" then
                        if PlayerDataTable.selRar then
                            local FolderType = PlayerDataTable.selType == "Pets" and "petsFolder" or "powerUpsFolder"
                            local PetsFolder = PlayerDataTable.selPlr:FindFirstChild(FolderType)
                            if PetsFolder then
                                local PetFolder = PetsFolder:FindFirstChild(PlayerDataTable.selRar)
                                if PetFolder then
                                    local PetChild, PetIndex, PetValue = ipairs(PetFolder:GetChildren())
                                    local PetTable = {}
                                    while true do
                                        local UnusedValue4
                                        PetValue, UnusedValue4 = PetChild(PetIndex, PetValue)
                                        if PetValue == nil then
                                            break
                                        end
                                        if UnusedValue4:IsA("StringValue") then
                                            PetTable[UnusedValue4.Name] = (PetTable[UnusedValue4.Name] or 0) + 1
                                        end
                                    end
                                    local PetKey, PetValue2, PetIndex2 = pairs(PetTable)
                                    local EmptyString = ""
                                    local ZeroValue = 0
                                    while true do
                                        local UnusedValue5
                                        PetIndex2, UnusedValue5 = PetKey(PetValue2, PetIndex2)
                                        if PetIndex2 == nil then
                                            break
                                        end
                                        EmptyString = EmptyString .. PetIndex2 .. " | " .. UnusedValue5 .. "\n"
                                        ZeroValue = ZeroValue + UnusedValue5
                                    end
                                    local UnusedValue6
                                    if EmptyString == "" then
                                        UnusedValue6 = "No " .. PlayerDataTable.selRar .. " " .. PlayerDataTable.selType:lower() .. " found."
                                    else
                                        UnusedValue6 = "Total " .. PlayerDataTable.selRar .. " " .. PlayerDataTable.selType .. ": " .. ZeroValue .. "\n\n" .. EmptyString
                                    end
                                    PlayerDataTable.invPara:Set({
                                        Title = PlayerDataTable.selType .. " Inventory - " .. PlayerDataTable.selPlr.DisplayName .. " (" .. PlayerDataTable.selRar .. ")",
                                        Content = UnusedValue6
                                    })
                                else
                                    local InventoryParameter = PlayerDataTable.invPara
                                    local InventorySetter = InventoryParameter.Set
                                    local InventoryTitle = {
                                        Title = "Inventory - " .. PlayerDataTable.selPlr.DisplayName,
                                        Content = "No " .. PlayerDataTable.selRar .. " " .. PlayerDataTable.selType:lower() .. " found."
                                    }
                                    InventorySetter(InventoryParameter, InventoryTitle)
                                end
                            else
                                local InventoryParameter2 = PlayerDataTable.invPara
                                local InventorySetter2 = InventoryParameter2.Set
                                local InventoryTitle2 = {
                                    Title = "Inventory - " .. PlayerDataTable.selPlr.DisplayName,
                                    Content = "Player has no " .. PlayerDataTable.selType:lower() .. " folder."
                                }
                                InventorySetter2(InventoryParameter2, InventoryTitle2)
                                return
                            end
                        else
                            PlayerDataTable.invPara:Set({
                                Title = "Inventory",
                                Content = "Select a player, type, and rarity to view their inventory."
                            })
                            return
                        end
                    else
                        local EquippedPetsFolder = PlayerDataTable.selPlr:FindFirstChild("equippedPets")
                        if EquippedPetsFolder then
                            local PetString = ""
                            local PetCount = 0
                            for PetIndex3 = 1, 8 do
                                local PetChild2 = EquippedPetsFolder:FindFirstChild("pet" .. PetIndex3)
                                if PetChild2 then
                                    if PetChild2:IsA("ObjectValue") then
                                        if PetChild2.Value then
                                            local PetName = PetChild2.Value.Name
                                            local PetObject = PlayerDataTable.findPetInFolder(PlayerDataTable.selPlr, PetName, PetIndex3)
                                            if PetObject then
                                                local PetString2 = PetString .. PetName .. "\n"
                                                local PetStats = PlayerDataTable.getPetStats(PetObject)
                                                if # PetStats <= 0 then
                                                    PetString2 = PetString2 .. "No stats found\n"
                                                else
                                                    local PetStatIndex, PetStatKey, PetStatValue = ipairs(PetStats)
                                                    while true do
                                                        local UnusedValue7
                                                        PetStatValue, UnusedValue7 = PetStatIndex(PetStatKey, PetStatValue)
                                                        if PetStatValue == nil then
                                                            break
                                                        end
                                                        PetString2 = PetString2 .. UnusedValue7 .. "\n"
                                                    end
                                                end
                                                PetString = PetString2 .. "-------------------------------\n"
                                                PetCount = PetCount + 1
                                            else
                                                PetString = ((PetString .. PetName .. "\n") .. "Pet data not found in petsFolder\n") .. "-------------------------------\n"
                                                PetCount = PetCount + 1
                                            end
                                        end
                                    end
                                end
                            end
                            local PetInfoString = PetString == "" and "This Player Currently Doesnt Have Pets Equipped" or "Total Equipped: " .. PetCount .. "\n\n" .. PetString
                            PlayerDataTable.invPara:Set({
                                Title = "Equipped Pets - " .. PlayerDataTable.selPlr.DisplayName,
                                Content = PetInfoString
                            })
                        else
                            PlayerDataTable.invPara:Set({
                                Title = "Equipped Pets - " .. PlayerDataTable.selPlr.DisplayName,
                                Content = "This Player Currently Doesnt Have Pets Equipped"
                            })
                        end
                    end
                else
                    local OwnedGamepassesFolder = PlayerDataTable.selPlr:FindFirstChild("ownedGamepasses")
                    if OwnedGamepassesFolder then
                        local GamepassChild, GamepassIndex, GamepassValue = ipairs(OwnedGamepassesFolder:GetChildren())
                        local GamepassTable = {}
                        local GamepassString = ""
                        local GamepassCount = 0
                        while true do
                            local UnusedValue8
                            GamepassValue, UnusedValue8 = GamepassChild(GamepassIndex, GamepassValue)
                            if GamepassValue == nil then
                                break
                            end
                            if UnusedValue8:IsA("IntValue") and not GamepassTable[UnusedValue8.Name] then
                                GamepassString = GamepassString .. UnusedValue8.Name .. "\n"
                                GamepassTable[UnusedValue8.Name] = true
                                GamepassCount = GamepassCount + 1
                            end
                        end
                        local GamepassInfoString = GamepassString == "" and "No gamepasses found." or "Total Gamepasses: " .. GamepassCount .. "\n\n" .. GamepassString
                        PlayerDataTable.invPara:Set({
                            Title = "Gamepasses - " .. PlayerDataTable.selPlr.DisplayName,
                            Content = GamepassInfoString
                        })
                    else
                        PlayerDataTable.invPara:Set({
                            Title = "Gamepasses - " .. PlayerDataTable.selPlr.DisplayName,
                            Content = "Player has no owned gamepasses."
                        })
                    end
                end
            else
                local UltimatesFolder = PlayerDataTable.selPlr:FindFirstChild("ultimatesFolder")
                if UltimatesFolder then
                    local UltimateChild, UltimateIndex, UltimateValue = ipairs(UltimatesFolder:GetChildren())
                    local UltimateString = ""
                    local UltimateCount = 0
                    while true do
                        local UnusedValue9
                        UltimateValue, UnusedValue9 = UltimateChild(UltimateIndex, UltimateValue)
                        if UltimateValue == nil then
                            break
                        end
                        if UnusedValue9:IsA("IntValue") then
                            UltimateString = UltimateString .. UnusedValue9.Name .. " : " .. UnusedValue9.Value .. "\n"
                            UltimateCount = UltimateCount + 1
                        end
                    end
                    local UltimateInfoString = UltimateString == "" and "No ultimates found." or "Total Ultimates: " .. UltimateCount .. "\n\n" .. UltimateString
                    PlayerDataTable.invPara:Set({
                        Title = "Ultimates - " .. PlayerDataTable.selPlr.DisplayName,
                        Content = UltimateInfoString
                    })
                else
                    PlayerDataTable.invPara:Set({
                        Title = "Ultimates - " .. PlayerDataTable.selPlr.DisplayName,
                        Content = "Player has no ultimates folder."
                    })
                end
            end
        else
            if PlayerDataTable.invPara then
                PlayerDataTable.invPara:Set({
                    Title = "Inventory",
                    Content = "Select a player and type to view their inventory."
                })
            end
            return
        end
    end
}
TabConfig["Snacks Eater"]:AddDropdown({
    Title = "Select Snacks",
    Content = "Choose which snacks to consume",
    Multi = true,
    Options = {
        "Energy Bar",
        "Protein Bar",
        "Protein Shake",
        "TOUGH Bar",
        "ULTRA Shake",
        "Protein Egg",
        "Tropical Shake"
    },
    Default = {},
    Callback = function(Parameter2)
        PlayerDataTable.sel = Parameter2
    end
})
TabConfig["Snacks Eater"]:AddDropdown({
    Title = "Special Snack",
    Content = "Select snack for eating",
    Multi = false,
    Options = {
        "Protein Egg",
        "Tropical Shake"
    },
    Default = {
        "Protein Egg"
    },
    Callback = function(Parameter3)
        PlayerDataTable.specSnack = Parameter3[1]
    end
})
TabConfig["Snacks Eater"]:AddInput({
    Title = "Quantity",
    Content = "Enter how many to eat",
    Placeholder = "5",
    Numeric = true,
    Callback = function(Parameter4)
        PlayerDataTable.qty = tonumber(Parameter4) or 1
    end
})
TabConfig["Snacks Eater"]:AddButton({
    Title = "Eat Special Snacks",
    Content = "Consume the specified amount of selected snack",
    Callback = function()
        PlayerDataTable.consumeSpecQty()
    end
})
TabConfig["Snacks Eater"]:AddToggle({
    Title = "Auto Eat Snacks",
    Content = "Automatically consume selected snacks",
    Default = false,
    Callback = function(Parameter5)
        PlayerDataTable.eating = Parameter5
        if Parameter5 then
            spawn(function()
                while PlayerDataTable.eating do
                    if # PlayerDataTable.sel > 0 then
                        PlayerDataTable.consumeSnacks()
                    end
                    wait(0.5)
                end
            end)
        end
    end
})
PlayerDataTable.plrDrop = TabConfig["Inventory Looker"]:AddDropdown({
    Title = "Select Player",
    Content = "Choose a player to view their inventory",
    Multi = false,
    Options = PlayerDataTable.getCurPlayers(),
    Default = {},
    Callback = function(Parameter6)
        if Parameter6 and # Parameter6 > 0 then
            PlayerDataTable.selPlr = game:GetService("Players"):FindFirstChild(Parameter6[1]:match("| (.+)$"))
            PlayerDataTable.foundPets = {}
        end
    end
})
TabConfig["Inventory Looker"]:AddDropdown({
    Title = "Select Type",
    Content = "Choose inventory type to view",
    Multi = false,
    Options = {
        "Pets",
        "Auras",
        "Ultimates",
        "Gamepasses",
        "Equipped Pets"
    },
    Default = {},
    Callback = function(Parameter7)
        if Parameter7 and # Parameter7 > 0 then
            PlayerDataTable.selType = Parameter7[1]
        end
    end
})
TabConfig["Inventory Looker"]:AddDropdown({
    Title = "Select Rarity",
    Content = "Choose rarity to display",
    Multi = false,
    Options = {
        "Basic",
        "Advanced",
        "Rare",
        "Epic",
        "Unique"
    },
    Default = {},
    Callback = function(Parameter8)
        if Parameter8 and # Parameter8 > 0 then
            PlayerDataTable.selRar = Parameter8[1]
        end
    end
})
PlayerDataTable.invPara = TabConfig["Inventory Looker"]:AddParagraph({
    Title = "Inventory",
    Content = "Select a player, type, and rarity to view their inventory."
})
game:GetService("Players").PlayerAdded:Connect(function()
    PlayerDataTable.plrDrop:Refresh(PlayerDataTable.getCurPlayers(), {})
end)
game:GetService("Players").PlayerRemoving:Connect(function()
    PlayerDataTable.plrDrop:Refresh(PlayerDataTable.getCurPlayers(), {})
end)
spawn(function()
    while true do
        repeat
            wait(2)
        until PlayerDataTable.selPlr and PlayerDataTable.selRar
        PlayerDataTable.updateInvDisplay()
    end
end)
local PlayerData = {
    selectedPlayerEgg = nil,
    eggCount = 0,
    selectedPlayerShake = nil,
    shakeCount = 0,
    eatingRunning = false,
    proteinEggLabel = nil,
    tropicalShakeLabel = nil,
    playerDropdownEgg = nil,
    playerDropdownShake = nil,
    eggCountLabel = nil,
    shakeCountLabel = nil,
    updateItemCount = function()
        local InitialValue = 0
        local InitialValue2 = 0
        local Backpack = game:GetService("Players").LocalPlayer:WaitForChild("Backpack")
        if Backpack then
            local ToolChild, ToolIndex, ToolValue = ipairs(Backpack:GetChildren())
            while true do
                local UnusedValue10
                ToolValue, UnusedValue10 = ToolChild(ToolIndex, ToolValue)
                if ToolValue == nil then
                    break
                end
                if UnusedValue10.Name ~= "Protein Egg" then
                    if UnusedValue10.Name == "Tropical Shake" then
                        InitialValue2 = InitialValue2 + 1
                    end
                else
                    InitialValue = InitialValue + 1
                end
            end
        end
        if PlayerData.eggCountLabel then
            PlayerData.eggCountLabel:Set({
                Title = "Protein Eggs",
                Content = "Current count: " .. InitialValue
            })
        end
        if PlayerData.shakeCountLabel then
            PlayerData.shakeCountLabel:Set({
                Title = "Tropical Shakes",
                Content = "Current count: " .. InitialValue2
            })
        end
    end,
    activateProteinEgg = function()
        local LocalPlayer = game:GetService("Players").LocalPlayer
        local ProteinEgg = LocalPlayer.Character:FindFirstChild("Protein Egg") or LocalPlayer.Backpack:FindFirstChild("Protein Egg")
        if ProteinEgg then
            LocalPlayer.muscleEvent:FireServer("proteinEgg", ProteinEgg)
        end
    end,
    giftProteinEggs = function()
        if PlayerData.selectedPlayerEgg and (PlayerData.eggCount and PlayerData.eggCount > 0) then
            for UnusedParameter = 1, PlayerData.eggCount do
                local GiftRequestTable = {
                    "giftRequest",
                    PlayerData.selectedPlayerEgg,
                    game:GetService("Players").LocalPlayer.consumablesFolder:FindFirstChild("Protein Egg")
                }
                game:GetService("ReplicatedStorage").rEvents.giftRemote:InvokeServer(unpack(GiftRequestTable))
            end
        end
    end,
    giftTropicalShakes = function()
        if PlayerData.selectedPlayerShake and (PlayerData.shakeCount and PlayerData.shakeCount > 0) then
            for UnusedParameter = 1, PlayerData.shakeCount do
                local GiftRequestTable2 = {
                    "giftRequest",
                    PlayerData.selectedPlayerShake,
                    game:GetService("Players").LocalPlayer.consumablesFolder:FindFirstChild("Tropical Shake")
                }
                game:GetService("ReplicatedStorage").rEvents.giftRemote:InvokeServer(unpack(GiftRequestTable2))
            end
        end
    end,
    getCurrentPlayers = function()
        local PlayerIndex, PlayerKey, PlayerValue = ipairs(game:GetService("Players"):GetPlayers())
        local PlayerTable = {}
        while true do
            local UnknownValue
            PlayerValue, UnknownValue = PlayerIndex(PlayerKey, PlayerValue)
            if PlayerValue == nil then
                break
            end
            if UnknownValue ~= game:GetService("Players").LocalPlayer then
                table.insert(PlayerTable, UnknownValue.Name)
            end
        end
        return PlayerTable
    end
}
local GiftSection = MainTab.Misc:AddSection("Gift Egg/Shakes", false)
GiftSection:AddSeperator({
    Title = "Egg Gifter"
})
PlayerData.eggCountLabel = GiftSection:AddParagraph({
    Title = "Protein Eggs",
    Content = "Current count: 0"
})
PlayerData.playerDropdownEgg = GiftSection:AddDropdown({
    Title = "Choose Player",
    Content = "Select player to gift eggs",
    Multi = false,
    Options = PlayerData.getCurrentPlayers(),
    Default = {},
    Callback = function(Parameter1)
        if Parameter1 and # Parameter1 > 0 then
            PlayerData.selectedPlayerEgg = game:GetService("Players"):FindFirstChild(Parameter1[1])
        end
    end
})
GiftSection:AddInput({
    Title = "Amount",
    Content = "Enter number of eggs to gift",
    Default = "1",
    Callback = function(Parameter2)
        PlayerData.eggCount = tonumber(Parameter2) or 1
    end
})
GiftSection:AddButton({
    Title = "Start Gifting Eggs",
    Content = "Gift the specified amount of protein eggs",
    Callback = function()
        PlayerData.giftProteinEggs()
    end
})
GiftSection:AddSeperator({
    Title = "Shake Gifter"
})
PlayerData.shakeCountLabel = GiftSection:AddParagraph({
    Title = "Tropical Shakes",
    Content = "Current count: 0"
})
PlayerData.playerDropdownShake = GiftSection:AddDropdown({
    Title = "Choose Player",
    Content = "Select player to gift shakes",
    Multi = false,
    Options = PlayerData.getCurrentPlayers(),
    Default = {},
    Callback = function(Parameter3)
        if Parameter3 and # Parameter3 > 0 then
            PlayerData.selectedPlayerShake = game:GetService("Players"):FindFirstChild(Parameter3[1])
        end
    end
})
GiftSection:AddInput({
    Title = "Amount",
    Content = "Enter number of shakes to gift",
    Default = "1",
    Callback = function(Parameter4)
        PlayerData.shakeCount = tonumber(Parameter4) or 1
    end
})
GiftSection:AddButton({
    Title = "Start Gifting Shakes",
    Content = "Gift the specified amount of tropical shakes",
    Callback = function()
        PlayerData.giftTropicalShakes()
    end
})
GiftSection:AddSeperator({
    Title = "Auto Eater"
})
GiftSection:AddToggle({
    Title = "Auto Eat Protein Eggs",
    Content = "Automatically consume protein eggs",
    Default = false,
    Callback = function(Parameter5)
        PlayerData.eatingRunning = Parameter5
    end
})
game:GetService("Players").PlayerAdded:Connect(function()
    local CurrentPlayer = PlayerData.getCurrentPlayers()
    PlayerData.playerDropdownEgg:Refresh(CurrentPlayer, {})
    PlayerData.playerDropdownShake:Refresh(CurrentPlayer, {})
end)
game:GetService("Players").PlayerRemoving:Connect(function()
    local PlayerList = PlayerData.getCurrentPlayers()
    PlayerData.playerDropdownEgg:Refresh(PlayerList, {})
    PlayerData.playerDropdownShake:Refresh(PlayerList, {})
end)
task.spawn(function()
    while true do
        PlayerData.updateItemCount()
        task.wait(0.25)
    end
end)
task.spawn(function()
    while true do
        while PlayerData.eatingRunning do
            PlayerData.activateProteinEgg()
            task.wait(0.25)
        end
        task.wait(1)
    end
end)
getgenv().SelectedRarity = "Unique"
getgenv().RebirthNumber = 18980
local RockTable = {
    {
        "Jungle Rock",
        16.25
    },
    {
        "Muscle King Rock",
        12.5
    },
    {
        "Legends Rock",
        2.5
    },
    {
        "Inferno Rock",
        1.125
    },
    {
        "Mystic Rock",
        0.75
    },
    {
        "Frozen Rock",
        0.375
    },
    {
        "Golden Rock",
        0.2
    },
    {
        "Large Rock",
        0.075
    },
    {
        "Punching Rock",
        0.05
    },
    {
        "Tiny Rock",
        0.025
    }
}
local PetTable = {
    ["Unique Pet"] = {
        0,
        1250,
        3750,
        7500,
        12500,
        18750,
        26250,
        35000,
        45000,
        56250,
        68750,
        82500,
        97500,
        113750,
        131250,
        150000,
        170000,
        191250,
        213750,
        237500
    },
    ["Epic Pet"] = {
        0,
        1000,
        3000,
        6000,
        10000,
        15000,
        21000,
        28000,
        36000,
        45000,
        55000,
        66000,
        78000,
        91000,
        105000,
        120000,
        136000,
        153000,
        171000,
        190000,
        210000
    },
    ["Rare Pet"] = {
        0,
        750,
        2250,
        4500,
        7500,
        11250,
        15750,
        21000,
        27000,
        33750,
        41250,
        49500,
        58500,
        68250,
        78750,
        90000,
        102000,
        114750,
        128250,
        142500,
        157500
    },
    ["Advanced Pet"] = {
        0,
        500,
        1500,
        3000,
        5000,
        7500,
        10500,
        14000,
        18000,
        22500,
        27500,
        33000,
        39000,
        45500,
        52500,
        60000,
        68000,
        76500,
        85500,
        95000,
        105000
    },
    ["Basic Pet"] = {
        0,
        250,
        750,
        1500,
        2500,
        3750,
        5250,
        7000,
        9000,
        11250,
        13750,
        16500,
        19500,
        22750,
        26250,
        30000,
        34000,
        38250,
        42750,
        47500,
        52500
    },
    ["Unique Aura"] = {
        0,
        3000,
        7500,
        13500,
        21000,
        30000,
        40500,
        52500,
        66000,
        81000,
        97500,
        115500,
        135000,
        156000,
        178500,
        202500,
        228000,
        255000,
        283500,
        313500,
        345000
    },
    ["Epic Aura"] = {
        0,
        2400,
        6000,
        10800,
        16800,
        24000,
        32400,
        42000,
        52800,
        64800,
        78000,
        92400,
        108000,
        124800,
        142800,
        162000,
        182400,
        204000,
        226800,
        250800,
        276000
    },
    ["Rare Aura"] = {
        0,
        1800,
        4500,
        8100,
        12600,
        18000,
        24300,
        31500,
        39600,
        48600,
        58500,
        69300,
        81000,
        93600,
        107100,
        121500,
        136800,
        153000,
        170100,
        188100,
        207000
    },
    ["Advanced Aura"] = {
        0,
        1200,
        3000,
        5400,
        8400,
        12000,
        16200,
        21000,
        26400,
        32400,
        39000,
        46200,
        54000,
        62400,
        71400,
        81000,
        91200,
        102000,
        113400,
        125400,
        138000
    },
    ["Basic Aura"] = {
        0,
        600,
        1500,
        2700,
        4200,
        6000,
        8100,
        10500,
        13200,
        16200,
        19500,
        23100,
        27000,
        31200,
        35700,
        40500,
        45600,
        51000,
        56700,
        62700,
        69000
    }
}
local RarityTable = {
    Basic = 1,
    Advanced = 2,
    Rare = 3,
    Epic = 4,
    Unique = 5
}
local UnusedValue = nil
function calculateAuraStats(FunctionParam1, FunctionParam2, FunctionParam3)
    local PetData = PetTable[FunctionParam2]
    if not PetData then
        return 0
    end
    if string.find(FunctionParam2, "Unique") and string.find(FunctionParam2, "Aura") then
        local ZeroValue = 0
        for LoopCounter = 2, # PetData do
            local PetInfo = PetData[LoopCounter]
            if PetInfo > FunctionParam1 then
                break
            end
            FunctionParam1 = FunctionParam1 - PetInfo
            ZeroValue = ZeroValue + 1
        end
        return (ZeroValue + 1) * FunctionParam3
    end
    if not string.find(FunctionParam2, "Aura") then
        local PetIndex, PetKey, PetValue = ipairs(PetData)
        local OneValue = 1
        while true do
            local UnusedVariable
            PetValue, UnusedVariable = PetIndex(PetKey, PetValue)
            if PetValue == nil or UnusedVariable > FunctionParam1 then
                break
            end
            OneValue = PetValue
        end
        return (OneValue - 1) * FunctionParam3
    end
    local InitialValue = 0
    for CounterValue = 2, # PetData do
        if PetData[CounterValue] > FunctionParam1 then
            break
        end
        InitialValue = InitialValue + 1
    end
    local CalculatedValue = InitialValue * FunctionParam3
    if CalculatedValue ~= 0 then
        FunctionParam3 = CalculatedValue
    end
    return FunctionParam3
end
function calculateSingleRock(Param1, Param2, Param3, Param4)
    local PetInfoData = PetTable[Param3]
    if not PetInfoData then
        return "Invalid type"
    end
    local RebirthValue = (getgenv().RebirthNumber + 20) * Param2
    if RebirthValue ~= math.floor(RebirthValue) or PetInfoData[# PetInfoData] < RebirthValue then
        return Param1 .. ": Not Glitchable"
    end
    local FloorValue = math.floor(RebirthValue)
    local PetIndex1, PetKey1, PetValue1 = ipairs(PetInfoData)
    while true do
        local UnusedVar
        PetValue1, UnusedVar = PetIndex1(PetKey1, PetValue1)
        if PetValue1 == nil then
            break
        end
        if FloorValue == UnusedVar then
            return Param1 .. ": Level 1, 0xp | " .. calculateAuraStats(FloorValue, Param3, Param4) .. " Stats"
        end
    end
    local PetIndex2, PetKey2, PetValue2 = ipairs(PetInfoData)
    local NilValue = nil
    while true do
        local SubtractValue
        PetValue2, SubtractValue = PetIndex2(PetKey2, PetValue2)
        if PetValue2 == nil then
            SubtractValue = NilValue
            break
        end
        if FloorValue < SubtractValue then
            break
        end
    end
    if not SubtractValue then
        return Param1 .. ": Not Glitchable"
    end
    local ResultValue = SubtractValue - FloorValue
    local CopyValue = ResultValue
    local TrueValue = 1
    for LoopIndex = 2, # PetInfoData do
        if PetInfoData[LoopIndex] >= CopyValue then
            break
        end
        ResultValue = CopyValue - PetInfoData[LoopIndex]
        TrueValue = LoopIndex
    end
    return Param1 .. ": Level " .. TrueValue .. ", " .. ResultValue .. "xp | " .. calculateAuraStats(FloorValue, Param3, Param4) .. " Stats"
end
function calculateResult()
    if getgenv().RebirthNumber and getgenv().RebirthNumber > 0 then
        local RarityLevel = RarityTable[getgenv().SelectedRarity]
        if RarityLevel then
            local PetName = getgenv().SelectedRarity .. " Pet"
            local RockIndex, RockKey, RockValue = ipairs(RockTable)
            local PetString = "Pets:\n"
            while true do
                local RockData
                RockValue, RockData = RockIndex(RockKey, RockValue)
                if RockValue == nil then
                    break
                end
                local RockName = RockData[1]
                local RockPrice = RockData[2]
                PetString = PetString .. calculateSingleRock(RockName, RockPrice, PetName, RarityLevel) .. "\n"
            end
            local AuraString = PetString .. "\nAuras:\n"
            local AuraName = getgenv().SelectedRarity .. " Aura"
            local RockIndex1, RockKey1, RockValue1 = ipairs(RockTable)
            while true do
                local AuraData
                RockValue1, AuraData = RockIndex1(RockKey1, RockValue1)
                if RockValue1 == nil then
                    break
                end
                local AuraName1 = AuraData[1]
                local AuraPrice = AuraData[2]
                AuraString = AuraString .. calculateSingleRock(AuraName1, AuraPrice, AuraName, RarityLevel) .. "\n"
            end
            if UnusedValue then
                UnusedValue:Set({
                    Title = "Calculation Result",
                    Content = AuraString
                })
            end
        end
    else
        if UnusedValue then
            UnusedValue:Set({
                Title = "Calculation Result",
                Content = "Enter a rebirth number to see the result"
            })
        end
        return
    end
end
TabConfig["Rebirth Calculator"] = MainTab.Calculators:AddSection("Rebirth Calculator", false)
TabConfig["Rebirth Calculator"]:AddDropdown({
    Title = "Rarity",
    Content = "Select the rarity level",
    Multi = false,
    Options = {
        "Basic",
        "Advanced",
        "Rare",
        "Epic",
        "Unique"
    },
    Default = {
        "Unique"
    },
    Callback = function(FuncParam1)
        getgenv().SelectedRarity = FuncParam1[1] or "Unique"
        calculateResult()
    end
})
TabConfig["Rebirth Calculator"]:AddInput({
    Title = "Rebirth Number",
    Content = "Enter your rebirth number to calculate",
    Default = "18980",
    Callback = function(FuncParam2)
        getgenv().RebirthNumber = tonumber(FuncParam2) or 0
        calculateResult()
    end
})
UnusedValue = TabConfig["Rebirth Calculator"]:AddParagraph({
    Title = "Calculation Result",
    Content = "Enter a rebirth number to see the result"
})
calculateResult()
TabConfig["Hit Animation"]:AddToggle({
    Title = "Hide Punch Animation",
    Default = false,
    Callback = function(FuncParam3)
        if FuncParam3 then
            local AssetTable = {
                ["rbxassetid://3638729053"] = true,
                ["rbxassetid://3638767427"] = true
            }
            local function LocalFunction()
                local LocalCharacter = game.Players.LocalPlayer.Character
                if LocalCharacter and LocalCharacter:FindFirstChild("Humanoid") then
                    local Humanoid = LocalCharacter:FindFirstChild("Humanoid")
                    local AnimationTrack, TrackKey, TrackValue = pairs(Humanoid:GetPlayingAnimationTracks())
                    while true do
                        local Animation
                        TrackValue, Animation = AnimationTrack(TrackKey, TrackValue)
                        if TrackValue == nil then
                            break
                        end
                        if Animation.Animation then
                            local AnimationId = Animation.Animation.AnimationId
                            local AnimationName = Animation.Name:lower()
                            if AssetTable[AnimationId] or (AnimationName:match("punch") or (AnimationName:match("attack") or AnimationName:match("right"))) then
                                Animation:Stop()
                            end
                        end
                    end
                    _G.AnimBlockConnection = Humanoid.AnimationPlayed:Connect(function(AnimParam)
                        if AnimParam.Animation then
                            local AnimId = AnimParam.Animation.AnimationId
                            local AnimName = AnimParam.Name:lower()
                            if AssetTable[AnimId] or (AnimName:match("punch") or (AnimName:match("attack") or AnimName:match("right"))) then
                                AnimParam:Stop()
                            end
                        end
                    end)
                end
            end
            local function LocalFunc(FuncParam)
                if FuncParam and (FuncParam.Name == "Punch" or (FuncParam.Name:match("Attack") or FuncParam.Name:match("Right"))) and not FuncParam:GetAttribute("ActivatedOverride") then
                    FuncParam:SetAttribute("ActivatedOverride", true)
                    _G.ToolConnections = _G.ToolConnections or {}
                    _G.ToolConnections[FuncParam] = FuncParam.Activated:Connect(function()
                        task.wait(0.05)
                        local Character = game.Players.LocalPlayer.Character
                        if Character and Character:FindFirstChild("Humanoid") then
                            local Track, TrackKey1, TrackValue1 = pairs(Character.Humanoid:GetPlayingAnimationTracks())
                            while true do
                                local Anim
                                TrackValue1, Anim = Track(TrackKey1, TrackValue1)
                                if TrackValue1 == nil then
                                    break
                                end
                                if Anim.Animation then
                                    local AnimId1 = Anim.Animation.AnimationId
                                    local AnimName1 = Anim.Name:lower()
                                    if AssetTable[AnimId1] or (AnimName1:match("punch") or (AnimName1:match("attack") or AnimName1:match("right"))) then
                                        Anim:Stop()
                                    end
                                end
                            end
                        end
                    end)
                end
            end
            local function LocalFunction1()
                local Tool, ToolKey, ToolValue = pairs(game.Players.LocalPlayer.Backpack:GetChildren())
                while true do
                    local ToolData
                    ToolValue, ToolData = Tool(ToolKey, ToolValue)
                    if ToolValue == nil then
                        break
                    end
                    LocalFunc(ToolData)
                end
                local Char = game.Players.LocalPlayer.Character
                if Char then
                    local Child, ChildKey, ChildValue = pairs(Char:GetChildren())
                    while true do
                        local Unused
                        ChildValue, Unused = Child(ChildKey, ChildValue)
                        if ChildValue == nil then
                            break
                        end
                        if Unused:IsA("Tool") then
                            LocalFunc(Unused)
                        end
                    end
                end
                _G.BackpackAddedConnection = game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function(Parameter1)
                    if Parameter1:IsA("Tool") then
                        task.wait(0.1)
                        LocalFunc(Parameter1)
                    end
                end)
                if Char then
                    _G.CharacterToolAddedConnection = Char.ChildAdded:Connect(function(Parameter2)
                        if Parameter2:IsA("Tool") then
                            task.wait(0.1)
                            LocalFunc(Parameter2)
                        end
                    end)
                end
            end
            _G.AnimMonitorConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if tick() % 0.5 < 0.01 then
                    local LocalCharacter = game.Players.LocalPlayer.Character
                    if LocalCharacter and LocalCharacter:FindFirstChild("Humanoid") then
                        local AnimationTrack, AnimationInstance, TrackInfo = pairs(LocalCharacter.Humanoid:GetPlayingAnimationTracks())
                        while true do
                            local ToolObject
                            TrackInfo, ToolObject = AnimationTrack(AnimationInstance, TrackInfo)
                            if TrackInfo == nil then
                                break
                            end
                            if ToolObject.Animation then
                                local AnimationId = ToolObject.Animation.AnimationId
                                local ToolName = ToolObject.Name:lower()
                                if AssetTable[AnimationId] or (ToolName:match("punch") or (ToolName:match("attack") or ToolName:match("right"))) then
                                    ToolObject:Stop()
                                end
                            end
                        end
                    end
                end
            end)
            _G.CharacterAddedConnection = game.Players.LocalPlayer.CharacterAdded:Connect(function(FunctionParam1)
                task.wait(1)
                LocalFunction()
                LocalFunction1()
                if _G.CharacterToolAddedConnection then
                    _G.CharacterToolAddedConnection:Disconnect()
                end
                _G.CharacterToolAddedConnection = FunctionParam1.ChildAdded:Connect(function(FunctionParam2)
                    if FunctionParam2:IsA("Tool") then
                        task.wait(0.1)
                        LocalFunc(FunctionParam2)
                    end
                end)
            end)
            LocalFunction()
            LocalFunction1()
        else
            if _G.AnimBlockConnection then
                _G.AnimBlockConnection:Disconnect()
                _G.AnimBlockConnection = nil
            end
            if _G.AnimMonitorConnection then
                _G.AnimMonitorConnection:Disconnect()
                _G.AnimMonitorConnection = nil
            end
            if _G.CharacterAddedConnection then
                _G.CharacterAddedConnection:Disconnect()
                _G.CharacterAddedConnection = nil
            end
            if _G.BackpackAddedConnection then
                _G.BackpackAddedConnection:Disconnect()
                _G.BackpackAddedConnection = nil
            end
            if _G.CharacterToolAddedConnection then
                _G.CharacterToolAddedConnection:Disconnect()
                _G.CharacterToolAddedConnection = nil
            end
            if _G.ToolConnections then
                local ToolConnectionFunc, ConnectionKey, ConnectionValue = pairs(_G.ToolConnections)
                while true do
                    local ConnectionResult, ConnectionData = ToolConnectionFunc(ConnectionKey, ConnectionValue)
                    if ConnectionResult == nil then
                        break
                    end
                    ConnectionValue = ConnectionResult
                    if ConnectionData then
                        ConnectionData:Disconnect()
                    end
                    if ConnectionResult and ConnectionResult:GetAttribute("ActivatedOverride") then
                        ConnectionResult:SetAttribute("ActivatedOverride", nil)
                    end
                end
                _G.ToolConnections = nil
            end
        end
    end
})
return ConfigData