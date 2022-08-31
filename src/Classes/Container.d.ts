import type Scene from "Classes/Scene";
import type Element from "Classes/Element"

type Array<T> = [T];
type Dictionary<T> = {string: T};

declare class Container {
    Push: (obj: GuiObject | Element | Array<GuiObject | Element>) => void;
    Tween: (propertyTable: Dictionary<any>, tweenInfo: TweenInfo) => Tween;
    Set: (prop: Dictionary<any> | string, newValue: any | null) => void;

    GetScene: () => Scene | null;

    Destroy: () => void;
}

export = Container