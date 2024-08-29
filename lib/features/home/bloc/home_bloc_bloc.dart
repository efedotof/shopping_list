import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBlocBloc() : super(HomeBlocInitial()) {
    on<ShowBottomLogin>((event, emit) {
  // showModalBottomSheet(
  //   context: event.context,
  //   shape: const RoundedRectangleBorder(
  //     borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
  //   ),
  //   isScrollControlled: true,
  //   builder: (context) {
  //     return const FractionallySizedBox(
  //       heightFactor: 0.4,
  //       child: SignInOptionsScreen(),
  //     );
  //   },
  // );
  emit(ShowBottomLoginState(context: event.context));
});
  }
}
