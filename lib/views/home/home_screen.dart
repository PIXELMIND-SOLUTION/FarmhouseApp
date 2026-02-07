// // // // import 'package:farmhouse_app/views/details/house_detail_screen.dart';
// // // // import 'package:farmhouse_app/views/home/nearest_houses.dart';
// // // // import 'package:farmhouse_app/views/location/location_screen.dart';
// // // // import 'package:farmhouse_app/views/notifications/notification_screen.dart';
// // // // import 'package:flutter/material.dart';

// // // // class HomeScreen extends StatefulWidget {
// // // //   const HomeScreen({super.key});

// // // //   @override
// // // //   State<HomeScreen> createState() => _HomeScreenState();
// // // // }

// // // // class _HomeScreenState extends State<HomeScreen> {
// // // //   List<Map<String, dynamic>> products = [
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "tag": "For Sale",
// // // //       "title": "Modern Apartment in City Center",
// // // //       "location": "Kakinada",
// // // //       "price": "₹25,000",
// // // //       "bed": "4 Bed",
// // // //       "bath": "2 Bath",
// // // //       "area": "7,500 sqft",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "tag": "For Sale",
// // // //       "title": "Luxury Villa with Pool",
// // // //       "location": "Kakinada",
// // // //       "price": "₹7,50,000",
// // // //       "bed": "4 Bed",
// // // //       "bath": "2 Bath",
// // // //       "area": "7,500 sqft",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "tag": "For Sale",
// // // //       "title": "Cozy 2BHK House",
// // // //       "location": "Kakinada",
// // // //       "price": "₹18,000",
// // // //       "bed": "4 Bed",
// // // //       "bath": "2 Bath",
// // // //       "area": "7,500 sqft",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "tag": "For Sale",
// // // //       "title": "Sea View Apartment",
// // // //       "location": "Kakinada",
// // // //       "price": "₹32,000",
// // // //       "bed": "4 Bed",
// // // //       "bath": "2 Bath",
// // // //       "area": "7,500 sqft",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "tag": "For Sale",
// // // //       "title": "Boutique Hotel Space",
// // // //       "location": "Kakinada",
// // // //       "price": "₹1,50,000",
// // // //       "bed": "4 Bed",
// // // //       "bath": "2 Bath",
// // // //       "area": "7,500 sqft",
// // // //     },
// // // //   ];

// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.white,
// // // //       appBar: AppBar(
// // // //         backgroundColor: Colors.white,
// // // //         elevation: 0,
// // // //         leading: const Padding(
// // // //           padding: EdgeInsets.only(left: 10),
// // // //           child: CircleAvatar(
// // // //             backgroundImage: NetworkImage(
// // // //               'https://upload.wikimedia.org/wikipedia/en/thumb/d/d6/Superman_Man_of_Steel.jpg/250px-Superman_Man_of_Steel.jpg',
// // // //             ),
// // // //           ),
// // // //         ),
// // // //         title: const Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: [
// // // //             Text(
// // // //               'Good Morning',
// // // //               style: TextStyle(fontSize: 14, color: Colors.black54),
// // // //             ),
// // // //             Text(
// // // //               'PMS',
// // // //               style: TextStyle(
// // // //                 fontSize: 16,
// // // //                 fontWeight: FontWeight.bold,
// // // //                 color: Colors.black,
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //         actions: [
// // // //           GestureDetector(
// // // //             onTap: () {
// // // //               Navigator.push(
// // // //                 context,
// // // //                 MaterialPageRoute(builder: (context) => LocationScreen()),
// // // //               );
// // // //             },
// // // //             child: Container(
// // // //               width: 40,
// // // //               height: 40,
// // // //               decoration: BoxDecoration(
// // // //                 borderRadius: BorderRadius.circular(8),
// // // //                 border: Border.all(color: Colors.grey),
// // // //               ),
// // // //               child: const Icon(Icons.location_on, color: Colors.black),
// // // //             ),
// // // //           ),
// // // //           const SizedBox(width: 16),
// // // //           GestureDetector(
// // // //             onTap: () {
// // // //               Navigator.push(
// // // //                 context,
// // // //                 MaterialPageRoute(
// // // //                   builder: (context) => const NotificationScreen(),
// // // //                 ),
// // // //               );
// // // //             },
// // // //             child: Container(
// // // //               width: 40,
// // // //               height: 40,
// // // //               decoration: BoxDecoration(
// // // //                 border: Border.all(color: Colors.grey),
// // // //                 borderRadius: BorderRadius.circular(8),
// // // //               ),
// // // //               child: Stack(
// // // //                 children: [
// // // //                   const Center(
// // // //                     child: Icon(Icons.notifications_none, color: Colors.black),
// // // //                   ),
// // // //                   Positioned(
// // // //                     right: 8,
// // // //                     top: 8,
// // // //                     child: Container(
// // // //                       width: 8,
// // // //                       height: 8,
// // // //                       decoration: const BoxDecoration(
// // // //                         color: Colors.red,
// // // //                         shape: BoxShape.circle,
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ),
// // // //           const SizedBox(width: 16),
// // // //         ],
// // // //       ),
// // // //       body: SingleChildScrollView(
// // // //         padding: const EdgeInsets.symmetric(horizontal: 16),
// // // //         child: Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: [
// // // //             const SizedBox(height: 12),
// // // //             Row(
// // // //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// // // //               children: [
// // // //                 Expanded(
// // // //                   child: TextField(
// // // //                     decoration: InputDecoration(
// // // //                       hintText: 'Search',
// // // //                       prefixIcon: const Icon(Icons.search),
// // // //                       filled: true,
// // // //                       fillColor: Colors.white,
// // // //                       enabledBorder: OutlineInputBorder(
// // // //                         borderRadius: BorderRadius.circular(30),
// // // //                         borderSide: const BorderSide(
// // // //                           color: Color.fromARGB(255, 221, 221, 221),
// // // //                           width: 2,
// // // //                         ),
// // // //                       ),
// // // //                       focusedBorder: OutlineInputBorder(
// // // //                         borderRadius: BorderRadius.circular(30),
// // // //                         borderSide: const BorderSide(
// // // //                           color: Color.fromARGB(255, 217, 216, 216),
// // // //                           width: 2,
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //                 const SizedBox(width: 10),
// // // //               ],
// // // //             ),
// // // //             const SizedBox(height: 16),

// // // //             const SizedBox(height: 20),

