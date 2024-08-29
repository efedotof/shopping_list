part of 'home_bloc_bloc.dart';

sealed class HomeBlocState extends Equatable {
  const HomeBlocState();
  
  @override
  List<Object> get props => [];
}

final class HomeBlocInitial extends HomeBlocState {}

class ShowBottomLoginState extends HomeBlocState{
  final BuildContext context;

  const ShowBottomLoginState({required this.context});
}