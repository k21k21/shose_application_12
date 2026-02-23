import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shose_application_12/User/details/view/detailspage.dart';
import 'package:shose_application_12/User/notification/view/notification_view.dart';
import 'package:shose_application_12/User/search/view/search.dart';
import 'package:shose_application_12/User/service/LouisVuitton_service.dart';
import 'package:shose_application_12/User/service/adidas_service.dart';
import 'package:shose_application_12/User/service/allservice.dart';
import 'package:shose_application_12/User/service/asics_service.dart';
import 'package:shose_application_12/User/service/bape_service.dart';
import 'package:shose_application_12/User/service/crocs_service.dart';
import 'package:shose_application_12/User/service/newbalance_service.dart';
import 'package:shose_application_12/User/service/nike_service.dart';
import 'dart:convert';
import 'package:shose_application_12/User/service/timberland_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

bool selected1 = false;
bool selected2 = false;
bool selected3 = false;
bool selected4 = false;
bool selected5 = false;
bool selected6 = false;
bool selected7 = false;
bool selected8 = false;
bool selected9 = false;

String selectedBrand = "";
String selectedCollection = "";

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> products = [];
  bool isLoadingData = false;

  // timberland_______________________________________________________________
  final TimberlandService _firestoreService = TimberlandService();
  Future<void> fetchBrandProducts({
    required String brand,
    required String collection,
  }) async {
    setState(() => isLoadingData = true);
    products = await _firestoreService.getBrandProducts(
      brandDoc: brand,
      collectionName: collection,
    );
    setState(() => isLoadingData = false);
  }

  // adidas_______________________________________________________________
  final AdidasService _firestoreServiceadidas = AdidasService();
  Future<void> fetchBrandProductsadidas({
    required String brand,
    required String collection,
  }) async {
    setState(() => isLoadingData = true);
    products = await _firestoreServiceadidas.getBrandProductsadidas(
      brandDoc: brand,
      collectionName: collection,
    );
    setState(() => isLoadingData = false);
  }

  // asics_______________________________________________________________
  final AsicsService _asicsService = AsicsService();
  Future<void> fetchBrandProductsasisc({
    required String brand,
    required String collection,
  }) async {
    setState(() => isLoadingData = true);
    products = await _asicsService.getBrandProductsasics(
      brandDoc: brand,
      collectionName: collection,
    );
    setState(() => isLoadingData = false);
  }

  // crocs_______________________________________________________________
  final CrocsService _crocsService = CrocsService();
  Future<void> fetchBrandProductscrocs({
    required String brand,
    required String collection,
  }) async {
    setState(() => isLoadingData = true);
    products = await _crocsService.getBrandProductscrocs(
      brandDoc: brand,
      collectionName: collection,
    );
    setState(() => isLoadingData = false);
  }

  // newbalance_______________________________________________________________
  final NewbalanceService _newbalanceService = NewbalanceService();
  Future<void> fetchBrandProductsnewbalance({
    required String brand,
    required String collection,
  }) async {
    setState(() => isLoadingData = true);
    products = await _newbalanceService.getBrandProductsnewbalance(
      brandDoc: brand,
      collectionName: collection,
    );
    setState(() => isLoadingData = false);
  }

  // nike_______________________________________________________________
  final NikeService _nikeService = NikeService();
  Future<void> fetchBrandProductsnike({
    required String brand,
    required String collection,
  }) async {
    setState(() => isLoadingData = true);
    products = await _nikeService.getNikeProductsByCollection(collection);
    setState(() => isLoadingData = false);
  }

  // louisvuitton_______________________________________________________________
  final LouisvuittonService _louisvuittonService = LouisvuittonService();
  Future<void> fetchBrandProductlouisvuitton({
    required String brand,
    required String collection,
  }) async {
    setState(() => isLoadingData = true);
    products = await _louisvuittonService.getBrandProductLouisvuitton(
      brandDoc: brand,
      collectionName: collection,
    );
    setState(() => isLoadingData = false);
  }

  // bape_______________________________________________________________
  final BapeService _bapeService = BapeService();
  Future<void> fetchBrandProductbape({
    required String brand,
    required String collection,
  }) async {
    setState(() => isLoadingData = true);
    products = await _bapeService.getBrandProductsbape(
      brandDoc: brand,
      collectionName: collection,
    );
    setState(() => isLoadingData = false);
  }

  // all_______________________________________________________________
  final Allservice _allservice = Allservice();

  Future<void> fetchAllProducts() async {
    setState(() => isLoadingData = true);

    products = await _allservice.getAllShoes();

    setState(() => isLoadingData = false);
  }

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
      _currentPage = _pageController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                            onPressed: () {},
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
                      width: 160.w,
                      height: 200.h,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 15.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: [

                  InkWell(
                    onTap: () async {
                      setState(() {
                        selected1 = true;
                        selected2 = false;
                        selected3 = false;
                        selected4 = false;
                        selected5 = false;
                        selected6 = false;
                        selected7 = false;
                        selected8 = false;
                        selected9 = false;
                      });
                      await fetchBrandProducts(brand: '', collection: '');
                    },
                    child: Container(
                      width: 60.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 243, 243),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: selected1 ? Colors.black : Colors.transparent,
                          width: 2.w,
                        ),
                      ),
                      child: Image.asset("assets/images/Timberlandlogo.png"),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        selected1 = false;
                        selected2 = true;
                        selected3 = false;
                        selected4 = false;
                        selected5 = false;
                        selected6 = false;
                        selected7 = false;
                        selected8 = false;
                        selected9 = false;
                      });
                      await fetchBrandProductsadidas(brand: '', collection: '');
                    },
                    child: Container(
                      width: 60.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 243, 243),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: selected2 ? Colors.black : Colors.transparent,
                          width: 2.w,
                        ),
                      ),
                      child: Image.asset(
                        "assets/images/689347-removebg-preview.png",
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        selected1 = false;
                        selected2 = false;
                        selected3 = true;
                        selected4 = false;
                        selected5 = false;
                        selected6 = false;
                        selected7 = false;
                        selected8 = false;
                        selected9 = false;
                      });
                      await fetchBrandProductsasisc(brand: '', collection: '');
                    },
                    child: Container(
                      width: 60.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 243, 243),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: selected3 ? Colors.black : Colors.transparent,
                          width: 2.w,
                        ),
                      ),
                      child: Image.asset(
                        "assets/images/371f20c81bc1d31cf5ab3c6f3fa746fd-removebg-preview.png",
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        selected1 = false;
                        selected2 = false;
                        selected3 = false;
                        selected4 = true;
                        selected5 = false;
                        selected6 = false;
                        selected7 = false;
                        selected8 = false;
                        selected9 = false;
                        isLoadingData = true;

                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.r),
                            ),
                          ),
                          builder: (context) {
                            return Container(
                              padding: EdgeInsets.all(20.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Nike Collections",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount:
                                          _nikeService.nikeCollections.length,
                                      itemBuilder: (context, index) {
                                        String collection =
                                            _nikeService.nikeCollections[index];
                                        return ListTile(
                                          title: Text(
                                            collection,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            setState(
                                              () => isLoadingData = true,
                                            );
                                            products = await _nikeService
                                                .getNikeProductsByCollection(
                                                  collection,
                                                );
                                            setState(
                                              () => isLoadingData = false,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      });
                    },

                    child: Container(
                      width: 60.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 243, 243),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: selected4 ? Colors.black : Colors.transparent,
                          width: 2.w,
                        ),
                      ),
                      child: Image.asset(
                        "assets/images/images-removebg-preview.png",
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        selected1 = false;
                        selected2 = false;
                        selected3 = false;
                        selected4 = false;
                        selected5 = false;
                        selected6 = false;
                        selected7 = false;
                        selected8 = true;
                        selected9 = false;
                      });
                      await fetchBrandProductbape(brand: '', collection: '');
                    },
                    child: Container(
                      width: 60.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 243, 243),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: selected8 ? Colors.black : Colors.transparent,
                          width: 2.w,
                        ),
                      ),
                      child: Image.asset(
                        "assets/images/images__1_-removebg-preview.png",
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        selected1 = false;
                        selected2 = false;
                        selected3 = false;
                        selected4 = false;
                        selected5 = false;
                        selected6 = false;
                        selected7 = false;
                        selected8 = false;
                        selected9 = true;
                      });
                      await fetchBrandProductlouisvuitton(
                        brand: '',
                        collection: '',
                      );
                    },
                    child: Container(
                      width: 60.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 243, 243),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: selected9 ? Colors.black : Colors.transparent,
                          width: 2.w,
                        ),
                      ),
                      child: Image.asset(
                        "assets/images/images-removebg-preview (1).png",
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        selected1 = false;
                        selected2 = false;
                        selected3 = false;
                        selected4 = false;
                        selected5 = true;
                        selected6 = false;
                        selected7 = false;
                        selected8 = false;
                        selected9 = false;
                      });
                      await fetchBrandProductscrocs(brand: '', collection: '');
                    },
                    child: Container(
                      width: 60.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 243, 243),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: selected5 ? Colors.black : Colors.transparent,
                          width: 2.w,
                        ),
                      ),
                      child: Image.asset(
                        "assets/images/crocs-logo-brandlogo.net_.png",
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        selected1 = false;
                        selected2 = false;
                        selected3 = false;
                        selected4 = false;
                        selected5 = false;
                        selected6 = true;
                        selected7 = false;
                        selected8 = false;
                        selected9 = false;
                      });
                      await fetchBrandProductsnewbalance(
                        brand: '',
                        collection: '',
                      );
                    },
                    child: Container(
                      width: 60.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 243, 243),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: selected6 ? Colors.black : Colors.transparent,
                          width: 2.w,
                        ),
                      ),
                      child: Image.asset(
                        "assets/images/new-balance-logo-png_seeklogo-171399-removebg-preview.png",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15.h),
          SizedBox(
            height: 400.h,
            child: isLoadingData
                ? Center(child: CircularProgressIndicator(color: Colors.black))
                : PageView.builder(
                    controller: _pageController,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      double scale = (0 - (_currentPage - index).abs()).clamp(
                        1.0,
                        1.0,
                      );
                      return Transform.scale(
                        scale: scale,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          clipBehavior: Clip.none,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => detailspage(
                                      bgColor:
                                          cardColors[index % cardColors.length],
                                      brandProducts: products,
                                      selectedIndex: index,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  width: 400.w,
                                  height: 290.h,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        cardColors[index % cardColors.length],
                                    borderRadius: BorderRadius.circular(20.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 7.r,
                                        offset: Offset(0, 3.h),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 90),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                right: 100.w,
                                              ),
                                              child: Text(
                                                product['name'] ?? "nodata",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.sp,
                                                  fontFamily:
                                                      "Roboto_Condensed",
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                right: 100.w,
                                                top: 7.h,
                                              ),
                                              child: Text(
                                                product['namebrand'] ??
                                                    "nodata",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp,
                                                  fontFamily:
                                                      "Roboto_Condensed",
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 10.w,
                                                    top: 50.h,
                                                  ),
                                                  child: Text(
                                                    product['price'].toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.sp,
                                                      fontFamily:
                                                          "Roboto_Condensed",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 20.w,
                                        child: Container(
                                          width: 55.w,
                                          height: 80.h,
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
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
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
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.add,
                                                      color:
                                                          const Color.fromARGB(
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
                            Positioned(
                              top: -30.h,
                              right: 20.w,
                              child: Transform.rotate(
                                angle: -0.6,
                                child: product['img'] != null
                                    ? Image.memory(
                                        base64Decode(
                                          product['img']
                                              .toString()
                                              .split(',')
                                              .last,
                                        ),
                                        width: 200.w,
                                        height: 200.h,
                                        fit: BoxFit.contain,
                                      )
                                    : Image.asset(
                                        "assets/images/s-l1200-removebg-preview.png",
                                        width: 250.w,
                                        height: 250.h,
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ),
                            Positioned(
                              top: 60.h,
                              right: 200.w,
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
                                  color: Colors.black,
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