// // // //             Row(
// // // //               children: [
// // // //                 const Text(
// // // //                   'Nearest Farm Houses',
// // // //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // //                 ),
// // // //                 const Spacer(),
// // // //                 GestureDetector(
// // // //                   onTap: () {
// // // //                     Navigator.push(
// // // //                       context,
// // // //                       MaterialPageRoute(builder: (context) => NearestHouses()),
// // // //                     );
// // // //                   },
// // // //                   child: const Text(
// // // //                     'See All',
// // // //                     style: TextStyle(color: Colors.black),
// // // //                   ),
// // // //                 ),
// // // //                 const SizedBox(width: 4),
// // // //                 const Icon(Icons.arrow_forward_ios, size: 13),
// // // //               ],
// // // //             ),
// // // //             const SizedBox(height: 10),
// // // //             ListView.builder(
// // // //               shrinkWrap: true,
// // // //               physics: const NeverScrollableScrollPhysics(),
// // // //               itemCount: products.length,
// // // //               itemBuilder: (context, index) {
// // // //                 final house = products[index];
// // // //                 return Container(
// // // //                   margin: const EdgeInsets.only(bottom: 16),
// // // //                   padding: const EdgeInsets.all(8),
// // // //                   decoration: BoxDecoration(
// // // //                     border: Border.all(color: Colors.grey.shade300, width: 1),
// // // //                     borderRadius: BorderRadius.circular(12),
// // // //                   ),
// // // //                   child: Column(
// // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // //                     children: [
// // // //                       Stack(
// // // //                         children: [
// // // //                           GestureDetector(
// // // //                             onTap: () {
// // // //                               Navigator.push(
// // // //                                 context,
// // // //                                 MaterialPageRoute(
// // // //                                   builder: (context) =>
// // // //                                       const HouseDetailScreen(),
// // // //                                 ),
// // // //                               );
// // // //                             },
// // // //                             child: ClipRRect(
// // // //                               borderRadius: BorderRadius.circular(10),
// // // //                               child: Image.asset(
// // // //                                 house['imageUrl'],
// // // //                                 height: 160,
// // // //                                 width: double.infinity,
// // // //                                 fit: BoxFit.cover,
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                           Positioned(
// // // //                             top: 8,
// // // //                             left: 8,
// // // //                             child: Container(
// // // //                               padding: const EdgeInsets.symmetric(
// // // //                                 horizontal: 8,
// // // //                                 vertical: 4,
// // // //                               ),
// // // //                               decoration: BoxDecoration(
// // // //                                 color: Colors.white,
// // // //                                 borderRadius: BorderRadius.circular(20),
// // // //                               ),
// // // //                               child: Text(
// // // //                                 house['tag'],
// // // //                                 style: const TextStyle(
// // // //                                   color: Colors.black,
// // // //                                   fontSize: 12,
// // // //                                 ),
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                           Positioned(
// // // //                             top: 8,
// // // //                             right: 8,
// // // //                             child: CircleAvatar(
// // // //                               backgroundColor: Colors.white,
// // // //                               child: IconButton(
// // // //                                 icon: const Icon(
// // // //                                   Icons.favorite_border,
// // // //                                   color: Colors.black,
// // // //                                 ),
// // // //                                 onPressed: () {},
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                       const SizedBox(height: 8),
// // // //                       Text(
// // // //                         house['title'],
// // // //                         style: const TextStyle(
// // // //                           fontWeight: FontWeight.w600,
// // // //                           fontSize: 15,
// // // //                         ),
// // // //                       ),
// // // //                       const SizedBox(height: 6),
// // // //                       Row(
// // // //                         children: [
// // // //                           _iconText(Icons.bed_outlined, house['bed']),
// // // //                           const SizedBox(width: 8),
// // // //                           _iconText(Icons.bathtub_outlined, house['bath']),
// // // //                           const SizedBox(width: 8),
// // // //                           _iconText(Icons.square_foot, house['area']),
// // // //                         ],
// // // //                       ),
// // // //                       const SizedBox(height: 6),
// // // //                       Row(
// // // //                         children: [
// // // //                           const Icon(Icons.location_on_outlined, size: 16),
// // // //                           Text(
// // // //                             house['location'],
// // // //                             style: const TextStyle(fontSize: 13),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                 );
// // // //               },
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //   Widget _iconText(IconData icon, String label) {
// // // //     return Container(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
// // // //       decoration: BoxDecoration(
// // // //         border: Border.all(color: Colors.grey.shade300),
// // // //         borderRadius: BorderRadius.circular(16),
// // // //       ),
// // // //       child: Row(
// // // //         children: [
// // // //           Icon(icon, size: 14),
// // // //           const SizedBox(width: 4),
// // // //           Text(label, style: const TextStyle(fontSize: 12)),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // import 'package:farmhouse_app/views/details/house_detail_screen.dart';
// // // // import 'package:farmhouse_app/views/home/nearest_houses.dart';
// // // // import 'package:farmhouse_app/views/location/location_screen.dart';
// // // // import 'package:farmhouse_app/views/notifications/notification_screen.dart';
// // // // import 'package:farmhouse_app/widgets/like_widget.dart';
// // // // import 'package:flutter/material.dart';

// // // // class HomeScreen extends StatefulWidget {
// // // //   const HomeScreen({super.key});

// // // //   @override
// // // //   State<HomeScreen> createState() => _HomeScreenState();
// // // // }

// // // // class _HomeScreenState extends State<HomeScreen> {
// // // //   final WishlistManager wishlistManager = WishlistManager();

// // // //   List<Map<String, dynamic>> products = [
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "tag": "For Sale",
// // // //       "title": "Modern Apartment in City Center",
// // // //       "location": "Kakinada",
// // // //       "price": "₹25,000",
// // // //       "bed": "4 Bed",
// // // //       "bath": "2 Bath",
// // // //       "area": "7,500 sqft",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "tag": "For Sale",
// // // //       "title": "Luxury Villa with Pool",
// // // //       "location": "Kakinada",
// // // //       "price": "₹7,50,000",
// // // //       "bed": "4 Bed",
// // // //       "bath": "2 Bath",
// // // //       "area": "7,500 sqft",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "tag": "For Sale",
// // // //       "title": "Cozy 2BHK House",
// // // //       "location": "Kakinada",
// // // //       "price": "₹18,000",
// // // //       "bed": "4 Bed",
// // // //       "bath": "2 Bath",
// // // //       "area": "7,500 sqft",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "tag": "For Sale",
// // // //       "title": "Sea View Apartment",
// // // //       "location": "Kakinada",
// // // //       "price": "₹32,000",
// // // //       "bed": "4 Bed",
// // // //       "bath": "2 Bath",
// // // //       "area": "7,500 sqft",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "tag": "For Sale",
// // // //       "title": "Boutique Hotel Space",
// // // //       "location": "Kakinada",
// // // //       "price": "₹1,50,000",
// // // //       "bed": "4 Bed",
// // // //       "bath": "2 Bath",
// // // //       "area": "7,500 sqft",
// // // //     },
// // // //   ];

// // // //   // void _toggleWishlist(Map<String, dynamic> house) {
// // // //   //   setState(() {
// // // //   //     wishlistManager.toggleWishlist(house);
// // // //   //   });

// // // //   //   ScaffoldMessenger.of(context).showSnackBar(
// // // //   //     SnackBar(
// // // //   //       backgroundColor: Colors.green,
// // // //   //       content: Text(
// // // //   //         wishlistManager.isInWishlist(house['title'])
// // // //   //             ? 'Added to wishlist'
// // // //   //             : 'Removed from wishlist',
// // // //   //       ),
// // // //   //       behavior: SnackBarBehavior.floating,
// // // //   //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// // // //   //       duration: const Duration(seconds: 2),
// // // //   //     ),
// // // //   //   );
// // // //   // }

// // // // void _toggleWishlist(Map<String, dynamic> house) {
// // // //   // Check current status BEFORE toggling
// // // //   final bool isAlreadyInWishlist = wishlistManager.isInWishlist(house['title']);

// // // //   setState(() {
// // // //     wishlistManager.toggleWishlist(house);
// // // //   });

// // // //   // Show proper color and message
// // // //   ScaffoldMessenger.of(context).showSnackBar(
// // // //     SnackBar(
// // // //       backgroundColor: isAlreadyInWishlist ? Colors.red : Colors.green,
// // // //       content: Text(
// // // //         isAlreadyInWishlist
// // // //             ? 'Removed from wishlist'
// // // //             : 'Added to wishlist',
// // // //       ),
// // // //       behavior: SnackBarBehavior.floating,
// // // //       shape: RoundedRectangleBorder(
// // // //         borderRadius: BorderRadius.circular(10),
// // // //       ),
// // // //       duration: const Duration(seconds: 2),
// // // //     ),
// // // //   );
// // // // }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.white,
// // // //       appBar: AppBar(
// // // //         backgroundColor: Colors.white,
// // // //         elevation: 0,
// // // //         leading: const Padding(
// // // //           padding: EdgeInsets.only(left: 10),
// // // //           child: CircleAvatar(
// // // //             backgroundImage: NetworkImage(
// // // //               'https://upload.wikimedia.org/wikipedia/en/thumb/d/d6/Superman_Man_of_Steel.jpg/250px-Superman_Man_of_Steel.jpg',
// // // //             ),
// // // //           ),
// // // //         ),
// // // //         title: const Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: [
// // // //             Text(
// // // //               'Good Morning',
// // // //               style: TextStyle(fontSize: 14, color: Colors.black54),
// // // //             ),
// // // //             Text(
// // // //               'PMS',
// // // //               style: TextStyle(
// // // //                 fontSize: 16,
// // // //                 fontWeight: FontWeight.bold,
// // // //                 color: Colors.black,
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //         actions: [
// // // //           GestureDetector(
// // // //             onTap: () {
// // // //               Navigator.push(
// // // //                 context,
// // // //                 MaterialPageRoute(builder: (context) => LocationScreen()),
// // // //               );
// // // //             },
// // // //             child: Container(
// // // //               width: 40,
// // // //               height: 40,
// // // //               decoration: BoxDecoration(
// // // //                 borderRadius: BorderRadius.circular(8),
// // // //                 border: Border.all(color: Colors.grey),
// // // //               ),
// // // //               child: const Icon(Icons.location_on, color: Colors.black),
// // // //             ),
// // // //           ),
// // // //           const SizedBox(width: 16),
// // // //           GestureDetector(
// // // //             onTap: () {
// // // //               Navigator.push(
// // // //                 context,
// // // //                 MaterialPageRoute(
// // // //                   builder: (context) => const NotificationScreen(),
// // // //                 ),
// // // //               );
// // // //             },
// // // //             child: Container(
// // // //               width: 40,
// // // //               height: 40,
// // // //               decoration: BoxDecoration(
// // // //                 border: Border.all(color: Colors.grey),
// // // //                 borderRadius: BorderRadius.circular(8),
// // // //               ),
// // // //               child: Stack(
// // // //                 children: [
// // // //                   const Center(
// // // //                     child: Icon(Icons.notifications_none, color: Colors.black),
// // // //                   ),
// // // //                   Positioned(
// // // //                     right: 8,
// // // //                     top: 8,
// // // //                     child: Container(
// // // //                       width: 8,
// // // //                       height: 8,
// // // //                       decoration: const BoxDecoration(
// // // //                         color: Colors.red,
// // // //                         shape: BoxShape.circle,
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ),
// // // //           const SizedBox(width: 16),
// // // //         ],
// // // //       ),
// // // //       body: SingleChildScrollView(
// // // //         padding: const EdgeInsets.symmetric(horizontal: 16),
// // // //         child: Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: [
// // // //             const SizedBox(height: 12),
// // // //             Row(
// // // //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// // // //               children: [
// // // //                 Expanded(
// // // //                   child: TextField(
// // // //                     decoration: InputDecoration(
// // // //                       hintText: 'Search',
// // // //                       prefixIcon: const Icon(Icons.search),
// // // //                       filled: true,
// // // //                       fillColor: Colors.white,
// // // //                       enabledBorder: OutlineInputBorder(
// // // //                         borderRadius: BorderRadius.circular(30),
// // // //                         borderSide: const BorderSide(
// // // //                           color: Color.fromARGB(255, 221, 221, 221),
// // // //                           width: 2,
// // // //                         ),
// // // //                       ),
// // // //                       focusedBorder: OutlineInputBorder(
// // // //                         borderRadius: BorderRadius.circular(30),
// // // //                         borderSide: const BorderSide(
// // // //                           color: Color.fromARGB(255, 217, 216, 216),
// // // //                           width: 2,
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //                 const SizedBox(width: 10),
// // // //               ],
// // // //             ),
// // // //             const SizedBox(height: 16),
// // // //             const SizedBox(height: 20),
// // // //             Row(
// // // //               children: [
// // // //                 const Text(
// // // //                   'Nearest Farm Houses',
// // // //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // //                 ),
// // // //                 const Spacer(),
// // // //                 GestureDetector(
// // // //                   onTap: () {
// // // //                     Navigator.push(
// // // //                       context,
// // // //                       MaterialPageRoute(builder: (context) => NearestHouses()),
// // // //                     );
// // // //                   },
// // // //                   child: const Text(
// // // //                     'See All',
// // // //                     style: TextStyle(color: Colors.black),
// // // //                   ),
// // // //                 ),
// // // //                 const SizedBox(width: 4),
// // // //                 const Icon(Icons.arrow_forward_ios, size: 13),
// // // //               ],
// // // //             ),
// // // //             const SizedBox(height: 10),
// // // //             ListView.builder(
// // // //               shrinkWrap: true,
// // // //               physics: const NeverScrollableScrollPhysics(),
// // // //               itemCount: products.length,
// // // //               itemBuilder: (context, index) {
// // // //                 final house = products[index];
// // // //                 final isInWishlist = wishlistManager.isInWishlist(house['title']);

// // // //                 return Container(
// // // //                   margin: const EdgeInsets.only(bottom: 16),
// // // //                   padding: const EdgeInsets.all(8),
// // // //                   decoration: BoxDecoration(
// // // //                     border: Border.all(color: Colors.grey.shade300, width: 1),
// // // //                     borderRadius: BorderRadius.circular(12),
// // // //                   ),
// // // //                   child: Column(
// // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // //                     children: [
// // // //                       Stack(
// // // //                         children: [
// // // //                           GestureDetector(
// // // //                             onTap: () {
// // // //                               Navigator.push(
// // // //                                 context,
// // // //                                 MaterialPageRoute(
// // // //                                   builder: (context) =>
// // // //                                       const HouseDetailScreen(),
// // // //                                 ),
// // // //                               );
// // // //                             },
// // // //                             child: ClipRRect(
// // // //                               borderRadius: BorderRadius.circular(10),
// // // //                               child: Image.asset(
// // // //                                 house['imageUrl'],
// // // //                                 height: 160,
// // // //                                 width: double.infinity,
// // // //                                 fit: BoxFit.cover,
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                           Positioned(
// // // //                             top: 8,
// // // //                             left: 8,
// // // //                             child: Container(
// // // //                               padding: const EdgeInsets.symmetric(
// // // //                                 horizontal: 8,
// // // //                                 vertical: 4,
// // // //                               ),
// // // //                               decoration: BoxDecoration(
// // // //                                 color: Colors.white,
// // // //                                 borderRadius: BorderRadius.circular(20),
// // // //                               ),
// // // //                               child: Text(
// // // //                                 house['tag'],
// // // //                                 style: const TextStyle(
// // // //                                   color: Colors.black,
// // // //                                   fontSize: 12,
// // // //                                 ),
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                           Positioned(
// // // //                             top: 8,
// // // //                             right: 8,
// // // //                             child: CircleAvatar(
// // // //                               backgroundColor: Colors.white,
// // // //                               child: IconButton(
// // // //                                 icon: Icon(
// // // //                                   isInWishlist ? Icons.favorite : Icons.favorite_border,
// // // //                                   color: isInWishlist ? Colors.red : Colors.black,
// // // //                                 ),
// // // //                                 onPressed: () => _toggleWishlist(house),
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                       const SizedBox(height: 8),
// // // //                       Text(
// // // //                         house['title'],
// // // //                         style: const TextStyle(
// // // //                           fontWeight: FontWeight.w600,
// // // //                           fontSize: 15,
// // // //                         ),
// // // //                       ),
// // // //                       const SizedBox(height: 6),
// // // //                       Row(
// // // //                         children: [
// // // //                           _iconText(Icons.bed_outlined, house['bed']),
// // // //                           const SizedBox(width: 8),
// // // //                           _iconText(Icons.bathtub_outlined, house['bath']),
// // // //                           const SizedBox(width: 8),
// // // //                           _iconText(Icons.square_foot, house['area']),
// // // //                         ],
// // // //                       ),
// // // //                       const SizedBox(height: 6),
// // // //                       Row(
// // // //                         children: [
// // // //                           const Icon(Icons.location_on_outlined, size: 16),
// // // //                           Text(
// // // //                             house['location'],
// // // //                             style: const TextStyle(fontSize: 13),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                 );
// // // //               },
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _iconText(IconData icon, String label) {
// // // //     return Container(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
// // // //       decoration: BoxDecoration(
// // // //         border: Border.all(color: Colors.grey.shade300),
// // // //         borderRadius: BorderRadius.circular(16),
// // // //       ),
// // // //       child: Row(
// // // //         children: [
// // // //           Icon(icon, size: 14),
// // // //           const SizedBox(width: 4),
// // // //           Text(label, style: const TextStyle(fontSize: 12)),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // import 'package:farmhouse_app/views/details/house_detail_screen.dart';
// // // // import 'package:farmhouse_app/views/home/nearest_houses.dart';
// // // // import 'package:farmhouse_app/views/location/location_screen.dart';
// // // // import 'package:farmhouse_app/views/notifications/notification_screen.dart';
// // // // import 'package:farmhouse_app/widgets/like_widget.dart';
// // // // import 'package:flutter/material.dart';

// // // // class HomeScreen extends StatefulWidget {
// // // //   const HomeScreen({super.key});

// // // //   @override
// // // //   State<HomeScreen> createState() => _HomeScreenState();
// // // // }

// // // // class _HomeScreenState extends State<HomeScreen> {
// // // //   final WishlistManager wishlistManager = WishlistManager();
// // // //   String selectedCategory = 'Rental House';

// // // //   List<Map<String, dynamic>> products = [
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "price": "10,000/ Month",
// // // //       "title": "Georgia House",
// // // //       "location": "Kochi, Kerala",
// // // //       "rating": "4.9",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "price": "5,000/ Month",
// // // //       "title": "Nice House",
// // // //       "location": "Edappally, Kerala",
// // // //       "rating": "4.8",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "price": "18,000/ Month",
// // // //       "title": "Luna Haven",
// // // //       "location": "Fort Kochi, Kerala",
// // // //       "rating": "4.9",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "price": "20,000/ Month",
// // // //       "title": "The Serene Nest",
// // // //       "location": "Kakkanad, Kerala",
// // // //       "rating": "4.9",
// // // //     },
// // // //   ];

// // // //   void _toggleWishlist(Map<String, dynamic> house) {
// // // //     final bool isAlreadyInWishlist =
// // // //         wishlistManager.isInWishlist(house['title']);

// // // //     setState(() {
// // // //       wishlistManager.toggleWishlist(house);
// // // //     });

// // // //     ScaffoldMessenger.of(context).showSnackBar(
// // // //       SnackBar(
// // // //         backgroundColor: isAlreadyInWishlist ? Colors.red : Colors.green,
// // // //         content: Text(
// // // //           isAlreadyInWishlist ? 'Removed from wishlist' : 'Added to wishlist',
// // // //         ),
// // // //         behavior: SnackBarBehavior.floating,
// // // //         shape: RoundedRectangleBorder(
// // // //           borderRadius: BorderRadius.circular(10),
// // // //         ),
// // // //         duration: const Duration(seconds: 2),
// // // //       ),
// // // //     );
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.white,
// // // //       body: SafeArea(
// // // //         child: SingleChildScrollView(
// // // //           child: Column(
// // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // //             children: [
// // // //               // Header Section
// // // //               Padding(
// // // //                 padding: const EdgeInsets.all(16.0),
// // // //                 child: Row(
// // // //                   children: [
// // // //                     Container(
// // // //                       padding: const EdgeInsets.symmetric(
// // // //                         horizontal: 12,
// // // //                         vertical: 6,
// // // //                       ),
// // // //                       decoration: BoxDecoration(
// // // //                         color: Colors.black,
// // // //                         borderRadius: BorderRadius.circular(20),
// // // //                       ),
// // // //                       child: Row(
// // // //                         children: const [
// // // //                           Icon(Icons.location_on,
// // // //                               color: Colors.white, size: 16),
// // // //                           SizedBox(width: 4),
// // // //                           Text(
// // // //                             'Kochi, Kerala',
// // // //                             style: TextStyle(color: Colors.white, fontSize: 12),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                     const Spacer(),
// // // //                     GestureDetector(
// // // //                       onTap: () {
// // // //                         Navigator.push(
// // // //                           context,
// // // //                           MaterialPageRoute(
// // // //                             builder: (context) => const NotificationScreen(),
// // // //                           ),
// // // //                         );
// // // //                       },
// // // //                       child: Stack(
// // // //                         children: [
// // // //                           const Icon(Icons.notifications_outlined, size: 28),
// // // //                           Positioned(
// // // //                             right: 0,
// // // //                             top: 0,
// // // //                             child: Container(
// // // //                               width: 8,
// // // //                               height: 8,
// // // //                               decoration: const BoxDecoration(
// // // //                                 color: Colors.blue,
// // // //                                 shape: BoxShape.circle,
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                     const SizedBox(width: 12),
// // // //                     const CircleAvatar(
// // // //                       radius: 20,
// // // //                       backgroundImage: NetworkImage(
// // // //                         'https://upload.wikimedia.org/wikipedia/en/thumb/d/d6/Superman_Man_of_Steel.jpg/250px-Superman_Man_of_Steel.jpg',
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),

// // // //               // Title
// // // //               const Padding(
// // // //                 padding: EdgeInsets.symmetric(horizontal: 16.0),
// // // //                 child: Text(
// // // //                   'Discover\nYour New House',
// // // //                   style: TextStyle(
// // // //                     fontSize: 32,
// // // //                     fontWeight: FontWeight.bold,
// // // //                     height: 1.2,
// // // //                   ),
// // // //                 ),
// // // //               ),

// // // //               const SizedBox(height: 20),

// // // //               // Search Bar
// // // //               Padding(
// // // //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // // //                 child: Row(
// // // //                   children: [
// // // //                     Expanded(
// // // //                       child: Container(
// // // //                         padding: const EdgeInsets.symmetric(horizontal: 16),
// // // //                         decoration: BoxDecoration(
// // // //                           color: Colors.grey[100],
// // // //                           borderRadius: BorderRadius.circular(12),
// // // //                         ),
// // // //                         child: Row(
// // // //                           children: [
// // // //                             const Icon(Icons.search, color: Colors.grey),
// // // //                             const SizedBox(width: 8),
// // // //                             Expanded(
// // // //                               child: TextField(
// // // //                                 decoration: const InputDecoration(
// // // //                                   hintText: 'Search Place...',
// // // //                                   border: InputBorder.none,
// // // //                                   hintStyle: TextStyle(color: Colors.grey),
// // // //                                 ),
// // // //                               ),
// // // //                             ),
// // // //                           ],
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //                     const SizedBox(width: 12),
// // // //                     Container(
// // // //                       padding: const EdgeInsets.all(12),
// // // //                       decoration: BoxDecoration(
// // // //                         color: Colors.grey[100],
// // // //                         borderRadius: BorderRadius.circular(12),
// // // //                       ),
// // // //                       child: const Icon(Icons.tune, color: Colors.black),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),

// // // //               const SizedBox(height: 20),

// // // //               // Category Tabs
// // // //               Padding(
// // // //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // // //                 child: SingleChildScrollView(
// // // //                   scrollDirection: Axis.horizontal,
// // // //                   child: Row(
// // // //                     children: [
// // // //                       _categoryChip('Rental House', true),
// // // //                       const SizedBox(width: 8),
// // // //                       _categoryChip('Appartment', false),
// // // //                       const SizedBox(width: 8),
// // // //                       _categoryChip('Houses', false),
// // // //                       const SizedBox(width: 8),
// // // //                       _categoryChip('Rooms', false),
// // // //                     ],
// // // //                   ),
// // // //                 ),
// // // //               ),

// // // //               const SizedBox(height: 20),

// // // //               // Nearby Rental House's Title
// // // //               Padding(
// // // //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // // //                 child: Row(
// // // //                   children: [
// // // //                     const Text(
// // // //                       'Nearby Rental House\'s',
// // // //                       style: TextStyle(
// // // //                         fontSize: 18,
// // // //                         fontWeight: FontWeight.bold,
// // // //                       ),
// // // //                     ),
// // // //                     const Spacer(),
// // // //                     GestureDetector(
// // // //                       onTap: () {
// // // //                         Navigator.push(
// // // //                           context,
// // // //                           MaterialPageRoute(
// // // //                             builder: (context) => NearestHouses(),
// // // //                           ),
// // // //                         );
// // // //                       },
// // // //                       child: const Text(
// // // //                         'See All',
// // // //                         style: TextStyle(
// // // //                           color: Colors.grey,
// // // //                           fontSize: 14,
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),

// // // //               const SizedBox(height: 16),

// // // //               // Grid of Houses
// // // //               Padding(
// // // //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // // //                 child: GridView.builder(
// // // //                   shrinkWrap: true,
// // // //                   physics: const NeverScrollableScrollPhysics(),
// // // //                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // // //                     crossAxisCount: 2,
// // // //                     childAspectRatio: 0.75,
// // // //                     crossAxisSpacing: 12,
// // // //                     mainAxisSpacing: 12,
// // // //                   ),
// // // //                   itemCount: products.length,
// // // //                   itemBuilder: (context, index) {
// // // //                     final house = products[index];
// // // //                     final isInWishlist =
// // // //                         wishlistManager.isInWishlist(house['title']);

// // // //                     return GestureDetector(
// // // //                       onTap: () {
// // // //                         Navigator.push(
// // // //                           context,
// // // //                           MaterialPageRoute(
// // // //                             builder: (context) => const HouseDetailScreen(),
// // // //                           ),
// // // //                         );
// // // //                       },
// // // //                       child: Container(
// // // //                         decoration: BoxDecoration(
// // // //                           borderRadius: BorderRadius.circular(16),
// // // //                           color: Colors.white,
// // // //                         ),
// // // //                         child: Column(
// // // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // // //                           children: [
// // // //                             // Image Section
// // // //                             Expanded(
// // // //                               child: Stack(
// // // //                                 children: [
// // // //                                   ClipRRect(
// // // //                                     borderRadius: BorderRadius.circular(16),
// // // //                                     child: Image.asset(
// // // //                                       house['imageUrl'],
// // // //                                       width: double.infinity,
// // // //                                       fit: BoxFit.cover,
// // // //                                     ),
// // // //                                   ),
// // // //                                   // Price Tag
// // // //                                   Positioned(
// // // //                                     top: 8,
// // // //                                     right: 8,
// // // //                                     child: Container(
// // // //                                       padding: const EdgeInsets.symmetric(
// // // //                                         horizontal: 8,
// // // //                                         vertical: 4,
// // // //                                       ),
// // // //                                       decoration: BoxDecoration(
// // // //                                         color: Colors.black.withOpacity(0.6),
// // // //                                         borderRadius: BorderRadius.circular(8),
// // // //                                       ),
// // // //                                       child: Text(
// // // //                                         house['price'],
// // // //                                         style: const TextStyle(
// // // //                                           color: Colors.white,
// // // //                                           fontSize: 10,
// // // //                                           fontWeight: FontWeight.w500,
// // // //                                         ),
// // // //                                       ),
// // // //                                     ),
// // // //                                   ),
// // // //                                   // Wishlist Icon
// // // //                                   Positioned(
// // // //                                     top: 8,
// // // //                                     left: 8,
// // // //                                     child: GestureDetector(
// // // //                                       onTap: () => _toggleWishlist(house),
// // // //                                       child: Container(
// // // //                                         padding: const EdgeInsets.all(6),
// // // //                                         decoration: BoxDecoration(
// // // //                                           color: Colors.blue,
// // // //                                           borderRadius:
// // // //                                               BorderRadius.circular(8),
// // // //                                         ),
// // // //                                         child: Icon(
// // // //                                           isInWishlist
// // // //                                               ? Icons.favorite
// // // //                                               : Icons.favorite_border,
// // // //                                           color: Colors.white,
// // // //                                           size: 16,
// // // //                                         ),
// // // //                                       ),
// // // //                                     ),
// // // //                                   ),
// // // //                                   // Rating Badge
// // // //                                   Positioned(
// // // //                                     bottom: 8,
// // // //                                     left: 8,
// // // //                                     child: Container(
// // // //                                       padding: const EdgeInsets.symmetric(
// // // //                                         horizontal: 8,
// // // //                                         vertical: 4,
// // // //                                       ),
// // // //                                       decoration: BoxDecoration(
// // // //                                         color: Colors.amber,
// // // //                                         borderRadius: BorderRadius.circular(8),
// // // //                                       ),
// // // //                                       child: Row(
// // // //                                         children: [
// // // //                                           const Icon(
// // // //                                             Icons.star,
// // // //                                             size: 12,
// // // //                                             color: Colors.white,
// // // //                                           ),
// // // //                                           const SizedBox(width: 2),
// // // //                                           Text(
// // // //                                             house['rating'],
// // // //                                             style: const TextStyle(
// // // //                                               color: Colors.white,
// // // //                                               fontSize: 10,
// // // //                                               fontWeight: FontWeight.bold,
// // // //                                             ),
// // // //                                           ),
// // // //                                         ],
// // // //                                       ),
// // // //                                     ),
// // // //                                   ),
// // // //                                 ],
// // // //                               ),
// // // //                             ),
// // // //                             // House Info
// // // //                             Padding(
// // // //                               padding: const EdgeInsets.all(8.0),
// // // //                               child: Column(
// // // //                                 crossAxisAlignment: CrossAxisAlignment.start,
// // // //                                 children: [
// // // //                                   Text(
// // // //                                     house['title'],
// // // //                                     style: const TextStyle(
// // // //                                       fontWeight: FontWeight.bold,
// // // //                                       fontSize: 14,
// // // //                                     ),
// // // //                                     maxLines: 1,
// // // //                                     overflow: TextOverflow.ellipsis,
// // // //                                   ),
// // // //                                   const SizedBox(height: 4),
// // // //                                   Row(
// // // //                                     children: [
// // // //                                       const Icon(
// // // //                                         Icons.location_on_outlined,
// // // //                                         size: 12,
// // // //                                         color: Colors.grey,
// // // //                                       ),
// // // //                                       const SizedBox(width: 2),
// // // //                                       Expanded(
// // // //                                         child: Text(
// // // //                                           house['location'],
// // // //                                           style: const TextStyle(
// // // //                                             fontSize: 11,
// // // //                                             color: Colors.grey,
// // // //                                           ),
// // // //                                           maxLines: 1,
// // // //                                           overflow: TextOverflow.ellipsis,
// // // //                                         ),
// // // //                                       ),
// // // //                                     ],
// // // //                                   ),
// // // //                                 ],
// // // //                               ),
// // // //                             ),
// // // //                           ],
// // // //                         ),
// // // //                       ),
// // // //                     );
// // // //                   },
// // // //                 ),
// // // //               ),

// // // //               const SizedBox(height: 80),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _categoryChip(String label, bool isSelected) {
// // // //     return GestureDetector(
// // // //       onTap: () {
// // // //         setState(() {
// // // //           selectedCategory = label;
// // // //         });
// // // //       },
// // // //       child: Container(
// // // //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// // // //         decoration: BoxDecoration(
// // // //           color: isSelected ? Colors.black : Colors.grey[200],
// // // //           borderRadius: BorderRadius.circular(20),
// // // //         ),
// // // //         child: Text(
// // // //           label,
// // // //           style: TextStyle(
// // // //             color: isSelected ? Colors.white : Colors.black,
// // // //             fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
// // // //             fontSize: 14,
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // import 'package:farmhouse_app/views/details/house_detail_screen.dart';
// // // // import 'package:farmhouse_app/views/home/nearest_houses.dart';
// // // // import 'package:farmhouse_app/views/location/location_screen.dart';
// // // // import 'package:farmhouse_app/views/notifications/notification_screen.dart';
// // // // import 'package:farmhouse_app/widgets/like_widget.dart';
// // // // import 'package:flutter/material.dart';

// // // // class HomeScreen extends StatefulWidget {
// // // //   const HomeScreen({super.key});

// // // //   @override
// // // //   State<HomeScreen> createState() => _HomeScreenState();
// // // // }

// // // // class _HomeScreenState extends State<HomeScreen> {
// // // //   final WishlistManager wishlistManager = WishlistManager();
// // // //   String selectedCategory = 'All';

// // // //   // All products with category field
// // // //   List<Map<String, dynamic>> allProducts = [
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "price": "10,000/ Month",
// // // //       "title": "Georgia House",
// // // //       "location": "Kochi, Kerala",
// // // //       "rating": "4.9",
// // // //       "category": "Rental House",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "price": "5,000/ Month",
// // // //       "title": "Nice House",
// // // //       "location": "Edappally, Kerala",
// // // //       "rating": "4.8",
// // // //       "category": "Rental House",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "price": "18,000/ Month",
// // // //       "title": "Luna Haven",
// // // //       "location": "Fort Kochi, Kerala",
// // // //       "rating": "4.9",
// // // //       "category": "Appartment",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "price": "20,000/ Month",
// // // //       "title": "The Serene Nest",
// // // //       "location": "Kakkanad, Kerala",
// // // //       "rating": "4.9",
// // // //       "category": "Houses",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "price": "8,000/ Month",
// // // //       "title": "Sunset Villa",
// // // //       "location": "Vyttila, Kerala",
// // // //       "rating": "4.7",
// // // //       "category": "Appartment",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "price": "15,000/ Month",
// // // //       "title": "Green Valley",
// // // //       "location": "Aluva, Kerala",
// // // //       "rating": "4.8",
// // // //       "category": "Houses",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "price": "3,500/ Month",
// // // //       "title": "Cozy Room",
// // // //       "location": "Ernakulam, Kerala",
// // // //       "rating": "4.6",
// // // //       "category": "Rooms",
// // // //     },
// // // //     {
// // // //       "imageUrl": "assets/farmhouseimage.jpg",
// // // //       "price": "4,000/ Month",
// // // //       "title": "Student Room",
// // // //       "location": "Kakkanad, Kerala",
// // // //       "rating": "4.5",
// // // //       "category": "Rooms",
// // // //     },
// // // //   ];

// // // //   // Get filtered products based on selected category
// // // //   List<Map<String, dynamic>> get filteredProducts {
// // // //     if (selectedCategory == 'All') {
// // // //       return allProducts;
// // // //     }
// // // //     return allProducts
// // // //         .where((product) => product['category'] == selectedCategory)
// // // //         .toList();
// // // //   }

// // // //   void _toggleWishlist(Map<String, dynamic> house) {
// // // //     final bool isAlreadyInWishlist =
// // // //         wishlistManager.isInWishlist(house['title']);

// // // //     setState(() {
// // // //       wishlistManager.toggleWishlist(house);
// // // //     });

// // // //     ScaffoldMessenger.of(context).showSnackBar(
// // // //       SnackBar(
// // // //         backgroundColor: isAlreadyInWishlist ? Colors.red : Colors.green,
// // // //         content: Text(
// // // //           isAlreadyInWishlist ? 'Removed from wishlist' : 'Added to wishlist',
// // // //         ),
// // // //         behavior: SnackBarBehavior.floating,
// // // //         shape: RoundedRectangleBorder(
// // // //           borderRadius: BorderRadius.circular(10),
// // // //         ),
// // // //         duration: const Duration(seconds: 2),
// // // //       ),
// // // //     );
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.white,
// // // //       body: SafeArea(
// // // //         child: SingleChildScrollView(
// // // //           child: Column(
// // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // //             children: [
// // // //               // Header Section
// // // //               Padding(
// // // //                 padding: const EdgeInsets.all(16.0),
// // // //                 child: Row(
// // // //                   children: [
// // // //                     GestureDetector(
// // // //                       onTap: () {
// // // //                         Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationScreen()));
// // // //                       },
// // // //                       child: Container(
// // // //                         padding: const EdgeInsets.symmetric(
// // // //                           horizontal: 12,
// // // //                           vertical: 6,
// // // //                         ),
// // // //                         decoration: BoxDecoration(
// // // //                           color: Colors.black,
// // // //                           borderRadius: BorderRadius.circular(20),
// // // //                         ),
// // // //                         child: Row(
// // // //                           children: const [
// // // //                             Icon(Icons.location_on,
// // // //                                 color: Colors.white, size: 16),
// // // //                             SizedBox(width: 4),
// // // //                             Text(
// // // //                               'Kochi, Kerala',
// // // //                               style: TextStyle(color: Colors.white, fontSize: 12),
// // // //                             ),
// // // //                           ],
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //                     const Spacer(),
// // // //                     GestureDetector(
// // // //                       onTap: () {
// // // //                         Navigator.push(
// // // //                           context,
// // // //                           MaterialPageRoute(
// // // //                             builder: (context) => const NotificationScreen(),
// // // //                           ),
// // // //                         );
// // // //                       },
// // // //                       child: Stack(
// // // //                         children: [
// // // //                           const Icon(Icons.notifications_outlined, size: 28),
// // // //                           Positioned(
// // // //                             right: 0,
// // // //                             top: 0,
// // // //                             child: Container(
// // // //                               width: 8,
// // // //                               height: 8,
// // // //                               decoration: const BoxDecoration(
// // // //                                 color: Colors.blue,
// // // //                                 shape: BoxShape.circle,
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                     const SizedBox(width: 12),
// // // //                     const CircleAvatar(
// // // //                       radius: 20,
// // // //                       backgroundImage: NetworkImage(
// // // //                         'https://upload.wikimedia.org/wikipedia/en/thumb/d/d6/Superman_Man_of_Steel.jpg/250px-Superman_Man_of_Steel.jpg',
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),

// // // //               // Title
// // // //               const Padding(
// // // //                 padding: EdgeInsets.symmetric(horizontal: 16.0),
// // // //                 child: Text(
// // // //                   'Discover\nYour New House',
// // // //                   style: TextStyle(
// // // //                     fontSize: 32,
// // // //                     fontWeight: FontWeight.bold,
// // // //                     height: 1.2,
// // // //                   ),
// // // //                 ),
// // // //               ),

// // // //               const SizedBox(height: 20),

// // // //               // Search Bar
// // // //               Padding(
// // // //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // // //                 child: Row(
// // // //                   children: [
// // // //                     Expanded(
// // // //                       child: Container(
// // // //                         padding: const EdgeInsets.symmetric(horizontal: 16),
// // // //                         decoration: BoxDecoration(
// // // //                           color: Colors.grey[100],
// // // //                           borderRadius: BorderRadius.circular(12),
// // // //                         ),
// // // //                         child: Row(
// // // //                           children: [
// // // //                             const Icon(Icons.search, color: Colors.grey),
// // // //                             const SizedBox(width: 8),
// // // //                             Expanded(
// // // //                               child: TextField(
// // // //                                 decoration: const InputDecoration(
// // // //                                   hintText: 'Search Place...',
// // // //                                   border: InputBorder.none,
// // // //                                   hintStyle: TextStyle(color: Colors.grey),
// // // //                                 ),
// // // //                               ),
// // // //                             ),
// // // //                           ],
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //                     const SizedBox(width: 12),
// // // //                     Container(
// // // //                       padding: const EdgeInsets.all(12),
// // // //                       decoration: BoxDecoration(
// // // //                         color: Colors.grey[100],
// // // //                         borderRadius: BorderRadius.circular(12),
// // // //                       ),
// // // //                       child: const Icon(Icons.tune, color: Colors.black),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),

// // // //               const SizedBox(height: 20),

// // // //               // Category Tabs
// // // //               // Padding(
// // // //               //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // // //               //   child: SingleChildScrollView(
// // // //               //     scrollDirection: Axis.horizontal,
// // // //               //     child: Row(
// // // //               //       children: [
// // // //               //         _categoryChip('All', selectedCategory == 'All'),
// // // //               //         const SizedBox(width: 8),
// // // //               //         _categoryChip('Rental House', selectedCategory == 'Rental House'),
// // // //               //         const SizedBox(width: 8),
// // // //               //         _categoryChip('Appartment', selectedCategory == 'Appartment'),
// // // //               //         const SizedBox(width: 8),
// // // //               //         _categoryChip('Houses', selectedCategory == 'Houses'),
// // // //               //         const SizedBox(width: 8),
// // // //               //         _categoryChip('Rooms', selectedCategory == 'Rooms'),
// // // //               //       ],
// // // //               //     ),
// // // //               //   ),
// // // //               // ),

// // // //               const SizedBox(height: 20),

// // // //               // Dynamic Title based on category
// // // //               Padding(
// // // //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // // //                 child: Row(
// // // //                   children: [
// // // //                     Text(
// // // //                       selectedCategory == 'All'
// // // //                           ? 'All Properties'
// // // //                           : 'Nearby $selectedCategory',
// // // //                       style: const TextStyle(
// // // //                         fontSize: 18,
// // // //                         fontWeight: FontWeight.bold,
// // // //                       ),
// // // //                     ),
// // // //                     const Spacer(),
// // // //                     GestureDetector(
// // // //                       onTap: () {
// // // //                         Navigator.push(
// // // //                           context,
// // // //                           MaterialPageRoute(
// // // //                             builder: (context) => NearestHouses(),
// // // //                           ),
// // // //                         );
// // // //                       },
// // // //                       child: const Text(
// // // //                         'See All',
// // // //                         style: TextStyle(
// // // //                           color: Colors.grey,
// // // //                           fontSize: 14,
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),

