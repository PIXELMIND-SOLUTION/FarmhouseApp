// import 'package:farmhouse_app/utils/helper_function.dart';
// import 'package:farmhouse_app/views/auth/navbar_screen.dart';
// import 'package:farmhouse_app/views/onboarding/onboarding_screen.dart';
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {

//   @override
//   void initState() {
//     super.initState();
//     _navigateToNextScreen();
//   }

//   Future<void> _navigateToNextScreen() async {
//     await Future.delayed(const Duration(seconds: 3));

//     final user = await SharedPrefs.getUser();
//     final bool isLoggedIn = user != null;

//     if (!mounted) return;

//     if (isLoggedIn) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const NavbarScreen()),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const OnboardingScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [

//           /// ✅ Fullscreen Image
//           SizedBox.expand(
//             child: Image.asset(
//               "assets/splash.png", // <-- your splash image path
//               fit: BoxFit.cover,
//             ),
//           ),

//           /// ✅ Bottom Powered By Text
//           Positioned(
//             bottom: 40,
//             left: 0,
//             right: 0,
//             child: Column(
//               children: const [
//                 Text(
//                   "Powered By",
//                   style: TextStyle(
//                     color: Colors.black54,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   "Pixelmindsolutions Pvt Ltd",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

























import 'package:farmhouse_app/provider/Location/location_provider.dart';
import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:farmhouse_app/views/auth/navbar_screen.dart';
import 'package:farmhouse_app/views/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _dotsController;
  String _locationStatus = 'Detecting your location...';
  bool _isLoading = true;
  bool _locationError = false;
  String? _detectedLocation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _navigateToNextScreen();
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  Future<void> _navigateToNextScreen() async {
    // Show splash for at least 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    final user = await SharedPrefs.getUser();
    final bool isLoggedIn = user != null;

    if (!mounted) return;

    if (isLoggedIn) {
      // User is logged in, fetch location before navigating
      await _fetchLocationAndNavigate(user!);
    } else {
      // User not logged in, go to onboarding
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    }
  }

  Future<void> _fetchLocationAndNavigate(dynamic user) async {
    if (!mounted) return;

    setState(() {
      _locationStatus = 'Detecting your location...';
      _isLoading = true;
      _locationError = false;
    });

    try {
      // Create LocationProvider instance
      final locationProvider = LocationProvider();
      
      // Listen to location changes
      locationProvider.addListener(() {
        if (mounted) {
          setState(() {
            if (locationProvider.address != null && locationProvider.address!.isNotEmpty) {
              _detectedLocation = locationProvider.address!.split(',').first;
              _locationStatus = 'Location detected: $_detectedLocation';
            }
          });
        }
      });

      // Fetch location
      await locationProvider.getCurrentLocation();
      
      // Check if location was successfully fetched
      if (locationProvider.address != null && locationProvider.address!.isNotEmpty) {
        setState(() {
          _detectedLocation = locationProvider.address!.split(',').first;
          _locationStatus = 'Location found!';
        });

        // Show success for a moment before navigating
        await Future.delayed(const Duration(milliseconds: 800));

        if (mounted) {
          // Navigate to home with the location provider
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                value: locationProvider,
                child: const NavbarScreen(),
              ),
            ),
          );
        }
      } else {
        // Location fetch failed or returned empty
        throw Exception('Location fetch returned empty');
      }
    } catch (e) {
      print('❌ Error in splash screen location fetch: $e');
      
      setState(() {
        _locationStatus = 'Unable to detect location';
        _locationError = true;
        _isLoading = false;
      });

      // Show error for 2 seconds then navigate anyway
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        // Navigate to home even if location failed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => LocationProvider(),
              child: const NavbarScreen(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fullscreen Background Image
          SizedBox.expand(
            child: Image.asset(
              "assets/splash.png",
              fit: BoxFit.cover,
            ),
          ),

          // Gradient overlay for better text visibility
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
                stops: const [0.6, 1.0],
              ),
            ),
          ),

          // Location Loading Animation (when user is logged in)
          if (_isLoading)
            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated location icon with pulse effect
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1.0 + (_pulseController.value * 0.2),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.15),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6366F1).withOpacity(0.3 * _pulseController.value),
                                blurRadius: 20 * _pulseController.value,
                                spreadRadius: 5 * _pulseController.value,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.my_location,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // Animated dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return AnimatedBuilder(
                        animation: _dotsController,
                        builder: (context, child) {
                          final delay = index * 0.3;
                          final animValue = (_dotsController.value + delay) % 1.0;
                          
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(
                                0.3 + (0.7 * (1 - animValue)),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  
                  // Location status text with animation
                  TweenAnimationBuilder(
                    tween: ColorTween(
                      begin: Colors.white70,
                      end: Colors.white,
                    ),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, color, child) {
                      return Text(
                        _locationStatus,
                        style: TextStyle(
                          color: color,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Subtext - changes based on status
                  Text(
                    _detectedLocation != null 
                        ? 'Preparing your experience...' 
                        : 'Finding nearby farmhouses...',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

          // Success State (briefly shown before navigation)
          if (_detectedLocation != null && !_isLoading)
            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.5, end: 1.0),
                duration: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Location Found!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Welcome back!',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: child,
                  );
                },
              ),
            ),

          // Error State
          if (_locationError)
            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.location_off,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Location detection failed',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Continuing with default location',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

          // Bottom Powered By Text
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: const [
                Text(
                  "Powered By",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Pixelmindsolutions Pvt Ltd",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}