-- miracle hub v4.0 - ultimate horror script
-- universal all games - professional edition
-- created by: jyloo

local players = game:GetService("Players")
local runservice = game:GetService("RunService")
local startergui = game:GetService("StarterGui")
local tweenservice = game:GetService("TweenService")
local userinputservice = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")
local lighting = game:GetService("Lighting")
local coregui = game:GetService("CoreGui")
local virtualuser = game:GetService("VirtualUser")
local httpservice = game:GetService("HttpService")

local plr = players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = plr:GetMouse()

-- anti afk system
plr.Idled:Connect(function()
    virtualuser:CaptureController()
    virtualuser:ClickButton2(Vector2.new())
end)

-- main gui container
local gui = Instance.new("ScreenGui")
gui.Name = "MiracleHub_Professional"
gui.Parent = plr:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- load saved configuration
local settings = {}
local function loadSettings()
    local success, data = pcall(function()
        return httpservice:JSONDecode(readfile("miraclehub_settings.json"))
    end)
    if success and data then
        settings = data
    else
        settings = {
            theme = "dark",
            autosave = true,
            alertdistance = 50,
            flashlightkey = "f",
            speedmultiplier = 2,
            espcolor = Color3.fromRGB(255, 50, 50)
        }
    end
end
loadSettings()

-- loading screen animation
local loadingframe = Instance.new("Frame")
loadingframe.Size = UDim2.new(1, 0, 1, 0)
loadingframe.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loadingframe.BackgroundTransparency = 0
loadingframe.Parent = gui

-- gradient background
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 5, 20)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 10, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 5, 20))
})
gradient.Rotation = 45
gradient.Parent = loadingframe

-- animated logo
local logoframe = Instance.new("Frame")
logoframe.Size = UDim2.new(0, 200, 0, 200)
logoframe.Position = UDim2.new(0.5, -100, 0.4, -100)
logoframe.BackgroundTransparency = 1
logoframe.Parent = loadingframe

local logocircle = Instance.new("ImageLabel")
logocircle.Size = UDim2.new(1, 0, 1, 0)
logocircle.BackgroundTransparency = 1
logocircle.Image = "rbxassetid://6031090995"
logocircle.ImageColor3 = Color3.fromRGB(100, 150, 255)
logocircle.ImageTransparency = 0.5
logocircle.Parent = logoframe

-- spinning animation
spawn(function()
    while logocircle do
        for i = 0, 360, 5 do
            logocircle.Rotation = i
            wait(0.01)
        end
    end
end)

-- main title
local miraclestitle = Instance.new("TextLabel")
miraclestitle.Size = UDim2.new(0.6, 0, 0.1, 0)
miraclestitle.Position = UDim2.new(0.2, 0, 0.6, 0)
miraclestitle.BackgroundTransparency = 1
miraclestitle.Text = "miracle hub"
miraclestitle.TextColor3 = Color3.fromRGB(200, 220, 255)
miraclestitle.TextScaled = true
miraclestitle.Font = Enum.Font.GothamBlack
miraclestitle.TextStrokeTransparency = 0.8
miraclestitle.TextStrokeColor3 = Color3.fromRGB(100, 50, 200)
miraclestitle.Parent = loadingframe

-- loading status
local loadingsub = Instance.new("TextLabel")
loadingsub.Size = UDim2.new(0.4, 0, 0.05, 0)
loadingsub.Position = UDim2.new(0.3, 0, 0.7, 0)
loadingsub.BackgroundTransparency = 1
loadingsub.Text = "initializing system..."
loadingsub.TextColor3 = Color3.fromRGB(150, 180, 255)
loadingsub.TextScaled = true
loadingsub.Font = Enum.Font.Gotham
loadingsub.TextTransparency = 0.3
loadingsub.Parent = loadingframe

-- progress bar
local loadbarbg = Instance.new("Frame")
loadbarbg.Size = UDim2.new(0.4, 0, 0, 4)
loadbarbg.Position = UDim2.new(0.3, 0, 0.8, 0)
loadbarbg.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
loadbarbg.Parent = loadingframe

