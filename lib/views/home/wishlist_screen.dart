// // import 'package:farmhouse_app/views/details/house_detail_screen.dart';
// // import 'package:farmhouse_app/views/payment/payment_screen.dart';
// // import 'package:flutter/material.dart';

// // class WishlistScreen extends StatefulWidget {
// //   const WishlistScreen({super.key});

// //   @override
// //   State<WishlistScreen> createState() => _WishlistScreenState();
// // }

// // class _WishlistScreenState extends State<WishlistScreen> {
// //   final List<Map<String, dynamic>> wishlistItems = [
// //     {
// //       'name': 'Green Valley Farmhouse',
// //       'location': 'Tuscany, Italy',
// //       'price': '\$450/night',
// //       'rating': 4.9,
// //       'reviews': 127,
// //       'image':
// //           'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
// //       'features': ['3 Bedrooms', 'Pool', 'Garden'],
// //     },
// //     {
// //       'name': 'Sunset Ranch Estate',
// //       'location': 'Texas, USA',
// //       'price': '\$380/night',
// //       'rating': 4.8,
// //       'reviews': 93,
// //       'image':
// //           'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
// //       'features': ['4 Bedrooms', 'Stables', 'BBQ Area'],
// //     },
// //     {
// //       'name': 'Alpine Meadow Villa',
// //       'location': 'Swiss Alps, Switzerland',
// //       'price': '\$620/night',
// //       'rating': 5.0,
// //       'reviews': 156,
// //       'image':
// //           'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800',
// //       'features': ['5 Bedrooms', 'Hot Tub', 'Mountain View'],
// //     },
// //     {
// //       'name': 'Lavender Fields Cottage',
// //       'location': 'Provence, France',
// //       'price': '\$290/night',
// //       'rating': 4.7,
// //       'reviews': 84,
// //       'image':
// //           'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=800',
// //       'features': ['2 Bedrooms', 'Garden', 'Vineyard'],
// //     },
// //   ];

