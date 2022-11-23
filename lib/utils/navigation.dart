import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screens/add_screen.dart';
import '../Screens/planner_screen.dart';
import '../Screens/home_screen.dart';
import '../Screens/settings_screen.dart';
import 'constant.dart';
import 'screen_size.dart';

class Navigators extends StatelessWidget {
  const Navigators({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double sizes = useScreenHeight(25);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.to(
                  () => const HomeScreen(),
                  transition: Transition.fadeIn,
                  duration: const Duration(microseconds: 1),
                );
              },
              child: Icon(
                Icons.home,
                color: greenLight,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                Get.to(() => const Calender(),
                    transition: Transition.fadeIn,
                    duration: const Duration(microseconds: 1));
              },
              child: Icon(
                color: greenLight,
                Icons.calendar_month,
                size: sizes,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                Get.to(() => const AddTask(),
                    transition: Transition.fadeIn,
                    duration: const Duration(microseconds: 1));
              },
              child: Icon(
                color: greenLight,
                Icons.add,
                size: sizes,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                Get.to(() => const Settings(),
                    transition: Transition.fadeIn,
                    duration: const Duration(microseconds: 1));
              },
              child: Icon(
                color: greenLight,
                Icons.settings,
                size: sizes,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
