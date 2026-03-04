// import 'package:farmhouse_app/provider/auth/profile_provider.dart';
// import 'package:farmhouse_app/provider/auth/register_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:provider/provider.dart';

// class BookingScreen extends StatefulWidget {
//   const BookingScreen({super.key});

//   @override
//   State<BookingScreen> createState() => _BookingScreenState();
// }

// class _BookingScreenState extends State<BookingScreen> {
//   String? userId;

//   Map<String, List<dynamic>> bookingsData = {
//     'upcoming': [],
//     'active': [],
//     'completed': [],
//     'canceled': [],
//   };

//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _initialize();
//   }

//   Future<void> _initialize() async {
//     await _loadProfileData();
//     if (userId != null) {
//       await _fetchAllBookings();
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> _loadProfileData() async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     await authProvider.loadUserFromPrefs();

//     final user = authProvider.user;
//     if (user != null) {
//       setState(() {
//         userId = user.id;
//       });
//       print("✅ User ID loaded: $userId");
//     } else {
//       print("❌ User ID is null");
//     }
//   }

//   Future<void> _fetchAllBookings() async {
//     if (userId == null) {
//       print("❌ Cannot fetch bookings: userId is null");
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     final statuses = ['upcoming', 'active', 'completed', 'canceled'];

//     for (String status in statuses) {
//       try {
//         print("📡 Fetching $status bookings for userId: $userId");
//         final response = await http.get(
//           Uri.parse(
//             'http://31.97.206.144:5124/api/order/all?userId=$userId&status=$status',
//           ),
//         );

//         print("📥 Response for $status: ${response.body}");

