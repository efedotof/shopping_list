import 'dart:core';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spisok_pokupok/widget/BeautifulContainer.dart';
import 'package:lottie/lottie.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import '../widget/buildImage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BeautifulContainer> containerList = [];
  List<String> titleStringList = [];
  List<String> shoppingList = [];
  List<String> word_processing = [];
  late String titleString;
  late String shoppingString;
  bool isAdLoaded = false;
  bool isLoading = false;
  late var adUnitId = '########';
  late var adUnitId2 = '########';
  late RewardedAd? _ad_rewerded;
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
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents dismissing the modal when tapping outside
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
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
      } catch (error) {
        await _onLoadClickedsRewardedAds();
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _onLoadClickedsRewardedAds() async {
    _ad_rewerded = await _createRewardedAds();
    await _showRewardedAds();
  }

  Future<RewardedAd> _createRewardedAds() {
    return RewardedAd.create(
      adUnitId: "########",
      onAdLoaded: () {
        setState(() => isLoading = false);
      },
      onAdFailedToLoad: (error) {
        Navigator.of(context).pop();
        setState(() => isLoading = false);
      },
      onRewarded: (reward) {},
      onAdDismissed: () {
        Navigator.of(context).pop();
        _ad_rewerded = null;
      },
    );
  }

  Future<void> _showRewardedAds() async {
    final ad = _ad_rewerded;
    if (ad != null) {
      setState(() => isLoading = true);
      try {
        await ad.load(adRequest: adRequest);
        await ad.show();
        await ad.waitForDismiss();
      } catch (error) {
        print(error);
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  

  @override
  void dispose() {
    super.dispose();
  }

  List<String> splitString(String input) {
    shoppingList.add(input);
    RegExp regex = RegExp(r'[^\s]+\s\d+');
    Iterable<Match> matches = regex.allMatches(input);
    List<String> result = [];

    matches.forEach((match) {
      result.add(match.group(0)!);
    });

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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
      );
    }
  }

  void _showThanks(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents dismissing the modal when tapping outside
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset('assets\thanks.json',repeat: true),
              SizedBox(height: 16.0),
              Text(
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
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Заголовок',
                    contentPadding: EdgeInsets.only(bottom: 12.0, right: 12.0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      titleString = value; // Update the titleString variable
                    });
                  },
                ),
                Container(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: containerList.isNotEmpty
          ? ListView(
              children: containerList.asMap().entries.map((entry) {
                int index = entry.key;
                BeautifulContainer container = entry.value;
                return Container(
                  key: ValueKey(container), // Add a key for each container
                  child: GestureDetector(
                    onTap: () {
                      // Handle the tap event on the container
                      deleteAnyway(container.title, shoppingList[index], index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
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
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Center(
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
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await showInterstitialAd();
          await _onLoadClicked();
          if(isLoading) _showThanks(context);
          showActionBottomMenu(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
