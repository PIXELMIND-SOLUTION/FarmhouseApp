// import 'package:farmhouse_app/provider/Location/location_provider.dart';
// import 'package:farmhouse_app/provider/Location/nearby_farmhouse_provider.dart';
// import 'package:farmhouse_app/provider/auth/forgot_password_provider.dart';
// import 'package:farmhouse_app/provider/auth/login_provider.dart';
// import 'package:farmhouse_app/provider/auth/profile_provider.dart';
// import 'package:farmhouse_app/provider/auth/register_provider.dart';
// import 'package:farmhouse_app/provider/booking/booking_provider.dart';
// import 'package:farmhouse_app/provider/booking/payment_provider.dart';
// import 'package:farmhouse_app/provider/firebase/google_provider.dart';
// import 'package:farmhouse_app/provider/navbar/navbar_provider.dart';
// import 'package:farmhouse_app/provider/wishlist/wishlist_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:farmhouse_app/views/splash/splash_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Firebase
//   await Firebase.initializeApp();
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//         ChangeNotifierProvider(create: (_) => LoginProvider()),
//         ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
//         ChangeNotifierProvider(create: (_) => ProfileProvider()),
//         ChangeNotifierProvider(create: (_) => LocationProvider()),
//         ChangeNotifierProvider(create: (_) => FarmhouseProvider()),
//         ChangeNotifierProvider(create: (_) => BookingProvider()),
//         ChangeNotifierProvider(create: (_) => GoogleAuthenticationProvider()),
//         ChangeNotifierProvider(create: (_) => WishlistProvider()),
//         ChangeNotifierProvider(create: (_) => PaymentProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'V FARM',
//       debugShowCheckedModeBanner: false,

//       theme: ThemeData(
//         useMaterial3: true,
//         brightness: Brightness.light,

//         // ✅ Main Colors
//         scaffoldBackgroundColor: Colors.white,
//         primaryColor: Colors.black,

//         colorScheme: const ColorScheme.light(
//           primary: Colors.black,
//           secondary: Colors.black,
//           surface: Colors.white,
//         ),

//         // ✅ AppBar Theme
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//           elevation: 0,
//           centerTitle: true,
//         ),

//         // ✅ Text Theme
//         textTheme: const TextTheme(
//           headlineLarge: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//           headlineMedium: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//           bodyLarge: TextStyle(color: Colors.black),
//           bodyMedium: TextStyle(color: Colors.black87),
//         ),

//         // ✅ Icon Theme
//         iconTheme: const IconThemeData(
//           color: Colors.black,
//         ),

//         // ✅ Buttons
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.black,
//             foregroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             elevation: 0,
//           ),
//         ),

//         // ✅ Input Fields
//         inputDecorationTheme: InputDecorationTheme(
//           filled: true,
//           fillColor: Colors.grey.shade100,
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide:
//                 BorderSide(color: Colors.grey.shade300),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.black),
//           ),
//           hintStyle: const TextStyle(color: Colors.grey),
//         ),

//         // ✅ Checkbox Theme
//         checkboxTheme: CheckboxThemeData(
//           fillColor:
//               MaterialStateProperty.all(Colors.black),
//         ),

//         // ✅ SnackBar Theme
//         snackBarTheme: const SnackBarThemeData(
//           backgroundColor: Colors.black,
//           contentTextStyle:
//               TextStyle(color: Colors.white),
//           behavior: SnackBarBehavior.floating,
//         ),

//         // ✅ Divider
//         dividerColor: Colors.grey.shade300,
//       ),

//       home: const SplashScreen(),
//     );
//   }
// }










import 'package:farmhouse_app/provider/Location/location_provider.dart';
import 'package:farmhouse_app/provider/Location/nearby_farmhouse_provider.dart';
import 'package:farmhouse_app/provider/auth/forgot_password_provider.dart';
import 'package:farmhouse_app/provider/auth/login_provider.dart';
import 'package:farmhouse_app/provider/auth/profile_provider.dart';
import 'package:farmhouse_app/provider/auth/register_provider.dart';
import 'package:farmhouse_app/provider/booking/booking_provider.dart';
import 'package:farmhouse_app/provider/booking/payment_provider.dart';
import 'package:farmhouse_app/provider/firebase/google_provider.dart';
import 'package:farmhouse_app/provider/navbar/navbar_provider.dart';
import 'package:farmhouse_app/provider/wishlist/wishlist_provider.dart';
import 'package:farmhouse_app/theme/theme_provider.dart';
import 'package:farmhouse_app/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farmhouse_app/views/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [

        /// 🔥 THEME PROVIDER
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => FarmhouseProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => GoogleAuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'V FARM',
          debugShowCheckedModeBanner: false,

          /// ✅ LIGHT THEME
          theme: AppTheme.lightTheme,

          /// ✅ DARK THEME
          darkTheme: AppTheme.darkTheme,

          /// ✅ ACTIVE MODE
          themeMode: themeProvider.themeMode,

          home: const SplashScreen(),
        );
      },
    );
  }
}