//         if (response.statusCode == 200) {
//           final data = json.decode(response.body);
//           if (data['success'] == true) {
//             setState(() {
//               bookingsData[status] = data['bookings'] ?? [];
//             });
//             print("✅ ${data['bookings']?.length ?? 0} $status bookings loaded");
//           }
//         }
//       } catch (e) {
//         print('❌ Error fetching $status bookings: $e');
//       }
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         backgroundColor: Colors.grey[50],
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           title: const Text(
//             'My Bookings',
//             style: TextStyle(
//               color: Colors.black87,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(60),
//             child: Container(
//               color: Colors.white,
//               child: TabBar(
//                 labelColor: const Color(0xFFFF5A5F),
//                 unselectedLabelColor: Colors.grey,
//                 labelStyle: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 indicatorColor: const Color(0xFFFF5A5F),
//                 indicatorWeight: 3,
//                 isScrollable: true,
//                 tabs: const [
//                   Tab(text: 'Upcoming'),
//                   Tab(text: 'Active'),
//                   Tab(text: 'Completed'),
//                   Tab(text: 'Canceled'),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         body: isLoading
//             ? const Center(
//                 child: CircularProgressIndicator(color: Color(0xFFFF5A5F)),
//               )
//             : TabBarView(
//                 children: [
//                   _buildBookingsList('upcoming'),
//                   _buildBookingsList('active'),
//                   _buildBookingsList('completed'),
//                   _buildBookingsList('canceled'),
//                 ],
//               ),
//       ),
//     );
//   }

//   Widget _buildBookingsList(String status) {
//     final bookings = bookingsData[status] ?? [];

//     if (bookings.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.calendar_today_outlined,
//               size: 80,
//               color: Colors.grey[300],
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'No ${status} bookings',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey[600],
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return RefreshIndicator(
//       onRefresh: _fetchAllBookings,
//       color: const Color(0xFFFF5A5F),
//       child: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           final booking = bookings[index];
//           return Padding(
//             padding: EdgeInsets.only(
//               bottom: index < bookings.length - 1 ? 16 : 0,
//             ),
//             child: _buildBookingCard(booking, status),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildBookingCard(dynamic booking, String statusType) {
//     final farmhouse = booking['farmhouseId'];
//     final bookingDetails = booking['bookingDetails'];
//     final formattedDates = booking['formattedDates'];
//     final actions = booking['actions'];

//     // String title = farmhouse['name'] ?? 'Unknown Farmhouse';

//     // Guard against null farmhouse
//     // String title = farmhouse != null ? (farmhouse['name'] ?? 'Unknown Farmhouse') : 'Unknown Farmhouse';
//     //   String location = farmhouse['address'] ?? 'Unknown Location';
//     //   String imageUrl = (farmhouse['images'] != null && farmhouse['images'].isNotEmpty)
//     //       ? farmhouse['images'][0]
//     //       : '';

//     String title = farmhouse != null
//         ? (farmhouse['name'] ?? 'Unknown Farmhouse')
//         : 'Unknown Farmhouse';
//     String location = farmhouse != null
//         ? (farmhouse['address'] ?? 'Unknown Location')
//         : 'Unknown Location';
//     String imageUrl =
//         (farmhouse != null &&
//             farmhouse['images'] != null &&
//             farmhouse['images'].isNotEmpty)
//         ? farmhouse['images'][0]
//         : '';

//     String date =
//         '${formattedDates['checkIn']} - ${formattedDates['checkOut']}';
//     String price = '₹${booking['totalAmount']}';
//     String status = booking['status'] ?? 'Unknown';

//     Color statusColor;
//     switch (statusType) {
//       case 'upcoming':
//         statusColor = const Color(0xFFFF5A5F);
//         break;
//       case 'active':
//         statusColor = const Color(0xFF2E7D32);
//         break;
//       case 'completed':
//         statusColor = Colors.grey;
//         break;
//       case 'canceled':
//         statusColor = Colors.red;
//         break;
//       default:
//         statusColor = Colors.grey;
//     }

//     bool isUpcoming = statusType == 'upcoming';
//     bool isActive = statusType == 'active';

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Image Section
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(16),
//                 ),
//                 child: imageUrl.isNotEmpty
//                     ? Image.network(
//                         imageUrl,
//                         height: 150,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             height: 150,
//                             color: Colors.grey[300],
//                             child: const Icon(
//                               Icons.house,
//                               size: 80,
//                               color: Colors.grey,
//                             ),
//                           );
//                         },
//                       )
//                     : Container(
//                         height: 150,
//                         color: Colors.grey[300],
//                         child: const Icon(
//                           Icons.house,
//                           size: 80,
//                           color: Colors.grey,
//                         ),
//                       ),
//               ),
//               // Positioned(
//               //   top: 12,
//               //   right: 12,
//               //   child: Container(
//               //     padding: const EdgeInsets.symmetric(
//               //       horizontal: 12,
//               //       vertical: 6,
//               //     ),
//               //     decoration: BoxDecoration(
//               //       color: statusColor,
//               //       borderRadius: BorderRadius.circular(20),
//               //     ),
//               //     child: Text(
//               //       status.toUpperCase(),
//               //       style: const TextStyle(
//               //         color: Colors.white,
//               //         fontSize: 12,
//               //         fontWeight: FontWeight.w600,
//               //       ),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),

//           // Content Section
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on, size: 16, color: Colors.grey),
//                     const SizedBox(width: 4),
//                     Expanded(
//                       child: Text(
//                         location,
//                         style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.calendar_today,
//                       size: 16,
//                       color: Color(0xFFFF5A5F),
//                     ),
//                     const SizedBox(width: 6),
//                     Expanded(
//                       child: Text(
//                         date,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black87,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.access_time,
//                       size: 16,
//                       color: Color(0xFFFF5A5F),
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       '${bookingDetails['label']} (${bookingDetails['timing']})',
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       price,
//                       style: const TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFFFF5A5F),
//                       ),
//                     ),
//                     // if (isUpcoming || isActive)
//                     //   Row(
//                     //     children: [
//                     //       OutlinedButton(
//                     //         onPressed: () {
//                     //           // Navigate to details
//                     //         },
//                     //         style: OutlinedButton.styleFrom(
//                     //           side: const BorderSide(color: Color(0xFFFF5A5F)),
//                     //           shape: RoundedRectangleBorder(
//                     //             borderRadius: BorderRadius.circular(8),
//                     //           ),
//                     //         ),
//                     //         child: const Text(
//                     //           'Details',
//                     //           style: TextStyle(color: Color(0xFFFF5A5F)),
//                     //         ),
//                     //       ),
//                     //     ],
//                     //   )
//                     // else if (statusType == 'completed')
//                     //   ElevatedButton.icon(
//                     //     onPressed: () {
//                     //       // Book again functionality
//                     //     },
//                     //     icon: const Icon(Icons.refresh, size: 18),
//                     //     label: const Text('Book Again'),
//                     //     style: ElevatedButton.styleFrom(
//                     //       backgroundColor: const Color(0xFFFF5A5F),
//                     //       foregroundColor: Colors.white,
//                     //       shape: RoundedRectangleBorder(
//                     //         borderRadius: BorderRadius.circular(8),
//                     //       ),
//                     //     ),
//                     //   ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





























import 'package:farmhouse_app/provider/auth/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  _buildTab('Completed', bookingsData['completed']?.length ?? 0),
                  _buildTab('Canceled', bookingsData['canceled']?.length ?? 0),
                ],
              ),
            ),
          ),
        ),
        body: isLoading
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
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
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
    final farmhouse = booking['farmhouseId'] is Map ? booking['farmhouseId'] : null;
    final bookingDetails = booking['bookingDetails'] is Map ? booking['bookingDetails'] : {};
    final formattedDates = booking['formattedDates'] is Map ? booking['formattedDates'] : {};
    final actions = booking['actions'] is Map ? booking['actions'] : {};
    final timeInfo = booking['timeInfo'] is Map ? booking['timeInfo'] : {};