// // // //               const SizedBox(height: 16),

// // // //               // Grid of Houses - Now filtered
// // // //               Padding(
// // // //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // // //                 child: filteredProducts.isEmpty
// // // //                     ? Center(
// // // //                         child: Padding(
// // // //                           padding: const EdgeInsets.all(32.0),
// // // //                           child: Column(
// // // //                             children: [
// // // //                               Icon(
// // // //                                 Icons.home_outlined,
// // // //                                 size: 64,
// // // //                                 color: Colors.grey[400],
// // // //                               ),
// // // //                               const SizedBox(height: 16),
// // // //                               Text(
// // // //                                 'No $selectedCategory available',
// // // //                                 style: TextStyle(
// // // //                                   fontSize: 16,
// // // //                                   color: Colors.grey[600],
// // // //                                   fontWeight: FontWeight.w500,
// // // //                                 ),
// // // //                               ),
// // // //                             ],
// // // //                           ),
// // // //                         ),
// // // //                       )
// // // //                     : GridView.builder(
// // // //                         shrinkWrap: true,
// // // //                         physics: const NeverScrollableScrollPhysics(),
// // // //                         gridDelegate:
// // // //                             const SliverGridDelegateWithFixedCrossAxisCount(
// // // //                           crossAxisCount: 2,
// // // //                           childAspectRatio: 0.75,
// // // //                           crossAxisSpacing: 12,
// // // //                           mainAxisSpacing: 12,
// // // //                         ),
// // // //                         itemCount: filteredProducts.length,
// // // //                         itemBuilder: (context, index) {
// // // //                           final house = filteredProducts[index];
// // // //                           final isInWishlist =
// // // //                               wishlistManager.isInWishlist(house['title']);

