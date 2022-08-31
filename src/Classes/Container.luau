--[=[
    @class Container
    The collection which holds all of the UI elements.
]=]

local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")

local Classes = script.Parent
local Utility = Classes.Parent.Utility

local Types = require(Utility.Types)
local Shared = require(Utility.Shared)

local Container = {}
Container.__index = Container

local function assertTrue(input: any, errMsg: string)
    if input then
        return error(errMsg)
    end

    return input
end

--[=[
    @function new
    @within Container

    Creates the "Container" object, not particularly recommended as the `Manager.Create()` function handles all creation of classes for you.

    @param propertyTable {[string]: any} | {}

    @return Container
]=]

function Container.new(propertyTable: {[string]: any} | {})
    if propertyTable == nil then
        propertyTable = {}
    end


    local defaultProperties = {
        Tag = "Container",
        Adornee = nil,

        __elements = {},
        __object = nil
    }

    for propName, propVal in defaultProperties do
        if typeof(propertyTable[propName]) ~= typeof(propVal) then
            propertyTable[propName] = propVal
        end
    end

    local obj = Instance.new("CanvasGroup")
    obj.Name = propertyTable.Tag
    obj.AnchorPoint = Vector2.new(.5, .5)
    obj.Position = UDim2.fromScale(.5, .5)
    obj.Size = UDim2.fromScale(1, 1)
    obj.BackgroundTransparency = 1
    obj.Parent = propertyTable.Adornee.__object

    CollectionService:AddTag(obj, "Container")

    local self = setmetatable(propertyTable, Container)
    self.__object = obj

    table.insert(self:GetScene().__containers, self)

    Shared.settype(self, "Container")

    return self
end

--[=[
    @method Push
    @within Container

    Pushes either an array of [GuiObject]s or an individual [GuiObject] into itself

    ```lua
    local Array : {[number]: any} = {
        TextLabel,
        Frame,
        TextButton
    }

    Container:Push(Array)

    -- OR

    Container:Push(TextLabel)
    ```

    @param obj {GuiObject} | GuiObject

    @return nil
]=]

function Container:Push(obj: {GuiObject | Types.Element} | GuiObject | Types.Element)
    assertTrue(obj == nil, "Missing argument")

    if typeof(obj) == "table" then
        for _, elmn in obj do
            if Shared.typeof(elmn) == "Element" then
                elmn.GuiObject.Parent = self.__object
                table.insert(self.__elements, elmn.GuiObject)
            end

            elmn.Parent = self.__object
            table.insert(self.__elements, elmn)
        end

        return nil
    end


    if Shared.typeof(obj) == "Element" then
        obj = obj.GuiObject
    end

    obj.Parent = self.__object
    table.insert(self.__elements, obj)

    return nil
end

--[=[
    @method Tween
    @within Container

    Tweens the [Container] with specified properties and [TweenInfo].

    ```lua
    local Tween = Container:Tween({
        Position = UDim2.fromScale(.5, .5)
    }, TweenInfo.new(.5, Enum.EasingStyle.Quad))
    ```

    @param propertyTable {[string]: any}
    @param tweenInfo TweenInfo

    @return Tween
]=]

function Container:Tween(propertyTable: {[string]: any}, tweenInfo: TweenInfo)
    assertTrue(propertyTable == nil, "Missing argument")

    if typeof(tweenInfo) ~= "TweenInfo" then
        tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear)
    end

    local tween = TweenService:Create(self.__object, tweenInfo, propertyTable)

    return tween
end

--[=[
    @method Set
    @within Container

    Sets any specified properties either in a Dictionary or simply a Tuple.

    @param prop {[string]: any} | string
    @param newValue any | nil

    @return nil
]=]

function Container:Set(prop: {[string]: any} | string, newValue: any | nil)
    assertTrue(prop == nil, "Missing argument")

    if typeof(prop) == "table" then
        for propName, newVal in prop do
            if self.__object[propName] == nil or typeof(newVal) ~= typeof(self.__object[propName]) then
                continue
            end

            self.__object[propName] = newValue
        end

        return nil
    end

    assertTrue(newValue == nil, "Missing argument")

    if self.__object[prop] == nil or typeof(newValue) ~= typeof(self.__object[prop]) then
        return nil
    end

    self.__object[prop] = newValue
    
    return nil
end

--[=[
    @method GetScene
    @within Container

    Returns the [Scene] the [Container] is in.

    @return Scene
]=]

function Container:GetScene()
    return self.Adornee
end

--[=[
    @method Destroy
    @within Container

    Destroys the [Container].

    @return nil
]=]

function Container:Destroy()
    self.__object:Destroy()
    setmetatable(self, nil)

    return nil
end

return Container