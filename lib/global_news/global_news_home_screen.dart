// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application/global_news/global_news_india.dart';
import 'package:news_application/global_news/global_news_russia.dart';
import 'package:news_application/global_news/global_news_uk.dart';
import 'package:news_application/global_news/global_news_us.dart';

void main() {
  runApp(const GlobalNewsHomeScreen());
}

class GlobalNewsHomeScreen extends StatefulWidget {
  const GlobalNewsHomeScreen({super.key});

  @override
  _GlobalNewsHomeScreenState createState() => _GlobalNewsHomeScreenState();
}

class _GlobalNewsHomeScreenState extends State<GlobalNewsHomeScreen>
    with SingleTickerProviderStateMixin {
  Widget _buildTabBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 4.0,
        isScrollable: true,
        tabs: <Widget>[
          SizedBox(
            height: 35.h,
            width: 52.w,
            child: const Tab(
              child: Text("India"),
            ),
          ),
          SizedBox(
            height: 35.h,
            width: 52.w,
            child: const Tab(
              child: Text("US"),
            ),
          ),
          SizedBox(
            height: 35.h,
            width: 52.w,
            child: const Tab(
              child: Text("UK"),
            ),
          ),
          SizedBox(
            height: 35.h,
            width: 52.w,
            child: const Tab(
              child: Text("Russia"),
            ),
          ),
        ],
      ),
    );
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 39, 39),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Global News",
              style:
                  GoogleFonts.ibmPlexSerif(textStyle: const TextStyle(fontSize: 24)),
            )
          ],
        ),
        elevation: 0, // Remove elevation
        backgroundColor: Colors.transparent, // Make appbar transparent
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 10.0),
          child: Container(
            padding: const EdgeInsets.only(top: 10.0),
            child: _buildTabBar(),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget> [
          GlobalNewsIndia(),
          GlobalNewsUs(),
          GlobalNewsUk(),
          GlobalNewsRussia(),
        ],
      ),
    );
  }
}
