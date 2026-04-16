import 'package:farmhouse_app/provider/auth/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? userId;
  late Razorpay _razorpay;

  Map<String, List<dynamic>> bookingsData = {
    'upcoming': [],
    'active': [],
    'completed': [],
    'canceled': [],
  };

  bool isLoading = true;
  String? _processingBookingId;
  bool _isProcessingPayment = false;
  bool _isRazorpayInitialized = false; // Add this flag

  @override
  void initState() {
    super.initState();
    _initializeRazorpay();
    _initialize();
  }

  void _initializeRazorpay() {
    try {
      _razorpay = Razorpay();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
      _isRazorpayInitialized = true;
      print('✅ Razorpay initialized successfully');
    } catch (e) {
      print('❌ Error initializing Razorpay: $e');
      _isRazorpayInitialized = false;
    }
  }

  @override
  void dispose() {
    if (_isRazorpayInitialized) {
      try {
        _razorpay.clear();
      } catch (e) {
        print('Error clearing Razorpay: $e');
      }
    }
    super.dispose();
  }

  Future<void> _initialize() async {
    await _loadProfileData();
    if (userId != null) {
      await _fetchAllBookings();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadProfileData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loadUserFromPrefs();

    final user = authProvider.user;
    if (user != null) {
      setState(() {
        userId = user.id;
      });
    }
  }

  Future<void> _fetchAllBookings() async {
    if (userId == null) return;

    setState(() {
      isLoading = true;
    });

    final statuses = ['upcoming', 'active', 'completed', 'canceled'];

    for (String status in statuses) {
      try {
        final response = await http.get(
          Uri.parse(
            'http://31.97.206.144:5124/api/order/all?userId=$userId&status=$status',
          ),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['success'] == true) {
            setState(() {
              bookingsData[status] = data['bookings'] ?? [];
            });
          }
        }
      } catch (e) {
        debugPrint('Error fetching $status bookings: $e');
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  // ─── Razorpay Payment Integration (Same as PaymentScreen) ────────────────

  Future<void> _processRemainingPayment(
    String bookingId,
    int remainingAmount,
  ) async {
    if (userId == null) {
      _showSnackBar('User session expired. Please log in again.', Colors.red);
      return;
    }

    // Check if Razorpay is initialized
    if (!_isRazorpayInitialized) {
      _showSnackBar('Payment system not ready. Please try again.', Colors.red);
      return;
    }

    setState(() {
      _processingBookingId = bookingId;
      _isProcessingPayment = true;
    });

    try {
      // Call complete-payment API to get order details
      // final response = await http.post(
      //   Uri.parse(
      //     'http://31.97.206.144:5124/api/order/complete-payment/$userId/$bookingId',
      //   ),
      //   headers: {'Content-Type': 'application/json'},
      //   body: json.encode({'remainingAmount': remainingAmount}),
      // );

      // print('📝 Complete Payment API Response Status: ${response.statusCode}');
      // print('📝 Complete Payment API Response Body: ${response.body}');

      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   final data = json.decode(response.body);

      //   if (data['success'] == true) {
      //     // Get Razorpay order details from response
      //     final razorpayOrderId = data['bookingId'];
      //     final razorpayKey = data['razorpayKey'] ?? 'rzp_live_R7WEc7UNXkN075';
      //     final amount = data['amountToPay'] ?? remainingAmount * 100;

      //     print('✅ Razorpay Order Created: $razorpayOrderId');
      //     print('💰 Amount to Pay: ₹${amount / 100}');

      //     // Open Razorpay checkout
      //     _openRazorpayCheckout(
      //       razorpayKey: razorpayKey,
      //       razorpayOrderId: razorpayOrderId,
      //       amount: amount,
      //       bookingId: bookingId,
      //     );
      //   } else {
      //     _showSnackBar(
      //       data['message'] ?? 'Failed to initiate payment',
      //       Colors.red,
      //     );
      //     setState(() {
      //       _isProcessingPayment = false;
      //       _processingBookingId = null;
      //     });
      //   }
      // } else {
      //   final data = json.decode(response.body);
      //   _showSnackBar(
      //     data['message'] ?? 'Failed to initiate payment',
      //     Colors.red,
      //   );
      //   setState(() {
      //     _isProcessingPayment = false;
      //     _processingBookingId = null;
      //   });
      // }

      final response = await http.post(
        Uri.parse(
          'http://31.97.206.144:5124/api/order/complete-payment/$userId/$bookingId',
        ),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'remainingAmount': remainingAmount}),
      );

      print('📝 Complete Payment API Response Status: ${response.statusCode}');
      print('📝 Complete Payment API Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          // Get amount from response
          String amountToPayStr =
              data['amountToPay']?.toString() ?? remainingAmount.toString();

          String cleanAmount = amountToPayStr.replaceAll(
            RegExp(r'[^0-9.]'),
            '',
          );

          // Parse to double and then to int (for paise conversion)
          double amountToPayDouble =
              double.tryParse(cleanAmount) ?? remainingAmount.toDouble();
          int amountToPay = amountToPayDouble.round();

          // Convert to paise (Razorpay requires amount in paise)
          final amountInPaise = (amountToPay * 100).round();

          print('💰 Original Amount String: $amountToPayStr');
          print('💰 Cleaned Amount: $amountToPay');
          print('💰 Amount in Paise: $amountInPaise');

          // Open Razorpay checkout without order_id (direct payment)
          _openRazorpayCheckout(
            razorpayKey: "rzp_live_R7WEc7UNXkN075",
            razorpayOrderId: bookingId,
            amount: amountInPaise,
            bookingId: bookingId,
          );
        } else {
          _showSnackBar(
            data['message'] ?? 'Failed to initiate payment',
            Colors.red,
          );
          setState(() {
            _isProcessingPayment = false;
            _processingBookingId = null;
          });
        }
      } else {
        final data = json.decode(response.body);
        _showSnackBar(
          data['message'] ?? 'Failed to initiate payment',
          Colors.red,
        );
        setState(() {
          _isProcessingPayment = false;
          _processingBookingId = null;
        });
      }
    } catch (e) {
      print('❌ Error processing payment: $e');
      _showSnackBar('Network error. Please try again.', Colors.red);
      setState(() {
        _isProcessingPayment = false;
        _processingBookingId = null;
      });
    }
  }

  void _openRazorpayCheckout({
    required String razorpayKey,
    required String? razorpayOrderId,
    required int amount,
    required String bookingId,
  }) {
    // Double check initialization before opening
    if (!_isRazorpayInitialized) {
      _showSnackBar('Payment system not ready. Please try again.', Colors.red);
      setState(() {
        _isProcessingPayment = false;
        _processingBookingId = null;
      });
      return;
    }

    var options = {
      'key': razorpayKey,
      'amount': amount,
      'currency': 'INR',
      'name': 'Farmhouse Booking',
      'description': 'Booking ID: ${bookingId ?? "N/A"}',
      'notes': {'bookingId': bookingId},
      'prefill': {
        'contact': '6303092897',
        'email': 'info@pixelmindsolutions.com',
      },
      'theme': {'color': '#FF5A5F'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('❌ Error opening Razorpay: $e');
      setState(() {
        _isProcessingPayment = false;
        _processingBookingId = null;
      });
      _showSnackBar('Error opening payment gateway: $e', Colors.red);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print('✅ Payment Success - Payment ID: ${response.paymentId}');
    print('✅ Order ID: ${response.orderId}');
    print('✅ Booking ID: $_processingBookingId');

    setState(() {
      _isProcessingPayment = false;
      _processingBookingId = null;
    });

    // Show success message
    _showSnackBar(
      'Payment successful! Your booking has been updated.',
      Colors.green,
    );

    // Refresh bookings list
    await _fetchAllBookings();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('❌ Payment Failed: ${response.message}');
    print('❌ Error Code: ${response.code}');

    // Call API to mark status back to partial
    if (_processingBookingId != null && userId != null) {
      _markStatusBackToPartial(_processingBookingId!);
    }

    setState(() {
      _isProcessingPayment = false;
      _processingBookingId = null;
    });

    // Show error dialog
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 28),
              SizedBox(width: 10),
              Text(
                'Payment Failed',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          content: Text(
            response.message ?? 'Something went wrong. Please try again.',
            style: const TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xFFFF5A5F)),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _markStatusBackToPartial(String bookingId) async {
    try {
      final response = await http.put(
        Uri.parse(
          'http://31.97.206.144:5124/api/order/markpartialstatus/$userId/$bookingId',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      print('📝 Mark Partial Status Response: ${response.statusCode}');
      print('📝 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('✅ Booking status updated back to partial');
      } else {
        print('❌ Failed to update booking status');
      }
    } catch (e) {
      print('❌ Error calling markpartialstatus API: $e');
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet: ${response.walletName}');
    setState(() {
      _isProcessingPayment = false;
      _processingBookingId = null;
    });
    _showSnackBar('External Wallet: ${response.walletName}', Colors.blueGrey);
  }

  // ─── Helper Methods ─────────────────────────────────────────────────────

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

  Future<void> _openMap(double lat, double lng, String label) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        _showSnackBar('Could not open maps', Colors.red);
      }
    }
  }

  Future<void> _makeCall(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        _showSnackBar('Could not make call', Colors.red);
      }
    }
  }

  void _showQRCode(String verificationId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Booking QR Code', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.qr_code_2_rounded,
              size: 120,
              color: Color(0xFF1A1A2E),
            ),
            const SizedBox(height: 12),
            Text(
              verificationId,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Close',
              style: TextStyle(color: Color(0xFFFF5A5F)),
            ),
          ),
        ],
      ),
    );
  }

  void _payRemainingAmount(String bookingId, int remainingAmount) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Complete Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'You have a pending remaining payment for this booking.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Remaining Amount:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '₹$remainingAmount',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF5A5F),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Would you like to pay the remaining amount now?',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _processRemainingPayment(bookingId, remainingAmount);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF5A5F),
            ),
            child: const Text('Pay Now'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FB),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'My Bookings',
            style: TextStyle(
              color: Color(0xFF1A1A2E),
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Container(
              color: Colors.white,
              child: TabBar(
                labelColor: const Color(0xFFFF5A5F),
                unselectedLabelColor: const Color(0xFF9E9E9E),
                labelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                indicatorColor: const Color(0xFFFF5A5F),
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                tabs: [
                  _buildTab('Upcoming', bookingsData['upcoming']?.length ?? 0),
                  _buildTab('Active', bookingsData['active']?.length ?? 0),
                  _buildTab(
                    'Completed',
                    bookingsData['completed']?.length ?? 0,
                  ),
                  _buildTab('Canceled', bookingsData['canceled']?.length ?? 0),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFFFF5A5F)),
                  )
                : TabBarView(
                    children: [
                      _buildBookingsList('upcoming'),
                      _buildBookingsList('active'),
                      _buildBookingsList('completed'),
                      _buildBookingsList('canceled'),
                    ],
                  ),
            // Loading Overlay for payment processing
            if (_isProcessingPayment)
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
                            'Processing payment...',
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
      ),
    );
  }

  Tab _buildTab(String label, int count) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          if (count > 0) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFF5A5F),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBookingsList(String status) {
    final bookings = bookingsData[status] ?? [];

    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F5),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.calendar_today_outlined,
                size: 44,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No $status bookings',
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF555555),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your $status bookings will appear here',
              style: TextStyle(fontSize: 14, color: Colors.grey[400]),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchAllBookings,
      color: const Color(0xFFFF5A5F),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < bookings.length - 1 ? 20 : 0,
            ),
            child: _buildBookingCard(booking, status),
          );
        },
      ),
    );
  }

  Widget _buildBookingCard(dynamic booking, String statusType) {
    // ── Safe field extraction with fallbacks ──────────────────────────────
    final farmhouse = booking['farmhouseId'] is Map
        ? booking['farmhouseId']
        : null;
    final bookingDetails = booking['bookingDetails'] is Map
        ? booking['bookingDetails']
        : {};
    final formattedDates = booking['formattedDates'] is Map
        ? booking['formattedDates']
        : {};
    final actions = booking['actions'] is Map ? booking['actions'] : {};
    final timeInfo = booking['timeInfo'] is Map ? booking['timeInfo'] : {};
    final locationData = farmhouse != null && farmhouse['location'] is Map
        ? farmhouse['location']
        : null;

    // Get payment status info
    final paymentStatus = booking['paymentStatus']?.toString() ?? 'full';
    final remainingAmount = booking['remainingAmount'] is num
        ? (booking['remainingAmount'] as num).toInt()
        : 0;
    final advancePayment = booking['advancePayment'] is num
        ? (booking['advancePayment'] as num).toInt()
        : 0;

    double? lat;
    double? lng;
    String phone = '';

    if (locationData != null) {
      final coords = locationData['coordinates'];

      if (coords is List && coords.length >= 2) {
        lng = (coords[0] as num).toDouble();
        lat = (coords[1] as num).toDouble();
      }

      phone = locationData['mobile']?.toString() ?? '';
    }

    final latitude = lat;
    final longitude = lng;

    final String title = farmhouse?['name']?.toString() ?? 'Unknown Farmhouse';
    final String address =
        farmhouse?['address']?.toString() ?? 'Unknown Location';

    final List<String> images = [];
    if (farmhouse?['images'] is List) {
      for (final img in farmhouse['images']) {
        if (img is String && img.isNotEmpty) images.add(img);
      }
    }
    if (images.isEmpty) images.add('');

    final String checkIn = formattedDates['checkIn']?.toString() ?? 'N/A';
    final String checkOut = formattedDates['checkOut']?.toString() ?? 'N/A';
    final String label = bookingDetails['label']?.toString() ?? 'N/A';
    final String timing = bookingDetails['timing']?.toString() ?? 'N/A';
    final String timeRemaining = timeInfo['timeRemaining']?.toString() ?? '';
    final num totalAmount = booking['totalAmount'] is num
        ? booking['totalAmount']
        : 0;
    final double rating = (farmhouse?['rating'] is num)
        ? (farmhouse['rating'] as num).toDouble()
        : 0.0;

    final bool canCancel = actions['canCancel'] == true;
    final bool canReschedule = actions['canReschedule'] == true;
    final bool canGenerateQR = actions['canGenerateQR'] == true;
    final bool canLeaveReview = actions['canLeaveReview'] == true;

    // Check if partial payment is pending
    final bool isPartialPaymentPending =
        paymentStatus == 'partial' &&
        remainingAmount > 0 &&
        statusType == 'upcoming';

    // ── Status color ──────────────────────────────────────────────────────
    Color statusColor;
    Color statusBg;
    IconData statusIcon;
    switch (statusType) {
      case 'upcoming':
        statusColor = const Color(0xFFFF5A5F);
        statusBg = const Color(0xFFFFF0F0);
        statusIcon = Icons.schedule;
        break;
      case 'active':
        statusColor = const Color(0xFF00C853);
        statusBg = const Color(0xFFE8FFF0);
        statusIcon = Icons.play_circle_outline;
        break;
      case 'completed':
        statusColor = const Color(0xFF757575);
        statusBg = const Color(0xFFF5F5F5);
        statusIcon = Icons.check_circle_outline;
        break;
      case 'canceled':
        statusColor = const Color(0xFFE53935);
        statusBg = const Color(0xFFFFF3F3);
        statusIcon = Icons.cancel_outlined;
        break;
      default:
        statusColor = Colors.grey;
        statusBg = Colors.grey[100]!;
        statusIcon = Icons.info_outline;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Auto-sliding image carousel ───────────────────────────────
          _ImageCarousel(
            images: images,
            statusColor: statusColor,
            statusBg: statusBg,
            statusIcon: statusIcon,
            statusType: statusType,
          ),

          // ── Card body ─────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + Rating
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A1A2E),
                          height: 1.2,
                        ),
                      ),
                    ),
                    if (rating > 0) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF8E1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 14,
                              color: Color(0xFFFFC107),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF795548),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 10),

                // Location + Map button
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 15,
                      color: Color(0xFFFF5A5F),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        address,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF757575),
                          height: 1.3,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (latitude != null && longitude != null)
                      _ActionChip(
                        icon: Icons.map_outlined,
                        label: 'Map',
                        color: const Color(0xFF1565C0),
                        bgColor: const Color(0xFFE3F2FD),
                        onTap: () => _openMap(latitude, longitude, title),
                      ),
                  ],
                ),

                const SizedBox(height: 8),

                // Phone
                Row(
                  children: [
                    const Icon(
                      Icons.phone_outlined,
                      size: 15,
                      color: Color(0xFF43A047),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        phone.isNotEmpty ? phone : 'No phone number',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF757575),
                        ),
                      ),
                    ),
                    if (phone.isNotEmpty)
                      _ActionChip(
                        icon: Icons.call,
                        label: 'Call',
                        color: const Color(0xFF2E7D32),
                        bgColor: const Color(0xFFE8F5E9),
                        onTap: () => _makeCall(phone),
                      ),
                  ],
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1, color: Color(0xFFF0F0F5)),
                ),

                // Dates row
                Row(
                  children: [
                    Expanded(
                      child: _DateBlock(
                        label: 'Check-in',
                        value: checkIn,
                        icon: Icons.login_rounded,
                      ),
                    ),
                    Container(
                      height: 36,
                      width: 1,
                      color: const Color(0xFFF0F0F5),
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    Expanded(
                      child: _DateBlock(
                        label: 'Check-out',
                        value: checkOut,
                        icon: Icons.logout_rounded,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Partial Payment Info Banner (if applicable)
                if (isPartialPaymentPending) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.orange.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Partial payment completed',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange.shade800,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Remaining Amount:',
                              style: TextStyle(fontSize: 13),
                            ),
                            Text(
                              '₹$remainingAmount',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF5A5F),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                // Price + Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                        Text(
                          '₹$totalAmount',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFFF5A5F),
                            height: 1.1,
                          ),
                        ),
                        if (paymentStatus == 'partial')
                          Text(
                            'Paid: ₹${totalAmount - remainingAmount}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        // Pay Remaining Button (for partial payments)
                        if (isPartialPaymentPending)
                          ElevatedButton.icon(
                            onPressed: _isProcessingPayment
                                ? null
                                : () => _payRemainingAmount(
                                    booking['_id'] ?? '',
                                    remainingAmount,
                                  ),
                            icon: const Icon(Icons.payment, size: 16),
                            label: const Text('Pay Remaining'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF5A5F),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        if (canGenerateQR && !isPartialPaymentPending)
                          _IconActionButton(
                            icon: Icons.qr_code_rounded,
                            tooltip: 'QR Code',
                            onTap: () =>
                                _showQRCode(booking['verificationId'] ?? ''),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Auto-sliding Image Carousel ────────────────────────────────────────────

class _ImageCarousel extends StatefulWidget {
  final List<String> images;
  final Color statusColor;
  final Color statusBg;
  final IconData statusIcon;
  final String statusType;

  const _ImageCarousel({
    required this.images,
    required this.statusColor,
    required this.statusBg,
    required this.statusIcon,
    required this.statusType,
  });

  @override
  State<_ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<_ImageCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    if (widget.images.length > 1) {
      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      final nextPage = (_currentPage + 1) % widget.images.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              onPageChanged: (p) => setState(() => _currentPage = p),
              itemBuilder: (context, index) {
                final url = widget.images[index];
                return url.isNotEmpty
                    ? Image.network(
                        url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => _placeholder(),
                      )
                    : _placeholder();
              },
            ),
          ),
        ),

        // Gradient overlay
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: Container(
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0x44000000)],
                stops: [0.5, 1.0],
              ),
            ),
          ),
        ),

        // Status badge
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: widget.statusBg,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.statusIcon, size: 12, color: widget.statusColor),
                const SizedBox(width: 4),
                Text(
                  widget.statusType.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: widget.statusColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Dot indicators
        if (widget.images.length > 1)
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (i) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentPage == i ? 20 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _currentPage == i ? Colors.white : Colors.white54,
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ),

        // Image count badge
        if (widget.images.length > 1)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_currentPage + 1}/${widget.images.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _placeholder() => Container(
    color: const Color(0xFFEEEEEE),
    child: const Center(
      child: Icon(Icons.home_work_outlined, size: 60, color: Color(0xFFBDBDBD)),
    ),
  );
}

// ── Reusable widgets ────────────────────────────────────────────────────────

class _DateBlock extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _DateBlock({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 12, color: const Color(0xFFFF5A5F)),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF9E9E9E),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A2E),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color color;
  final VoidCallback onTap;

  const _IconActionButton({
    required this.icon,
    required this.tooltip,
    this.color = const Color(0xFF1A1A2E),
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
      ),
    );
  }
}
