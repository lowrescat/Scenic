import type Container from "Classes/Container"

type Dictionary<T> = {string: T}

declare class Element {
    Push: (container: Container) => void;
    Tween: (propertyTable: Dictionary<any>, tweenInfo: TweenInfo) => Tween;
    Set: (prop: Dictionary<any>, newValue: any | null) => void

    GetContainer: () => Container | null;

    Destroy: () => void;
}

export = Element