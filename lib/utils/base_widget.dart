// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'hive_base.dart';

class BaseWidget extends InheritedWidget {
  BaseWidget({super.key, required super.child});
  final HiveDataBase dataStore = HiveDataBase();

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError('Could not find ancestor widget of type BaseWidget');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
