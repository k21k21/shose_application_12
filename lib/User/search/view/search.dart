import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../viewmodel/seach_viewmodel.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          final vm = context.watch<SearchViewModel>();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, size: 20, color: Colors.black),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            body: SafeArea(
              child: Column(
                children: [
                  _searchBar(vm),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: vm.filteredShoes.isEmpty
                        ? const _EmptyState()
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            itemCount: vm.filteredShoes.length,
                            itemBuilder: (context, index) {
                              final shoe = vm.filteredShoes[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: SearchShoeCard(
                                  title: shoe['title'],
                                  subtitle: shoe['subtitle'],
                                  price: shoe['price'],
                                  image: shoe['image'],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _searchBar(SearchViewModel vm) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: TextField(
        controller: vm.searchController,
        onChanged: vm.onSearch,
        decoration: InputDecoration(
          hintText: 'Search shoes...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

/* ================= Shoe Card ================= */

class SearchShoeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int price;
  final String image;

  const SearchShoeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Container(
            height: 70.h,
            width: 70.w,
            decoration: BoxDecoration(
              color: const Color(0xffEFE6FF),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          Text(
            '\$$price',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}

/* ================= Empty State ================= */

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80.h, color: Colors.grey),
          SizedBox(height: 12.h),
          Text(
            'No results found',
            style: TextStyle(color: Colors.grey, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
