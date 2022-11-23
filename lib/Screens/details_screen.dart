// ignore_for_file: must_be_immutable, dead_code

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../utils/constant.dart';
import '../utils/provider.dart';
import '../utils/screen_size.dart';
import '../utils/tasks.dart';

class DetailScreen extends StatefulWidget {
  String boxName;
  BaseWidget bases;
  DetailScreen({
    Key? key,
    required this.boxName,
    required this.bases,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  late final GifController controller1, controller2;

  @override
  void initState() {
    controller1 = GifController(vsync: this);
    controller2 = GifController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Tasks data = Get.arguments;
    int different = data.startDate!.difference(data.endDate!).inDays;
    different = different * -1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          data.tittle!,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xff1E1E1E),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: useScreenWidth(15)),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  data.toCallDeleted = true;
                  widget.bases.dataStore.delete(task: data);
                  context.read<ProviderListener>().NumOfTask();
                  context.read<ProviderListener>().NumOfTaskComplete();
                });
              },
              child: const Icon(Icons.delete_outline_rounded),
            ),
          )
        ],
      ),
      body: data.toCallDeleted
          ? Column(
              children: [
                SizedBox(
                  height: useScreenHeight(200),
                ),
                Center(
                  child: Gif(
                    image: const AssetImage('assets/gif/delete.gif'),
                    controller: controller2,
                    autostart: Autostart.no,
                    onFetchCompleted: () {
                      controller2.reset();
                      controller2.forward();
                    },
                  ),
                ),
                Text(
                  "Deleted successfully",
                  style: TextStyle(
                      fontSize: useScreenHeight(18),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: useScreenHeight(100)),
                      child: Divider(
                        thickness: 5,
                        endIndent: useScreenWidth(10),
                        indent: useScreenWidth(10),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height - 195,
                      width: useScreenWidth(450),
                      decoration: BoxDecoration(
                        color: greenLight,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(useScreenWidth(12)),
                          topRight: Radius.circular(useScreenWidth(12)),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height - 195,
                            width: useScreenWidth(450),
                            decoration: BoxDecoration(
                              color: greenLight,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(useScreenWidth(12)),
                                topRight: Radius.circular(useScreenWidth(12)),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // user info
                                Container(
                                  padding: EdgeInsets.all(useScreenWidth(10)),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.1),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(useScreenWidth(12)),
                                      topRight:
                                          Radius.circular(useScreenWidth(12)),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: useScreenHeight(30),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: useScreenWidth(12)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Ryan Flatcher',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: useScreenHeight(18),
                                                letterSpacing: .4,
                                              ),
                                            ),
                                            SizedBox(
                                                height: useScreenHeight(5)),
                                            Text(
                                              '$different days to go',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            data.isComplete = true;
                                            context
                                                .read<ProviderListener>()
                                                .NumOfTask();
                                            context
                                                .read<ProviderListener>()
                                                .NumOfTaskComplete();
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: useScreenWidth(10)),
                                          decoration: BoxDecoration(
                                              color: data.isComplete == true
                                                  ? Colors.green
                                                  : Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: .8)),
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // duration
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: useScreenHeight(50)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            DateFormat.jm()
                                                .format(data.startTime!),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: useScreenHeight(18)),
                                          ),
                                          const Text(
                                            'Start',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: useScreenHeight(50),
                                        width: useScreenWidth(3),
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            DateFormat.jm()
                                                .format(data.endTime!),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: useScreenHeight(18)),
                                          ),
                                          const Text(
                                            'end',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                                data.isComplete
                                    ? Gif(
                                        image: const AssetImage(
                                            "assets/gif/completed.gif"),
                                        controller: controller1,
                                        fps: 30,
                                        // duration: const Duration(seconds: 3),
                                        autostart: Autostart.once,
                                        // placeholder: (context) =>
                                        //     const Text('Success'),
                                        onFetchCompleted: () {
                                          controller1.reset();
                                          controller1.forward();
                                        },
                                      )
                                    : Container(),
                                //  description

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: useScreenWidth(12)),
                                  child: Text(
                                    'Description',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: useScreenHeight(20)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: useScreenWidth(20),
                                    right: useScreenWidth(10),
                                  ),
                                  child: Text(data.description!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: useScreenHeight(15))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