local loadbar = Instance.new("Frame")
loadbar.Size = UDim2.new(0, 0, 1, 0)
loadbar.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
loadbar.Parent = loadbarbg

local loadbarcorner = Instance.new("UICorner")
loadbarcorner.CornerRadius = UDim.new(0, 2)
loadbarcorner.Parent = loadbar

-- personalized greeting
local greetinglabel = Instance.new("TextLabel")
greetinglabel.Size = UDim2.new(0.6, 0, 0.08, 0)
greetinglabel.Position = UDim2.new(0.2, 0, 0.85, 0)
greetinglabel.BackgroundTransparency = 1
greetinglabel.Text = ""
greetinglabel.TextColor3 = Color3.fromRGB(180, 200, 255)
greetinglabel.TextScaled = true
greetinglabel.Font = Enum.Font.GothamLight
greetinglabel.Parent = loadingframe

-- typing effect
local fulltext = "welcome back, " .. plr.Name .. " • system ready"
spawn(function()
    for i = 1, #fulltext do
        greetinglabel.Text = string.sub(fulltext, 1, i)
        wait(0.03)
    end
    wait(0.5)
end)

-- loading progression
spawn(function()
    for i = 1, 100 do
        loadbar.Size = UDim2.new(i/100, 0, 1, 0)
        if i == 30 then
            loadingsub.Text = "loading modules..."
        elseif i == 60 then
            loadingsub.Text = "scanning game environment..."
        elseif i == 90 then
            loadingsub.Text = "activating features..."
        end
        wait(0.02)
    end
    
    wait(0.3)
    loadingframe:TweenPosition(UDim2.new(0, 0, -1, 0), "Out", "Quad", 1)
    wait(1)
    loadingframe:Destroy()
end)

-- main interface
local mainframe = Instance.new("Frame")
mainframe.Size = UDim2.new(0, 450, 0, 550)
mainframe.Position = UDim2.new(0.5, -225, 1.1, 0)
mainframe.BackgroundColor3 = Color3.fromRGB(10, 8, 20)
mainframe.Parent = gui
mainframe.ClipsDescendants = true

-- glassmorphism effect
local maingradient = Instance.new("UIGradient")
maingradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 15, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 5, 25))
})
maingradient.Rotation = 90
maingradient.Parent = mainframe

local maincorner = Instance.new("UICorner")
maincorner.CornerRadius = UDim.new(0, 20)
maincorner.Parent = mainframe

local mainstroke = Instance.new("UIStroke")
mainstroke.Color = Color3.fromRGB(100, 80, 200)
mainstroke.Thickness = 1.5
mainstroke.Transparency = 0.7
mainstroke.Parent = mainframe

-- top bar
local topbar = Instance.new("Frame")
topbar.Size = UDim2.new(1, 0, 0, 60)
topbar.BackgroundColor3 = Color3.fromRGB(20, 15, 35)
topbar.Parent = mainframe

local topbargradient = Instance.new("UIGradient")
topbargradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 25, 70)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 15, 35))
})
topbargradient.Rotation = 180
topbargradient.Parent = topbar

local topcorner = Instance.new("UICorner")
topcorner.CornerRadius = UDim.new(0, 20)
topcorner.Parent = topbar

local topbarstroke = Instance.new("UIStroke")
topbarstroke.Color = Color3.fromRGB(150, 100, 255)
topbarstroke.Thickness = 1
topbarstroke.Transparency = 0.5
topbarstroke.Parent = topbar

-- hub icon
local hubicon = Instance.new("ImageLabel")
hubicon.Size = UDim2.new(0, 40, 0, 40)
hubicon.Position = UDim2.new(0, 15, 0.5, -20)
hubicon.BackgroundTransparency = 1
hubicon.Image = "rbxassetid://6031090995"
hubicon.ImageColor3 = Color3.fromRGB(120, 80, 255)
hubicon.Parent = topbar

