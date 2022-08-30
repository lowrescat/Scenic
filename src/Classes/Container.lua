--[=[
    @class Container
    The collection which holds all of the UI elements.
]=]

local TweenService = game:GetService("TweenService")

local Container = {}
Container.__index = Container
Container.__type = "Container"

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

    local self = setmetatable(propertyTable, Container)
    self.__object = obj

    table.insert(self:GetScene().__containers, self)

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

function Container:Push(obj: {GuiObject} | GuiObject)
    assertTrue(obj == nil, "Missing argument")

    if typeof(obj) == "table" then
        for _, elmn in obj do
            elmn.Parent = self.__object
            table.insert(self.__elements, elmn)
        end

        return nil
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
end

return Container