// // // //                           return GestureDetector(
// // // //                             onTap: () {
// // // //                               Navigator.push(
// // // //                                 context,
// // // //                                 MaterialPageRoute(
// // // //                                   builder: (context) =>
// // // //                                       const HouseDetailScreen(),
// // // //                                 ),
// // // //                               );
// // // //                             },
// // // //                             child: Container(
// // // //                               decoration: BoxDecoration(
// // // //                                 borderRadius: BorderRadius.circular(16),
// // // //                                 color: Colors.white,
// // // //                               ),
// // // //                               child: Column(
// // // //                                 crossAxisAlignment: CrossAxisAlignment.start,
// // // //                                 children: [
// // // //                                   // Image Section
// // // //                                   Expanded(
// // // //                                     child: Stack(
// // // //                                       children: [
// // // //                                         ClipRRect(
// // // //                                           borderRadius:
// // // //                                               BorderRadius.circular(16),
// // // //                                           child: Image.asset(
// // // //                                             house['imageUrl'],
// // // //                                             width: double.infinity,
// // // //                                             fit: BoxFit.cover,
// // // //                                           ),
// // // //                                         ),
// // // //                                         // Price Tag
// // // //                                         Positioned(
// // // //                                           top: 8,
// // // //                                           right: 8,
// // // //                                           child: Container(
// // // //                                             padding: const EdgeInsets.symmetric(
// // // //                                               horizontal: 8,
// // // //                                               vertical: 4,
// // // //                                             ),
// // // //                                             decoration: BoxDecoration(
// // // //                                               color:
// // // //                                                   Colors.black.withOpacity(0.6),
// // // //                                               borderRadius:
// // // //                                                   BorderRadius.circular(8),
// // // //                                             ),
// // // //                                             child: Text(
// // // //                                               house['price'],
// // // //                                               style: const TextStyle(
// // // //                                                 color: Colors.white,
// // // //                                                 fontSize: 10,
// // // //                                                 fontWeight: FontWeight.w500,
// // // //                                               ),
// // // //                                             ),
// // // //                                           ),
// // // //                                         ),
// // // //                                         // Wishlist Icon
// // // //                                         Positioned(
// // // //                                           top: 8,
// // // //                                           left: 8,
// // // //                                           child: GestureDetector(
// // // //                                             onTap: () => _toggleWishlist(house),
// // // //                                             child: Container(
// // // //                                               padding: const EdgeInsets.all(6),
// // // //                                               decoration: BoxDecoration(
// // // //                                                 color: Colors.blue,
// // // //                                                 borderRadius:
// // // //                                                     BorderRadius.circular(8),
// // // //                                               ),
// // // //                                               child: Icon(
// // // //                                                 isInWishlist
// // // //                                                     ? Icons.favorite
// // // //                                                     : Icons.favorite_border,
// // // //                                                 color: Colors.white,
// // // //                                                 size: 16,
// // // //                                               ),
// // // //                                             ),
// // // //                                           ),
// // // //                                         ),
// // // //                                         // Rating Badge
// // // //                                         Positioned(
// // // //                                           bottom: 8,
// // // //                                           left: 8,
// // // //                                           child: Container(
// // // //                                             padding: const EdgeInsets.symmetric(
// // // //                                               horizontal: 8,
// // // //                                               vertical: 4,
// // // //                                             ),
// // // //                                             decoration: BoxDecoration(
// // // //                                               color: Colors.amber,
// // // //                                               borderRadius:
// // // //                                                   BorderRadius.circular(8),
// // // //                                             ),
// // // //                                             child: Row(
// // // //                                               children: [
// // // //                                                 const Icon(
// // // //                                                   Icons.star,
// // // //                                                   size: 12,
// // // //                                                   color: Colors.white,
// // // //                                                 ),
// // // //                                                 const SizedBox(width: 2),
// // // //                                                 Text(
// // // //                                                   house['rating'],
// // // //                                                   style: const TextStyle(
// // // //                                                     color: Colors.white,
// // // //                                                     fontSize: 10,
// // // //                                                     fontWeight: FontWeight.bold,
// // // //                                                   ),
// // // //                                                 ),
// // // //                                               ],
// // // //                                             ),
// // // //                                           ),
// // // //                                         ),
// // // //                                       ],
// // // //                                     ),
// // // //                                   ),
// // // //                                   // House Info
// // // //                                   Padding(
// // // //                                     padding: const EdgeInsets.all(8.0),
// // // //                                     child: Column(
// // // //                                       crossAxisAlignment:
// // // //                                           CrossAxisAlignment.start,
// // // //                                       children: [
// // // //                                         Text(
// // // //                                           house['title'],
// // // //                                           style: const TextStyle(
// // // //                                             fontWeight: FontWeight.bold,
// // // //                                             fontSize: 14,
// // // //                                           ),
// // // //                                           maxLines: 1,
// // // //                                           overflow: TextOverflow.ellipsis,
// // // //                                         ),
// // // //                                         const SizedBox(height: 4),
// // // //                                         Row(
// // // //                                           children: [
// // // //                                             const Icon(
// // // //                                               Icons.location_on_outlined,
// // // //                                               size: 12,
// // // //                                               color: Colors.grey,
// // // //                                             ),
// // // //                                             const SizedBox(width: 2),
// // // //                                             Expanded(
// // // //                                               child: Text(
// // // //                                                 house['location'],
// // // //                                                 style: const TextStyle(
// // // //                                                   fontSize: 11,
// // // //                                                   color: Colors.grey,
// // // //                                                 ),
// // // //                                                 maxLines: 1,
// // // //                                                 overflow: TextOverflow.ellipsis,
// // // //                                               ),
// // // //                                             ),
// // // //                                           ],
// // // //                                         ),
// // // //                                       ],
// // // //                                     ),
// // // //                                   ),
// // // //                                 ],
// // // //                               ),
// // // //                             ),
// // // //                           );
// // // //                         },
// // // //                       ),
// // // //               ),

// // // //               const SizedBox(height: 80),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _categoryChip(String label, bool isSelected) {
// // // //     return GestureDetector(
// // // //       onTap: () {
// // // //         setState(() {
// // // //           selectedCategory = label;
// // // //         });
// // // //       },
// // // //       child: Container(
// // // //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// // // //         decoration: BoxDecoration(
// // // //           color: isSelected ? Colors.black : Colors.grey[200],
// // // //           borderRadius: BorderRadius.circular(20),
// // // //         ),
// // // //         child: Text(
// // // //           label,
// // // //           style: TextStyle(
// // // //             color: isSelected ? Colors.white : Colors.black,
// // // //             fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
// // // //             fontSize: 14,
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:farmhouse_app/views/details/house_detail_screen.dart';
// // // import 'package:farmhouse_app/views/home/nearest_houses.dart';
// // // import 'package:farmhouse_app/views/home/profile_screen.dart';
// // // import 'package:farmhouse_app/views/location/location_screen.dart';
// // // import 'package:farmhouse_app/views/notifications/notification_screen.dart';
// // // import 'package:farmhouse_app/widgets/like_widget.dart';
// // // import 'package:flutter/material.dart';

// // // class HomeScreen extends StatefulWidget {
// // //   const HomeScreen({super.key});

// // //   @override
// // //   State<HomeScreen> createState() => _HomeScreenState();
// // // }

// // // class _HomeScreenState extends State<HomeScreen> {
// // //   final WishlistManager wishlistManager = WishlistManager();
// // //   final TextEditingController _searchController = TextEditingController();

// // //   String selectedCategory = 'All';
// // //   String searchQuery = '';

// // //   // Filter criteria
// // //   String? filterLocation;
// // //   double? minPrice;
// // //   double? maxPrice;

// // //   // All products with category field
// // //   List<Map<String, dynamic>> allProducts = [
// // //     {
// // //       "imageUrl": "assets/farmhouseimage.jpg",
// // //       "price": "10,000/ Month",
// // //       "title": "Georgia House",
// // //       "location": "Kochi, Kerala",
// // //       "rating": "4.9",
// // //       "category": "Rental House",
// // //       "priceValue": 10000,
// // //     },
// // //     {
// // //       "imageUrl": "assets/farmhouseimage.jpg",
// // //       "price": "5,000/ Month",
// // //       "title": "Nice House",
// // //       "location": "Edappally, Kerala",
// // //       "rating": "4.8",
// // //       "category": "Rental House",
// // //       "priceValue": 5000,
// // //     },
// // //     {
// // //       "imageUrl": "assets/farmhouseimage.jpg",
// // //       "price": "18,000/ Month",
// // //       "title": "Luna Haven",
// // //       "location": "Fort Kochi, Kerala",
// // //       "rating": "4.9",
// // //       "category": "Appartment",
// // //       "priceValue": 18000,
// // //     },
// // //     {
// // //       "imageUrl": "assets/farmhouseimage.jpg",
// // //       "price": "20,000/ Month",
// // //       "title": "The Serene Nest",
// // //       "location": "Kakkanad, Kerala",
// // //       "rating": "4.9",
// // //       "category": "Houses",
// // //       "priceValue": 20000,
// // //     },
// // //     {
// // //       "imageUrl": "assets/farmhouseimage.jpg",
// // //       "price": "8,000/ Month",
// // //       "title": "Sunset Villa",
// // //       "location": "Vyttila, Kerala",
// // //       "rating": "4.7",
// // //       "category": "Appartment",
// // //       "priceValue": 8000,
// // //     },
// // //     {
// // //       "imageUrl": "assets/farmhouseimage.jpg",
// // //       "price": "15,000/ Month",
// // //       "title": "Green Valley",
// // //       "location": "Aluva, Kerala",
// // //       "rating": "4.8",
// // //       "category": "Houses",
// // //       "priceValue": 15000,
// // //     },
// // //     {
// // //       "imageUrl": "assets/farmhouseimage.jpg",
// // //       "price": "3,500/ Month",
// // //       "title": "Cozy Room",
// // //       "location": "Ernakulam, Kerala",
// // //       "rating": "4.6",
// // //       "category": "Rooms",
// // //       "priceValue": 3500,
// // //     },
// // //     {
// // //       "imageUrl": "assets/farmhouseimage.jpg",
// // //       "price": "4,000/ Month",
// // //       "title": "Student Room",
// // //       "location": "Kakkanad, Kerala",
// // //       "rating": "4.5",
// // //       "category": "Rooms",
// // //       "priceValue": 4000,
// // //     },
// // //   ];

// // //   // Get unique locations from all products
// // //   List<String> get availableLocations {
// // //     return allProducts
// // //         .map((product) => product['location'] as String)
// // //         .toSet()
// // //         .toList()..sort();
// // //   }

// // //   // Get filtered products based on selected category, search query, and filters
// // //   List<Map<String, dynamic>> get filteredProducts {
// // //     List<Map<String, dynamic>> products = allProducts;

// // //     // Filter by category
// // //     if (selectedCategory != 'All') {
// // //       products = products
// // //           .where((product) => product['category'] == selectedCategory)
// // //           .toList();
// // //     }

// // //     // Filter by search query (name)
// // //     if (searchQuery.isNotEmpty) {
// // //       products = products.where((product) {
// // //         final title = product['title'].toString().toLowerCase();
// // //         return title.contains(searchQuery.toLowerCase());
// // //       }).toList();
// // //     }

// // //     // Filter by location
// // //     if (filterLocation != null && filterLocation!.isNotEmpty) {
// // //       products = products
// // //           .where((product) => product['location'] == filterLocation)
// // //           .toList();
// // //     }

// // //     // Filter by price range
// // //     if (minPrice != null) {
// // //       products = products
// // //           .where((product) => product['priceValue'] >= minPrice!)
// // //           .toList();
// // //     }
// // //     if (maxPrice != null) {
// // //       products = products
// // //           .where((product) => product['priceValue'] <= maxPrice!)
// // //           .toList();
// // //     }

// // //     return products;
// // //   }

// // //   void _toggleWishlist(Map<String, dynamic> house) {
// // //     final bool isAlreadyInWishlist =
// // //         wishlistManager.isInWishlist(house['title']);

// // //     setState(() {
// // //       wishlistManager.toggleWishlist(house);
// // //     });

// // //     ScaffoldMessenger.of(context).showSnackBar(
// // //       SnackBar(
// // //         backgroundColor: isAlreadyInWishlist ? Colors.red : Colors.green,
// // //         content: Text(
// // //           isAlreadyInWishlist ? 'Removed from wishlist' : 'Added to wishlist',
// // //         ),
// // //         behavior: SnackBarBehavior.floating,
// // //         shape: RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.circular(10),
// // //         ),
// // //         duration: const Duration(seconds: 2),
// // //       ),
// // //     );
// // //   }

// // //   void _showFilterDialog() {
// // //     String? tempLocation = filterLocation;
// // //     double? tempMinPrice = minPrice;
// // //     double? tempMaxPrice = maxPrice;

// // //     showDialog(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         return StatefulBuilder(
// // //           builder: (context, setDialogState) {
// // //             return AlertDialog(
// // //               title: Row(
// // //                 children: [
// // //                   const Text('Filter Properties'),
// // //                   const Spacer(),
// // //                   IconButton(
// // //                     icon: const Icon(Icons.close),
// // //                     onPressed: () => Navigator.pop(context),
// // //                   ),
// // //                 ],
// // //               ),
// // //               content: SingleChildScrollView(
// // //                 child: Column(
// // //                   mainAxisSize: MainAxisSize.min,
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     // Location Filter
// // //                     const Text(
// // //                       'Location',
// // //                       style: TextStyle(
// // //                         fontWeight: FontWeight.bold,
// // //                         fontSize: 16,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 8),
// // //                     Container(
// // //                       padding: const EdgeInsets.symmetric(horizontal: 12),
// // //                       decoration: BoxDecoration(
// // //                         border: Border.all(color: Colors.grey[300]!),
// // //                         borderRadius: BorderRadius.circular(8),
// // //                       ),
// // //                       child: DropdownButtonHideUnderline(
// // //                         child: DropdownButton<String>(
// // //                           isExpanded: true,
// // //                           value: tempLocation,
// // //                           hint: const Text('Select Location'),
// // //                           items: [
// // //                             const DropdownMenuItem<String>(
// // //                               value: null,
// // //                               child: Text('All Locations'),
// // //                             ),
// // //                             ...availableLocations.map((String location) {
// // //                               return DropdownMenuItem<String>(
// // //                                 value: location,
// // //                                 child: Text(location),
// // //                               );
// // //                             }).toList(),
// // //                           ],
// // //                           onChanged: (String? newValue) {
// // //                             setDialogState(() {
// // //                               tempLocation = newValue;
// // //                             });
// // //                           },
// // //                         ),
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 20),

// // //                     // Price Range Filter
// // //                     const Text(
// // //                       'Price Range',
// // //                       style: TextStyle(
// // //                         fontWeight: FontWeight.bold,
// // //                         fontSize: 16,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 8),
// // //                     Row(
// // //                       children: [
// // //                         Expanded(
// // //                           child: TextField(
// // //                             keyboardType: TextInputType.number,
// // //                             decoration: InputDecoration(
// // //                               labelText: 'Min Price',
// // //                               hintText: '3,500',
// // //                               border: OutlineInputBorder(
// // //                                 borderRadius: BorderRadius.circular(8),
// // //                               ),
// // //                               prefixText: '₹ ',
// // //                             ),
// // //                             onChanged: (value) {
// // //                               tempMinPrice = double.tryParse(
// // //                                   value.replaceAll(',', ''));
// // //                             },
// // //                             controller: TextEditingController(
// // //                               text: tempMinPrice?.toStringAsFixed(0) ?? '',
// // //                             ),
// // //                           ),
// // //                         ),
// // //                         const SizedBox(width: 12),
// // //                         Expanded(
// // //                           child: TextField(
// // //                             keyboardType: TextInputType.number,
// // //                             decoration: InputDecoration(
// // //                               labelText: 'Max Price',
// // //                               hintText: '20,000',
// // //                               border: OutlineInputBorder(
// // //                                 borderRadius: BorderRadius.circular(8),
// // //                               ),
// // //                               prefixText: '₹ ',
// // //                             ),
// // //                             onChanged: (value) {
// // //                               tempMaxPrice = double.tryParse(
// // //                                   value.replaceAll(',', ''));
// // //                             },
// // //                             controller: TextEditingController(
// // //                               text: tempMaxPrice?.toStringAsFixed(0) ?? '',
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                     const SizedBox(height: 20),

