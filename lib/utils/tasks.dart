import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'tasks.g.dart';

@HiveType(typeId: 0)
class Tasks extends HiveObject {
  @HiveField(0)
  final String? tittle;

  @HiveField(1)
  final DateTime? startTime;
  @HiveField(2)
  final DateTime? endTime;
  @HiveField(3)
  final DateTime? startDate;

  @HiveField(4)
  final DateTime? endDate;

  @HiveField(5)
  final String? description;

  @HiveField(6)
  bool isComplete = false;
  @HiveField(8)
  bool toCallDeleted = false;

  @HiveField(7)
  bool alarm = false;

  Tasks({
    required this.alarm,
    required this.tittle,
    required this.endTime,
    required this.startTime,
    required this.startDate,
    required this.endDate,
    required this.description,
  });
  factory Tasks.create(
          {String? tittle,
          DateTime? startTime,
          DateTime? endTime,
          DateTime? startDate,
          DateTime? endDate,
          String? description,
          required bool alarmValue}) =>
      Tasks(
          tittle: tittle,
          endTime: endTime,
          startTime: startTime,
          startDate: startDate,
          endDate: endDate,
          description: description,
          alarm: alarmValue);
}

String? userName;
addName(String? name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userName', name!);
}

getUserName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  userName = prefs.getString('userName');
}
