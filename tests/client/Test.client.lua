local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Scenic = require(ReplicatedStorage.Packages.Scenic)
local Manager = Scenic.Manager

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = script.Parent

local Frame = Instance.new("Frame")
Frame.AnchorPoint = Vector2.new(.5, .5)
Frame.Position = UDim2.fromScale(.5, .5)
Frame.Size = UDim2.fromOffset(50, 50)

local Scene = Manager.Create("Scene", {
    Tag = "MyTag",
    Adornee = ScreenGui
})

local Container = Manager.Create("Container", {
    Tag = "MyContainer",
    Adornee = Scene
})

local Element = Manager.Create("Element", {
    GuiObject = Frame
})

Container:Push(Element)

Players.LocalPlayer.Chatted:Connect(function(message)
    if message == "SetPos" then
        Container:Set("Position", UDim2.fromScale(.5, .25))
    end
end)

print(Manager.FindSceneFromId(1))