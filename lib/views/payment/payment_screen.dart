// // import 'package:flutter/material.dart';
// // import 'package:razorpay_flutter/razorpay_flutter.dart';

// // class PaymentScreen extends StatefulWidget {
// //   final String? image;
// //   final String? price;
// //   final String? name;
// //   const PaymentScreen({super.key, this.image, this.price, this.name});

// //   @override
// //   State<PaymentScreen> createState() => _PaymentScreenState();
// // }

// // class _PaymentScreenState extends State<PaymentScreen> {
// //   late Razorpay _razorpay;
// //   String? _selectedPaymentMethod;
// //   bool _isLoading = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializeRazorpay();
// //   }

// //   void _initializeRazorpay() {
// //     _razorpay = Razorpay();
// //     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
// //     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
// //     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
// //   }

// //   void _handlePaymentSuccess(PaymentSuccessResponse response) {
// //     setState(() => _isLoading = false);

// //     showDialog(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (context) => AlertDialog(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //         title: Row(
// //           children: const [
// //             Icon(Icons.check_circle, color: Colors.green, size: 28),
// //             SizedBox(width: 10),
// //             Expanded(
// //               child: Text(
// //                 'Payment Successful',
// //                 style: TextStyle(fontWeight: FontWeight.w600),
// //               ),
// //             ),
// //           ],
// //         ),
// //         content: SingleChildScrollView(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               const SizedBox(height: 8),
// //               Text(
// //                 'Payment ID',
// //                 style: TextStyle(fontSize: 13, color: Colors.grey[600]),
// //               ),
// //               const SizedBox(height: 4),
// //               Text(
// //                 response.paymentId ?? 'N/A',
// //                 style: const TextStyle(fontWeight: FontWeight.w600),
// //               ),
// //               const SizedBox(height: 12),
// //               const Text(
// //                 'Your booking has been confirmed successfully.',
// //                 style: TextStyle(fontSize: 14),
// //               ),
// //             ],
// //           ),
// //         ),
// //         actionsPadding: const EdgeInsets.symmetric(
// //           horizontal: 16,
// //           vertical: 12,
// //         ),
// //         actions: [
// //           SizedBox(
// //             width: double.infinity,
// //             height: 45,
// //             child: ElevatedButton(
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: const Color(0xFFFF5A5F),
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //               ),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //                 Navigator.of(context).pop();
// //               },
// //               child: const Text(
// //                 'OK',
// //                 style: TextStyle(
// //                   color: Colors.white,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );

// //     debugPrint('Payment Success: ${response.paymentId}');
// //   }

// //   void _handlePaymentError(PaymentFailureResponse response) {
// //     setState(() => _isLoading = false);

// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text('Payment Failed: ${response.message}'),
// //         backgroundColor: Colors.red,
// //         behavior: SnackBarBehavior.floating,
// //         duration: const Duration(seconds: 3),
// //       ),
// //     );

// //     debugPrint('Payment Error: ${response.code} - ${response.message}');
// //   }

// //   void _handleExternalWallet(ExternalWalletResponse response) {
// //     setState(() => _isLoading = false);

// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text('External Wallet: ${response.walletName}'),
// //         behavior: SnackBarBehavior.floating,
// //       ),
// //     );

// //     debugPrint('External Wallet: ${response.walletName}');
// //   }

// //   void _openRazorpayCheckout() {
// //     String priceStr = widget.price ?? '7800';
// //     priceStr = priceStr.replaceAll('₹', '').replaceAll(',', '').trim();

// //     int amountInPaise = (double.parse(priceStr) * 100).toInt();

// //     var options = {
// //       'key': 'rzp_test_BxtRNvflG06PTV',
// //       'amount': amountInPaise,
// //       'name': 'Farm House',
// //       'description': '${widget.name ?? "Farm House"} - Calicut, Kerala',
// //       'prefill': {'contact': '9961593179', 'email': 'booking@farmhouse.com'},
// //       'theme': {'color': '#FF5A5F'},
// //     };

