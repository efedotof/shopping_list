// ignore_for_file: file_names

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spisok_pokupok/localStorage/LisBoxses/list_box.dart';
import 'package:spisok_pokupok/router/router.dart';


class ListCards extends StatelessWidget {
  const ListCards({
    super.key,
    required this.box,
    required this.index,
  });

  final ListBox box;
  final int index;

  @override
  Widget build(BuildContext context) {
    log(index.toString());
    return GestureDetector(
      onTap: (){ 
        //  context.read<AdsCubit>().showAds();
        context.pushRoute(ShowCardRoute(box: box, targetIndex: index,
      ));
      
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.001),
        child: Stack(
          children: [
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      box.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      box.itemsBoolList.length.toString(),
                      style: const TextStyle(color: Color(0xFF5D5FF0)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
