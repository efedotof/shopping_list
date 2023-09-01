import 'dart:core';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spisok_pokupok/intil.dart';
import 'package:spisok_pokupok/widget/BeautifulContainer.dart';
import 'package:lottie/lottie.dart';
import 'package:spisok_pokupok/widget/auth.dart';
import 'package:spisok_pokupok/widget/message.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import '../widget/buildImage.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.uniqKey}) : super(key: key);
  final String uniqKey;
  @override
  State<Home> createState() => _HomeState();
  // ignore: library_private_types_in_public_api
  static _HomeState? of(BuildContext context) {
    return context.findAncestorStateOfType<_HomeState>();
  }
}

class _HomeState extends State<Home> {
  //key
  List<BeautifulContainer> containerList = [];
  List<String> titleStringList = [];
  List<String> shoppingList = [];

  // ignore: non_constant_identifier_names
  List<String> word_processing = [];
  late String titleString;
  late String shoppingString;
  bool isAdLoaded = false;
  bool isLoading = false;
  late var adUnitId = 'R-M-2511202-5';
  late var adUnitId2 = 'R-M-2511202-4';
  // ignore: non_constant_identifier_names
  late InterstitialAd? _ad;
  var adRequest = const AdRequest();

  @override
  void initState() {
    MobileAds.initialize();
    MobileAds.setDebugErrorIndicator(true);
    loadData();
    super.initState();
  }

