local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local HiddenFolder = Instance.new("Folder", workspace)
HiddenFolder.Name = HttpService:GenerateGUID()

local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local ESP = {drawings = {}}
local PlayerCache = {}

local HitboxParts = {
    head = {"Head"},
    chest = {"UpperTorso", "LowerTorso"},
    arms = {"LeftUpperArm", "LeftLowerArm", "LeftHand", "RightUpperArm", "RightLowerArm", "RightHand"},
    legs = {"LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperLeg", "RightLowerLeg", "RightFoot"}
}

local RaycastValidation = {
    FindPartOnRayWithIgnoreList = {
        ArgCountRequired = 3,
        Args = {"Instance", "Ray", "table", "boolean", "boolean"}
    },
    FindPartOnRayWithWhitelist = {
        ArgCountRequired = 3,
        Args = {"Instance", "Ray", "table", "boolean"}
    },
    FindPartOnRay = {
        ArgCountRequired = 2,
        Args = {"Instance", "Ray", "Instance", "boolean", "boolean"}
    },
    Raycast = {
        ArgCountRequired = 3,
        Args = {"Instance", "Vector3", "Vector3", "RaycastParams"}
    }
}

if not Lighting:FindFirstChild("Atmosphere") then
    Instance.new("Atmosphere", Lighting)
end

local AimbotTarget = {target = nil}

if not (mousemove or mousemoverel or mouse_move) then
    LocalPlayer:Kick("Exploit not supported! Missing: mousemove.")
end

local function WorldToScreenPoint(position, player)
    local vector, onScreen = Camera:WorldToViewportPoint(position)
    return Vector2.new(vector.X, vector.Y), onScreen
end

local function GetDirection(from, to)
    return (to - from).Unit * 1000
end

local function ValidateArgs(args, validation)
    local matchCount = 0
    if #args < validation.ArgCountRequired then
        return false
    end
    for i, v in pairs(args) do
        if typeof(v) == validation.Args[i] then
            matchCount = matchCount + 1
        end
    end
    return validation.ArgCountRequired <= matchCount
end

local function IsPlayerValid(player)
    if not player then
        player = LocalPlayer
    end
    if not player then
        return false
    end
    if not player.Character then
        return false
    end
    if not player.Character:FindFirstChild("Humanoid") then
        return false
    end
    if player.Character.Humanoid.Health <= 0 then
        return false
    end
    return true
end

local function GetEquippedTool(character)
    for _, tool in pairs(character:GetChildren()) do
        if tool.ClassName == "Tool" then
            return tostring(tool.Name)
        end
    end
    return "NONE"
end

local GitHubURL = "https://raw.githubusercontent.com/fliskScript/jaran/refs/heads/main/other/"

local Library = loadstring(game:HttpGet(GitHubURL .. "Library"))()
local ThemeManager = loadstring(game:HttpGet(GitHubURL .. "Themes"))()
local SaveManager = loadstring(game:HttpGet(GitHubURL .. "SaveManager"))()

local WindowTitle = "t.me/jaran<font color=\"#C090E2\">vip</font>"

