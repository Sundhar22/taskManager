import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../date_file/calender.dart';
import '../main.dart';
import '../utils/constant.dart';
import '../utils/navigation.dart';
import '../utils/provider.dart';
import '../utils/screen_size.dart';
import '../utils/tasks.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  List<Tasks> listTask = List.empty();

  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: ValueListenableBuilder(
              valueListenable: base.dataStore.listenToTasks(),
              builder: (BuildContext context, Box<Tasks> box, Widget? child) {
                listTask = box.values.toList();
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: useScreenWidth(12),
                    vertical: useScreenHeight(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Planner',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: useScreenHeight(22),
                                ),
                              ),
                              SizedBox(height: useScreenHeight(10)),
                              Text(
                                'You have ${context.watch<ProviderListener>().TodayTask} tasks for today',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: useScreenHeight(15)),
                              )
                            ],
                          ),
                          CircleAvatar(
                            child: Image.asset(
                                "assets/OIP-removebg-preview.png",
                                fit: BoxFit.fill),
                          )
                        ],
                      ),
                      SizedBox(height: useScreenHeight(30)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${DateFormat.LLLL().format(DateTime.now())}  ${DateTime.now().year}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: useScreenHeight(20)),
                          ),
                          Row(
                            children: [
                              Text(
                                'Today ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: useScreenHeight(16)),
                              ),
                              const Icon(Icons.line_style_rounded)
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: useScreenHeight(30)),
                      HorizontalCalendar(
                        initialDate: DateTime.utc(2000, 7, 20),
                        lastDate: DateTime.utc(2100, 7, 20),
                        date: DateTime.now(),
                        textColor: brightness == Brightness.dark
                            ? Colors.grey
                            : Colors.black,
                        backgroundColor: Colors.transparent,
                        selectedColor: greenLight,
                        onDateSelected: (date) {
                          DateTime formate = DateTime.parse(date);
                          setState(() {
                            currentDate = formate;
                          });
                        },
                      ),
                      SizedBox(height: useScreenHeight(10)),
                      SizedBox(
                        height: useScreenHeight(500),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                            height: useScreenHeight(08),
                          ),
                          itemCount: listTask.length,
                          itemBuilder: (context, index) => currentDate ==
                                  listTask[index].startDate!
                              ? Container(
                                  padding: EdgeInsets.all(useScreenWidth(15)),
                                  height: useScreenHeight(60),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: color5,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    listTask[index].tittle!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: useScreenHeight(18),
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Container(),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        bottomSheet: const Navigators());
  }
}
