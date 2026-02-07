-- ts file was generated at discord.gg/25ms

local _Lighting = game:GetService('Lighting')
local _RunService = game:GetService('RunService')

game:GetService('StarterGui')

local _HttpService = game:GetService('HttpService')
local _TeleportService = game:GetService('TeleportService')
local _UserInputService = game:GetService('UserInputService')

game:GetService('ReplicatedStorage')

local _Folder = Instance.new('Folder', workspace)

_Folder.Name = _HttpService:GenerateGUID()

local _Players = game.Players
local _LocalPlayer = _Players.LocalPlayer
local u9 = _LocalPlayer:GetMouse()
local _CurrentCamera = workspace.CurrentCamera
local u11 = {drawings = {}}
local u12 = {}
local u13 = {
    head = {
        'Head',
    },
    chest = {
        'UpperTorso',
        'LowerTorso',
    },
    arms = {
        'LeftUpperArm',
        'LeftLowerArm',
        'LeftHand',
        'RightUpperArm',
        'RightLowerArm',
        'RightHand',
    },
    legs = {
        'LeftUpperLeg',
        'LeftLowerLeg',
        'LeftFoot',
        'RightUpperLeg',
        'RightLowerLeg',
        'RightFoot',
    },
}
local u14 = {
    FindPartOnRayWithIgnoreList = {
        ArgCountRequired = 3,
        Args = {
            'Instance',
            'Ray',
            'table',
            'boolean',
            'boolean',
        },
    },
    FindPartOnRayWithWhitelist = {
        ArgCountRequired = 3,
        Args = {
            'Instance',
            'Ray',
            'table',
            'boolean',
        },
    },
    FindPartOnRay = {
        ArgCountRequired = 2,
        Args = {
            'Instance',
            'Ray',
            'Instance',
            'boolean',
            'boolean',
        },
    },
    Raycast = {
        ArgCountRequired = 3,
        Args = {
            'Instance',
            'Vector3',
            'Vector3',
            'RaycastParams',
        },
    },
}

if not _Lighting:FindFirstChild('Atmosphere') then
    Instance.new('Atmosphere', _Lighting)
end

local u15 = {target = nil}
local u16 = mousemove or mousemoverel or (mouse_move or false)

if u16 == false then
    return _LocalPlayer:Kick('Exploit not supported! Missing: mousemove.')
end

local function u19(p17, p18)
    return #_CurrentCamera:GetPartsObscuringTarget({
        _LocalPlayer.Character.Head.Position,
        p17,
    }, p18) == 0 and true or false
end
local function u26(p20, p21)
    local v22 = 0

    if #p20 < p21.ArgCountRequired then
        return false
    end

    local v23 = next
    local v24 = nil

    while true do
        local v25

        v24, v25 = v23(p20, v24)

        if v24 == nil then
            break
        end
        if typeof(v25) == p21.Args[v24] then
            v22 = v22 + 1
        end
    end

    return p21.ArgCountRequired <= v22
end
local function u29(p27, p28)
    return (p28 - p27).Unit * 1000
end
local function u31(p30)
    if p30 == nil then
        p30 = _LocalPlayer
    end

    return p30 and (p30.Character and (p30.Character.FindFirstChild(p30.Character, 'Humanoid') and p30.Character.Humanoid.Health > 0)) and true or false
end
local function u37(p32)
    local v33, v34, v35 = pairs(p32:GetChildren())

    while true do
        local v36

        v35, v36 = v33(v34, v35)

        if v35 == nil then
            break
        end
        if v36.ClassName == 'Tool' then
            return tostring(v36.Name)
        end
    end

    return 'NONE'
end

local v38 = 'https://raw.githubusercontent.com/fliskScript/jaran/refs/heads/main/other/'
local u39 = loadstring(game:HttpGet(v38 .. 'Library'))()

loadstring(game:HttpGet(v38 .. 'Themes'))()

local v40 = loadstring(game:HttpGet(v38 .. 'SaveManager'))()
local v41 = u39
local v42 = u39.CreateWindow(v41, {
    Title = 't.me/jaran<font color="#C090E2">vip</font> | free | role: user',
    Center = true,
    AutoShow = true,
    Size = UDim2.fromOffset(550, 500),
    TabPadding = 8,
    MenuFadeTime = 0.2,
})
local v43 = {
    legit = v42:AddTab('legitbot'),
    esp = v42:AddTab('visuals'),
    misc = v42:AddTab('misc'),
    ['UI Settings'] = v42:AddTab('menu'),
}
local _aimbot = v43.legit:AddLeftGroupbox('aimbot')

