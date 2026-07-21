package bridge;

import js.Syntax;

class Achievements {
    var unlockCallback: Bool->Void = null;
    var getAchievementsCallback: Bool->Void = null;

    public function new(): Void {

    }

    public function unlock(id: String, callback: Bool->Void = null): Void {
        if (unlockCallback != null) return;
        unlockCallback = callback;
        Syntax.code("bridge.achievements.unlock({0}).then({1}).catch({2})", id, onUnlockThen, onUnlockCatch);
    }

    function onUnlockThen(): Void {
        if (unlockCallback != null) {
            unlockCallback(true);
            unlockCallback = null;
        }
    }

    function onUnlockCatch(error: String): Void {
        if (unlockCallback != null) {
            unlockCallback(false);
            unlockCallback = null;
        }
    }

    public function getAchievements() {
        if (getAchievementsCallback != null) return;
        getAchievementsCallback = callback;
        Syntax.code("bridge.achievements.getAchievements().then({0}).catch({1})", onGetAchievementsThen, onGetAchievementsCatch);
    }

    function onGetAchievementsThen(list: Array<Any>): Void {
        if (getAchievementsCallback != null) {
            getAchievementsCallback(true, list);
            getAchievementsCallback = null;
        }
    }

    function onGetAchievementsCatch(error: String): Void {
        if (getAchievementsCallback != null) {
            getAchievementsCallback(false, []);
            getAchievementsCallback = null;
        }
    }
}
