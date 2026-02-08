// import 'package:farmhouse_app/provider/auth/login_provider.dart';
// import 'package:farmhouse_app/provider/firebase/google_provider.dart';
// import 'package:farmhouse_app/views/auth/forgot_password_screen.dart';
// import 'package:farmhouse_app/views/auth/navbar_screen.dart';
// import 'package:farmhouse_app/views/auth/register_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _isPasswordVisible = false;
//   bool _rememberMe = false;

//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleLogin() async {
//     final phoneNumber = _phoneController.text.trim();
//     final password = _passwordController.text.trim();

//     // Validation
//     if (phoneNumber.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please enter phone number and password'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     if (!_rememberMe) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please enable "Remember me" to continue'),
//           backgroundColor: Colors.orange,
//         ),
//       );
//       return;
//     }

//     // Get provider
//     final loginProvider = Provider.of<LoginProvider>(context, listen: false);

//     // Attempt login
//     final success = await loginProvider.login(phoneNumber, password);

//     if (!mounted) return;

//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Login successful'),
//           backgroundColor: Colors.green,
//         ),
//       );

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => NavbarScreen()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Login failed. Please check your credentials.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   // ✅ Google Sign-In Handler
//   Future<void> _handleGoogleSignIn() async {
//     final googleAuthProvider = Provider.of<GoogleAuthenticationProvider>(
//       context,
//       listen: false,
//     );

//     final success = await googleAuthProvider.signInWithGoogle();

//     if (!mounted) return;

//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Google sign-in successful!'),
//           backgroundColor: Colors.green,
//         ),
//       );

//       // Navigate to home screen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => NavbarScreen()),
//       );
//     } else {
//       // Show error if any
//       final errorMessage = googleAuthProvider.errorMessage ??
//           'Google sign-in failed';
      
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(errorMessage),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2B2D42),
//       body: SafeArea(
//         child: Consumer<LoginProvider>(
//           builder: (context, loginProvider, child) {
//             return Stack(
//               children: [
//                 SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 40),

//                         // ✅ Farmhouse Logo
//                         Center(
//                           child: Image.asset(
//                             'assets/farmhouselogo.png',
//                             height: 300,
//                             width: 300,
//                             fit: BoxFit.contain,
//                           ),
//                         ),

//                         const SizedBox(height: 30),

//                         const Text(
//                           'Log In',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 32,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),

//                         const SizedBox(height: 40),

//                         _buildTextField(
//                           hint: 'Phone Number',
//                           icon: Icons.phone,
//                           controller: _phoneController,
//                           isPhone: true,
//                         ),
//                         const SizedBox(height: 20),

//                         _buildTextField(
//                           hint: 'Password',
//                           icon: Icons.lock,
//                           isPassword: true,
//                           isVisible: _isPasswordVisible,
//                           controller: _passwordController,
//                           onToggleVisibility: () {
//                             setState(() {
//                               _isPasswordVisible = !_isPasswordVisible;
//                             });
//                           },
//                         ),

//                         const SizedBox(height: 16),

//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   width: 20,
//                                   height: 20,
//                                   child: Checkbox(
//                                     value: _rememberMe,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         _rememberMe = value ?? true;
//                                       });
//                                     },
//                                     fillColor:
//                                         MaterialStateProperty.resolveWith((
//                                           states,
//                                         ) {
//                                           if (states.contains(
//                                             MaterialState.selected,
//                                           )) {
//                                             return const Color(0xFFFF5A5F);
//                                           }
//                                           return Colors.transparent;
//                                         }),
//                                     side: const BorderSide(
//                                       color: Colors.white54,
//                                       width: 2,
//                                     ),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(4),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 const Text(
//                                   'Remember me',
//                                   style: TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         ForgotPasswordScreen(),
//                                   ),
//                                 );
//                               },
//                               child: const Text(
//                                 'Forgot Password',
//                                 style: TextStyle(
//                                   color: Color(0xFFFF5A5F),
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 32),

//                         SizedBox(
//                           width: double.infinity,
//                           height: 56,
//                           child: ElevatedButton(
//                             onPressed: loginProvider.isLoading
//                                 ? null
//                                 : _handleLogin,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFFFF5A5F),
//                               disabledBackgroundColor: const Color(
//                                 0xFFFF5A5F,
//                               ).withOpacity(0.6),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(28),
//                               ),
//                               elevation: 0,
//                             ),
//                             child: loginProvider.isLoading
//                                 ? const SizedBox(
//                                     height: 24,
//                                     width: 24,
//                                     child: CircularProgressIndicator(
//                                       color: Colors.white,
//                                       strokeWidth: 2.5,
//                                     ),
//                                   )
//                                 : const Text(
//                                     'Log In',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                           ),
//                         ),

