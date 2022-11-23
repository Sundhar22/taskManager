// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Screens/details_screen.dart';
import '../../main.dart';
import '../../utils/screen_size.dart';
import '../../utils/tasks.dart';

class Reusable extends StatefulWidget {
  List<Tasks> givenTask;
  Reusable({
    Key? key,
    required this.givenTask,
  }) : super(key: key);
  @override
  State<Reusable> createState() => _ReusableState();
}

class _ReusableState extends State<Reusable> {
  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);

    var brightness = MediaQuery.of(context).platformBrightness;
    return ListView.separated(
      separatorBuilder: (context, index) =>
          SizedBox(height: useScreenHeight(12)),
      itemCount: widget.givenTask.length,
      itemBuilder: (context, index) {
        int different = widget.givenTask[index].startDate!
            .difference(widget.givenTask[index].endDate!)
            .inDays;
        different = different * -1;
        return Container(
          padding: EdgeInsets.all(useScreenWidth(20)),
          margin: EdgeInsets.all(useScreenWidth(10)),
          height: useScreenHeight(150),
          width: useScreenWidth(350),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white10,
              borderRadius: BorderRadius.circular(15),
              boxShadow: brightness == Brightness.light
                  ? const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          blurStyle: BlurStyle.outer)
                    ]
                  : null),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.givenTask[index].tittle!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: useScreenHeight(18)),
                  ),
                  SizedBox(height: useScreenHeight(10)),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_sharp,
                        size: useScreenHeight(20),
                        color: const Color(0xFFAC32DC),
                      ),
                      SizedBox(width: useScreenWidth(5)),
                      Text(
                          DateFormat.jm()
                              .format(widget.givenTask[index].startTime!),
                          style: const TextStyle(
                            wordSpacing: 2,
                            color: Colors.black54,
                            fontSize: 15,
                          )),
                      SizedBox(width: useScreenWidth(5)),
                      const Text(
                        'to',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: useScreenWidth(5)),
                      Text(
                        DateFormat.jm()
                            .format(widget.givenTask[index].endTime!),
                        style: const TextStyle(
                          wordSpacing: 2,
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    height: useScreenHeight(30),
                    width: useScreenWidth(70),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        different > 1 ? '$different days' : '$different day',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w400,
                          letterSpacing: .2,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          Get.to(
                              DetailScreen(
                                  boxName: base.dataStore.getBoxName(),
                                  bases: base),
                              transition: Transition.rightToLeftWithFade,
                              duration: const Duration(milliseconds: 500),
                              arguments: widget.givenTask[index]);
                        });
                      },
                      child: const Text(
                        'details',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                            letterSpacing: 1,
                            decorationStyle: TextDecorationStyle.solid),
                      ))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
