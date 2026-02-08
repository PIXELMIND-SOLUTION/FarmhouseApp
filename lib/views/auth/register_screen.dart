import 'package:farmhouse_app/provider/auth/register_provider.dart';
import 'package:farmhouse_app/utils/validators.dart';
import 'package:farmhouse_app/views/auth/login_screen.dart';
import 'package:farmhouse_app/views/auth/otp_screen.dart';
import 'package:farmhouse_app/widgets/error_tooltip.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final _scrollController = ScrollController();

  // Error messages
  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  void _validateFields() {
    setState(() {
      _firstNameError = Validators.validateName(
        _firstNameController.text.trim(),
        fieldName: "First name",
      );
      _lastNameError = Validators.validateName(
        _lastNameController.text.trim(),
        fieldName: "Last name",
      );
      _emailError = Validators.validateEmail(_emailController.text.trim());
      _phoneError = Validators.validatePhone(_phoneController.text.trim());
      _passwordError = Validators.validatePassword(_passwordController.text);
      _confirmPasswordError = Validators.validateConfirmPassword(
        _confirmPasswordController.text,
        _passwordController.text,
      );
    });
  }

  Future<void> _handleRegister() async {
    _validateFields();

    // Check for errors
    if (_firstNameError != null ||
        _lastNameError != null ||
        _emailError != null ||
        _phoneError != null ||
        _passwordError != null ||
        _confirmPasswordError != null) {
      return;
    }

    if (!_agreedToPolicy) {
      _showSnackBar('Please agree to the privacy policy', isError: true);
      return;
    }

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
      _showSnackBar(
          authProvider.errorMessage ?? 'Registration failed. Please try again.',
          isError: true);
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
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF2B2D42),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: keyboardVisible ? 16 : 32),

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

                              // Title
                              const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: keyboardVisible ? 16 : 24),

                              // First Name & Last Name Row
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                      hint: 'First Name',
                                      controller: _firstNameController,
                                      errorText: _firstNameError,
                                      lettersOnly: true,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _buildTextField(
                                      hint: 'Last Name',
                                      controller: _lastNameController,
                                      errorText: _lastNameError,
                                      lettersOnly: true,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 14),

                              // Email
                              _buildTextField(
                                hint: 'Email',
                                controller: _emailController,
                                errorText: _emailError,
                                keyboardType: TextInputType.emailAddress,
                              ),

                              const SizedBox(height: 14),

                              // Phone
                              _buildTextField(
                                hint: 'Phone Number',
                                controller: _phoneController,
                                errorText: _phoneError,
                                isPhone: true,
                              ),

                              const SizedBox(height: 14),

                              // Password
                              _buildTextField(
                                hint: 'Password',
                                controller: _passwordController,
                                errorText: _passwordError,
                                isPassword: true,
                                isVisible: _isPasswordVisible,
                                onToggleVisibility: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),

                              const SizedBox(height: 14),

                              // Confirm Password
                              _buildTextField(
                                hint: 'Confirm Password',
                                controller: _confirmPasswordController,
                                errorText: _confirmPasswordError,
                                isPassword: true,
                                isVisible: _isConfirmPasswordVisible,
                                onToggleVisibility: () {
                                  setState(() {
                                    _isConfirmPasswordVisible =
                                        !_isConfirmPasswordVisible;
                                  });
                                },
                              ),

                              const SizedBox(height: 16),

                              // Privacy Policy Checkbox
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
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
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  /// Clickable Text
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                        children: [
                                          const TextSpan(text: 'I agree to the '),

                                          TextSpan(
                                            text: 'Privacy Policy',
                                            style: const TextStyle(
                                              color: Color(0xFFFF5A5F),
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                _launchURL(
                                                    "https://v-farm-houses-policies.onrender.com/privacy-policy");
                                              },
                                          ),

                                          const TextSpan(text: ' and '),

                                          TextSpan(
                                            text: 'Terms & Conditions',
                                            style: const TextStyle(
                                              color: Color(0xFFFF5A5F),
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                _launchURL(
                                                    "https://v-farm-houses-policies.onrender.com/terms-and-conditions");
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: keyboardVisible ? 16 : 24),

                              // Sign Up Button
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: (!_agreedToPolicy ||
                                          authProvider.isLoading)
                                      ? null // ❌ disabled
                                      : _handleRegister, // ✅ enabled
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFF5A5F),
                                    disabledBackgroundColor:
                                        const Color(0xFFFF5A5F)
                                            .withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
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
                                                    Colors.white),
                                          ),
                                        )
                                      : const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              ),

                              SizedBox(height: keyboardVisible ? 12 : 20),

                              // Sign In Link
                              if (!keyboardVisible)
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
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
                                          fontSize: 13,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "Already have an account? ",
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

                              SizedBox(height: keyboardVisible ? 16 : 24),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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

  /// TEXT FIELD WIDGET
  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
    String? errorText,
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? onToggleVisibility,
    bool isPhone = false,
    TextInputType? keyboardType,
    bool lettersOnly = false,
  }) {
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(
              color: hasError ? Colors.red : const Color(0xFFFF5A5F),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword && !isVisible,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            keyboardType: isPhone
                ? TextInputType.number
                : (keyboardType ?? TextInputType.text),
            inputFormatters: isPhone
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(10),
                  ]
                : lettersOnly
                    ? [
                        FilteringTextInputFormatter.allow(
                          RegExp(r"[a-zA-Z\s\-']"),
                        ),
                      ]
                    : null,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
              isDense: true,
              suffixIcon: hasError
                  ? const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(Icons.error, color: Colors.red, size: 18),
                    )
                  : isPassword
                      ? Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: TextButton(
                            onPressed: onToggleVisibility,
                            child: Text(
                              isVisible ? 'Hide' : 'Show',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 11,
                              ),
                            ),
                          ),
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