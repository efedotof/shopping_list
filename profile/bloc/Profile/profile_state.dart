part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}


class ClearChash extends ProfileState{}



class UserIsAuth extends ProfileState{}

class UserIsNotAuth extends ProfileState{}
