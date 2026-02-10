import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shose_application_12/User/login/view/login.dart';
import 'package:shose_application_12/User/setting/view/setting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: Column(
            children: [
              Container(
                height: 400.h,
                width: 500.w,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 50.h),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Center(
                        child: CircleAvatar(
                          radius: 45.r,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: Text(
                          'Jane Cooper',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Center(
                        child: Text(
                          'Janeper01@gmail.com',
                          style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 22.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade800.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.receipt_long,
                                      color: Colors.white,
                                      size: 28.sp,
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      'My Orders',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 22.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade800.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.history,
                                      color: Colors.white,
                                      size: 28.sp,
                                    ),
                                    SizedBox(height: 5.h),
                                    Center(
                                      child: Text(
                                        'My requests',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
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
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SettingsPage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 3.h,
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.settings_outlined,
                            color: Colors.black,
                            size: 28.sp,
                          ),
                          title: Text(
                            'Setting',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              fontFamily: "Roboto_Condensed",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 3.h,
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.info_outline,
                            color: Colors.black,
                            size: 28.sp,
                          ),
                          title: Text(
                            'About App',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              fontFamily: "Roboto_Condensed",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 3.h,
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.help_outline,
                            color: Colors.black,
                            size: 28.sp,
                          ),
                          title: Text(
                            'Help & Support',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              fontFamily: "Roboto_Condensed",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => loginpage()),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 3.h,
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.red,
                            size: 28.sp,
                          ),
                          title: Text(
                            'Log out',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              fontFamily: "Roboto_Condensed",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