final locationData =
    farmhouse != null && farmhouse['location'] is Map
        ? farmhouse['location']
        : null;

double? lat;
double? lng;
String phone = '';

if (locationData != null) {
  final coords = locationData['coordinates'];

  if (coords is List && coords.length >= 2) {
    lng = (coords[0] as num).toDouble(); // longitude
    lat = (coords[1] as num).toDouble(); // latitude
  }

  phone = locationData['mobile']?.toString() ?? '';
}


final latitude = lat;
final longitude = lng;

    final String title = farmhouse?['name']?.toString() ?? 'Unknown Farmhouse';
    final String address = farmhouse?['address']?.toString() ?? 'Unknown Location';


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
    final num totalAmount = booking['totalAmount'] is num ? booking['totalAmount'] : 0;
    final double rating = (farmhouse?['rating'] is num) ? (farmhouse['rating'] as num).toDouble() : 0.0;

    final bool canCancel = actions['canCancel'] == true;
    final bool canReschedule = actions['canReschedule'] == true;
    final bool canGenerateQR = actions['canGenerateQR'] == true;
    final bool canLeaveReview = actions['canLeaveReview'] == true;

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
          _ImageCarousel(images: images, statusColor: statusColor, statusBg: statusBg, statusIcon: statusIcon, statusType: statusType),

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
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF8E1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded, size: 14, color: Color(0xFFFFC107)),
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
                    const Icon(Icons.location_on_rounded, size: 15, color: Color(0xFFFF5A5F)),
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

                // if (phone.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.phone_outlined, size: 15, color: Color(0xFF43A047)),
                      const SizedBox(width: 4),
                      Text(
                        phone,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF757575),
                        ),
                      ),
                      const Spacer(),
                      _ActionChip(
                        icon: Icons.call,
                        label: 'Call',
                        color: const Color(0xFF2E7D32),
                        bgColor: const Color(0xFFE8F5E9),
                        onTap: () => _makeCall(phone),
                      ),
                    ],
                  ),
                // ],

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

                // Slot info
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                //   decoration: BoxDecoration(
                //     color: const Color(0xFFF8F8FF),
                //     borderRadius: BorderRadius.circular(10),
                //     border: Border.all(color: const Color(0xFFE8E8F0)),
                //   ),
                //   child: Row(
                //     children: [
                //       const Icon(Icons.access_time_rounded, size: 16, color: Color(0xFFFF5A5F)),
                //       const SizedBox(width: 8),
                //       Expanded(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               label,
                //               style: const TextStyle(
                //                 fontSize: 13,
                //                 fontWeight: FontWeight.w600,
                //                 color: Color(0xFF1A1A2E),
                //               ),
                //             ),
                //             Text(
                //               timing,
                //               style: const TextStyle(
                //                 fontSize: 12,
                //                 color: Color(0xFF9E9E9E),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       if (timeRemaining.isNotEmpty && statusType == 'upcoming')
                //         Container(
                //           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //           decoration: BoxDecoration(
                //             color: const Color(0xFFFFF3E0),
                //             borderRadius: BorderRadius.circular(6),
                //           ),
                //           child: Text(
                //             timeRemaining,
                //             style: const TextStyle(
                //               fontSize: 11,
                //               fontWeight: FontWeight.w600,
                //               color: Color(0xFFE65100),
                //             ),
                //           ),
                //         ),
                //     ],
                //   ),
                // ),

                // const SizedBox(height: 14),

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
                          style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
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
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     if (canGenerateQR)
                    //       _IconActionButton(
                    //         icon: Icons.qr_code_rounded,
                    //         tooltip: 'QR Code',
                    //         onTap: () => _showQRCode(booking['verificationId'] ?? ''),
                    //       ),
                    //     if (canCancel) ...[
                    //       const SizedBox(width: 8),
                    //       _IconActionButton(
                    //         icon: Icons.cancel_outlined,
                    //         tooltip: 'Cancel',
                    //         color: const Color(0xFFE53935),
                    //         onTap: () => _confirmCancel(booking['_id'] ?? ''),
                    //       ),
                    //     ],
                    //     if (canLeaveReview) ...[
                    //       const SizedBox(width: 8),
                    //       _IconActionButton(
                    //         icon: Icons.rate_review_outlined,
                    //         tooltip: 'Review',
                    //         color: const Color(0xFFFF9800),
                    //         onTap: () {},
                    //       ),
                    //     ],
                    //     if (statusType == 'completed') ...[
                    //       const SizedBox(width: 8),
                    //       ElevatedButton.icon(
                    //         onPressed: () {},
                    //         icon: const Icon(Icons.refresh_rounded, size: 16),
                    //         label: const Text('Book Again'),
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: const Color(0xFFFF5A5F),
                    //           foregroundColor: Colors.white,
                    //           elevation: 0,
                    //           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(10),
                    //           ),
                    //           textStyle: const TextStyle(
                    //             fontSize: 13,
                    //             fontWeight: FontWeight.w700,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ],
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ─────────────────────────────────────────────────────────────

  Future<void> _openMap(double lat, double lng, String label) async {
    final uri = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open maps')),
        );
      }
    }
  }

  Future<void> _makeCall(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not make call')),
        );
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
            const Icon(Icons.qr_code_2_rounded, size: 120, color: Color(0xFF1A1A2E)),
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
            child: const Text('Close', style: TextStyle(color: Color(0xFFFF5A5F))),
          ),
        ],
      ),
    );
  }

  void _confirmCancel(String bookingId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Cancel Booking'),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: implement cancel API call
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Yes, Cancel', style: TextStyle(color: Colors.white)),
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
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6)],
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
                style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
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

  const _DateBlock({required this.label, required this.value, required this.icon});

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
              style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E), fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E)),
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
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color),
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