_aimbot:AddToggle('legit_enabled', {
    Text = 'enabled',
})
_aimbot:AddToggle('legit_team', {
    Text = 'teammates',
})
_aimbot:AddLabel('activation type'):AddKeyPicker('legit_bind', {
    Default = 'MB1',
    Mode = 'Hold',
    NoUI = true,
    Text = 'legitbot',
})
_aimbot:AddDropdown('legit_hitbox', {
    Text = 'target hitbox',
    Default = 1,
    Multi = true,
    Values = {
        'head',
        'chest',
        'arms',
        'legs',
    },
})
_aimbot:AddDropdown('legit_target_priority', {
    Text = 'target priority',
    Default = 1,
    Values = {
        'closest to crosshair',
        'distance',
    },
})
_aimbot:AddSlider('legit_speed', {
    Text = 'smoothness',
    Default = 8,
    Min = 1,
    Max = 30,
    Rounding = 0,
})
_aimbot:AddSlider('legit_aim_fov', {
    Text = 'maximum fov',
    Default = 90,
    Min = 0,
    Max = 180,
    Suffix = '\u{fffd}',
    Rounding = 0,
})
_aimbot:AddSlider('legit_deadzone_fov', {
    Text = 'deadzone fov',
    Default = 50,
    Min = 0,
    Max = 140,
    Rounding = 0,
})
_aimbot:AddToggle('legit_walls', {
    Text = 'aim through walls',
})
_aimbot:AddToggle('legit_forcefield', {
    Text = 'aim on forcefield',
})
_aimbot:AddDivider()
_aimbot:AddLabel('silent aim')
_aimbot:AddToggle('legit_silent', {
    Text = 'enabled',
})
_aimbot:AddSlider('legit_hitchance', {
    Text = 'hitchance',
    Default = 100,
    Min = 0,
    Max = 100,
    Suffix = '%',
    Rounding = 0,
})
_aimbot:AddDropdown('legit_silent_mode', {
    Text = 'method',
    Default = 1,
    Values = {
        'raycast',
        'findpartonray',
        'findpartonraywithwhitelist',
        'findpartonraywithignorelist',
        'mouse.hit/target',
    },
})
_aimbot:AddToggle('legit_prediction', {
    Text = 'prediction (mouse.hit/target)',
})
_aimbot:AddSlider('legit_prediction_amount', {
    Text = 'prediction amount',
    Default = 100,
    Min = 0,
    Max = 100,
    Suffix = '%',
    Rounding = 0,
})

local _triggerbot = v43.legit:AddRightGroupbox('triggerbot')

_triggerbot:AddToggle('trigger_enabled', {
    Text = 'enabled',
})
_triggerbot:AddToggle('trigger_team', {
    Text = 'teammates',
})
_triggerbot:AddToggle('trigger_onkey', {
    Text = 'on keybind',
})
_triggerbot:AddLabel('activation type'):AddKeyPicker('trigger_bind', {
    Default = 'E',
    Mode = 'Hold',
    NoUI = true,
    Text = 'triggerbot',
})
_triggerbot:AddSlider('trigger_delay', {
    Text = 'delay',
    Default = 0,
    Min = 0,
    Max = 1000,
    Suffix = 'ms',
    Rounding = 0,
})

local _renders = v43.legit:AddRightGroupbox('renders')

_renders:AddDropdown('legit_fov_position', {
    Text = 'circle position',
    Default = 1,
    Values = {
        'center',
        'mouse',
    },
})
_renders:AddToggle('legit_fov_render', {
    Text = 'aimbot fov render',
}):AddColorPicker('fov_color', {
    Default = Color3.new(1, 1, 1),
    Transparency = 0,
})
_renders:AddToggle('legit_deadzone_render', {
    Text = 'deadzone fov render',
}):AddColorPicker('deadzone_color', {
    Default = Color3.new(1, 0, 0),
    Transparency = 0,
})
_renders:AddToggle('legit_fov_filled', {
    Text = 'aimbot fov filled',
})
_renders:AddToggle('legit_target_text', {
    Text = 'target name render',
})

local _players = v43.esp:AddLeftGroupbox('players')

_players:AddToggle('esp_team', {
    Text = 'teammates',
})
_players:AddToggle('esp_box', {
    Text = 'bounding box',
}):AddColorPicker('box_color', {
    Default = Color3.new(1, 1, 1),
})
_players:AddToggle('esp_healthbar', {
    Text = 'healthbar',
}):AddColorPicker('health_color', {
    Default = Color3.fromRGB(172, 223, 126),
})

local v48 = _players:AddDependencyBox()

v48:SetupDependencies({
    {
        Toggles.esp_healthbar,
        true,
    },
})
v48:AddToggle('esp_health', {
    Text = 'health text',
}):AddColorPicker('htext_color', {
    Default = Color3.fromRGB(172, 223, 126),
})
_players:AddToggle('esp_name', {
    Text = 'name',
}):AddColorPicker('name_color', {
    Default = Color3.new(1, 1, 1),
})
_players:AddToggle('esp_weapon', {
    Text = 'weapon',
}):AddColorPicker('weapon_color', {
    Default = Color3.new(1, 1, 1),
})
_players:AddToggle('esp_distance', {
    Text = 'distance',
}):AddColorPicker('distance_color', {
    Default = Color3.new(1, 1, 1),
})
_players:AddToggle('esp_outoffov', {
    Text = 'out of fov',
}):AddColorPicker('arrows_color', {
    Default = Color3.new(1, 1, 1),
    Transparency = 0,
})

local v49 = _players:AddDependencyBox()