// //     try {
// //       setState(() => _isLoading = true);
// //       _razorpay.open(options);
// //     } catch (e) {
// //       setState(() => _isLoading = false);
// //       debugPrint('Error opening Razorpay: $e');
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Error: $e'),
// //           backgroundColor: Colors.red,
// //           behavior: SnackBarBehavior.floating,
// //         ),
// //       );
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _razorpay.clear();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     print('priceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee ${widget.price}');
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF7F8FA),
// //       appBar: AppBar(
// //         title: const Text(
// //           "Payment",
// //           style: TextStyle(fontWeight: FontWeight.w600),
// //         ),
// //         leading: IconButton(
// //           onPressed: () {
// //             Navigator.of(context).pop();
// //           },
// //           icon: const Icon(Icons.arrow_back_ios),
// //         ),
// //         centerTitle: true,
// //         elevation: 0,
// //         backgroundColor: Colors.white,
// //         foregroundColor: Colors.black,
// //       ),
// //       body: Stack(
// //         children: [
// //           SingleChildScrollView(
// //             padding: const EdgeInsets.all(16),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 // ---------- Farmhouse Card ----------
// //                 Container(
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(18),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.black.withOpacity(0.08),
// //                         blurRadius: 10,
// //                         offset: const Offset(0, 4),
// //                       ),
// //                     ],
// //                   ),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       ClipRRect(
// //                         borderRadius: const BorderRadius.only(
// //                           topLeft: Radius.circular(18),
// //                           topRight: Radius.circular(18),
// //                         ),
// //                         child: _buildImage(widget.image.toString()),
// //                       ),
// //                       Padding(
// //                         padding: const EdgeInsets.all(16),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               '${widget.name}',
// //                               style: const TextStyle(
// //                                 fontSize: 20,
// //                                 fontWeight: FontWeight.w700,
// //                               ),
// //                             ),
// //                             const SizedBox(height: 4),
// //                             const Text(
// //                               "Calicut, Kerala",
// //                               style: TextStyle(
// //                                 color: Colors.grey,
// //                                 fontSize: 14,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //                 const SizedBox(height: 25),

// //                 // ---------- Price Details ----------
// //                 const Text(
// //                   "Price Details",
// //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
// //                 ),
// //                 const SizedBox(height: 12),

// //                 _buildPriceRow("Farm House Price", "₹7,000"),
// //                 _buildPriceRow("Cleaning Fee", "₹500"),
// //                 _buildPriceRow("Service Fee", "₹300"),

// //                 const Divider(height: 30, thickness: 1),

// //                 _buildPriceRow("Total Amount", "₹7,800", isTotal: true),

// //                 const SizedBox(height: 25),

// //                 const Text(
// //                   "Payment Method",
// //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
// //                 ),
// //                 const SizedBox(height: 12),

// //                 _buildPaymentMethod(
// //                   Icons.credit_card,
// //                   "Credit / Debit Card",
// //                   "card",
// //                 ),
// //                 const SizedBox(height: 10),
// //                 _buildPaymentMethod(
// //                   Icons.account_balance_wallet,
// //                   "UPI / Wallet",
// //                   "upi",
// //                 ),
// //                 const SizedBox(height: 10),
// //                 _buildPaymentMethod(
// //                   Icons.currency_rupee,
// //                   "Cash on Arrival",
// //                   "cash",
// //                 ),

// //                 const SizedBox(height: 100),
// //               ],
// //             ),
// //           ),

// //           // Loading overlay
// //           if (_isLoading)
// //             Container(
// //               color: Colors.black.withOpacity(0.5),
// //               child: const Center(
// //                 child: Card(
// //                   child: Padding(
// //                     padding: EdgeInsets.all(20),
// //                     child: Column(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         CircularProgressIndicator(color: Color(0xFFFF5A5F)),
// //                         SizedBox(height: 16),
// //                         Text(
// //                           'Opening Payment Gateway...',
// //                           style: TextStyle(fontSize: 14),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //         ],
// //       ),

