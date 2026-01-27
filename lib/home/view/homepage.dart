import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shose_application_12/details/view/detailspage.dart';
import 'package:shose_application_12/notification/view/notification_view.dart';
import 'package:shose_application_12/search/view/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.65);
  double _currentPage = 0;

  final List<Color> cardColors = [
    Color(0xffBEE7E8),
    Color(0xffF2C6C6),
    Color(0xffC9D6F0),
    Color(0xffF5E0B7),
    Color(0xffD6CDEE),
  ];

  int selectedIndex = 0;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil init
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NotificationView()),
              );
            },
            icon: Icon(
              Icons.notifications_none,
              size: 30.sp,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SearchPage()),
                );
              },
              icon: Icon(
                Icons.search,
                size: 30.sp,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Top (الصورة بحجمها الطبيعي)
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Center(
              child: Container(
                width: 1.sw,
                height: 180.h,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                            "New Release",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: "Roboto_Condensed",
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                            "Nike Travis\nScott Shose",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto_Condensed",
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => detailspage(),
                                ),
                              );
                            },
                            child: Text(
                              "Shop Now",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto_Condensed",
                              ),
                            ),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Image.asset(
                      "assets/images/s-l1200-removebg-preview.png",
                      width: 160.w, // خليت الحجم زي ما هو أصلي تقريبًا
                      height: 200.h,
                      fit: BoxFit.contain, // خلي الصورة تبقى كما هي
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 15.h),

          // Category Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: List.generate(5, (i) {
                  List<String> titles = [
                    "Popular",
                    "Men",
                    "Women",
                    "Kids",
                    "Collection",
                  ];
                  return Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = i;
                        });
                      },
                      child: Container(
                        width: 90.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: selectedIndex == i
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: Text(
                            titles[i],
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto_Condensed",
                              color: selectedIndex == i
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          SizedBox(height: 15.h),

          // PageView Cards
          SizedBox(
            height: 400.h,
            child: PageView.builder(
              controller: _pageController,
              itemCount: 5,
              itemBuilder: (context, index) {
                double scale = (1 - (_currentPage - index).abs()).clamp(
                  0.8,
                  1.0,
                );
                return Transform.scale(
                  scale: scale,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      // ================== الكارت ==================
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const detailspage(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(
                            width: 400.w,
                            height: 290.h,
                            margin: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: cardColors[index % cardColors.length],
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 7.r,
                                  offset: Offset(0, 3.h),
                                ),
                              ],
                            ),

                            // 🔽 التعديل هنا فقط
                            child: Stack(
                              children: [
                                // ---------- المحتوى الأصلي ----------
                                Padding(
                                  padding: EdgeInsets.only(top: 90),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 30.w),
                                        child: Text(
                                          "Travis Scott Shose",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                            fontFamily: "Roboto_Condensed",
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 130.w,
                                          top: 7.h,
                                        ),
                                        child: Text(
                                          "Men Shoe's",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp,
                                            fontFamily: "Roboto_Condensed",
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 10.w,
                                              top: 70.h,
                                            ),
                                            child: Text(
                                              "120S",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp,
                                                fontFamily: "Roboto_Condensed",
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // ---------- الشريط الطويل (جوا الكونتينر) ----------
                                Positioned(
                                  bottom: 0,
                                  right: 20.w,
                                  child: Container(
                                    width: 55.w,
                                    height: 80.h, // ⭐ طويل
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25.r),
                                        topRight: Radius.circular(25.r),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 40.w,
                                            height: 40.h,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                255,
                                                255,
                                                255,
                                                255,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.add,
                                                color: const Color.fromARGB(
                                                  255,
                                                  0,
                                                  0,
                                                  0,
                                                ),
                                                size: 24.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // ================== صورة الحذاء ==================
                      Positioned(
                        top: -84.h,
                        right: 32.w,
                        child: Transform.rotate(
                          angle: -0.6,
                          child: Image.asset(
                            "assets/images/s-l1200-removebg-preview.png",
                            width: 220.w,
                            height: 220.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      // ================== Favorite Icon فوق كل حاجة ==================
                      Positioned(
                        top: 60.h, // فوق الصورة شوية
                        right: 200.w, // جنب الصورة
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: Icon(
                            isFavorite
                                ? Icons.bookmark
                                : Icons.bookmark_add_outlined,
                            color: isFavorite
                                ? const Color.fromARGB(255, 0, 0, 0)
                                : const Color.fromARGB(255, 0, 0, 0),
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
