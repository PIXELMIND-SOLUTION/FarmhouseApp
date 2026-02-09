import 'package:farmhouse_app/provider/auth/profile_provider.dart';
import 'package:farmhouse_app/provider/auth/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class BookingScreen extends StatefulWidget {
  
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

  String? userId;

  Map<String, List<dynamic>> bookingsData = {
    'upcoming': [],
    'active': [],
    'completed': [],
    'canceled': [],
  };
  
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialize();
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
      print("✅ User ID loaded: $userId");
    } else {
      print("❌ User ID is null");
    }
  }

  Future<void> _fetchAllBookings() async {
    if (userId == null) {
      print("❌ Cannot fetch bookings: userId is null");
      return;
    }

    setState(() {
      isLoading = true;
    });

    final statuses = ['upcoming', 'active', 'completed', 'canceled'];
    
    for (String status in statuses) {
      try {
        print("📡 Fetching $status bookings for userId: $userId");
        final response = await http.get(
          Uri.parse('http://31.97.206.144:5124/api/order/all?userId=$userId&status=$status'),
        );

        print("📥 Response for $status: ${response.body}");

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['success'] == true) {
            setState(() {
              bookingsData[status] = data['bookings'] ?? [];
            });
            print("✅ ${data['bookings']?.length ?? 0} $status bookings loaded");
          }
        }
      } catch (e) {
        print('❌ Error fetching $status bookings: $e');
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'My Bookings',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              color: Colors.white,
              child: TabBar(
                labelColor: const Color(0xFFFF5A5F),
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                indicatorColor: const Color(0xFFFF5A5F),
                indicatorWeight: 3,
                isScrollable: true,
                tabs: const [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Active'),
                  Tab(text: 'Completed'),
                  Tab(text: 'Canceled'),
                ],
              ),
            ),
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator(color: Color(0xFFFF5A5F)))
            : TabBarView(
                children: [
                  _buildBookingsList('upcoming'),
                  _buildBookingsList('active'),
                  _buildBookingsList('completed'),
                  _buildBookingsList('canceled'),
                ],
              ),
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
            Icon(
              Icons.calendar_today_outlined,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'No ${status} bookings',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
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
            padding: EdgeInsets.only(bottom: index < bookings.length - 1 ? 16 : 0),
            child: _buildBookingCard(booking, status),
          );
        },
      ),
    );
  }

  Widget _buildBookingCard(dynamic booking, String statusType) {
    final farmhouse = booking['farmhouseId'];
    final bookingDetails = booking['bookingDetails'];
    final formattedDates = booking['formattedDates'];
    final actions = booking['actions'];
    
    String title = farmhouse['name'] ?? 'Unknown Farmhouse';
    String location = farmhouse['address'] ?? 'Unknown Location';
    String imageUrl = (farmhouse['images'] != null && farmhouse['images'].isNotEmpty) 
        ? farmhouse['images'][0] 
        : '';
    
    String date = '${formattedDates['checkIn']} - ${formattedDates['checkOut']}';
    String price = '₹${booking['totalAmount']}';
    String status = booking['status'] ?? 'Unknown';
    
    Color statusColor;
    switch (statusType) {
      case 'upcoming':
        statusColor = const Color(0xFFFF5A5F);
        break;
      case 'active':
        statusColor = const Color(0xFF2E7D32);
        break;
      case 'completed':
        statusColor = Colors.grey;
        break;
      case 'canceled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    bool isUpcoming = statusType == 'upcoming';
    bool isActive = statusType == 'active';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          // Image Section
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 150,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.house,
                              size: 80,
                              color: Colors.grey,
                            ),
                          );
                        },
                      )
                    : Container(
                        height: 150,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.house,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),
              ),
              // Positioned(
              //   top: 12,
              //   right: 12,
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 12,
              //       vertical: 6,
              //     ),
              //     decoration: BoxDecoration(
              //       color: statusColor,
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: Text(
              //       status.toUpperCase(),
              //       style: const TextStyle(
              //         color: Colors.white,
              //         fontSize: 12,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),

          // Content Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Color(0xFFFF5A5F),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        date,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: Color(0xFFFF5A5F),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${bookingDetails['label']} (${bookingDetails['timing']})',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF5A5F),
                      ),
                    ),
                    // if (isUpcoming || isActive)
                    //   Row(
                    //     children: [
                    //       OutlinedButton(
                    //         onPressed: () {
                    //           // Navigate to details
                    //         },
                    //         style: OutlinedButton.styleFrom(
                    //           side: const BorderSide(color: Color(0xFFFF5A5F)),
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(8),
                    //           ),
                    //         ),
                    //         child: const Text(
                    //           'Details',
                    //           style: TextStyle(color: Color(0xFFFF5A5F)),
                    //         ),
                    //       ),
                    //     ],
                    //   )
                    // else if (statusType == 'completed')
                    //   ElevatedButton.icon(
                    //     onPressed: () {
                    //       // Book again functionality
                    //     },
                    //     icon: const Icon(Icons.refresh, size: 18),
                    //     label: const Text('Book Again'),
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: const Color(0xFFFF5A5F),
                    //       foregroundColor: Colors.white,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(8),
                    //       ),
                    //     ),
                    //   ),
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