// //       // ---------- Bottom Bar ----------
// //       bottomNavigationBar: Container(
// //         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withOpacity(0.05),
// //               blurRadius: 8,
// //               offset: const Offset(0, -2),
// //             ),
// //           ],
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             const Text(
// //               "₹7,800",
// //               style: TextStyle(
// //                 fontSize: 22,
// //                 fontWeight: FontWeight.w700,
// //                 color: Colors.black,
// //               ),
// //             ),
// //             ElevatedButton(
// //               style: ElevatedButton.styleFrom(
// //                 padding: const EdgeInsets.symmetric(
// //                   horizontal: 40,
// //                   vertical: 14,
// //                 ),
// //                 backgroundColor: const Color(0xFFFF5A5F),
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(14),
// //                 ),
// //               ),
// //               onPressed: _isLoading
// //                   ? null
// //                   : () {
// //                       if (_selectedPaymentMethod == null) {
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           const SnackBar(
// //                             content: Text('Please select a payment method'),
// //                             behavior: SnackBarBehavior.floating,
// //                             backgroundColor: Colors.orange,
// //                           ),
// //                         );
// //                         return;
// //                       }

// //                       if (_selectedPaymentMethod == 'cash') {
// //                         // Handle cash on arrival
// //                         showDialog(
// //                           context: context,
// //                           barrierDismissible: false,
// //                           builder: (context) => AlertDialog(
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(16),
// //                             ),
// //                             title: Column(
// //                               mainAxisSize: MainAxisSize.min,
// //                               crossAxisAlignment: CrossAxisAlignment.center,
// //                               children: const [
// //                                 Icon(
// //                                   Icons.check_circle,
// //                                   color: Colors.green,
// //                                   size: 28,
// //                                 ),
// //                                 SizedBox(height: 8),
// //                                 Text(
// //                                   'Booking Confirmed',
// //                                   style: TextStyle(
// //                                     fontWeight: FontWeight.w600,
// //                                     fontSize: 16,
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),

// //                             content: const Text(
// //                               'Your booking has been confirmed. Please pay cash on arrival.',
// //                               style: TextStyle(fontSize: 14),
// //                             ),
// //                             actions: [
// //                               SizedBox(
// //                                 width: double.infinity,
// //                                 child: ElevatedButton(
// //                                   style: ElevatedButton.styleFrom(
// //                                     backgroundColor: const Color(0xFFFF5A5F),
// //                                     shape: RoundedRectangleBorder(
// //                                       borderRadius: BorderRadius.circular(12),
// //                                     ),
// //                                   ),
// //                                   onPressed: () {
// //                                     Navigator.of(context).pop();
// //                                     Navigator.of(context).pop();
// //                                   },
// //                                   child: const Text(
// //                                     'OK',
// //                                     style: TextStyle(
// //                                       color: Colors.white,
// //                                       fontWeight: FontWeight.w600,
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         );
// //                       } else {
// //                         _openRazorpayCheckout();
// //                       }
// //                     },
// //               child: const Text(
// //                 "Pay Now",
// //                 style: TextStyle(
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.w700,
// //                   color: Colors.white,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildImage(String image) {
// //     final bool isNetworkImage = image.startsWith('http');

// //     return isNetworkImage
// //         ? Image.network(
// //             image,
// //             height: 180,
// //             width: double.infinity,
// //             fit: BoxFit.cover,
// //             errorBuilder: (context, error, stackTrace) {
// //               return Container(
// //                 height: 180,
// //                 color: Colors.grey[300],
// //                 child: const Icon(Icons.image_not_supported, size: 50),
// //               );
// //             },
// //           )
// //         : Image.asset(
// //             image,
// //             height: 180,
// //             width: double.infinity,
// //             fit: BoxFit.cover,
// //             errorBuilder: (context, error, stackTrace) {
// //               return Container(
// //                 height: 180,
// //                 color: Colors.grey[300],
// //                 child: const Icon(Icons.image_not_supported, size: 50),
// //               );
// //             },
// //           );
// //   }

// //   // ---------------- Reusable Widgets ----------------
// //   Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 6),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(
// //             label,
// //             style: TextStyle(
// //               fontSize: isTotal ? 17 : 15,
// //               fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
// //             ),
// //           ),
// //           Text(
// //             value,
// //             style: TextStyle(
// //               fontSize: isTotal ? 18 : 15,
// //               fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
// //               color: isTotal ? const Color(0xFFFF5A5F) : Colors.black,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildPaymentMethod(IconData icon, String title, String method) {
// //     bool isSelected = _selectedPaymentMethod == method;

