package bridge;

import js.Syntax;

class DailyRewards {
    var getRewardsCallback: (Bool, Array<String>)->Void = null;
    var getCurrentDayCallback: (Bool, Int)->Void = null;
    var getCurrentRewardCallback: (Bool, String)->Void = null;
    var claimCurrentRewardCallback: Bool->Void = null;

    public function new() {

    }

    public function getRewards(callback: (Bool, Array<String>)->Void) {
        if (getRewardsCallback != null) return;
        getRewardsCallback = callback;
        Syntax.code("bridge.dailyRewards.getRewards().then({0}).catch({1})", onGetRewardsThen, onGetRewardsCatch);
    }

    function onGetRewardsThen(rewards: Array<String>) {
        if (getRewardsCallback != null) {
            getRewardsCallback(true, rewards);
            getRewardsCallback = null;
        }
    }

    function onGetRewardsCatch(error: String) {
        if (getRewardsCallback != null) {
            getRewardsCallback(false, []);
            getRewardsCallback = null;
        }
    }

    public function getCurrentDay(callback: (Bool, Int)->Void) {
        if (getCurrentDayCallback != null) return;
        getCurrentDayCallback = callback;
        Syntax.code("bridge.dailyRewards.getCurrentDay().then({0}).catch({1})", onGetCurrentDayThen, onGetCurrentDayCatch);
    }

    function onGetCurrentDayThen(day: Int) {
        if (getCurrentDayCallback != null) {
            getCurrentDayCallback(true, day);
            getCurrentDayCallback = null;
        }
    }

    function onGetCurrentDayCatch(error: String) {
        if (getCurrentDayCallback != null) {
            getCurrentDayCallback(false, 0);
            getCurrentDayCallback = null;
        }
    }

    public function getCurrentReward(callback: (Bool, String)->Void) {
        if (getCurrentRewardCallback != null) return;
        getCurrentRewardCallback = callback;
        Syntax.code("bridge.dailyRewards.getCurrentReward().then({0}).catch({1})", onGetCurrentRewardThen, onGetCurrentRewardCatch);
    }

    function onGetCurrentRewardThen(reward: String) {
        if (getCurrentRewardCallback != null) {
            getCurrentRewardCallback(true, reward);
            getCurrentRewardCallback = null;
        }
    }

    function onGetCurrentRewardCatch(error: String) {
        if (getCurrentRewardCallback != null) {
            getCurrentRewardCallback(false, null);
            getCurrentRewardCallback = null;
        }
    }

    public function claimCurrentReward(callback: Bool->Void) {
        if (claimCurrentRewardCallback != null) return;
        claimCurrentRewardCallback = callback;
        Syntax.code("bridge.dailyRewards.claimCurrentReward().then({0}).catch({1})", onClaimCurrentRewardThen, onClaimCurrentRewardCatch);
    }

    function onClaimCurrentRewardThen() {
        if (claimCurrentRewardCallback != null) {
            claimCurrentRewardCallback(true);
            claimCurrentRewardCallback = null;
        }
    }

    function onClaimCurrentRewardCatch(error: String) {
        if (claimCurrentRewardCallback != null) {
            claimCurrentRewardCallback(false);
            claimCurrentRewardCallback = null;
        }
    }
}