// //   void _removeFromWishlist(int index) {
// //     setState(() {
// //       wishlistItems.removeAt(index);
// //     });
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: const Text('Removed from wishlist'),
// //         behavior: SnackBarBehavior.floating,
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// //         duration: const Duration(seconds: 2),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[50],
// //       appBar: AppBar(
// //         elevation: 0,
// //         backgroundColor: Colors.white,
// //         title: const Text(
// //           'Wishlist',
// //           style: TextStyle(
// //             color: Colors.black87,
// //             fontSize: 24,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         automaticallyImplyLeading: false,
// //         centerTitle: true,
// //         // actions: [
// //         //   IconButton(
// //         //     icon: const Icon(Icons.filter_list, color: Colors.black87),
// //         //     onPressed: () {},
// //         //   ),
// //         // ],
// //       ),
// //       body: wishlistItems.isEmpty
// //           ? _buildEmptyWishlist()
// //           : Column(
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Row(
// //                     children: [
// //                       Text(
// //                         '${wishlistItems.length} Properties',
// //                         style: TextStyle(
// //                           fontSize: 16,
// //                           color: Colors.grey[600],
// //                           fontWeight: FontWeight.w500,
// //                         ),
// //                       ),
// //                       const Spacer(),
// //                       TextButton.icon(
// //                         onPressed: () {},
// //                         icon: const Icon(Icons.sort, size: 18),
// //                         label: const Text('Sort'),
// //                         style: TextButton.styleFrom(
// //                           foregroundColor: Colors.green[700],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 Expanded(
// //                   child: ListView.builder(
// //                     padding: const EdgeInsets.symmetric(horizontal: 16),
// //                     itemCount: wishlistItems.length,
// //                     itemBuilder: (context, index) {
// //                       return _buildWishlistCard(wishlistItems[index], index);
// //                     },
// //                   ),
// //                 ),
// //               ],
// //             ),
// //     );
// //   }

// //   Widget _buildEmptyWishlist() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.favorite_border, size: 100, color: Colors.grey[300]),
// //           const SizedBox(height: 24),
// //           Text(
// //             'Your wishlist is empty',
// //             style: TextStyle(
// //               fontSize: 22,
// //               fontWeight: FontWeight.bold,
// //               color: Colors.grey[700],
// //             ),
// //           ),
// //           const SizedBox(height: 12),
// //           Text(
// //             'Start adding farmhouses you love!',
// //             style: TextStyle(fontSize: 16, color: Colors.grey[500]),
// //           ),
// //           const SizedBox(height: 32),
// //           ElevatedButton(
// //             onPressed: () {},
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.green[700],
// //               foregroundColor: Colors.white,
// //               padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //             ),
// //             child: const Text(
// //               'Explore Properties',
// //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildWishlistCard(Map<String, dynamic> item, int index) {
// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 16),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.08),
// //             blurRadius: 10,
// //             offset: const Offset(0, 4),
// //           ),
// //         ],
// //       ),
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Stack(
// //               children: [
// //                 GestureDetector(
// //                   onTap: () {
// //                     Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseDetailScreen()));
// //                   },
// //                   child: Image.network(
// //                     item['image'],
// //                     height: 220,
// //                     width: double.infinity,
// //                     fit: BoxFit.cover,
// //                     errorBuilder: (context, error, stackTrace) {
// //                       return Container(
// //                         height: 220,
// //                         color: Colors.grey[300],
// //                         child: const Icon(
// //                           Icons.home,
// //                           size: 60,
// //                           color: Colors.grey,
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //                 Positioned(
// //                   top: 12,
// //                   right: 12,
// //                   child: Container(
// //                     decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       shape: BoxShape.circle,
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: Colors.black.withOpacity(0.2),
// //                           blurRadius: 8,
// //                         ),
// //                       ],
// //                     ),
// //                     child: IconButton(
// //                       icon: const Icon(Icons.favorite, color: Colors.red),
// //                       onPressed: () => _removeFromWishlist(index),
// //                     ),
// //                   ),
// //                 ),
// //                 Positioned(
// //                   bottom: 12,
// //                   left: 12,
// //                   child: Container(
// //                     padding: const EdgeInsets.symmetric(
// //                       horizontal: 12,
// //                       vertical: 6,
// //                     ),
// //                     decoration: BoxDecoration(
// //                       color: Colors.black.withOpacity(0.6),
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                     child: Row(
// //                       children: [
// //                         const Icon(Icons.star, color: Colors.amber, size: 16),
// //                         const SizedBox(width: 4),
// //                         Text(
// //                           '${item['rating']} (${item['reviews']})',
// //                           style: const TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 13,
// //                             fontWeight: FontWeight.w600,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(16),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     item['name'],
// //                     style: const TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.black87,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 6),
// //                   Row(
// //                     children: [
// //                       Icon(
// //                         Icons.location_on,
// //                         size: 16,
// //                         color: Colors.grey[600],
// //                       ),
// //                       const SizedBox(width: 4),
// //                       Text(
// //                         item['location'],
// //                         style: TextStyle(fontSize: 14, color: Colors.grey[600]),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 12),
// //                   Wrap(
// //                     spacing: 8,
// //                     runSpacing: 8,
// //                     children: (item['features'] as List<String>).map((feature) {
// //                       return Container(
// //                         padding: const EdgeInsets.symmetric(
// //                           horizontal: 10,
// //                           vertical: 6,
// //                         ),
// //                         decoration: BoxDecoration(
// //                           color: Colors.green[50],
// //                           borderRadius: BorderRadius.circular(8),
// //                           border: Border.all(color: Colors.green[200]!),
// //                         ),
// //                         child: Text(
// //                           feature,
// //                           style: TextStyle(
// //                             fontSize: 12,
// //                             color: Color(0xFFFF5A5F),
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                       );
// //                     }).toList(),
// //                   ),
// //                   const SizedBox(height: 16),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Text(
// //                         item['price'],
// //                         style: TextStyle(
// //                           fontSize: 22,
// //                           fontWeight: FontWeight.bold,
// //                           color: Color(0xFFFF5A5F),
// //                         ),
// //                       ),
// //                       ElevatedButton(
// //                         onPressed: () {
// //                           Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentScreen()));
// //                         },
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: Color(0xFFFF5A5F),
// //                           foregroundColor: Colors.white,
// //                           padding: const EdgeInsets.symmetric(
// //                             horizontal: 24,
// //                             vertical: 12,
// //                           ),
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(10),
// //                           ),
// //                         ),
// //                         child: const Text(
// //                           'Book Now',
// //                           style: TextStyle(fontWeight: FontWeight.w600),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:farmhouse_app/views/details/house_detail_screen.dart';
// import 'package:farmhouse_app/views/payment/payment_screen.dart';
// import 'package:farmhouse_app/widgets/like_widget.dart';
// import 'package:flutter/material.dart';

// class WishlistScreen extends StatefulWidget {
//   const WishlistScreen({super.key});

//   @override
//   State<WishlistScreen> createState() => _WishlistScreenState();
// }

// class _WishlistScreenState extends State<WishlistScreen> {
//   final WishlistManager wishlistManager = WishlistManager();

//   @override
//   void initState() {

//     super.initState();
//     wishlistManager.addListener(_onWishlistChanged);
//   }

//   @override
//   void dispose() {
//     wishlistManager.removeListener(_onWishlistChanged);
//     super.dispose();
//   }

//   void _onWishlistChanged() {
//     setState(() {});
//   }

//   void _removeFromWishlist(Map<String, dynamic> item) {
//     wishlistManager.removeFromWishlist(item['title']);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text('Removed from wishlist'),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final wishlistItems = wishlistManager.wishlistItems;

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Wishlist',
//           style: TextStyle(
//             color: Colors.black87,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//       ),
//       body: wishlistItems.isEmpty
//           ? _buildEmptyWishlist()
//           : Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     children: [
//                       Text(
//                         '${wishlistItems.length} Properties',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey[600],
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const Spacer(),
//                       TextButton.icon(
//                         onPressed: () {},
//                         icon: const Icon(Icons.sort, size: 18),
//                         label: const Text('Sort'),
//                         style: TextButton.styleFrom(
//                           foregroundColor: Colors.green[700],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     itemCount: wishlistItems.length,
//                     itemBuilder: (context, index) {
//                       return _buildWishlistCard(wishlistItems[index]);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }

//   Widget _buildEmptyWishlist() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.favorite_border, size: 100, color: Colors.grey[300]),
//           const SizedBox(height: 24),
//           Text(
//             'Your wishlist is empty',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[700],
//             ),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             'Your favourite list is currently empy\nStart adding items to create your\n               Personel Collection!',
//             style: TextStyle(fontSize: 16, color: Colors.grey[500]),
//           ),
//           const SizedBox(height: 32),
//           // ElevatedButton(
//           //   onPressed: () {},
//           //   style: ElevatedButton.styleFrom(
//           //     backgroundColor: Color(0xFFFF5A5F),
//           //     foregroundColor: Colors.white,
//           //     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//           //     shape: RoundedRectangleBorder(
//           //       borderRadius: BorderRadius.circular(12),
//           //     ),
//           //   ),
//           //   child: const Text(
//           //     'Explore Properties',
//           //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget _buildWishlistCard(Map<String, dynamic> item) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
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
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const HouseDetailScreen(),
//                       ),
//                     );
//                   },
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(16),
//                     ),
//                     child: Image.asset(
//                       item['imageUrl'],
//                       height: 220,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           height: 220,
//                           color: Colors.grey[300],
//                           child: const Icon(
//                             Icons.home,
//                             size: 60,
//                             color: Colors.grey,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 12,
//                   right: 12,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           blurRadius: 8,
//                         ),
//                       ],
//                     ),
//                     child: IconButton(
//                       icon: const Icon(Icons.favorite, color: Colors.red),
//                       onPressed: () => _removeFromWishlist(item),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 12,
//                   left: 12,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 4,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       item['tag'],
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item['title'],
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.location_on,
//                         size: 16,
//                         color: Colors.grey[600],
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         item['location'],
//                         style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       _buildFeatureChip(Icons.bed_outlined, item['bed']),
//                       const SizedBox(width: 8),
//                       _buildFeatureChip(Icons.bathtub_outlined, item['bath']),
//                       const SizedBox(width: 8),
//                       _buildFeatureChip(Icons.square_foot, item['area']),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         item['price'],
//                         style: const TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFFFF5A5F),
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => PaymentScreen(),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFFF5A5F),
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 24,
//                             vertical: 12,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: const Text(
//                           'Book Now',
//                           style: TextStyle(fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFeatureChip(IconData icon, String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.green[50],
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.green[200]!),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 14, color: Colors.green[700]),
//           const SizedBox(width: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.green[700],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:farmhouse_app/views/details/house_detail_screen.dart';
// import 'package:farmhouse_app/views/payment/payment_screen.dart';
// import 'package:farmhouse_app/widgets/like_widget.dart';
// import 'package:flutter/material.dart';

