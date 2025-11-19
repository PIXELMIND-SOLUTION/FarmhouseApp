import 'package:farmhouse_app/views/auth/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreedToPolicy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                    Expanded(child: _buildTextField('First Name')),
                    const SizedBox(width: 12),
                    Expanded(child: _buildTextField('Last Name')),
                  ],
                ),

                const SizedBox(height: 20),

                _buildTextField('Email'),

                const SizedBox(height: 20),

                _buildTextField(
                  'Password',
                  isPassword: true,
                  isVisible: _isPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  'Confirm Password',
                  isPassword: true,
                  isVisible: _isConfirmPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      _isConfirmPasswordVisible =
                          !_isConfirmPasswordVisible;
                    });
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
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
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

                    // Terms & Policy text
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                        children: [
                          TextSpan(text: 'I Agree with '),
                          TextSpan(
                            text: 'privacy',
                            style: TextStyle(color: Color(0xFFFF5A5F)),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'policy',
                            style: TextStyle(color: Color(0xFFFF5A5F)),
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5A5F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
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
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.white60, fontSize: 14),
                        children: [
                          TextSpan(text: "Already have an account ?  "),
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
    );
  }

  Widget _buildTextField(
    String hint, {
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFF5A5F), width: 1.5),
        borderRadius: BorderRadius.circular(28),
      ),
      child: TextField(
        obscureText: isPassword && !isVisible,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Text(
                    'Show',
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
