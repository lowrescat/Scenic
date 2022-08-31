--[[
    Thanks alot Luau engineers >:(
--]]

local Shared = {}
local Types = setmetatable({}, {
    __mode = "k"
})

function Shared.settype(object: any, typeName: string, noProperties: boolean)
    if noProperties or typeof(object) ~= "table" then
        Types[object] = typeName
        return nil
    end

    local success = pcall(function()
        local metatable = getmetatable(object) or object
        rawset(metatable, "__type", typeName)
    end)

    if not success then
        rawset(object, "__type", typeName)
    end
end

function Shared.typeof(object: any)
    if typeof(object) ~= "table" or Types[object] then
        return Types[object] or typeof(object)
    end

    local target = getmetatable(object) or object

    if typeof(target) ~= "table" then
        target = object
    end

    return rawget(target, "__type") or typeof(object)
end

return Shared