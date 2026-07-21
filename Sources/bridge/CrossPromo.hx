package bridge;

import js.Syntax;

class CrossPromo {
    public var isVisible(get, null): Bool;
    var getGamesCallback: (Bool, Array<Any>)->Void = null;

    public function new() {

    }

    function get_isVisible(): Bool {
        return Syntax.code('bridge.crossPromo.isVisible');
    }

    public function getGames(callback: (Bool, Array<Any>)->Void) {
        if (getGamesCallback != null) return;
        getGamesCallback = callback;
        Syntax.code("bridge.crossPromo.getGames().then({0}).catch({1})", onGetGamesThen, onGetGamesCatch);
    }

    function onGetGamesThen(games: Array<Any>) {
        if (getGamesCallback != null) {
            getGamesCallback(true, games);
            getGamesCallback = null;
        }
    }

    function onGetGamesCatch(error: String) {
        if (getGamesCallback != null) {
            getGamesCallback(false, []);
            getGamesCallback = null;
        }
    }

    public function show() {
        Syntax.code("bridge.crossPromo.show()");
    }

    public function hide() {
        Syntax.code("bridge.crossPromo.hide()");
    }
}