v49:SetupDependencies({
    {
        Toggles.esp_outoffov,
        true,
    },
})
v49:AddToggle('esp_arrowfilled', {
    Text = 'arrows filled',
    Default = true,
})
v49:AddDropdown('esp_arrows_transparency', {
    Text = 'transparency mode',
    Default = 1,
    Values = {
        'static',
        'pulse',
    },
})
v49:AddSlider('esp_arrowsize', {
    Text = 'arrows size',
    Default = 64,
    Min = 40,
    Max = 200,
    Rounding = 0,
})
v49:AddSlider('esp_arrowoffset', {
    Text = 'arrows offset',
    Default = 10,
    Min = 1,
    Max = 30,
    Rounding = 0,
})
_players:AddToggle('esp_chams', {
    Text = 'chams',
}):AddColorPicker('chams_color', {
    Default = Color3.fromRGB(166, 255, 0),
    Transparency = 0.3,
})

local v50 = _players:AddDependencyBox()

v50:SetupDependencies({
    {
        Toggles.esp_chams,
        true,
    },
})
v50:AddToggle('esp_chamsoutline', {
    Text = 'chams outline',
}):AddColorPicker('ochams_color', {
    Default = Color3.fromRGB(245, 129, 204),
    Transparency = 0.6,
})
_players:AddDropdown('esp_font', {
    Text = 'font',
    Default = 1,
    Values = {
        '1',
        '2',
        '3',
    },
})
_players:AddSlider('esp_fontsize', {
    Text = 'font size',
    Default = 11,
    Min = 7,
    Max = 20,
    Rounding = 0,
})
_players:AddSlider('esp_fontflagsize', {
    Text = 'font flags size',
    Default = 10,
    Min = 7,
    Max = 20,
    Rounding = 0,
})

local _world = v43.esp:AddRightGroupbox('world')

_world:AddToggle('effects_worldcolor', {
    Text = 'world gradient',
}):AddColorPicker('ambient_color', {
    Default = _Lighting.Ambient,
    Title = 'ambient',
}):AddColorPicker('outdoorambient_color', {
    Default = _Lighting.OutdoorAmbient,
    Title = 'outdoor ambient',
})
_world:AddDropdown('effects_brightness', {
    Text = 'brightness adjustment',
    Default = 1,
    Values = {
        '-',
        'fullbright',
        'night mode',
    },
})
_world:AddSlider('effects_haze', {
    Text = 'haze',
    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 0,
    Callback = function(p52)
        _Lighting.Atmosphere.Haze = p52
    end,
})
_world:AddLabel('haze color'):AddColorPicker('haze_color', {
    Default = _Lighting.Atmosphere.Color,
    Title = 'haze',
    Callback = function(p53)
        _Lighting.Atmosphere.Color = p53
    end,
})
_world:AddSlider('effects_glare', {
    Text = 'glare',
    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 0,
    Callback = function(p54)
        _Lighting.Atmosphere.Glare = p54
    end,
})
_world:AddLabel('decay color'):AddColorPicker('haze_color', {
    Default = _Lighting.Atmosphere.Color,
    Title = 'haze',
    Callback = function(p55)
        _Lighting.Atmosphere.Decay = p55
    end,
})
_world:AddSlider('effects_fog', {
    Text = 'fog',
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(p56)
        _Lighting.Atmosphere.Density = p56
    end,
})
_world:AddSlider('effects_fog_visible', {
    Text = 'fog visible',
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(p57)
        _Lighting.Atmosphere.Offset = p57
    end,
})
_world:AddSlider('effects_exposure', {
    Text = 'exposure',
    Default = _Lighting.ExposureCompensation,
    Min = 0,
    Max = 5,
    Rounding = 0,
    Callback = function(p58)
        _Lighting.ExposureCompensation = p58
    end,
})

local _server = v43.misc:AddLeftGroupbox('server')

_server:AddButton({
    Text = 'copy place id',
    Func = function()
        setclipboard(game.PlaceId)
    end,
})
_server:AddButton({
    Text = 'copy job id',
    Func = function()
        setclipboard(game.JobId)
    end,
})
_server:AddButton({
    Text = 'rejoin to the server',
    Func = function()
        _TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, _LocalPlayer)
    end,
})

local _game = v43.misc:AddLeftGroupbox('game')

_game:AddSlider('fps_cap', {
    Text = 'fps cap',
    Default = 144,
    Min = 20,
    Max = 600,
    Rounding = 0,
    Callback = function(p61)
        setfpscap(p61)
    end,
})
_game:AddToggle('misc_fovtoggle', {
    Text = 'fov changer',
})
_game:AddSlider('misc_fov', {
    Text = '',
    Default = 70,
    Min = 70,
    Max = 120,
    Rounding = 0,
    Callback = function(p62)
        if _LocalPlayer.Character ~= nil then
            if Toggles.misc_fovtoggle.Value then
                _CurrentCamera.FieldOfView = p62
            end
        end
    end,
})
_CurrentCamera:GetPropertyChangedSignal('FieldOfView'):Connect(function(p63)
    if _LocalPlayer.Character ~= nil then
        if p63 ~= Options.misc_fov.Value then
            if Toggles.misc_fovtoggle.Value then
                _CurrentCamera.FieldOfView = Options.misc_fov.Value
            end
        end
    else
        return
    end
end)

local _movement = v43.misc:AddRightGroupbox('movement')

