// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/Tabs/all_tab.dart';
import 'package:task_manager/utils/tasks.dart';

class ProviderListener with ChangeNotifier {
  bool iconBool = false;
  int availableTasks = NumOfTask1();
  int completedTasks = NumOfTaskComplete1();
  int TodayTasks = NumOfTodayTask1();

  int get availableTask => availableTasks;
  int get completedTask => completedTasks;
  int get TodayTask => TodayTasks;
  bool get iconChange => iconBool;

  void themeChanger() {
    iconBool = !iconBool;
  }

  void NumOfTask() {
    List<Tasks> NumberOfTasks = [];
    final Box<Tasks> box = Hive.box<Tasks>('task');
    for (Tasks element in box.values) {
      if (element.isComplete == false) {
        NumberOfTasks.add(element);
      }
    }
    availableTasks = NumberOfTasks.length;
    notifyListeners();
  }

  void NumOfTaskComplete() {
    List<Tasks> NumberOfTasks = [];
    final Box<Tasks> box = Hive.box<Tasks>('task');
    for (Tasks element in box.values) {
      if (element.isComplete) {
        NumberOfTasks.add(element);
      }
    }
    completedTasks = NumberOfTasks.length;
    notifyListeners();
  }

  void NumOfTodayTask() {
    List<Tasks> todayTask = [];
    final Box<Tasks> box = Hive.box<Tasks>('task');
    for (var element in box.values) {
      if (DateFormat('yyyy-MM-dd').format(element.startDate!) ==
          DateFormat('yyyy-MM-dd').format(DateTime.now())) {
        todayTask.add(element);
      }
    }
    TodayTasks = todayTask.length;
    notifyListeners();
  }
}
