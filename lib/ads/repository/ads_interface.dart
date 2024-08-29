
import 'package:yandex_mobileads/mobile_ads.dart';

abstract interface class AdsInterface{
  Future<InterstitialAdLoader> createInterstitialAd();
  Future<void> showInterstitialAd();
  Future<void> onLoadClicked();
  Future<void> initAds();


}