// // import 'package:farmhouse_app/views/auth/forgot_password_screen.dart';
// // import 'package:farmhouse_app/views/auth/navbar_screen.dart';
// // import 'package:farmhouse_app/views/auth/otp_screen.dart';
// // import 'package:farmhouse_app/views/auth/register_screen.dart';
// // import 'package:flutter/material.dart';

// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({super.key});

// //   @override
// //   State<LoginScreen> createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen> {
// //   bool _isPasswordVisible = false;
// //   bool _rememberMe = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFF2B2D42),
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           physics: const BouncingScrollPhysics(),
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 24.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const SizedBox(height: 50),

// //                 const Text(
// //                   'Log In',
// //                   style: TextStyle(
// //                     color: Colors.white,
// //                     fontSize: 32,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),

// //                 const SizedBox(height: 40),

// //                 _buildTextField(hint: 'Phone Number', icon: Icons.phone),
// //                 const SizedBox(height: 20),

// //                 _buildTextField(
// //                   hint: 'Password',
// //                   icon: Icons.lock,
// //                   isPassword: true,
// //                   isVisible: _isPasswordVisible,
// //                   onToggleVisibility: () {
// //                     setState(() {
// //                       _isPasswordVisible = !_isPasswordVisible;
// //                     });
// //                   },
// //                 ),

// //                 const SizedBox(height: 16),

// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Row(
// //                       children: [
// //                         SizedBox(
// //                           width: 20,
// //                           height: 20,
// //                           child: Checkbox(
// //                             value: _rememberMe,
// //                             onChanged: (value) {
// //                               setState(() {
// //                                 _rememberMe = value ?? false;
// //                               });
// //                             },
// //                             fillColor: MaterialStateProperty.resolveWith((
// //                               states,
// //                             ) {
// //                               if (states.contains(MaterialState.selected)) {
// //                                 return const Color(0xFFFF5A5F);
// //                               }
// //                               return Colors.transparent;
// //                             }),
// //                             side: const BorderSide(
// //                               color: Colors.white54,
// //                               width: 2,
// //                             ),
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(4),
// //                             ),
// //                           ),
// //                         ),
// //                         const SizedBox(width: 8),
// //                         const Text(
// //                           'Remember me',
// //                           style: TextStyle(color: Colors.white70, fontSize: 14),
// //                         ),
// //                       ],
// //                     ),
// //                     GestureDetector(
// //                       onTap: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) => ForgotPasswordScreen(),
// //                           ),
// //                         );
// //                       },
// //                       child: const Text(
// //                         'Forgot Password',
// //                         style: TextStyle(
// //                           color: Color(0xFFFF5A5F),
// //                           fontSize: 14,
// //                           fontWeight: FontWeight.w500,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),

// //                 const SizedBox(height: 32),

// //                 SizedBox(
// //                   width: double.infinity,
// //                   height: 56,
// //                   child: ElevatedButton(
// //                     onPressed: () {

// //                       Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) => OtpScreen(),
// //                           ),
// //                         );
// //                       // Navigator.push(
// //                       //   context,
// //                       //   MaterialPageRoute(builder: (context) => NavbarScreen()),
// //                       // );
// //                     },
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: const Color(0xFFFF5A5F),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(28),
// //                       ),
// //                       elevation: 0,
// //                     ),
// //                     child: const Text(
// //                       'Log In',
// //                       style: TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 40),

