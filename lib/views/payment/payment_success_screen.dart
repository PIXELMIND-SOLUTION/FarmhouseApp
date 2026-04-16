// views/payment/payment_success_screen.dart
import 'package:farmhouse_app/views/home/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_provider.dart';
import '../auth/navbar_screen.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String? paymentId;
  final String? bookingId;
  final String paymentOption; // 'full' or 'advance'
  final int totalAmount;
  final int paidAmount;

  const PaymentSuccessScreen({
    super.key,
    this.paymentId,
    this.bookingId,
    required this.paymentOption,
    required this.totalAmount,
    required this.paidAmount,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final remainingAmount = totalAmount - paidAmount;

    return WillPopScope(
      onWillPop: () async {
        // Prevent going back to payment screen
        // Navigate directly to bookings instead
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const NavbarScreen(initialIndex: 1),
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ), // Optional: Add some top spacing if needed
                // Success Animation
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade50,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Icon(
                    Icons.check_circle,
                    size: 100,
                    color: Colors.green.shade600,
                  ),
                ),
                const SizedBox(height: 32),

                // Title
                const Text(
                  "Payment Successful!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),

                // Subtitle
                Text(
                  paymentOption == 'advance'
                      ? "Your 30% advance payment has been received"
                      : "Your full payment has been received",
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Payment Details Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Payment Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildDetailRow("Payment ID", paymentId ?? 'N/A'),
                      const Divider(height: 20),
                      _buildDetailRow("Booking ID", bookingId ?? 'N/A'),
                      const Divider(height: 20),
                      _buildDetailRow(
                        "Amount Paid",
                        "₹$paidAmount",
                        isHighlight: true,
                      ),
                      if (paymentOption == 'advance') ...[
                        const Divider(height: 20),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.orange.shade700,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "Remaining balance: ₹$remainingAmount to be paid at check-in",
                                  style: TextStyle(
                                    fontSize: 13,
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

                const SizedBox(height: 32),

                // Action Buttons
                Column(
                  children: [
                    // View Bookings Button
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 50,
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: const Color(0xFFFF5A5F),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //       elevation: 0,
                    //     ),
                    //     onPressed: () {
                    //       Navigator.of(context).pushReplacement(
                    //         MaterialPageRoute(
                    //           builder: (_) => const NavbarScreen(
                    //             initialIndex: 2,
                    //           ), // 2 for Bookings tab
                    //         ),
                    //       );
                    //     },
                    //     child: const Text(
                    //       "View My Bookings",
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w600,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 12),

                    // Home Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFFF5A5F),
                          side: const BorderSide(color: Color(0xFFFF5A5F)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const NavbarScreen(
                                initialIndex: 0,
                              ), // 0 for Home/Explore
                            ),
                          );
                        },
                        child: const Text(
                          "Back to Home",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 40,
                ), // Optional: Add some bottom spacing if needed
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isHighlight ? 18 : 14,
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
              color: isHighlight ? const Color(0xFFFF5A5F) : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
