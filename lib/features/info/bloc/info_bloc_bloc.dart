import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive_flutter/hive_flutter.dart';
import '../../../localStorage/LisBoxses/list_box.dart';
import '../../../router/router.dart';
import '../widget/sign_in_options_screen.dart';
import 'models/product.dart';

part 'info_bloc_event.dart';
part 'info_bloc_state.dart';

class InfoBlocBloc extends Bloc<InfoBlocEvent, InfoBlocState> {
  InfoBlocBloc() : super(InfoBlocInitial()) {
    on<NextScreenToFinalAdd>((event, emit) {
      if (selectedElements.isNotEmpty) {
        event.context.pushRoute(FinalAddListRoute(bloc: event.bloc));
        finalProductInt = List<int>.filled(selectedElements.length, 1);
      }
    });

    on<UpdateBoolElementShow>((event, emit) async {});

    on<AddNewBox>((event, emit) async {
      final box = Hive.box<ListBox>('listbox');
      final newBox = ListBox(
        name: event.name,
        itemsList: event.titleList,
        itemsBoolList: event.elementBool,
        itemsIntList: event.elementInt,
      );
      await box.add(
        newBox,
      );
      AutoRouter.of(event.context).replaceAll([const InfoRoute()]);
      emit(BoxAddedState(box: newBox));
    });

    on<AddIntElement>((event, emit) {
      if (finalProductInt[event.index] < 99) {
        finalProductInt[event.index]++;
        emit(UpdatedIntList(listInt: List.from(finalProductInt)));
      }
    });

    on<RemoveIntElement>((event, emit) {
      if (finalProductInt[event.index] > 1) {
        finalProductInt[event.index]--;
        emit(UpdatedIntList(listInt: List.from(finalProductInt)));
      }
    });

    on<AddElementList>((event, emit) {
      if (selectedElements.contains(event.element)) {
        selectedElements.remove(event.element);
      } else {
        selectedElements.add(event.element);
      }
      emit(ElementListUpdated(
        selectedElements: List.from(selectedElements),
        products: state is SearchResult
            ? (state as SearchResult).products
            : (state is ElementListUpdated)
                ? (state as ElementListUpdated).products
                : [],
      ));
    });

    on<ShowModal>((event, emit) {
      _removeFull();
      showModalBottomSheet(
        context: event.context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        isScrollControlled: true,
        builder: (context) {
          return SignInOptionsScreen(bloc: event.bloc);
        },
      );
      emit(ShowModalState(context: event.context));
    });

    on<AddNewElement>((event, emit) {
      TextEditingController _name = TextEditingController();

      showModalBottomSheet(
        context: event.context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Wrap(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Свой продукт',
                        style: TextStyle(
                            color: Color(0xFF252E8F),
                            fontWeight: FontWeight.normal,
                            fontSize: 22),
                      ),
                      const SizedBox(height: 20),
                      Hero(
                        tag: 'textField',
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.01,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.01,
                          ),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: TextField(
                            maxLines: 1,
                            controller: _name,
                            onChanged: (value) {
                              _name.text = value;
                              // setState(() {
                              //   _controller.text = value;
                              // });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Название',
                              prefixIcon: Icon(Icons.add),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          selectedElements.add(_name.text);
                          _name.text = '';
                          context.maybePop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF5D5FF0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: const Text(
                            'Добавить',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
          // return SignInOptionsScreen(bloc: event.bloc);
        },
      );
    });

    on<NextScreenAdd>((event, emit) {
      name = event.title;
      if (name.isNotEmpty) {
        event.context.maybePop();
        event.context.pushRoute(AddListRoute(bloc: event.bloc));
        emit(LoadingData());
      }
    });

    on<SearchProducts>((event, emit) async {
      emit(LoadingData());
      final products = await searchProducts(event.query);
      if (products.isEmpty) {
        emit(SearchResultEmpty());
      } else {
        emit(SearchResult(products: products));
      }
    });
  }

  String? _cachedJsonString;
  List<Product>? _cachedProducts;

  Future<void> _loadProducts() async {
    _cachedJsonString ??=
        await rootBundle.loadString('assets/data/product.json');

    if (_cachedProducts == null) {
      Map<String, dynamic> jsonResponse = json.decode(_cachedJsonString!);
      List<dynamic> listNames = jsonResponse['ListNames'];
      _cachedProducts =
          listNames.map((name) => Product.fromJson(name)).toList();
    }

    boolElement = List<bool>.filled(_cachedProducts!.length, false);
  }

  Future<List<Product>> searchProducts(String query) async {
    await _loadProducts();

    query = query.toLowerCase();
    return _cachedProducts!
        .where((product) => product.name.toLowerCase().contains(query))
        .toList();
  }

  void _removeFull() {
    name = '';
    boolElement = [];
    selectedElements = [];
    finalProductInt = [];
  }

  String name = '';
  List<bool> boolElement = [];
  List<String> selectedElements = [];
  List<int> finalProductInt = [];
}
