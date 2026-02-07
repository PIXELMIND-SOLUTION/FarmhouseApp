// import 'package:farmhouse_app/views/onboarding/onboarding_screen.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _logoController;
//   late AnimationController _textController;
//   late AnimationController _particleController;
//   late AnimationController _shimmerController;
  
//   late Animation<double> _logoScaleAnimation;
//   late Animation<double> _logoFadeAnimation;
//   late Animation<double> _logoRotateAnimation;
//   late Animation<double> _textFadeAnimation;
//   late Animation<Offset> _textSlideAnimation;
//   late Animation<double> _shimmerAnimation;

//   @override
//   void initState() {
//     super.initState();
    
//     _logoController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );
    
//     _textController = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );
    
//     _particleController = AnimationController(
//       duration: const Duration(milliseconds: 3000),
//       vsync: this,
//     );
    
//     _shimmerController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );
    
//     _logoScaleAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _logoController,
//       curve: Curves.easeOutBack,
//     ));
    
//     _logoFadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _logoController,
//       curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
//     ));
    
//     _logoRotateAnimation = Tween<double>(
//       begin: -0.5,
//       end: 0.0,
//     ).animate(CurvedAnimation(
//       parent: _logoController,
//       curve: Curves.easeOutBack,
//     ));
    
//     _textFadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _textController,
//       curve: Curves.easeIn,
//     ));
    
//     _textSlideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _textController,
//       curve: Curves.easeOutCubic,
//     ));
    
//     _shimmerAnimation = Tween<double>(
//       begin: -2.0,
//       end: 2.0,
//     ).animate(CurvedAnimation(
//       parent: _shimmerController,
//       curve: Curves.easeInOut,
//     ));
    
//     _startAnimations();
//   }
  
//   void _startAnimations() async {
//     _particleController.repeat();
//     _shimmerController.repeat();
    
//     await Future.delayed(const Duration(milliseconds: 300));
//     await _logoController.forward();
//     await _textController.forward();
    