// //     return GestureDetector(
// //       onTap: () {
// //         setState(() {
// //           _selectedPaymentMethod = method;
// //         });
// //       },
// //       child: Container(
// //         padding: const EdgeInsets.all(16),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(14),
// //           border: Border.all(
// //             color: isSelected ? const Color(0xFFFF5A5F) : Colors.grey.shade300,
// //             width: isSelected ? 2 : 1,
// //           ),
// //         ),
// //         child: Row(
// //           children: [
// //             Icon(
// //               icon,
// //               size: 28,
// //               color: isSelected ? const Color(0xFFFF5A5F) : Colors.grey[600],
// //             ),
// //             const SizedBox(width: 16),
// //             Expanded(
// //               child: Text(
// //                 title,
// //                 style: TextStyle(
// //                   fontSize: 16,
// //                   fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
// //                   color: isSelected ? const Color(0xFFFF5A5F) : Colors.black,
// //                 ),
// //               ),
// //             ),
// //             if (isSelected)
// //               const Icon(
// //                 Icons.check_circle,
// //                 color: Color(0xFFFF5A5F),
// //                 size: 24,
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class PaymentScreen extends StatefulWidget {
//   final List<String>? images;
//   final String? price;
//   final String? name;
//   final String?address;

//   const PaymentScreen({super.key, this.images, this.price, this.name,this.address});

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   late Razorpay _razorpay;
//   String? _selectedPaymentMethod;
//   bool _isLoading = false;
//   int _currentImageIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _initializeRazorpay();
//   }

//   void _initializeRazorpay() {
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     setState(() => _isLoading = false);

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
//                 response.paymentId ?? 'N/A',
//                 style: const TextStyle(fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(height: 12),
//               const Text(
//                 'Your booking has been confirmed successfully.',
//                 style: TextStyle(fontSize: 14),
//               ),
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

//     debugPrint('Payment Success: ${response.paymentId}');
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     setState(() => _isLoading = false);

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Payment Failed: ${response.message}'),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//         duration: const Duration(seconds: 3),
//       ),
//     );

//     debugPrint('Payment Error: ${response.code} - ${response.message}');
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     setState(() => _isLoading = false);

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('External Wallet: ${response.walletName}'),
//         behavior: SnackBarBehavior.floating,
//       ),
//     );

//     debugPrint('External Wallet: ${response.walletName}');
//   }

//   void _openRazorpayCheckout() {
//     String priceStr = widget.price ?? '0';
//     priceStr = priceStr.replaceAll('₹', '').replaceAll(',', '').trim();

//     int amountInPaise = (double.parse(priceStr) * 100).toInt();

//     var options = {
//       'key': 'rzp_test_BxtRNvflG06PTV',
//       'amount': amountInPaise,
//       'name': 'Farm House',
//       'description': '${widget.name ?? "Farm House"} - Calicut, Kerala',
//       'prefill': {'contact': '9961593179', 'email': 'booking@farmhouse.com'},
//       'theme': {'color': '#FF5A5F'},
//     };

//     try {
//       setState(() => _isLoading = true);
//       _razorpay.open(options);
//     } catch (e) {
//       setState(() => _isLoading = false);
//       debugPrint('Error opening Razorpay: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: $e'),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//     }
//   }

//   double _calculateTotal() {
//     String priceStr = widget.price ?? '0';
//     priceStr = priceStr.replaceAll('₹', '').replaceAll(',', '').trim();
//     double basePrice = double.tryParse(priceStr) ?? 0;
//     double cleaningFee = 500;
//     double serviceFee = 300;
//     return basePrice + cleaningFee + serviceFee;
//   }

//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<String> imageList = widget.images ?? [];
//     final double totalAmount = _calculateTotal();

//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F8FA),
//       appBar: AppBar(
//         title: const Text(
//           "Payment",
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
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
//                       // Image Gallery with PageView
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
//                                         setState(() {
//                                           _currentImageIndex = index;
//                                         });
//                                       },
//                                       itemBuilder: (context, index) {
//                                         return Image.network(
//                                           imageList[index],
//                                           height: 220,
//                                           width: double.infinity,
//                                           fit: BoxFit.cover,
//                                           errorBuilder: (context, error, stackTrace) {
//                                             return Container(
//                                               height: 220,
//                                               color: Colors.grey[300],
//                                               child: const Icon(
//                                                 Icons.image_not_supported,
//                                                 size: 50,
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       },
//                                     ),
//                             ),
//                             // Image indicator
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
//                              Text(
//                               "${widget.address}",
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

