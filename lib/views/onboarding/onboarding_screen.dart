import 'package:farmhouse_app/views/auth/login_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      image: 'assets/onboardingimage3.jpg',
      title: 'Welcome to\nFarmHouseHub',
      description:
          'Monthly hangout destinations for Indians. It is nearby & affordable.',
      isLast: true,
    ),
    OnboardingPage(
      image: 'assets/onboardimage.jpg',
      title: 'Nearby Spots',
      description:
          'FarmHouseHub provides perfect staycation within just 100kms. No long stressful travels!',
    ),
    OnboardingPage(
      image: 'assets/onboardingimage2.jpg',
      title: 'Multiple Use Cases',
      description:
          'FarmHouseHub can be booked for family get togethers, friends hangout, corporate outings & many more.',
    ),
    OnboardingPage(
      image: 'assets/onboardingimage3.jpg',
      title: 'Flexible Slots',
      description:
          'FarmHouseHub offers stays as short as 12 hours. No need to pay full day rent!',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to home or login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  void _onSkipPressed() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _onSkipPressed,
                  child: const Text(
                    'SKIP',
                    style: TextStyle(
                      color: Color(0xFFFF5A5F),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),

            // Page Indicator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => _buildIndicator(index == _currentPage),
                ),
              ),
            ),

            // Next Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onNextPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5A5F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image placeholder
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              // child: page.isLast
              //     ? _buildLogo()
              //     : Icon(
              //         Icons.image_outlined,
              //         size: 80,
              //         color: Colors.grey[400],
              //       ),
              child: page.isLast
                  ? _buildLogo()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        page.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 60),

          // Title
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E1E),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20),

          // Description
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo placeholder
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home_outlined,
                      size: 40,
                      color: Colors.teal[800],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_florist,
                          size: 24,
                          color: Colors.yellow[700],
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.local_florist,
                          size: 24,
                          color: Colors.yellow[700],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Positioned(
                top: 8,
                right: 8,
                child: Text('®', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
            children: [
              TextSpan(
                text: 'Farm',
                style: TextStyle(color: Colors.teal[800]),
              ),
              TextSpan(
                text: 'House',
                style: TextStyle(color: Colors.green[600]),
              ),
              TextSpan(
                text: 'Hub',
                style: TextStyle(color: Colors.amber[700]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFF5A5F) : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingPage {
  final String image;
  final String title;
  final String description;
  final bool isLast;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    this.isLast = false,
  });
}
