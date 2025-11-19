import 'package:farmhouse_app/views/details/house_detail_screen.dart';
import 'package:farmhouse_app/views/payment/payment_screen.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                indicatorColor: const Color(0xFFFF5A5F),
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Past Bookings'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildUpcomingBookings(context),
            _buildPastBookings(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingBookings(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildBookingCard(
          context: context,
          title: 'Green Valley Farm House',
          location: 'Hyderabad, Telangana',
          date: 'Nov 20 - Nov 22, 2025',
          guests: '6 Guests',
          price: '₹12,500',
          imageUrl:
              'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
          status: 'Confirmed',
          statusColor: const Color(0xFFFF5A5F),
          isUpcoming: true,
        ),
        const SizedBox(height: 16),
        _buildBookingCard(
          context: context,

          title: 'Sunset Paradise Villa',
          location: 'Lonavala, Maharashtra',
          date: 'Dec 15 - Dec 17, 2025',
          guests: '8 Guests',
          price: '₹18,000',
          imageUrl:
              'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
          status: 'Pending',
          statusColor: Colors.orange,
          isUpcoming: true,
        ),
        const SizedBox(height: 16),
        _buildBookingCard(
          title: 'Riverside Retreat',
          location: 'Coorg, Karnataka',
          date: 'Jan 10 - Jan 12, 2026',
          guests: '4 Guests',
          price: '₹9,500',
          imageUrl:
              'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800',
          status: 'Confirmed',
          statusColor: const Color(0xFF2E7D32),
          isUpcoming: true,
          context: context,
        ),
      ],
    );
  }

  Widget _buildPastBookings(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildBookingCard(
          context: context,

          title: 'Mountain View Farm House',
          location: 'Shimla, Himachal Pradesh',
          date: 'Oct 5 - Oct 7, 2025',
          guests: '5 Guests',
          price: '₹11,000',
          imageUrl:
              'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800',
          status: 'Completed',
          statusColor: Colors.grey,
          isUpcoming: false,
        ),
        const SizedBox(height: 16),
        _buildBookingCard(
          context: context,

          title: 'Tranquil Meadows Estate',
          location: 'Ooty, Tamil Nadu',
          date: 'Sep 12 - Sep 14, 2025',
          guests: '7 Guests',
          price: '₹14,500',
          imageUrl:
              'https://images.unsplash.com/photo-1600607687644-c7171b42498f?w=800',
          status: 'Completed',
          statusColor: Colors.grey,
          isUpcoming: false,
        ),
        const SizedBox(height: 16),
        _buildBookingCard(
          context: context,
          title: 'Lakeside Farm Cottage',
          location: 'Nainital, Uttarakhand',
          date: 'Aug 20 - Aug 22, 2025',
          guests: '4 Guests',
          price: '₹8,500',
          imageUrl:
              'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?w=800',
          status: 'Completed',
          statusColor: Colors.grey,
          isUpcoming: false,
        ),
      ],
    );
  }

  Widget _buildBookingCard({
    required BuildContext context,
    required String title,
    required String location,
    required String date,
    required String guests,
    required String price,
    required String imageUrl,
    required String status,
    required Color statusColor,
    required bool isUpcoming,
  }) {
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
                child: Image.network(
                  imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.house,
                        size: 80,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
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
                    Text(
                      location,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.people,
                      size: 16,
                      color: Color(0xFFFF5A5F),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      guests,
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
                        color: const Color(0xFFFF5A5F),
                      ),
                    ),
                    if (isUpcoming)
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HouseDetailScreen(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFFF5A5F)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Details',
                              style: TextStyle(color: Color(0xFFFF5A5F)),
                            ),
                          ),
                          // const SizedBox(width: 8),
                          // ElevatedButton(
                          //   onPressed: () {},
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: const Color(0xFFFF5A5F),
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(8),
                          //     ),
                          //   ),
                          //   child: const Text(
                          //     'Modify',
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          // ),
                        ],
                      )
                    else
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PaymentScreen(image: imageUrl,name: title,),
                            ),
                          );
                        },
                        icon: const Icon(Icons.refresh, size: 18),
                        label: const Text('Book Again'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5A5F),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
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
