--[=[
    @class Manager
    Controls all your Scenes.
]=]

local Classes = script.Parent.Classes
local Utility = script.Parent.Utility

local Types = require(Utility.Types)

local Manager = {}
Manager.__type = "Manager"

Manager.Scenes = {}

local function assertTrue(input: any, errMsg: string)
    if input then
        return error(errMsg)
    end

    return input
end

--[=[
    @function Create
    @within Manager

    Creates any of the classes specified with a class name.

    ```lua
    local Manager = Scenic.Manager

    local Scene = Manager.Create("Scene", {
        Tag = "MyFirstScene",
        Adornee = script.Parent
    })
    ```

    @param className string
    @param propertyTable {[string]: any} | nil

    @return Class
]=]

function Manager.Create(className: string, propertyTable: {[string]: any} | nil)
    if propertyTable == nil then 
        propertyTable = {} 
    end

    if Classes[className] then
        local newClass = require(Classes[className]).new(propertyTable)

        return newClass :: Types.ValidClass
    end

    return error(string.format("Class %s doesn't exist.", className))
end

--[=[
    @function GetScenes
    @within Manager

    Gets all [Scene] objects and returns them in an array to you.

    @return {Scene} | nil
]=]

function Manager.GetScenes()
    local array: {[number]: any} = {}

    for _, scene in Manager.Scenes do
        table.insert(array, scene)
    end

    return array
end

--[=[
    @function FindSceneFromTag
    @within Manager

    Finds any specified scene with a specified tag, set during the creation process of the [Scene] itself.

    @param tag string

    @return Scene | nil
]=]

function Manager.FindSceneFromTag(tag: string)
    assertTrue(tag == nil, "Missing argument")

    for _, scene in Manager.Scenes do
        if scene.Tag == tag then
            return scene
        end
    end

    return nil
end

--[=[
    @function FindSceneFromId
    @within Manager

    Finds any specified scene with its set ID, which is set during the inner-process of a [Scene]'s creation.

    @param id number

    @return Scene | nil
]=]

function Manager.FindSceneFromId(id: number)
    assertTrue(id == nil, "Missing argument")

    if Manager.Scenes[id] then
        return Manager.Scenes[id]
    end

    return nil
end

return Manager