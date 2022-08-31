import type Scene from "Classes/Scene";

type Array<T> = [T];
type Dictionary<T, U> = {T: U};

declare class Container {
    Push: (obj: GuiObject | Array<GuiObject>) => void;
    Tween: (propertyTable: Dictionary<string, any>, tweenInfo: TweenInfo) => Tween;

    GetScene: () => Scene | null;

    Destroy: () => void;
}

export = Container