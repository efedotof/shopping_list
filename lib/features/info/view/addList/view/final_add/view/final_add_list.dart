import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spisok_pokupok/features/info/bloc/info_bloc_bloc.dart';


@RoutePage()
class FinalAddListScreen extends StatefulWidget {
  const FinalAddListScreen({super.key, required this.bloc});

  final InfoBlocBloc bloc;


  @override
  State<FinalAddListScreen> createState() => _FinalAddListScreenState();
}

class _FinalAddListScreenState extends State<FinalAddListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InfoBlocBloc, InfoBlocState>(
        bloc: widget.bloc,
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                leading: GestureDetector(
                  onTap: () => context.maybePop(),
                  child: const Icon(Icons.arrow_back),
                ),
                pinned: false,
                expandedHeight: 25.0,
                flexibleSpace: const FlexibleSpaceBar(
                  centerTitle: true,
                  expandedTitleScale: 1,
                  title: Text('Это последний шаг!'),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(
                      widget.bloc.selectedElements.length,
                      (index) => Card(
                        child: ListTile(
                          title: Text(
                            widget.bloc.selectedElements[index],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          trailing: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () => widget.bloc.add(RemoveIntElement(index: index)),
                                ),
                                Text(widget.bloc.finalProductInt[index].toString()),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => widget.bloc.add(AddIntElement(index: index)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                      const SizedBox(height: 80,)
                    ]
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF23B87A),
        onPressed: () {
          // log(widget.bloc.name);
          widget.bloc.add( 
            AddNewBox(
              name: widget.bloc.name, 
              titleList: widget.bloc.selectedElements, 
              elementBool: List<bool>.filled(widget.bloc.selectedElements.length, false), 
              elementInt: widget.bloc.finalProductInt, 
              context: context
            )
          );
        }  ,
        child: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
      ),
    );
  }
}






