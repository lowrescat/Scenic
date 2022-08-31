import type Manager from "Manager"

interface Scenic {
    Create: Manager.Create;
    Push: Manager.Push;

    FindSceneFromTag: Manager.FindSceneFromTag;
    FindSceneFromId: Manager.FindSceneFromId;
}  

export = Scenic;