//                         const SizedBox(height: 40),

//                         Center(
//                           child: TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => RegisterScreen(),
//                                 ),
//                               );
//                             },
//                             child: RichText(
//                               text: const TextSpan(
//                                 style: TextStyle(
//                                   color: Colors.white60,
//                                   fontSize: 14,
//                                 ),
//                                 children: [
//                                   TextSpan(text: "Don't have an account?  "),
//                                   TextSpan(
//                                     text: 'Sign up',
//                                     style: TextStyle(
//                                       color: Color(0xFFFF5A5F),
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 30),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Loading overlay
//                 if (loginProvider.isLoading)
//                   Container(
//                     color: Colors.black26,
//                     child: const Center(
//                       child: CircularProgressIndicator(
//                         color: Color(0xFFFF5A5F),
//                       ),
//                     ),
//                   ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required String hint,
//     required IconData icon,
//     required TextEditingController controller,
//     bool isPassword = false,
//     bool isVisible = false,
//     VoidCallback? onToggleVisibility,
//     bool isPhone = false,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xFFFF5A5F), width: 1.5),
//         borderRadius: BorderRadius.circular(28),
//       ),
//       child: TextField(
//         controller: controller,
//         obscureText: isPassword && !isVisible,
//         style: const TextStyle(color: Colors.white),
//         keyboardType: isPhone ? TextInputType.number : TextInputType.text,
//         inputFormatters: isPhone
//             ? <TextInputFormatter>[
//                 FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                 LengthLimitingTextInputFormatter(10),
//               ]
//             : null,
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
//           prefixIcon: Icon(icon, color: Colors.white54, size: 20),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 16,
//           ),
//           suffixIcon: isPassword
//               ? IconButton(
//                   icon: Text(
//                     isVisible ? 'Hide' : 'Show',
//                     style: const TextStyle(color: Colors.white54, fontSize: 12),
//                   ),
//                   onPressed: onToggleVisibility,
//                 )
//               : null,
//         ),
//       ),
//     );
//   }

//   Widget _socialButton({
//     required String imageUrl,
//     required VoidCallback onTap,
//     bool isLoading = false,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         height: 55,
//         width: 55,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         padding: const EdgeInsets.all(12),
//         child: isLoading
//             ? const CircularProgressIndicator(
//                 strokeWidth: 2.5,
//                 color: Color(0xFFFF5A5F),
//               )
//             : Image.network(
//                 imageUrl,
//                 fit: BoxFit.contain,
//                 errorBuilder: (context, error, stackTrace) {
//                   return const Icon(Icons.error, color: Colors.red);
//                 },
//               ),
//       ),
//     );
//   }
// }















// import 'package:farmhouse_app/provider/auth/login_provider.dart';
// import 'package:farmhouse_app/provider/firebase/google_provider.dart';
// import 'package:farmhouse_app/utils/validators.dart';
// import 'package:farmhouse_app/views/auth/forgot_password_screen.dart';
// import 'package:farmhouse_app/views/auth/navbar_screen.dart';
// import 'package:farmhouse_app/views/auth/register_screen.dart';
// import 'package:farmhouse_app/widgets/error_tooltip.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _isPasswordVisible = false;
//   bool _rememberMe = false;

//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   String? _phoneError;
//   String? _passwordError;

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   /// LOGIN HANDLER
//   Future<void> _handleLogin() async {
//     setState(() {
//       _phoneError = Validators.validatePhone(_phoneController.text);
//       _passwordError = Validators.validatePassword(_passwordController.text);
//     });

//     // Stop if validation fails
//     if (_phoneError != null || _passwordError != null) return;

//     if (!_rememberMe) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please enable "Remember me"'),
//           backgroundColor: Colors.orange,
//         ),
//       );
//       return;
//     }

//     final loginProvider = Provider.of<LoginProvider>(context, listen: false);

//     final success = await loginProvider.login(
//       _phoneController.text.trim(),
//       _passwordController.text.trim(),
//     );

//     if (!mounted) return;

//     if (success) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => NavbarScreen()),
//       );
//     } else {
//       // Backend error → Toast only
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Invalid credentials"),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   /// GOOGLE LOGIN
//   Future<void> _handleGoogleSignIn() async {
//     final googleAuthProvider =
//         Provider.of<GoogleAuthenticationProvider>(context, listen: false);

//     final success = await googleAuthProvider.signInWithGoogle();

//     if (!mounted) return;

//     if (success) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => NavbarScreen()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content:
//               Text(googleAuthProvider.errorMessage ?? "Google login failed"),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2B2D42),
//       body: SafeArea(
//         child: Consumer<LoginProvider>(
//           builder: (context, loginProvider, child) {
//             return Stack(
//               children: [
//                 SingleChildScrollView(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 40),

