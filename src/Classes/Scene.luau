--[=[
    @class Scene
    The higher collection in the hierarchy, the class that contains the "Container" object.
]=]

local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")

local Classes = script.Parent
local Utility = Classes.Parent.Utility

local Package = require(Classes.Parent)
local Manager = Package.Manager

local Types = require(Utility.Types)
local Shared = require(Utility.Shared)

local Group = require(Classes.Group)

local Scene = {}
Scene.__index = Scene

local function assertTrue(input: any, errMsg: string)
    if input then
        return error(errMsg)
    end

    return input
end

local function getId()
    return #Manager.Scenes + 1
end

--[=[
    @function new
    @within Scene

    Creates the "Scene" object, not particularly recommended as the `Manager.Create()` function handles all creation of classes for you.

    @param propertyTable {[string]: any} | {}

    @return Scene
]=]

function Scene.new(propertyTable: {[string]: any} | {})
    if propertyTable == nil then
        propertyTable = {}
    end

    local defaultProperties = {
        Tag = "Scene",
        Adornee = nil,

        __containers = {},
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
    obj.Parent = propertyTable.Adornee

    CollectionService:AddTag(obj, "Scene")

    local self = setmetatable(propertyTable, Scene)
    self.__object = obj

    Shared.settype(self, "Scene")

    Manager.Scenes[getId()] = self

    return self
end

--[=[
    @method Push
    @within Scene

    Pushes either an array of [GuiObject]s or an individual [GuiObject] into a [Container]

    ```lua
    local Array : {[number]: any} = {
        TextLabel,
        Frame,
        TextButton
    }

    Scene:Push(Array, Container)

    -- OR

    Scene:Push(TextLabel, Container)
    ```

    @param obj {GuiObject} | GuiObject
    @param container Container | string

    @return nil
]=]

function Scene:Push(obj: {GuiObject | Types.Element} | GuiObject | Types.Element, container: Types.Container | string | number)
    assertTrue(obj == nil or container == nil, "Missing argument")

    if typeof(container) == "string" then
        if self:FindContainerFromTag(container) then
            container = self:FindContainerFromTag(container)

            if Shared.typeof(obj) == Types.Element then
                obj = obj.GuiObject
            end

            container:Push(obj)

            return nil
        end

        return error(string.format("Couldn't find Container with the tag %s", container))
    end

    if typeof(container) == "number" then
        if self:FindContainerFromId(container) then
            container = self:FindContainerFromId(container)

            if Shared.typeof(obj) == "Element" then
                obj = obj.GuiObject
            end

            container:Push(obj)

            return nil
        end

        return error(string.format("Couldn't find Container with the ID %d", container))
    end

    container:Push(obj)

    return nil
end

--[=[
    @method Tween
    @within Scene

    Tweens a table of [Container] tags / ids to specified properties and with a specified [TweenInfo].

    ```lua
    local Tween = Scene:Tween({
        ["MyContainer"] = {
            ["Position"] = UDim2.fromScale(.5, .25)
        }
    }, TweenInfo.new(0.5, Enum.EasingStyle.Quad))

    Tween:Play()
    ```

    @param obj {[string | number]: {[string]: any}}
    @param tweenInfo TweenInfo

    @return Tween
]=]

function Scene:Tween(obj: {[string | number]: {[string]: any}}, tweenInfo: TweenInfo)
    assertTrue(obj == nil, "Missing argument")

    if typeof(tweenInfo) ~= "TweenInfo" then
        tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear)
    end

    local newGroup = Group.new()
    newGroup.Tweens = {}

    for tagOrID, properties in obj do
        local container: Types.Container

        if self:FindContainerFromTag(tagOrID) then
            container = self:FindContainerFromTag(tagOrID)
        elseif self:FindContainerFromId(tagOrID) then
            container = self:FindContainerFromId(tagOrID)
        end

        local tween = TweenService:Create(container.__object, tweenInfo, properties)
        newGroup.Tweens[container.Tag] = tween

        print(newGroup)
    end

    return newGroup
end

--[=[
    @method Set
    @within Scene

    Sets any specified properties either in a Dictionary or simply a Tuple.

    @param prop {[string]: any} | string
    @param newValue any | nil

    @return nil
]=]

function Scene:Set(prop: {[string]: any} | string, newValue: any | nil)
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
    @method FindContainerFromTag
    @within Scene

    Finds the [Container] within the [Scene] with the specified tag.

    ```lua
    local Container = Scene:FindContainerFromTag("MyContainer")

    Container:Tween({
        Position = UDim2.fromScale(.5, .5)
    }, TweenInfo.new(.5, Enum.EasingStyle.Quad))
    ```

    @param tag string

    @return Container | nil
]=]

function Scene:FindContainerFromTag(tag: string)
    assertTrue(tag == nil, "Missing argument")

    for _, container in self.__containers do
        if container.Tag == tag then
            return container
        end
    end

    return nil
end

--[=[
    @method FindContainerFromId
    @within Scene

    Similarly to the [FindContainerFromTag] method, this finds the [Container] inside the [Scene] with its ID.

    ```lua
    local Container = Scene:FindContainerFromId(1)
    
    Container:Tween({
        Position = UDim2.fromScale(.5, .5)
    }, TweenInfo.new(.5, Enum.EasingStyle.Quad))
    ```

    @param id string
    
    @return nil
]=]

function Scene:FindContainerFromId(id: string | number)
    assertTrue(typeof(id) ~= "string" or typeof(id) ~= "number", "ID needs to be a string or a number.")

    if typeof(id) == "string" then
        id = tonumber(id)
    end

    if self.__containers[id] then
        return self.__containers[id]
    end

    return nil
end

--[=[
    @method GetContainers
    @within Scene

    Returns every [Container] inside an array to whatever called the method.

    @return Containers {Container}
]=]

function Scene:GetContainers()
    local array: {[number]: any} = {}

    for _, container in self.__containers do
        table.insert(array, container)
    end

    return array
end

--[=[
    @method Destroy
    @within Scene

    Destroys the [Scene].

    @return nil
]=]

function Scene:Destroy()
    self.__object:Destroy()
    setmetatable(self, nil)
end

return Scene