// import 'package:farmhouse_app/provider/booking/payment_provider.dart';
// import 'package:farmhouse_app/theme/theme_provider.dart';
// import 'package:farmhouse_app/utils/helper_function.dart';
// import 'package:farmhouse_app/views/auth/navbar_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class PaymentScreen extends StatefulWidget {
//   final List<String>? images;
//   final String? price;
//   final String? name;
//   final String? address;
//   final int slotPrice;
//   final int cleaningFee;
//   final int serviceFee;
//   final int totalAmount;
//   final String slotId;
//   final String farmhouseId;

//   const PaymentScreen({
//     super.key,
//     this.images,
//     this.price,
//     this.name,
//     this.address,
//     required this.slotPrice,
//     required this.cleaningFee,
//     required this.serviceFee,
//     required this.totalAmount,
//     required this.slotId,
//     required this.farmhouseId,
//   });

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   late Razorpay _razorpay;
//   final PaymentProvider _paymentProvider = PaymentProvider();
//   String? _selectedPaymentMethod;
//   String? _selectedPaymentOption; // 'full' or 'advance'
//   bool _isLoading = false;
//   int _currentImageIndex = 0;
//   String? _userId; // fetched from SharedPrefs

//   @override
//   void initState() {
//     super.initState();
//     _initializeRazorpay();
//     _fetchUserId();
//     // Default to full payment
//     _selectedPaymentOption = 'full';
//   }

//   /// Pulls the logged-in user's ID from SharedPreferences
//   Future<void> _fetchUserId() async {
//     final user = await SharedPrefs.getUser();
//     if (mounted) {
//       setState(() {
//         _userId = user?.id;
//       });
//     }
//   }

//   void _initializeRazorpay() {
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   /// Called by Razorpay on success → hands off to the provider
//   Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     setState(() => _isLoading = false);

//     if (_userId == null) {
//       _showSnackBar('User session expired. Please log in again.', Colors.red);
//       return;
//     }

//     // Get the actual amount paid
//     int amountPaid = _getPayableAmount();

//     // Hand the transaction ID + verification ID to the provider
//     await _paymentProvider.createPayment(
//       transactionId: response.paymentId ?? '',
//       userId: _userId!,
//       slotId: widget.slotId,
//       farmId: widget.farmhouseId,
//       // paymentType: _selectedPaymentOption, // 'full' or 'advance'
//       // amountPaid: amountPaid,
//     );

//     print('Transaction ID: ${response.paymentId}');
//     print('Payment Type: $_selectedPaymentOption');
//     print('Amount Paid: $amountPaid');

//     // Provider already called notifyListeners; check the result
//     if (_paymentProvider.status == PaymentStatus.success) {
//       _showSuccessDialog(response.paymentId);
//     } else {
//       _showSnackBar(
//         'Payment recorded but server error: ${_paymentProvider.errorMessage}',
//         Colors.red,
//       );
//     }
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     setState(() => _isLoading = false);
//     _showSnackBar('Payment Failed: ${response.message}', Colors.red);
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     setState(() => _isLoading = false);
//     _showSnackBar('External Wallet: ${response.walletName}', Colors.blueGrey);
//   }

//   /// Calculate the amount to be paid based on selected option
//   int _getPayableAmount() {
//     if (_selectedPaymentOption == 'advance') {
//       // Calculate 30% of total amount
//       return (widget.totalAmount * 0.3).round();
//     }
//     return widget.totalAmount; // Full amount
//   }

//   void _openRazorpayCheckout() {
//     if (_userId == null) {
//       _showSnackBar('User session expired. Please log in again.', Colors.red);
//       return;
//     }

//     int amountToPay = _getPayableAmount();
//     int amountInPaise = amountToPay * 100; // Convert to paise

//     var options = {
//       'key': 'rzp_live_R7WEc7UNXkN075',
//       'amount': amountInPaise,
//       'name': 'V Farm',
//       'description':
//           '${widget.name ?? "Farm House"} - Calicut, Kerala\n${_selectedPaymentOption == 'advance' ? '30% Advance Payment' : 'Full Payment'}',
//       'prefill': {'contact': '9961593179', 'email': 'booking@farmhouse.com'},
//       'theme': {'color': '#FF5A5F'},
//     };

