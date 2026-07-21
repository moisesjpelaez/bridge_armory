package bridge;

import js.Syntax;

class Clipboard {
    public var isSupported(get, null): Bool;
    var writeCallback: Bool->Void = null;
    var readCallback: (Bool, String)->Void = null;

    public function new() {

    }

    function get_isSupported(): Bool {
        return Syntax.code('bridge.clipboard.isSupported');
    }

    public function write(text: String, callback: Bool->Void = null) {
        if (writeCallback != null) return;
        writeCallback = callback;
        Syntax.code("bridge.clipboard.write({0}).then({1}).catch({2})", text, onWriteThen, onWriteCatch);
    }

    function onWriteThen() {
        if (writeCallback != null) {
            writeCallback(true);
            writeCallback = null;
        }
    }

    function onWriteCatch(error: String) {
        if (writeCallback != null) {
            writeCallback(false);
            writeCallback = null;
        }
    }

    public function read(callback: (Bool, String)->Void) {
        readCallback = callback;
        Syntax.code("bridge.clipboard.read().then({0}).catch({1})", onReadThen, onReadCatch);
    }

    function onReadThen(text: String) {
        if (readCallback != null) {
            readCallback(true, text);
            readCallback = null;
        }
    }

    function onReadCatch(error: String) {
        if (readCallback != null) {
            readCallback(false, "");
            readCallback = null;
        }
    }
}