import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shose_application_12/viewmodel/app_settings.dart';
import 'package:shose_application_12/view/card.dart';
import 'package:shose_application_12/view/setting.dart';
import 'package:shose_application_12/viewmodel/signup_viewmodel.dart';

import 'view/login.dart';
import 'view/homepage.dart';
import 'viewmodel/login_viewmodel.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppSettings(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: settings.locale,
      themeMode: settings.themeMode, // هنا يتم تطبيق الثيم
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white, // باكجروند النهار
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black, // باكجروند الليل
      ),
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
       home:SettingsPage(),
     );


    //MultiProvider(
    //   // providers: [
    //   //   ChangeNotifierProvider(
    //   //     create: (_) => LoginViewModel(),
    //   //   ),
    //   //   ChangeNotifierProvider(create: (_) => SignupViewModel()),
    //   //
    //   // ],
    //   // child: const MaterialApp(
    //   //   debugShowCheckedModeBanner: false,
    //   //   home: AuthGate(),
    //   ),
    //);
  }
}
//
// class AuthGate extends StatelessWidget {
//   const AuthGate({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }
//
//         if (snapshot.hasData) {
//           return HomePage();
//         }
//
//         return const loginpage();
//       },
//     );
//   }
// }