//     try {
//       setState(() => _isLoading = true);
//       _razorpay.open(options);
//     } catch (e) {
//       setState(() => _isLoading = false);
//       _showSnackBar('Error: $e', Colors.red);
//     }
//   }

//   double _calculateTotal() {
//     String priceStr = widget.price ?? '0';
//     priceStr = priceStr.replaceAll('₹', '').replaceAll(',', '').trim();
//     double basePrice = double.tryParse(priceStr) ?? 0;
//     return basePrice + 500 + 300; // cleaning + service fee
//   }

//   // ─── Reusable helpers ────────────────────────────────────────────────────

//   void _showSnackBar(String message, Color color) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: color,
//         behavior: SnackBarBehavior.floating,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   void _showSuccessDialog(String? paymentId) {
//     if (!mounted) return;
//     String paymentMessage = _selectedPaymentOption == 'advance'
//         ? 'Your 30% advance payment has been received. Remaining balance to be paid at check-in.'
//         : 'Your full payment has been received. Your booking is confirmed.';

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: Row(
//           children: const [
//             Icon(Icons.check_circle, color: Colors.green, size: 28),
//             SizedBox(width: 10),
//             Expanded(
//               child: Text(
//                 'Payment Successful',
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//             ),
//           ],
//         ),
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(height: 8),
//               Text(
//                 'Payment ID',
//                 style: TextStyle(fontSize: 13, color: Colors.grey[600]),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 paymentId ?? 'N/A',
//                 style: const TextStyle(fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(height: 12),
//               Text(paymentMessage, style: const TextStyle(fontSize: 14)),
//               if (_selectedPaymentOption == 'advance') ...[
//                 const SizedBox(height: 12),
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.orange.shade50,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.orange.shade200),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.info_outline,
//                         color: Colors.orange.shade700,
//                         size: 20,
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           'Remaining balance: ₹${widget.totalAmount - _getPayableAmount()} to be paid at check-in',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.orange.shade800,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//         actionsPadding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 12,
//         ),
//         actions: [
//           SizedBox(
//             width: double.infinity,
//             height: 45,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFFF5A5F),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop(); // close dialog

//                 Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (_) => const NavbarScreen()),
//                   (route) => false,
//                 );
//               },
//               child: const Text(
//                 'OK',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _razorpay.clear();
//     _paymentProvider.reset();
//     super.dispose();
//   }

//   // ─── BUILD ───────────────────────────────────────────────────────────────

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final isDarkMode = themeProvider.isDarkMode;
//     final List<String> imageList = widget.images ?? [];
//     final double totalAmount = _calculateTotal();
//     final int payableAmount = _getPayableAmount();

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: const Text(
//           "Payment",
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//         leading: IconButton(
//           onPressed: () => Navigator.of(context).pop(),
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // ---------- Farmhouse Card ----------
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(18),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.08),
//                         blurRadius: 10,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Image Gallery
//                       ClipRRect(
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(18),
//                           topRight: Radius.circular(18),
//                         ),
//                         child: Stack(
//                           children: [
//                             SizedBox(
//                               height: 220,
//                               child: imageList.isEmpty
//                                   ? Container(
//                                       color: Colors.grey[300],
//                                       child: const Center(
//                                         child: Icon(
//                                           Icons.image_not_supported,
//                                           size: 50,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                     )
//                                   : PageView.builder(
//                                       itemCount: imageList.length,
//                                       onPageChanged: (index) {
//                                         setState(
//                                           () => _currentImageIndex = index,
//                                         );
//                                       },
//                                       itemBuilder: (context, index) {
//                                         return Image.network(
//                                           imageList[index],
//                                           height: 220,
//                                           width: double.infinity,
//                                           fit: BoxFit.cover,
//                                           errorBuilder: (_, __, ___) =>
//                                               Container(
//                                                 height: 220,
//                                                 color: Colors.grey[300],
//                                                 child: const Icon(
//                                                   Icons.image_not_supported,
//                                                   size: 50,
//                                                 ),
//                                               ),
//                                         );
//                                       },
//                                     ),
//                             ),
//                             if (imageList.length > 1)
//                               Positioned(
//                                 bottom: 12,
//                                 right: 12,
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 10,
//                                     vertical: 6,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Colors.black.withOpacity(0.7),
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Text(
//                                     '${_currentImageIndex + 1}/${imageList.length}',
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.name ?? 'Farm House',
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               widget.address ?? '',
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 25),

