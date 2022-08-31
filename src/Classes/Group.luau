--[=[
    @class Group
    Allows you to play multiple [Tween] objects at once.
]=]

local Classes = script.Parent
local Utility = Classes.Parent.Utility

local Shared = require(Utility.Shared)

local Group = {}
Group.__index = Group

--[=[
    @function new
    @within Group

    Creates the "Group" object, not particularly recommended as the `Manager.Create()` function handles all creation of classes for you.

    @param propertyTable {[string]: any} | {}

    @return Group
]=]

function Group.new(propertyTable: {[string]: any} | {})
    if propertyTable == nil then
        propertyTable = {}
    end

    local defaultProperties = {
        Tweens = {}
    }

    for propName, propVal in defaultProperties do
        if typeof(propertyTable[propName]) ~= typeof(propVal) then
            propertyTable[propName] = propVal
        end
    end

    local self = setmetatable(propertyTable, Group)

    Shared.settype(self, "Group")

    return self
end

--[=[
    @method PlayAll
    @within Group

    Plays every [Tween] inside the [Group].

    @return nil
]=]

function Group:PlayAll()
    for _, Tween in self.Tweens do
        Tween:Play()
    end

    return nil
end

--[=[
    @method PauseAll
    @within Group

    Pauses every [Tween] inside the [Group].

    @return nil
]=]

function Group:PauseAll()
    for _, Tween in self.Tweens do
        Tween:Pause()
    end

    return nil
end

--[=[
    @method CancelAll
    @within Group

    Cancels every [Tween] inside the [Group].

    @return nil
]=]

function Group:CancelAll()
    for _, Tween in self.Tweens do
        Tween:Cancel()
    end

    return nil
end

--[=[
    @method Play
    @within Group

    Plays the [Tween] inside the [Group] with the tag specified.

    @param tag string

    @return nil
]=]

function Group:Play(tag: string)
    if tag == nil then
        self:PlayAll()

        return nil
    end

    self.Tweens[tag]:Play()

    return nil
end

--[=[
    @method Pause
    @within Group

    Pauses the [Tween] inside the [Group] with the tag specified.

    @param tag string
    
    @return nil
]=]

function Group:Pause(tag: string)
    if tag == nil then
        self:PauseAll()

        return nil
    end

    self.Tweens[tag]:Pause()

    return nil
end

--[=[
    @method Cancel
    @within Group

    Cancels the [Tween] inside the [Group] with the tag specified.

    @param tag string
    
    @return nil
]=]

function Group:Cancel(tag: string)
    if tag == nil then
        self:CancelAll()

        return nil
    end

    self.Tweens[tag]:Cancel()

    return nil
end

return Group