//     await Future.delayed(const Duration(milliseconds: 1500));
//     if (mounted) {
//       Navigator.pushReplacement(
//         context,
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) => const OnboardingScreen(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(opacity: animation, child: child);
//           },
//           transitionDuration: const Duration(milliseconds: 500),
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _logoController.dispose();
//     _textController.dispose();
//     _particleController.dispose();
//     _shimmerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Animated Gradient Background
//           AnimatedBuilder(
//             animation: _particleController,
//             builder: (context, child) {
//               return Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Color.lerp(
//                         const Color(0xFF1E3A8A),
//                         const Color(0xFF3B82F6),
//                         (_particleController.value * 2) % 1,
//                       )!,
//                       const Color(0xFF3B82F6),
//                       Color.lerp(
//                         const Color(0xFF8B5CF6),
//                         const Color(0xFFA855F7),
//                         (_particleController.value * 2) % 1,
//                       )!,
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
          
//           // Floating Particles
//           ...List.generate(20, (index) {
//             return AnimatedBuilder(
//               animation: _particleController,
//               builder: (context, child) {
//                 final progress = (_particleController.value + index * 0.1) % 1.0;
//                 final size = 4.0 + (index % 3) * 2.0;
//                 return Positioned(
//                   left: (index * 50.0) % MediaQuery.of(context).size.width,
//                   top: MediaQuery.of(context).size.height * progress,
//                   child: Opacity(
//                     opacity: (1 - progress) * 0.3,
//                     child: Container(
//                       width: size,
//                       height: size,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.white.withOpacity(0.5),
//                             blurRadius: 10,
//                             spreadRadius: 2,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }),
          
//           // Main Content
//           SafeArea(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Spacer(flex: 3),
                  
//                   // Animated Logo with Glow Effect
//                   AnimatedBuilder(
//                     animation: _logoController,
//                     builder: (context, child) {
//                       return FadeTransition(
//                         opacity: _logoFadeAnimation,
//                         child: Transform.rotate(
//                           angle: _logoRotateAnimation.value * math.pi,
//                           child: ScaleTransition(
//                             scale: _logoScaleAnimation,
//                             child: Container(
//                               width: 160,
//                               height: 160,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: const LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: [
//                                     Colors.white,
//                                     Color(0xFFF0F9FF),
//                                   ],
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.blue.shade300.withOpacity(0.6),
//                                     blurRadius: 40,
//                                     spreadRadius: 10,
//                                   ),
//                                   BoxShadow(
//                                     color: Colors.purple.shade300.withOpacity(0.4),
//                                     blurRadius: 60,
//                                     spreadRadius: 15,
//                                   ),
//                                 ],
//                               ),
//                               child: Stack(
//                                 alignment: Alignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.rocket_launch_rounded,
//                                     size: 80,
//                                     color: Colors.blue.shade700,
//                                   ),
//                                   AnimatedBuilder(
//                                     animation: _shimmerController,
//                                     builder: (context, child) {
//                                       return Positioned.fill(
//                                         child: ClipOval(
//                                           child: OverflowBox(
//                                             maxWidth: double.infinity,
//                                             child: Transform.translate(
//                                               offset: Offset(_shimmerAnimation.value * 100, 0),
//                                               child: Container(
//                                                 width: 100,
//                                                 decoration: BoxDecoration(
//                                                   gradient: LinearGradient(
//                                                     colors: [
//                                                       Colors.transparent,
//                                                       Colors.white.withOpacity(0.3),
//                                                       Colors.transparent,
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
                  
//                   const SizedBox(height: 40),
                  
//                   // Animated App Name with Shimmer
//                   AnimatedBuilder(
//                     animation: _textController,
//                     builder: (context, child) {
//                       return FadeTransition(
//                         opacity: _textFadeAnimation,
//                         child: SlideTransition(
//                           position: _textSlideAnimation,
//                           child: Column(
//                             children: [
//                               ShaderMask(
//                                 shaderCallback: (bounds) {
//                                   return LinearGradient(
//                                     colors: const [
//                                       Colors.white,
//                                       Color(0xFFE0F2FE),
//                                       Colors.white,
//                                     ],
//                                   ).createShader(bounds);
//                                 },
//                                 child: const Text(
//                                   'Farm House App',
//                                   style: TextStyle(
//                                     fontSize: 36,
//                                     fontWeight: FontWeight.w800,
//                                     color: Colors.white,
//                                     letterSpacing: 2.0,
//                                     height: 1.2,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 20,
//                                   vertical: 8,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withOpacity(0.15),
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(
//                                     color: Colors.white.withOpacity(0.3),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: Text(
//                                   'Your Journey Starts Here',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.white.withOpacity(0.95),
//                                     letterSpacing: 1.2,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
                  
//                   const Spacer(flex: 3),
                  
//                   // Modern Loading Indicator
//                   AnimatedBuilder(
//                     animation: _particleController,
//                     builder: (context, child) {
//                       return Column(
//                         children: [
//                           Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               SizedBox(
//                                 width: 50,
//                                 height: 50,
//                                 child: CircularProgressIndicator(
//                                   valueColor: AlwaysStoppedAnimation<Color>(
//                                     Colors.white.withOpacity(0.3),
//                                   ),
//                                   strokeWidth: 3,
//                                   value: 1.0,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 50,
//                                 height: 50,
//                                 child: CircularProgressIndicator(
//                                   valueColor: const AlwaysStoppedAnimation<Color>(
//                                     Colors.white,
//                                   ),
//                                   strokeWidth: 3,
//                                   value: _particleController.value,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                           Text(
//                             'Loading Experience...',
//                             style: TextStyle(
//                               color: Colors.white.withOpacity(0.9),
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 1.5,
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
                  
//                   const SizedBox(height: 60),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
























// import 'package:farmhouse_app/utils/helper_function.dart';
// import 'package:farmhouse_app/views/auth/navbar_screen.dart';
// import 'package:farmhouse_app/views/onboarding/onboarding_screen.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// // Import your navbar screen here
// // import 'package:farmhouse_app/views/navbar_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _logoController;
//   late AnimationController _textController;
//   late AnimationController _particleController;
//   late AnimationController _shimmerController;
  
//   late Animation<double> _logoScaleAnimation;
//   late Animation<double> _logoFadeAnimation;
//   late Animation<double> _logoRotateAnimation;
//   late Animation<double> _textFadeAnimation;
//   late Animation<Offset> _textSlideAnimation;
//   late Animation<double> _shimmerAnimation;

//   @override
//   void initState() {
//     super.initState();
    
//     _logoController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );
    
//     _textController = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );
    
//     _particleController = AnimationController(
//       duration: const Duration(milliseconds: 3000),
//       vsync: this,
//     );
    
//     _shimmerController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );
    
//     _logoScaleAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _logoController,
//       curve: Curves.easeOutBack,
//     ));
    
//     _logoFadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _logoController,
//       curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
//     ));
    
//     _logoRotateAnimation = Tween<double>(
//       begin: -0.5,
//       end: 0.0,
//     ).animate(CurvedAnimation(
//       parent: _logoController,
//       curve: Curves.easeOutBack,
//     ));
    
//     _textFadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _textController,
//       curve: Curves.easeIn,
//     ));
    
//     _textSlideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _textController,
//       curve: Curves.easeOutCubic,
//     ));
    
//     _shimmerAnimation = Tween<double>(
//       begin: -2.0,
//       end: 2.0,
//     ).animate(CurvedAnimation(
//       parent: _shimmerController,
//       curve: Curves.easeInOut,
//     ));
    
//     _startAnimations();
//   }
  
//   void _startAnimations() async {
//     _particleController.repeat();
//     _shimmerController.repeat();
    
//     await Future.delayed(const Duration(milliseconds: 300));
//     await _logoController.forward();
//     await _textController.forward();
    
//     await Future.delayed(const Duration(milliseconds: 1500));
    
//     // Check if user is logged in
//     await _navigateToNextScreen();
//   }

//   Future<void> _navigateToNextScreen() async {
//     if (!mounted) return;

//     // Check if user is logged in
//     final user = await SharedPrefs.getUser();
//     final bool isLoggedIn = user != null;

//     if (!mounted) return;

//     if (isLoggedIn) {
//       // Navigate to Navbar Screen
//       Navigator.pushReplacement(
//         context,
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) => const NavbarScreen(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(opacity: animation, child: child);
//           },
//           transitionDuration: const Duration(milliseconds: 500),
//         ),
//       );
//     } else {
//       // Navigate to Onboarding Screen
//       Navigator.pushReplacement(
//         context,
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) => const OnboardingScreen(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(opacity: animation, child: child);
//           },
//           transitionDuration: const Duration(milliseconds: 500),
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _logoController.dispose();
//     _textController.dispose();
//     _particleController.dispose();
//     _shimmerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Animated Gradient Background
//           AnimatedBuilder(
//             animation: _particleController,
//             builder: (context, child) {
//               return Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Color.lerp(
//                         const Color(0xFF1E3A8A),
//                         const Color(0xFF3B82F6),
//                         (_particleController.value * 2) % 1,
//                       )!,
//                       const Color(0xFF3B82F6),
//                       Color.lerp(
//                         const Color(0xFF8B5CF6),
//                         const Color(0xFFA855F7),
//                         (_particleController.value * 2) % 1,
//                       )!,
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
          
//           // Floating Particles
//           ...List.generate(20, (index) {
//             return AnimatedBuilder(
//               animation: _particleController,
//               builder: (context, child) {
//                 final progress = (_particleController.value + index * 0.1) % 1.0;
//                 final size = 4.0 + (index % 3) * 2.0;
//                 return Positioned(
//                   left: (index * 50.0) % MediaQuery.of(context).size.width,
//                   top: MediaQuery.of(context).size.height * progress,
//                   child: Opacity(
//                     opacity: (1 - progress) * 0.3,
//                     child: Container(
//                       width: size,
//                       height: size,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.white.withOpacity(0.5),
//                             blurRadius: 10,
//                             spreadRadius: 2,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }),
          
//           // Main Content
//           SafeArea(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Spacer(flex: 3),
                  
//                   // Animated Logo with Glow Effect
//                   AnimatedBuilder(
//                     animation: _logoController,
//                     builder: (context, child) {
//                       return FadeTransition(
//                         opacity: _logoFadeAnimation,
//                         child: Transform.rotate(
//                           angle: _logoRotateAnimation.value * math.pi,
//                           child: ScaleTransition(
//                             scale: _logoScaleAnimation,
//                             child: Container(
//                               width: 160,
//                               height: 160,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: const LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: [
//                                     Colors.white,
//                                     Color(0xFFF0F9FF),
//                                   ],
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.blue.shade300.withOpacity(0.6),
//                                     blurRadius: 40,
//                                     spreadRadius: 10,
//                                   ),
//                                   BoxShadow(
//                                     color: Colors.purple.shade300.withOpacity(0.4),
//                                     blurRadius: 60,
//                                     spreadRadius: 15,
//                                   ),
//                                 ],
//                               ),
//                               child: Stack(
//                                 alignment: Alignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.rocket_launch_rounded,
//                                     size: 80,
//                                     color: Colors.blue.shade700,
//                                   ),
//                                   AnimatedBuilder(
//                                     animation: _shimmerController,
//                                     builder: (context, child) {
//                                       return Positioned.fill(
//                                         child: ClipOval(
//                                           child: OverflowBox(
//                                             maxWidth: double.infinity,
//                                             child: Transform.translate(
//                                               offset: Offset(_shimmerAnimation.value * 100, 0),
//                                               child: Container(
//                                                 width: 100,
//                                                 decoration: BoxDecoration(
//                                                   gradient: LinearGradient(
//                                                     colors: [
//                                                       Colors.transparent,
//                                                       Colors.white.withOpacity(0.3),
//                                                       Colors.transparent,
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
                  
//                   const SizedBox(height: 40),
                  
//                   // Animated App Name with Shimmer
//                   AnimatedBuilder(
//                     animation: _textController,
//                     builder: (context, child) {
//                       return FadeTransition(
//                         opacity: _textFadeAnimation,
//                         child: SlideTransition(
//                           position: _textSlideAnimation,
//                           child: Column(
//                             children: [
//                               ShaderMask(
//                                 shaderCallback: (bounds) {
//                                   return LinearGradient(
//                                     colors: const [
//                                       Colors.white,
//                                       Color(0xFFE0F2FE),
//                                       Colors.white,
//                                     ],
//                                   ).createShader(bounds);
//                                 },
//                                 child: const Text(
//                                   'Farm House App',
//                                   style: TextStyle(
//                                     fontSize: 36,
//                                     fontWeight: FontWeight.w800,
//                                     color: Colors.white,
//                                     letterSpacing: 2.0,
//                                     height: 1.2,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 20,
//                                   vertical: 8,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withOpacity(0.15),
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(
//                                     color: Colors.white.withOpacity(0.3),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: Text(
//                                   'Your Journey Starts Here',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.white.withOpacity(0.95),
//                                     letterSpacing: 1.2,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
                  
//                   const Spacer(flex: 3),
                  
//                   // Modern Loading Indicator
//                   AnimatedBuilder(
//                     animation: _particleController,
//                     builder: (context, child) {
//                       return Column(
//                         children: [
//                           Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               SizedBox(
//                                 width: 50,
//                                 height: 50,
//                                 child: CircularProgressIndicator(
//                                   valueColor: AlwaysStoppedAnimation<Color>(
//                                     Colors.white.withOpacity(0.3),
//                                   ),
//                                   strokeWidth: 3,
//                                   value: 1.0,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 50,
//                                 height: 50,
//                                 child: CircularProgressIndicator(
//                                   valueColor: const AlwaysStoppedAnimation<Color>(
//                                     Colors.white,
//                                   ),
//                                   strokeWidth: 3,
//                                   value: _particleController.value,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                           Text(
//                             'Loading Experience...',
//                             style: TextStyle(
//                               color: Colors.white.withOpacity(0.9),
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 1.5,
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
                  
//                   const SizedBox(height: 60),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
















import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:farmhouse_app/views/auth/navbar_screen.dart';
import 'package:farmhouse_app/views/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _particleController;
  late AnimationController _shimmerController;
  
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoRotateAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutBack,
    ));
    
    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
    
    _logoRotateAnimation = Tween<double>(
      begin: -0.5,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutBack,
    ));
    
    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    ));
    
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));
    
    _shimmerAnimation = Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));
    
    _startAnimations();
  }
  
  void _startAnimations() async {
    _particleController.repeat();
    _shimmerController.repeat();
    
    await Future.delayed(const Duration(milliseconds: 300));
    await _logoController.forward();
    await _textController.forward();
    
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Check if user is logged in
    await _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    if (!mounted) return;

    // Check if user is logged in
    final user = await SharedPrefs.getUser();
    final bool isLoggedIn = user != null;

    if (!mounted) return;

    if (isLoggedIn) {
      // Navigate to Navbar Screen
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const NavbarScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    } else {
      // Navigate to Onboarding Screen
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  Future<void> _launchURL() async {
    final Uri url = Uri.parse('https://www.pixelmindsolutions.com/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch website')),
        );
      }
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _particleController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Gradient Background
          AnimatedBuilder(
            animation: _particleController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.lerp(
                        const Color(0xFF1E3A8A),
                        const Color(0xFF3B82F6),
                        (_particleController.value * 2) % 1,
                      )!,
                      const Color(0xFF3B82F6),
                      Color.lerp(
                        const Color(0xFF8B5CF6),
                        const Color(0xFFA855F7),
                        (_particleController.value * 2) % 1,
                      )!,
                    ],
                  ),
                ),
              );
            },
          ),
          
          // Floating Particles
          ...List.generate(20, (index) {
            return AnimatedBuilder(
              animation: _particleController,
              builder: (context, child) {
                final progress = (_particleController.value + index * 0.1) % 1.0;
                final size = 4.0 + (index % 3) * 2.0;
                return Positioned(
                  left: (index * 50.0) % MediaQuery.of(context).size.width,
                  top: MediaQuery.of(context).size.height * progress,
                  child: Opacity(
                    opacity: (1 - progress) * 0.3,
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
          
          // Main Content
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),
                  
                  // Animated Logo with Glow Effect
                  AnimatedBuilder(
                    animation: _logoController,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _logoFadeAnimation,
                        child: Transform.rotate(
                          angle: _logoRotateAnimation.value * math.pi,
                          child: ScaleTransition(
                            scale: _logoScaleAnimation,
                            child: Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white,
                                    Color(0xFFF0F9FF),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.shade300.withOpacity(0.6),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                  BoxShadow(
                                    color: Colors.purple.shade300.withOpacity(0.4),
                                    blurRadius: 60,
                                    spreadRadius: 15,
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.rocket_launch_rounded,
                                    size: 80,
                                    color: Colors.blue.shade700,
                                  ),
                                  AnimatedBuilder(
                                    animation: _shimmerController,
                                    builder: (context, child) {
                                      return Positioned.fill(
                                        child: ClipOval(
                                          child: OverflowBox(
                                            maxWidth: double.infinity,
                                            child: Transform.translate(
                                              offset: Offset(_shimmerAnimation.value * 100, 0),
                                              child: Container(
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.white.withOpacity(0.3),
                                                      Colors.transparent,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Animated App Name with Shimmer
                  AnimatedBuilder(
                    animation: _textController,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _textFadeAnimation,
                        child: SlideTransition(
                          position: _textSlideAnimation,
                          child: Column(
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) {
                                  return LinearGradient(
                                    colors: const [
                                      Colors.white,
                                      Color(0xFFE0F2FE),
                                      Colors.white,
                                    ],
                                  ).createShader(bounds);
                                },
                                child: const Text(
                                  'Farm House App',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: 2.0,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  'Your Journey Starts Here',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.95),
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const Spacer(flex: 3),
                  
                  // Modern Loading Indicator
                  AnimatedBuilder(
                    animation: _particleController,
                    builder: (context, child) {
                      return Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white.withOpacity(0.3),
                                  ),
                                  strokeWidth: 3,
                                  value: 1.0,
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                  strokeWidth: 3,
                                  value: _particleController.value,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Loading Experience...',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // PixelMind Solutions Link
                  GestureDetector(
                    onTap: _launchURL,
                    child: AnimatedBuilder(
                      animation: _textController,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _textFadeAnimation,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'by ',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'PixelMind Solutions',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.open_in_new,
                                  size: 14,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}