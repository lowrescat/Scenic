local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Scenic = require(ReplicatedStorage.Packages.Scenic)
local Manager = Scenic.Manager

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = script.Parent

local Frame = Instance.new("Frame")
Frame.AnchorPoint = Vector2.new(.5, .5)
Frame.Position = UDim2.fromScale(.5, .5)
Frame.Size = UDim2.fromOffset(50, 50)

local Frame2 = Instance.new("Frame")
Frame2.AnchorPoint = Vector2.new(.5, .5)
Frame2.Position = UDim2.fromScale(.5, .5)
Frame2.Size = UDim2.fromOffset(50, 50)

local Scene = Manager.Create("Scene", {
    Tag = "MyTag",
    Adornee = ScreenGui
})

local Container = Manager.Create("Container", {
    Tag = "MyContainer",
    Adornee = Scene
})

local Container2 = Manager.Create("Container", {
    Tag = "MySecondContainer",
    Adornee = Scene
})

Container:Push(Frame)
Container2:Push(Frame2)

local Player = game:GetService("Players").LocalPlayer

Player.Chatted:Connect(function(message)
    if message == "Tween" then
        Scene:Tween({
            ["MyContainer"] = {
                ["Position"] = UDim2.fromScale(.5, .25)
            },

            ["MySecondContainer"] = {
                ["Position"] = UDim2.fromScale(.5, .75)
            }
        }):PlayAll()
    end
end)