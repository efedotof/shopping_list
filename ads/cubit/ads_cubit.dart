

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spisok_pokupok/ads/repository/ads_interface.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit({required AdsInterface interf}) : _interf = interf, super(AdsInitial()){
    ads();
  }

  final AdsInterface _interf;


   void ads() async {
    _interf.initAds();
  }

  void showAds()async{
    _interf.showInterstitialAd();
    // Timer(const Duration(seconds: 160), ()=> _interf.showInterstitialAd());
  }

  


}
