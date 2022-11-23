// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../utils/tasks.dart';
import 'components/reusable.dart';

class AllTabBar extends StatefulWidget {
  const AllTabBar({super.key});

  @override
  State<AllTabBar> createState() => _AllTabBarState();
}

class _AllTabBarState extends State<AllTabBar> {
  static List<Tasks> allTask = [];
  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
      valueListenable: base.dataStore.listenToTasks(),
      builder: (context, Box<Tasks> box, Widget? child) {
        allTask = box.values.toList();
        return Reusable(
          givenTask: allTask,
        );
      },
    );
  }
}
// https://internshala.com/application/form/marketing-internship-in-indore-at-metafic1666336503
class TodayTabBar extends StatefulWidget {
  const TodayTabBar({super.key});

  @override
  State<TodayTabBar> createState() => _TodayTabBarState();
}

class _TodayTabBarState extends State<TodayTabBar> {
  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    List<Tasks> todayTask = [];
    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenToTasks(),
        builder: (context, Box<Tasks> box, Widget? child) {
          for (var element in box.values) {
            if (DateFormat('yyyy-MM-dd').format(element.startDate!) ==
                DateFormat('yyyy-MM-dd').format(DateTime.now())) {
              todayTask.add(element);
            }
          }
          todayTask.sort(
            (a, b) => a.startTime!.compareTo(b.startTime!),
          );
          return Reusable(
            givenTask: todayTask,
          );
        });
  }
}

class UpcomingTabBar extends StatelessWidget {
  const UpcomingTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    List<Tasks> upcomingTask = [];
    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenToTasks(),
        builder: (context, Box<Tasks> box, Widget? child) {
          for (var element in box.values) {
            if (DateFormat('yyyy-MM-dd').format(element.startDate!) !=
                DateFormat('yyyy-MM-dd').format(DateTime.now())) {
              upcomingTask.add(element);
            }
          }
          upcomingTask.sort(
            (a, b) => a.startTime!.compareTo(b.startTime!),
          );
          return Reusable(
            givenTask: upcomingTask,
          );
        });
  }
}

class RecentlyTabBar extends StatefulWidget {
  const RecentlyTabBar({super.key});

  @override
  State<RecentlyTabBar> createState() => _RecentlyTabBarState();
}

class _RecentlyTabBarState extends State<RecentlyTabBar> {
  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    return ValueListenableBuilder(
      valueListenable: base.dataStore.listenToTasks(),
      builder: (BuildContext context, Box<Tasks> box, Widget? child) {
        List<Tasks> recentlyTasks = [];
        for (Tasks element in box.values) {
          if (element.isComplete) {
            recentlyTasks.add(element);
          }
        }
        return Reusable(
          givenTask: recentlyTasks,
        );
      },
    );
  }
}

int NumOfTask1() {
  List<Tasks> NumberOfTasks = [];
  final Box<Tasks> box = Hive.box<Tasks>('task');
  for (Tasks element in box.values) {
    if (element.isComplete == false) {
      NumberOfTasks.add(element);
    }
  }

  return NumberOfTasks.length;
}

int NumOfTaskComplete1() {
  List<Tasks> NumberOfTasks = [];
  final Box<Tasks> box = Hive.box<Tasks>('task');
  for (Tasks element in box.values) {
    if (element.isComplete) {
      NumberOfTasks.add(element);
    }
  }

  return NumberOfTasks.length;
}

int NumOfTodayTask1() {
  List<Tasks> todayTask = [];
  final Box<Tasks> box = Hive.box<Tasks>('task');
  for (var element in box.values) {
    if (DateFormat('yyyy-MM-dd').format(element.startDate!) ==
        DateFormat('yyyy-MM-dd').format(DateTime.now())) {
      todayTask.add(element);
    }
  }
  todayTask.sort(
    (a, b) => a.startTime!.compareTo(b.startTime!),
  );
  return todayTask.length;
}
