import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spisok_pokupok/ads/cubit/ads_cubit.dart';
import 'package:spisok_pokupok/features/info/bloc/info_bloc_bloc.dart';

import '../../../localStorage/LisBoxses/list_box.dart';
import '../widget/widget.dart';

@RoutePage()
class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final listBoxs = Hive.box<ListBox>('listbox');
  late InfoBlocBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<InfoBlocBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InfoBlocBloc(),
      child: BlocBuilder<InfoBlocBloc, InfoBlocState>(
        bloc: _bloc,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              elevation: 1,
              automaticallyImplyLeading: false,
              title: const Text('Ваш список'),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: ValueListenableBuilder(
                valueListenable: listBoxs.listenable(),
                builder: (context, Box<ListBox> box, _) {
                  if (box.values.isEmpty) {
                    return const Center(
                      child: Text('Список пуст 🤔'),
                    );
                  }
                  var keyss = box.keys.toString();
                  log(keyss);
                  return  ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      final listBoxItem =
                          box.getAt(box.values.length - index - 1)!;
                      return Dismissible(
                        background: const SlideRightBackground(),
                        key: ValueKey<int>(box.values.length),
                        secondaryBackground: const SlideLeftBackground(),
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Подтвердите удаление"),
                                  content: const Text(
                                      "Вы уверены, что хотите удалить этот элемент?"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text("Отмена"),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text("Удалить"),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return false;
                          }
                        },
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            int currentIndex = box.values.length - index - 1;
                            box.deleteAt(currentIndex);
                          }
                        },
                        
                        child: ListCards(
                          box: listBoxItem,
                          index: box.values.length - index - 1,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xFF23B87A),
              onPressed: (){
                  context.read<AdsCubit>().showAds();
                 _bloc.add(ShowModal(context: context, bloc: _bloc));
              },
                 
              child: const Icon(Icons.add_circle, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
