// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application/data/news_headlines.dart';
import 'package:shimmer/shimmer.dart';

class GlobalNewsRussia extends StatefulWidget {
  const GlobalNewsRussia({Key? key}) : super(key: key);

  @override
  _GlobalNewsRussiaState createState() => _GlobalNewsRussiaState();
}

class _GlobalNewsRussiaState extends State<GlobalNewsRussia> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    // Set a timer to simulate a 2-second loading delay
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 39, 39),
      body: _loading ? _buildShimmer() : _buildBody(),
    );
  }

Widget _buildShimmer() {
  return ListView.builder(
    itemCount: 5,
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.all(16.sp),
        child: Shimmer.fromColors(
          direction: ShimmerDirection.ttb,
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 150.h,
            width: 300.w,
            decoration: BoxDecoration(
              color: Colors.grey[300]!,
              borderRadius: BorderRadius.circular(8.sp),
            ),
            child: Row(
              children: [
                Shimmer.fromColors(
                  direction: ShimmerDirection.ttb,
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 130.h,
                    width: 100.w,
                    margin: EdgeInsets.only(right: 10.sp),
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 30.h,
                        width: 150.w,
                        margin: EdgeInsets.only(bottom: 10.sp),
                        decoration: BoxDecoration(
                          color: Colors.grey[300]!,
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 100.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          color: Colors.grey[300]!,
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

  Widget _buildBody() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: indiaNewsDescription.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 2),
          child: Container(
            height: 150.h,
            width: 280.w,
            decoration: BoxDecoration(
              // color: Colors.green,
              border: index == 0
                  ? null
                  : const Border(
                      top: BorderSide(
                        width: 0.5,
                        color: Colors.grey,
                      ),
                    ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 25),
                    height: 80.h,
                    width: 100.w,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Image.network(
                        RandomImageUrlsForRussia[index].toString(),fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 5),
                      height: 30.h,
                      width: 200.w,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          RussiaNewsHeadlines[index],
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100.h,
                      width: 200.w,
                      child: Text(
                        russiaNewsDescription[index],
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