-- hub title
local hubtitle = Instance.new("TextLabel")
hubtitle.Size = UDim2.new(0.5, 0, 1, 0)
hubtitle.Position = UDim2.new(0, 65, 0, 0)
hubtitle.BackgroundTransparency = 1
hubtitle.Text = "miracle hub"
hubtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
hubtitle.TextScaled = true
hubtitle.Font = Enum.Font.GothamBlack
hubtitle.TextXAlignment = Enum.TextXAlignment.Left
hubtitle.TextStrokeTransparency = 0.5
hubtitle.TextStrokeColor3 = Color3.fromRGB(100, 50, 200)
hubtitle.Parent = topbar

-- version indicator
local versionlabel = Instance.new("TextLabel")
versionlabel.Size = UDim2.new(0, 60, 0, 20)
versionlabel.Position = UDim2.new(1, -70, 0.5, -10)
versionlabel.BackgroundColor3 = Color3.fromRGB(40, 30, 70)
versionlabel.Text = "v4.0"
versionlabel.TextColor3 = Color3.fromRGB(200, 200, 255)
versionlabel.TextScaled = true
versionlabel.Font = Enum.Font.GothamBold
versionlabel.Parent = topbar

local versioncorner = Instance.new("UICorner")
versioncorner.CornerRadius = UDim.new(0, 10)
versioncorner.Parent = versionlabel

-- minimize button
local minimizebtn = Instance.new("TextButton")
minimizebtn.Size = UDim2.new(0, 35, 0, 35)
minimizebtn.Position = UDim2.new(1, -115, 0.5, -17.5)
minimizebtn.BackgroundColor3 = Color3.fromRGB(30, 25, 45)
minimizebtn.Text = "—"
minimizebtn.TextColor3 = Color3.fromRGB(200, 200, 255)
minimizebtn.TextScaled = true
minimizebtn.Font = Enum.Font.GothamBold
minimizebtn.Parent = topbar

local mincorner = Instance.new("UICorner")
mincorner.CornerRadius = UDim.new(0, 12)
mincorner.Parent = minimizebtn

-- close button
local closebtn = Instance.new("TextButton")
closebtn.Size = UDim2.new(0, 35, 0, 35)
closebtn.Position = UDim2.new(1, -70, 0.5, -17.5)
closebtn.BackgroundColor3 = Color3.fromRGB(45, 25, 35)
closebtn.Text = "✕"
closebtn.TextColor3 = Color3.fromRGB(255, 150, 150)
closebtn.TextScaled = true
closebtn.Font = Enum.Font.GothamBold
closebtn.Parent = topbar

local closecorner = Instance.new("UICorner")
closecorner.CornerRadius = UDim.new(0, 12)
closecorner.Parent = closebtn

closebtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- tab navigation
local tabframe = Instance.new("Frame")
tabframe.Size = UDim2.new(1, -20, 0, 40)
tabframe.Position = UDim2.new(0, 10, 0, 65)
tabframe.BackgroundTransparency = 1
tabframe.Parent = mainframe

local tabs = {}

local function createTab(name, posX)
    local tabbtn = Instance.new("TextButton")
    tabbtn.Size = UDim2.new(0, 80, 0, 35)
    tabbtn.Position = UDim2.new(0, posX, 0, 2.5)
    tabbtn.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
    tabbtn.Text = name
    tabbtn.TextColor3 = Color3.fromRGB(180, 180, 255)
    tabbtn.Font = Enum.Font.GothamBold
    tabbtn.TextScaled = true
    tabbtn.Parent = tabframe
    
    local tabcorner = Instance.new("UICorner")
    tabcorner.CornerRadius = UDim.new(0, 12)
    tabcorner.Parent = tabbtn
    
    return tabbtn
end

local tabmain = createTab("main", 0)
local tabesp = createTab("esp", 90)
local tabvisual = createTab("visual", 180)
local tabmisc = createTab("misc", 270)
local tabsettings = createTab("settings", 360)

-- content container
local container = Instance.new("Frame")
container.Size = UDim2.new(1, -20, 1, -160)
container.Position = UDim2.new(0, 10, 0, 110)
container.BackgroundColor3 = Color3.fromRGB(15, 12, 30)
container.Parent = mainframe
container.ClipsDescendants = true

