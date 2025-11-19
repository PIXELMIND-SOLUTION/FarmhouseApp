import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Color(0xFFFF5A5F),
        elevation: 0,
        title: const Text(
          "Privacy Policy",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 255, 255, 255),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Header Image or Icon
              Center(
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.privacy_tip_outlined,
                    size: 60,
                    color: Color(0xFFFF5A5F),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Farm House Privacy Policy",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF5A5F),
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                "Your privacy is important to us. This Privacy Policy explains how we collect, use, "
                "and protect your information when you use our Farm House Application.",
                style: TextStyle(fontSize: 15, height: 1.5),
              ),

              const SizedBox(height: 25),

              _sectionTitle("1. Information We Collect"),
              _sectionText(
                "• Personal details such as your name, email, and phone number.\n"
                "• Booking information related to farm house reservations.\n"
                "• Location data to enhance user experience.\n"
                "• Device information like IP address and device type."
              ),

              const SizedBox(height: 20),

              _sectionTitle("2. How We Use Your Information"),
              _sectionText(
                "• To manage farm house bookings and user accounts.\n"
                "• To improve application performance and user experience.\n"
                "• To send booking confirmations and important updates.\n"
                "• To provide customer support and troubleshooting."
              ),

              const SizedBox(height: 20),

              _sectionTitle("3. Data Protection"),
              _sectionText(
                "We use advanced security measures to protect your personal information from "
                "unauthorized access, alteration, or misuse."
              ),

              const SizedBox(height: 20),

              _sectionTitle("4. Sharing of Information"),
              _sectionText(
                "We do not sell or share your information with third-party companies except "
                "for trusted service providers who help us operate the application."
              ),

              const SizedBox(height: 20),

              _sectionTitle("5. Your Rights"),
              _sectionText(
                "• You can request deletion of your data.\n"
                "• You can update your personal information at any time.\n"
                "• You can opt out of notifications."
              ),

              const SizedBox(height: 20),

              _sectionTitle("6. Changes to This Policy"),
              _sectionText(
                "We may update this policy from time to time. We will notify you of major changes "
                "through the application."
              ),

              const SizedBox(height: 35),

              Center(
                child: Text(
                  "Last Updated: November 2025",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable widgets (title & text)
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFF5A5F),
      ),
    );
  }

  Widget _sectionText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        height: 1.6,
        color: Colors.black87,
      ),
    );
  }
}
