import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/app_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return Scaffold(
          backgroundColor:  Color(0xffF7F7F7),
          body: SafeArea(
            child: Column(
              children: [
                Center(child: _appBar(settings)),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    children: [

                      SizedBox(height: 20.h),
                      _settingTile(
                        icon: Icons.lock,
                        title: settings.isArabic
                            ? 'تغيير كلمة المرور'
                            : 'Change Password',
                        onTap: () {},
                      ),

                      SizedBox(height: 20.h),
                      _sectionTitle(
                        settings.isArabic ? 'التفضيلات' : 'Preferences',
                      ),
                      _switchTile(
                        icon: Icons.notifications,
                        title: settings.isArabic
                            ? 'الإشعارات'
                            : 'Notifications',
                        value: notifications,
                        onChanged: (v) => setState(() => notifications = v),
                      ),
                      _switchTile(
                        icon: Icons.dark_mode,
                        title: settings.isArabic ? 'الوضع الداكن' : 'Dark Mode',
                        value: settings.isDark,
                        onChanged: settings.toggleTheme,
                      ),
                      _switchTile(
                        icon: Icons.language,
                        title: settings.isArabic
                            ? 'اللغة العربية'
                            : 'Arabic Language',
                        value: settings.isArabic,
                        onChanged: settings.changeLanguage,
                      ),
                      SizedBox(height: 30.h),
                      _logoutButton(settings),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _appBar(AppSettings settings) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: SizedBox(
        width: double.infinity,
          child:
          Center(
            child: Text(
              settings.isArabic ? 'الإعدادات' : 'Settings',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
          ),
      ),

    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: ListTile(
        leading: Icon(icon, size: 22.sp, color: Colors.black),
        title: Text(title, style: TextStyle(fontSize: 14.sp)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
        onTap: onTap,
      ),
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: SwitchListTile(
        secondary: Icon(icon, color: Colors.black, size: 24.sp),
        title: Text(title, style: TextStyle(fontSize: 14.sp)),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.black,
      ),
    );
  }

  Widget _logoutButton(AppSettings settings) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
      ),
      child: Text(
        settings.isArabic ? 'حذف الحساب' : 'Delete Account',
        style: TextStyle(

          fontSize: 16.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