  Future<void> _onLoadClicked() async {
    _ad = await _createInterstitialAd();
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents dismissing the modal when tapping outside
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(), // Add the circular progress indicator
                SizedBox(height: 16.0),
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    await _showInterstitialAd();
  }
  Future<InterstitialAd> _createInterstitialAd() {
    return InterstitialAd.create(
      adUnitId: adUnitId,
      onAdLoaded: () {
        setState(() => isLoading = false);
      },
      onAdDismissed: () {
        _ad = null;
      },
      onAdFailedToLoad: (error) {
        _ad = null;
      },
    );
  }
  Future<void> _showInterstitialAd() async {
    final ad = _ad;
    if (ad != null) {
      setState(() => isLoading = true);
      try {
        await ad.load(adRequest: adRequest);
        await ad.show();
        await ad.waitForDismiss();
      }catch(e){
        
      } 
      
      finally {
        setState(() => isLoading = false);
      }
    }
  }
  @override
  void dispose() {
    super.dispose();
  }
  List<bool> ischecked = [];
  List<String> splitString(String input) {
    shoppingList.add(input);
    RegExp regex = RegExp(r'[^\s]+\s\d+');
    Iterable<Match> matches = regex.allMatches(input);
    List<String> result = [];

    for (var match in matches) {
      result.add(match.group(0)!);
      ischecked.add(false);
    }
    return result;
  }
  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('titleStringList', titleStringList);
    await prefs.setStringList('shoppingList', shoppingList);
  }
  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      titleStringList = prefs.getStringList('titleStringList') ?? [];
      shoppingList = prefs.getStringList('shoppingList') ?? [];
      containerList = titleStringList.asMap().entries.map((entry) {
        int index = entry.key;
        String title = entry.value;
        String listName = shoppingList[index];
        return BeautifulContainer(
          title: title,
          Deleate_settings: () => deleteAnyway(title, listName, index),
          list_name_product: splitString(listName),
          isCheckedLists: ischecked,
          index: index,
        );
      }).toList();
    });
  }




  Future<void> deleteContainer(int index) async {
    if (!mounted) {
      return; // Check if the widget is still mounted
    }
    setState(() {
      containerList.removeAt(index);
      titleStringList.removeAt(index);
      shoppingList.removeAt(index);
    });

    updateContainerIndices();

    await saveData();
  }
  Future<void> deleteAnyway(String title, String listName, int index) async {
    if (!mounted) {
      return; // Check if the widget is still mounted
    }

    await deleteContainer(index);

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Список удален'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.white10),
    );
  }
  void addContainer(String title, String listName, int index) async {
    setState(() {
      word_processing = splitString(listName); // Process the listName string
      BeautifulContainer newContainer = BeautifulContainer(
  title: title,
  Deleate_settings: () => deleteAnyway(title, listName, index),
  list_name_product: word_processing,
  isCheckedLists: List<bool>.from(ischecked), // Create a new list to avoid sharing the same reference
  index: index,
);
      containerList.insert(0, newContainer);
      titleStringList.insert(0, title);
      shoppingList.insert(0, listName);
      titleString = ''; // Reset the titleString variable
      shoppingString = ''; // Reset the shoppingString variable
      updateContainerIndices();
    });
    await saveData();
  }
  void updateContainerIndices() {
  for (int i = 0; i < containerList.length; i++) {
    containerList[i] = BeautifulContainer(
      title: containerList[i].title,
      list_name_product: containerList[i].list_name_product,
      Deleate_settings: () =>
          deleteAnyway(containerList[i].title, shoppingList[i], i),
      isCheckedLists: ischecked,
      index: i, // Add index here
    );
  }
}
  void _showThanks(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents dismissing the modal when tapping outside
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset('assets\thanks.json', repeat: true),
                const SizedBox(height: 16.0),
                const Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  String formatDate(DateTime dateTime) {
    String dayOfWeek = getDayOfWeek(dateTime.weekday);
    String date = '${dateTime.day}.${dateTime.month}.${dateTime.year}';

    return '$dayOfWeek, $date';
  }
  String getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Понедельник';
      case 2:
        return 'Вторник';
      case 3:
        return 'Среда';
      case 4:
        return 'Четверг';
      case 5:
        return 'Пятница';
      case 6:
        return 'Суббота';
      case 7:
        return 'Воскресенье';
      default:
        return '';
    }
  }
  Future<void> showActionBottomMenu(BuildContext context) async {
    int index = containerList
        .length; // Get the current length of containerList as the index for the new container

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Wrap(
              children: [
                // TextField(
                //   decoration: const InputDecoration(
                //     labelText: 'Заголовок',
                //     contentPadding: EdgeInsets.only(bottom: 12.0, right: 12.0),
                //   ),
                //   onChanged: (value) {
                //     setState(() {
                //       titleString = value; // Update the titleString variable
                //     });
                //   },
                // ),
                SizedBox(
                  height: 300,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: '',
                      hintMaxLines: 1,
                      hintStyle: TextStyle(fontSize: 13),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    maxLines: 50,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      setState(() {
                        shoppingString =
                            value; // Update the shoppingString variable
                      });
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      "Каждый продукт на отдельную строку с указанием количества"),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 60,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Закрыть"),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: TextButton(
                        onPressed: () async {
                          word_processing = splitString(shoppingString);
                          //titleString =
                           titleString =  formatDate(DateTime.now());
                          addContainer(titleString, shoppingString, index);
                          Navigator.pop(context);
                        },
                        child: const Text("Сохранить"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      isScrollControlled: true,
    );
  }
  bool isShowUniqKey = false;
  void showUniqueKeyDialog(BuildContext context) {
     TextEditingController keyController = TextEditingController();
    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Уникальный ключ'),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close, color: Colors.redAccent),
            ),
          ],
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Ваш уникальный ключ:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.uniqKey,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700), // Замазанный текст
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Или",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: keyController,
              decoration: const InputDecoration(labelText: 'Введите ключ'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _onLoadClicked();
          if (isLoading) _showThanks(context);
          Navigator.pop(context);
                if (keyController.text.isEmpty) {
                   Navigator.pop(context);
                  Message.show(context,
                      message: 'Ключ не введен',
                      duration: const Duration(seconds: 3));
                } else {
                  if (keyController.text == widget.uniqKey) {
                     Navigator.pop(context);
                    Message.show(context,
                        message: 'Вы ввели свой ключ, данные не добавлены',
                        duration: const Duration(seconds: 3));
                  } else {
                    Navigator.pop(context); // Закрыть диалоговое окно
                   await Auth().create(
                        context, titleStringList, shoppingList, widget.uniqKey);
                    String selectKey = keyController.text;
                   await Auth().fetchShoppingAndTitleLists(context, selectKey);
                    // for(int i =0; i < keytitleStringList.length;i++){
                    //   keycontainerList.add(BeautifulContainer(title: keytitleStringList[i], list_name_product: keyshoppingList, Deleate_settings:()=>deleteAnyway(keytitleStringList[i], keyshoppingList[i], i)));
                    // }
                    for(int i = 0; i < keytitleStringList.length; i++){
                      addContainer(keytitleStringList[i] + " Новый", keyshoppingList[i], i);
                    }
                    
                  }
                }
              },
              child: const Text('Получить списки'),
            ),
          ],
        ),
      ),
    );
  }
  bool showAllContainers = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: containerList.isNotEmpty
          ? ListView(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "Привет !",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        showUniqueKeyDialog(context);
                      },
                    )
                  ],
                ),

                ...containerList.asMap().entries.map((entry) {
                  int index = entry.key;
                  BeautifulContainer container = entry.value;
                  return Container(
                    key: ValueKey(container), // Add a key for each container
                    child: GestureDetector(
                      onTap: () {
                        // Handle the tap event on the container
                        deleteAnyway(
                            container.title, shoppingList[index], index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Список удален'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.white10,
                          ),
                        );
                      },
                      child: container,
                    ),
                  );
                }).toList(),

              ],
            )
          : ListView(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      "Привет !",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      showUniqueKeyDialog(context);
                    },
                  )
                ],
              ),
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buidImage(
                      assetName: "sorry.json",
                      width: 300,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "К сожалению, в этом месте пустота. Однако, давайте добавим первый элемент, чтобы сделать его более интересным и содержательным.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                          softWrap: true,
                          maxLines: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              




            ]
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await showInterstitialAd();
          await _onLoadClicked();
          // await _onLoadClickedsRewardedAds();
          // ignore: use_build_context_synchronously
          if (isLoading) _showThanks(context);
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          showActionBottomMenu(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
