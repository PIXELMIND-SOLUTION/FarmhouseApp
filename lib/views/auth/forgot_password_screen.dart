// import 'package:farmhouse_app/provider/auth/forgot_password_provider.dart';
// import 'package:farmhouse_app/utils/validators.dart';
// import 'package:farmhouse_app/widgets/error_tooltip.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
//     with TickerProviderStateMixin {
//   final _phoneController = TextEditingController();
//   final _newPasswordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _otpController = TextEditingController();
  
//   bool _showResetScreen = false;
//   bool _obscureNewPassword = true;
//   bool _obscureConfirmPassword = true;

//   // Error messages
//   String? _phoneError;
//   String? _otpError;
//   String? _newPasswordError;
//   String? _confirmPasswordError;

//   late AnimationController _fadeController;
//   late AnimationController _slideController;
//   late AnimationController _scaleController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
    
//     _fadeController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
    
//     _slideController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );
    
//     _scaleController = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
//     );

//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(parent: _scaleController, curve: Curves.easeOut),
//     );

//     _fadeController.forward();
//     _slideController.forward();
//     _scaleController.forward();
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _slideController.dispose();
//     _scaleController.dispose();
//     _phoneController.dispose();
//     _newPasswordController.dispose();
//     _confirmPasswordController.dispose();
//     _otpController.dispose();
//     super.dispose();
//   }

//   void _validatePhone() {
//     setState(() {
//       _phoneError = Validators.validatePhone(_phoneController.text.trim());
//     });
//   }

//   void _validateOtp() {
//     setState(() {
//       _otpError = Validators.validateOTP(_otpController.text.trim(), length: 4);
//     });
//   }

//   void _validatePasswordFields() {
//     setState(() {
//       _newPasswordError = Validators.validatePassword(_newPasswordController.text);
//       _confirmPasswordError = Validators.validateConfirmPassword(
//         _confirmPasswordController.text,
//         _newPasswordController.text,
//       );
//     });
//   }

//   Future<void> _handleVerifyPhone() async {
//     _validatePhone();

//     if (_phoneError != null) {
//       return;
//     }

//     final provider = Provider.of<ForgotPasswordProvider>(context, listen: false);
    
//     final success = await provider.sendOtp(_phoneController.text);

//     if (success && mounted) {
//       _showOtpModal();
//     } else if (mounted) {
//       _showErrorDialog(
//         provider.errorMessage ?? 'Failed to send OTP. Please try again.'
//       );
//     }
//   }

