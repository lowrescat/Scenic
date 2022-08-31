import type Container from "Classes/Container"
import type Scene from "Classes/Scene"

type Array<T> = [T]

declare namespace Manager {
    export type Create = (className: string, props: {string: any}) => Scene | Container
    export type Push = (obj: GuiObject | Array<GuiObject>, toPushInto: number | string | Scene | Container, toPushIntoSecondly: number | string | Container) => void

    export type FindSceneFromId = (id: number) => Scene | null
    export type FindSceneFromTag = (tag: string) => Scene | null
}

export = Manager