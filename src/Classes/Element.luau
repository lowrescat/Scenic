--[=[
    @class Element
    To incorporate a Container and Scene's methods into a standalone GUI element.
]=]
local CollectionService = game:GetService("CollectionService")

local TweenService = game:GetService("TweenService")

local Classes = script.Parent
local Utility = Classes.Parent.Utility

local Types = require(Utility.Types)
local Shared = require(Utility.Shared)

local Element = {}
Element.__index = Element

local function assertTrue(input: any, errMsg: string)
    if input then
        return error(errMsg)
    end

    return input
end

--[=[
    @function new
    @within Element

    Creates the "Element" object, not particularly recommended as the `Manager.Create()` function handles all creation of classes for you.

    @param propertyTable {[string]: any} | {}

    @return Container
]=]

function Element.new(propertyTable: {[string]: any})
    if propertyTable == nil then
        propertyTable = {}
    end

    local defaultProperties = {
        GuiObject = nil,

        __container = {}
    }

    for propName, propVal in defaultProperties do
        if typeof(propertyTable[propName]) ~= typeof(propVal) then
            propertyTable[propName] = propVal
        end
    end

    CollectionService:AddTag(propertyTable.GuiObject, "Element")

    local self = setmetatable(propertyTable, Element)

    Shared.settype(self, "Element")

    return self
end

--[=[
    @method Tween
    @within Element

    Tweens the [Element] similar to a [Container] or a [Scene] object's respective tween methods.

    @param propertyTable {[string]: any}
    @param tweenInfo TweenInfo

    @return Tween
]=]

function Element:Tween(propertyTable: {[string]: any}, tweenInfo: TweenInfo)
    assertTrue(propertyTable == nil, "Missing argument")

    if typeof(tweenInfo) ~= "TweenInfo" then
        tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear)
    end

    local tween = TweenService:Create(self.GuiObject, tweenInfo, propertyTable)

    return tween
end

--[=[
    @method Push
    @within Element

    Pushes the [Element] into a specified [Container]

    @param container Container

    @return nil
]=]

function Element:Push(container: Types.Container)
    assertTrue(container == nil, "Missing argument")

    local object = container.__object
    self.GuiObject.Parent = object

    table.insert(container.__elements, self.GuiObject)

    return nil
end

--[=[
    @method Set
    @within Element

    Sets any specified properties either in a Dictionary or simply a Tuple.

    @param prop {[string]: any} | string
    @param newValue any | nil

    @return nil
]=]

function Element:Set(prop: {[string]: any} | string, newValue: any | nil)
    assertTrue(prop == nil, "Missing argument")

    if typeof(prop) == "table" then
        for propName, newVal in prop do
            if self.GuiObject[propName] == nil or typeof(newVal) ~= typeof(self.GuiObject[propName]) then
                continue
            end

            self.GuiObject[propName] = newValue
        end

        return nil
    end

    assertTrue(newValue == nil, "Missing argument")

    if self.GuiObject[prop] == nil or typeof(newValue) ~= typeof(self.GuiObject[prop]) then
        return nil
    end

    self.GuiObject[prop] = newValue
    
    return nil
end

--[=[
    @method GetContainer
    @within Element

    Returns the [Container] the [Element] is in.

    @return Container | nil
]=]

function Element:GetContainer()
    if self.__container ~= {} or self.__container ~= nil then
        return self.__container
    end
    
    return nil
end

--[=[
    @method Destroy
    @within Element

    Destroys the [Element]

    @return nil
]=]

function Element:Destroy()
    self.GuiObject:Destroy()
    setmetatable(self, nil)
end

return Element