// // //                     // Active Filters Display
// // //                     if (tempLocation != null ||
// // //                         tempMinPrice != null ||
// // //                         tempMaxPrice != null)
// // //                       Container(
// // //                         padding: const EdgeInsets.all(12),
// // //                         decoration: BoxDecoration(
// // //                           color: Colors.blue[50],
// // //                           borderRadius: BorderRadius.circular(8),
// // //                         ),
// // //                         child: Column(
// // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // //                           children: [
// // //                             const Text(
// // //                               'Active Filters:',
// // //                               style: TextStyle(
// // //                                 fontWeight: FontWeight.bold,
// // //                                 fontSize: 14,
// // //                               ),
// // //                             ),
// // //                             const SizedBox(height: 4),
// // //                             if (tempLocation != null)
// // //                               Text('• Location: $tempLocation'),
// // //                             if (tempMinPrice != null)
// // //                               Text('• Min Price: ₹${tempMinPrice!.toStringAsFixed(0)}'),
// // //                             if (tempMaxPrice != null)
// // //                               Text('• Max Price: ₹${tempMaxPrice!.toStringAsFixed(0)}'),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                   ],
// // //                 ),
// // //               ),
// // //               actions: [
// // //                 TextButton(
// // //                   onPressed: () {
// // //                     setState(() {
// // //                       filterLocation = null;
// // //                       minPrice = null;
// // //                       maxPrice = null;
// // //                     });
// // //                     Navigator.pop(context);
// // //                   },
// // //                   child: const Text('Clear All'),
// // //                 ),
// // //                 ElevatedButton(
// // //                   style: ElevatedButton.styleFrom(
// // //                     backgroundColor: Colors.black,
// // //                     foregroundColor: Colors.white,
// // //                   ),
// // //                   onPressed: () {
// // //                     setState(() {
// // //                       filterLocation = tempLocation;
// // //                       minPrice = tempMinPrice;
// // //                       maxPrice = tempMaxPrice;
// // //                     });
// // //                     Navigator.pop(context);
// // //                   },
// // //                   child: const Text('Apply Filters'),
// // //                 ),
// // //               ],
// // //             );
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }

// // //   void _clearFilters() {
// // //     setState(() {
// // //       filterLocation = null;
// // //       minPrice = null;
// // //       maxPrice = null;
// // //       searchQuery = '';
// // //       _searchController.clear();
// // //     });
// // //   }

// // //   bool get hasActiveFilters =>
// // //       filterLocation != null || minPrice != null || maxPrice != null;

// // //   @override
// // //   void dispose() {
// // //     _searchController.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.white,
// // //       body: SafeArea(
// // //         child: SingleChildScrollView(
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               // Header Section
// // //               Padding(
// // //                 padding: const EdgeInsets.all(16.0),
// // //                 child: Row(
// // //                   children: [
// // //                     GestureDetector(
// // //                       onTap: () {
// // //                         Navigator.push(
// // //                             context,
// // //                             MaterialPageRoute(
// // //                                 builder: (context) => LocationScreen()));
// // //                       },
// // //                       child: Container(
// // //                         padding: const EdgeInsets.symmetric(
// // //                           horizontal: 12,
// // //                           vertical: 6,
// // //                         ),
// // //                         decoration: BoxDecoration(
// // //                           color: Colors.black,
// // //                           borderRadius: BorderRadius.circular(20),
// // //                         ),
// // //                         child: Row(
// // //                           children: const [
// // //                             Icon(Icons.location_on,
// // //                                 color: Colors.white, size: 16),
// // //                             SizedBox(width: 4),
// // //                             Text(
// // //                               'Kochi, Kerala',
// // //                               style:
// // //                                   TextStyle(color: Colors.white, fontSize: 12),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     ),
// // //                     const Spacer(),
// // //                     GestureDetector(
// // //                       onTap: () {
// // //                         Navigator.push(
// // //                           context,
// // //                           MaterialPageRoute(
// // //                             builder: (context) => const NotificationScreen(),
// // //                           ),
// // //                         );
// // //                       },
// // //                       child: Stack(
// // //                         children: [
// // //                           const Icon(Icons.notifications_outlined, size: 28),
// // //                           Positioned(
// // //                             right: 0,
// // //                             top: 0,
// // //                             child: Container(
// // //                               width: 8,
// // //                               height: 8,
// // //                               decoration: const BoxDecoration(
// // //                                 color: Colors.blue,
// // //                                 shape: BoxShape.circle,
// // //                               ),
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                     const SizedBox(width: 12),
// // //                     GestureDetector(
// // //                       onTap: () {
// // //                         Navigator.push(
// // //                           context,
// // //                           MaterialPageRoute(
// // //                             builder: (context) => const ProfileScreen(),
// // //                           ),
// // //                         );
// // //                       },
// // //                       child: const CircleAvatar(
// // //                         radius: 20,
// // //                         backgroundImage: NetworkImage(
// // //                           'https://upload.wikimedia.org/wikipedia/en/thumb/d/d6/Superman_Man_of_Steel.jpg/250px-Superman_Man_of_Steel.jpg',
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),

// // //               // Title
// // //               const Padding(
// // //                 padding: EdgeInsets.symmetric(horizontal: 16.0),
// // //                 child: Text(
// // //                   'Discover\nYour New House',
// // //                   style: TextStyle(
// // //                     fontSize: 32,
// // //                     fontWeight: FontWeight.bold,
// // //                     height: 1.2,
// // //                   ),
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 20),

// // //               // Search Bar with Filter
// // //               Padding(
// // //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //                 child: Row(
// // //                   children: [
// // //                     Expanded(
// // //                       child: Container(
// // //                         padding: const EdgeInsets.symmetric(horizontal: 16),
// // //                         decoration: BoxDecoration(
// // //                           color: Colors.grey[100],
// // //                           borderRadius: BorderRadius.circular(12),
// // //                         ),
// // //                         child: Row(
// // //                           children: [
// // //                             const Icon(Icons.search, color: Colors.grey),
// // //                             const SizedBox(width: 8),
// // //                             Expanded(
// // //                               child: TextField(
// // //                                 controller: _searchController,
// // //                                 decoration: const InputDecoration(
// // //                                   hintText: 'Search by name...',
// // //                                   border: InputBorder.none,
// // //                                   hintStyle: TextStyle(color: Colors.grey),
// // //                                 ),
// // //                                 onChanged: (value) {
// // //                                   setState(() {
// // //                                     searchQuery = value;
// // //                                   });
// // //                                 },
// // //                               ),
// // //                             ),
// // //                             if (searchQuery.isNotEmpty)
// // //                               GestureDetector(
// // //                                 onTap: () {
// // //                                   setState(() {
// // //                                     searchQuery = '';
// // //                                     _searchController.clear();
// // //                                   });
// // //                                 },
// // //                                 child: const Icon(
// // //                                   Icons.clear,
// // //                                   color: Colors.grey,
// // //                                   size: 20,
// // //                                 ),
// // //                               ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     ),
// // //                     const SizedBox(width: 12),
// // //                     GestureDetector(
// // //                       onTap: _showFilterDialog,
// // //                       child: Container(
// // //                         padding: const EdgeInsets.all(12),
// // //                         decoration: BoxDecoration(
// // //                           color: hasActiveFilters ? Colors.black : Colors.grey[100],
// // //                           borderRadius: BorderRadius.circular(12),
// // //                         ),
// // //                         child: Stack(
// // //                           children: [
// // //                             Icon(
// // //                               Icons.tune,
// // //                               color: hasActiveFilters ? Colors.white : Colors.black,
// // //                             ),
// // //                             if (hasActiveFilters)
// // //                               Positioned(
// // //                                 right: 0,
// // //                                 top: 0,
// // //                                 child: Container(
// // //                                   width: 8,
// // //                                   height: 8,
// // //                                   decoration: const BoxDecoration(
// // //                                     color: Colors.blue,
// // //                                     shape: BoxShape.circle,
// // //                                   ),
// // //                                 ),
// // //                               ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 12),

// // //               // Active Filters Chips
// // //               if (hasActiveFilters || searchQuery.isNotEmpty)
// // //                 Padding(
// // //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //                   child: SingleChildScrollView(
// // //                     scrollDirection: Axis.horizontal,
// // //                     child: Row(
// // //                       children: [
// // //                         if (searchQuery.isNotEmpty)
// // //                           _filterChip(
// // //                             'Search: "$searchQuery"',
// // //                             () {
// // //                               setState(() {
// // //                                 searchQuery = '';
// // //                                 _searchController.clear();
// // //                               });
// // //                             },
// // //                           ),
// // //                         if (filterLocation != null) ...[
// // //                           const SizedBox(width: 8),
// // //                           _filterChip(
// // //                             'Location: $filterLocation',
// // //                             () {
// // //                               setState(() {
// // //                                 filterLocation = null;
// // //                               });
// // //                             },
// // //                           ),
// // //                         ],
// // //                         if (minPrice != null) ...[
// // //                           const SizedBox(width: 8),
// // //                           _filterChip(
// // //                             'Min: ₹${minPrice!.toStringAsFixed(0)}',
// // //                             () {
// // //                               setState(() {
// // //                                 minPrice = null;
// // //                               });
// // //                             },
// // //                           ),
// // //                         ],
// // //                         if (maxPrice != null) ...[
// // //                           const SizedBox(width: 8),
// // //                           _filterChip(
// // //                             'Max: ₹${maxPrice!.toStringAsFixed(0)}',
// // //                             () {
// // //                               setState(() {
// // //                                 maxPrice = null;
// // //                               });
// // //                             },
// // //                           ),
// // //                         ],
// // //                         if (hasActiveFilters || searchQuery.isNotEmpty) ...[
// // //                           const SizedBox(width: 8),
// // //                           GestureDetector(
// // //                             onTap: _clearFilters,
// // //                             child: Container(
// // //                               padding: const EdgeInsets.symmetric(
// // //                                 horizontal: 12,
// // //                                 vertical: 6,
// // //                               ),
// // //                               decoration: BoxDecoration(
// // //                                 color: Colors.red[50],
// // //                                 borderRadius: BorderRadius.circular(16),
// // //                                 border: Border.all(color: Colors.red[300]!),
// // //                               ),
// // //                               child: Row(
// // //                                 children: const [
// // //                                   Icon(
// // //                                     Icons.clear_all,
// // //                                     size: 14,
// // //                                     color: Colors.red,
// // //                                   ),
// // //                                   SizedBox(width: 4),
// // //                                   Text(
// // //                                     'Clear All',
// // //                                     style: TextStyle(
// // //                                       color: Colors.red,
// // //                                       fontSize: 12,
// // //                                       fontWeight: FontWeight.w500,
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ),

// // //               // const SizedBox(height: 20),

// // //               // Category Tabs (uncomment if needed)
// // //               // Padding(
// // //               //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //               //   child: SingleChildScrollView(
// // //               //     scrollDirection: Axis.horizontal,
// // //               //     child: Row(
// // //               //       children: [
// // //               //         _categoryChip('All', selectedCategory == 'All'),
// // //               //         const SizedBox(width: 8),
// // //               //         _categoryChip('Rental House',
// // //               //             selectedCategory == 'Rental House'),
// // //               //         const SizedBox(width: 8),
// // //               //         _categoryChip(
// // //               //             'Appartment', selectedCategory == 'Appartment'),
// // //               //         const SizedBox(width: 8),
// // //               //         _categoryChip('Houses', selectedCategory == 'Houses'),
// // //               //         const SizedBox(width: 8),
// // //               //         _categoryChip('Rooms', selectedCategory == 'Rooms'),
// // //               //       ],
// // //               //     ),
// // //               //   ),
// // //               // ),

// // //               const SizedBox(height: 20),

// // //               // Dynamic Title with results count
// // //               Padding(
// // //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //                 child: Row(
// // //                   children: [
// // //                     Expanded(
// // //                       child: Column(
// // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // //                         children: [
// // //                           Text(
// // //                             selectedCategory == 'All'
// // //                                 ? 'All Properties'
// // //                                 : 'Nearby $selectedCategory',
// // //                             style: const TextStyle(
// // //                               fontSize: 18,
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                           const SizedBox(height: 4),
// // //                           Text(
// // //                             '${filteredProducts.length} properties found',
// // //                             style: TextStyle(
// // //                               fontSize: 12,
// // //                               color: Colors.grey[600],
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                     GestureDetector(
// // //                       onTap: () {
// // //                         Navigator.push(
// // //                           context,
// // //                           MaterialPageRoute(
// // //                             builder: (context) => NearestHouses(),
// // //                           ),
// // //                         );
// // //                       },
// // //                       child: const Text(
// // //                         'See All',
// // //                         style: TextStyle(
// // //                           color: Colors.grey,
// // //                           fontSize: 14,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 16),

// // //               // Grid of Houses - Now filtered
// // //               Padding(
// // //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //                 child: filteredProducts.isEmpty
// // //                     ? Center(
// // //                         child: Padding(
// // //                           padding: const EdgeInsets.all(32.0),
// // //                           child: Column(
// // //                             children: [
// // //                               Icon(
// // //                                 Icons.search_off,
// // //                                 size: 64,
// // //                                 color: Colors.grey[400],
// // //                               ),
// // //                               const SizedBox(height: 16),
// // //                               Text(
// // //                                 'No properties found',
// // //                                 style: TextStyle(
// // //                                   fontSize: 18,
// // //                                   color: Colors.grey[600],
// // //                                   fontWeight: FontWeight.w600,
// // //                                 ),
// // //                               ),
// // //                               const SizedBox(height: 8),
// // //                               Text(
// // //                                 'Try adjusting your filters or search',
// // //                                 style: TextStyle(
// // //                                   fontSize: 14,
// // //                                   color: Colors.grey[500],
// // //                                 ),
// // //                               ),
// // //                               const SizedBox(height: 16),
// // //                               ElevatedButton(
// // //                                 onPressed: _clearFilters,
// // //                                 style: ElevatedButton.styleFrom(
// // //                                   backgroundColor: Colors.black,
// // //                                   foregroundColor: Colors.white,
// // //                                 ),
// // //                                 child: const Text('Clear Filters'),
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ),
// // //                       )
// // //                     : GridView.builder(
// // //                         shrinkWrap: true,
// // //                         physics: const NeverScrollableScrollPhysics(),
// // //                         gridDelegate:
// // //                             const SliverGridDelegateWithFixedCrossAxisCount(
// // //                           crossAxisCount: 2,
// // //                           childAspectRatio: 0.75,
// // //                           crossAxisSpacing: 12,
// // //                           mainAxisSpacing: 12,
// // //                         ),
// // //                         itemCount: filteredProducts.length,
// // //                         itemBuilder: (context, index) {
// // //                           final house = filteredProducts[index];
// // //                           final isInWishlist =
// // //                               wishlistManager.isInWishlist(house['title']);