local Window = Library:CreateWindow({
    Title = WindowTitle .. " | free | role: user",
    Center = true,
    AutoShow = true,
    Size = UDim2.fromOffset(550, 500),
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {}
Tabs.legit = Window:AddTab("legitbot")
Tabs.esp = Window:AddTab("visuals")
Tabs.misc = Window:AddTab("misc")
Tabs["UI Settings"] = Window:AddTab("menu")

local LegitGroupbox = Tabs.legit:AddLeftGroupbox("aimbot")

LegitGroupbox:AddToggle("legit_enabled", {Text = "enabled"})
LegitGroupbox:AddToggle("legit_team", {Text = "teammates"})

LegitGroupbox:AddLabel("activation type"):AddKeyPicker("legit_bind", {
    Default = "MB1",
    Mode = "Hold",
    NoUI = true,
    Text = "legitbot"
})

LegitGroupbox:AddDropdown("legit_hitbox", {
    Text = "target hitbox",
    Default = 1,
    Multi = true,
    Values = {"head", "chest", "arms", "legs"}
})

LegitGroupbox:AddDropdown("legit_target_priority", {
    Text = "target priority",
    Default = 1,
    Values = {"closest to crosshair", "distance"}
})

LegitGroupbox:AddSlider("legit_speed", {
    Text = "smoothness",
    Default = 8,
    Min = 1,
    Max = 30,
    Rounding = 0
})

LegitGroupbox:AddSlider("legit_aim_fov", {
    Text = "maximum fov",
    Default = 90,
    Min = 0,
    Max = 180,
    Suffix = " ",
    Rounding = 0
})

LegitGroupbox:AddSlider("legit_deadzone_fov", {
    Text = "deadzone fov",
    Default = 50,
    Min = 0,
    Max = 140,
    Rounding = 0
})

LegitGroupbox:AddToggle("legit_walls", {Text = "aim through walls"})
LegitGroupbox:AddToggle("legit_forcefield", {Text = "aim on forcefield"})
LegitGroupbox:AddDivider()
LegitGroupbox:AddLabel("silent aim")
LegitGroupbox:AddToggle("legit_silent", {Text = "enabled"})

LegitGroupbox:AddSlider("legit_hitchance", {
    Text = "hitchance",
    Default = 100,
    Min = 0,
    Max = 100,
    Suffix = "%",
    Rounding = 0
})

LegitGroupbox:AddDropdown("legit_silent_mode", {
    Text = "method",
    Default = 1,
    Values = {"raycast", "findpartonray", "findpartonraywithwhitelist", "findpartonraywithignorelist", "mouse.hit/target"}
})

LegitGroupbox:AddToggle("legit_prediction", {Text = "prediction (mouse.hit/target)"})

LegitGroupbox:AddSlider("legit_prediction_amount", {
    Text = "prediction amount",
    Default = 100,
    Min = 0,
    Max = 100,
    Suffix = "%",
    Rounding = 0
})

local TriggerGroupbox = Tabs.legit:AddRightGroupbox("triggerbot")

TriggerGroupbox:AddToggle("trigger_enabled", {Text = "enabled"})
TriggerGroupbox:AddToggle("trigger_team", {Text = "teammates"})
TriggerGroupbox:AddToggle("trigger_onkey", {Text = "on keybind"})

TriggerGroupbox:AddLabel("activation type"):AddKeyPicker("trigger_bind", {
    Default = "E",
    Mode = "Hold",
    NoUI = true,
    Text = "triggerbot"
})

TriggerGroupbox:AddSlider("trigger_delay", {
    Text = "delay",
    Default = 0,
    Min = 0,
    Max = 1000,
    Suffix = "ms",
    Rounding = 0
})

local RenderGroupbox = Tabs.legit:AddRightGroupbox("renders")

RenderGroupbox:AddDropdown("legit_fov_position", {
    Text = "circle position",
    Default = 1,
    Values = {"center", "mouse"}
})

RenderGroupbox:AddToggle("legit_fov_render", {Text = "aimbot fov render"}):AddColorPicker("fov_color", {
    Default = Color3.new(1, 1, 1),
    Transparency = 0
})

RenderGroupbox:AddToggle("legit_deadzone_render", {Text = "deadzone fov render"}):AddColorPicker("deadzone_color", {
    Default = Color3.new(1, 0, 0),
    Transparency = 0
})

RenderGroupbox:AddToggle("legit_fov_filled", {Text = "aimbot fov filled"})
RenderGroupbox:AddToggle("legit_target_text", {Text = "target name render"})

local PlayerESPGroupbox = Tabs.esp:AddLeftGroupbox("players")

PlayerESPGroupbox:AddToggle("esp_team", {Text = "teammates"})

PlayerESPGroupbox:AddToggle("esp_box", {Text = "bounding box"}):AddColorPicker("box_color", {
    Default = Color3.new(1, 1, 1)
})

PlayerESPGroupbox:AddToggle("esp_healthbar", {Text = "healthbar"}):AddColorPicker("health_color", {
    Default = Color3.fromRGB(172, 223, 126)
})

local HealthDependency = PlayerESPGroupbox:AddDependencyBox()
HealthDependency:SetupDependencies({{Toggles.esp_healthbar, true}})

HealthDependency:AddToggle("esp_health", {Text = "health text"}):AddColorPicker("htext_color", {
    Default = Color3.fromRGB(172, 223, 126)
})

PlayerESPGroupbox:AddToggle("esp_name", {Text = "name"}):AddColorPicker("name_color", {
    Default = Color3.new(1, 1, 1)
})

PlayerESPGroupbox:AddToggle("esp_weapon", {Text = "weapon"}):AddColorPicker("weapon_color", {
    Default = Color3.new(1, 1, 1)
})

PlayerESPGroupbox:AddToggle("esp_distance", {Text = "distance"}):AddColorPicker("distance_color", {
    Default = Color3.new(1, 1, 1)
})

PlayerESPGroupbox:AddToggle("esp_outoffov", {Text = "out of fov"}):AddColorPicker("arrows_color", {
    Default = Color3.new(1, 1, 1),
    Transparency = 0
})

local ArrowDependency = PlayerESPGroupbox:AddDependencyBox()
ArrowDependency:SetupDependencies({{Toggles.esp_outoffov, true}})

ArrowDependency:AddToggle("esp_arrowfilled", {
    Text = "arrows filled",
    Default = true
})

ArrowDependency:AddDropdown("esp_arrows_transparency", {
    Text = "transparency mode",
    Default = 1,
    Values = {"static", "pulse"}
})

ArrowDependency:AddSlider("esp_arrowsize", {
    Text = "arrows size",
    Default = 64,
    Min = 40,
    Max = 200,
    Rounding = 0
})

ArrowDependency:AddSlider("esp_arrowoffset", {
    Text = "arrows offset",
    Default = 10,
    Min = 1,
    Max = 30,
    Rounding = 0
})

PlayerESPGroupbox:AddToggle("esp_chams", {Text = "chams"}):AddColorPicker("chams_color", {
    Default = Color3.fromRGB(166, 255, 0),
    Transparency = 0.3
})

local ChamsDependency = PlayerESPGroupbox:AddDependencyBox()
ChamsDependency:SetupDependencies({{Toggles.esp_chams, true}})

ChamsDependency:AddToggle("esp_chamsoutline", {Text = "chams outline"}):AddColorPicker("ochams_color", {
    Default = Color3.fromRGB(245, 129, 204),
    Transparency = 0.6
})

PlayerESPGroupbox:AddDropdown("esp_font", {
    Text = "font",
    Default = 1,
    Values = {"1", "2", "3"}
})

PlayerESPGroupbox:AddSlider("esp_fontsize", {
    Text = "font size",
    Default = 11,
    Min = 7,
    Max = 20,
    Rounding = 0
})

PlayerESPGroupbox:AddSlider("esp_fontflagsize", {
    Text = "font flags size",
    Default = 10,
    Min = 7,
    Max = 20,
    Rounding = 0
})

local WorldGroupbox = Tabs.esp:AddRightGroupbox("world")

WorldGroupbox:AddToggle("effects_worldcolor", {Text = "world gradient"}):AddColorPicker("ambient_color", {
    Default = Lighting.Ambient,
    Title = "ambient"
}):AddColorPicker("outdoorambient_color", {
    Default = Lighting.OutdoorAmbient,
    Title = "outdoor ambient"
})

WorldGroupbox:AddDropdown("effects_brightness", {
    Text = "brightness adjustment",
    Default = 1,
    Values = {"-", "fullbright", "night mode"}
})

WorldGroupbox:AddSlider("effects_haze", {
    Text = "haze",
    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 0,
    Callback = function(value)
        Lighting.Atmosphere.Haze = value
    end
})

WorldGroupbox:AddLabel("haze color"):AddColorPicker("haze_color", {
    Default = Lighting.Atmosphere.Color,
    Title = "haze",
    Callback = function(value)
        Lighting.Atmosphere.Color = value
    end
})

WorldGroupbox:AddSlider("effects_glare", {
    Text = "glare",
    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 0,
    Callback = function(value)
        Lighting.Atmosphere.Glare = value
    end
})

WorldGroupbox:AddLabel("decay color"):AddColorPicker("haze_color", {
    Default = Lighting.Atmosphere.Color,
    Title = "haze",
    Callback = function(value)
        Lighting.Atmosphere.Decay = value
    end
})

WorldGroupbox:AddSlider("effects_fog", {
    Text = "fog",
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(value)
        Lighting.Atmosphere.Density = value
    end
})

WorldGroupbox:AddSlider("effects_fog_visible", {
    Text = "fog visible",
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(value)
        Lighting.Atmosphere.Offset = value
    end
})

WorldGroupbox:AddSlider("effects_exposure", {
    Text = "exposure",
    Default = Lighting.ExposureCompensation,
    Min = 0,
    Max = 5,
    Rounding = 0,
    Callback = function(value)
        Lighting.ExposureCompensation = value
    end
})

local ServerGroupbox = Tabs.misc:AddLeftGroupbox("server")

ServerGroupbox:AddButton({
    Text = "copy place id",
    Func = function()
        setclipboard(game.PlaceId)
    end
})

ServerGroupbox:AddButton({
    Text = "copy job id",
    Func = function()
        setclipboard(game.JobId)
    end
})

ServerGroupbox:AddButton({
    Text = "rejoin to the server",
    Func = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
})

local GameGroupbox = Tabs.misc:AddLeftGroupbox("game")

GameGroupbox:AddSlider("fps_cap", {
    Text = "fps cap",
    Default = 144,
    Min = 20,
    Max = 600,
    Rounding = 0,
    Callback = function(value)
        setfpscap(value)
    end
})

GameGroupbox:AddToggle("misc_fovtoggle", {Text = "fov changer"})

GameGroupbox:AddSlider("misc_fov", {
    Text = "",
    Default = 70,
    Min = 70,
    Max = 120,
    Rounding = 0,
    Callback = function(value)
        if LocalPlayer.Character == nil then
            return
        end
        if Toggles.misc_fovtoggle.Value then
            Camera.FieldOfView = value
        end
    end
})

Camera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
    if LocalPlayer.Character == nil then
        return
    end
    if Options.misc_fov.Value == Camera.FieldOfView then
        return
    end
    if Toggles.misc_fovtoggle.Value then
        Camera.FieldOfView = Options.misc_fov.Value
    end
})