// class WishlistScreen extends StatefulWidget {
//   const WishlistScreen({super.key});

//   @override
//   State<WishlistScreen> createState() => _WishlistScreenState();
// }

// class _WishlistScreenState extends State<WishlistScreen> {
//   final WishlistManager wishlistManager = WishlistManager();

//   @override
//   void initState() {
//     super.initState();
//     wishlistManager.addListener(_onWishlistChanged);
//   }

//   @override
//   void dispose() {
//     wishlistManager.removeListener(_onWishlistChanged);
//     super.dispose();
//   }

//   void _onWishlistChanged() {
//     setState(() {});
//   }

//   void _removeFromWishlist(Map<String, dynamic> item) {
//     wishlistManager.removeFromWishlist(item['title']);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text('Removed from wishlist'),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final wishlistItems = wishlistManager.wishlistItems;

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Wishlist',
//           style: TextStyle(
//             color: Colors.black87,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//       ),
//       body: wishlistItems.isEmpty
//           ? _buildEmptyWishlist()
//           : Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     children: [
//                       Text(
//                         '${wishlistItems.length} Properties',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey[600],
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const Spacer(),
//                       TextButton.icon(
//                         onPressed: () {},
//                         icon: const Icon(Icons.sort, size: 18),
//                         label: const Text('Sort'),
//                         style: TextButton.styleFrom(
//                           foregroundColor: Colors.green[700],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     itemCount: wishlistItems.length,
//                     itemBuilder: (context, index) {
//                       return _buildWishlistCard(wishlistItems[index]);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }

