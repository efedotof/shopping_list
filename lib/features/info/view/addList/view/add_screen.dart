import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spisok_pokupok/features/info/bloc/info_bloc_bloc.dart';


@RoutePage()
class AddListScreen extends StatefulWidget {
  const AddListScreen({super.key, required this.bloc});

  final InfoBlocBloc bloc;


  @override
  State<AddListScreen> createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchController.text.isNotEmpty) {
        widget.bloc.add(SearchProducts(query: _searchController.text));
      }
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      actions: [
        
        GestureDetector(
          onTap: () =>  widget.bloc.add(AddNewElement(context: context)),
          child: Icon(Icons.add)),
        const SizedBox(width: 10,),
      ],
      title: Hero(
        tag: 'textField',
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
              horizontal: MediaQuery.of(context).size.width * 0.01,
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              // color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(11),
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Что купим ?',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    ),
    body: BlocBuilder<InfoBlocBloc, InfoBlocState>(
      bloc: widget.bloc,
      builder: (context, state) {
        if (_searchController.text.isEmpty) {
          return const Center(child: Text('Начните поиск продуктов'));
        } else if (state is LoadingData) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchResult || state is ElementListUpdated) {
          final products = state is SearchResult
              ? state.products
              : (state as ElementListUpdated).products;
          final selectedElements = state is ElementListUpdated
              ? state.selectedElements
              : widget.bloc.selectedElements;
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      products.length,
                      (index) => GestureDetector(
                        onTap: () => widget.bloc.add(AddElementList(
                            element: products[index].name, index: index)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height *
                                0.001,
                          ),
                          child: Card(
                            color: selectedElements.contains(products[index].name)? Colors.grey : Theme.of(context).cardTheme.color,
                                // ? Colors.white10
                                // : Colors.white,
                            child: ListTile(
                              title: Text(
                                products[index].name,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is SearchResultEmpty) {
          return const Center(child: Text('Ничего не найдено'));
        } else {
          return const Center(child: Text('Начните поиск продуктов'));
        }
      },
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: const Color(0xFF23B87A),
      onPressed: () {
        widget.bloc.add(NextScreenToFinalAdd(context: context, bloc: widget.bloc));
      },
      child: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
      ),
    ),
  );
}
}





