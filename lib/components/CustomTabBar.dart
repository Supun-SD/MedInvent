import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabTitles;
  final List<Widget> tabViews;

  const CustomTabBar({
    Key? key,
    required this.tabTitles,
    required this.tabViews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: tabTitles.length,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
            child: Container(
              height: screenHeight * 0.06,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(screenHeight * 0.1),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: const Color(0xFF2980B9),
                  borderRadius: BorderRadius.circular(screenHeight * 0.1),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: tabTitles.map((title) {
                  return Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title.split(" ")[0],
                          style: TextStyle(fontSize: screenHeight * 0.015),
                        ),
                        Text(
                          title.split(" ")[1],
                          style: TextStyle(fontSize: screenHeight * 0.015),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: tabViews,
            ),
          ),
        ],
      ),
    );
  }
}
