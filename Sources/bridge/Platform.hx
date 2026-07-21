package bridge;

import armory.system.Signal;
import js.Syntax;

class Platform {
    public var audioStateChanged: Signal = new Signal();
    public var pauseStateChanged: Signal = new Signal();

    public var id(get, null): String;
    public var sdk(get, null): String;
    public var language(get, null): String;
    public var payload(get, null): String;
    public var tld(get, null): String;
    public var isAudioEnabled(get, null): Bool;
    public var isExternalCallsSupported(get, null): Bool;
    public var isExternalLinksAllowed(get, null): Bool;

    var getServerTimeCallback: Int->Void = null;

    public function new() {
        Syntax.code('bridge.platform.on(bridge.EVENT_NAME.AUDIO_STATE_CHANGED, {0})', onAudioStateChanged);
        Syntax.code('bridge.platform.on(bridge.EVENT_NAME.PAUSE_STATE_CHANGED, {0})', onPauseStateChanged);
    }

    function get_id(): String {
        return Syntax.code('bridge.platform.id');
    }

    function get_sdk(): Null<String> {
        return Syntax.code('bridge.platform.sdk');
    }

    function get_language(): String {
        return Syntax.code('bridge.platform.language');
    }

    function get_payload(): Null<String> {
        return Syntax.code('bridge.platform.payload');
    }

    function get_tld(): Null<String> {
        return Syntax.code('bridge.platform.tld');
    }

    function get_isAudioEnabled(): Bool {
        return Syntax.code('bridge.platform.isAudioEnabled');
    }

    function get_isExternalCallsSupported(): Bool {
        return Syntax.code('bridge.platform.isExternalCallsSupported');
    }

    function get_isExternalLinksAllowed(): Bool {
        return Syntax.code('bridge.platform.isExternalLinksAllowed');
    }

    public function sendMessage(message: String, ?options: Any = null) {
        Syntax.code('bridge.platform.sendMessage({0}, {1})', message, options);
    }

    public function sendCustomMessage(id: String, ?options: Any = null) {
        Syntax.code('bridge.platform.sendCustomMessage({0}, {1})', id, options);
    }

    public function getServerTime(callback: Int->Void): Void {
        if (getServerTimeCallback != null) return;
        getServerTimeCallback = callback;
        Syntax.code('bridge.platform.getServerTime().then({0}).catch({1})', onGetServerTimeThen, onGetServerTimeCatch);
    }

    function onGetServerTimeThen(result: Int): Void {
        if (getServerTimeCallback != null) {
            if (result is Int) getServerTimeCallback(result);
            else getServerTimeCallback(0);
            getServerTimeCallback = null;
        }
    }

    function onGetServerTimeCatch(error: String) {
        if (getServerTimeCallback != null) {
            getServerTimeCallback(0);
            getServerTimeCallback = null;
        }
    }

    function onAudioStateChanged(isEnabled: Bool) {
        audioStateChanged.emit(isEnabled);
    }

    function onPauseStateChanged(isPaused: Bool) {
        pauseStateChanged.emit(isPaused);
    }
}
