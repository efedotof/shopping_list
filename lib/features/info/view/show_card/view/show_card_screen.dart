import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spisok_pokupok/localStorage/LisBoxses/list_box.dart';

@RoutePage()
class ShowCardScreen extends StatefulWidget {
  const ShowCardScreen({
    super.key,
    required this.targetIndex,
    required this.box,
  });

  final int targetIndex;
  final ListBox box;

  @override
  State<ShowCardScreen> createState() => _ShowCardScreenState();
}

class _ShowCardScreenState extends State<ShowCardScreen> {
  late Box<ListBox> _box;
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    _box = Hive.box<ListBox>('listBox'); // Предполагается, что коробка уже открыта
  }

  void _toggleItem(int index) async {
    setState(() {
      widget.box.itemsBoolList[index] = !widget.box.itemsBoolList[index];
    });

    await _box.putAt(widget.targetIndex, widget.box);
  }

  Future<void> _shareList() async {
    final Uint8List? imageBytes = await _screenshotController.capture();
    if (imageBytes != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/shopping_list.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(imageBytes);

      final xFile = XFile(imagePath);

      await Share.shareXFiles([xFile], text: 'Хочу поделиться с тобой списком продуктов:');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.box.name),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: _shareList,
            child: const Icon(Icons.share),
          ),
          const SizedBox(width: 10),
        ],
        leading: GestureDetector(
          onTap: () => context.maybePop(),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Screenshot(
        controller: _screenshotController,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    widget.box.itemsList.length,
                    (index) => Card(
                      child: GestureDetector(
                        onTap: () => _toggleItem(index),
                        child: ListTile(
                          title: Text(widget.box.itemsList[index]),
                          trailing: Text(widget.box.itemsIntList[index].toString()),
                          leading: Container(
                            width: MediaQuery.of(context).size.width * 0.08,
                            height: MediaQuery.of(context).size.height * 0.08,
                            decoration: BoxDecoration(
                              color: widget.box.itemsBoolList[index]
                                  ? const Color(0xFF2ABC7E)
                                  : const Color(0xFFD8D9DD),
                              shape: BoxShape.circle,
                            ),
                            child: widget.box.itemsBoolList[index]
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
