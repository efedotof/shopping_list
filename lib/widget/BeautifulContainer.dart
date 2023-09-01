// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeautifulContainer extends StatefulWidget {
  const BeautifulContainer({
    Key? key,
    required this.title,
    // ignore: non_constant_identifier_names
    required this.list_name_product,
    // ignore: non_constant_identifier_names
    required this.Deleate_settings,
    required this.isCheckedLists,
    required this.index,
    // required this.date_info,
  }) : super(key: key);

  final String title;
  // ignore: non_constant_identifier_names
  final List<String> list_name_product;
  final List<bool> isCheckedLists;
  final int index;
  // ignore: non_constant_identifier_names
  final void Function() Deleate_settings;
  // final String date_info;

  @override
  State<BeautifulContainer> createState() => _BeautifulContainerState();

  static fromString(String containerString) {}
}

class _BeautifulContainerState extends State<BeautifulContainer> {
  bool isLongPressed = false;
  int selectedCheckboxIndex = -1;
 


  Future<void> savePrefs()async{
    List<String> newShopping = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      List<String> res  = List<String>.from(widget.list_name_product);
      List<String> hell = prefs.getStringList('shoppingList')??[];
      if(hell.isNotEmpty){
        hell[widget.index] = res.toString();
      }
      prefs.setStringList('shoppingList', hell);
    });

    

  }




  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.transparent),
      onDismissed: (direction) {
        if (widget.list_name_product.isNotEmpty) {
          setState(() {
            for (int i = widget.isCheckedLists.length - 1; i >= 0; i--) {
              // Handle dismissed items if needed
            }
          });

          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              // Handle dismissal completion if needed
            }
          });
        }
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
                          fontSize: 19,
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
                  Container(color: Colors.white, height: 1),
                  for (int i = 0; i < widget.list_name_product.length; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${i + 1}. ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            decoration: widget.isCheckedLists[i]
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        Text(
                          widget.list_name_product[i],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            decoration: widget.isCheckedLists[i]
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        Checkbox(
  value: widget.isCheckedLists[i],
  onChanged: isLongPressed
      ? (value) {
          setState(() {
            if (value != null) {
              if (value) {
                // Uncheck the previously selected checkbox
                if (selectedCheckboxIndex != -1) {
                  widget.isCheckedLists[selectedCheckboxIndex] = false;
                }
                selectedCheckboxIndex = i; 
              } else {
                selectedCheckboxIndex = -1; 
              }
              widget.isCheckedLists[i] = value;

              // Check if the checkbox is now true
              if (value) {
                // Remove the item from lists
                widget.list_name_product[i] = 'Куплено';
                widget.isCheckedLists[i] = true;
                if (selectedCheckboxIndex == i) {
                  selectedCheckboxIndex = -1;
                }
                savePrefs();
              }
            }
          });
        }
      : null,
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