local MovementGroupbox = Tabs.misc:AddRightGroupbox("movement")

MovementGroupbox:AddToggle("move_speedhack", {Text = "speedhack"}):AddKeyPicker("speed_bind", {
    Default = "O",
    Mode = "Toggle",
    Text = "speedhack"
})

MovementGroupbox:AddSlider("move_speed", {
    Text = "speed",
    Default = 60,
    Min = 15,
    Max = 300,
    Suffix = " studs/s",
    Rounding = 0
})

MovementGroupbox:AddToggle("move_noclip", {Text = "noclip"}):AddKeyPicker("noclip_bind", {
    Default = "L",
    Mode = "Toggle",
    Text = "noclip"
})

MovementGroupbox:AddSlider("move_noclipspeed", {
    Text = "speed",
    Default = 80,
    Min = 0,
    Max = 300,
    Rounding = 0
})

MovementGroupbox:AddToggle("move_autojump", {Text = "auto jump"})

MovementGroupbox:AddToggle("move_edge", {Text = "jump at edge"}):AddKeyPicker("edge_bind", {
    Default = "Z",
    Mode = "Hold",
    Text = "jump at edje"
})

Library.OnUnload = function()
    Library.Unloaded = true
end

local MenuGroupbox = Tabs["UI Settings"]:AddRightGroupbox("menu")

