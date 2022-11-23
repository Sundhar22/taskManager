import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/utils/constant.dart';

import '../main.dart';
import '../utils/navigation.dart';
import '../utils/provider.dart';
import '../utils/screen_size.dart';
import '../utils/tasks.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController descController = TextEditingController();

  String? taskName;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? startTime;
  DateTime? endTime;
  bool alarm = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    var bases = BaseWidget.of(context);
    return ValueListenableBuilder(
        valueListenable: bases.dataStore.listenToTasks(),
        builder: (BuildContext context, Box<Tasks> box, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Create New Task'),
              // centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: useScreenWidth(15)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //TaskName
                      Text(
                        "Task name",
                        style: TextStyle(
                            fontSize: useScreenHeight(19),
                            fontWeight: FontWeight.bold),
                      ),

                      SizedBox(
                        height: useScreenHeight(10),
                      ),
                      TextField(
                        controller: taskNameController,
                        keyboardType: TextInputType.text,
                        cursorHeight: 20,
                        decoration: InputDecoration(
                          hintText: 'Enter project name',
                          hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(.7),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(useScreenWidth(10))),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(useScreenWidth(10))),
                          prefixIcon: Icon(
                            Icons.card_travel,
                            color: greenLight,
                          ),
                        ),
                        onChanged: (value) {
                          taskName = value;
                        },
                      ),

                      SizedBox(
                        height: useScreenHeight(10),
                      ),

                      // description
                      Text(
                        "Description",
                        style: TextStyle(
                            fontSize: useScreenHeight(19),
                            fontWeight: FontWeight.bold),
                      ),

                      SizedBox(
                        height: useScreenHeight(10),
                      ),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        cursorHeight: 25,
                        controller: descController,
                        decoration: InputDecoration(
                          hintText: 'description',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(useScreenWidth(10))),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(useScreenWidth(10))),
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(.7)),
                          prefixIcon: Icon(
                            Icons.assignment_rounded,
                            color: greenLight,
                          ),
                        ),
                        onChanged: (value) {
                          description = value;
                        },
                        
                      ),
                      SizedBox(
                        height: useScreenHeight(10),
                      ),
                      Text(
                        "Date",
                        style: TextStyle(
                            fontSize: useScreenHeight(19),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: useScreenHeight(10),
                      ),
                      // startDate
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: useScreenWidth(140),
                            child: TextField(
                              controller: startDateController,
                              keyboardType: TextInputType.datetime,
                              cursorHeight: 25,
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                hintText: 'StartDate',
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(.7)),
                                prefixIcon: Icon(
                                  Icons.date_range,
                                  color: greenLight,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        useScreenWidth(10))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        useScreenWidth(10))),
                              ),
                              onTap: () async {
                                DateTime? pickDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2200),
                                );
                                if (pickDate != null) {
                                  setState(() {
                                    startDateController.text =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickDate);
                                    startDate = DateTime(pickDate.year,
                                        pickDate.month, pickDate.day);
                                  });
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: useScreenWidth(140),
                            child: TextField(
                              controller: endDateController,
                              cursorHeight: 25,
                              decoration: InputDecoration(
                                hintText: 'EndDate',
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(.7)),
                                prefixIcon: Icon(
                                  Icons.date_range,
                                  color: greenLight,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        useScreenWidth(10))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        useScreenWidth(10))),
                              ),
                              onTap: () async {
                                DateTime? pickDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2200),
                                );
                                if (pickDate != null) {
                                  setState(() {
                                    endDateController.text =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickDate);
                                    endDate = pickDate;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: useScreenHeight(10),
                      ),
                      Text(
                        "Time",
                        style: TextStyle(
                            fontSize: useScreenHeight(19),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: useScreenHeight(10),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: useScreenWidth(140),
                            child: TextField(
                              controller: startTimeController,
                              keyboardType: TextInputType.datetime,
                              cursorHeight: 25,
                              decoration: InputDecoration(
                                hintText: 'StartTime',
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(.7)),
                                prefixIcon: Icon(
                                  Icons.access_time_sharp,
                                  color: greenLight,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        useScreenWidth(10))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        useScreenWidth(10))),
                              ),
                              onTap: () async {
                                final TimeOfDay? timeOfDay =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: selectedTime,
                                  initialEntryMode: TimePickerEntryMode.dial,
                                );
                                if (timeOfDay != null &&
                                    timeOfDay != selectedTime) {
                                  setState(() {
                                    selectedTime = timeOfDay;
                                  });
                                }
                                final now = DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    selectedTime.hour,
                                    selectedTime.minute);
                                startTime = now;
                                startTimeController.text =
                                    DateFormat.Hm().format(now);
                              },
                            ),
                          ),
                          SizedBox(
                            width: useScreenWidth(140),
                            child: TextField(
                              keyboardType: TextInputType.datetime,
                              controller: endTimeController,
                              cursorHeight: 25,
                              decoration: InputDecoration(
                                hintText: 'EndTime',
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(.7)),
                                prefixIcon: Icon(Icons.access_time_sharp,
                                    color: greenLight),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        useScreenWidth(10))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        useScreenWidth(10))),
                              ),
                              onTap: () async {
                                final TimeOfDay? timeOfDay =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: selectedTime2,
                                  initialEntryMode: TimePickerEntryMode.dial,
                                );
                                if (timeOfDay != null &&
                                    timeOfDay != selectedTime) {
                                  setState(() {
                                    selectedTime2 = timeOfDay;
                                  });
                                }
                                final now = DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    selectedTime2.hour,
                                    selectedTime2.minute);
                                endTime = now;
                                endTimeController.text =
                                    DateFormat.Hm().format(now);
                              },
                            ),
                          )
                        ],
                      ),
                      // EndTime
                      SizedBox(
                        height: useScreenHeight(10),
                      ),
                      Text(
                        "alarm",
                        style: TextStyle(
                            fontSize: useScreenHeight(19),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: useScreenHeight(10),
                      ),
                      //  alarm
                      _container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: useScreenWidth(11),
                              ),
                              Icon(Icons.alarm, color: greenLight),
                              SizedBox(
                                width: useScreenWidth(10),
                              ),
                              const Text(
                                "Alarm",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                borderRadius:
                                    BorderRadius.circular(useScreenWidth(13)),
                                onTap: () {
                                  setState(() {
                                    alarm = !alarm;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  height: useScreenHeight(25),
                                  width: useScreenWidth(50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          useScreenWidth(13)),
                                      color: alarm
                                          ? Colors.green[100]
                                          : Colors.redAccent[100]),
                                  child: Stack(
                                    children: [
                                      AnimatedPositioned(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.decelerate,
                                        left: alarm ? 25.0 : 0.0,
                                        right: alarm ? 0.0 : 30.0,
                                        child: AnimatedSwitcher(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          transitionBuilder:
                                              (child, animation) {
                                            return RotationTransition(
                                                turns: animation, child: child);
                                          },
                                          child: alarm
                                              ? Icon(Icons.check_circle,
                                                  color: Colors.green,
                                                  size: useScreenHeight(26),
                                                  key: UniqueKey())
                                              : Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.red,
                                                  size: useScreenHeight(26),
                                                  key: UniqueKey(),
                                                ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: useScreenWidth(10),
                              )
                            ],
                          ),
                        ],
                      )),
                      SizedBox(
                        height: useScreenHeight(50),
                      )
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: Padding(
              padding: EdgeInsets.only(
                  bottom: useScreenHeight(5), left: useScreenWidth(15)),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if ((taskName!.isNotEmpty &&
                        description!.isNotEmpty &&
                        endDate != null &&
                        startDate != null &&
                        startTime != null &&
                        endTime != null)) {
                      Tasks addTask = Tasks.create(
                          tittle: taskName,
                          endTime: endTime,
                          startTime: startTime,
                          startDate: startDate,
                          endDate: endDate,
                          description: description,
                          alarmValue: alarm);

                      if (alarm &&
                          DateTime(startDate!.year, startDate!.month,
                                  startDate!.day) ==
                              DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day)) {
                        int hours = startTime!.hour;
                        int min = startTime!.minute;

                        FlutterAlarmClock.createAlarm(hours, min);
                      }
                      box.add(addTask);
                      context.read<ProviderListener>().NumOfTask();
                      Get.snackbar(taskName!, 'TaskCreated Successfully');
                      taskName = null;
                      description = null;
                      taskNameController.clear();
                      descController.clear();
                      endDateController.clear();
                      startDateController.clear();
                      startTimeController.clear();
                      endTimeController.clear();
                    }
                  });
                },
                child: Container(
                  height: useScreenHeight(50),
                  width: useScreenWidth(350),
                  decoration: BoxDecoration(
                    // color: Colors.green,
                    color: greenLight,
                    borderRadius: BorderRadius.circular(useScreenWidth(12)),
                  ),
                  child: const Center(
                      child: Text(
                    'Create Task',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  )),
                ),
              ),
            ),
            bottomNavigationBar: const Navigators(),
          );
        });
  }

  Container _container({required child}) {
    return Container(
        height: useScreenHeight(60),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(.5)),
          borderRadius: BorderRadius.circular(useScreenWidth(12)),
        ),
        child: child);
  }

  
}