_movement:AddToggle('move_speedhack', {
    Text = 'speedhack',
}):AddKeyPicker('speed_bind', {
    Default = 'O',
    Mode = 'Toggle',
    Text = 'speedhack',
})
_movement:AddSlider('move_speed', {
    Text = 'speed',
    Default = 60,
    Min = 15,
    Max = 300,
    Suffix = ' studs/s',
    Rounding = 0,
})
_movement:AddToggle('move_noclip', {
    Text = 'noclip',
}):AddKeyPicker('noclip_bind', {
    Default = 'L',
    Mode = 'Toggle',
    Text = 'noclip',
})
_movement:AddSlider('move_noclipspeed', {
    Text = 'speed',
    Default = 80,
    Min = 0,
    Max = 300,
    Rounding = 0,
})
_movement:AddToggle('move_autojump', {
    Text = 'auto jump',
})
_movement:AddToggle('move_edge', {
    Text = 'jump at edge',
}):AddKeyPicker('edge_bind', {
    Default = 'Z',
    Mode = 'Hold',
    Text = 'jump at edje',
})

local v65 = u39

u39.OnUnload(v65, function()
    u39.Unloaded = true
end)

local _menu = v43['UI Settings']:AddRightGroupbox('menu')

_menu:AddToggle('show_keybinds', {
    Text = 'show keybinds',
    Callback = function(p67)
        u39.KeybindFrame.Visible = p67
    end,
})
_menu:AddButton('unload', function()
    u39:Unload()
end)
_menu:AddLabel('menu bind'):AddKeyPicker('MenuKeybind', {
    Default = 'Insert',
    NoUI = true,
    Text = 'menu keybind',
})

u39.ToggleKeybind = Options.MenuKeybind

v40:SetLibrary(u39)
v40:IgnoreThemeSettings()
v40:SetIgnoreIndexes({
    'MenuKeybind',
})
v40:SetFolder('jaran/cfgs')
v40:BuildConfigSection(v43['UI Settings'])
v40:LoadAutoloadConfig()

local function u80()
    local _huge = math.huge
    local v69 = _Players
    local v70, v71, v72 = pairs(v69:GetPlayers())
    local v73 = nil

    while true do
        local v74

        v72, v74 = v70(v71, v72)

        if v72 == nil then
            break
        end
        if u31(v74) and v74 ~= _LocalPlayer and (Toggles.legit_forcefield.Value or not v74.Character:FindFirstChild('ForceField')) and ((Toggles.legit_team.Value or v74.Team ~= _LocalPlayer.Team) and (Toggles.legit_walls.Value or u19(v74.Character.Head.Position, {
            v74.Character,
            _LocalPlayer.Character,
            _Folder,
            _CurrentCamera,
        }) == true)) then
            local v75, _ = _CurrentCamera:WorldToScreenPoint(v74.Character.HumanoidRootPart.Position)
            local _magnitude = (Vector2.new(u9.X, u9.Y) - Vector2.new(v75.X, v75.Y)).magnitude

            if _magnitude <= Options.legit_aim_fov.Value and Options.legit_deadzone_fov.Value <= _magnitude or Options.legit_aim_fov.Value == 0 then
                if Options.legit_target_priority.Value ~= 'closest to crosshair' then
                    if Options.legit_target_priority.Value == 'distance' then
                        local v77 = math.floor((v74.Character.HumanoidRootPart.Position - _LocalPlayer.Character.HumanoidRootPart.Position).magnitude)

                        if v77 < _huge then
                            v73 = v74
                            _huge = v77
                        end
                    end
                else
                    local v78, _ = _CurrentCamera:WorldToScreenPoint(v74.Character.HumanoidRootPart.Position)
                    local _magnitude2 = (Vector2.new(u9.X, u9.Y) - Vector2.new(v78.X, v78.Y)).magnitude

                    if _magnitude2 < _huge then
                        v73 = v74
                        _huge = _magnitude2
                    end
                end
            end
        end
    end

    if v73 ~= nil then
        return v73
    end
end

function u11.drawObject(_, p81, p82)
    local v83 = Drawing.new(p81)

    if p82 then
        local v84 = next
        local v85 = nil

        while true do
            local v86

            v85, v86 = v84(p82, v85)

            if v85 == nil then
                break
            end

            v83[v85] = v86
        end
    end

    return v83
end

u11.default = {
    Line = {
        Thickness = 1.5,
        Color = Color3.fromRGB(255, 255, 255),
        Visible = false,
    },
    Text = {
        Size = 13,
        Center = true,
        Outline = true,
        Font = Drawing.Fonts.Plex,
        Color = Color3.fromRGB(255, 255, 255),
        Visible = false,
    },
    Square = {
        Thickness = 1,
        Filled = false,
        Color = Color3.fromRGB(255, 255, 255),
        Visible = false,
    },
    Triangle = {
        Thickness = 2,
        Filled = false,
        Visible = false,
        Color = Color3.fromRGB(255, 255, 255),
    },
}

function u11.create(p87, p88, p89)
    local v90 = Drawing.new(p87)
    local v91, v92, v93 = pairs(u11.default[p87])

    while true do
        local v94

        v93, v94 = v91(v92, v93)

        if v93 == nil then
            break
        end

        v90[v93] = v94
        v90.ZIndex = 2
    end

    if p88 then
        v90.ZIndex = 1
        v90.Color = Color3.new(0, 0, 0)
        v90.Thickness = 2
    end
    if p89 then
        v90.Data = game:HttpGet('https://raw.githubusercontent.com/portallol/luna/main/Gradient180.png')
    end

    return v90
