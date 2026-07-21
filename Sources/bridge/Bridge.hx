package bridge;

import js.Syntax;

class Bridge {
    public static var achievements: Achievements = new Achievements();
    public static var advertisement: Advertisement = new Advertisement();
    public static var crossPromo: CrossPromo = new CrossPromo();
    public static var dailyRewards: DailyRewards = new DailyRewards();
    public static var device: Device = new Device();
    public static var leaderboards: Leaderboards = new Leaderboards();
    public static var payments: Payments = new Payments();
    public static var platform: Platform = new Platform();
    public static var player: Player = new Player();
    public static var remoteConfig: RemoteConfig = new RemoteConfig();
    public static var social: Social = new Social();
    public static var storage: Storage = new Storage();
    public static var tasks: Tasks = new Tasks();

    public static function setGameLoadingProgress(percent: Int) {
        Syntax.code("bridge.setGameLoadingProgress({0})", percent);
    }
}