MenuGroupbox:AddToggle("show_keybinds", {
    Text = "show keybinds",
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end
})

MenuGroupbox:AddButton("unload", function()
    Library:Unload()
end)

MenuGroupbox:AddLabel("menu bind"):AddKeyPicker("MenuKeybind", {
    Default = "Insert",
    NoUI = true,
    Text = "menu keybind"
})

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
ThemeManager:IgnoreThemeSettings()
ThemeManager:SetIgnoreIndexes({"MenuKeybind"})
ThemeManager:SetFolder("jaran/cfgs")
ThemeManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:LoadAutoloadConfig()

local function GetClosestPlayer()
    local closestDistance = math.huge
    local closestPlayer = nil
    
    for _, selectedHitbox in pairs(Options.legit_hitbox.Value) do
        for _, partName in pairs(HitboxParts[selectedHitbox]) do
            local targetPart = Player.Character:FindFirstChild(partName)
            if targetPart ~= nil then
                local screenPos, onScreen = Camera:WorldToScreenPoint(targetPart.Position)
                local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                local playerPos = Vector2.new(screenPos.X, screenPos.Y)
                local distance = (mousePos - playerPos).magnitude
                
                if distance < closestDistance then
                    closestPlayer = targetPart
                    closestDistance = distance
                end
            end
        end
    end
    
    if closestPlayer ~= nil then
        return closestPlayer
    end
end

local function GetHitboxPart(player)
    local closestDistance = math.huge
    local closestPart = nil
    
    for _, selectedHitbox in pairs(Options.legit_hitbox.Value) do
        for _, partName in pairs(HitboxParts[selectedHitbox]) do
            local targetPart = player.Character:FindFirstChild(partName)
            if targetPart ~= nil then
                local screenPos, onScreen = Camera:WorldToScreenPoint(targetPart.Position)
                local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                local playerPos = Vector2.new(screenPos.X, screenPos.Y)
                local distance = (mousePos - playerPos).magnitude
                
                if distance < closestDistance then
                    closestPart = targetPart
                    closestDistance = distance
                end
            end
        end
    end
    
    if closestPart ~= nil then
        return closestPart
    end
end

function ESP.drawObject(type, properties)
    local obj = Drawing.new(type)
    if properties then
        for k, v in next, properties do
            obj[k] = v
        end
    end
    return obj
end

ESP.default = {
    Line = {
        Thickness = 1.5,
        Color = Color3.fromRGB(255, 255, 255),
        Visible = false
    },
    Text = {
        Size = 13,
        Center = true,
        Outline = true,
        Font = Drawing.Fonts.Plex,
        Color = Color3.fromRGB(255, 255, 255),
        Visible = false
    },
    Square = {
        Thickness = 1,
        Filled = false,
        Color = Color3.fromRGB(255, 255, 255),
        Visible = false
    },
    Triangle = {
        Thickness = 2,
        Filled = false,
        Visible = false,
        Color = Color3.fromRGB(255, 255, 255)
    }
}

