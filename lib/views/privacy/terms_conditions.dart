import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Color(0xFFFF5A5F),
        elevation: 0,
        title: const Text(
          "Terms & Conditions",
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
              
              Center(
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.article_outlined,
                    size: 60,
                    color: Color(0xFFFF5A5F)
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Farm House Terms & Conditions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF5A5F),
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                "Please read these Terms & Conditions carefully before using our Farm House Application. "
                "By accessing or using the app, you agree to comply with these terms.",
                style: TextStyle(fontSize: 15, height: 1.5),
              ),

              const SizedBox(height: 25),

              _sectionTitle("1. Acceptance of Terms"),
              _sectionText(
                "By creating an account or using our services, you agree to be bound by these Terms & Conditions. "
                "If you do not agree, you may not use the application."
              ),

              const SizedBox(height: 20),

              _sectionTitle("2. Booking & Payments"),
              _sectionText(
                "• Booking confirmation is subject to availability.\n"
                "• Users must provide accurate details during booking.\n"
                "• Payments made for farm house reservations are non-refundable unless otherwise mentioned.\n"
                "• The app may charge additional service or maintenance fees."
              ),

              const SizedBox(height: 20),

              _sectionTitle("3. User Responsibilities"),
              _sectionText(
                "• Users must provide correct and up-to-date personal information.\n"
                "• Any damage caused to property during your stay will be your responsibility.\n"
                "• Illegal, abusive, or harmful activities are strictly prohibited.\n"
                "• Users must follow all farm house rules and safety guidelines."
              ),

              const SizedBox(height: 20),

              _sectionTitle("4. Prohibited Activities"),
              _sectionText(
                "• Misusing the property or causing harm to livestock or farmland.\n"
                "• Attempting to hack, damage, or disrupt the app systems.\n"
                "• Sharing false booking information or fraudulent activity."
              ),

              const SizedBox(height: 20),

              _sectionTitle("5. Limitation of Liability"),
              _sectionText(
                "We are not responsible for:\n"
                "• Loss or damage of personal belongings.\n"
                "• Accidents caused by user negligence.\n"
                "• Delays or cancellations due to natural events, weather, or emergencies.\n"
                "• Technical issues in the app caused by third-party services."
              ),

              const SizedBox(height: 20),

              _sectionTitle("6. Modifications to Services"),
              _sectionText(
                "We reserve the right to modify or discontinue any service, feature, or part of the application "
                "at any time without prior notice."
              ),

              const SizedBox(height: 20),

              _sectionTitle("7. Termination"),
              _sectionText(
                "We may suspend or terminate your access if:\n"
                "• You violate these Terms & Conditions.\n"
                "• Suspicious or harmful activity is detected.\n"
                "• Required information is not provided."
              ),

              const SizedBox(height: 20),

              _sectionTitle("8. Changes to Terms"),
              _sectionText(
                "These Terms & Conditions may be updated periodically. Please review them occasionally "
                "to stay informed."
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