//                       Center(
//                         child: Image.asset(
//                           'assets/farmhouselogo.png',
//                           height: 300,
//                         ),
//                       ),

//                       const SizedBox(height: 30),

//                       const Text(
//                         'Log In',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 40),

//                       _buildTextField(
//                         hint: 'Phone Number',
//                         icon: Icons.phone,
//                         controller: _phoneController,
//                         isPhone: true,
//                         errorText: _phoneError,
//                       ),

//                       const SizedBox(height: 20),

//                       _buildTextField(
//                         hint: 'Password',
//                         icon: Icons.lock,
//                         controller: _passwordController,
//                         isPassword: true,
//                         isVisible: _isPasswordVisible,
//                         errorText: _passwordError,
//                         onToggleVisibility: () {
//                           setState(() {
//                             _isPasswordVisible = !_isPasswordVisible;
//                           });
//                         },
//                       ),

//                       const SizedBox(height: 16),

//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Checkbox(
//                                 value: _rememberMe,
//                                 onChanged: (v) =>
//                                     setState(() => _rememberMe = v ?? false),
//                               ),
//                               const Text("Remember me",
//                                   style: TextStyle(color: Colors.white70)),
//                             ],
//                           ),
//                           GestureDetector(
//                             onTap: () => Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (_) =>
//                                       const ForgotPasswordScreen()),
//                             ),
//                             child: const Text(
//                               "Forgot Password",
//                               style: TextStyle(
//                                   color: Color(0xFFFF5A5F)),
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 32),

//                       SizedBox(
//                         width: double.infinity,
//                         height: 56,
//                         child: ElevatedButton(
//                           onPressed: loginProvider.isLoading
//                               ? null
//                               : _handleLogin,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFFFF5A5F),
//                           ),
//                           child: loginProvider.isLoading
//                               ? const CircularProgressIndicator(
//                                   color: Colors.white)
//                               : const Text("Log In"),
//                         ),
//                       ),

//                       const SizedBox(height: 30),

//                       Center(
//                         child: TextButton(
//                           onPressed: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => const RegisterScreen()),
//                           ),
//                           child: const Text(
//                             "Don't have an account? Sign up",
//                             style: TextStyle(color: Colors.white60),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 if (loginProvider.isLoading)
//                   Container(
//                     color: Colors.black26,
//                     child: const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   /// TEXT FIELD WIDGET
// Widget _buildTextField({
//   required String hint,
//   required IconData icon,
//   required TextEditingController controller,
//   String? errorText,
//   bool isPassword = false,
//   bool isVisible = false,
//   VoidCallback? onToggleVisibility,
//   bool isPhone = false,
// }) {
//   final hasError = errorText != null;

//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       /// TextField
//       Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: hasError ? Colors.red : const Color(0xFFFF5A5F),
//             width: 1.5,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: TextField(
//           controller: controller,
//           obscureText: isPassword && !isVisible,
//           style: const TextStyle(color: Colors.white),
//           keyboardType:
//               isPhone ? TextInputType.number : TextInputType.text,
//           inputFormatters: isPhone
//               ? [
//                   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                   LengthLimitingTextInputFormatter(10),
//                 ]
//               : null,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle:
//                 const TextStyle(color: Colors.white38),
//             prefixIcon:
//                 Icon(icon, color: Colors.white54),
//             border: InputBorder.none,

//             /// Red error icon
//             suffixIcon: hasError
//                 ? const Icon(Icons.error,
//                     color: Colors.red)
//                 : isPassword
//                     ? IconButton(
//                         icon: Text(
//                           isVisible ? "Hide" : "Show",
//                           style: const TextStyle(
//                               color: Colors.white54),
//                         ),
//                         onPressed: onToggleVisibility,
//                       )
//                     : null,
//           ),
//         ),
//       ),

//       /// Error Bubble
//       if (hasError) ...[
//         const SizedBox(height: 6),
//         ErrorTooltip(message: errorText),
//       ]
//     ],
//   );
// }

// }














import 'package:farmhouse_app/provider/auth/login_provider.dart';
import 'package:farmhouse_app/provider/firebase/google_provider.dart';
import 'package:farmhouse_app/utils/validators.dart';
import 'package:farmhouse_app/views/auth/forgot_password_screen.dart';
import 'package:farmhouse_app/views/auth/navbar_screen.dart';
import 'package:farmhouse_app/views/auth/register_screen.dart';
import 'package:farmhouse_app/widgets/error_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  bool _rememberMe = true;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _phoneError;
  String? _passwordError;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// LOGIN HANDLER
