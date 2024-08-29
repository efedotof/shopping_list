part of 'info_bloc_bloc.dart';

sealed class InfoBlocState extends Equatable {
  const InfoBlocState();

  @override
  List<Object> get props => [];
}

final class InfoBlocInitial extends InfoBlocState {}

class ShowModalState extends InfoBlocState {
  final BuildContext context;

  const ShowModalState({required this.context});
}

class SearchResult extends InfoBlocState {
  final List<Product> products;

  const SearchResult({required this.products});

  @override
  List<Object> get props => [products];
}

class LoadingData extends InfoBlocState {}

class ElementListUpdated extends InfoBlocState {
  final List<String> selectedElements;
  final List<Product> products;

  const ElementListUpdated({
    required this.selectedElements,
    required this.products,
  });

  @override
  List<Object> get props => [selectedElements, products];
}

class SearchResultEmpty extends InfoBlocState {}

class FinalScreenData extends InfoBlocState {
  final List<String> list;

  const FinalScreenData({required this.list});
}

class AddIntElementState extends InfoBlocState {
  final int ints;

  const AddIntElementState({required this.ints});
}

class RemoveIntElementState extends InfoBlocState {
  final int ints;

  const RemoveIntElementState({required this.ints});
}

class UpdatedIntList extends InfoBlocState {
  final List<int> listInt;

  const UpdatedIntList({required this.listInt});

  @override
  List<Object> get props => [listInt];
}

class BoxAddedState extends InfoBlocState {
  final ListBox box;

  const BoxAddedState({required this.box});

  @override
  List<Object> get props => [box];
}


class ChangeBoolState extends InfoBlocState {
  final List<bool> boolElement;

  const ChangeBoolState({required this.boolElement});

  @override
  List<Object> get props => [boolElement];
}