local containercorner = Instance.new("UICorner")
containercorner.CornerRadius = UDim.new(0, 15)
containercorner.Parent = container

local containergradient = Instance.new("UIGradient")
containergradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 20, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 10, 35))
})
containergradient.Rotation = 45
containergradient.Parent = container

-- page system
local pages = {}

local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(100, 80, 200)
    page.Parent = container
    page.Visible = false
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingBottom = UDim.new(0, 10)
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = page
    
    pages[name] = page
    return page
end

local pagemain = createPage("main")
local pageesp = createPage("esp")
local pagevisual = createPage("visual")
local pagemisc = createPage("misc")
local pagesettings = createPage("settings")

-- tab switching
local function switchTab(tab)
    for _, p in pairs(pages) do
        p.Visible = false
    end
    pages[tab].Visible = true
end

tabmain.MouseButton1Click:Connect(function() switchTab("main") end)
tabesp.MouseButton1Click:Connect(function() switchTab("esp") end)
tabvisual.MouseButton1Click:Connect(function() switchTab("visual") end)
tabmisc.MouseButton1Click:Connect(function() switchTab("misc") end)
tabsettings.MouseButton1Click:Connect(function() switchTab("settings") end)

-- professional toggle creator
local function createToggle(parent, name, desc, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 60)
    frame.BackgroundColor3 = Color3.fromRGB(20, 15, 35)
    frame.Parent = parent
    
    local framecorner = Instance.new("UICorner")
    framecorner.CornerRadius = UDim.new(0, 12)
    framecorner.Parent = frame
    
    local framestroke = Instance.new("UIStroke")
    framestroke.Color = Color3.fromRGB(80, 60, 150)
    framestroke.Thickness = 1
    framestroke.Transparency = 0.7
    framestroke.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.7, 0, 0.4, 0)
    title.Position = UDim2.new(0, 15, 0, 8)
    title.BackgroundTransparency = 1
    title.Text = name
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame
    
    local desclabel = Instance.new("TextLabel")
    desclabel.Size = UDim2.new(0.7, 0, 0.4, 0)
    desclabel.Position = UDim2.new(0, 15, 0, 28)
    desclabel.BackgroundTransparency = 1
    desclabel.Text = desc
    desclabel.TextColor3 = Color3.fromRGB(150, 150, 200)
    desclabel.TextScaled = true
    desclabel.Font = Enum.Font.GothamLight
    desclabel.TextXAlignment = Enum.TextXAlignment.Left
    desclabel.Parent = frame
    
    local togglebtn = Instance.new("TextButton")
    togglebtn.Size = UDim2.new(0, 50, 0, 30)
    togglebtn.Position = UDim2.new(1, -65, 0.5, -15)
    togglebtn.BackgroundColor3 = default and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(60, 50, 80)
    togglebtn.Text = default and "on" or "off"
    togglebtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    togglebtn.Font = Enum.Font.GothamBold
    togglebtn.TextScaled = true
    togglebtn.Parent = frame
    
    local btncorner = Instance.new("UICorner")
    btncorner.CornerRadius = UDim.new(0, 8)
    btncorner.Parent = togglebtn
    
    local state = default
    
    togglebtn.MouseButton1Click:Connect(function()
        state = not state
        togglebtn.Text = state and "on" or "off"
        togglebtn.BackgroundColor3 = state and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(60, 50, 80)
        callback(state)
    end)
    
    return frame
end