//                 // ---------- Payment Option ----------
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 8,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Payment Option",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       // Full Payment Radio
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _selectedPaymentOption = 'full';
//                           });
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 12,
//                           ),
//                           decoration: BoxDecoration(
//                             color: _selectedPaymentOption == 'full'
//                                 ? const Color(0xFFFF5A5F).withOpacity(0.05)
//                                 : Colors.transparent,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(
//                               color: _selectedPaymentOption == 'full'
//                                   ? const Color(0xFFFF5A5F)
//                                   : Colors.grey.shade300,
//                               width: _selectedPaymentOption == 'full' ? 2 : 1,
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               Radio(
//                                 value: 'full',
//                                 groupValue: _selectedPaymentOption,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _selectedPaymentOption = value;
//                                   });
//                                 },
//                                 activeColor: const Color(0xFFFF5A5F),
//                               ),
//                               const Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Pay Full Amount",
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     SizedBox(height: 4),
//                                     Text(
//                                       "Pay the complete amount now",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Text(
//                                 "₹${widget.totalAmount}",
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w700,
//                                   color: Color(0xFFFF5A5F),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       // 30% Advance Payment Radio
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _selectedPaymentOption = 'advance';
//                           });
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 12,
//                           ),
//                           decoration: BoxDecoration(
//                             color: _selectedPaymentOption == 'advance'
//                                 ? const Color(0xFFFF5A5F).withOpacity(0.05)
//                                 : Colors.transparent,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(
//                               color: _selectedPaymentOption == 'advance'
//                                   ? const Color(0xFFFF5A5F)
//                                   : Colors.grey.shade300,
//                               width: _selectedPaymentOption == 'advance'
//                                   ? 2
//                                   : 1,
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               Radio(
//                                 value: 'advance',
//                                 groupValue: _selectedPaymentOption,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _selectedPaymentOption = value;
//                                   });
//                                 },
//                                 activeColor: const Color(0xFFFF5A5F),
//                               ),
//                               const Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Pay 30% Advance",
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     SizedBox(height: 4),
//                                     Text(
//                                       "Pay only 30% now, remaining at check-in",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     "₹${(widget.totalAmount * 0.3).round()}",
//                                     style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w700,
//                                       color: Color(0xFFFF5A5F),
//                                     ),
//                                   ),
//                                   Text(
//                                     "Total: ₹${widget.totalAmount}",
//                                     style: TextStyle(
//                                       fontSize: 10,
//                                       color: Colors.grey.shade500,
//                                       decoration: TextDecoration.lineThrough,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 25),

//                 // ---------- Price Details ----------
//                 const Text(
//                   "Price Details",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(height: 12),

//                 _buildPriceRow("Farm House Price", widget.slotPrice.toString()),
//                 _buildPriceRow("Cleaning Fee", widget.cleaningFee.toString()),
//                 _buildPriceRow("Service Fee", widget.serviceFee.toString()),

//                 const Divider(height: 30, thickness: 1),

//                 _buildPriceRow(
//                   "Total Amount",
//                   widget.totalAmount.toString(),
//                   isTotal: true,
//                 ),

//                 if (_selectedPaymentOption == 'advance') ...[
//                   const SizedBox(height: 8),
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade50,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.info_outline,
//                           color: Colors.blue.shade700,
//                           size: 20,
//                         ),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             "You'll pay 30% now (₹${(widget.totalAmount * 0.3).round()}) and remaining ₹${widget.totalAmount - (widget.totalAmount * 0.3).round()} at check-in",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.blue.shade800,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],

//                 const SizedBox(height: 25),

//                 // Payment methods section commented out as before
//               ],
//             ),
//           ),

//           // ---------- Loading Overlay ----------
//           if (_isLoading || _paymentProvider.isLoading)
//             Container(
//               color: Colors.black.withOpacity(0.5),
//               child: const Center(
//                 child: Card(
//                   child: Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         CircularProgressIndicator(color: Color(0xFFFF5A5F)),
//                         SizedBox(height: 16),
//                         Text(
//                           'Opening Payment Gateway...',
//                           style: TextStyle(fontSize: 14),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),

//       // ---------- Bottom Bar ----------
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 8,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   _selectedPaymentOption == 'advance'
//                       ? "Payable Now"
//                       : "Total Amount",
//                   style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
//                 ),
//                 Text(
//                   "₹${payableAmount}",
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.black,
//                   ),
//                 ),
//                 if (_selectedPaymentOption == 'advance')
//                   Text(
//                     "Remaining: ₹${widget.totalAmount - payableAmount}",
//                     style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
//                   ),
//               ],
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 40,
//                   vertical: 14,
//                 ),
//                 backgroundColor: const Color(0xFFFF5A5F),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//               ),
//               onPressed: (_isLoading || _paymentProvider.isLoading)
//                   ? null
//                   : _handlePayPress,
//               child: Text(
//                 _selectedPaymentOption == 'advance'
//                     ? "Pay ₹${payableAmount}"
//                     : "Pay Now",
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Central handler for the "Pay Now" tap
//   void _handlePayPress() async {
//     if (_selectedPaymentOption == null) {
//       _showSnackBar('Please select a payment option', Colors.orange);
//       return;
//     }
//     _openRazorpayCheckout();
//   }

//   void _showCashConfirmDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: const [
//             Icon(Icons.check_circle, color: Colors.green, size: 28),
//             SizedBox(height: 8),
//             Text(
//               'Booking Confirmed',
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//             ),
//           ],
//         ),
//         content: const Text(
//           'Your booking has been confirmed. Please pay cash on arrival.',
//           style: TextStyle(fontSize: 14),
//         ),
//         actions: [
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFFF5A5F),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pop();
//               },
//               child: const Text(
//                 'OK',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ─── Reusable Widgets ────────────────────────────────────────────────────

//   Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: isTotal ? 17 : 15,
//               fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
//               color: Theme.of(context).textTheme.bodyLarge?.color,
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: isTotal ? 18 : 15,
//               fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
//               color: isTotal
//                   ? const Color(0xFFFF5A5F)
//                   : Theme.of(context).textTheme.bodyLarge?.color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentMethod(IconData icon, String title, String method) {
//     bool isSelected = _selectedPaymentMethod == method;

//     return GestureDetector(
//       onTap: () => setState(() => _selectedPaymentMethod = method),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(
//             color: isSelected ? const Color(0xFFFF5A5F) : Colors.grey.shade300,
//             width: isSelected ? 2 : 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               icon,
//               size: 28,
//               color: isSelected ? const Color(0xFFFF5A5F) : Colors.grey[600],
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
//                   color: isSelected ? const Color(0xFFFF5A5F) : Colors.black,
//                 ),
//               ),
//             ),
//             if (isSelected)
//               const Icon(
//                 Icons.check_circle,
//                 color: Color(0xFFFF5A5F),
//                 size: 24,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:farmhouse_app/provider/booking/payment_provider.dart';
import 'package:farmhouse_app/theme/theme_provider.dart';
import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:farmhouse_app/views/auth/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final List<String>? images;
  final String? price;
  final String? name;
  final String? address;
  final int slotPrice;
  final int cleaningFee;
  final int serviceFee;
  final int totalAmount;
  final String slotId;
  final String farmhouseId;

  const PaymentScreen({
    super.key,
    this.images,
    this.price,
    this.name,
    this.address,
    required this.slotPrice,
    required this.cleaningFee,
    required this.serviceFee,
    required this.totalAmount,
    required this.slotId,
    required this.farmhouseId,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  final PaymentProvider _paymentProvider = PaymentProvider();
  String? _selectedPaymentMethod;
  String? _selectedPaymentOption; // 'full' or 'advance'
  bool _isLoading = false;
  int _currentImageIndex = 0;
  String? _userId; // fetched from SharedPrefs
  String? _bookingId; // Store the booking ID from API response

  @override
  void initState() {
    super.initState();
    _initializeRazorpay();
    _fetchUserId();
    // Default to full payment
    _selectedPaymentOption = 'full';
  }

  /// Pulls the logged-in user's ID from SharedPreferences
  Future<void> _fetchUserId() async {
    final user = await SharedPrefs.getUser();
    if (mounted) {
      setState(() {
        _userId = user?.id;
      });
    }
  }

  void _initializeRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  /// Calculate the amount to be paid based on selected option
  int _getPayableAmount() {
    if (_selectedPaymentOption == 'advance') {
      // Calculate 30% of total amount
      return (widget.totalAmount * 0.3).round();
    }
    return widget.totalAmount; // Full amount
  }

  /// NEW FLOW: First create booking, then open Razorpay
  /// NEW FLOW: First create booking, then open Razorpay
  Future<void> _createBookingAndOpenRazorpay() async {
    if (_userId == null) {
      _showSnackBar('User session expired. Please log in again.', Colors.red);
      return;
    }

    if (_selectedPaymentOption == null) {
      _showSnackBar('Please select a payment option', Colors.orange);
      return;
    }

    setState(() => _isLoading = true);

    // Calculate advance payment amount
    // For 'advance' -> pass the 30% amount
    // For 'full' -> pass 0
    int advancePaymentAmount = _selectedPaymentOption == 'advance'
        ? _getPayableAmount() // This returns 30% of total amount
        : 0; // For full payment, pass 0

    print('📝 Creating booking with:');
    print('User ID: $_userId');
    print('Farmhouse ID: ${widget.farmhouseId}');
    print('Slot ID: ${widget.slotId}');
    print('Advance Payment Amount: $advancePaymentAmount');
    print('Payment Option: $_selectedPaymentOption');
    print('Total Amount: ${widget.totalAmount}');
    print('Payable Now: ${_getPayableAmount()}');

    // Step 1: Create booking with pending payment
    final bookingId = await _paymentProvider.createBooking(
      farmhouseId: widget.farmhouseId,
      slotId: widget.slotId,
      advancePayment:
          advancePaymentAmount, // Pass 0 for full, amount for partial
      userId: _userId!,
    );

    // Check if booking was created successfully
    if (bookingId == null) {
      setState(() => _isLoading = false);
      _showSnackBar(
        'Failed to create booking: ${_paymentProvider.errorMessage}',
        Colors.red,
      );
      return;
    }

    // Step 2: Store the booking ID from response
    _bookingId = bookingId;

    // Optional: Get and log booking details using provider getters
    final bookingDetails = _paymentProvider.getBookingDetails();
    final paymentInfo = _paymentProvider.getPaymentInfo();
    final slotInfo = _paymentProvider.getSlotInfo();

    print('✅ Booking created successfully');
    print('📝 Booking ID: $_bookingId');
    print('🏠 Farmhouse: ${_paymentProvider.getFarmhouseName()}');
    print('💰 Payment Info: $paymentInfo');
    print('⏰ Slot Info: $slotInfo');
    print('📦 Full Response: ${_paymentProvider.bookingResponse}');

    // Step 3: Open Razorpay with booking ID
    _openRazorpayCheckout();
  }

  /// Open Razorpay with booking ID in description/notes
  /// Open Razorpay with booking ID in description/notes
  void _openRazorpayCheckout() {
    // Get the amount to pay based on selected option
    int amountToPay =
        _getPayableAmount(); // Returns 30% for advance, full amount for full payment

    // Convert to paise (Razorpay requires amount in paise)
    int amountInPaise = amountToPay * 100;

    print('💰 Opening Razorpay with:');
    print('Amount to Pay: ₹$amountToPay');
    print('Amount in Paise: $amountInPaise');
    print('Payment Option: $_selectedPaymentOption');
    print('Booking ID: $_bookingId');

    // Get Razorpay key from environment or constants
    const razorpayKey = 'rzp_live_R7WEc7UNXkN075'; // Your live key

    var options = {
      'key': razorpayKey,
      'amount': amountInPaise,
      'currency': 'INR',
      'name': 'Farmhouse Booking',
      'description': 'Booking ID: ${_bookingId ?? "N/A"}',
      'notes': {'bookingId': _bookingId},
      'prefill': {
        'contact': '6303092897',
        'email': 'info@pixelmindsolutions.com',
      },
      'theme': {'color': '#FF5A5F'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Error opening payment gateway: $e', Colors.red);

      // Cancel pending booking if Razorpay fails to open
      _cancelPendingBooking();
    }
  }

  Future<void> _cancelPendingBooking() async {
    if (_bookingId != null && _userId != null) {
      print('🔄 Cancelling pending booking: $_bookingId');
      final cancelled = await _paymentProvider.cancelBooking(
        bookingId: _bookingId!,
        userId: _userId!,
      );
      if (cancelled) {
        print('✅ Pending booking cancelled: $_bookingId');
        setState(() {
          _bookingId = null;
        });
      } else {
        print('⚠️ Failed to cancel booking: $_bookingId');
      }
    }
  }

  /// Called by Razorpay on success
  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print('✅ Razorpay Success - Payment ID: ${response.paymentId}');
    print('✅ Booking ID: $_bookingId');

    setState(() => _isLoading = false);

    // Optional: If you have a confirm payment API, call it here
    // await _paymentProvider.confirmPayment(
    //   bookingId: _bookingId!,
    //   transactionId: response.paymentId ?? '',
    // );

    // Show success dialog
    _showSuccessDialog(response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() => _isLoading = false);
    _showSnackBar('Payment Failed: ${response.message}', Colors.red);

    _cancelPendingBooking();

    // Optional: You might want to delete the pending booking here
    // Or show a message that booking is pending payment
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() => _isLoading = false);
    _showSnackBar('External Wallet: ${response.walletName}', Colors.blueGrey);
  }

  // ─── Reusable helpers ────────────────────────────────────────────────────

  void _showSnackBar(String message, Color color) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessDialog(String? paymentId) {
    if (!mounted) return;

    String paymentMessage = _selectedPaymentOption == 'advance'
        ? 'Your 30% advance payment has been received. Remaining balance to be paid at check-in.'
        : 'Your full payment has been received. Your booking is confirmed.';

    String bookingInfo = '\n\nBooking ID: ${_bookingId ?? 'N/A'}';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Payment Successful',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text(
                'Payment ID',
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                paymentId ?? 'N/A',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                'Booking ID',
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                _bookingId ?? 'N/A',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Text(paymentMessage, style: const TextStyle(fontSize: 14)),
              if (_selectedPaymentOption == 'advance') ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.orange.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Remaining balance: ₹${widget.totalAmount - _getPayableAmount()} to be paid at check-in',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange.shade800,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5A5F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const NavbarScreen()),
                  (route) => false,
                );
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    _paymentProvider.reset();
    super.dispose();
  }

  // ─── BUILD ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final List<String> imageList = widget.images ?? [];
    final int payableAmount = _getPayableAmount();

    return WillPopScope(
      onWillPop: () async {
        // If there's a pending booking, cancel it
        if (_bookingId != null && _userId != null) {
          await _cancelPendingBooking();
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text(
            "Payment",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------- Farmhouse Card ----------
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Gallery
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 220,
                                child: imageList.isEmpty
                                    ? Container(
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: Icon(
                                            Icons.image_not_supported,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      )
                                    : PageView.builder(
                                        itemCount: imageList.length,
                                        onPageChanged: (index) {
                                          setState(
                                            () => _currentImageIndex = index,
                                          );
                                        },
                                        itemBuilder: (context, index) {
                                          return Image.network(
                                            imageList[index],
                                            height: 220,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) =>
                                                Container(
                                                  height: 220,
                                                  color: Colors.grey[300],
                                                  child: const Icon(
                                                    Icons.image_not_supported,
                                                    size: 50,
                                                  ),
                                                ),
                                          );
                                        },
                                      ),
                              ),
                              if (imageList.length > 1)
                                Positioned(
                                  bottom: 12,
                                  right: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      '${_currentImageIndex + 1}/${imageList.length}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name ?? 'Farm House',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.address ?? '',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ---------- Payment Option ----------
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Payment Option",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Full Payment Radio
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPaymentOption = 'full';
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedPaymentOption == 'full'
                                  ? const Color(0xFFFF5A5F).withOpacity(0.05)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selectedPaymentOption == 'full'
                                    ? const Color(0xFFFF5A5F)
                                    : Colors.grey.shade300,
                                width: _selectedPaymentOption == 'full' ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Radio(
                                  value: 'full',
                                  groupValue: _selectedPaymentOption,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedPaymentOption = value;
                                    });
                                  },
                                  activeColor: const Color(0xFFFF5A5F),
                                ),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pay Full Amount",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Pay the complete amount now",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "₹${widget.totalAmount}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFFF5A5F),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // 30% Advance Payment Radio
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPaymentOption = 'advance';
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedPaymentOption == 'advance'
                                  ? const Color(0xFFFF5A5F).withOpacity(0.05)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selectedPaymentOption == 'advance'
                                    ? const Color(0xFFFF5A5F)
                                    : Colors.grey.shade300,
                                width: _selectedPaymentOption == 'advance'
                                    ? 2
                                    : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Radio(
                                  value: 'advance',
                                  groupValue: _selectedPaymentOption,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedPaymentOption = value;
                                    });
                                  },
                                  activeColor: const Color(0xFFFF5A5F),
                                ),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pay 30% Advance",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Pay only 30% now, remaining at check-in",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "₹${(widget.totalAmount * 0.3).round()}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFFFF5A5F),
                                      ),
                                    ),
                                    Text(
                                      "Total: ₹${widget.totalAmount}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey.shade500,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ---------- Price Details ----------
                  const Text(
                    "Price Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),

                  _buildPriceRow(
                    "Farm House Price",
                    widget.slotPrice.toString(),
                  ),
                  _buildPriceRow("Cleaning Fee", widget.cleaningFee.toString()),
                  _buildPriceRow("Service Fee", widget.serviceFee.toString()),

                  const Divider(height: 30, thickness: 1),

                  _buildPriceRow(
                    "Total Amount",
                    widget.totalAmount.toString(),
                    isTotal: true,
                  ),

                  if (_selectedPaymentOption == 'advance') ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.blue.shade700,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "You'll pay 30% now (₹${(widget.totalAmount * 0.3).round()}) and remaining ₹${widget.totalAmount - (widget.totalAmount * 0.3).round()} at check-in",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 25),
                ],
              ),
            ),

            // ---------- Loading Overlay ----------
            if (_isLoading || _paymentProvider.isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(color: Color(0xFFFF5A5F)),
                          SizedBox(height: 16),
                          Text(
                            'Creating booking...',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),

        // ---------- Bottom Bar ----------
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedPaymentOption == 'advance'
                        ? "Payable Now"
                        : "Total Amount",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  Text(
                    "₹${payableAmount}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  if (_selectedPaymentOption == 'advance')
                    Text(
                      "Remaining: ₹${widget.totalAmount - payableAmount}",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  backgroundColor: const Color(0xFFFF5A5F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: (_isLoading || _paymentProvider.isLoading)
                    ? null
                    : _handlePayPress,
                child: Text(
                  _selectedPaymentOption == 'advance'
                      ? "Pay ₹${payableAmount}"
                      : "Pay Now",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Central handler for the "Pay Now" tap
  void _handlePayPress() async {
    if (_selectedPaymentOption == null) {
      _showSnackBar('Please select a payment option', Colors.orange);
      return;
    }

    // New flow: First create booking, then open Razorpay
    await _createBookingAndOpenRazorpay();
  }

  // ─── Reusable Widgets ────────────────────────────────────────────────────

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 17 : 15,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 15,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
              color: isTotal
                  ? const Color(0xFFFF5A5F)
                  : Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(IconData icon, String title, String method) {
    bool isSelected = _selectedPaymentMethod == method;

    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = method),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF5A5F) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected ? const Color(0xFFFF5A5F) : Colors.grey[600],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: isSelected ? const Color(0xFFFF5A5F) : Colors.black,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFFFF5A5F),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