//   Widget _buildEmptyWishlist() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.favorite_border, size: 100, color: Colors.grey[300]),
//           const SizedBox(height: 24),
//           Text(
//             'Your wishlist is empty',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[700],
//             ),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             'Your favourite list is currently empty\nStart adding items to create your\n               Personal Collection!',
//             style: TextStyle(fontSize: 16, color: Colors.grey[500]),
//           ),
//           const SizedBox(height: 32),
//         ],
//       ),
//     );
//   }

//   Widget _buildWishlistCard(Map<String, dynamic> item) {
//     // Safely get values with null checks
//     final String imageUrl = item['imageUrl'] ?? 'assets/farmhouseimage.jpg';
//     final String title = item['title'] ?? 'Unknown Property';
//     final String location = item['location'] ?? 'Unknown Location';
//     final String price = item['price'] ?? '₹0';
//     final String tag = item['tag'] ?? 'For Sale';
//     final String? bed = item['bed'];
//     final String? bath = item['bath'];
//     final String? area = item['area'];

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
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
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const HouseDetailScreen(),
//                       ),
//                     );
//                   },
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(16),
//                     ),
//                     child: Image.asset(
//                       imageUrl,
//                       height: 150,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           height: 220,
//                           color: Colors.grey[300],
//                           child: const Icon(
//                             Icons.home,
//                             size: 60,
//                             color: Colors.grey,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 12,
//                   right: 12,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           blurRadius: 8,
//                         ),
//                       ],
//                     ),
//                     child: IconButton(
//                       icon: const Icon(Icons.favorite, color: Colors.red),
//                       onPressed: () => _removeFromWishlist(item),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 12,
//                   left: 12,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 4,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       tag,
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.location_on,
//                         size: 16,
//                         color: Colors.grey[600],
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         location,
//                         style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   // Only show features if they exist
//                   if (bed != null || bath != null || area != null)
//                     Row(
//                       children: [
//                         if (bed != null) ...[
//                           _buildFeatureChip(Icons.bed_outlined, bed),
//                           const SizedBox(width: 8),
//                         ],
//                         if (bath != null) ...[
//                           _buildFeatureChip(Icons.bathtub_outlined, bath),
//                           const SizedBox(width: 8),
//                         ],
//                         if (area != null)
//                           _buildFeatureChip(Icons.square_foot, area),
//                       ],
//                     ),
//                   if (bed != null || bath != null || area != null)
//                     const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             price,
//                             style: const TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFFFF5A5F),
//                             ),
//                           ),
//                           Text(
//                             '/Month',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => PaymentScreen(),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFFF5A5F),
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 24,
//                             vertical: 12,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: const Text(
//                           'Book Now',
//                           style: TextStyle(fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFeatureChip(IconData icon, String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.green[50],
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.green[200]!),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 14, color: Colors.green[700]),
//           const SizedBox(width: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.green[700],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





