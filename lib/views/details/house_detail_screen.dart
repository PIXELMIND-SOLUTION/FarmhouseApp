// import 'package:farmhouse_app/views/payment/payment_screen.dart';
// import 'package:flutter/material.dart';

// class HouseDetailScreen extends StatefulWidget {
//   const HouseDetailScreen({super.key});

//   @override
//   State<HouseDetailScreen> createState() => _HouseDetailScreenState();
// }

// class _HouseDetailScreenState extends State<HouseDetailScreen> {
//   int selectedImageIndex = 0;
//   String selectedPricing = 'hour';

//   final List<String> imageUrls = [
//     'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
//     'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800',
//     'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
//     'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=800',
//   ];

//   final List<Map<String, dynamic>> reviews = [
//     {
//       'name': 'Sarah Johnson',
//       'rating': 5,
//       'comment':
//           'Amazing place! Perfect for a weekend getaway. The views are breathtaking.',
//       'date': '2 weeks ago',
//       'avatar': 'SJ',
//     },
//     {
//       'name': 'Michael Chen',
//       'rating': 4,
//       'comment':
//           'Beautiful farmhouse with great amenities. Highly recommended for families.',
//       'date': '1 month ago',
//       'avatar': 'MC',
//     },
//     {
//       'name': 'Emma Williams',
//       'rating': 5,
//       'comment':
//           'Peaceful and serene. Exactly what we needed to disconnect from city life.',
//       'date': '2 months ago',
//       'avatar': 'EW',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           CustomScrollView(
//             slivers: [
//               // Image Gallery Header
//               SliverAppBar(
//                 expandedHeight: 400,
//                 pinned: true,
//                 backgroundColor: Colors.white,
//                 elevation: 0,
//                 leading: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: CircleAvatar(
//                     backgroundColor: Colors.white,
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back, color: Colors.black),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ),
//                 ),
//                 actions: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: IconButton(
//                         icon: const Icon(
//                           Icons.favorite_border,
//                           color: Colors.black,
//                         ),
//                         onPressed: () {},
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: IconButton(
//                         icon: const Icon(Icons.share, color: Colors.black),
//                         onPressed: () {},
//                       ),
//                     ),
//                   ),
//                 ],
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       Image.network(
//                         imageUrls[selectedImageIndex],
//                         fit: BoxFit.cover,
//                       ),
//                       Positioned(
//                         bottom: 20,
//                         right: 20,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.7),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             '${selectedImageIndex + 1}/${imageUrls.length}',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 20,
//                         left: 0,
//                         right: 0,
//                         child: SizedBox(
//                           height: 80,
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             itemCount: imageUrls.length,
//                             itemBuilder: (context, index) {
//                               return GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedImageIndex = index;
//                                   });
//                                 },
//                                 child: Container(
//                                   width: 80,
//                                   margin: const EdgeInsets.only(right: 10),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(12),
//                                     border: Border.all(
//                                       color: selectedImageIndex == index
//                                           ? Colors.white
//                                           : Colors.transparent,
//                                       width: 3,
//                                     ),
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(10),
//                                     child: Image.network(
//                                       imageUrls[index],
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Content
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Title and Rating
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Expanded(
//                             child: Text(
//                               'Luxury Farm House',
//                               style: TextStyle(
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 6,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.amber,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: const Row(
//                               children: [
//                                 Icon(Icons.star, color: Colors.white, size: 18),
//                                 SizedBox(width: 4),
//                                 Text(
//                                   '4.8',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.location_on,
//                             size: 20,
//                             color: Colors.grey,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             'Green Valley, Countryside',
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 24),

//                       // Pricing Toggle
//                       Container(
//                         padding: const EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[100],
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedPricing = 'hour';
//                                   });
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 12,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: selectedPricing == 'hour'
//                                         ? Colors.white
//                                         : Colors.transparent,
//                                     borderRadius: BorderRadius.circular(10),
//                                     boxShadow: selectedPricing == 'hour'
//                                         ? [
//                                             BoxShadow(
//                                               color: Colors.black.withOpacity(
//                                                 0.1,
//                                               ),
//                                               blurRadius: 8,
//                                               offset: const Offset(0, 2),
//                                             ),
//                                           ]
//                                         : null,
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                         '\$50',
//                                         style: TextStyle(
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.bold,
//                                           color: selectedPricing == 'hour'
//                                               ? Colors.black
//                                               : Colors.grey,
//                                         ),
//                                       ),
//                                       Text(
//                                         'per hour',
//                                         style: TextStyle(
//                                           color: selectedPricing == 'hour'
//                                               ? Colors.grey[600]
//                                               : Colors.grey[400],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedPricing = 'day';
//                                   });
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 12,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: selectedPricing == 'day'
//                                         ? Colors.white
//                                         : Colors.transparent,
//                                     borderRadius: BorderRadius.circular(10),
//                                     boxShadow: selectedPricing == 'day'
//                                         ? [
//                                             BoxShadow(
//                                               color: Colors.black.withOpacity(
//                                                 0.1,
//                                               ),
//                                               blurRadius: 8,
//                                               offset: const Offset(0, 2),
//                                             ),
//                                           ]
//                                         : null,
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                         '\$350',
//                                         style: TextStyle(
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.bold,
//                                           color: selectedPricing == 'day'
//                                               ? Colors.black
//                                               : Colors.grey,
//                                         ),
//                                       ),
//                                       Text(
//                                         'per day',
//                                         style: TextStyle(
//                                           color: selectedPricing == 'day'
//                                               ? Colors.grey[600]
//                                               : Colors.grey[400],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 24),

//                       // Features
//                       const Text(
//                         'Features',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           _buildFeatureItem(Icons.bed, '4 Bedrooms'),
//                           _buildFeatureItem(Icons.bathtub, '3 Bathrooms'),
//                           _buildFeatureItem(Icons.square_foot, '2500 sqft'),
//                         ],
//                       ),
//                       const SizedBox(height: 24),

//                       // Description
//                       const Text(
//                         'Description',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         'Experience tranquility in this stunning farmhouse nestled in the countryside. Perfect for family gatherings, weekend retreats, or special celebrations. Features include a spacious garden, modern amenities, and breathtaking views.',
//                         style: TextStyle(
//                           color: Colors.grey[700],
//                           fontSize: 15,
//                           height: 1.6,
//                         ),
//                       ),
//                       const SizedBox(height: 24),

//                       Text('ssssssssssssssssss'),

//                       // Reviews Header
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Reviews',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {},
//                             child: const Text('See all'),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),

//                       // Reviews List
//                       ...reviews.map((review) => _buildReviewCard(review)),
//                       const SizedBox(height: 100),

//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           // Book Now Button (Fixed at bottom)
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 10,
//                     offset: const Offset(0, -5),
//                   ),
//                 ],
//               ),
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PaymentScreen(
//                         image: imageUrls[0],
//                         // name: reviews[0]['name'],
//                         name: 'Luxury Farm House',
//                       ),
//                     ),
//                   );
//                   // ScaffoldMessenger.of(context).showSnackBar(
//                   //   const SnackBar(
//                   //     content: Text('Booking initiated!'),
//                   //     behavior: SnackBarBehavior.floating,
//                   //   ),
//                   // );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: const Text(
//                   'Book Now',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFeatureItem(IconData icon, String label) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Colors.grey[100],
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(icon, size: 28, color: Colors.black),
//         ),
//         const SizedBox(height: 8),
//         Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
//       ],
//     );
//   }

//   Widget _buildReviewCard(Map<String, dynamic> review) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.black,
//                 child: Text(
//                   review['avatar'],
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       review['name'],
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     Text(
//                       review['date'],
//                       style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 children: List.generate(
//                   5,
//                   (index) => Icon(
//                     index < review['rating'] ? Icons.star : Icons.star_border,
//                     color: Colors.amber,
//                     size: 18,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             review['comment'],
//             style: TextStyle(
//               color: Colors.grey[700],
//               fontSize: 14,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:farmhouse_app/views/payment/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HouseDetailScreen extends StatefulWidget {
  const HouseDetailScreen({super.key});

  @override
  State<HouseDetailScreen> createState() => _HouseDetailScreenState();
}

class _HouseDetailScreenState extends State<HouseDetailScreen> {
  int selectedImageIndex = 0;
  String selectedPricing = 'hour';
  int? selectedDateIndex;
  String? selectedTimeSlot;

  DateTime selectedDate = DateTime.now();

  final List<String> imageUrls = [
    'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
    'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800',
    'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
    'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=800',
  ];

  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Sarah Johnson',
      'rating': 5,
      'comment':
          'Amazing place! Perfect for a weekend getaway. The views are breathtaking.',
      'date': '2 weeks ago',
      'avatar': 'SJ',
    },
    {
      'name': 'Michael Chen',
      'rating': 4,
      'comment':
          'Beautiful farmhouse with great amenities. Highly recommended for families.',
      'date': '1 month ago',
      'avatar': 'MC',
    },
    {
      'name': 'Emma Williams',
      'rating': 5,
      'comment':
          'Peaceful and serene. Exactly what we needed to disconnect from city life.',
      'date': '2 months ago',
      'avatar': 'EW',
    },
  ];

  final List<Map<String, dynamic>> timeSlots = [
    {'label': 'Day', 'time': '9am - 8pm', 'price': '₹ 8000'},
    {'label': 'Night', 'time': '9pm - 8am', 'price': '₹ 8000'},
    {'label': 'Full Day', 'time': '12pm - 10am', 'price': '₹ 9000'},
    {'label': 'Mid-Day', 'time': '3pm - 1pm', 'price': '₹ 9000'},
    {'label': 'Late-Stay', 'time': '6pm - 4pm', 'price': '₹ 12000'},
  ];

  List<DateTime> getNextSevenDays() {
    final today = DateTime.now();
    return List.generate(7, (index) => today.add(Duration(days: index)));
  }

  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6366F1),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableDates = getNextSevenDays();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Image Gallery Header
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.share, color: Colors.black),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        imageUrls[selectedImageIndex],
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${selectedImageIndex + 1}/${imageUrls.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: imageUrls.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedImageIndex = index;
                                  });
                                },
                                child: Container(
                                  width: 80,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: selectedImageIndex == index
                                          ? Colors.white
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      imageUrls[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Luxury Farm House',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.star, color: Colors.white, size: 18),
                                SizedBox(width: 4),
                                Text(
                                  '4.8',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Green Valley, Countryside',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Pricing Toggle
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedPricing = 'hour';
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: selectedPricing == 'hour'
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: selectedPricing == 'hour'
                                        ? [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.1,
                                              ),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        '\$50',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: selectedPricing == 'hour'
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        'per hour',
                                        style: TextStyle(
                                          color: selectedPricing == 'hour'
                                              ? Colors.grey[600]
                                              : Colors.grey[400],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedPricing = 'day';
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: selectedPricing == 'day'
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: selectedPricing == 'day'
                                        ? [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.1,
                                              ),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        '\$350',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: selectedPricing == 'day'
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        'per day',
                                        style: TextStyle(
                                          color: selectedPricing == 'day'
                                              ? Colors.grey[600]
                                              : Colors.grey[400],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Features
                      const Text(
                        'Features',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildFeatureItem(Icons.bed, '4 Bedrooms'),
                          _buildFeatureItem(Icons.bathtub, '3 Bathrooms'),
                          _buildFeatureItem(Icons.square_foot, '2500 sqft'),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Description
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Experience tranquility in this stunning farmhouse nestled in the countryside. Perfect for family gatherings, weekend retreats, or special celebrations. Features include a spacious garden, modern amenities, and breathtaking views.',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Available Dates Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Available Dates',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.calendar_month),
                            onPressed: () {
                              _showDatePicker();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Date Selector
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: availableDates.length,
                          itemBuilder: (context, index) {
                            final date = availableDates[index];
                            final isSelected = selectedDateIndex == index;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedDateIndex = index;
                                });
                              },
                              child: Container(
                                width: 70,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF5B67F7)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF5B67F7)
                                        : Colors.grey[300]!,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat(
                                        'EEE',
                                      ).format(date).substring(0, 3),
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF5B67F7),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      DateFormat('d').format(date),
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Choose Time Section
                      const Text(
                        'Choose Time',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // const SizedBox(height: 10),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.60,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                        itemCount: timeSlots.length,
                        itemBuilder: (context, index) {
                          final slot = timeSlots[index];
                          final isSelected = selectedTimeSlot == slot['label'];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTimeSlot = slot['label'];
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF5B67F7)
                                      : Colors.grey[300]!,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          slot['label'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? const Color(0xFF5B67F7)
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      if (isSelected)
                                        const Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF5B67F7),
                                          size: 18,
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    slot['time'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    slot['price'],
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 32),

                      // Booking Summary
                      if (selectedDateIndex != null && selectedTimeSlot != null)
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Check In :',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      DateFormat('d MMM, hh:mma').format(
                                        availableDates[selectedDateIndex!],
                                      ),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Duration',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      '1 Mrng',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Check Out :',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      DateFormat('d MMM, hh:mma').format(
                                        availableDates[selectedDateIndex!].add(
                                          const Duration(hours: 11),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 32),

                      // Reviews Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Reviews',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('See all'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Reviews List
                      ...reviews.map((review) => _buildReviewCard(review)),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Book Now Button (Fixed at bottom)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (selectedDateIndex == null || selectedTimeSlot == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select date and time slot'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        image: imageUrls[0],
                        name: 'Luxury Farm House',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 28, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
      ],
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                child: Text(
                  review['avatar'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      review['date'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < review['rating'] ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review['comment'],
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
