package bridge;

import js.Syntax;

class RemoteConfig {
    public var isSupported(get, null): Bool;
    var getCallback: (Bool, Any)->Void = null;
    var isGetting: Bool = false;

    public function new() {

    }

    function get_isSupported(): Bool {
        return Syntax.code('bridge.remoteConfig.isSupported');
    }

    public function setContext(context: Any) {
        Syntax.code('bridge.remoteConfig.setContext({0})', context);
    }

    public function get(callback: (Bool, Any)->Void = null) {
        if (isGetting || callback == null) return;

        isGetting = true;
        getCallback = callback;

        Syntax.code('bridge.remoteConfig.get().then({0}).catch({1})', onGetThen, onGetCatch);
    }

    function onGetThen(flags: Any) {
        isGetting = false;
        if (getCallback == null) return;
        getCallback(true, flags);
    }

    function onGetCatch(error: String) {
        isGetting = false;
        if (getCallback == null) return;
        getCallback(false, null);
    }
}