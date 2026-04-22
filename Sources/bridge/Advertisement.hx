package bridge;

import armory.system.Signal;
import js.Syntax;

class Advertisement {
    public var bannerStateChanged: Signal = new Signal();
    public var interstitialStateChanged: Signal = new Signal();
    public var rewardedStateChanged: Signal = new Signal();
    public var advancedBannersStateChanged: Signal = new Signal();

    public var minimumDelayBetweenInterstitial(get, null): Int;
    public var isBannerSupported(get, null): Bool;
    public var bannerState(get, null): String;
    public var isInterstitialSupported(get, null): Bool;
    public var interstitialState(get, null): String;
    public var isRewardedSupported(get, null): Bool;
    public var rewardedState(get, null): String;
    public var rewardedPlacement(get, null): String;
    public var isAdvancedBannersSupported(get, null): Bool;
    public var advancedBannersState(get, null): String;

    var checkAdBlockCallback: Bool->Void = null;

    public function new() {
        Syntax.code('bridge.advertisement.on(bridge.EVENT_NAME.BANNER_STATE_CHANGED, {0})', onBannerStateChanged);
        Syntax.code('bridge.advertisement.on(bridge.EVENT_NAME.INTERSTITIAL_STATE_CHANGED, {0})', onInterstitialStateChanged);
        Syntax.code('bridge.advertisement.on(bridge.EVENT_NAME.REWARDED_STATE_CHANGED, {0})', onRewardedStateChanged);
        Syntax.code('bridge.advertisement.on(bridge.EVENT_NAME.ADVANCED_BANNERS_STATE_CHANGED, {0})', onAdvancedBannersStateChanged);
    }

    function get_minimumDelayBetweenInterstitial(): Int {
        return Syntax.code('bridge.advertisement.minimumDelayBetweenInterstitial');
    }

    function setMinimumDelayBetweenInterstitial(time: Int) {
        Syntax.code('bridge.advertisement.setMinimumDelayBetweenInterstitial({0})', time);
    }

    function get_isBannerSupported(): Bool {
        return Syntax.code('bridge.advertisement.isBannerSupported');
    }

    function get_bannerState(): String {
        return Syntax.code('bridge.advertisement.bannerState');
    }

    function get_isInterstitialSupported(): Bool {
        return Syntax.code('bridge.advertisement.isInterstitialSupported');
    }

    function get_interstitialState(): String {
        return Syntax.code('bridge.advertisement.interstitialState');
    }

    function get_isRewardedSupported(): Bool {
        return Syntax.code('bridge.advertisement.isRewardedSupported');
    }

    function get_rewardedState(): String {
        return Syntax.code('bridge.advertisement.rewardedState');
    }

    function get_rewardedPlacement(): String {
        return Syntax.code('bridge.advertisement.rewardedPlacement');
    }

    function get_isAdvancedBannersSupported(): Bool {
        return Syntax.code('bridge.advertisement.isAdvancedBannersSupported');
    }

    function get_advancedBannersState(): String {
        return Syntax.code('bridge.advertisement.advancedBannersState');
    }

    public function showBanner(position: String, placement: String) {
        Syntax.code('bridge.advertisement.showBanner({0}, {1})', position, placement);
    }

    public function hideBanner() {
        Syntax.code('bridge.advertisement.hideBanner()');
    }

    public function showInterstitial(?placement: String) {
        Syntax.code('bridge.advertisement.showInterstitial({0})', placement);
    }

    public function showRewarded(?placement: String) {
        Syntax.code('bridge.advertisement.showRewarded({0})', placement);
    }

    public function showAdvancedBanners(?placement: String) {
        Syntax.code('bridge.advertisement.showAdvancedBanners({0})', placement);
    }

    public function hideAdvancedBanners() {
        Syntax.code('bridge.advertisement.hideAdvancedBanners()');
    }

    public function checkAdBlock(callback: Bool->Void) {
        checkAdBlockCallback = callback;
        Syntax.code('bridge.advertisement.checkAdBlock().then({0}).catch({1})', onCheckAdBlockThen, onCheckAdBlockCatch);
    }

    function onBannerStateChanged(state: String) {
        bannerStateChanged.emit(state);
    }

    function onInterstitialStateChanged(state: String) {
        interstitialStateChanged.emit(state);
    }

    function onRewardedStateChanged(state: String) {
        rewardedStateChanged.emit(state);
    }

    function onCheckAdBlockThen(result: Bool) {
        if (checkAdBlockCallback != null) {
            if (result is Bool) checkAdBlockCallback(result);
            else checkAdBlockCallback(false);
            checkAdBlockCallback = null;
        }
    }

    function onCheckAdBlockCatch(error: String) {
        if (checkAdBlockCallback != null) {
            checkAdBlockCallback(false);
            checkAdBlockCallback = null;
        }
    }

    function onAdvancedBannersStateChanged(state: String) {
        advancedBannersStateChanged.emit(state);
    }
}