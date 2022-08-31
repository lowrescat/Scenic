import type Manager from "Manager"

interface Scenic {
    Create: Manager.Create;

    FindSceneFromTag: Manager.FindSceneFromTag;
    FindSceneFromId: Manager.FindSceneFromId;
}  

export = Scenic;