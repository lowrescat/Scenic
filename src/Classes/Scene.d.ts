import type Container from "Classes/Container";
import type Element from "Classes/Element"

type Array<T> = [T];
type Dictionary<T> = {string: T | Dictionary<T>};

declare class Scene {
    Push: (obj: GuiObject | Element | Array<GuiObject | Element>) => void;
    Tween: (obj: Dictionary<any>, tweenInfo: TweenInfo) => Tween;
    Set: (prop: Dictionary<any> | string, newValue: any | null) => void;

    FindContainerFromTag: (tag: string) => Container | null;
    FindContainerFromId: (id: string | number) => Container | null;
    GetContainers: () => Array<Container>;
}

export = Scene