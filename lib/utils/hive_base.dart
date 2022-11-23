import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'tasks.dart';

class HiveDataBase {
  static const String name = 'task';
   final Box<Tasks> box = Hive.box<Tasks>(name);

  Future<Tasks?> getId({required String id}) async {
    return box.get(id);
  }

  String getBoxName() {
    return name;
  }

  Future<void> addTask({required Tasks tasks}) async {
    await box.add(tasks);
  }

  Future<void> updateTask({required Tasks task}) async {
    await task.save();
  }

  Future<void> delete({required Tasks task}) async {
    await task.delete();
  }

  ValueListenable<Box<Tasks>> listenToTasks() {
    return box.listenable();
  }
}
