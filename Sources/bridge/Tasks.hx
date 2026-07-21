package bridge;

import js.Syntax;

class Tasks {
    var getTasksCallback: (Bool, Array<Any>)->Void = null;
    var addProgressCallback: (Bool, String, Int)->Void = null;
    var claimRewardCallback: Bool->Void = null;

    public function new() {

    }

    public function getTasks(callback: (Bool, Array<Any>)->Void) {
        if (getTasksCallback != null) return;
        getTasksCallback = callback;
        Syntax.code("bridge.tasks.getTasks().then({0}).catch({1})", onGetTasksThen, onGetTasksCatch);
    }

    function onGetTasksThen(tasks: Array<Any>) {
        if (getTasksCallback != null) {
            getTasksCallback(true, tasks);
            getTasksCallback = null;
        }
    }

    function onGetTasksCatch(error: String) {
        if (getTasksCallback != null) {
            getTasksCallback(false, []);
            getTasksCallback = null;
        }
    }

    public function addProgress(metric: String, amount: Int = 1, callback: (Bool, String, Int)->Void) {
        if (addProgressCallback != null) return;
        addProgressCallback = callback;
        Syntax.code("bridge.tasks.addProgress({0}, {1}).then({2}).catch({3})", metrid, amount, onAddProgressThen, onAddProgressCatch);
    }

    function onAddProgressThen() {
        if (addProgressCallback != null) {
            addProgressCallback(true);
            addProgressCallback = null;
        }
    }

    function onAddProgressCatch(error: String) {
        if (addProgressCallback != null) {
            addProgressCallback(false);
            addProgressCallback = null;
        }
    }

    public function claimReward(id: String, callback: Bool->Void) {
        if (claimRewardCallback != null) return;
        claimRewardCallback = callback;
        Syntax.code("bridge.tasks.claimReward({0}).then({1}).catch({2})", id, onClaimRewardThen, onClaimRewardCatch);
    }

    function onClaimRewardThen(claimed: Bool) {
        if (claimRewardCallback != null) {
            claimRewardCallback(claimed);
            claimRewardCallback = null;
        }
    }

    function onClaimRewardCatch(error: String) {
        if (claimRewardCallback != null) {
            claimRewardCallback(false);
            claimRewardCallback = null;
        }
    }
}