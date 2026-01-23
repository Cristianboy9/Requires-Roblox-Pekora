local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local map = ReplicatedStorage:FindFirstChild("Map") -- CAMBIA el nombre si es distinto
if not map then
    warn("Map no encontrado en ReplicatedStorage")
    return
end

if Workspace:FindFirstChild(map.Name) then
    Workspace[map.Name]:Destroy()
end

local mapClone = map:Clone()
mapClone.Parent = Workspace

if mapClone:IsA("Model") then
    mapClone:PivotTo(CFrame.new(0, 0, 0))
elseif mapClone:IsA("BasePart") then
    mapClone.Position = Vector3.new(0, 0, 0)
end
