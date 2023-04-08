import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application/api/latest_news_carousel_images.dart';
import 'package:news_application/widgets/app_bar_for_news_screen.dart';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({Key? key}) : super(key: key);

  @override
  State<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  Widget _buildScaffoldWidget() {
    return FutureBuilder<List<String>>(
      future: getNewsApiImages(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final imageUrls = snapshot.data!;
          return SizedBox(
            height: 180.h,
            width: ScreenUtil().screenWidth,
            child: Center(
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: 180.h,
                  viewportFraction: 0.92,
                  autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                  autoPlayInterval: const Duration(milliseconds: 5000),
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                ),
                itemCount: imageUrls.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10),
                    width: 345.w,
                    height: 180.h,
                    decoration: const BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(44),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(44)),
                      child: Image.network(
                        imageUrls[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Failed to fetch news images'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _titleOfNews(
    String name,
  ) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Container(
              width: 270.w,
              child: Text(
                name,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontFamily: "Monserrat"),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_circle_right,
              size: 40,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }

  Widget _latestNews() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 235.h,
        width: 330.w,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
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
                      height: 20.h,
                      width: 200.w,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "Bharati Times",
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
                        Container(
                          height: 65.h,
                          width: 230.w,
                          // color: Colors.pink,
                          child: Text(
                            "This is the random things that make the differnt of the overall things that might be the technique to make it the best of the world but there are also another things that help in making it successful so that we can do our things in normal manner",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.sourceSansPro(
                                textStyle: TextStyle(
                                    fontSize: 14.h,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ), //this container is for description
                        Container(
                          height: 65.h,
                          width: 70.w,
                          color: Colors.amber,
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
  }

  AppBar _buildAppBarForNewsScreen() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 40, 39, 39),
      elevation: 0,
      title: Row(
        children: [
          const Icon(
            Icons.circle,
            size: 40,
          ),
          const Spacer(),
          Text(
            "News Bridge",
            style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20)),
          ),
          const Spacer(),
          const Icon(
            Icons.search,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 39, 39),
      appBar: _buildAppBarForNewsScreen(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: [
              _buildScaffoldWidget(),
              _titleOfNews("Top Stories"),
              _latestNews(),
              _titleOfNews("Local News"),
              _latestNews(),
              _titleOfNews("Business News"),
              _latestNews(),
            ],
          ),
        ),
      ),
    );
  }
}