end
function u11.add(p95)
    if not u12[p95] then
        u12[p95] = {
            Name = u11.create('Text'),
            Weapon = u11.create('Text'),
            BoxOutline = u11.create('Square', true),
            Box = u11.create('Square'),
            Distance = u11.create('Text'),
            HealthOutline = u11.create('Line', true),
            Health = u11.create('Line'),
            HealthText = u11.create('Text'),
            Arrow = u11.create('Triangle'),
        }
    end
end

local v96, v97, v98 = pairs(_Players:GetPlayers())
local u99 = u31

local function u113(p100)
    local _huge2 = math.huge
    local v102, v103, v104 = pairs(Options.legit_hitbox.Value)
    local v105 = nil

    while true do
        local v106

        v104, v106 = v102(v103, v104)

        if v104 == nil then
            break
        end

        local v107, v108, v109 = pairs(u13[v104])

        while true do
            local v110

            v109, v110 = v107(v108, v109)

            if v109 == nil then
                break
            end

            targetpart = p100.Character:FindFirstChild(v110)

            if targetpart ~= nil then
                local v111, _ = _CurrentCamera:WorldToScreenPoint(targetpart.Position)
                local _magnitude3 = (Vector2.new(u9.X, u9.Y) - Vector2.new(v111.X, v111.Y)).magnitude

                if _magnitude3 < _huge2 then
                    v105 = targetpart
                    _huge2 = _magnitude3
                end
            end
        end
    end

    if v105 ~= nil then
        return v105
    end
end

while true do
    local v114

    v98, v114 = v96(v97, v98)

    if v98 == nil then
        break
    end
    if Player ~= _LocalPlayer then
        u11.add(v114)
    end
end

_Players.PlayerAdded:Connect(u11.add)
_Players.PlayerRemoving:Connect(function(p115)
    wait()

    if u12[p115] then
        local v116, v117, v118 = pairs(u12[p115])

        while true do
            local v119

            v118, v119 = v116(v117, v118)

            if v118 == nil then
                break
            end
            if v119 then
                v119:Remove()
            end
        end

        u12[p115] = nil
    end
end)

u11.drawings.aimbot_fov = u11:drawObject('Circle', {
    Visible = false,
    Radius = 90,
    Color = Color3.new(1, 1, 1),
    Filled = false,
})
u11.drawings.deadzone_fov = u11:drawObject('Circle', {
    Visible = false,
    Radius = 50,
    Color = Color3.new(1, 0, 0),
    Filled = false,
})
u11.drawings.target_text = u11:drawObject('Text', {
    Visible = false,
    Text = '',
    Size = 20,
    Font = 3,
    Center = true,
})

function getRotate(p120, p121)
    local _unit = p120.unit
    local v123 = math.sin(p121)
    local v124 = math.cos(p121)
    local v125 = v124 * _unit.X - v123 * _unit.Y
    local v126 = v123 * _unit.X + v124 * _unit.Y

    return Vector2.new(v125, v126).unit * p120.Magnitude
end

