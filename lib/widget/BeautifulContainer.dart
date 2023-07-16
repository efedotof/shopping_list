// ignore: file_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeautifulContainer extends StatefulWidget {
  const BeautifulContainer({
    Key? key,
    required this.title,
    // ignore: non_constant_identifier_names
    required this.list_name_product,
    // ignore: non_constant_identifier_names
    required this.Deleate_settings,
    // required this.date_info,
  }) : super(key: key);

  final String title;
  // ignore: non_constant_identifier_names
  final List<String> list_name_product;
  // ignore: non_constant_identifier_names
  final void Function() Deleate_settings;
  // final String date_info;

  @override
  State<BeautifulContainer> createState() => _BeautifulContainerState();

  static fromString(String containerString) {}
}

class _BeautifulContainerState extends State<BeautifulContainer> {
  bool isLongPressed = false;
  List<bool> isCheckedList = [];

  @override
  void initState() {
    super.initState();
    isCheckedList = List<bool>.filled(widget.list_name_product.length, false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isAllChecked = isCheckedList.every((isChecked) => isChecked);

    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.transparent),
      onDismissed: (direction) {
        widget.Deleate_settings();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            if (mounted) {
              setState(() {
                isLongPressed = true;
              });
              Future.delayed(const Duration(seconds: 3), () {
                if (mounted) {
                  setState(() {
                    isLongPressed = false;
                  });
                }
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blueAccent,
            ),
            padding: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isLongPressed)
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                if (mounted) {
                                  widget.Deleate_settings();
                                }
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ],
                        ),
                        
                    ],
                    
                  ),
                  Container(color: Colors.white,height: 1,),
                  for (int i = 0; i < widget.list_name_product.length; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${i + 1}. ${widget.list_name_product[i]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            decoration: isCheckedList[i]
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        Checkbox(
                          value: isCheckedList[i],
                          onChanged: (value) {
                            setState(() {
                              isCheckedList[i] = value ?? false;
                            });
                          },
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
