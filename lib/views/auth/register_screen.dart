// import 'package:farmhouse_app/views/auth/login_screen.dart';
// import 'package:flutter/material.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   bool _isPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;
//   bool _agreedToPolicy = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1E1E2E),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 40),

//                 const Text(
//                   'Sign Up',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 40),

//                 Row(
//                   children: [
//                     Expanded(child: _buildTextField('First Name')),
//                     const SizedBox(width: 12),
//                     Expanded(child: _buildTextField('Last Name')),
//                   ],
//                 ),

//                 const SizedBox(height: 20),

//                 _buildTextField('Email'),

//                 const SizedBox(height: 20),

//                 _buildTextField('Phone'),
//                 const SizedBox(height: 20),

//                 _buildTextField(
//                   'Password',
//                   isPassword: true,
//                   isVisible: _isPasswordVisible,
//                   onToggleVisibility: () {
//                     setState(() {
//                       _isPasswordVisible = !_isPasswordVisible;
//                     });
//                   },
//                 ),

//                 const SizedBox(height: 20),

//                 _buildTextField(
//                   'Confirm Password',
//                   isPassword: true,
//                   isVisible: _isConfirmPasswordVisible,
//                   onToggleVisibility: () {
//                     setState(() {
//                       _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//                     });
//                   },
//                 ),

//                 const SizedBox(height: 24),

//                 Row(
//                   children: [
//                     SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: Checkbox(
//                         value: _agreedToPolicy,
//                         onChanged: (value) {
//                           setState(() {
//                             _agreedToPolicy = value ?? false;
//                           });
//                         },
//                         fillColor: MaterialStateProperty.resolveWith((states) {
//                           if (states.contains(MaterialState.selected)) {
//                             return const Color(0xFFFF5A5F);
//                           }
//                           return Colors.transparent;
//                         }),
//                         side: const BorderSide(
//                           color: Color(0xFFFF5A5F),
//                           width: 2,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),

//                     // Terms & Policy text
//                     RichText(
//                       text: const TextSpan(
//                         style: TextStyle(color: Colors.white70, fontSize: 14),
//                         children: [
//                           TextSpan(text: 'I Agree with '),
//                           TextSpan(
//                             text: 'privacy',
//                             style: TextStyle(color: Color(0xFFFF5A5F)),
//                           ),
//                           TextSpan(text: ' and '),
//                           TextSpan(
//                             text: 'policy',
//                             style: TextStyle(color: Color(0xFFFF5A5F)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 32),

//                 SizedBox(
//                   width: double.infinity,
//                   height: 56,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const LoginScreen()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFFF5A5F),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(28),
//                       ),
//                       elevation: 0,
//                     ),
//                     child: const Text(
//                       'Sign up',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 40),

//                 Center(
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const LoginScreen()),
//                       );
//                     },
//                     child: RichText(
//                       text: const TextSpan(
//                         style: TextStyle(color: Colors.white60, fontSize: 14),
//                         children: [
//                           TextSpan(text: "Already have an account ?  "),
//                           TextSpan(
//                             text: 'Sign in',
//                             style: TextStyle(
//                               color: Color(0xFFFF5A5F),
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 40),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//     String hint, {
//     bool isPassword = false,
//     bool isVisible = false,
//     VoidCallback? onToggleVisibility,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xFFFF5A5F), width: 1.5),
//         borderRadius: BorderRadius.circular(28),
//       ),
//       child: TextField(
//         obscureText: isPassword && !isVisible,
//         style: const TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 16,
//           ),
//           suffixIcon: isPassword
//               ? IconButton(
//                   icon: Text(
//                     'Show',
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.5),
//                       fontSize: 12,
//                     ),
//                   ),
//                   onPressed: onToggleVisibility,
//                 )
//               : null,
//         ),
//       ),
//     );
//   }
// }

