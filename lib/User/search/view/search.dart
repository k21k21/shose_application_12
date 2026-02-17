import 'dart:convert';
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
            backgroundColor: Colors.white,

            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.grey.shade600,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [


                        SizedBox(width: 7.w),
                        Expanded(
                          child: _searchBar(vm),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  Expanded(
                    child: vm.isLoadingData
                        ? const Center(child: CircularProgressIndicator())
                        : vm.filteredShoes.isEmpty
                        ? const _EmptyState()
                        : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: vm.filteredShoes.length,
                      itemBuilder: (context, index) {
                        final shoe = vm.filteredShoes[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
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
      child: Container(
        height: 52.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: TextField(
          controller: vm.searchController,
          onChanged: vm.onSearch,
          decoration: InputDecoration(
            hintText: 'Search shoes...',
            prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

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
    Widget shoeImage;

    if (image.startsWith('http')) {
      shoeImage = Image.network(image, fit: BoxFit.cover);
    } else if (image.isNotEmpty) {
      try {
        shoeImage = Image.memory(base64Decode(image), fit: BoxFit.cover);
      } catch (_) {
        shoeImage = const Icon(Icons.image_not_supported);
      }
    } else {
      shoeImage = const Icon(Icons.image_not_supported);
    }

    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xffBEE7E8),
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 72.h,
              width: 72.w,
              decoration: BoxDecoration(
                color: const Color(0xffF3F3F3),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: shoeImage,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '\$$price',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 72.h, color: Colors.grey.shade400),
          SizedBox(height: 12.h),
          Text(
            'No results found',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