-- professional slider creator
local function createSlider(parent, name, desc, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 70)
    frame.BackgroundColor3 = Color3.fromRGB(20, 15, 35)
    frame.Parent = parent
    
    local framecorner = Instance.new("UICorner")
    framecorner.CornerRadius = UDim.new(0, 12)
    framecorner.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.7, 0, 0.3, 0)
    title.Position = UDim2.new(0, 15, 0, 8)
    title.BackgroundTransparency = 1
    title.Text = name
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame
    
    local desclabel = Instance.new("TextLabel")
    desclabel.Size = UDim2.new(0.7, 0, 0.3, 0)
    desclabel.Position = UDim2.new(0, 15, 0, 28)
    desclabel.BackgroundTransparency = 1
    desclabel.Text = desc
    desclabel.TextColor3 = Color3.fromRGB(150, 150, 200)
    desclabel.TextScaled = true
    desclabel.Font = Enum.Font.GothamLight
    desclabel.TextXAlignment = Enum.TextXAlignment.Left
    desclabel.Parent = frame
    
    local valuelabel = Instance.new("TextLabel")
    valuelabel.Size = UDim2.new(0, 60, 0, 25)
    valuelabel.Position = UDim2.new(1, -75, 0, 8)
    valuelabel.BackgroundColor3 = Color3.fromRGB(40, 30, 70)
    valuelabel.Text = tostring(default)
    valuelabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    valuelabel.Font = Enum.Font.GothamBold
    valuelabel.TextScaled = true
    valuelabel.Parent = frame
    
    local valcorner = Instance.new("UICorner")
    valcorner.CornerRadius = UDim.new(0, 6)
    valcorner.Parent = valuelabel
    
    local sliderbg = Instance.new("Frame")
    sliderbg.Size = UDim2.new(0.8, -20, 0, 8)
    sliderbg.Position = UDim2.new(0.1, 0, 0, 50)
    sliderbg.BackgroundColor3 = Color3.fromRGB(40, 30, 60)
    sliderbg.Parent = frame
    
    local slidercorner = Instance.new("UICorner")
    slidercorner.CornerRadius = UDim.new(0, 4)
    slidercorner.Parent = sliderbg
    
    local sliderfill = Instance.new("Frame")
    sliderfill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderfill.BackgroundColor3 = Color3.fromRGB(100, 80, 255)
    sliderfill.Parent = sliderbg
    
    local fillcorner = Instance.new("UICorner")
    fillcorner.CornerRadius = UDim.new(0, 4)
    fillcorner.Parent = sliderfill
    
    local dragging = false
    
    sliderbg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    sliderbg.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    userinputservice.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = userinputservice:GetMouseLocation()
            local abspos = sliderbg.AbsolutePosition
            local abssize = sliderbg.AbsoluteSize
            local relativex = math.clamp(pos.X - abspos.X, 0, abssize.X)
            local percent = relativex / abssize.X
            local value = math.floor((min + (max - min) * percent) * 10) / 10
            valuelabel.Text = tostring(value)
            sliderfill.Size = UDim2.new(percent, 0, 1, 0)
            callback(value)
        end
    end)
    
    return frame
end

-- professional button creator
local function createButton(parent, name, desc, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 60)
    frame.BackgroundColor3 = Color3.fromRGB(20, 15, 35)
    frame.Parent = parent
    
    local framecorner = Instance.new("UICorner")
    framecorner.CornerRadius = UDim.new(0, 12)
    framecorner.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.7, 0, 0.4, 0)
    title.Position = UDim2.new(0, 15, 0, 8)
    title.BackgroundTransparency = 1
    title.Text = name
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame
    
    local desclabel = Instance.new("TextLabel")
    desclabel.Size = UDim2.new(0.7, 0, 0.4, 0)
    desclabel.Position = UDim2.new(0, 15, 0, 28)
    desclabel.BackgroundTransparency = 1
    desclabel.Text = desc
    desclabel.TextColor3 = Color3.fromRGB(150, 150, 200)
    desclabel.TextScaled = true
    desclabel.Font = Enum.Font.GothamLight
    desclabel.TextXAlignment = Enum.TextXAlignment.Left
    desclabel.Parent = frame
    
    local actionbtn = Instance.new("TextButton")
    actionbtn.Size = UDim2.new(0, 70, 0, 35)
    actionbtn.Position = UDim2.new(1, -85, 0.5, -17.5)
    actionbtn.BackgroundColor3 = Color3.fromRGB(80, 60, 150)
    actionbtn.Text = "run"
    actionbtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    actionbtn.Font = Enum.Font.GothamBold
    actionbtn.TextScaled = true
    actionbtn.Parent = frame
    
    local btncorner = Instance.new("UICorner")
    btncorner.CornerRadius = UDim.new(0, 8)
    btncorner.Parent = actionbtn
    
    actionbtn.MouseButton1Click:Connect(callback)
    
    return frame