// // //                           return GestureDetector(
// // //                             onTap: () {
// // //                               Navigator.push(
// // //                                 context,
// // //                                 MaterialPageRoute(
// // //                                   builder: (context) =>
// // //                                       const HouseDetailScreen(),
// // //                                 ),
// // //                               );
// // //                             },
// // //                             child: Container(
// // //                               decoration: BoxDecoration(
// // //                                 borderRadius: BorderRadius.circular(16),
// // //                                 color: Colors.white,
// // //                               ),
// // //                               child: Column(
// // //                                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                                 children: [
// // //                                   // Image Section
// // //                                   Expanded(
// // //                                     child: Stack(
// // //                                       children: [
// // //                                         ClipRRect(
// // //                                           borderRadius:
// // //                                               BorderRadius.circular(16),
// // //                                           child: Image.asset(
// // //                                             house['imageUrl'],
// // //                                             width: double.infinity,
// // //                                             fit: BoxFit.cover,
// // //                                           ),
// // //                                         ),
// // //                                         // Price Tag
// // //                                         Positioned(
// // //                                           top: 8,
// // //                                           right: 8,
// // //                                           child: Container(
// // //                                             padding: const EdgeInsets.symmetric(
// // //                                               horizontal: 8,
// // //                                               vertical: 4,
// // //                                             ),
// // //                                             decoration: BoxDecoration(
// // //                                               color:
// // //                                                   Colors.black.withOpacity(0.6),
// // //                                               borderRadius:
// // //                                                   BorderRadius.circular(8),
// // //                                             ),
// // //                                             child: Text(
// // //                                               house['price'],
// // //                                               style: const TextStyle(
// // //                                                 color: Colors.white,
// // //                                                 fontSize: 10,
// // //                                                 fontWeight: FontWeight.w500,
// // //                                               ),
// // //                                             ),
// // //                                           ),
// // //                                         ),
// // //                                         // Wishlist Icon
// // //                                         Positioned(
// // //                                           top: 8,
// // //                                           left: 8,
// // //                                           child: GestureDetector(
// // //                                             onTap: () => _toggleWishlist(house),
// // //                                             child: Container(
// // //                                               padding: const EdgeInsets.all(6),
// // //                                               decoration: BoxDecoration(
// // //                                                 color: Colors.blue,
// // //                                                 borderRadius:
// // //                                                     BorderRadius.circular(8),
// // //                                               ),
// // //                                               child: Icon(
// // //                                                 isInWishlist
// // //                                                     ? Icons.favorite
// // //                                                     : Icons.favorite_border,
// // //                                                 color: Colors.white,
// // //                                                 size: 16,
// // //                                               ),
// // //                                             ),
// // //                                           ),
// // //                                         ),
// // //                                         // Rating Badge
// // //                                         Positioned(
// // //                                           bottom: 8,
// // //                                           left: 8,
// // //                                           child: Container(
// // //                                             padding: const EdgeInsets.symmetric(
// // //                                               horizontal: 8,
// // //                                               vertical: 4,
// // //                                             ),
// // //                                             decoration: BoxDecoration(
// // //                                               color: Colors.amber,
// // //                                               borderRadius:
// // //                                                   BorderRadius.circular(8),
// // //                                             ),
// // //                                             child: Row(
// // //                                               children: [
// // //                                                 const Icon(
// // //                                                   Icons.star,
// // //                                                   size: 12,
// // //                                                   color: Colors.white,
// // //                                                 ),
// // //                                                 const SizedBox(width: 2),
// // //                                                 Text(
// // //                                                   house['rating'],
// // //                                                   style: const TextStyle(
// // //                                                     color: Colors.white,
// // //                                                     fontSize: 10,
// // //                                                     fontWeight: FontWeight.bold,
// // //                                                   ),
// // //                                                 ),
// // //                                               ],
// // //                                             ),
// // //                                           ),
// // //                                         ),
// // //                                       ],
// // //                                     ),
// // //                                   ),
// // //                                   // House Info
// // //                                   Padding(
// // //                                     padding: const EdgeInsets.all(8.0),
// // //                                     child: Column(
// // //                                       crossAxisAlignment:
// // //                                           CrossAxisAlignment.start,
// // //                                       children: [
// // //                                         Text(
// // //                                           house['title'],
// // //                                           style: const TextStyle(
// // //                                             fontWeight: FontWeight.bold,
// // //                                             fontSize: 14,
// // //                                           ),
// // //                                           maxLines: 1,
// // //                                           overflow: TextOverflow.ellipsis,
// // //                                         ),
// // //                                         const SizedBox(height: 4),
// // //                                         Row(
// // //                                           children: [
// // //                                             const Icon(
// // //                                               Icons.location_on_outlined,
// // //                                               size: 12,
// // //                                               color: Colors.grey,
// // //                                             ),
// // //                                             const SizedBox(width: 2),
// // //                                             Expanded(
// // //                                               child: Text(
// // //                                                 house['location'],
// // //                                                 style: const TextStyle(
// // //                                                   fontSize: 11,
// // //                                                   color: Colors.grey,
// // //                                                 ),
// // //                                                 maxLines: 1,
// // //                                                 overflow: TextOverflow.ellipsis,
// // //                                               ),
// // //                                             ),
// // //                                           ],
// // //                                         ),
// // //                                       ],
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                             ),
// // //                           );
// // //                         },
// // //                       ),
// // //               ),

// // //               const SizedBox(height: 80),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   // Widget _categoryChip(String label, bool isSelected) {
// // //   //   return GestureDetector(
// // //   //     onTap: () {
// // //   //       setState(() {
// // //   //         selectedCategory = label;
// // //   //       });
// // //   //     },
// // //   //     child: Container(
// // //   //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// // //   //       decoration: BoxDecoration(
// // //   //         color: isSelected ? Colors.black : Colors.grey[200],
// // //   //         borderRadius: BorderRadius.circular(20),
// // //   //       ),
// // //   //       child: Text(
// // //   //         label,
// // //   //         style: TextStyle(
// // //   //           color: isSelected ? Colors.white : Colors.black,
// // //   //           fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
// // //   //           fontSize: 14,
// // //   //         ),
// // //   //       ),
// // //   //     ),
// // //   //   );
// // //   // }

// // //   Widget _filterChip(String label, VoidCallback onRemove) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// // //       decoration: BoxDecoration(
// // //         color: Colors.blue[50],
// // //         borderRadius: BorderRadius.circular(16),
// // //         border: Border.all(color: Colors.blue[200]!),
// // //       ),
// // //       child: Row(
// // //         mainAxisSize: MainAxisSize.min,
// // //         children: [
// // //           Text(
// // //             label,
// // //             style: TextStyle(
// // //               color: Colors.blue[700],
// // //               fontSize: 12,
// // //               fontWeight: FontWeight.w500,
// // //             ),
// // //           ),
// // //           const SizedBox(width: 6),
// // //           GestureDetector(
// // //             onTap: onRemove,
// // //             child: Icon(
// // //               Icons.close,
// // //               size: 14,
// // //               color: Colors.blue[700],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// import 'dart:io';
// import 'package:farmhouse_app/widgets/like_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class FarmhouseHomePage extends StatefulWidget {
//   const FarmhouseHomePage({super.key});

//   @override
//   State<FarmhouseHomePage> createState() => _FarmhouseHomePageState();
// }

// class _FarmhouseHomePageState extends State<FarmhouseHomePage> {
//   int selectedTabIndex = 0;
//   String selectedCategory = 'All Category';
//   String selectedPrice = 'Select Price';
//   String selectedRooms = 'Select No Of Rooms';
//   int currentPropertyIndex = 0;
//   DateTime selectedDate = DateTime.now();
//   final TextEditingController _searchController = TextEditingController();

//   final WishlistManager wishlistManager = WishlistManager();

//   final List<String> tabs = ['Farmhouse & Home Stays', 'Hotel & Resorts'];

//   final List<Map<String, String>> categories = [
//     {'title': 'Basic Farmhouses', 'subtitle': 'Under 10000'},
//     {'title': 'Luxury Farmhouses', 'subtitle': 'Under 20000'},
//     {'title': 'With', 'subtitle': 'Box Cricket'},
//   ];

//   final List<Map<String, dynamic>> properties = [
//     {
//       'name': 'Dozzy 1773',
//       'bhk': '1 BHK',
//       'location': 'MOINABAD',
//       'distance': '39 mins near you',
//       'price': '₹ 7000',
//       'freeFor': 'Free for 10 members',
//       'images': [
//         'assets/farmhouseimage.jpg',
//         'assets/farmhouseimage.jpg',
//         'assets/farmhouseimage.jpg',
//         'assets/farmhouseimage.jpg',
//       ],
//     },
//     {
//       'name': 'Dozzy 1782',
//       'bhk': '2 BHK',
//       'location': 'SHAMSHABAD',
//       'distance': '45 mins near you',
//       'price': '₹ 8500',
//       'freeFor': 'Free for 12 members',
//       'images': [
//         'assets/farmhouseimage.jpg',
//         'assets/farmhouseimage.jpg',
//         'assets/farmhouseimage.jpg',
//       ],
//     },
//     {
//       'name': 'Sunset Villa',
//       'bhk': '3 BHK',
//       'location': 'KOMPALLY',
//       'distance': '25 mins near you',
//       'price': '₹ 12000',
//       'freeFor': 'Free for 15 members',
//       'images': [
//         'assets/farmhouseimage.jpg',
//         'assets/farmhouseimage.jpg',
//         'assets/farmhouseimage.jpg',
//         'assets/farmhouseimage.jpg',
//         'assets/farmhouseimage.jpg',
//       ],
//     },
//   ];

//   Map<int, int> currentImageIndexMap = {};

//   @override
//   void initState() {
//     super.initState();
//     wishlistManager.addListener(_onWishlistChanged);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     wishlistManager.removeListener(_onWishlistChanged);
//     super.dispose();
//   }

//   void _onWishlistChanged() {
//     setState(() {});
//   }

//   List<DateTime> _getDateList() {
//     List<DateTime> dates = [];
//     for (int i = 0; i < 8; i++) {
//       dates.add(selectedDate.add(Duration(days: i)));
//     }
//     return dates;
//   }

//   String _getDayName(DateTime date) {
//     const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return days[date.weekday - 1];
//   }

//   Future<void> _showDatePicker() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: Color(0xFF6366F1),
//               onPrimary: Colors.white,
//               onSurface: Colors.black,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   // void _shareProperty(Map<String, dynamic> property) {
//   //   final String propertyName = property['name'];
//   //   final String location = property['location'];
//   //   final String price = property['price'];
//   //   final String bhk = property['bhk'];

//   //   Share.share(
//   //     'Check out this amazing property!\n\n'
//   //     '🏡 $propertyName ($bhk)\n'
//   //     '📍 $location\n'
//   //     '💰 $price\n\n'
//   //     'Book now on Farmhouse App!',
//   //     subject: 'Check out $propertyName',
//   //   );
//   // }

//   Future<void> _shareProperty(Map<String, dynamic> property) async {
//   final String propertyName = property['name'];
//   final String location = property['location'];
//   final String price = property['price'];
//   final String bhk = property['bhk'];
//   final List<String> images = property['images'];

//   try {
//     // Pick the first image to share
//     final String assetPath = images[0];

//     // Load asset file to memory
//     final byteData = await rootBundle.load(assetPath);

//     // Create temp file
//     final tempDir = await getTemporaryDirectory();
//     final tempFile = File('${tempDir.path}/${propertyName.replaceAll(" ", "_")}.jpg');

//     // Write image bytes to temp file
//     await tempFile.writeAsBytes(
//       byteData.buffer.asUint8List(),
//       flush: true,
//     );

