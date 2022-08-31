import type Container from "Classes/Container";

type Array<T> = [T];
type Dictionary<T> = {string: T | Dictionary<T>};

declare class Scene {
    Push: (obj: GuiObject | Array<GuiObject>, container: Container | string) => void;
    Tween: (obj: Dictionary<any>, tweenInfo: TweenInfo) => Tween;

    SetPosition: (newPos: UDim2, container: Container | string) => void;

    FindContainerFromTag: (tag: string) => Container | null;
    FindContainerFromId: (id: string | number) => Container | null;
    GetContainers: () => Array<Container>;

    Destroy: () => void;
}

export = Scene