/// LOGIN HANDLER
Future<void> _handleLogin() async {
  setState(() {
    _phoneError = Validators.validatePhone(_phoneController.text);
    _passwordError = Validators.validatePassword(_passwordController.text);
  });

  if (_phoneError != null || _passwordError != null) return;

  if (!_rememberMe) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enable "Remember me"'),
        backgroundColor: Colors.orange,
      ),
    );
    return;
  }

  final loginProvider = Provider.of<LoginProvider>(context, listen: false);
  final success = await loginProvider.login(
    _phoneController.text.trim(),
    _passwordController.text.trim(),
  );

  if (!mounted) return;

  if (success) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const NavbarScreen()),
    );
  } else {
    // Show backend error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          loginProvider.errorMessage ?? "Invalid credentials",
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

  /// GOOGLE LOGIN
  // Future<void> _handleGoogleSignIn() async {
  //   final googleAuthProvider =
  //       Provider.of<GoogleAuthProvider>(context, listen: false);
  //   final success = await googleAuthProvider.signInWithGoogle();

  //   if (!mounted) return;

  //   if (success) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => NavbarScreen()),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //             googleAuthProvider.errorMessage ?? "Google login failed"),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF2B2D42),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Consumer<LoginProvider>(
          builder: (context, loginProvider, child) {
            return Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Adaptive spacing
                              SizedBox(height: keyboardVisible ? 16 : 24),

                              // Logo - reduced size when keyboard open
                              Center(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  height: keyboardVisible
                                      ? (screenHeight < 700 ? 80 : 120)
                                      : (screenHeight < 700 ? 150 : 200),
                                  child: Image.asset(
                                    'assets/farmhouselogo.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),

                              SizedBox(height: keyboardVisible ? 16 : 24),

                              // Title
                              const Text(
                                'Log In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: keyboardVisible ? 16 : 24),

                              // Phone field
                              _buildTextField(
                                hint: 'Phone Number',
                                icon: Icons.phone,
                                controller: _phoneController,
                                isPhone: true,
                                errorText: _phoneError,
                              ),

                              const SizedBox(height: 16),

                              // Password field
                              _buildTextField(
                                hint: 'Password',
                                icon: Icons.lock,
                                controller: _passwordController,
                                isPassword: true,
                                isVisible: _isPasswordVisible,
                                errorText: _passwordError,
                                onToggleVisibility: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),

                              const SizedBox(height: 12),

                              // Remember me & Forgot password
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // SizedBox(
                                        //   height: 24,
                                        //   width: 24,
                                        //   child: Checkbox(
                                        //     value: _rememberMe,
                                        //     onChanged: (v) => setState(
                                        //         () => _rememberMe = v ?? false),
                                        //     materialTapTargetSize:
                                        //         MaterialTapTargetSize
                                        //             .shrinkWrap,
                                        //   ),
                                        // ),
                                        // const SizedBox(width: 4),
                                        // const Flexible(
                                        //   child: Text(
                                        //     "Remember me",
                                        //     style: TextStyle(
                                        //       color: Colors.white70,
                                        //       fontSize: 13,
                                        //     ),
                                        //     overflow: TextOverflow.ellipsis,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const ForgotPasswordScreen(),
                                      ),
                                    ),
                                    child: const Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        color: Color(0xFFFF5A5F),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: keyboardVisible ? 16 : 24),

                              // Login button
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: loginProvider.isLoading
                                      ? null
                                      : _handleLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFF5A5F),
                                    disabledBackgroundColor:
                                        const Color(0xFFFF5A5F)
                                            .withOpacity(0.6),
                                  ),
                                  child: loginProvider.isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          "Log In",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),

                              SizedBox(height: keyboardVisible ? 16 : 20),

                              // Sign up link
                              if (!keyboardVisible)
                                Center(
                                  child: TextButton(
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const RegisterScreen(),
                                      ),
                                    ),
                                    child: const Text(
                                      "Don't have an account? Sign up",
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),

                              SizedBox(height: keyboardVisible ? 16 : 24),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (loginProvider.isLoading)
                  Container(
                    color: Colors.black26,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// TEXT FIELD WIDGET
  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    String? errorText,
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? onToggleVisibility,
    bool isPhone = false,
  }) {
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: hasError ? Colors.red : const Color(0xFFFF5A5F),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword && !isVisible,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            keyboardType: isPhone ? TextInputType.number : TextInputType.text,
            inputFormatters: isPhone
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(10),
                  ]
                : null,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
              prefixIcon: Icon(icon, color: Colors.white54, size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              isDense: true,
              suffixIcon: hasError
                  ? const Icon(Icons.error, color: Colors.red, size: 20)
                  : isPassword
                      ? IconButton(
                          icon: Text(
                            isVisible ? "Hide" : "Show",
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                          onPressed: onToggleVisibility,
                        )
                      : null,
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 6),
          ErrorTooltip(message: errorText),
        ]
      ],
    );
  }
}