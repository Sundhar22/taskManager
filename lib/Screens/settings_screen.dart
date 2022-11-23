import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/utils/constant.dart';
import 'package:task_manager/utils/screen_size.dart';
import 'package:task_manager/utils/tasks.dart';

import '../utils/navigation.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

bool isEnabled = false;

class _SettingsState extends State<Settings> {
  bool visualLine = false;

  final animationDuration = const Duration(milliseconds: 500);
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor:
            brightness == Brightness.dark ? Colors.white : Colors.black,
        leading: const Offstage(),
      ),
      body: Column(
        children: [
          SizedBox(height: useScreenHeight(25)),
          profile(brightness),
          SizedBox(height: useScreenHeight(25)),
          settings_01(brightness),
          SizedBox(height: useScreenHeight(35)),
          setting_02(brightness)
        ],
      ),
      bottomSheet: const Navigators(),
    );
  }

  Container setting_02(Brightness brightness) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: useScreenWidth(15), vertical: useScreenHeight(15)),
      margin: EdgeInsets.symmetric(horizontal: useScreenWidth(10)),
      decoration: BoxDecoration(
          color: brightness == Brightness.dark
              ? Colors.grey.shade600
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          title(
            Colors.redAccent,
            CupertinoIcons.info,
            "App info",
            "Learn about the app ",
            brightness,
          ),
          const Divider(),
          title(
            greenLight,
            CupertinoIcons.bubble_left_fill,
            "Feed Back",
            "What we can improve in this app",
            brightness,
          )
        ],
      ),
    );
  }

  Container settings_01(Brightness brightness) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: useScreenWidth(15), vertical: useScreenHeight(15)),
      margin: EdgeInsets.symmetric(horizontal: useScreenWidth(10)),
      decoration: BoxDecoration(
          color: brightness == Brightness.dark
              ? Colors.grey.shade600
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15)),
      child: Column(children: [
        title(
          greenLight,
          Icons.fingerprint,
          "Privacy",
          'Learn more about app privacy ',
          brightness,
        ),
        const Divider(),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(useScreenHeight(2)),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(useScreenWidth(13))),
              child: Icon(
                Icons.bedtime_rounded,
                color: Colors.white,
                size: useScreenHeight(45),
              ),
            ),
            SizedBox(width: useScreenWidth(15)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dark Mode",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: useScreenHeight(18)),
                ),
                const Text(
                  "Change your mode ",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            SizedBox(width: useScreenWidth(75)),
            GestureDetector(
              onTap: () {
                setState(() {
                  isEnabled = !isEnabled;
                });
              },
              child: AnimatedContainer(
                height: useScreenHeight(28),
                width: useScreenWidth(48),
                decoration: BoxDecoration(
                  color: isEnabled ? Colors.blue : Colors.grey[50],
                  borderRadius: BorderRadius.circular(useScreenWidth(20)),
                ),
                duration: animationDuration,
                child: AnimatedAlign(
                  duration: animationDuration,
                  alignment:
                      isEnabled ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    height: useScreenHeight(28),
                    width: useScreenWidth(28),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        shape: BoxShape.circle,
                        color: Colors.black26,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            blurStyle: BlurStyle.outer,
                            color: Colors.grey.shade500,
                          )
                        ]),
                  ),
                ),
              ),
            )
          ],
        ),
        const Divider(),
        title(
          Colors.blueAccent,
          CupertinoIcons.doc_plaintext,
          "Guidance",
          'Learn how to use the app  ',
          brightness,
        ),
      ]),
    );
  }

  Row title(Color color, IconData icon, String tittle, String subTitle,
      Brightness brightness) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(useScreenHeight(2)),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(useScreenWidth(13))),
          child: Icon(
            icon,
            color: Colors.white,
            size: useScreenHeight(45),
          ),
        ),
        SizedBox(width: useScreenWidth(15)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tittle,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: useScreenHeight(18)),
            ),
            Text(
              subTitle,
              style: const TextStyle(color: Colors.grey),
            )
          ],
        ),
      ],
    );
  }

  Container profile(Brightness brightness) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: useScreenWidth(15), vertical: useScreenHeight(10)),
      margin: EdgeInsets.symmetric(horizontal: useScreenWidth(10)),
      decoration: BoxDecoration(
          color: brightness == Brightness.dark
              ? Colors.grey.shade600
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15)),
      child: Column(children: [
        Row(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(useScreenHeight(40)),
              onTap: () {},
              child: CircleAvatar(
                maxRadius: useScreenHeight(40),
                backgroundImage: const AssetImage(
                  "assets/OIP-removebg-preview.png",
                ),
              ),
            ),
            SizedBox(
                width: useScreenWidth(100),
                child: TextField(
                  onSubmitted: (value) {
                    setState(() {
                      addName(value);
                      visualLine = !visualLine;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: visualLine == false
                          ? (userName == null ? "user" : userName!)
                          : null,
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: useScreenHeight(20)),
                      border: visualLine ? null : InputBorder.none),
                  onTap: () {
                    setState(() {
                      visualLine = !visualLine;
                    });
                  },
                )),
          ],
        ),
      ]),
    );
  }
}