end

-- [ MAIN PAGE FEATURES ]

createToggle(pagemain, "objective hint", "highlight interactive objectives", false, function(state)
    _G.HintObjective = state
    if state then
        spawn(function()
            local cache = {}
            while _G.HintObjective do
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Part") and not cache[obj] then
                        local name = obj.Name:lower()
                        if name:find("door") or name:find("key") or name:find("lever") or 
                           name:find("button") or name:find("objective") or name:find("switch") then
                            
                            local highlight = Instance.new("Highlight")
                            highlight.Adornee = obj
                            highlight.FillColor = Color3.fromRGB(0, 255, 0)
                            highlight.FillTransparency = 0.5
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                            highlight.Parent = obj
                            
                            cache[obj] = true
                            game:GetService("Debris"):AddItem(highlight, 3)
                        end
                    end
                end
                wait(3)
            end
        end)
    end
end)

createToggle(pagemain, "full scan", "scan entire game environment", false, function(state)
    _G.FullScan = state
    if state then
        spawn(function()
            while _G.FullScan do
                local items = {}
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Part") and v.Material ~= Enum.Material.Air then
                        table.insert(items, v.Name)
                    end
                end
                print("scan complete - items found:", #items)
                wait(5)
            end
        end)
    end
end)

createSlider(pagemain, "speed multiplier", "adjust movement speed", 1, 10, 2, function(val)
    _G.SpeedValue = val
    if _G.SpeedEnabled and plr.Character and plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid.WalkSpeed = 16 * val
    end
end)

createToggle(pagemain, "speed hack", "enable speed multiplier", false, function(state)
    _G.SpeedEnabled = state
    if plr.Character and plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid.WalkSpeed = state and 16 * (_G.SpeedValue or 2) or 16
    end
end)

createToggle(pagemain, "noclip", "walk through walls", false, function(state)
    _G.NoclipEnabled = state
    if state then
        spawn(function()
            while _G.NoclipEnabled do
                if plr.Character then
                    for _, part in pairs(plr.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
                wait(0.1)
            end
        end)
    end
end)

-- [ ESP PAGE FEATURES ]

createToggle(pageesp, "mob esp", "highlight enemy entities", false, function(state)
    _G.MobESP = state
    spawn(function()
        while _G.MobESP do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v ~= plr.Character then
                    if not v:FindFirstChild("mob_esp") then
                        local box = Instance.new("BoxHandleAdornment")
                        box.Size = v:GetExtentsSize()
                        box.Adornee = v
                        box.ZIndex = 5
                        box.AlwaysOnTop = true
                        box.Transparency = 0.5
                        box.Color3 = Color3.fromRGB(255, 50, 50)
                        box.Name = "mob_esp"
                        box.Parent = v
                    end
                end
            end
            wait(0.5)
        end
    end)
end)

createToggle(pageesp, "player esp", "highlight other players", false, function(state)
    _G.PlayerESP = state
    spawn(function()
        while _G.PlayerESP do
            for _, player in pairs(players:GetPlayers()) do
                if player ~= plr and player.Character then
                    if not player.Character:FindFirstChild("player_esp") then
                        local highlight = Instance.new("Highlight")
                        highlight.Adornee = player.Character
                        highlight.FillColor = Color3.fromRGB(50, 100, 255)
                        highlight.FillTransparency = 0.5
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.Name = "player_esp"
                        highlight.Parent = player.Character
                    end
                end
            end
            wait(0.5)
        end
    end)
end)

createToggle(pageesp, "item esp", "highlight valuable items", false, function(state)
    _G.ItemESP = state
    spawn(function()
        while _G.ItemESP do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Part") and (v.Name:lower():find("key") or v.Name:lower():find("battery") or 
                   v.Name:lower():find("flashlight") or v.Name:lower():find("tool")) then
                    if not v:FindFirstChild("item_esp") then
                        local highlight = Instance.new("Highlight")
                        highlight.Adornee = v
                        highlight.FillColor = Color3.fromRGB(255, 200, 50)
                        highlight.FillTransparency = 0.5
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.Name = "item_esp"
                        highlight.Parent = v
                        game:GetService("Debris"):AddItem(highlight, 2)
                    end
                end
            end
            wait(1)
        end
    end)
end)

createSlider(pageesp, "esp distance", "maximum render distance", 10, 200, 100, function(val)
    _G.ESPDistance = val
end)

createButton(pageesp, "refresh esp", "clear and update highlights", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BoxHandleAdornment") or v:IsA("Highlight") then
            if v.Name == "mob_esp" or v.Name == "player_esp" or v.Name == "item_esp" then
                v:Destroy()
            end
        end
    end
    startergui:SetCore("SendNotification", {
        Title = "miracle hub",
        Text = "esp refreshed successfully",
        Duration = 2
    })
end)

-- [ VISUAL PAGE FEATURES ]

createToggle(pagevisual, "auto flashlight", "automatically toggle flashlight", false, function(state)
    _G.AutoFlashlight = state
    spawn(function()
        while _G.AutoFlashlight do
            if plr.Character and plr.Character:FindFirstChildOfClass("Tool") then
                local tool = plr.Character:FindFirstChildOfClass("Tool")
                if tool.Name:lower():find("flashlight") or tool.Name:lower():find("torch") or tool.Name:lower():find("lamp") then
                    tool:Activate()
                end
            end
            wait(0.5)
        end
    end)
end)

createToggle(pagevisual, "fps counter", "display framerate monitor", false, function(state)
    if state then
        local fpslabel = Instance.new("TextLabel")
        fpslabel.Name = "fps_counter"
        fpslabel.Size = UDim2.new(0, 100, 0, 30)
        fpslabel.Position = UDim2.new(0, 10, 0, 10)
        fpslabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        fpslabel.BackgroundTransparency = 0.5
        fpslabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        fpslabel.Font = Enum.Font.GothamBold
        fpslabel.TextScaled = true
        fpslabel.Parent = gui
        
        local lasttime = tick()
        local frames = 0
        
        spawn(function()
            while _G.FPSCounter do
                frames = frames + 1
                local currenttime = tick()
                if currenttime - lasttime >= 1 then
                    fpslabel.Text = "fps: " .. frames
                    frames = 0
                    lasttime = currenttime
                end
                wait()
            end
            fpslabel:Destroy()
        end)
    end
    _G.FPSCounter = state
end)

createToggle(pagevisual, "fullbright", "enhance visibility in darkness", false, function(state)
    if state then
        lighting.Ambient = Color3.fromRGB(255, 255, 255)
        lighting.Brightness = 2
        lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        lighting.GlobalShadows = false
    else
        lighting.Ambient = Color3.fromRGB(127, 127, 127)
        lighting.Brightness = 1
        lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
        lighting.GlobalShadows = true
    end
end)

createToggle(pagevisual, "remove fog", "disable atmospheric fog", false, function(state)
    if state then
        lighting.FogEnd = 100000
        lighting.FogStart = 0
    else
        lighting.FogEnd = 100000
        lighting.FogStart = 0
    end
end)

-- [ MISC PAGE FEATURES ]

createToggle(pagemisc, "monster alert", "notify when enemies nearby", false, function(state)
    _G.MonsterAlert = state
    spawn(function()
        while _G.MonsterAlert do
            local nearestdist = math.huge
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v ~= plr.Character then
                    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (plr.Character.HumanoidRootPart.Position - v:GetPivot().Position).Magnitude
                        if dist < nearestdist then
                            nearestdist = dist
                        end
                    end
                end
            end
            
            if nearestdist < (_G.AlertDistance or 50) then
                startergui:SetCore("SendNotification", {
                    Title = "⚠️ monster detected",
                    Text = "distance: " .. math.floor(nearestdist) .. " studs",
                    Duration = 2
                })
            end
            wait(3)
        end
    end)
end)

createSlider(pagemisc, "alert distance", "detection range for alerts", 10, 100, 50, function(val)
    _G.AlertDistance = val
end)

-- infinite jump with proper connection management
local jumpconnection = nil
createButton(pagemisc, "infinite jump", "toggle unlimited jumping", function()
    _G.InfiniteJump = not _G.InfiniteJump
    
    if _G.InfiniteJump then
        if not jumpconnection then
            jumpconnection = userinputservice.JumpRequest:Connect(function()
                if _G.InfiniteJump and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    plr.Character.Humanoid:ChangeState("Jumping")
                end
            end)
        end
    else
        if jumpconnection then
            jumpconnection:Disconnect()
            jumpconnection = nil
        end
    end
    
    startergui:SetCore("SendNotification", {
        Title = "miracle hub",
        Text = "infinite jump: " .. (_G.InfiniteJump and "enabled" or "disabled"),
        Duration = 2
    })
end)

createButton(pagemisc, "rejoin game", "reconnect to current server", function()
    local ts = game:GetService("TeleportService")
    local placeid = game.PlaceId
    ts:Teleport(placeid, plr)
end)

-- [ SETTINGS PAGE FEATURES ]

createSlider(pagesettings, "ui transparency", "adjust interface opacity", 0, 1, 0, function(val)
    mainframe.BackgroundTransparency = val
    for _, v in pairs(mainframe:GetDescendants()) do
        if v:IsA("Frame") or v:IsA("TextButton") or v:IsA("TextLabel") then
            pcall(function()
                v.BackgroundTransparency = val
            end)
        end
    end
end)

createButton(pagesettings, "save configuration", "store current settings", function()
    local data = {
        speedmultiplier = _G.SpeedValue or 2,
        alertdistance = _G.AlertDistance or 50,
        espdistance = _G.ESPDistance or 100
    }
    pcall(function()
        writefile("miraclehub_settings.json", httpservice:JSONEncode(data))
    end)
    startergui:SetCore("SendNotification", {
        Title = "miracle hub",
        Text = "configuration saved",
        Duration = 2
    })
end)

createButton(pagesettings, "reset configuration", "restore default values", function()
    _G.SpeedValue = 2
    _G.AlertDistance = 50
    _G.ESPDistance = 100
    startergui:SetCore("SendNotification", {
        Title = "miracle hub",
        Text = "configuration reset",
        Duration = 2
    })
end)

-- drag system
local dragging = false
local draginput = nil
local dragstart = nil
local startpos = nil

local function updateDrag(input)
    local delta = input.Position - dragstart
    mainframe.Position = UDim2.new(startpos.X.Scale, startpos.X.Offset + delta.X, startpos.Y.Scale, startpos.Y.Offset + delta.Y)
end

topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragstart = input.Position
        startpos = mainframe.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

topbar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        draginput = input
    end
end)

