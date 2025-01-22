local redzlib = 
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local Window = redzlib:MakeWindow({
    Title = "ZuXolo Hub : " .. gameName .. "",
    SubTitle = "by zuxolo",
    SaveFolder = "test"
})
game.StarterGui:SetCore("SendNotification", { -- cosmetic
    Title = "ZuXolo Hub",
    Text = "HUB SUCEFULL LOAD",
    Duration = 4
})

local TabDiscord = Window:MakeTab({"Discord", "lucide-circle-ellipsis"})

TabDiscord:AddButton({"Copy Discord", function()
setclipboard("not finish")
end})

TabDiscord:AddButton({"Changelog Page", function()
setclipboard("")
end})


local TabBlox = Window:MakeTab({"Blox Fruit", "lucide-apple"})

TabBlox:AddButton({"Redz Hub (Pc/Mobile)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
end})

local TabArsenal = Window:MakeTab({"Arsenal", "lucide-shield"})
TabArsenal:AddButton({"Tbao Hub (Pc/Mobile) - Atlantis Crash", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubArsenal"))()
end})

local TabT = Window:MakeTab({"Universal", "lucide-circle-slash"})

TabT:AddButton({"Infinity Yield (Pc/Mobile 75%)", function()
    local Dialog = Window:Dialog({
        Title = "Infinity Yield",
        Text = "Do you have sure?\nthis script have an autoexecute",
        Options = {
            {"Confirm", function()
                loadstring(game:HttpGet ("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
            end},
            {"Cancel", function()
                
            end}
        }
    })
end})

TabT:AddButton({"ESP Players (Beta) (Pc/Mobile)", function()
    game.StarterGui:SetCore("SendNotification", { -- cosmetic
        Title = "ZuXolo Hub",
        Text = "Esp enabled",
        Duration = 4
    })
    game.StarterGui:SetCore("SendNotification", { -- cosmetic
        Title = "ZuXolo Hub",
        Text = "Esp can be make an lag",
        Duration = 4
    })

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Configurações do ESP
local ESPSettings = {
    FillColor = Color3.fromRGB(128, 128, 128), -- Cor de preenchimento
    FillTransparency = 0.7,                   -- Transparência do preenchimento
    OutlineColor = Color3.fromRGB(255, 255, 255), -- Cor da borda
    OutlineTransparency = 0                   -- Transparência da borda
}

-- Cria o ESP para o personagem de um jogador
local function createESP(player)
    local character = player.Character
    if character and not character:FindFirstChildOfClass("Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "PlayerESP" -- Nome para facilitar a identificação
        highlight.Parent = character
        highlight.FillColor = ESPSettings.FillColor
        highlight.FillTransparency = ESPSettings.FillTransparency
        highlight.OutlineColor = ESPSettings.OutlineColor
        highlight.OutlineTransparency = ESPSettings.OutlineTransparency

        -- Força o ESP a ignorar lógica de time
        highlight.Adornee = character
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- Garante que o ESP seja sempre visível
    end
end

-- Remove o ESP do personagem de um jogador
local function removeESP(player)
    local character = player.Character
    if character then
        local highlight = character:FindFirstChild("PlayerESP")
        if highlight then
            highlight:Destroy()
        end
    end
end

-- Atualiza o ESP para todos os jogadores
local function updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            if player.Character then
                createESP(player)
            end
        end
    end
end

-- Lida com jogadores que entram no jogo
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        createESP(player)
    end)
end)

-- Lida com jogadores que saem do jogo
Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

-- Atualiza constantemente o ESP
RunService.Heartbeat:Connect(function()
    updateESP()
end)

end})

TabT:AddButton({"Aimbot FOV (Beta) (Pc/Mobile)", function()
--[[ 
  WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]

-- Configurações do FOV
local fov = 130
local maxTransparency = 1 -- Transparência máxima dentro do círculo (0.1 = 10% de transparência)

-- Serviços do Roblox
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Cam = workspace.CurrentCamera

-- Criação do círculo de FOV
local FOVring = Drawing.new("Circle")
FOVring.Visible = true
FOVring.Thickness = 2
FOVring.Color = Color3.fromRGB(255, 255, 255) -- Cor roxa
FOVring.Filled = false
FOVring.Radius = fov
FOVring.Position = Cam.ViewportSize / 2

-- Atualiza o desenho do círculo
local function updateDrawings()
    FOVring.Position = Cam.ViewportSize / 2
end

-- Função para movimentar a câmera na direção do alvo
local function lookAt(target)
    if target then
        local lookVector = (target - Cam.CFrame.Position).Unit
        local newCFrame = CFrame.new(Cam.CFrame.Position, Cam.CFrame.Position + lookVector)
        Cam.CFrame = newCFrame
    end
end

-- Função para calcular a transparência com base na distância
local function calculateTransparency(distance)
    local maxDistance = fov
    local transparency = math.clamp((1 - (distance / maxDistance)) * maxTransparency, 0, maxTransparency)
    return transparency
end

-- Função para encontrar o jogador mais próximo no FOV
local function getClosestPlayerInFOV(targetPart)
    local nearestPlayer = nil
    local shortestDistance = math.huge
    local centerScreen = Cam.ViewportSize / 2

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character then
            local part = player.Character:FindFirstChild(targetPart)
            if part then
                local screenPos, onScreen = Cam:WorldToViewportPoint(part.Position)
                local distance = (Vector2.new(screenPos.X, screenPos.Y) - centerScreen).Magnitude
                
                if onScreen and distance < shortestDistance and distance < fov then
                    shortestDistance = distance
                    nearestPlayer = player
                end
            end
        end
    end

    return nearestPlayer
end

-- Detecta a tecla "Delete" para encerrar o script
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Delete then
        RunService:UnbindFromRenderStep("FOVUpdate")
        FOVring:Remove()
    end
end)

-- Atualização contínua no RenderStepped
RunService.RenderStepped:Connect(function(deltaTime)
    updateDrawings()
    local closestPlayer = getClosestPlayerInFOV("Head")

    if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
        lookAt(closestPlayer.Character.Head.Position)

        -- Ajusta a transparência do círculo com base no jogador mais próximo
        local screenPos, _ = Cam:WorldToViewportPoint(closestPlayer.Character.Head.Position)
        local distance = (Vector2.new(screenPos.X, screenPos.Y) - (Cam.ViewportSize / 2)).Magnitude
        FOVring.Transparency = calculateTransparency(distance)
    else
        FOVring.Transparency = maxTransparency
    end
end)
end})

TabT:AddSlider({
    Name = "WalkSpeed",
    Min = 1,
    Max = 150,
    Increase = 1,
    Default = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

TabT:AddSlider({
    Name = "WalkSpeed - blox fruit",
    Min = 1,
    Max = 10,
    Increase = 0.05,
    Default = 1,
    Callback = function(Value)
        game.Players.LocalPlayer.Character:SetAttribute("SpeedMultiplier", Value)
    end
})

TabT:AddSlider({
    Name = "Jump Power",
    Min = 1,
    Max = 150,
    Increase = 1,
    Default = 50,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

	
	return Window
