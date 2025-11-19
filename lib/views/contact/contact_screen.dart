import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: _buildContactCard(
                      icon: Icons.phone,
                      title: "Phone",
                      subtitle: "+91 98765 43210",
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 15),
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: _buildContactCard(
                      icon: Icons.email_outlined,
                      title: "Email",
                      subtitle: "support@yourapp.com",
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 15),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: _buildContactCard(
                      icon: Icons.location_on_rounded,
                      title: "Address",
                      subtitle: "KPHB, Hyderabad, Telangana",
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 15),
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: _buildContactCard(
                      icon: Icons.support_agent,
                      title: "Customer Support",
                      subtitle: "Available 24/7 for your help",
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// HEADER UI
  Widget _buildHeader() {
    return Container(
      height: 230,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF5A5F), Color(0xFFFF5A5F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.support_agent_rounded, color: Colors.white, size: 80),
            SizedBox(height: 10),
            Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "We are here to help you anytime",
              style: TextStyle(color: Colors.white70, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }

  /// CONTACT CARD UI
  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 16)
        ],
      ),
    );
  }
}
