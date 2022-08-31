type Array<T> = [T]

declare class Group {
    PlayAll: () => void;
    PauseAll: () => void;
    CancelAll: () => void;
    
    Play: (tag: string) => void;
    Pause: (tag: string) => void;
    Cancel: (tag: string) => void;
}

export = Group