userinputservice.InputChanged:Connect(function(input)
    if input == draginput and dragging then
        updateDrag(input)
    end
end)

-- minimize feature
local minimized = false

minimizebtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        mainframe:TweenSize(UDim2.new(0, 450, 0, 60), "Out", "Quad", 0.3)
        container.Visible = false
        tabframe.Visible = false
    else
        mainframe:TweenSize(UDim2.new(0, 450, 0, 550), "Out", "Quad", 0.3)
        wait(0.3)
        container.Visible = true
        tabframe.Visible = true
    end
end)

-- initial page
switchTab("main")

-- entrance animation
spawn(function()
    wait(2.5)
    mainframe:TweenPosition(UDim2.new(0.5, -225, 0.15, 0), "Out", "Back", 0.8)
end)

-- welcome notification
spawn(function()
    wait(3)
    startergui:SetCore("SendNotification", {
        Title = "✨ miracle hub activated ✨",
        Text = "welcome " .. plr.Name .. " • all systems online",
        Duration = 5,
        Icon = "rbxassetid://6031090995"
    })
end)

-- speed loop
runservice.RenderStepped:Connect(function()
    if _G.SpeedEnabled and plr.Character and plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid.WalkSpeed = 16 * (_G.SpeedValue or 2)
    end
end)

print("✅ miracle hub v4.0 - active for " .. plr.Name)
