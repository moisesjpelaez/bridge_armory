package bridge;

import js.Syntax;

class Notifications {
    public var isSupported(get, null): Bool;

    var scheduleCallback: Bool->Void = null;
    var cancelCallback: Bool->Void = null;
    var cancelAllCallback: Bool->Void = null;

    public function new() {

    }

    function get_isSupported(): Bool {
        return Syntax.code('bridge.notifications.isSupported');
    }

    public function schedule(options: Any = null, callback: Bool->Void = null) {
        if (scheduleCallback != null) return;
        scheduleCallback = callback;
        Syntax.code('bridge.notifications.schedule({0}).then({1}).catch({2})', options, onScheduleThen, onScheduleCatch);
    }

    function onScheduleThen() {
        if (scheduleCallback != null) {
            scheduleCallback(true);
            scheduleCallback = null;
        }
    }

    function onScheduleCatch(error: String) {
        if (scheduleCallback != null) {
            scheduleCallback(false);
            scheduleCallback = null;
        }
    }

    public function cancel(callback: Bool->Void = null) {
        if (cancelCallback != null) return;
        cancelCallback = callback;
        Syntax.code('bridge.notifications.cancel().then({0}).catch({1})', onCancelThen, onCancelCatch);
    }

    function onCancelThen() {
        if (cancelCallback != null) {
            cancelCallback(true);
            cancelCallback = null;
        }
    }

    function onCancelCatch(error: String) {
        if (cancelCallback != null) {
            cancelCallback(false);
            cancelCallback = null;
        }
    }

    public function cancelAll(callback: Bool->Void = null) {
        if (cancelAllCallback != null) return;
        cancelAllCallback = callback;
        Syntax.code('bridge.notifications.cancelAll().then({0}).catch({1})', onCancelAllThen, onCancelAllCatch);
    }

    function onCancelAllThen() {
        if (cancelAllCallback != null) {
            cancelAllCallback(true);
            cancelAllCallback = null;
        }
    }

    function onCancelAllCatch(error: String) {
        if (cancelAllCallback != null) {
            cancelAllCallback(false);
            cancelAllCallback = null;
        }
    }
}