//                 // ---------- Price Details ----------
//                 const Text(
//                   "Price Details",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(height: 12),

//                 _buildPriceRow("Farm House Price", widget.price ?? '₹0'),
//                 _buildPriceRow("Cleaning Fee", "₹500"),
//                 _buildPriceRow("Service Fee", "₹300"),

//                 const Divider(height: 30, thickness: 1),

//                 _buildPriceRow(
//                   "Total Amount",
//                   "₹${totalAmount.toStringAsFixed(0)}",
//                   isTotal: true,
//                 ),

//                 const SizedBox(height: 25),

//                 const Text(
//                   "Payment Method",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(height: 12),

//                 _buildPaymentMethod(
//                   Icons.credit_card,
//                   "Credit / Debit Card",
//                   "card",
//                 ),
//                 const SizedBox(height: 10),
//                 _buildPaymentMethod(
//                   Icons.account_balance_wallet,
//                   "UPI / Wallet",
//                   "upi",
//                 ),
//                 const SizedBox(height: 10),
//                 _buildPaymentMethod(
//                   Icons.currency_rupee,
//                   "Cash on Arrival",
//                   "cash",
//                 ),

//                 const SizedBox(height: 100),
//               ],
//             ),
//           ),

//           // Loading overlay
//           if (_isLoading)
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
//             Text(
//               "₹${totalAmount.toStringAsFixed(0)}",
//               style: const TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black,
//               ),
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
//               onPressed: _isLoading
//                   ? null
//                   : () {
//                       if (_selectedPaymentMethod == null) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Please select a payment method'),
//                             behavior: SnackBarBehavior.floating,
//                             backgroundColor: Colors.orange,
//                           ),
//                         );
//                         return;
//                       }

