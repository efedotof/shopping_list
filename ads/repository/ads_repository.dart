import 'dart:developer';
import 'package:yandex_mobileads/mobile_ads.dart';

import 'ads_interface.dart';

class AdsRepository implements AdsInterface {
  late final Future<InterstitialAdLoader> _adLoader;
  InterstitialAd? _ad;

  String adUnitId = 'R-M-2511202-6';

  @override
  Future<InterstitialAdLoader> createInterstitialAd() async {
    return InterstitialAdLoader.create(
      onAdLoaded: (InterstitialAd interstitialAd) {
        _ad = interstitialAd;
      },
      onAdFailedToLoad: (error) {
        _ad = null;
      },
    );
  }

  @override
  Future<void> onLoadClicked() async {
    final adLoader = await _adLoader;
    await adLoader.loadAd(adRequestConfiguration: AdRequestConfiguration(adUnitId: adUnitId));
  }

  @override
  Future<void> showInterstitialAd() async {
    _ad?.setAdEventListener(eventListener: InterstitialAdEventListener(
      onAdShown: () => log('>>>> onAdShow', name: 'ads'),
      onAdFailedToShow: (err) {
        _ad?.destroy();
        _ad = null;
        log('>>>> onAdFailedToShow', name: 'ads');
        onLoadClicked();
      },
      onAdClicked: () {
        log('>>>> onAdClicked', name: 'ads');
      },
      onAdDismissed: () {
        _ad?.destroy();
        _ad = null;
        onLoadClicked();
        log('>>>> onAdDismissed', name: 'ads');
      },
      onAdImpression: (impressionData) => log('>>>> onAdImpression $impressionData', name: 'ads'),
    ));
    await _ad?.show();
    await _ad?.waitForDismiss();
  }

  @override
  Future<void> initAds() async {
    MobileAds.initialize();
    MobileAds.setDebugErrorIndicator(true);
    _adLoader = createInterstitialAd();
    onLoadClicked();
  }
}