// //                 Center(
// //                   child: TextButton(
// //                     onPressed: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (_) => RegisterScreen()),
// //                       );
// //                     },
// //                     child: RichText(
// //                       text: const TextSpan(
// //                         style: TextStyle(color: Colors.white60, fontSize: 14),
// //                         children: [
// //                           TextSpan(text: "Don't have an account?  "),
// //                           TextSpan(
// //                             text: 'Sign up',
// //                             style: TextStyle(
// //                               color: Color(0xFFFF5A5F),
// //                               fontWeight: FontWeight.w600,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 30),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildTextField({
// //     required String hint,
// //     required IconData icon,
// //     bool isPassword = false,
// //     bool isVisible = false,
// //     VoidCallback? onToggleVisibility,
// //   }) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         border: Border.all(color: const Color(0xFFFF5A5F), width: 1.5),
// //         borderRadius: BorderRadius.circular(28),
// //       ),
// //       child: TextField(
// //         obscureText: isPassword && !isVisible,
// //         style: const TextStyle(color: Colors.white),
// //         decoration: InputDecoration(
// //           hintText: hint,
// //           hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
// //           prefixIcon: Icon(icon, color: Colors.white54, size: 20),
// //           border: InputBorder.none,
// //           contentPadding: const EdgeInsets.symmetric(
// //             horizontal: 20,
// //             vertical: 16,
// //           ),
// //           suffixIcon: isPassword
// //               ? IconButton(
// //                   icon: Text(
// //                     'Show',
// //                     style: TextStyle(
// //                       color: Colors.white.withOpacity(0.5),
// //                       fontSize: 12,
// //                     ),
// //                   ),
// //                   onPressed: onToggleVisibility,
// //                 )
// //               : null,
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:farmhouse_app/provider/auth/login_provider.dart';
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
//           content: Text('Login successfull'),
//           backgroundColor: Colors.red,
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
//                         const SizedBox(height: 50),

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

//                         SizedBox(height: 70),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             _socialButton(
//                               imageUrl:
//                                   "https://yt3.googleusercontent.com/wjb1KjcaSgzXnqLUMTafDqgppr_LS7-A8sGf9DP1JJThg_Npp4EsiByYk9IPCkofvvD_3hy6dg=s900-c-k-c0x00ffffff-no-rj",
//                               onTap: () {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text("Google Login Clicked"),
//                                   ),
//                                 );
//                               },
//                             ),
//                             // const SizedBox(width: 18),
//                             // _socialButton(
//                             //   imageUrl:
//                             //       "https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png",
//                             //   onTap: () {
//                             //     ScaffoldMessenger.of(context).showSnackBar(
//                             //       const SnackBar(
//                             //         content: Text("Facebook Login Clicked"),
//                             //       ),
//                             //     );
//                             //   },
//                             // ),
//                           ],
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

//   // Widget _buildTextField({
//   //   required String hint,
//   //   required IconData icon,
//   //   required TextEditingController controller,
//   //   bool isPassword = false,
//   //   bool isVisible = false,
//   //   VoidCallback? onToggleVisibility,
//   // }) {
//   //   return Container(
//   //     decoration: BoxDecoration(
//   //       border: Border.all(color: const Color(0xFFFF5A5F), width: 1.5),
//   //       borderRadius: BorderRadius.circular(28),
//   //     ),
//   //     child: TextField(
//   //       controller: controller,
//   //       obscureText: isPassword && !isVisible,
//   //       style: const TextStyle(color: Colors.white),
//   //       keyboardType: isPassword ? TextInputType.text : TextInputType.phone,
//   //       decoration: InputDecoration(
//   //         hintText: hint,
//   //         hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
//   //         prefixIcon: Icon(icon, color: Colors.white54, size: 20),
//   //         border: InputBorder.none,
//   //         contentPadding: const EdgeInsets.symmetric(
//   //           horizontal: 20,
//   //           vertical: 16,
//   //         ),
//   //         suffixIcon: isPassword
//   //             ? IconButton(
//   //                 icon: Text(
//   //                   'Show',
//   //                   style: TextStyle(
//   //                     color: Colors.white.withOpacity(0.5),
//   //                     fontSize: 12,
//   //                   ),
//   //                 ),
//   //                 onPressed: onToggleVisibility,
//   //               )
//   //             : null,
//   //       ),
//   //     ),
//   //   );
//   // }

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

//         // ✅ Keyboard type
//         keyboardType: isPhone ? TextInputType.number : TextInputType.text,

//         // ✅ STRICT input control for phone
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
//                     style: TextStyle(color: Colors.white54, fontSize: 12),
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
//         child: Image.network(
//           imageUrl,
//           fit: BoxFit.contain,
//           errorBuilder: (context, error, stackTrace) {
//             return const Icon(Icons.error, color: Colors.red);
//           },
//         ),
//       ),
//     );
//   }
// }



















