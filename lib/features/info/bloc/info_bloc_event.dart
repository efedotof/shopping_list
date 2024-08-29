part of 'info_bloc_bloc.dart';

sealed class InfoBlocEvent extends Equatable {
  const InfoBlocEvent();

  @override
  List<Object> get props => [];
}

class AddNewBox extends InfoBlocEvent {
  final BuildContext context;
  final String name;
  final List<String> titleList;
  final List<bool> elementBool;
  final List<int> elementInt;

  const AddNewBox({
    required this.context,
    required this.name,
    required this.titleList,
    required this.elementBool,
    required this.elementInt,
  });
}




class ShowModal extends InfoBlocEvent {
  final BuildContext context;
  final InfoBlocBloc bloc;

  const ShowModal({
    required this.context,
    required this.bloc,
  });
}

class NextScreenAdd extends InfoBlocEvent {
  final BuildContext context;
  final String title;
  final InfoBlocBloc bloc;

  const NextScreenAdd({
    required this.context,
    required this.title,
    required this.bloc,
  });
}

class SearchProducts extends InfoBlocEvent {
  final String query;

  const SearchProducts({required this.query});
}

class AddElementList extends InfoBlocEvent {
  final String element;
  final int index;

  const AddElementList({
    required this.element,
    required this.index,
  });
}

class NextScreenToFinalAdd extends InfoBlocEvent {
  final BuildContext context;
  final InfoBlocBloc bloc;

  const NextScreenToFinalAdd({
    required this.context,
    required this.bloc,
  });
}

class FinalScreen extends InfoBlocEvent {}

class AddIntElement extends InfoBlocEvent {
  final int index;

  const AddIntElement({required this.index});
}

class RemoveIntElement extends InfoBlocEvent {
  final int index;

  const RemoveIntElement({required this.index});
}

class UpdateIntList extends InfoBlocEvent {
  final List<int> listElement;

  const UpdateIntList({required this.listElement});
}


class UpdateBoolElementShow extends InfoBlocEvent {
  final int index;

  const UpdateBoolElementShow({required this.index});

  @override
  List<Object> get props => [index];
}


class AddNewElement extends InfoBlocEvent{
  final BuildContext context;

  const AddNewElement({required this.context});

}