import 'package:farmhouse_app/provider/auth/register_provider.dart';
import 'package:farmhouse_app/views/auth/login_screen.dart';
import 'package:farmhouse_app/views/auth/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreedToPolicy = false;

  // Form controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_agreedToPolicy) {
      _showSnackBar('Please agree to the privacy policy', isError: true);
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar('Passwords do not match', isError: true);
      return;
    }

    // Debug: Print values before sending
    print('=== Registration Debug ===');
    print('First Name: ${_firstNameController.text.trim()}');
    print('Last Name: ${_lastNameController.text.trim()}');
    print('Email: ${_emailController.text.trim()}');
    print('Phone: ${_phoneController.text.trim()}');
    print('Password length: ${_passwordController.text.length}');

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final success = await authProvider.register(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    );

    if (!mounted) return;

    if (success) {
      _showSnackBar('Registration successful!', isError: false);
      // Navigate to home or next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OtpScreen(
            number: authProvider.user!.phoneNumber,
            token: authProvider.user!.token,
          ),
        ),
      );
    } else {
      _showSnackBar('Registration failed. Please try again.', isError: true);
    }
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  'First Name',
                                  controller: _firstNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildTextField(
                                  'Last Name',
                                  controller: _lastNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            'Email',
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              if (!value.contains('@')) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // _buildTextField(
                          //   'Phone',
                          //   controller: _phoneController,
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Phone number is required';
                          //     }
                          //     if (value.length < 10) {
                          //       return 'Enter a valid phone number';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          _buildTextField(
                            'Phone',
                            controller: _phoneController,
                            isPhone: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number is required';
                              }
                              if (value.length != 10) {
                                return 'Enter a valid 10-digit phone number';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),
                          _buildTextField(
                            'Password',
                            controller: _passwordController,
                            isPassword: true,
                            isVisible: _isPasswordVisible,
                            onToggleVisibility: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            'Confirm Password',
                            controller: _confirmPasswordController,
                            isPassword: true,
                            isVisible: _isConfirmPasswordVisible,
                            onToggleVisibility: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                  value: _agreedToPolicy,
                                  onChanged: (value) {
                                    setState(() {
                                      _agreedToPolicy = value ?? false;
                                    });
                                  },
                                  fillColor: MaterialStateProperty.resolveWith((
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
                                    color: Color(0xFFFF5A5F),
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(text: 'I Agree with '),
                                    TextSpan(
                                      text: 'privacy',
                                      style: TextStyle(
                                        color: Color(0xFFFF5A5F),
                                      ),
                                    ),
                                    TextSpan(text: ' and '),
                                    TextSpan(
                                      text: 'policy',
                                      style: TextStyle(
                                        color: Color(0xFFFF5A5F),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              // onPressed: authProvider.isLoading
                              onPressed:
                                  (!_agreedToPolicy || authProvider.isLoading)
                                  ? null
                                  : _handleRegister,
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
                              child: authProvider.isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    )
                                  : const Text(
                                      'Sign up',
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
                                    builder: (_) => const LoginScreen(),
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
                                    TextSpan(
                                      text: "Already have an account ?  ",
                                    ),
                                    TextSpan(
                                      text: 'Sign in',
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
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
                if (authProvider.isLoading)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFFF5A5F),
                        ),
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

  // Widget _buildTextField(
  //   String hint, {
  //   bool isPassword = false,
  //   bool isVisible = false,
  //   VoidCallback? onToggleVisibility,
  //   TextEditingController? controller,
  //   String? Function(String?)? validator,
  // }) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       border: Border.all(color: const Color(0xFFFF5A5F), width: 1.5),
  //       borderRadius: BorderRadius.circular(28),
  //     ),
  //     child: TextFormField(
  //       controller: controller,
  //       obscureText: isPassword && !isVisible,
  //       style: const TextStyle(color: Colors.white),
  //       validator: validator,
  //       decoration: InputDecoration(
  //         hintText: hint,
  //         hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
  //         border: InputBorder.none,
  //         errorStyle: const TextStyle(fontSize: 11, height: 0.5),
  //         contentPadding: const EdgeInsets.symmetric(
  //           horizontal: 20,
  //           vertical: 16,
  //         ),
  //         suffixIcon: isPassword
  //             ? IconButton(
  //                 icon: Text(
  //                   isVisible ? 'Hide' : 'Show',
  //                   style: TextStyle(
  //                     color: Colors.white.withOpacity(0.5),
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //                 onPressed: onToggleVisibility,
  //               )
  //             : null,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildTextField(
    String hint, {
    bool isPassword = false,
    bool isVisible = false,
    bool isPhone = false,
    VoidCallback? onToggleVisibility,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFF5A5F), width: 1.5),
        borderRadius: BorderRadius.circular(28),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !isVisible,
        style: const TextStyle(color: Colors.white),
        validator: validator,

        // ✅ Keyboard type
        keyboardType: isPhone ? TextInputType.number : TextInputType.text,

        // ✅ Phone-only restrictions
        inputFormatters: isPhone
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(10),
              ]
            : null,

        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
          border: InputBorder.none,
          errorStyle: const TextStyle(fontSize: 11, height: 0.5),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Text(
                    isVisible ? 'Hide' : 'Show',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
        ),
      ),
    );
  }
}
