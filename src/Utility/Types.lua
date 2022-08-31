local Utility = script.Parent
local Classes = Utility.Parent.Classes

--// General Types
export type Properties = {[string]: any} | {}

--// Types
export type Scene = typeof(require(Classes.Scene).new({}))
export type Container = typeof(require(Classes.Container).new({}))
export type Group = typeof(require(Classes.Group).new({}))
export type Element = typeof(require(Classes.Element).new({}))

--// Abstract Types
export type ValidClass =
    Scene |
    Container |
    Group |
    Element

return nil