_RunService.RenderStepped:Connect(function(_)
    u11.drawings.aimbot_fov.Position = Options.legit_fov_position.Value == 'center' and _CurrentCamera.ViewportSize / 2 or _UserInputService:GetMouseLocation()
    u11.drawings.deadzone_fov.Position = u11.drawings.aimbot_fov.Position

    local _aimbot_fov = u11.drawings.aimbot_fov
    local _Value = Toggles.legit_enabled.Value

    if _Value then
        _Value = Toggles.legit_fov_render.Value
    end

    _aimbot_fov.Visible = _Value

    local _deadzone_fov = u11.drawings.deadzone_fov
    local _Value2 = Toggles.legit_enabled.Value

    if _Value2 then
        _Value2 = Toggles.legit_deadzone_render.Value
    end

    _deadzone_fov.Visible = _Value2
    u11.drawings.aimbot_fov.Color = Options.fov_color.Value
    u11.drawings.deadzone_fov.Color = Options.deadzone_color.Value
    u11.drawings.aimbot_fov.Transparency = math.abs(1 - Options.fov_color.Transparency)
    u11.drawings.deadzone_fov.Transparency = math.abs(1 - Options.deadzone_color.Transparency)
    u11.drawings.aimbot_fov.Filled = Toggles.legit_fov_filled.Value
    u11.drawings.aimbot_fov.Radius = Options.legit_aim_fov.Value
    u11.drawings.deadzone_fov.Radius = Options.legit_deadzone_fov.Value

    if u99() then
        if Toggles.legit_enabled.Value then
            Player = u80()

            if Player == nil then
                u11.drawings.target_text.Text = ''

                if u15.target ~= nil then
                    u15.target = nil
                end
            else
                u11.drawings.target_text.Visible = Toggles.legit_target_text.Value
                u11.drawings.target_text.Position = _CurrentCamera.ViewportSize / 2 + Vector2.new(0, Options.legit_aim_fov.Value + 15)
                u11.drawings.target_text.Text = Player.Name
                hitboxpart = u113(Player)

                if hitboxpart == nil then
                    if u15.target ~= nil then
                        u15.target = nil
                    end
                else
                    local v131, _ = _CurrentCamera:WorldToScreenPoint(hitboxpart.Position)
                    local v132 = (u9.X - v131.X) / Options.legit_speed.Value + 1
                    local v133 = (u9.Y - v131.Y) / Options.legit_speed.Value + 1

                    if Toggles.legit_silent.Value then
                        u15.target = hitboxpart
                    else
                        if Options.legit_bind:GetState() then
                            u16(-v132, -v133)
                        end
                        if u15.target ~= nil then
                            u15.target = nil
                        end
                    end
                end
            end
        end
        if Toggles.trigger_enabled.Value and (not Toggles.trigger_onkey.Value or Options.trigger_bind:GetState()) and (u9.Target and u9.Target.Parent and u9.Target.Parent:FindFirstChildOfClass('Humanoid')) then
            local u134 = _Players:GetPlayerFromCharacter(u9.Target.Parent)

            if Toggles.trigger_team.Value or u134.Team ~= _LocalPlayer.Team then
                coroutine.wrap(function()
                    wait(Options.trigger_delay.Value / 1000)
                    mouse1press()

                    repeat
                        _RunService.RenderStepped:Wait()
                    until u9.Target == nil or u134 ~= _Players:GetPlayerFromCharacter(u9.Target.Parent)

                    mouse1release()
                end)()
            end
        end
        if Toggles.move_speedhack.Value and Options.speed_bind:GetState() then
            local _zero = Vector3.zero

            if _UserInputService:IsKeyDown('W') then
                _zero = _zero + _CurrentCamera.CFrame.LookVector
            end
            if _UserInputService:IsKeyDown('S') then
                _zero = _zero - _CurrentCamera.CFrame.LookVector
            end
            if _UserInputService:IsKeyDown('A') then
                _zero = _zero - _CurrentCamera.CFrame.RightVector
            end
            if _UserInputService:IsKeyDown('D') then
                _zero = _zero + _CurrentCamera.CFrame.RightVector
            end
            if _zero.Magnitude > 0 then
                local v136 = Vector3.new(_zero.X, 0, _zero.Z)

                _LocalPlayer.Character.HumanoidRootPart.Velocity = v136.Unit * (Options.move_speed.Value * 1.3) + Vector3.new(0, _LocalPlayer.Character.HumanoidRootPart.Velocity.Y, 0)
            end
        end
        if Toggles.move_noclip.Value and Options.noclip_bind:GetState() then
            local _Value3 = Options.move_noclipspeed.Value
            local v138 = Vector3.new(0, 1, 0)

            if _UserInputService:IsKeyDown(Enum.KeyCode.W) then
                v138 = v138 + _CurrentCamera.CoordinateFrame.lookVector * _Value3
            end
            if _UserInputService:IsKeyDown(Enum.KeyCode.A) then
                v138 = v138 + _CurrentCamera.CoordinateFrame.rightVector * -_Value3
            end
            if _UserInputService:IsKeyDown(Enum.KeyCode.S) then
                v138 = v138 + _CurrentCamera.CoordinateFrame.lookVector * -_Value3
            end
            if _UserInputService:IsKeyDown(Enum.KeyCode.D) then
                v138 = v138 + _CurrentCamera.CoordinateFrame.rightVector * _Value3
            end

            _LocalPlayer.Character.HumanoidRootPart.Velocity = v138
            _LocalPlayer.Character.Humanoid.PlatformStand = true

            local v139, v140, v141 = pairs(_LocalPlayer.Character:GetChildren())

            while true do
                local v142

                v141, v142 = v139(v140, v141)

                if v141 == nil then
                    break
                end
                if v142:IsA('BasePart') and v142.CanCollide == true then
                    v142.CanCollide = false
                end
            end
        end
        if Toggles.move_edge.Value and (Options.edge_bind:GetState() and (_LocalPlayer.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall and _LocalPlayer.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Jumping)) then
            coroutine.wrap(function()
                _RunService.RenderStepped:Wait()

                if _LocalPlayer.Character ~= nil and (_LocalPlayer.Character:FindFirstChild('Humanoid') and (_LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall and _LocalPlayer.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Jumping)) then
                    _LocalPlayer.Character.Humanoid:ChangeState('Jumping')
                end
            end)()
        end
    end
    if Toggles.effects_worldcolor.Value then
        _Lighting.Ambient = Options.effects_brightness.Value == 'fullbright' and Color3.new(1, 1, 1) or Options.ambient_color.Value
        _Lighting.OutdoorAmbient = Options.effects_brightness.Value == 'fullbright' and Color3.new(1, 1, 1) or Options.outdoorambient_color.Value
    end
    if Options.effects_brightness.Value ~= 'fullbright' then
        if Options.effects_brightness.Value == 'night mode' then
            _Lighting.Brightness = 0
        end
    else
        _Lighting.Brightness = 2
    end

    local v143 = _Players
    local v144, v145, v146 = pairs(v143:GetPlayers())

    while true do
        local v147

        v146, v147 = v144(v145, v146)

        if v146 == nil then
            break
        end

        local v148 = u12[v147]

        if v148 == nil then
            return
        end
        if v147.Character and (v147.Character:FindFirstChild('HumanoidRootPart') and (Toggles.esp_team.Value or _LocalPlayer.Team ~= v147.Team) and _LocalPlayer ~= v147 and v147.Character:FindFirstChild('Humanoid')) then
            local _Position = v147.Character.HumanoidRootPart.Position
            local v150, v151 = _CurrentCamera:WorldToViewportPoint(_Position)
            local v152 = _CurrentCamera
            local v153 = (_CurrentCamera:WorldToViewportPoint(_Position - Vector3.new(0, 3, 0)).Y - v152:WorldToViewportPoint(_Position + Vector3.new(0, 2.6, 0)).Y) / 2
            local v154 = math.round((_CurrentCamera.CFrame.Position - _Position).Magnitude * 0.28)
            local v155 = tonumber(Options.esp_font.Value)
            local _Value4 = Options.esp_fontsize.Value
            local _Value5 = Options.esp_fontflagsize.Value

            v148.Box.Color = Options.box_color.Value
            v148.Box.Size = Vector2.new(v153 * 1.5, v153 * 1.9)
            v148.Box.Position = Vector2.new(v150.X - v153 * 1.5 / 2, v150.Y - v153 * 1.6 / 2)

            if Toggles.esp_box.Value then
                v148.Box.Visible = v151
                v148.BoxOutline.Size = v148.Box.Size
                v148.BoxOutline.Position = v148.Box.Position
                v148.BoxOutline.Visible = v151
            else
                v148.Box.Visible = false
                v148.BoxOutline.Visible = false
            end
            if Toggles.esp_healthbar.Value then
                v148.Health.Color = Options.health_color.Value
                v148.Health.From = Vector2.new(v148.Box.Position.X - 5, v148.Box.Position.Y + v148.Box.Size.Y)
                v148.Health.To = Vector2.new(v148.Health.From.X, v148.Health.From.Y - v147.Character.Humanoid.Health / v147.Character.Humanoid.MaxHealth * v148.Box.Size.Y)
                v148.Health.Visible = v151
                v148.HealthOutline.From = Vector2.new(v148.Health.From.X, v148.Box.Position.Y + v148.Box.Size.Y + 1)
                v148.HealthOutline.To = Vector2.new(v148.Health.From.X, v148.Health.From.Y - 1 * v148.Box.Size.Y - 1)
                v148.HealthOutline.Visible = v151
            else
                v148.Health.Visible = false
                v148.HealthOutline.Visible = false
            end
            if Toggles.esp_health.Value and (Toggles.esp_healthbar.Value and (v147.Character.Humanoid.Health ~= 0 and v147.Character.Humanoid.Health < 100)) then
                v148.HealthText.Color = Options.htext_color.Value
                v148.HealthText.Text = math.round(v147.Character.Humanoid.Health)
                v148.HealthText.Position = Vector2.new(v148.Health.To.X - 10, v148.Health.To.Y)
                v148.HealthText.Font = v155
                v148.HealthText.Outline = true
                v148.HealthText.Size = _Value5
                v148.HealthText.Visible = v151
            else
                v148.HealthText.Visible = false
            end
            if Toggles.esp_weapon.Value then
                v148.Weapon.Color = Options.weapon_color.Value
                v148.Weapon.Text = tostring(u37(v147.Character))
                v148.Weapon.Position = Vector2.new(v148.Box.Size.X / 2 + v148.Box.Position.X, v148.Box.Size.Y + v148.Box.Position.Y + 2)
                v148.Weapon.Font = 5
                v148.Weapon.Outline = true
                v148.Weapon.Size = _Value4
                v148.Weapon.Visible = v151
            else
                v148.Weapon.Visible = false
            end
            if Toggles.esp_name.Value then
                v148.Name.Color = Options.name_color.Value
                v148.Name.Text = v147.Name
                v148.Name.Position = Vector2.new(v148.Box.Size.X / 2 + v148.Box.Position.X, v148.Box.Position.Y - 16)
                v148.Name.Font = v155
                v148.Name.Outline = true
                v148.Name.Size = _Value4
                v148.Name.Visible = v151
            else
                v148.Name.Visible = false
            end
            if Toggles.esp_distance.Value then
                v148.Distance.Color = Options.distance_color.Value
                v148.Distance.Text = '[' .. v154 .. 'M]'
                v148.Distance.Position = Vector2.new(v148.Box.Size.X / 2 + v148.Box.Position.X, v148.Box.Size.Y + v148.Box.Position.Y + 2) + Vector2.new(0, Toggles.esp_weapon.Value and Options.esp_fontsize.Value or 0)
                v148.Distance.Font = v155
                v148.Distance.Outline = true
                v148.Distance.Size = _Value4
                v148.Distance.Visible = v151
            else
                v148.Distance.Visible = false
            end
            if Toggles.esp_outoffov.Value then
                v148.Arrow.Visible = not v151

                local v158 = _CurrentCamera.CFrame:PointToObjectSpace(v147.Character.HumanoidRootPart.Position)
                local v159 = math.atan2(-v158.Y, v158.X)
                local v160 = Vector2.new(math.cos(v159), math.sin(v159))
                local v161 = v160 * _CurrentCamera.ViewportSize * (Options.esp_arrowoffset.Value / 100) + _CurrentCamera.ViewportSize / 2
                local v162 = math.floor(_CurrentCamera.ViewportSize.X / math.abs(256 - Options.esp_arrowsize.Value))

                v148.Arrow.PointA = v161
                v148.Arrow.PointB = v161 - getRotate(v160, 0.5) * v162
                v148.Arrow.PointC = v161 - getRotate(v160, -0.5) * v162
                v148.Arrow.Color = Options.arrows_color.Value
                v148.Arrow.Transparency = Options.esp_arrows_transparency.Value == 'pulse' and math.abs(math.sin(tick() * 0.8)) or math.abs(1 - Options.arrows_color.Transparency)
                v148.Arrow.Filled = Toggles.esp_arrowfilled.Value
            else
                v148.Arrow.Visible = false
            end
            if Toggles.esp_chams.Value then
                if not v147.Character:FindFirstChildOfClass('Highlight') then
                    local _Highlight = Instance.new('Highlight', v147.Character)

                    _Highlight.FillTransparency = Options.chams_color.Transparency
                    _Highlight.OutlineTransparency = 1
                end

                v147.Character.Highlight.FillColor = Options.chams_color.Value

                if Toggles.esp_chamsoutline.Value and Toggles.esp_chams.Value then
                    v147.Character.Highlight.OutlineTransparency = Options.ochams_color.Transparency
                    v147.Character.Highlight.OutlineColor = Options.ochams_color.Value
                else
                    v147.Character.Highlight.OutlineTransparency = 1
                end
            elseif v147.Character:FindFirstChildOfClass('Highlight') then
                v147.Character:FindFirstChildOfClass('Highlight'):Destroy()
            end
        elseif v147.Name ~= _LocalPlayer.Name then
            local v164, v165, v166 = pairs(v148)

            while true do
                local v167

                v166, v167 = v164(v165, v166)

                if v166 == nil then
                    break
                end

                v167.Visible = false
            end
        end
    end
end)

