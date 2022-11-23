import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/utils/provider.dart';
import '../Tabs/tab_controller.dart';
import '../utils/navigation.dart';
import '../utils/screen_size.dart';

class HomeScreen extends StatefulWidget {
  static const String title = 'Home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool fullScreen = false;
  final IconData _iconLight = Icons.wb_sunny;
  final IconData _iconDark = Icons.nights_stay;

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    TabController tabController = TabController(length: 4, vsync: this);

    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Task Manger',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: fullScreen
              ? InkWell(
                  onTap: () {
                    setState(() {
                      fullScreen = false;
                    });
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ))
              : IconButton(
                  icon: Icon(
                    context.watch<ProviderListener>().iconChange
                        ? _iconDark
                        : _iconLight,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      context.read<ProviderListener>().themeChanger();
                    });
                  },
                ),
          actions: [
            Padding(
              padding: EdgeInsets.all(useScreenWidth(8)),
              child: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    child: Image.asset("assets/OIP-removebg-preview.png",
                        fit: BoxFit.fill),
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: useScreenWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // headline
                !fullScreen
                    ? SizedBox(height: useScreenHeight(15))
                    : Container(),
                !fullScreen
                    ? Text(
                        'Save Your Task',
                        style: TextStyle(
                          fontSize: useScreenHeight(25),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Container(),
                !fullScreen
                    ? Text(
                        'Easily',
                        style: TextStyle(
                          fontSize: useScreenHeight(25),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Container(),
                !fullScreen
                    ? SizedBox(height: useScreenHeight(15))
                    : Container(),
                !fullScreen
                    ? Text(
                        '${context.watch<ProviderListener>().availableTask} available Tasks',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: useScreenHeight(18)),
                      )
                    : Container(),
                !fullScreen
                    ? SizedBox(height: useScreenHeight(15))
                    : Container(),

                // Task status
                !fullScreen
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: useScreenWidth(20),
                            vertical: useScreenHeight(15)),
                        height: useScreenHeight(175),
                        width: useScreenWidth(450),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                                image: AssetImage(
                                    'assets/shutterstock_download.jpg')),
                            boxShadow: brightness == Brightness.dark
                                ? null
                                : const [
                                    BoxShadow(
                                      offset: Offset(0, 6),
                                      blurRadius: 2,
                                      color: Colors.grey,
                                    )
                                  ]),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: useScreenHeight(34)),
                                Text(
                                  'Your Task Growth',
                                  style: TextStyle(
                                      fontSize: useScreenHeight(18),
                                      fontWeight: FontWeight.bold,
                                      wordSpacing: 1.5,
                                      color: Colors.white),
                                ),
                                SizedBox(height: useScreenHeight(10)),
                                Text(
                                  '${context.watch<ProviderListener>().completedTask} Tasks Completed',
                                  style: TextStyle(
                                      fontSize: useScreenHeight(15),
                                      // fontWeight: FontWeight.bold,
                                      wordSpacing: 1.5,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
                !fullScreen
                    ? Padding(
                        padding: EdgeInsets.only(top: useScreenHeight(34)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: useScreenHeight(14)),
                              child: Text(
                                'Tasks',
                                style: TextStyle(
                                  fontSize: useScreenHeight(25),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    fullScreen = true;
                                  });
                                },
                                child: const Text('View all'))
                          ],
                        ),
                      )
                    : Container(),
                Tabs(tabController: tabController),
                TabViewWidget(
                  tabController: tabController,
                  fullScreen: fullScreen,
                )
              ],
            ),
          ),
        ),
        bottomSheet: const Navigators());
  }
}
