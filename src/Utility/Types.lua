local Utility = script.Parent
local Classes = Utility.Parent.Classes

--// General Types
export type Properties = {[string]: any} | {}

--// Types
export type Scene = typeof(require(Classes.Scene).new({}))
export type Container = typeof(require(Classes.Container).new({}))

--// Abstract Types
export type ValidClass =
    Scene |
    Container

return nil