//   void _showOtpModal() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       isDismissible: false,
//       enableDrag: false,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
//       ),
//       builder: (context) => Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//           left: 24,
//           right: 24,
//           top: 24,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Handle bar
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               // Icon
//               Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFFF5A5F).withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.message_outlined,
//                   size: 40,
//                   color: Color(0xFFFF5A5F),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Enter OTP',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 'We have sent a 4-digit OTP to\n+91 ${_phoneController.text}',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                   height: 1.5,
//                 ),
//               ),
//               const SizedBox(height: 32),
//               // OTP Input
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextFormField(
//                     controller: _otpController,
//                     keyboardType: TextInputType.number,
//                     textAlign: TextAlign.center,
//                     maxLength: 4,
//                     inputFormatters: [
//                       FilteringTextInputFormatter.digitsOnly,
//                       LengthLimitingTextInputFormatter(4),
//                     ],
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 20,
//                     ),
//                     decoration: InputDecoration(
//                       counterText: '',
//                       hintText: '••••',
//                       hintStyle: TextStyle(
//                         fontSize: 24,
//                         color: Colors.grey[400],
//                         letterSpacing: 20,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: _otpError != null ? Colors.red : Colors.grey.shade300,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: _otpError != null ? Colors.red : const Color(0xFFFF5A5F),
//                           width: 2,
//                         ),
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[50],
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: const BorderSide(color: Colors.red),
//                       ),
//                     ),
//                   ),
//                   if (_otpError != null) ...[
//                     const SizedBox(height: 8),
//                     ErrorTooltip(message: _otpError!),
//                   ],
//                 ],
//               ),
//               const SizedBox(height: 24),
//               // Verify Button
//               Consumer<ForgotPasswordProvider>(
//                 builder: (context, provider, child) {
//                   return SizedBox(
//                     width: double.infinity,
//                     height: 56,
//                     child: ElevatedButton(
//                       onPressed: provider.isLoading
//                           ? null
//                           : () async {
//                               _validateOtp();
                              
//                               if (_otpError != null) {
//                                 return;
//                               }

//                               final success = await provider.verifyOtp(
//                                 _otpController.text,
//                                 provider.token.toString(),
//                               );
                              
//                               if (success && mounted) {
//                                 Navigator.pop(context);
//                                 setState(() {
//                                   _showResetScreen = true;
//                                   _otpError = null;
//                                 });
//                                 // Reset animations for new screen
//                                 _fadeController.reset();
//                                 _slideController.reset();
//                                 _scaleController.reset();
//                                 _fadeController.forward();
//                                 _slideController.forward();
//                                 _scaleController.forward();
//                               } else if (mounted) {
//                                 setState(() {
//                                   _otpError = provider.errorMessage ?? 'Invalid OTP. Please try again.';
//                                 });
//                               }
//                             },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFFF5A5F),
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 2,
//                       ),
//                       child: provider.isLoading
//                           ? const SizedBox(
//                               width: 24,
//                               height: 24,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2.5,
//                                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                               ),
//                             )
//                           : const Text(
//                               'Verify OTP',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 16),
//               // Resend OTP
//               TextButton(
//                 onPressed: () async {
//                   _otpController.clear();
//                   setState(() {
//                     _otpError = null;
//                   });
//                   final provider = Provider.of<ForgotPasswordProvider>(context, listen: false);
//                   await provider.sendOtp(_phoneController.text);
//                   if (mounted) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('OTP resent successfully')),
//                     );
//                   }
//                 },
//                 child: const Text(
//                   'Resend OTP',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _handleResetPassword() async {
//     _validatePasswordFields();

//     if (_newPasswordError != null || _confirmPasswordError != null) {
//       return;
//     }

//     final provider = Provider.of<ForgotPasswordProvider>(context, listen: false);
    
//     final success = await provider.resetPassword(
//       _newPasswordController.text,
//       _confirmPasswordController.text,
//     );

//     if (success && mounted) {
//       _showSuccessDialog();
//     } else if (mounted) {
//       _showErrorDialog(
//         provider.errorMessage ?? 'Failed to reset password. Please try again.'
//       );
//     }
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 color: Colors.red.shade50,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.error_outline_rounded,
//                 size: 50,
//                 color: Colors.red.shade700,
//               ),
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'Error',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 12),
//             Text(
//               message,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red.shade700,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                 ),
//                 child: const Text(
//                   'OK',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => ScaleTransition(
//         scale: _scaleAnimation,
//         child: AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: Colors.green.shade50,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.check_circle_rounded,
//                   size: 50,
//                   color: Colors.green.shade700,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               const Text(
//                 'Password Reset Successful!',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 'Your password has been reset successfully. You can now login with your new password.',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     Navigator.of(context).pop();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green.shade700,
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                   ),
//                   child: const Text(
//                     'Back to Login',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: SlideTransition(
//               position: _slideAnimation,
//               child: _showResetScreen 
//                   ? _buildResetPasswordView() 
//                   : _buildPhoneView(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPhoneView() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 20),
//         // Animated Icon
//         Center(
//           child: ScaleTransition(
//             scale: _scaleAnimation,
//             child: Container(
//               width: 100,
//               height: 100,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.phone_android_rounded,
//                 size: 50,
//                 color: Color(0xFFFF5A5F),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 40),
//         // Title
//         const Text(
//           'Forgot Password?',
//           style: TextStyle(
//             fontSize: 32,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(
//           'Enter your mobile number to verify your identity and reset your password.',
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey[600],
//             height: 1.5,
//           ),
//         ),
//         const SizedBox(height: 40),
//         // Form
//         Column(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextFormField(
//                   controller: _phoneController,
//                   keyboardType: TextInputType.phone,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     LengthLimitingTextInputFormatter(10),
//                   ],
//                   decoration: InputDecoration(
//                     labelText: 'Mobile Number',
//                     hintText: 'Enter your mobile number',
//                     prefixIcon: const Icon(Icons.phone_outlined),
//                     prefixText: '+91 ',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(
//                         color: _phoneError != null ? Colors.red : Colors.grey.shade300,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(
//                         color: _phoneError != null ? Colors.red : const Color(0xFFFF5A5F),
//                         width: 2,
//                       ),
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Colors.red),
//                     ),
//                   ),
//                 ),
//                 if (_phoneError != null) ...[
//                   const SizedBox(height: 8),
//                   ErrorTooltip(message: _phoneError!),
//                 ],
//               ],
//             ),
//             const SizedBox(height: 24),
//             // Submit Button
//             Consumer<ForgotPasswordProvider>(
//               builder: (context, provider, child) {
//                 return SizedBox(
//                   width: double.infinity,
//                   height: 56,
//                   child: ElevatedButton(
//                     onPressed: provider.isLoading ? null : _handleVerifyPhone,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFFF5A5F),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 2,
//                     ),
//                     child: provider.isLoading
//                         ? const SizedBox(
//                             width: 24,
//                             height: 24,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2.5,
//                               valueColor:
//                                   AlwaysStoppedAnimation<Color>(Colors.white),
//                             ),
//                           )
//                         : const Text(
//                             'Send OTP',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//         const SizedBox(height: 24),
//         // Back to Login
//         Center(
//           child: TextButton.icon(
//             onPressed: () => Navigator.pop(context),
//             icon: const Icon(Icons.arrow_back, size: 18),
//             label: const Text(
//               'Back to Login',
//               style: TextStyle(fontSize: 15),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildResetPasswordView() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 20),
//         // Animated Icon
//         Center(
//           child: ScaleTransition(
//             scale: _scaleAnimation,
//             child: Container(
//               width: 100,
//               height: 100,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.lock_reset_rounded,
//                 size: 50,
//                 color: Color(0xFFFF5A5F),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 40),
//         // Title
//         const Text(
//           'Create New Password',
//           style: TextStyle(
//             fontSize: 32,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(
//           'Your new password must be different from previously used passwords.',
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey[600],
//             height: 1.5,
//           ),
//         ),
//         const SizedBox(height: 40),
//         // Form
//         Column(
//           children: [
//             // New Password Field
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextFormField(
//                   controller: _newPasswordController,
//                   obscureText: _obscureNewPassword,
//                   decoration: InputDecoration(
//                     labelText: 'New Password',
//                     hintText: 'Enter new password',
//                     prefixIcon: const Icon(Icons.lock_outline),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscureNewPassword
//                             ? Icons.visibility_off_outlined
//                             : Icons.visibility_outlined,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscureNewPassword = !_obscureNewPassword;
//                         });
//                       },
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(
//                         color: _newPasswordError != null ? Colors.red : Colors.grey.shade300,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(
//                         color: _newPasswordError != null ? Colors.red : const Color(0xFFFF5A5F),
//                         width: 2,
//                       ),
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Colors.red),
//                     ),
//                   ),
//                 ),
//                 if (_newPasswordError != null) ...[
//                   const SizedBox(height: 8),
//                   ErrorTooltip(message: _newPasswordError!),
//                 ],
//               ],
//             ),
//             const SizedBox(height: 20),
//             // Confirm Password Field
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextFormField(
//                   controller: _confirmPasswordController,
//                   obscureText: _obscureConfirmPassword,
//                   decoration: InputDecoration(
//                     labelText: 'Confirm Password',
//                     hintText: 'Re-enter new password',
//                     prefixIcon: const Icon(Icons.lock_outline),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscureConfirmPassword
//                             ? Icons.visibility_off_outlined
//                             : Icons.visibility_outlined,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscureConfirmPassword = !_obscureConfirmPassword;
//                         });
//                       },
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(
//                         color: _confirmPasswordError != null ? Colors.red : Colors.grey.shade300,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(
//                         color: _confirmPasswordError != null ? Colors.red : const Color(0xFFFF5A5F),
//                         width: 2,
//                       ),
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Colors.red),
//                     ),
//                   ),
//                 ),
//                 if (_confirmPasswordError != null) ...[
//                   const SizedBox(height: 8),
//                   ErrorTooltip(message: _confirmPasswordError!),
//                 ],
//               ],
//             ),
//             const SizedBox(height: 32),
//             // Submit Button
//             Consumer<ForgotPasswordProvider>(
//               builder: (context, provider, child) {
//                 return SizedBox(
//                   width: double.infinity,
//                   height: 56,
//                   child: ElevatedButton(
//                     onPressed: provider.isLoading ? null : _handleResetPassword,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFFF5A5F),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 2,
//                     ),
//                     child: provider.isLoading
//                         ? const SizedBox(
//                             width: 24,
//                             height: 24,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2.5,
//                               valueColor:
//                                   AlwaysStoppedAnimation<Color>(Colors.white),
//                             ),
//                           )
//                         : const Text(
//                             'Reset Password',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }























import 'dart:async';
import 'package:farmhouse_app/provider/auth/forgot_password_provider.dart';
import 'package:farmhouse_app/utils/validators.dart';
import 'package:farmhouse_app/widgets/error_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with TickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _otpController = TextEditingController();
  
  bool _showResetScreen = false;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  // Error messages
  String? _phoneError;
  String? _otpError;
  String? _newPasswordError;
  String? _confirmPasswordError;

  // Timer for password reset
  int _remainingSeconds = 30;
  Timer? _timer;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOut),
    );

    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _phoneController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _validatePhone() {
    setState(() {
      _phoneError = Validators.validatePhone(_phoneController.text.trim());
    });
  }

  void _validateOtp() {
    setState(() {
      _otpError = Validators.validateOTP(_otpController.text.trim(), length: 4);
    });
  }

  void _validatePasswordFields() {
    setState(() {
      _newPasswordError = Validators.validatePassword(_newPasswordController.text);
      _confirmPasswordError = Validators.validateConfirmPassword(
        _confirmPasswordController.text,
        _newPasswordController.text,
      );
    });
  }

  void _startTimer() {
    _remainingSeconds = 30;
    _timer?.cancel();
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _resetToPhoneScreen() {
    _timer?.cancel();
    setState(() {
      _showResetScreen = false;
      _remainingSeconds = 30;
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      _otpController.clear();
      _newPasswordError = null;
      _confirmPasswordError = null;
    });
    
    // Reset animations
    _fadeController.reset();
    _slideController.reset();
    _scaleController.reset();
    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  Future<void> _handleVerifyPhone() async {
    _validatePhone();

    if (_phoneError != null) {
      return;
    }

    final provider = Provider.of<ForgotPasswordProvider>(context, listen: false);
    
    final success = await provider.sendOtp(_phoneController.text);

    if (success && mounted) {
      _showOtpModal();
    } else if (mounted) {
      _showErrorDialog(
        provider.errorMessage ?? 'Failed to send OTP. Please try again.'
      );
    }
  }

  void _showOtpModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              // Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5A5F).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.message_outlined,
                  size: 40,
                  color: Color(0xFFFF5A5F),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter OTP',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'We have sent a 4-digit OTP to\n+91 ${_phoneController.text}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              // OTP Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 4,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 20,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '••••',
                      hintStyle: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[400],
                        letterSpacing: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: _otpError != null ? Colors.red : Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: _otpError != null ? Colors.red : const Color(0xFFFF5A5F),
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  if (_otpError != null) ...[
                    const SizedBox(height: 8),
                    ErrorTooltip(message: _otpError!),
                  ],
                ],
              ),
              const SizedBox(height: 24),
              // Verify Button
              Consumer<ForgotPasswordProvider>(
                builder: (context, provider, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: provider.isLoading
                          ? null
                          : () async {
                              _validateOtp();
                              
                              if (_otpError != null) {
                                return;
                              }

                              final success = await provider.verifyOtp(
                                _otpController.text,
                                provider.token.toString(),
                              );
                              
                              if (success && mounted) {
                                Navigator.pop(context);
                                setState(() {
                                  _showResetScreen = true;
                                  _otpError = null;
                                });
                                // Start 30-second timer
                                _startTimer();
                                // Reset animations for new screen
                                _fadeController.reset();
                                _slideController.reset();
                                _scaleController.reset();
                                _fadeController.forward();
                                _slideController.forward();
                                _scaleController.forward();
                                // Unfocus to hide keyboard
                                FocusScope.of(context).unfocus();
                              } else if (mounted) {
                                setState(() {
                                  _otpError = provider.errorMessage ?? 'Invalid OTP. Please try again.';
                                });
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5A5F),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: provider.isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Verify OTP',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              // Resend OTP
              TextButton(
                onPressed: () async {
                  _otpController.clear();
                  setState(() {
                    _otpError = null;
                  });
                  final provider = Provider.of<ForgotPasswordProvider>(context, listen: false);
                  await provider.sendOtp(_phoneController.text);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('OTP resent successfully')),
                    );
                  }
                },
                child: const Text(
                  'Resend OTP',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleResetPassword() async {
    _validatePasswordFields();

    if (_newPasswordError != null || _confirmPasswordError != null) {
      return;
    }

    final provider = Provider.of<ForgotPasswordProvider>(context, listen: false);
    
    final success = await provider.resetPassword(
      _newPasswordController.text,
      _confirmPasswordController.text,
    );

    if (success && mounted) {
      _showSuccessDialog();
    } else if (mounted) {
      _showErrorDialog(
        provider.errorMessage ?? 'Failed to reset password. Please try again.'
      );
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 50,
                color: Colors.red.shade700,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Error',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ScaleTransition(
        scale: _scaleAnimation,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  size: 50,
                  color: Colors.green.shade700,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Password Reset Successful!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Your password has been reset successfully. You can now login with your new password.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Back to Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: _showResetScreen 
                  ? _buildResetPasswordView() 
                  : _buildPhoneView(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        // Animated Icon
        Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.phone_android_rounded,
                size: 50,
                color: Color(0xFFFF5A5F),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        // Title
        const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Enter your mobile number to verify your identity and reset your password.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
        const SizedBox(height: 40),
        // Form
        Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: 'Enter your mobile number',
                    prefixIcon: const Icon(Icons.phone_outlined),
                    prefixText: '+91 ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: _phoneError != null ? Colors.red : Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: _phoneError != null ? Colors.red : const Color(0xFFFF5A5F),
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                if (_phoneError != null) ...[
                  const SizedBox(height: 8),
                  ErrorTooltip(message: _phoneError!),
                ],
              ],
            ),
            const SizedBox(height: 24),
            // Submit Button
            Consumer<ForgotPasswordProvider>(
              builder: (context, provider, child) {
                return SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _handleVerifyPhone,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5A5F),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: provider.isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Send OTP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Back to Login
        Center(
          child: TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 18),
            label: const Text(
              'Back to Login',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResetPasswordView() {
    final bool isExpired = _remainingSeconds == 0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        // Animated Icon
        Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lock_reset_rounded,
                size: 50,
                color: Color(0xFFFF5A5F),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        // Title
        const Text(
          'Create New Password',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Your new password must be different from previously used passwords.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        
        // Timer Display
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isExpired ? Colors.red.shade50 : const Color(0xFFFF5A5F).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isExpired ? Colors.red.shade300 : const Color(0xFFFF5A5F).withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                isExpired ? Icons.error_outline : Icons.timer_outlined,
                color: isExpired ? Colors.red.shade700 : const Color(0xFFFF5A5F),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isExpired
                      ? 'Session expired! Please request a new OTP.'
                      : 'Complete within $_remainingSeconds seconds',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isExpired ? Colors.red.shade700 : const Color(0xFFFF5A5F),
                  ),
                ),
              ),
              if (!isExpired)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5A5F),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$_remainingSeconds',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        // Form
        Column(
          children: [
            // New Password Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: _obscureNewPassword,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  enabled: !isExpired,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    hintText: 'Enter new password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNewPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureNewPassword = !_obscureNewPassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: _newPasswordError != null ? Colors.red : Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: _newPasswordError != null ? Colors.red : const Color(0xFFFF5A5F),
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                if (_newPasswordError != null) ...[
                  const SizedBox(height: 8),
                  ErrorTooltip(message: _newPasswordError!),
                ],
              ],
            ),
            const SizedBox(height: 20),
            // Confirm Password Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  enabled: !isExpired,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter new password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: _confirmPasswordError != null ? Colors.red : Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: _confirmPasswordError != null ? Colors.red : const Color(0xFFFF5A5F),
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                if (_confirmPasswordError != null) ...[
                  const SizedBox(height: 8),
                  ErrorTooltip(message: _confirmPasswordError!),
                ],
              ],
            ),
            const SizedBox(height: 32),
            // Submit Button or Go Back Button
            Consumer<ForgotPasswordProvider>(
              builder: (context, provider, child) {
                if (isExpired) {
                  // Show "Go Back" button when timer expires
                  return SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: _resetToPhoneScreen,
                      icon: const Icon(Icons.arrow_back, size: 20),
                      label: const Text(
                        'Go Back & Request New OTP',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                    ),
                  );
                }
                
                // Show "Reset Password" button when timer is running
                return SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _handleResetPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5A5F),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: provider.isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Reset Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}