local u168 = nil

u168 = hookmetamethod(game, '__namecall', newcclosure(function(...)
    local v169 = getnamecallmethod()
    local v170 = {...}
    local v171 = v170[1]

    if Toggles.legit_enabled.Value and (v171 == workspace and (not checkcaller() and math.random(0, 100) <= Options.legit_hitchance.Value)) then
        if v169 == 'FindPartOnRayWithIgnoreList' and Options.legit_silent_mode.Value == v169:lower() then
            if u26(v170, u14.FindPartOnRayWithIgnoreList) then
                local v172 = v170[2]

                if u15.target ~= nil then
                    local _Origin = v172.Origin
                    local v174 = u29(_Origin, u15.target.Position)

                    v170[2] = Ray.new(_Origin, v174)

                    return u168(unpack(v170))
                end
            end
        elseif v169 == 'FindPartOnRayWithWhitelist' and Options.legit_silent_mode.Value == v169:lower() then
            if u26(v170, u14.FindPartOnRayWithWhitelist) then
                local v175 = v170[2]

                if u15.target ~= nil then
                    local _Origin2 = v175.Origin
                    local v177 = u29(_Origin2, u15.target.Position)

                    v170[2] = Ray.new(_Origin2, v177)

                    return u168(unpack(v170))
                end
            end
        elseif (v169 == 'FindPartOnRay' or v169 == 'findPartOnRay') and Options.legit_silent_mode.Value:lower() == v169:lower() then
            if u26(v170, u14.FindPartOnRay) then
                local v178 = v170[2]

                if u15.target ~= nil then
                    local _Origin3 = v178.Origin
                    local v180 = u29(_Origin3, u15.target.Position)

                    v170[2] = Ray.new(_Origin3, v180)

                    return u168(unpack(v170))
                end
            end
        elseif v169 == 'Raycast' and (Options.legit_silent_mode.Value == v169:lower() and u26(v170, u14.Raycast)) then
            local v181 = v170[2]

            if u15.target then
                v170[3] = u29(v181, u15.target.Position)

                return u168(unpack(v170))
            end
        end
    end

    return u168(...)
end))

local u182 = nil

u182 = hookmetamethod(game, '__index', newcclosure(function(p183, p184)
    if p183 == u9 and (not checkcaller() and (Toggles.legit_enabled.Value and (Options.legit_silent_mode.Value == 'mouse.hit/target' and u15.target ~= nil))) then
        if p184 == 'Target' or p184 == 'target' then
            return u15.target
        end
        if p184 == 'Hit' or p184 == 'hit' then
            local v185 = Toggles.legit_prediction.Value and u15.target.CFrame + u15.target.Velocity * Options.legit_prediction_amount.Value

            if not v185 then
                if Toggles.legit_prediction.Value then
                    v185 = false
                else
                    v185 = u15.target.CFrame
                end
            end

            return v185
        end
        if p184 == 'X' or p184 == 'x' then
            return p183.X
        end
        if p184 == 'Y' or p184 == 'y' then
            return p183.Y
        end
        if p184 == 'UnitRay' then
            return Ray.new(p183.Origin, (p183.Hit - p183.Origin).Unit)
        end
    end

    return u182(p183, p184)
end))