function ESP.create(type, outline, gradient)
    local obj = Drawing.new(type)
    for k, v in pairs(ESP.default[type]) do
        obj[k] = v
        obj.ZIndex = 2
    end
    if outline then
        obj.ZIndex = 1
        obj.Color = Color3.new(0, 0, 0)
        obj.Thickness = 2
    end
    if gradient then
        obj.Data = game:HttpGet("https://raw.githubusercontent.com/portallol/luna/main/Gradient180.png")
    end
    return obj
end

function ESP.add(player)
    if PlayerCache[player] then
        return
    end
    PlayerCache[player] = {
        Name = ESP.create("Text"),
        Weapon = ESP.create("Text"),
        BoxOutline = ESP.create("Square", true),
        Box = ESP.create("Square"),
        Distance = ESP.create("Text"),
        HealthOutline = ESP.create("Line", true),
        Health = ESP.create("Line"),
        HealthText = ESP.create("Text"),
        Arrow = ESP.create("Triangle")
    }
end

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        ESP.add(player)
    end
end

Players.PlayerAdded:Connect(ESP.add)

Players.PlayerRemoving:Connect(function(player)
    wait()
    if PlayerCache[player] then
        for _, drawing in pairs(PlayerCache[player]) do
            if drawing then
                drawing:Remove()
            end
        end
        PlayerCache[player] = nil
    end
end)

ESP.drawings.aimbot_fov = ESP.drawObject("Circle", {
    Visible = false,
    Radius = 90,
    Color = Color3.new(1, 1, 1),
    Filled = false
})

ESP.drawings.deadzone_fov = ESP.drawObject("Circle", {
    Visible = false,
    Radius = 50,
    Color = Color3.new(1, 0, 0),
    Filled = false
})

ESP.drawings.target_text = ESP.drawObject("Text", {
    Visible = false,
    Text = "",
    Size = 20,
    Font = 3,
    Center = true
})

function getRotate(vector, angle)
    local unit = vector.unit
    local sin = math.sin(angle)
    local cos = math.cos(angle)
    local x = cos * unit.X - sin * unit.Y
    local y = sin * unit.X + cos * unit.Y
    return Vector2.new(x, y).unit * vector.Magnitude
end

