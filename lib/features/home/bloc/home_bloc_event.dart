part of 'home_bloc_bloc.dart';

sealed class HomeBlocEvent extends Equatable {
  const HomeBlocEvent();

  @override
  List<Object> get props => [];
}



class ShowBottomLogin extends HomeBlocEvent{
  final BuildContext context;

  const ShowBottomLogin({required this.context});
}