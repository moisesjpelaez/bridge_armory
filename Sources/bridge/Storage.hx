package bridge;

import js.Syntax;

class Storage {
    var isGetting: Bool = false;
    var getCallback: (Bool, Any)->Void = null;
    var isSetting: Bool = false;
    var setCallback: Bool->Void = null;
    var isDeleting: Bool = false;
    var deleteCallback: Bool->Void = null;

    public function new() {

    }

    public function get(key: Any, callback: (Bool, Any)->Void = null) {
        if (isGetting || callback == null) return;
        isGetting = true;
        getCallback = callback;
        Syntax.code('bridge.storage.get({0}).then({1}).catch({2})', key, onGetThen, onGetCatch);
    }

    function onGetThen(data: Any) {
        isGetting = false;
        if (getCallback != null) getCallback(true, data);
    }

    function onGetCatch(error: String) {
        isGetting = false;
        if (getCallback != null) getCallback(false, null);
    }

    public function set(key: Any, value: Any, callback: Bool->Void = null) {
        if (isSetting) return;
        isSetting = true;
        setCallback = callback;
        Syntax.code('bridge.storage.set({0}, {1}).then({2}).catch({3})', key, value, onSetThen, onSetCatch);
    }

    function onSetThen() {
        isSetting = false;
        if (setCallback != null) setCallback(true);
    }

    function onSetCatch(error: String) {
        isSetting = false;
        if (setCallback != null) setCallback(false);
    }

    public function delete(key: Any, callback: Bool->Void = null,) {
        if (isDeleting) return;
        isDeleting = true;
        deleteCallback = callback;
        Syntax.code('bridge.storage.delete({0}).then({1}).catch({2})', key, onDeleteThen, onDeleteCatch);
    }

    function onDeleteThen() {
        isDeleting = false;
        if (deleteCallback != null) deleteCallback(true);
    }

    function onDeleteCatch(error: String) {
        isDeleting = false;
        if (deleteCallback != null) deleteCallback(false);
    }
}