import 'package:farmhouse_app/provider/auth/login_provider.dart';
import 'package:farmhouse_app/provider/firebase/google_provider.dart';
import 'package:farmhouse_app/views/auth/forgot_password_screen.dart';
import 'package:farmhouse_app/views/auth/navbar_screen.dart';
import 'package:farmhouse_app/views/auth/register_screen.dart';
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
  bool _rememberMe = false;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final phoneNumber = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    // Validation
    if (phoneNumber.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter phone number and password'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }


  //     if (!RegExp(r'^[0-9]{10}$').hasMatch(phoneNumber)) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text('Please enter a valid 10-digit phone number'),
  //       backgroundColor: Colors.red,
  //     ),
  //   );
  //   return;
  // }

    if (!_rememberMe) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enable "Remember me" to continue'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Get provider
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    // Attempt login
    final success = await loginProvider.login(phoneNumber, password);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavbarScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed. Please check your credentials.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ✅ Google Sign-In Handler
  Future<void> _handleGoogleSignIn() async {
    final googleAuthProvider = Provider.of<GoogleAuthenticationProvider>(
      context,
      listen: false,
    );

    final success = await googleAuthProvider.signInWithGoogle();

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Google sign-in successful!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavbarScreen()),
      );
    } else {
      // Show error if any
      final errorMessage = googleAuthProvider.errorMessage ??
          'Google sign-in failed';
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B2D42),
      body: SafeArea(
        child: Consumer<LoginProvider>(
          builder: (context, loginProvider, child) {
            return Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),

                        const Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 40),

                        _buildTextField(
                          hint: 'Phone Number',
                          icon: Icons.phone,
                          controller: _phoneController,
                          isPhone: true,
                        ),
                        const SizedBox(height: 20),

                        _buildTextField(
                          hint: 'Password',
                          icon: Icons.lock,
                          isPassword: true,
                          isVisible: _isPasswordVisible,
                          controller: _passwordController,
                          onToggleVisibility: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value ?? true;
                                      });
                                    },
                                    fillColor:
                                        MaterialStateProperty.resolveWith((
                                          states,
                                        ) {
                                          if (states.contains(
                                            MaterialState.selected,
                                          )) {
                                            return const Color(0xFFFF5A5F);
                                          }
                                          return Colors.transparent;
                                        }),
                                    side: const BorderSide(
                                      color: Colors.white54,
                                      width: 2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Forgot Password',
                                style: TextStyle(
                                  color: Color(0xFFFF5A5F),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: loginProvider.isLoading
                                ? null
                                : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF5A5F),
                              disabledBackgroundColor: const Color(
                                0xFFFF5A5F,
                              ).withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              elevation: 0,
                            ),
                            child: loginProvider.isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : const Text(
                                    'Log In',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RegisterScreen(),
                                ),
                              );
                            },
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(text: "Don't have an account?  "),
                                  TextSpan(
                                    text: 'Sign up',
                                    style: TextStyle(
                                      color: Color(0xFFFF5A5F),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 70),
                        
                        // ✅ Google Sign-In Button with Consumer
                        // Consumer<GoogleAuthenticationProvider>(
                        //   builder: (context, googleAuthProvider, _) {
                        //     return Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         _socialButton(
                        //           imageUrl:
                        //               "https://yt3.googleusercontent.com/wjb1KjcaSgzXnqLUMTafDqgppr_LS7-A8sGf9DP1JJThg_Npp4EsiByYk9IPCkofvvD_3hy6dg=s900-c-k-c0x00ffffff-no-rj",
                        //           onTap: googleAuthProvider.isLoading
                        //               ? () {} // Disable when loading
                        //               : _handleGoogleSignIn,
                        //           isLoading: googleAuthProvider.isLoading,
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),

                // Loading overlay
                if (loginProvider.isLoading)
                  Container(
                    color: Colors.black26,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF5A5F),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? onToggleVisibility,
    bool isPhone = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFF5A5F), width: 1.5),
        borderRadius: BorderRadius.circular(28),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !isVisible,
        style: const TextStyle(color: Colors.white),
        keyboardType: isPhone ? TextInputType.number : TextInputType.text,
        inputFormatters: isPhone
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(10),
              ]
            : null,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
          prefixIcon: Icon(icon, color: Colors.white54, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Text(
                    isVisible ? 'Hide' : 'Show',
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
        ),
      ),
    );
  }

  Widget _socialButton({
    required String imageUrl,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: isLoading
            ? const CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Color(0xFFFF5A5F),
              )
            : Image.network(
                imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.red);
                },
              ),
      ),
    );
  }
}