import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application/api/latest_news_carousel_images.dart';
import 'package:news_application/home_screen/search_section.dart';
import 'package:news_application/pages/profile_page.dart';
import 'package:news_application/widgets/business_news.dart';
import 'package:news_application/widgets/local_news.dart';
import 'package:news_application/widgets/top_news.dart';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({Key? key}) : super(key: key);

  @override
  State<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isSearching = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
            SizedBox(
              width: 270.w,
              child: Text(
                name,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  AppBar _buildAppBarForNewsScreen() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 40, 39, 39),
      elevation: 0,
      title: Row(
        children: [
          GestureDetector(
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (BuildContext context) => ProfileScreen(),
            //     ),
            //   );
            // },
            child: const Icon(
              Icons.person,
              size: 40,
            ),
          ),
          const Spacer(),
          Text(
            "News Bridge",
            style: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20)),
          ),
          const Spacer(),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return _isSearching
                  ? SizedBox(
                      width: _animation.value * 200,
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSearching = true;
                        });
                        _animationController.forward();
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const SearchSection();
                        })).then((value) {
                          setState(() {
                            _isSearching = false;
                          });
                          _animationController.reverse();
                        });
                      },
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    );
            },
          ),
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
              const TopNews(),
              _titleOfNews("Local News"),
              const LocalNews(),
              _titleOfNews("Business News"),
              const BusinessNewsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