//     // Share text + image
//     await Share.shareXFiles(
//       [XFile(tempFile.path)],
//       text:
//           'Check out this amazing property!\n\n'
//           '🏡 $propertyName ($bhk)\n'
//           '📍 $location\n'
//           '💰 $price\n\n'
//           'Book now on Farmhouse App!',
//       subject: 'Check out $propertyName',
//     );
//   } catch (e) {
//     print("Share error: $e");
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildSearchBar(),
//               const SizedBox(height: 16),
//               _buildTopTabs(),
//               const SizedBox(height: 20),
//               _buildCategoryFilters(),
//               const SizedBox(height: 24),
//               _buildPropertyCardsList(),
//               const SizedBox(height: 24),
//               _buildDateSelector(),
//               const SizedBox(height: 100),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey[100],
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: TextField(
//           controller: _searchController,
//           decoration: InputDecoration(
//             hintText: 'Search by property number...',
//             hintStyle: TextStyle(
//               color: Colors.grey[500],
//               fontSize: 14,
//             ),
//             prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
//             suffixIcon: TextButton(
//               onPressed: () {
//                 _searchController.clear();
//               },
//               child: Text(
//                 'Close',
//                 style: TextStyle(
//                   color: const Color(0xFF6366F1),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             border: InputBorder.none,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTopTabs() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: List.generate(tabs.length, (index) {
//           final isSelected = selectedTabIndex == index;
//           return Expanded(
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   selectedTabIndex = index;
//                 });
//               },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(
//                       color: isSelected ? const Color(0xFF6366F1) : Colors.transparent,
//                       width: 2,
//                     ),
//                   ),
//                 ),
//                 child: Text(
//                   tabs[index],
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: isSelected ? const Color(0xFF6366F1) : Colors.grey[600],
//                     fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }

//   Widget _buildCategoryFilters() {
//     return SizedBox(
//       height: 80,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           final category = categories[index];
//           return Container(
//             margin: const EdgeInsets.only(right: 12),
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.grey[300]!, width: 1),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   category['title']!,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   category['subtitle']!,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildPropertyCardsList() {
//     return Column(
//       children: List.generate(
//         properties.length,
//         (propertyIndex) {
//           final property = properties[propertyIndex];
//           final images = property['images'] as List<String>;
//           final currentImageIndex = currentImageIndexMap[propertyIndex] ?? 0;
//           final isInWishlist = wishlistManager.isInWishlist(property['name']);

//           return Padding(
//             padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
//             child: Container(
//               height: 420,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(32),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 20,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(32),
//                     child: CarouselSlider.builder(
//                       itemCount: images.length,
//                       options: CarouselOptions(
//                         height: 420,
//                         viewportFraction: 1.0,
//                         enableInfiniteScroll: false,
//                         onPageChanged: (index, reason) {
//                           setState(() {
//                             currentImageIndexMap[propertyIndex] = index;
//                           });
//                         },
//                       ),
//                       itemBuilder: (context, imageIndex, realIndex) {
//                         return Stack(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     Colors.grey[300]!,
//                                     Colors.grey[100]!,
//                                   ],
//                                 ),
//                               ),
//                               child: Image.asset(
//                                 images[imageIndex],
//                                 width: double.infinity,
//                                 height: double.infinity,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return Container(
//                                     color: Colors.grey[300],
//                                     child: const Center(
//                                       child: Icon(Icons.home, size: 80, color: Colors.grey),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     Colors.transparent,
//                                     Colors.black.withOpacity(0.3),
//                                     Colors.black.withOpacity(0.7),
//                                   ],
//                                   stops: const [0.3, 0.6, 1.0],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),

//                   // Top Icons with Wishlist and Share
//                   Positioned(
//                     top: 16,
//                     left: 16,
//                     right: 16,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             wishlistManager.toggleWishlist(property);
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   isInWishlist
//                                     ? 'Removed from wishlist'
//                                     : 'Added to wishlist'
//                                 ),
//                                 duration: const Duration(seconds: 1),
//                                 backgroundColor: isInWishlist
//                                   ? Colors.grey[700]
//                                   : const Color(0xFF6366F1),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.3),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               isInWishlist ? Icons.favorite : Icons.favorite_border,
//                               color: isInWishlist ? Colors.red : Colors.white,
//                               size: 24,
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () => _shareProperty(property),
//                           child: Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.3),
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(
//                               Icons.send,
//                               color: Colors.white,
//                               size: 24,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Bottom Content
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Flexible(
//                                           child: Text(
//                                             property['name'],
//                                             style: const TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 22,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(width: 8),
//                                         Container(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 8,
//                                             vertical: 4,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white.withOpacity(0.2),
//                                             borderRadius: BorderRadius.circular(6),
//                                           ),
//                                           child: Text(
//                                             property['bhk'],
//                                             style: const TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 11,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 6),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           property['location'],
//                                           style: TextStyle(
//                                             color: Colors.white.withOpacity(0.9),
//                                             fontSize: 13,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                         Text(
//                                           ' | ${property['distance']}',
//                                           style: TextStyle(
//                                             color: Colors.white.withOpacity(0.7),
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       property['freeFor'],
//                                       style: TextStyle(
//                                         color: Colors.white.withOpacity(0.7),
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Text(
//                                 property['price'],
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 12),

//                           // Image Dots Indicator
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: List.generate(
//                               images.length,
//                               (index) => Container(
//                                 margin: const EdgeInsets.symmetric(horizontal: 3),
//                                 width: 6,
//                                 height: 6,
//                                 decoration: BoxDecoration(
//                                   color: index == currentImageIndex
//                                       ? Colors.white
//                                       : Colors.white.withOpacity(0.4),
//                                   shape: BoxShape.circle,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildDateSelector() {
//     final dateList = _getDateList();

//     return Column(
//       children: [
//         SizedBox(
//           height: 90,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             itemCount: dateList.length,
//             itemBuilder: (context, index) {
//               final date = dateList[index];
//               final isToday = date.day == DateTime.now().day &&
//                              date.month == DateTime.now().month &&
//                              date.year == DateTime.now().year;
//               final isSelected = date.day == selectedDate.day &&
//                                 date.month == selectedDate.month &&
//                                 date.year == selectedDate.year;

//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedDate = date;
//                   });
//                 },
//                 child: Container(
//                   width: 70,
//                   margin: const EdgeInsets.only(right: 8),
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   decoration: BoxDecoration(
//                     color: isSelected ? Colors.grey[800] : Colors.grey[100],
//                     borderRadius: BorderRadius.circular(12),
//                     border: isToday && !isSelected
//                         ? Border.all(color: const Color(0xFF6366F1), width: 2)
//                         : null,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         _getDayName(date),
//                         style: TextStyle(
//                           color: isSelected ? Colors.white : Colors.grey[600],
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         date.day.toString(),
//                         style: TextStyle(
//                           color: isSelected ? Colors.white : Colors.black,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       if (isToday && !isSelected)
//                         Container(
//                           margin: const EdgeInsets.only(top: 4),
//                           width: 6,
//                           height: 6,
//                           decoration: const BoxDecoration(
//                             color: Color(0xFF6366F1),
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 12),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Align(
//             alignment: Alignment.centerRight,
//             child: GestureDetector(
//               onTap: _showDatePicker,
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(
//                   Icons.calendar_month,
//                   color: Colors.grey[700],
//                   size: 24,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'dart:io';
// import 'package:farmhouse_app/views/details/house_detail_screen.dart';
// import 'package:farmhouse_app/widgets/like_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class FarmhouseHomePage extends StatefulWidget {
//   const FarmhouseHomePage({super.key});

//   @override
//   State<FarmhouseHomePage> createState() => _FarmhouseHomePageState();
// }

// class _FarmhouseHomePageState extends State<FarmhouseHomePage> {
//   int selectedTabIndex = 0;
//   String selectedCategory = 'All Category';
//   String selectedPrice = 'Select Price';
//   String selectedRooms = 'Select No Of Rooms';
//   int currentPropertyIndex = 0;
//   DateTime selectedDate = DateTime.now();
//   final TextEditingController _searchController = TextEditingController();

//   final WishlistManager wishlistManager = WishlistManager();

//   final List<String> tabs = ['Farmhouse & Home Stays', 'Hotel & Resorts'];

//   final List<Map<String, String>> categories = [
//     {'title': 'Basic Farmhouses', 'subtitle': 'Under 10000'},
//     {'title': 'Luxury Farmhouses', 'subtitle': 'Under 20000'},
//     {'title': 'With', 'subtitle': 'Box Cricket'},
//   ];

//   final List<Map<String, dynamic>> properties = [
//     {
//       'name': 'Dozzy 1773',
//       'bhk': '1 BHK',
//       'location': 'MOINABAD',
//       'distance': '39 mins near you',
//       'price': '₹ 7000',
//       'freeFor': 'Free for 10 members',
//       'images': [
//         'assets/farmhouseimage.jpg',
//         'assets/imagefarm.jpg',
//         'assets/farmimage.jpg',
//         'assets/farmimages.jpg',
//       ],
//     },
//     {
//       'name': 'Dozzy 1782',
//       'bhk': '2 BHK',
//       'location': 'SHAMSHABAD',
//       'distance': '45 mins near you',
//       'price': '₹ 8500',
//       'freeFor': 'Free for 12 members',
//       'images': [
//         'assets/farmhouseimage.jpg',
//         'assets/imagefarm.jpg',
//         'assets/farmimage.jpg',
//       ],
//     },
//     {
//       'name': 'Sunset Villa',
//       'bhk': '3 BHK',
//       'location': 'KOMPALLY',
//       'distance': '25 mins near you',
//       'price': '₹ 12000',
//       'freeFor': 'Free for 15 members',
//       'images': [
//         'assets/farmhouseimage.jpg',
//         'assets/imagefarm.jpg',
//         'assets/farmimage.jpg',
//         'assets/farmimages.jpg',
//         'assets/farmhouseimage.jpg',
//       ],
//     },
//   ];

//   Map<int, int> currentImageIndexMap = {};

//   @override
//   void initState() {
//     super.initState();
//     wishlistManager.addListener(_onWishlistChanged);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     wishlistManager.removeListener(_onWishlistChanged);
//     super.dispose();
//   }

//   void _onWishlistChanged() {
//     setState(() {});
//   }

//   List<DateTime> _getDateList() {
//     List<DateTime> dates = [];
//     for (int i = 0; i < 8; i++) {
//       dates.add(selectedDate.add(Duration(days: i)));
//     }
//     return dates;
//   }

//   String _getDayName(DateTime date) {
//     const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return days[date.weekday - 1];
//   }

//   Future<void> _showDatePicker() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: Color(0xFF6366F1),
//               onPrimary: Colors.white,
//               onSurface: Colors.black,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   Future<void> _shareProperty(Map<String, dynamic> property) async {
//     final String propertyName = property['name'];
//     final String location = property['location'];
//     final String price = property['price'];
//     final String bhk = property['bhk'];
//     final List<String> images = property['images'];

//     try {
//       final String assetPath = images[0];
//       final byteData = await rootBundle.load(assetPath);
//       final tempDir = await getTemporaryDirectory();
//       final tempFile = File('${tempDir.path}/${propertyName.replaceAll(" ", "_")}.jpg');

//       await tempFile.writeAsBytes(
//         byteData.buffer.asUint8List(),
//         flush: true,
//       );

//       await Share.shareXFiles(
//         [XFile(tempFile.path)],
//         text:
//             'Check out this amazing property!\n\n'
//             '🏡 $propertyName ($bhk)\n'
//             '📍 $location\n'
//             '💰 $price\n\n'
//             'Book now on Farmhouse App!',
//         subject: 'Check out $propertyName',
//       );
//     } catch (e) {
//       print("Share error: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildTopBanner(),
//               const SizedBox(height: 16),
//               _buildSearchBar(),
//               const SizedBox(height: 16),
//               _buildTopTabs(),
//               const SizedBox(height: 20),
//               _buildCategoryFilters(),
//               const SizedBox(height: 24),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseDetailScreen()));
//                 },
//                 child: _buildPropertyCardsList()),
//               const SizedBox(height: 24),
//               _buildDateSelector(),
//               const SizedBox(height: 100),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// Widget _buildTopBanner() {
//   return SizedBox(
//     height: 280,
//     child: CarouselSlider(
//       items: [
//         'assets/farmhouseimage.jpg',
//         'assets/onboardimage.jpg',
//         'assets/onboardingimage1.jpg',
//       ].map((image) {
//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.15),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Image.asset(
//               image,
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           ),
//         );
//       }).toList(),
//       options: CarouselOptions(
//         height: 280,
//         autoPlay: true,
//         enlargeCenterPage: true,
//         viewportFraction: 0.92,
//         autoPlayInterval: const Duration(seconds: 3),
//         autoPlayCurve: Curves.easeInOut,
//       ),
//     ),
//   );
// }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey[100],
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: TextField(
//           controller: _searchController,
//           decoration: InputDecoration(
//             hintText: 'Search by property number...',
//             hintStyle: TextStyle(
//               color: Colors.grey[500],
//               fontSize: 14,
//             ),
//             prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
//             suffixIcon: TextButton(
//               onPressed: () {
//                 _searchController.clear();
//               },
//               child: Text(
//                 'Close',
//                 style: TextStyle(
//                   color: const Color(0xFF6366F1),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             border: InputBorder.none,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTopTabs() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: List.generate(tabs.length, (index) {
//           final isSelected = selectedTabIndex == index;
//           return Expanded(
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   selectedTabIndex = index;
//                 });
//               },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(
//                       color: isSelected ? const Color(0xFF6366F1) : Colors.transparent,
//                       width: 2,
//                     ),
//                   ),
//                 ),
//                 child: Text(
//                   tabs[index],
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: isSelected ? const Color(0xFF6366F1) : Colors.grey[600],
//                     fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }

//   Widget _buildCategoryFilters() {
//     return SizedBox(
//       height: 80,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           final category = categories[index];
//           return Container(
//             margin: const EdgeInsets.only(right: 12),
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.grey[300]!, width: 1),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   category['title']!,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   category['subtitle']!,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildPropertyCardsList() {
//     return Column(
//       children: List.generate(
//         properties.length,
//         (propertyIndex) {
//           final property = properties[propertyIndex];
//           final images = property['images'] as List<String>;
//           final currentImageIndex = currentImageIndexMap[propertyIndex] ?? 0;
//           final isInWishlist = wishlistManager.isInWishlist(property['name']);

//           return Padding(
//             padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
//             child: Container(
//               height: 420,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(32),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 20,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(32),
//                     child: CarouselSlider.builder(
//                       itemCount: images.length,
//                       options: CarouselOptions(
//                         height: 420,
//                         viewportFraction: 1.0,
//                         enableInfiniteScroll: false,
//                         onPageChanged: (index, reason) {
//                           setState(() {
//                             currentImageIndexMap[propertyIndex] = index;
//                           });
//                         },
//                       ),
//                       itemBuilder: (context, imageIndex, realIndex) {
//                         return Stack(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     Colors.grey[300]!,
//                                     Colors.grey[100]!,
//                                   ],
//                                 ),
//                               ),
//                               child: Image.asset(
//                                 images[imageIndex],
//                                 width: double.infinity,
//                                 height: double.infinity,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return Container(
//                                     color: Colors.grey[300],
//                                     child: const Center(
//                                       child: Icon(Icons.home, size: 80, color: Colors.grey),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     Colors.transparent,
//                                     Colors.black.withOpacity(0.3),
//                                     Colors.black.withOpacity(0.7),
//                                   ],
//                                   stops: const [0.3, 0.6, 1.0],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),

//                   Positioned(
//                     top: 16,
//                     left: 16,
//                     right: 16,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             wishlistManager.toggleWishlist(property);
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   isInWishlist
//                                     ? 'Removed from wishlist'
//                                     : 'Added to wishlist'
//                                 ),
//                                 duration: const Duration(seconds: 1),
//                                 backgroundColor: isInWishlist
//                                   ? Colors.grey[700]
//                                   : const Color(0xFF6366F1),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.3),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               isInWishlist ? Icons.favorite : Icons.favorite_border,
//                               color: isInWishlist ? Colors.red : Colors.white,
//                               size: 24,
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () => _shareProperty(property),
//                           child: Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.3),
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(
//                               Icons.send,
//                               color: Colors.white,
//                               size: 24,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Flexible(
//                                           child: Text(
//                                             property['name'],
//                                             style: const TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 22,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(width: 8),
//                                         Container(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 8,
//                                             vertical: 4,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white.withOpacity(0.2),
//                                             borderRadius: BorderRadius.circular(6),
//                                           ),
//                                           child: Text(
//                                             property['bhk'],
//                                             style: const TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 11,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 6),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           property['location'],
//                                           style: TextStyle(
//                                             color: Colors.white.withOpacity(0.9),
//                                             fontSize: 13,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                         Text(
//                                           ' | ${property['distance']}',
//                                           style: TextStyle(
//                                             color: Colors.white.withOpacity(0.7),
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       property['freeFor'],
//                                       style: TextStyle(
//                                         color: Colors.white.withOpacity(0.7),
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Text(
//                                 property['price'],
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 12),

//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: List.generate(
//                               images.length,
//                               (index) => Container(
//                                 margin: const EdgeInsets.symmetric(horizontal: 3),
//                                 width: 6,
//                                 height: 6,
//                                 decoration: BoxDecoration(
//                                   color: index == currentImageIndex
//                                       ? Colors.white
//                                       : Colors.white.withOpacity(0.4),
//                                   shape: BoxShape.circle,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildDateSelector() {
//     final dateList = _getDateList();

//     return Column(
//       children: [
//         SizedBox(
//           height: 90,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             itemCount: dateList.length,
//             itemBuilder: (context, index) {
//               final date = dateList[index];
//               final isToday = date.day == DateTime.now().day &&
//                              date.month == DateTime.now().month &&
//                              date.year == DateTime.now().year;
//               final isSelected = date.day == selectedDate.day &&
//                                 date.month == selectedDate.month &&
//                                 date.year == selectedDate.year;

//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedDate = date;
//                   });
//                 },
//                 child: Container(
//                   width: 70,
//                   margin: const EdgeInsets.only(right: 8),
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   decoration: BoxDecoration(
//                     color: isSelected ? Colors.grey[800] : Colors.grey[100],
//                     borderRadius: BorderRadius.circular(12),
//                     border: isToday && !isSelected
//                         ? Border.all(color: const Color(0xFF6366F1), width: 2)
//                         : null,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         _getDayName(date),
//                         style: TextStyle(
//                           color: isSelected ? Colors.white : Colors.grey[600],
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         date.day.toString(),
//                         style: TextStyle(
//                           color: isSelected ? Colors.white : Colors.black,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       if (isToday && !isSelected)
//                         Container(
//                           margin: const EdgeInsets.only(top: 4),
//                           width: 6,
//                           height: 6,
//                           decoration: const BoxDecoration(
//                             color: Color(0xFF6366F1),
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 12),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Align(
//             alignment: Alignment.centerRight,
//             child: GestureDetector(
//               onTap: _showDatePicker,
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(
//                   Icons.calendar_month,
//                   color: Colors.grey[700],
//                   size: 24,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }





import 'dart:io';
import 'package:farmhouse_app/provider/Location/location_provider.dart';
import 'package:farmhouse_app/provider/Location/nearby_farmhouse_provider.dart';
import 'package:farmhouse_app/provider/auth/profile_provider.dart';
import 'package:farmhouse_app/provider/auth/register_provider.dart';
import 'package:farmhouse_app/provider/firebase/google_provider.dart';
import 'package:farmhouse_app/views/details/house_detail_screen.dart';
import 'package:farmhouse_app/views/home/profile_screen.dart';
import 'package:farmhouse_app/views/location/location_screen.dart';
import 'package:farmhouse_app/views/models/farmhouse_model.dart';
import 'package:farmhouse_app/views/search/search_screen.dart';
import 'package:farmhouse_app/widgets/carousel_widget.dart';
import 'package:farmhouse_app/widgets/like_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FarmhouseHomePage extends StatefulWidget {
  const FarmhouseHomePage({super.key});

  @override
  State<FarmhouseHomePage> createState() => _FarmhouseHomePageState();
}

class _FarmhouseHomePageState extends State<FarmhouseHomePage> {
  int selectedTabIndex = 0;
  String selectedCategory = 'All Category';
  String selectedPrice = 'Select Price';
  String selectedRooms = 'Select No Of Rooms';
  int currentPropertyIndex = 0;
  DateTime selectedDate = DateTime.now();
  final TextEditingController _searchController = TextEditingController();

  final WishlistManager wishlistManager = WishlistManager();

  final List<String> tabs = ['Farmhouse & Home Stays', 'Hotel & Resorts'];

  final List<Map<String, String>> categories = [
    {'title': 'Basic Farmhouses', 'subtitle': 'Under 10000'},
    {'title': 'Luxury Farmhouses', 'subtitle': 'Under 20000'},
    {'title': 'With', 'subtitle': 'Box Cricket'},
  ];

  final List<Map<String, String>> hotelCategories = [
    {'title': 'Luxury Resorts', 'subtitle': 'Top Rated'},
    {'title': 'Premium Hotels', 'subtitle': '5 Star'},
    {'title': 'Beach Resorts', 'subtitle': 'Sea View'},
  ];

  final List<String> hotelCategoryOptions = [
    'All Category',
    'Luxury Resorts',
    'Premium Hotels',
    'Beach Resorts',
  ];

  final List<String> priceOptions = [
    'Select Price',
    'Under 5000',
    '5000 - 10000',
    '10000 - 20000',
    '20000+',
  ];

  final List<String> roomsOptions = [
    'Select No Of Rooms',
    '1 Room',
    '2 Rooms',
    '3 Rooms',
    '4+ Rooms',
  ];

  // final List<Map<String, dynamic>> properties = [
  //   {
  //     'name': 'Dozzy 1773',
  //     'bhk': '1 BHK',
  //     'location': 'MOINABAD',
  //     'distance': '39 mins near you',
  //     'price': '₹ 7000',
  //     'freeFor': 'Free for 10 members',
  //     'images': [
  //       'assets/farmhouseimage.jpg',
  //       'assets/imagefarm.jpg',
  //       'assets/farmimage.jpg',
  //       'assets/farmimages.jpg',
  //     ],
  //   },
  //   {
  //     'name': 'Dozzy 1782',
  //     'bhk': '2 BHK',
  //     'location': 'SHAMSHABAD',
  //     'distance': '45 mins near you',
  //     'price': '₹ 8500',
  //     'freeFor': 'Free for 12 members',
  //     'images': [
  //       'assets/farmhouseimage.jpg',
  //       'assets/imagefarm.jpg',
  //       'assets/farmimage.jpg',
  //     ],
  //   },
  //   {
  //     'name': 'Sunset Villa',
  //     'bhk': '3 BHK',
  //     'location': 'KOMPALLY',
  //     'distance': '25 mins near you',
  //     'price': '₹ 12000',
  //     'freeFor': 'Free for 15 members',
  //     'images': [
  //       'assets/farmhouseimage.jpg',
  //       'assets/imagefarm.jpg',
  //       'assets/farmimage.jpg',
  //       'assets/farmimages.jpg',
  //       'assets/farmhouseimage.jpg',
  //     ],
  //   },
  // ];

  Map<int, int> currentImageIndexMap = {};

  @override
  void initState() {
    _loadProfileData();
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).loadUserFromPrefs();
    wishlistManager.addListener(_onWishlistChanged);
    _setupLocationListener();

    _loadProfileData().then((_) {
      Future.delayed(Duration(milliseconds: 500), () {
        _getCurrentLocationAutomatically();
      });
    });
  }

  Future<void> _getCurrentLocationAutomatically() async {
    print('🔍 Starting automatic location detection...');

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    if (user == null) {
      print('❌ User not logged in, cannot fetch location');
      return;
    }

    print('✅ User logged in: ${user.firstName}');
    print('✅ User iddddddddddddddddddddd :${user.id}');

    final locationProvider = Provider.of<LocationProvider>(
      context,
      listen: false,
    );

    // Check if location is already set
    if (locationProvider.address != null &&
        locationProvider.address!.trim().isNotEmpty) {
      print('✅ Location already set: ${locationProvider.address}');
      await _fetchNearbyFarmhouses();
      return;
    }

    print('📍 Fetching current location...');

    try {
      // Get current location automatically
      await locationProvider.getCurrentLocation();

      print(
        '📍 Location fetched - Lat: ${locationProvider.latitude}, Lng: ${locationProvider.longitude}',
      );
      print('📍 Address: ${locationProvider.address}');

      // After getting location, fetch nearby farmhouses
      if (locationProvider.address != null &&
          locationProvider.address!.isNotEmpty) {
        print('✅ Fetching nearby farmhouses...');
        await _fetchNearbyFarmhouses();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Location detected: ${locationProvider.address!.split(',').first}',
                    ),
                  ),
                ],
              ),
              backgroundColor: Color(0xFF6366F1),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.all(16),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        print('⚠️ Location fetched but address is empty');
      }
    } catch (e) {
      print('❌ Error getting current location: $e');

      // Show error to user so they know to set location manually
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.location_off, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Unable to detect location. Please set manually.',
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.all(16),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _loadProfileData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loadUserFromPrefs();

    final user = authProvider.user;
    if (user != null) {
      final profileProvider = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      await profileProvider.fetchProfile(user.id);
    }
  }

  void _setupLocationListener() {
    final locationProvider = Provider.of<LocationProvider>(
      context,
      listen: false,
    );

    locationProvider.addListener(() {
      // When location updates, fetch nearby farmhouses
      if (locationProvider.address != null &&
          locationProvider.address!.isNotEmpty) {
        _fetchNearbyFarmhouses();
      }
    });
  }

  Future<void> _fetchNearbyFarmhouses() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    if (user == null) {
      print('User not logged in, cannot fetch farmhouses');
      return;
    }

    final farmhouseProvider = Provider.of<FarmhouseProvider>(
      context,
      listen: false,
    );

    // Fetch farmhouses based on user's current location
    await farmhouseProvider.fetchNearbyFarmhousesByUserId(user.id);
  }

  //    Future<void> _fetchNearbyFarmhouses() async {
  //   final farmhouseProvider = Provider.of<FarmhouseProvider>(
  //     context,
  //     listen: false,
  //   );
  //   await farmhouseProvider.fetchNearbyFarmhouses();
  // }

  @override
  void dispose() {
    _searchController.dispose();
    wishlistManager.removeListener(_onWishlistChanged);
    super.dispose();
  }

  void _onWishlistChanged() {
    setState(() {});
  }

  List<DateTime> _getDateList() {
    List<DateTime> dates = [];
    for (int i = 0; i < 8; i++) {
      dates.add(selectedDate.add(Duration(days: i)));
    }
    return dates;
  }

  String _getDayName(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
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

  Future<void> shareFarmhouseWithMultipleImages(
    BuildContext context,
    Farmhouse farmhouse, {
    int maxImages = 3,
  }) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(color: Color(0xFF6366F1)),
        ),
      );

      List<XFile> imageFiles = [];
      final tempDir = await getTemporaryDirectory();

      // Download up to maxImages
      final imagesToDownload = farmhouse.images.take(maxImages).toList();

      for (int i = 0; i < imagesToDownload.length; i++) {
        try {
          final response = await http.get(Uri.parse(imagesToDownload[i]));

          if (response.statusCode == 200) {
            final fileName = '${farmhouse.name.replaceAll(" ", "_")}_$i.jpg';
            final imageFile = File('${tempDir.path}/$fileName');

            await imageFile.writeAsBytes(response.bodyBytes);
            imageFiles.add(XFile(imageFile.path));
          }
        } catch (e) {
          print('Error downloading image $i: $e');
        }
      }

      if (context.mounted) {
        Navigator.of(context).pop();
      }

      final shareText =
          '''
Check out this amazing farmhouse! 🏡

📍 ${farmhouse.name}
🌍 ${farmhouse.address}
⭐ Rating: ${farmhouse.rating}/5.0
💰 ₹${farmhouse.pricePerDay.toInt()}/day

✨ ${farmhouse.description}

Book now on Farmhouse App!
''';

      if (imageFiles.isNotEmpty) {
        await Share.shareXFiles(
          imageFiles,
          text: shareText,
          subject: 'Check out ${farmhouse.name}',
        );
      } else {
        await Share.share(shareText, subject: 'Check out ${farmhouse.name}');
      }
    } catch (e) {
      print('Share error: $e');

      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to share. Please try again.'),
            backgroundColor: Colors.red[700],
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final profileData = profileProvider.profileData;
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        // ... existing properties
        title: Consumer2<AuthProvider, GoogleAuthenticationProvider>(
          builder: (context, authProvider, googleAuthProvider, child) {
            final user = authProvider.user;
            final googleUser = googleAuthProvider.user;

            String displayName = "Guest User";
            if (googleUser?.displayName != null) {
              displayName = googleUser!.displayName!.split(' ')[0];
            } else if (user != null) {
              displayName = user.firstName;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello $displayName 👋",
                  // ... existing style
                ),

                Consumer<LocationProvider>(
                  builder: (context, locationProvider, child) {
                    final rawAddress = locationProvider.address ?? '';

                    // ---- 👇 NEW LOGIC YOU NEED ----
                    final bool noLocation = rawAddress.trim().isEmpty;

                    // Split address safely
                    final addressParts = rawAddress
                        .split(',')
                        .map((e) => e.trim())
                        .toList();

                    final primaryAddress =
                        !noLocation && addressParts.isNotEmpty
                        ? addressParts[0]
                        : 'Tap to set location'; // 👈 DEFAULT TEXT

                    final secondaryAddress =
                        (!noLocation && addressParts.length > 1)
                        ? addressParts.sublist(1).join(', ')
                        : '';

                    return GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LocationScreen(userId: user!.id.toString()),
                          ),
                        );

                        if (result == true && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text('Updating location...'),
                                ],
                              ),
                              backgroundColor: Color(0xFFFF5A5F),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: const EdgeInsets.all(16),
                            ),
                          );

                          await _fetchNearbyFarmhouses();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6366F1).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.location_on,
                                color: Color(0xFFFF5A5F),
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (locationProvider.isLoading == true)
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                          height: 10,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Color(0xFF6366F1),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Loading',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    )
                                  else
                                    Text(
                                      primaryAddress,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: noLocation
                                            ? Color(0xFF6366F1)
                                            : Color(0xFF1F2937),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                  if (!noLocation &&
                                      secondaryAddress.isNotEmpty)
                                    Text(
                                      secondaryAddress,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // ... your existing location widget
              ],
            );
          },
        ),

        actions: [
          Consumer2<ProfileProvider, GoogleAuthenticationProvider>(
            builder: (context, profileProvider, googleAuthProvider, child) {
              final profileData = profileProvider.profileData;
              final googleUser = googleAuthProvider.user;

              String? profileImageUrl =
                  googleUser?.photoURL ?? profileData?['profileImage'];

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: profileImageUrl != null
                        ? NetworkImage(profileImageUrl)
                        : null,
                    child: profileImageUrl == null
                        ? const Icon(Icons.person, size: 24, color: Colors.grey)
                        : null,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Scrollable content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 100,
                ), // Space for fixed date selector
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BannerSlider(),
                    // _buildTopBanner()
                    const SizedBox(height: 16),
                    _buildSearchBar(),
                    const SizedBox(height: 16),
                    _buildTopTabs(),
                    const SizedBox(height: 20),
                    _buildCategoryFilters(),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => HouseDetailScreen(),
                        //   ),
                        // );
                      },
                      child: _buildPropertyCardsList(),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Fixed bottom date selector
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildFixedDateSelector(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBanner() {
    return SizedBox(
      height: 200,
      child: CarouselSlider(
        items:
            [
              'assets/farmhouseimage.jpg',
              'assets/onboardimage.jpg',
              'assets/onboardingimage1.jpg',
            ].map((image) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            }).toList(),
        options: CarouselOptions(
          height: 280,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.92,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayCurve: Curves.easeInOut,
        ),
      ),
    );
  }

  // Widget _buildSearchBar() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.grey[100],
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: TextField(
  //         controller: _searchController,
  //         decoration: InputDecoration(
  //           hintText: 'Search by property number...',
  //           hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
  //           prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
  //           border: InputBorder.none,
  //           contentPadding: const EdgeInsets.symmetric(
  //             horizontal: 16,
  //             vertical: 14,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }



  Widget _buildSearchBar() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        readOnly: true, // 👈 prevents keyboard
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const SearchScreen(),
            ),
          );
        },
        decoration: InputDecoration(
          hintText: 'Search by property number...',
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    ),
  );
}


  Widget _buildTopTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedTabIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTabIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? const Color(0xFF6366F1)
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  tabs[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFF6366F1)
                        : Colors.grey[600],
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Widget _buildCategoryFilters() {
  //   return SizedBox(
  //     height: 80,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       padding: const EdgeInsets.symmetric(horizontal: 16),
  //       itemCount: categories.length,
  //       itemBuilder: (context, index) {
  //         final category = categories[index];
  //         return Container(
  //           margin: const EdgeInsets.only(right: 12),
  //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(color: Colors.grey[300]!, width: 1),
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 category['title']!,
  //                 textAlign: TextAlign.center,
  //                 style: const TextStyle(
  //                   fontSize: 13,
  //                   fontWeight: FontWeight.w600,
  //                   color: Colors.black,
  //                 ),
  //               ),
  //               const SizedBox(height: 2),
  //               Text(
  //                 category['subtitle']!,
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.w500,
  //                   color: Colors.grey[600],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _buildCategoryFilters() {
    if (selectedTabIndex == 1) {
      // HOTEL & RESORTS UI
      return Column(
        children: [
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: hotelCategories.length,
              itemBuilder: (context, index) {
                final category = hotelCategories[index];
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        category['title']!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        category['subtitle']!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // DROPDOWNS BELOW
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildDropdown(
                    'Category',
                    selectedCategory,
                    hotelCategoryOptions,
                    (val) {
                      setState(() => selectedCategory = val);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildDropdown('Price', selectedPrice, priceOptions, (
                    val,
                  ) {
                    setState(() => selectedPrice = val);
                  }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildDropdown('Rooms', selectedRooms, roomsOptions, (
                    val,
                  ) {
                    setState(() => selectedRooms = val);
                  }),
                ),
              ],
            ),
          ),
        ],
      );
    }

    //------------------------------------------------------------------
    // EXISTING FARMHOUSE CATEGORY LIST
    //------------------------------------------------------------------

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category['title']!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  category['subtitle']!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String selectedValue,
    List<String> options,
    Function(String) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 1.4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          onChanged: (value) => onChanged(value!),
          items: options.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildPropertyCardsList() {
    return Consumer2<FarmhouseProvider, LocationProvider>(
      builder: (context, farmhouseProvider, locationProvider, child) {
        // Show location prompt if no location set
        if (locationProvider.address == null ||
            locationProvider.address!.trim().isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Icon(
                    Icons.location_off_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Set your location to find nearby farmhouses',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final authProvider = Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      );
                      final user = authProvider.user;
                      if (user != null) {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LocationScreen(userId: user.id.toString()),
                          ),
                        );
                        if (result == true) {
                          await _fetchNearbyFarmhouses();
                        }
                      }
                    },
                    icon: const Icon(Icons.location_on),
                    label: const Text('Set Location'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Show loading indicator
        if (farmhouseProvider.isLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(color: Color(0xFF6366F1)),
            ),
          );
        }

        // Show error message
        if (farmhouseProvider.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    farmhouseProvider.errorMessage ??
                        'Failed to load farmhouses',
                    style: TextStyle(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _fetchNearbyFarmhouses,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        // Show empty state
        if (farmhouseProvider.farmhouses.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Icon(Icons.home_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No farmhouses found nearby',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (locationProvider.address != null)
                    Text(
                      'Near ${locationProvider.address!.split(',').first}',
                      style: TextStyle(color: Colors.grey[500], fontSize: 14),
                    ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () async {
                      final authProvider = Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      );
                      final user = authProvider.user;
                      if (user != null) {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LocationScreen(userId: user.id.toString()),
                          ),
                        );
                        if (result == true) {
                          await _fetchNearbyFarmhouses();
                        }
                      }
                    },
                    icon: const Icon(Icons.location_searching),
                    label: const Text('Change Location'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF6366F1),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Show farmhouse list with distance info
        final farmhouses = farmhouseProvider.farmhouses;
        final userLocation = farmhouseProvider.userLocation;

        return Column(
          children: [
            // Location info header
            if (userLocation != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Icon(Icons.near_me, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      'Found ${farmhouses.length} farmhouse${farmhouses.length > 1 ? 's' : ''} nearby',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

            // Farmhouse cards
            ...List.generate(farmhouses.length, (index) {
              final farmhouse = farmhouses[index];
              final images = farmhouse.images;
              final currentImageIndex = currentImageIndexMap[index] ?? 0;
              final isInWishlist = wishlistManager.isInWishlist(farmhouse.name);

              return Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                child: Container(
                  height: 420,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Carousel with Network Images
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HouseDetailScreen(
                                farmhouse: farmhouse,
                                id: farmhouse.id,
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: CarouselSlider.builder(
                            itemCount: images.length,
                            options: CarouselOptions(
                              height: 420,
                              viewportFraction: 1.0,
                              enableInfiniteScroll: false,
                              onPageChanged: (imgIndex, reason) {
                                setState(() {
                                  currentImageIndexMap[index] = imgIndex;
                                });
                              },
                            ),
                            itemBuilder: (context, imageIndex, realIndex) {
                              return Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.grey[300]!,
                                          Colors.grey[100]!,
                                        ],
                                      ),
                                    ),
                                    child: Image.network(
                                      images[imageIndex],
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value:
                                                    loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[300],
                                              child: const Center(
                                                child: Icon(
                                                  Icons.home,
                                                  size: 80,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.3),
                                          Colors.black.withOpacity(0.7),
                                        ],
                                        stops: const [0.3, 0.6, 1.0],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                      // Top actions (wishlist & share)
                      Positioned(
                        top: 16,
                        left: 16,
                        right: 16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                wishlistManager.toggleWishlist({
                                  'name': farmhouse.name,
                                  'id': farmhouse.id,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isInWishlist
                                          ? '${farmhouse.name} Removed from wishlist'
                                          : '${farmhouse.name} Added to wishlist',
                                    ),
                                    duration: const Duration(seconds: 1),
                                    backgroundColor: isInWishlist
                                        ? Colors.grey[700]
                                        : const Color(0xFF6366F1),
                                  ),
                                );
                              },
                              child: Icon(
                                isInWishlist
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isInWishlist ? Colors.red : Colors.white,
                                size: 24,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                shareFarmhouseWithMultipleImages(
                                  context,
                                  farmhouse,
                                );
                                // shareFarmhouse(context,farmhouse);
                                // Share functionality
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Bottom info
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                farmhouse.name,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(
                                                  0.2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 12,
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                    farmhouse.rating.toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          farmhouse.address,
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                              0.9,
                                            ),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          farmhouse.description,
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                              0.7,
                                            ),
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '₹${farmhouse.pricePerDay.toInt()}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'per day',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  images.length,
                                  (dotIndex) => Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 3,
                                    ),
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: dotIndex == currentImageIndex
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.4),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildFixedDateSelector() {
    // Always start from today and show next 7 days
    final dateList = List.generate(
      8,
      (index) => DateTime.now().add(Duration(days: index)),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: dateList.length + 1,
              itemBuilder: (context, index) {
                if (index == dateList.length) {
                  print(
                    'selecteddddddddd dateeeeeeeeeeeeeeeeeeeeee $selectedDate',
                  );
                  return GestureDetector(
                    onTap: _showDatePicker,
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.grey[700],
                        size: 28,
                      ),
                    ),
                  );
                }

                final date = dateList[index];
                final isToday =
                    date.day == DateTime.now().day &&
                    date.month == DateTime.now().month &&
                    date.year == DateTime.now().year;
                final isSelected =
                    date.day == selectedDate.day &&
                    date.month == selectedDate.month &&
                    date.year == selectedDate.year;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  child: Container(
                    width: 63,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.grey[300]!,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getDayName(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[600],
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isToday)
                          Text(
                            'Today',
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey[600],
                              fontSize: 10,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