RunService.RenderStepped:Connect(function()
    ESP.drawings.aimbot_fov.Position = Options.legit_fov_position.Value == "center" and Camera.ViewportSize / 2 or UserInputService:GetMouseLocation()
    ESP.drawings.deadzone_fov.Position = ESP.drawings.aimbot_fov.Position
    ESP.drawings.aimbot_fov.Visible = Toggles.legit_enabled.Value and Toggles.legit_fov_render.Value
    ESP.drawings.deadzone_fov.Visible = Toggles.legit_enabled.Value and Toggles.legit_deadzone_render.Value
    ESP.drawings.aimbot_fov.Color = Options.fov_color.Value
    ESP.drawings.deadzone_fov.Color = Options.deadzone_color.Value
    ESP.drawings.aimbot_fov.Transparency = math.abs(1 - Options.fov_color.Transparency)
    ESP.drawings.deadzone_fov.Transparency = math.abs(1 - Options.deadzone_color.Transparency)
    ESP.drawings.aimbot_fov.Filled = Toggles.legit_fov_filled.Value
    ESP.drawings.aimbot_fov.Radius = Options.legit_aim_fov.Value
    ESP.drawings.deadzone_fov.Radius = Options.legit_deadzone_fov.Value
    
    if IsPlayerValid() and Toggles.legit_enabled.Value then
        Player = GetClosestPlayer()
        
        if Player ~= nil then
            ESP.drawings.target_text.Visible = Toggles.legit_target_text.Value
            ESP.drawings.target_text.Position = Camera.ViewportSize / 2 + Vector2.new(0, Options.legit_aim_fov.Value + 15)
            ESP.drawings.target_text.Text = Player.Name
            
            hitboxpart = GetHitboxPart(Player)
            
            if hitboxpart ~= nil then
                local screenPos, onScreen = Camera:WorldToScreenPoint(hitboxpart.Position)
                local offsetX = (Mouse.X - screenPos.X) / Options.legit_speed.Value + 1
                local offsetY = (Mouse.Y - screenPos.Y) / Options.legit_speed.Value + 1
                
                if not Toggles.legit_silent.Value and Options.legit_bind:GetState() then
                    mousemove(-offsetX, -offsetY)
                end
                
                if AimbotTarget.target ~= nil then
                    AimbotTarget.target = nil
                else
                    AimbotTarget.target = hitboxpart
                end
            else
                if AimbotTarget.target ~= nil then
                    AimbotTarget.target = nil
                end
            end
        else
            ESP.drawings.target_text.Text = ""
            if AimbotTarget.target ~= nil then
                AimbotTarget.target = nil
            end
        end
    end
    
    if Toggles.trigger_enabled.Value then
        if not Toggles.trigger_onkey.Value or Options.trigger_bind:GetState() then
            if Mouse.Target and Mouse.Target.Parent and Mouse.Target.Parent:FindFirstChildOfClass("Humanoid") then
                local targetPlayer = Players:GetPlayerFromCharacter(Mouse.Target.Parent)
                if not Toggles.trigger_team.Value or targetPlayer.Team ~= LocalPlayer.Team then
                    coroutine.wrap(function()
                        wait(Options.trigger_delay.Value / 1000)
                        mouse1press()
                        RunService.RenderStepped:Wait()
                        while Mouse.Target ~= nil and Players:GetPlayerFromCharacter(Mouse.Target.Parent) == targetPlayer do
                            RunService.RenderStepped:Wait()
                        end
                        mouse1release()
                    end)()
                end
            end
        end
    end
    
    if Toggles.move_speedhack.Value and Options.speed_bind:GetState() then
        local direction = Vector3.zero
        if UserInputService:IsKeyDown("W") then
            direction = direction + Camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown("S") then
            direction = direction - Camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown("A") then
            direction = direction - Camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown("D") then
            direction = direction + Camera.CFrame.RightVector
        end
        
        if direction.Magnitude > 0 then
            direction = Vector3.new(direction.X, 0, direction.Z)
            LocalPlayer.Character.HumanoidRootPart.Velocity = direction.Unit * Options.move_speed.Value * 1.3 + Vector3.new(0, LocalPlayer.Character.HumanoidRootPart.Velocity.Y, 0)
        end
    end
    
    if Toggles.move_noclip.Value and Options.noclip_bind:GetState() then
        local speed = Options.move_noclipspeed.Value
        local velocity = Vector3.new(0, 1, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            velocity = velocity + Camera.CoordinateFrame.lookVector * speed
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            velocity = velocity + Camera.CoordinateFrame.rightVector * -speed
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            velocity = velocity + Camera.CoordinateFrame.lookVector * -speed
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            velocity = velocity + Camera.CoordinateFrame.rightVector * speed
        end
        
        LocalPlayer.Character.HumanoidRootPart.Velocity = velocity
        LocalPlayer.Character.Humanoid.PlatformStand = true
        
        for _, part in pairs(LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") and part.CanCollide == true then
                part.CanCollide = false
            end
        end
    end
    
    if Toggles.move_edge.Value and Options.edge_bind:GetState() then
        if LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall or LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
            coroutine.wrap(function()
                RunService.RenderStepped:Wait()
                while LocalPlayer.Character ~= nil and LocalPlayer.Character:FindFirstChild("Humanoid") and (LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall or LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Jumping) do
                    RunService.RenderStepped:Wait()
                end
                LocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end)()
        end
    end
    
    if Toggles.effects_worldcolor.Value then
        Lighting.Ambient = Options.effects_brightness.Value == "fullbright" and Color3.new(1, 1, 1) or Options.ambient_color.Value
        Lighting.OutdoorAmbient = Options.effects_brightness.Value == "fullbright" and Color3.new(1, 1, 1) or Options.outdoorambient_color.Value
        
        if Options.effects_brightness.Value == "fullbright" then
            Lighting.Brightness = 2
        elseif Options.effects_brightness.Value == "night mode" then
            Lighting.Brightness = 0
        end
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        local cache = PlayerCache[player]
        
        if cache == nil or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            goto continue
        end
        
        if not (Toggles.esp_team.Value or LocalPlayer.Team ~= player.Team) then
            goto continue
        end
        
        if LocalPlayer == player then
            goto continue
        end
        
        if not player.Character:FindFirstChild("Humanoid") then
            goto continue
        end
        
        local rootPosition = player.Character.HumanoidRootPart.Position
        local screenPos, onScreen = Camera:WorldToViewportPoint(rootPosition)
        local topPos = Camera:WorldToViewportPoint(rootPosition - Vector3.new(0, 3, 0)).Y
        local bottomPos = Camera:WorldToViewportPoint(rootPosition + Vector3.new(0, 2.6, 0)).Y
        local boxHeight = (topPos - bottomPos) / 2
        local distance = math.round((Camera.CFrame.Position - rootPosition).Magnitude * 0.28)
        local font = tonumber(Options.esp_font.Value)
        local fontSize = Options.esp_fontsize.Value
        local flagSize = Options.esp_fontflagsize.Value
        
        cache.Box.Color = Options.box_color.Value
        cache.Box.Size = Vector2.new(boxHeight * 1.5, boxHeight * 1.9)
        cache.Box.Position = Vector2.new(screenPos.X - boxHeight * 1.5 / 2, screenPos.Y - boxHeight * 1.6 / 2)
        
        if Toggles.esp_box.Value then
            cache.Box.Visible = onScreen
            cache.BoxOutline.Size = cache.Box.Size
            cache.BoxOutline.Position = cache.Box.Position
            cache.BoxOutline.Visible = onScreen
        else
            cache.Box.Visible = false
            cache.BoxOutline.Visible = false
        end
        
        if Toggles.esp_healthbar.Value then
            cache.Health.Color = Options.health_color.Value
            cache.Health.From = Vector2.new(cache.Box.Position.X - 5, cache.Box.Position.Y + cache.Box.Size.Y)
            cache.Health.To = Vector2.new(cache.Health.From.X, cache.Health.From.Y - (player.Character.Humanoid.Health / player.Character.Humanoid.MaxHealth) * cache.Box.Size.Y)
            cache.Health.Visible = onScreen
            
            cache.HealthOutline.From = Vector2.new(cache.Health.From.X, cache.Box.Position.Y + cache.Box.Size.Y + 1)
            cache.HealthOutline.To = Vector2.new(cache.Health.From.X, cache.Health.From.Y - 1 * cache.Box.Size.Y - 1)
            cache.HealthOutline.Visible = onScreen
        else
            cache.Health.Visible = false
            cache.HealthOutline.Visible = false
        end
        
        if Toggles.esp_health.Value and Toggles.esp_healthbar.Value then
            if player.Character.Humanoid.Health ~= 0 and player.Character.Humanoid.Health < 100 then
                cache.HealthText.Color = Options.htext_color.Value
                cache.HealthText.Text = math.round(player.Character.Humanoid.Health)
                cache.HealthText.Position = Vector2.new(cache.Health.To.X - 10, cache.Health.To.Y)
                cache.HealthText.Font = font
                cache.HealthText.Outline = true
                cache.HealthText.Size = flagSize
                cache.HealthText.Visible = onScreen
            else
                cache.HealthText.Visible = false
            end
        end
        
        if Toggles.esp_weapon.Value then
            cache.Weapon.Color = Options.weapon_color.Value
            cache.Weapon.Text = tostring(GetEquippedTool(player.Character))
            cache.Weapon.Position = Vector2.new(cache.Box.Size.X / 2 + cache.Box.Position.X, cache.Box.Size.Y + cache.Box.Position.Y + 2)
            cache.Weapon.Font = 5
            cache.Weapon.Outline = true
            cache.Weapon.Size = fontSize
            cache.Weapon.Visible = onScreen
        else
            cache.Weapon.Visible = false
        end
        
        if Toggles.esp_name.Value then
            cache.Name.Color = Options.name_color.Value
            cache.Name.Text = player.Name
            cache.Name.Position = Vector2.new(cache.Box.Size.X / 2 + cache.Box.Position.X, cache.Box.Position.Y - 16)
            cache.Name.Font = font
            cache.Name.Outline = true
            cache.Name.Size = fontSize
            cache.Name.Visible = onScreen
        else
            cache.Name.Visible = false
        end
        
        if Toggles.esp_distance.Value then
            cache.Distance.Color = Options.distance_color.Value
            cache.Distance.Text = "[" .. distance .. "M]"
            cache.Distance.Position = Vector2.new(cache.Box.Size.X / 2 + cache.Box.Position.X, cache.Box.Size.Y + cache.Box.Position.Y + 2) + Vector2.new(0, Toggles.esp_weapon.Value and Options.esp_fontsize.Value or 0)
            cache.Distance.Font = font
            cache.Distance.Outline = true
            cache.Distance.Size = fontSize
            cache.Distance.Visible = onScreen
        else
            cache.Distance.Visible = false
        end
        
        if Toggles.esp_outoffov.Value then
            cache.Arrow.Visible = not onScreen
            
            local relativePos = Camera.CFrame:PointToObjectSpace(player.Character.HumanoidRootPart.Position)
            local angle = math.atan2(-relativePos.Y, relativePos.X)
            local direction = Vector2.new(math.cos(angle), math.sin(angle))
            local arrowPos = direction * Camera.ViewportSize * (Options.esp_arrowoffset.Value / 100) + Camera.ViewportSize / 2
            local scale = math.floor(Camera.ViewportSize.X / math.abs(256 - Options.esp_arrowsize.Value))
            
            cache.Arrow.PointA = arrowPos
            cache.Arrow.PointB = arrowPos - getRotate(direction, 0.5) * scale
            cache.Arrow.PointC = arrowPos - getRotate(direction, -0.5) * scale
            cache.Arrow.Color = Options.arrows_color.Value
            cache.Arrow.Transparency = Options.esp_arrows_transparency.Value == "pulse" and math.abs(math.sin(tick() * 0.8)) or math.abs(1 - Options.arrows_color.Transparency)
            cache.Arrow.Filled = Toggles.esp_arrowfilled.Value
        else
            cache.Arrow.Visible = false
        end
        
        if Toggles.esp_chams.Value then
            if not player.Character:FindFirstChildOfClass("Highlight") then
                local highlight = Instance.new("Highlight", player.Character)
                highlight.FillTransparency = Options.chams_color.Transparency
                highlight.OutlineTransparency = 1
            end
            
            player.Character.Highlight.FillColor = Options.chams_color.Value
            
            if Toggles.esp_chamsoutline.Value and Toggles.esp_chams.Value then
                player.Character.Highlight.OutlineTransparency = Options.ochams_color.Transparency
                player.Character.Highlight.OutlineColor = Options.ochams_color.Value
            else
                player.Character.Highlight.OutlineTransparency = 1
            end
        else
            if player.Character:FindFirstChildOfClass("Highlight") then
                player.Character:FindFirstChildOfClass("Highlight"):Destroy()
            end
        end
        
        ::continue::
        
        if player.Name == LocalPlayer.Name then
            for _, v in pairs(cache) do
                v.Visible = false
            end
        end
    end
end)

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}
    local self = args[1]
    
    if Toggles.legit_enabled.Value and self == workspace and not checkcaller() then
        if math.random(0, 100) <= Options.legit_hitchance.Value then
            if method == "FindPartOnRayWithIgnoreList" and Options.legit_silent_mode.Value:lower() == method:lower() then
                if ValidateArgs(args, RaycastValidation.FindPartOnRayWithIgnoreList) and AimbotTarget.target ~= nil then
                    local origin = args[2].Origin
                    local direction = GetDirection(origin, AimbotTarget.target.Position)
                    args[2] = Ray.new(origin, direction)
                    return oldNamecall(unpack(args))
                end
            elseif method == "FindPartOnRayWithWhitelist" and Options.legit_silent_mode.Value:lower() == method:lower() then
                if ValidateArgs(args, RaycastValidation.FindPartOnRayWithWhitelist) and AimbotTarget.target ~= nil then
                    local origin = args[2].Origin
                    local direction = GetDirection(origin, AimbotTarget.target.Position)
                    args[2] = Ray.new(origin, direction)
                    return oldNamecall(unpack(args))
                end
            elseif (method == "FindPartOnRay" or method == "findPartOnRay") and Options.legit_silent_mode.Value:lower() == method:lower() then
                if ValidateArgs(args, RaycastValidation.FindPartOnRay) and AimbotTarget.target ~= nil then
                    local origin = args[2].Origin
                    local direction = GetDirection(origin, AimbotTarget.target.Position)
                    args[2] = Ray.new(origin, direction)
                    return oldNamecall(unpack(args))
                end
            elseif method == "Raycast" and Options.legit_silent_mode.Value:lower() == method:lower() then
                if ValidateArgs(args, RaycastValidation.Raycast) and AimbotTarget.target then
                    args[3] = GetDirection(args[2], AimbotTarget.target.Position)
                    return oldNamecall(unpack(args))
                end
            end
        end
    end
    
    return oldNamecall(...)
end))

local oldIndex
oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, key)
    if self == Mouse and not checkcaller() and Toggles.legit_enabled.Value then
        if Options.legit_silent_mode.Value == "mouse.hit/target" and AimbotTarget.target ~= nil then
            if key == "Target" or key == "target" then
                return AimbotTarget.target
            elseif key == "Hit" or key == "hit" then
                return (Toggles.legit_prediction.Value and AimbotTarget.target.CFrame + AimbotTarget.target.Velocity * Options.legit_prediction_amount.Value or (Toggles.legit_prediction.Value and AimbotTarget.target.CFrame or false))
            elseif key == "X" or key == "x" then
                return self.X
            elseif key == "Y" or key == "y" then
                return self.Y
            elseif key == "UnitRay" then
                return Ray.new(self.Origin, (self.Hit - self.Origin).Unit)
            end
        end
    end
    
    return oldIndex(self, key)
end))
