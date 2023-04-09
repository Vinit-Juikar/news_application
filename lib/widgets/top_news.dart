import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application/api/top_news_api.dart';

class TopNews extends StatelessWidget {
  const TopNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: getTopNews(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final articleList = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 235.h,
              width: 330.w,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  final article = articleList[index];
                  final name = article['name'];
                  final description = article['description'];
                  final imageUrl = article['imageUrl'];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 7),
                    height: 105.h,
                    width: 330.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.h),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                           height: 28.h,
                            width: 200.w,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15,top: 5),
                              child: Text(
                                name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ), //this container is for the title
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 65.h,
                                width: 230.w,
                                // color: Colors.pink,
                                child: Text(
                                  description!,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.sourceSansPro(
                                      textStyle: TextStyle(
                                          fontSize: 14.h,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ), //this container is for description
                              SizedBox(
                                height: 65.h,
                                width: 70.w,
                                child: 
                                ClipRRect(
                                   borderRadius: BorderRadius.all(Radius.circular(10.h)),
                                  child: Image.network(
                                    imageUrl!,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      final double? value = loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                          : null;
                                      return Center(
                                        child: TweenAnimationBuilder<double>(
                                          tween: Tween(begin: 0.0, end: value),
                                          duration:
                                              const Duration(milliseconds: 500),
                                          builder: (context, double val, child) {
                                            return CircularProgressIndicator(
                                                value: val);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ), //this is for the image
                            ],
                          ),
                        ) // this container is for the title
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  static Widget create() => const TopNews();
}