import 'package:farmhouse_app/views/details/house_detail_screen.dart';
import 'package:farmhouse_app/views/payment/payment_screen.dart';
import 'package:farmhouse_app/widgets/like_widget.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishlistManager wishlistManager = WishlistManager();

  @override
  void initState() {
    super.initState();
    wishlistManager.addListener(_onWishlistChanged);
  }

  @override
  void dispose() {
    wishlistManager.removeListener(_onWishlistChanged);
    super.dispose();
  }

  void _onWishlistChanged() {
    setState(() {});
  }

  void _removeFromWishlist(Map<String, dynamic> item) {
    wishlistManager.removeFromWishlist(item['name']);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Removed from wishlist'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wishlistItems = wishlistManager.wishlistItems;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Wishlist',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: wishlistItems.isEmpty
          ? _buildEmptyWishlist()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 12,
                      //     vertical: 6,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: Colors.green[50],
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //   child: Text(
                      //     '${wishlistItems.length} Properties',
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       color: Colors.green[700],
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // ),
                      const Spacer(),
                      // TextButton.icon(
                      //   onPressed: () {},
                      //   icon: const Icon(Icons.sort, size: 18),
                      //   label: const Text('Sort'),
                      //   style: TextButton.styleFrom(
                      //     foregroundColor: Colors.green[700],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    itemCount: wishlistItems.length,
                    itemBuilder: (context, index) {
                      return _buildWishlistCard(wishlistItems[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.pink[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_border,
              size: 80,
              color: Colors.pink[300],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your wishlist is empty',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Start adding properties you love\nto build your dream collection',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildWishlistCard(Map<String, dynamic> item) {
    final String imageUrl = item['imageUrl'] ?? 'assets/farmhouseimage.jpg';
    final String title = item['name'] ?? 'Unknown Property';
    final String location = item['location'] ?? 'Unknown Location';
    final String price = item['price'] ?? '₹0';
    final String tag = item['tag'] ?? 'For Sale';
    final String? bed = item['bed'];
    final String? bath = item['bath'];
    final String? area = item['area'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HouseDetailScreen()),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Compact Image with tag
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imageUrl,
                      height: 110,
                      width: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.home_outlined,
                            size: 40,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                    ),
                  ),
                  // Positioned(
                  //   top: 8,
                  //   left: 8,
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 8,
                  //       vertical: 4,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: Colors.green[600],
                  //       borderRadius: BorderRadius.circular(6),
                  //     ),
                  //     child: Text(
                  //       tag,
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 10,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(width: 12),
              // Property Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          // decoration: BoxDecoration(
                          //   color: Colors.red[50],
                          //   shape: BoxShape.circle,
                          // ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.favorite,
                              color: Color(0xFFFF5A5F),
                              size: 20,
                            ),
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(),
                            onPressed: () => _removeFromWishlist(item),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Features
                    if (bed != null || bath != null || area != null)
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: [
                          if (bed != null)
                            _buildCompactFeatureChip(Icons.bed_outlined, bed),
                          if (bath != null)
                            _buildCompactFeatureChip(
                              Icons.bathtub_outlined,
                              bath,
                            ),
                          if (area != null)
                            _buildCompactFeatureChip(Icons.square_foot, area),
                        ],
                      ),
                    const SizedBox(height: 10),
                    // Price and Book Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                price,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF5A5F),
                                ),
                              ),
                              // Text(
                              //   '/Month',
                              //   style: TextStyle(
                              //     fontSize: 11,
                              //     color: Colors.grey[500],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PaymentScreen(image: imageUrl),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF5A5F),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Book Now',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
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
        ),
      ),
    );
  }

  Widget _buildCompactFeatureChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.green[200]!, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.green[700]),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.green[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