//                       if (_selectedPaymentMethod == 'cash') {
//                         // Handle cash on arrival
//                         showDialog(
//                           context: context,
//                           barrierDismissible: false,
//                           builder: (context) => AlertDialog(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             title: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: const [
//                                 Icon(
//                                   Icons.check_circle,
//                                   color: Colors.green,
//                                   size: 28,
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   'Booking Confirmed',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             content: const Text(
//                               'Your booking has been confirmed. Please pay cash on arrival.',
//                               style: TextStyle(fontSize: 14),
//                             ),
//                             actions: [
//                               SizedBox(
//                                 width: double.infinity,
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: const Color(0xFFFF5A5F),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: const Text(
//                                     'OK',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       } else {
//                         _openRazorpayCheckout();
//                       }
//                     },
//               child: const Text(
//                 "Pay Now",
//                 style: TextStyle(
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

//   // ---------------- Reusable Widgets ----------------
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
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: isTotal ? 18 : 15,
//               fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
//               color: isTotal ? const Color(0xFFFF5A5F) : Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentMethod(IconData icon, String title, String method) {
//     bool isSelected = _selectedPaymentMethod == method;

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedPaymentMethod = method;
//         });
//       },
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
import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final List<String>? images;
  final String? price;
  final String? name;
  final String? address;
  final String
  verificationId; // ← pass this in from the slot-verification response

  const PaymentScreen({
    super.key,
    this.images,
    this.price,
    this.name,
    this.address,
    required this.verificationId,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  final PaymentProvider _paymentProvider = PaymentProvider();
  String? _selectedPaymentMethod;
  bool _isLoading = false;
  int _currentImageIndex = 0;
  String? _userId; // fetched from SharedPrefs

  @override
  void initState() {
    super.initState();
    _initializeRazorpay();
    _fetchUserId();
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

  /// Called by Razorpay on success → hands off to the provider
  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    setState(() => _isLoading = false);

    if (_userId == null) {
      _showSnackBar('User session expired. Please log in again.', Colors.red);
      return;
    }

    // Hand the transaction ID + verification ID to the provider
    await _paymentProvider.createPayment(
      verificationId: widget.verificationId,
      transactionId: response.paymentId ?? '',
      userId: _userId!,
    );

    print(
      'transaaaaaaaaaaaaaaaaaaaaaaaaactionnnnnnnnnnnnn iddddddddddddddd ${response.paymentId}',
    );

    // Provider already called notifyListeners; check the result
    if (_paymentProvider.status == PaymentStatus.success) {
      _showSuccessDialog(response.paymentId);
    } else {
      _showSnackBar(
        'Payment recorded but server error: ${_paymentProvider.errorMessage}',
        Colors.red,
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() => _isLoading = false);
    _showSnackBar('Payment Failed: ${response.message}', Colors.red);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() => _isLoading = false);
    _showSnackBar('External Wallet: ${response.walletName}', Colors.blueGrey);
  }

  void _openRazorpayCheckout() {
    if (_userId == null) {
      _showSnackBar('User session expired. Please log in again.', Colors.red);
      return;
    }

    String priceStr = widget.price ?? '0';
    priceStr = priceStr.replaceAll('₹', '').replaceAll(',', '').trim();
    int amountInPaise = (double.parse(priceStr) * 100).toInt();

    var options = {
      'key': 'rzp_test_BxtRNvflG06PTV',
      'amount': amountInPaise,
      'name': 'Farm House',
      'description': '${widget.name ?? "Farm House"} - Calicut, Kerala',
      'prefill': {'contact': '9961593179', 'email': 'booking@farmhouse.com'},
      'theme': {'color': '#FF5A5F'},
    };

    try {
      setState(() => _isLoading = true);
      _razorpay.open(options);
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Error: $e', Colors.red);
    }
  }

  double _calculateTotal() {
    String priceStr = widget.price ?? '0';
    priceStr = priceStr.replaceAll('₹', '').replaceAll(',', '').trim();
    double basePrice = double.tryParse(priceStr) ?? 0;
    return basePrice + 500 + 300; // cleaning + service fee
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
              const SizedBox(height: 12),
              const Text(
                'Your booking has been confirmed successfully.',
                style: TextStyle(fontSize: 14),
              ),
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
                Navigator.of(context).pop(); // close PaymentScreen
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
    final List<String> imageList = widget.images ?? [];
    final double totalAmount = _calculateTotal();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
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

                // ---------- Price Details ----------
                const Text(
                  "Price Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                _buildPriceRow("Farm House Price", widget.price ?? '₹0'),
                _buildPriceRow("Cleaning Fee", "₹500"),
                _buildPriceRow("Service Fee", "₹300"),

                const Divider(height: 30, thickness: 1),

                _buildPriceRow(
                  "Total Amount",
                  "₹${totalAmount.toStringAsFixed(0)}",
                  isTotal: true,
                ),

                const SizedBox(height: 25),

                // ---------- Payment Methods ----------
                const Text(
                  "Payment Method",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                _buildPaymentMethod(
                  Icons.credit_card,
                  "Credit / Debit Card",
                  "card",
                ),
                const SizedBox(height: 10),
                _buildPaymentMethod(
                  Icons.account_balance_wallet,
                  "UPI / Wallet",
                  "upi",
                ),
                const SizedBox(height: 10),
                _buildPaymentMethod(
                  Icons.currency_rupee,
                  "Cash on Arrival",
                  "cash",
                ),

                const SizedBox(height: 100),
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
                          'Opening Payment Gateway...',
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
            Text(
              "₹${totalAmount.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
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
              child: const Text(
                "Pay Now",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Central handler for the "Pay Now" tap
  void _handlePayPress() {
    if (_selectedPaymentMethod == null) {
      _showSnackBar('Please select a payment method', Colors.orange);
      return;
    }

    if (_selectedPaymentMethod == 'cash') {
      _showCashConfirmDialog();
    } else {
      _openRazorpayCheckout();
    }
  }

  void _showCashConfirmDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(height: 8),
            Text(
              'Booking Confirmed',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ],
        ),
        content: const Text(
          'Your booking has been confirmed. Please pay cash on arrival.',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5A5F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
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
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 15,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
              color: isTotal ? const Color(0xFFFF5A5F) : Colors.black,
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
