import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'package:task_manager/utils/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'Screens/home_screen.dart';
// import 'Screens/onboarding.dart';
import 'utils/constant.dart';
import 'utils/hive_base.dart';
import 'utils/tasks.dart';

var uniqueId = DateTime.now().second.toString();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  final appDocDic = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocDic.path);
  Hive.registerAdapter(TasksAdapter());
  await Hive.openBox<Tasks>('task');
  Workmanager().registerPeriodicTask(uniqueId, "taskApp",
      initialDelay: Duration(minutes: timeDifference()),
      frequency: const Duration(hours: 1));
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ProviderListener())],
    child: BaseWidget(child: const MyApp()),
  ));
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    run();
    return Future.value(true);
  });
}

void run() {
  final Box<Tasks> box = Hive.box<Tasks>('task');
  for (var element in box.values) {
    if (DateTime(element.startDate!.year, element.startDate!.month,
            element.startDate!.day) ==
        DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
      FlutterAlarmClock.createAlarm(
          element.startTime!.hour, element.startTime!.minute);
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: lightThemeData(context),
        darkTheme: ThemeData(
            fontFamily: 'SourceCodePro',
            brightness: Brightness.dark,
            primaryColor: color5,
            colorScheme:
                const ColorScheme.dark().copyWith(secondary: greenLight)),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen());
  }
}

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

int timeDifference() {
  var format = DateFormat("HH:mm");

  var one = format.parse("${DateTime.now().hour}:${DateTime.now().minute}");
  var two = format.parse("${DateTime.now().hour + 1}:00");

  return two.difference(one).inMinutes;
}
