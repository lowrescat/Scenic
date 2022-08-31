import type Container from "Classes/Container"
import type Scene from "Classes/Scene"
import type Group from "Classes/Group"
import type Element from "Classes/Element"

type Array<T> = [T]

type ValidClass = 
Container | Scene | Group | Element

declare namespace Manager {
    export type Create = (className: string, props: {string: any}) => ValidClass
    export type Push = (obj: GuiObject | Array<GuiObject>, toPushInto: number | string | Scene | Container, toPushIntoSecondly: number | string | Container) => void

    export type GetScenes = () => Array<Scene> | null
    export type FindSceneFromId = (id: number) => Scene | null
    export type FindSceneFromTag = (tag: string) => Scene | null
}

export = Manager