import 'package:flutter/material.dart';

import '../utils/constant.dart';
import '../utils/screen_size.dart';
import 'all_tab.dart';

class Tabs extends StatelessWidget {
  const Tabs({
    super.key,
    required this.tabController,
  });

  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return TabBar(
        labelPadding: EdgeInsets.symmetric(horizontal: useScreenWidth(20)),
        unselectedLabelColor: Colors.grey,
        isScrollable: true,
        indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        controller: tabController,
        labelColor: greenLight,
        tabs: const [
          Tab(
            text: 'All',
          ),
          Tab(
            text: 'Today',
          ),
          Tab(
            text: 'Upcoming',
          ),
          Tab(
            text: 'Recently',
          ),
        ]);
  }
}

class TabViewWidget extends StatelessWidget {
  const TabViewWidget({
    Key? key,
    required this.tabController,
    required this.fullScreen,
  }) : super(key: key);
  final bool fullScreen;
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return SizedBox(
      height: fullScreen ? useScreenHeight(600) : useScreenHeight(250),
      child: TabBarView(controller: tabController, children: const [
        AllTabBar(),
        TodayTabBar(),
        UpcomingTabBar(),
        RecentlyTabBar(),
      ]),
    );
  }
}
