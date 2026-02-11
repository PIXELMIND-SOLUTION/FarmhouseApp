// import 'dart:io';
// import 'package:farmhouse_app/provider/Location/location_provider.dart';
// import 'package:farmhouse_app/provider/Location/nearby_farmhouse_provider.dart';
// import 'package:farmhouse_app/provider/auth/profile_provider.dart';
// import 'package:farmhouse_app/provider/auth/register_provider.dart';
// import 'package:farmhouse_app/provider/firebase/google_provider.dart';
// import 'package:farmhouse_app/provider/wishlist/wishlist_provider.dart';
// import 'package:farmhouse_app/views/details/house_detail_screen.dart';
// import 'package:farmhouse_app/views/home/profile_screen.dart';
// import 'package:farmhouse_app/views/location/location_screen.dart';
// import 'package:farmhouse_app/views/models/farmhouse_model.dart';
// import 'package:farmhouse_app/views/search/search_screen.dart';
// import 'package:farmhouse_app/widgets/carousel_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class FarmhouseHomePage extends StatefulWidget {
//   const FarmhouseHomePage({super.key});

//   @override
//   State<FarmhouseHomePage> createState() => _FarmhouseHomePageState();
// }

// class _FarmhouseHomePageState extends State<FarmhouseHomePage> {
//   int currentPropertyIndex = 0;
//   DateTime selectedDate = DateTime.now();
//   final TextEditingController _searchController = TextEditingController();

//   Map<int, int> currentImageIndexMap = {};

//   @override
//   void initState() {
//     super.initState();
//     _loadProfileData();
//     Provider.of<AuthProvider>(context, listen: false).loadUserFromPrefs();
//     _setupLocationListener();

//     // Load wishlist on init
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<WishlistProvider>(context, listen: false).fetchWishlist();
//     });

//     _loadProfileData().then((_) {
//       Future.delayed(Duration(milliseconds: 500), () {
//         _getCurrentLocationAutomatically();
//       });
//     });
//   }

//   Future<void> _getCurrentLocationAutomatically() async {
//     print('🔍 Starting automatic location detection...');

//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final user = authProvider.user;

//     if (user == null) {
//       print('❌ User not logged in, cannot fetch location');
//       return;
//     }

//     print('✅ User logged in: ${user.firstName}');
//     print('✅ User id: ${user.id}');

//     final locationProvider = Provider.of<LocationProvider>(
//       context,
//       listen: false,
//     );

//     // Check if location is already set
//     if (locationProvider.address != null &&
//         locationProvider.address!.trim().isNotEmpty) {
//       print('✅ Location already set: ${locationProvider.address}');
//       await _fetchNearbyFarmhouses();
//       return;
//     }

//     print('📍 Fetching current location...');

//     try {
//       // Get current location automatically
//       await locationProvider.getCurrentLocation();

//       print(
//         '📍 Location fetched - Lat: ${locationProvider.latitude}, Lng: ${locationProvider.longitude}',
//       );
//       print('📍 Address: ${locationProvider.address}');

//       // After getting location, fetch nearby farmhouses
//       if (locationProvider.address != null &&
//           locationProvider.address!.isNotEmpty) {
//         print('✅ Fetching nearby farmhouses...');
//         await _fetchNearbyFarmhouses();

//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Row(
//                 children: [
//                   Icon(Icons.location_on, color: Colors.white, size: 20),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       'Location detected: ${locationProvider.address!.split(',').first}',
//                     ),
//                   ),
//                 ],
//               ),
//               backgroundColor: Color(0xFF6366F1),
//               behavior: SnackBarBehavior.floating,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               margin: EdgeInsets.all(16),
//               duration: Duration(seconds: 2),
//             ),
//           );
//         }
//       } else {
//         print('⚠️ Location fetched but address is empty');
//       }
//     } catch (e) {
//       print('❌ Error getting current location: $e');

//       // Show error to user so they know to set location manually
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Row(
//               children: [
//                 Icon(Icons.location_off, color: Colors.white, size: 20),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     'Unable to detect location. Please set manually.',
//                   ),
//                 ),
//               ],
//             ),
//             backgroundColor: Colors.orange,
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             margin: EdgeInsets.all(16),
//             duration: Duration(seconds: 3),
//           ),
//         );
//       }
//     }
//   }

//   Future<void> _loadProfileData() async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     await authProvider.loadUserFromPrefs();

//     final user = authProvider.user;
//     if (user != null) {
//       final profileProvider = Provider.of<ProfileProvider>(
//         context,
//         listen: false,
//       );
//       await profileProvider.fetchProfile(user.id);
//     }
//   }

//   void _setupLocationListener() {
//     final locationProvider = Provider.of<LocationProvider>(
//       context,
//       listen: false,
//     );

//     locationProvider.addListener(() {
//       // When location updates, fetch nearby farmhouses
//       if (locationProvider.address != null &&
//           locationProvider.address!.isNotEmpty) {
//         _fetchNearbyFarmhouses();
//       }
//     });
//   }

//   Future<void> _fetchNearbyFarmhouses() async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final user = authProvider.user;

//     if (user == null) {
//       print('User not logged in, cannot fetch farmhouses');
//       return;
//     }

//     final farmhouseProvider = Provider.of<FarmhouseProvider>(
//       context,
//       listen: false,
//     );

//     // Format date as YYYY-MM-DD
//     final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

//     print('📅 Fetching farmhouses for date: $formattedDate');

//     // Fetch farmhouses based on user's current location and selected date
//     await farmhouseProvider.fetchNearbyFarmhousesByUserId(
//       user.id,
//       date: formattedDate,
//       maxDistance: 10000, // 10km radius - you can make this configurable
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
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
//       // Fetch farmhouses for the new date
//       await _fetchNearbyFarmhouses();
//     }
//   }

//   Future<void> shareFarmhouseWithMultipleImages(
//     BuildContext context,
//     Farmhouse farmhouse, {
//     int maxImages = 3,
//   }) async {
//     try {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => const Center(
//           child: CircularProgressIndicator(color: Color(0xFF6366F1)),
//         ),
//       );

//       List<XFile> imageFiles = [];
//       final tempDir = await getTemporaryDirectory();

//       // Download up to maxImages
//       final imagesToDownload = farmhouse.images.take(maxImages).toList();

//       for (int i = 0; i < imagesToDownload.length; i++) {
//         try {
//           final response = await http.get(Uri.parse(imagesToDownload[i]));

//           if (response.statusCode == 200) {
//             final fileName = '${farmhouse.name.replaceAll(" ", "_")}_$i.jpg';
//             final imageFile = File('${tempDir.path}/$fileName');

//             await imageFile.writeAsBytes(response.bodyBytes);
//             imageFiles.add(XFile(imageFile.path));
//           }
//         } catch (e) {
//           print('Error downloading image $i: $e');
//         }
//       }

//       if (context.mounted) {
//         Navigator.of(context).pop();
//       }

//       final shareText =
//           '''
// Check out this amazing farmhouse! 🏡

// 📍 ${farmhouse.name}
// 🌍 ${farmhouse.address}
// ⭐ Rating: ${farmhouse.rating}/5.0
// 💰 ₹${farmhouse.pricePerDay.toInt()}/day

// ✨ ${farmhouse.description}

// Book now on Farmhouse App!
// ''';

//       if (imageFiles.isNotEmpty) {
//         await Share.shareXFiles(
//           imageFiles,
//           text: shareText,
//           subject: 'Check out ${farmhouse.name}',
//         );
//       } else {
//         await Share.share(shareText, subject: 'Check out ${farmhouse.name}');
//       }
//     } catch (e) {
//       print('Share error: $e');

//       if (context.mounted) {
//         Navigator.of(context, rootNavigator: true).pop();

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: const Text('Failed to share. Please try again.'),
//             backgroundColor: Colors.red[700],
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       }
//     }
//   }

//   Future<void> _handleWishlistToggle(
//     BuildContext context,
//     String farmhouseId,
//     String farmhouseName,
//     bool isCurrentlyWishlisted,
//   ) async {
//     final wishlistProvider = Provider.of<WishlistProvider>(
//       context,
//       listen: false,
//     );

//     await wishlistProvider.toggleWishlist(farmhouseId);

//     if (context.mounted) {
//       // Check if there was an error
//       if (wishlistProvider.errorMessage != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(wishlistProvider.errorMessage!),
//             backgroundColor: Colors.red[700],
//             duration: const Duration(seconds: 2),
//           ),
//         );
//       } else {
//         // Success message
//         final nowWishlisted = wishlistProvider.isWishlisted(farmhouseId);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               nowWishlisted
//                   ? '$farmhouseName added to wishlist'
//                   : '$farmhouseName removed from wishlist',
//             ),
//             duration: const Duration(seconds: 1),
//             backgroundColor: nowWishlisted
//                 ? const Color(0xFF6366F1)
//                 : Colors.grey[700],
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profileProvider = Provider.of<ProfileProvider>(context);
//     final profileData = profileProvider.profileData;
//     final authProvider = Provider.of<AuthProvider>(context);
//     final user = authProvider.user;
//     return Scaffold(
//       // appBar: AppBar(
//       //   automaticallyImplyLeading: false,
//       //   toolbarHeight: 100,
//       //   title: Consumer2<AuthProvider, GoogleAuthenticationProvider>(
//       //     builder: (context, authProvider, googleAuthProvider, child) {
//       //       final user = authProvider.user;
//       //       final googleUser = googleAuthProvider.user;

//       //       String displayName = "Guest User";
//       //       if (googleUser?.displayName != null) {
//       //         displayName = googleUser!.displayName!.split(' ')[0];
//       //       } else if (user != null) {
//       //         displayName = user.firstName;
//       //       }

//       //       return Column(
//       //         crossAxisAlignment: CrossAxisAlignment.start,
//       //         children: [
//       //           Text(
//       //             "Hello $displayName 👋",
//       //             style: const TextStyle(
//       //               fontSize: 20,
//       //               fontWeight: FontWeight.bold,
//       //             ),
//       //           ),
//       //           Consumer<LocationProvider>(
//       //             builder: (context, locationProvider, child) {
//       //               final rawAddress = locationProvider.address ?? '';
//       //               final bool noLocation = rawAddress.trim().isEmpty;

//       //               final addressParts = rawAddress
//       //                   .split(',')
//       //                   .map((e) => e.trim())
//       //                   .toList();

//       //               final primaryAddress =
//       //                   !noLocation && addressParts.isNotEmpty
//       //                   ? addressParts[0]
//       //                   : 'Tap to set location';

//       //               final secondaryAddress =
//       //                   (!noLocation && addressParts.length > 1)
//       //                   ? addressParts.sublist(1).join(', ')
//       //                   : '';

//       //               return GestureDetector(
//       //                 onTap: () async {
//       //                   final result = await Navigator.push(
//       //                     context,
//       //                     MaterialPageRoute(
//       //                       builder: (context) =>
//       //                           LocationScreen(userId: user!.id.toString()),
//       //                     ),
//       //                   );

//       //                   if (result == true && mounted) {
//       //                     ScaffoldMessenger.of(context).showSnackBar(
//       //                       SnackBar(
//       //                         content: const Row(
//       //                           children: [
//       //                             Icon(
//       //                               Icons.location_on,
//       //                               color: Colors.white,
//       //                               size: 20,
//       //                             ),
//       //                             SizedBox(width: 8),
//       //                             Text('Updating location...'),
//       //                           ],
//       //                         ),
//       //                         backgroundColor: Color(0xFFFF5A5F),
//       //                         behavior: SnackBarBehavior.floating,
//       //                         shape: RoundedRectangleBorder(
//       //                           borderRadius: BorderRadius.circular(12),
//       //                         ),
//       //                         margin: const EdgeInsets.all(16),
//       //                       ),
//       //                     );

//       //                     await _fetchNearbyFarmhouses();
//       //                   }
//       //                 },
//       //                 child: Container(
//       //                   padding: const EdgeInsets.symmetric(
//       //                     horizontal: 12,
//       //                     vertical: 8,
//       //                   ),
//       //                   decoration: BoxDecoration(
//       //                     color: Colors.white,
//       //                     borderRadius: BorderRadius.circular(12),
//       //                     boxShadow: [
//       //                       BoxShadow(
//       //                         color: Colors.black.withOpacity(0.05),
//       //                         blurRadius: 6,
//       //                         offset: Offset(0, 1),
//       //                       ),
//       //                     ],
//       //                   ),
//       //                   child: Row(
//       //                     mainAxisSize: MainAxisSize.min,
//       //                     children: [
//       //                       Container(
//       //                         padding: const EdgeInsets.all(6),
//       //                         decoration: BoxDecoration(
//       //                           color: const Color(0xFF6366F1).withOpacity(0.1),
//       //                           borderRadius: BorderRadius.circular(8),
//       //                         ),
//       //                         child: const Icon(
//       //                           Icons.location_on,
//       //                           color: Color(0xFFFF5A5F),
//       //                           size: 16,
//       //                         ),
//       //                       ),
//       //                       const SizedBox(width: 8),
//       //                       Flexible(
//       //                         child: Column(
//       //                           crossAxisAlignment: CrossAxisAlignment.start,
//       //                           children: [
//       //                             if (locationProvider.isLoading == true)
//       //                               Row(
//       //                                 children: [
//       //                                   const SizedBox(
//       //                                     width: 10,
//       //                                     height: 10,
//       //                                     child: CircularProgressIndicator(
//       //                                       strokeWidth: 2,
//       //                                       color: Color(0xFF6366F1),
//       //                                     ),
//       //                                   ),
//       //                                   const SizedBox(width: 4),
//       //                                   Text(
//       //                                     'Loading',
//       //                                     style: TextStyle(
//       //                                       fontSize: 12,
//       //                                       color: Colors.grey[600],
//       //                                     ),
//       //                                   ),
//       //                                 ],
//       //                               )
//       //                             else
//       //                               Text(
//       //                                 primaryAddress,
//       //                                 style: TextStyle(
//       //                                   fontSize: 12,
//       //                                   color: noLocation
//       //                                       ? Color(0xFF6366F1)
//       //                                       : Color(0xFF1F2937),
//       //                                   fontWeight: FontWeight.w500,
//       //                                 ),
//       //                                 maxLines: 1,
//       //                                 overflow: TextOverflow.ellipsis,
//       //                               ),
//       //                             if (!noLocation &&
//       //                                 secondaryAddress.isNotEmpty)
//       //                               Text(
//       //                                 secondaryAddress,
//       //                                 style: TextStyle(
//       //                                   fontSize: 10,
//       //                                   color: Colors.grey[600],
//       //                                   fontWeight: FontWeight.w400,
//       //                                 ),
//       //                                 maxLines: 1,
//       //                                 overflow: TextOverflow.ellipsis,
//       //                               ),
//       //                           ],
//       //                         ),
//       //                       ),
//       //                     ],
//       //                   ),
//       //                 ),
//       //               );
//       //             },
//       //           ),
//       //         ],
//       //       );
//       //     },
//       //   ),
//       //   actions: [
//       //     Consumer2<ProfileProvider, GoogleAuthenticationProvider>(
//       //       builder: (context, profileProvider, googleAuthProvider, child) {
//       //         final profileData = profileProvider.profileData;
//       //         final googleUser = googleAuthProvider.user;

//       //         String? profileImageUrl =
//       //             googleUser?.photoURL ?? profileData?['profileImage'];

//       //         return Padding(
//       //           padding: const EdgeInsets.only(right: 12),
//       //           child: GestureDetector(
//       //             onTap: () {
//       //               Navigator.push(
//       //                 context,
//       //                 MaterialPageRoute(builder: (context) => ProfileScreen()),
//       //               );
//       //             },
//       //             child: CircleAvatar(
//       //               radius: 20,
//       //               backgroundColor: Colors.grey.shade200,
//       //               backgroundImage: profileImageUrl != null
//       //                   ? NetworkImage(profileImageUrl)
//       //                   : null,
//       //               child: profileImageUrl == null
//       //                   ? const Icon(Icons.person, size: 24, color: Colors.grey)
//       //                   : null,
//       //             ),
//       //           ),
//       //         );
//       //       },
//       //     ),
//       //   ],
//       // ),
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         top: false,
//         bottom: true,
//   child: Stack(
//     children: [

//       /// 📜 SCROLLABLE CONTENT
//       SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 100),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               /// 🔥 TOP BANNER + OVERLAY
//               Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   /// 🖼 API BANNER
//                   SizedBox(
//                     height: 220,
//                     child: BannerSlider(),
//                   ),

//                   /// 🌑 Gradient overlay
//                   Container(
//                     height: 220,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Colors.black.withOpacity(0.4),
//                           Colors.transparent,
//                           Colors.black.withOpacity(0.3),
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                     ),
//                   ),

//                   /// 📍 LOCATION + DAY VIEW
//                   Positioned(
//                     top: 40,
//                     left: 16,
//                     right: 16,
//                     child: Row(
//                       mainAxisAlignment:
//                           MainAxisAlignment.spaceBetween,
//                       children: [

//                         /// LOCATION
//                         Row(
//                           children: const [
//                             Icon(Icons.location_on,
//                                 color: Colors.white),
//                             SizedBox(width: 4),
//                             Text(
//                               "Kukatpally",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             Icon(Icons.keyboard_arrow_down,
//                                 color: Colors.white),
//                           ],
//                         ),

//                         /// DAY VIEW TOGGLE
//                         Container(
//                           padding:
//                               const EdgeInsets.symmetric(
//                                   horizontal: 12,
//                                   vertical: 6),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius:
//                                 BorderRadius.circular(20),
//                           ),
//                           child: const Text(
//                             "Day View",
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight:
//                                   FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   /// 🔍 FLOATING SEARCH BAR
//                   Positioned(
//                     bottom: -22,
//                     left: 16,
//                     right: 16,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius:
//                             BorderRadius.circular(14),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black
//                                 .withOpacity(0.1),
//                             blurRadius: 8,
//                           ),
//                         ],
//                       ),
//                       child: TextField(
//                         readOnly: true,
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) =>
//                                   const SearchScreen(),
//                             ),
//                           );
//                         },
//                         decoration:
//                             const InputDecoration(
//                           hintText:
//                               "Search by property number...",
//                           prefixIcon:
//                               Icon(Icons.search),
//                           border: InputBorder.none,
//                           contentPadding:
//                               EdgeInsets.symmetric(
//                                   horizontal: 16,
//                                   vertical: 14),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               /// space after floating search
//               const SizedBox(height: 40),

//               /// 🏡 PROPERTY LIST
//               _buildPropertyCardsList(),

//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),

//       /// 📅 FIXED DATE SELECTOR
//       Positioned(
//         bottom: 0,
//         left: 0,
//         right: 0,
//         child: _buildFixedDateSelector(),
//       ),
//     ],
//   ),
// )

//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey[100],
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: TextField(
//           readOnly: true,
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const SearchScreen()),
//             );
//           },
//           decoration: InputDecoration(
//             hintText: 'Search by property number...',
//             hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
//             prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
//             border: InputBorder.none,
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 14,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPropertyCardsList() {
//     return Consumer3<FarmhouseProvider, LocationProvider, WishlistProvider>(
//       builder: (context, farmhouseProvider, locationProvider, wishlistProvider, child) {
//         // Show location prompt if no location set
//         if (locationProvider.address == null ||
//             locationProvider.address!.trim().isEmpty) {
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(32.0),
//               child: Column(
//                 children: [
//                   Icon(
//                     Icons.location_off_outlined,
//                     size: 64,
//                     color: Colors.grey[400],
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Set your location to find nearby farmhouses',
//                     style: TextStyle(color: Colors.grey[600], fontSize: 16),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton.icon(
//                     onPressed: () async {
//                       final authProvider = Provider.of<AuthProvider>(
//                         context,
//                         listen: false,
//                       );
//                       final user = authProvider.user;
//                       if (user != null) {
//                         final result = await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 LocationScreen(userId: user.id.toString()),
//                           ),
//                         );
//                         if (result == true) {
//                           await _fetchNearbyFarmhouses();
//                         }
//                       }
//                     },
//                     icon: const Icon(Icons.location_on),
//                     label: const Text('Set Location'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF6366F1),
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 24,
//                         vertical: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }

//         // Show loading indicator
//         if (farmhouseProvider.isLoading) {
//           return const Center(
//             child: Padding(
//               padding: EdgeInsets.all(32.0),
//               child: CircularProgressIndicator(color: Color(0xFF6366F1)),
//             ),
//           );
//         }

//         // Show error message
//         if (farmhouseProvider.hasError) {
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(32.0),
//               child: Column(
//                 children: [
//                   Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
//                   const SizedBox(height: 16),
//                   Text(
//                     farmhouseProvider.errorMessage ??
//                         'Failed to load farmhouses',
//                     style: TextStyle(color: Colors.grey[600]),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: _fetchNearbyFarmhouses,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF6366F1),
//                     ),
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }

//         // Show empty state
//         if (farmhouseProvider.farmhouses.isEmpty) {
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(32.0),
//               child: Column(
//                 children: [
//                   Icon(Icons.home_outlined, size: 64, color: Colors.grey[400]),
//                   const SizedBox(height: 16),
//                   Text(
//                     'No farmhouses available',
//                     style: TextStyle(
//                       color: Colors.grey[700],
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'for ${DateFormat('MMM dd, yyyy').format(selectedDate)}',
//                     style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                   ),
//                   if (locationProvider.address != null)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 4),
//                       child: Text(
//                         'Near ${locationProvider.address!.split(',').first}',
//                         style: TextStyle(color: Colors.grey[500], fontSize: 14),
//                       ),
//                     ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       TextButton.icon(
//                         onPressed: () {
//                           setState(() {
//                             selectedDate = DateTime.now();
//                           });
//                           _fetchNearbyFarmhouses();
//                         },
//                         icon: const Icon(Icons.today),
//                         label: const Text('Try Today'),
//                         style: TextButton.styleFrom(
//                           foregroundColor: const Color(0xFF6366F1),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       TextButton.icon(
//                         onPressed: () async {
//                           final authProvider = Provider.of<AuthProvider>(
//                             context,
//                             listen: false,
//                           );
//                           final user = authProvider.user;
//                           if (user != null) {
//                             final result = await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     LocationScreen(userId: user.id.toString()),
//                               ),
//                             );
//                             if (result == true) {
//                               await _fetchNearbyFarmhouses();
//                             }
//                           }
//                         },
//                         icon: const Icon(Icons.location_searching),
//                         label: const Text('Change Location'),
//                         style: TextButton.styleFrom(
//                           foregroundColor: const Color(0xFF6366F1),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }

//         // Show farmhouse list with distance info
//         final farmhouses = farmhouseProvider.farmhouses;
//         final userLocation = farmhouseProvider.userLocation;

//         return Column(
//           children: [
//             // Location and date info header
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.calendar_today,
//                         size: 14,
//                         color: Colors.grey[600],
//                       ),
//                       const SizedBox(width: 6),
//                       Text(
//                         DateFormat('EEEE, MMM dd, yyyy').format(selectedDate),
//                         style: TextStyle(
//                           color: Colors.grey[700],
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   if (userLocation != null)
//                     Row(
//                       children: [
//                         Icon(Icons.near_me, size: 14, color: Colors.grey[600]),
//                         const SizedBox(width: 6),
//                         Text(
//                           'Found ${farmhouses.length} farmhouse${farmhouses.length > 1 ? 's' : ''} nearby',
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//             ),

//             // Farmhouse cards
//             ...List.generate(farmhouses.length, (index) {
//               final farmhouse = farmhouses[index];
//               final images = farmhouse.images;
//               final currentImageIndex = currentImageIndexMap[index] ?? 0;
//               final isInWishlist = wishlistProvider.isWishlisted(farmhouse.id);

//               return Padding(
//                 padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
//                 child: Container(
//                   height: 420,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(32),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 20,
//                         offset: const Offset(0, 10),
//                       ),
//                     ],
//                   ),
//                   child: Stack(
//                     children: [
//                       // Carousel with Network Images
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => HouseDetailScreen(
//                                 farmhouse: farmhouse,
//                                 id: farmhouse.id,
//                               ),
//                             ),
//                           );
//                         },
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(32),
//                           child: CarouselSlider.builder(
//                             itemCount: images.length,
//                             options: CarouselOptions(
//                               height: 420,
//                               viewportFraction: 1.0,
//                               enableInfiniteScroll: false,
//                               onPageChanged: (imgIndex, reason) {
//                                 setState(() {
//                                   currentImageIndexMap[index] = imgIndex;
//                                 });
//                               },
//                             ),
//                             itemBuilder: (context, imageIndex, realIndex) {
//                               return Stack(
//                                 children: [
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         begin: Alignment.topCenter,
//                                         end: Alignment.bottomCenter,
//                                         colors: [
//                                           Colors.grey[300]!,
//                                           Colors.grey[100]!,
//                                         ],
//                                       ),
//                                     ),
//                                     child: Image.network(
//                                       images[imageIndex],
//                                       width: double.infinity,
//                                       height: double.infinity,
//                                       fit: BoxFit.cover,
//                                       loadingBuilder:
//                                           (context, child, loadingProgress) {
//                                             if (loadingProgress == null)
//                                               return child;
//                                             return Center(
//                                               child: CircularProgressIndicator(
//                                                 value:
//                                                     loadingProgress
//                                                             .expectedTotalBytes !=
//                                                         null
//                                                     ? loadingProgress
//                                                               .cumulativeBytesLoaded /
//                                                           loadingProgress
//                                                               .expectedTotalBytes!
//                                                     : null,
//                                               ),
//                                             );
//                                           },
//                                       errorBuilder:
//                                           (context, error, stackTrace) {
//                                             return Container(
//                                               color: Colors.grey[300],
//                                               child: const Center(
//                                                 child: Icon(
//                                                   Icons.home,
//                                                   size: 80,
//                                                   color: Colors.grey,
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                     ),
//                                   ),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         begin: Alignment.topCenter,
//                                         end: Alignment.bottomCenter,
//                                         colors: [
//                                           Colors.transparent,
//                                           Colors.black.withOpacity(0.3),
//                                           Colors.black.withOpacity(0.7),
//                                         ],
//                                         stops: const [0.3, 0.6, 1.0],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           ),
//                         ),
//                       ),

//                       // Top actions (wishlist & share)
//                       Positioned(
//                         top: 16,
//                         left: 16,
//                         right: 16,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 _handleWishlistToggle(
//                                   context,
//                                   farmhouse.id,
//                                   farmhouse.name,
//                                   isInWishlist,
//                                 );
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.3),
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Icon(
//                                   isInWishlist
//                                       ? Icons.favorite
//                                       : Icons.favorite_border,
//                                   color: isInWishlist
//                                       ? Colors.red
//                                       : Colors.white,
//                                   size: 24,
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 shareFarmhouseWithMultipleImages(
//                                   context,
//                                   farmhouse,
//                                 );
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.3),
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(
//                                   Icons.send,
//                                   color: Colors.white,
//                                   size: 24,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       // Bottom info
//                       Positioned(
//                         bottom: 0,
//                         left: 0,
//                         right: 0,
//                         child: Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Flexible(
//                                               child: Text(
//                                                 farmhouse.name,
//                                                 style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 22,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(width: 8),
//                                             Container(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                     horizontal: 8,
//                                                     vertical: 4,
//                                                   ),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white.withOpacity(
//                                                   0.2,
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(6),
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   const Icon(
//                                                     Icons.star,
//                                                     color: Colors.amber,
//                                                     size: 12,
//                                                   ),
//                                                   const SizedBox(width: 2),
//                                                   Text(
//                                                     farmhouse.rating.toString(),
//                                                     style: const TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: 11,
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(height: 6),
//                                         Text(
//                                           farmhouse.address,
//                                           style: TextStyle(
//                                             color: Colors.white.withOpacity(
//                                               0.9,
//                                             ),
//                                             fontSize: 13,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 4),
//                                         Text(
//                                           farmhouse.description,
//                                           style: TextStyle(
//                                             color: Colors.white.withOpacity(
//                                               0.7,
//                                             ),
//                                             fontSize: 12,
//                                           ),
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(width: 12),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         '₹${farmhouse.pricePerDay.toInt()}',
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Text(
//                                         'per day',
//                                         style: TextStyle(
//                                           color: Colors.white.withOpacity(0.7),
//                                           fontSize: 10,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 12),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: List.generate(
//                                   images.length,
//                                   (dotIndex) => Container(
//                                     margin: const EdgeInsets.symmetric(
//                                       horizontal: 3,
//                                     ),
//                                     width: 6,
//                                     height: 6,
//                                     decoration: BoxDecoration(
//                                       color: dotIndex == currentImageIndex
//                                           ? Colors.white
//                                           : Colors.white.withOpacity(0.4),
//                                       shape: BoxShape.circle,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildFixedDateSelector() {
//     // Always start from today and show next 7 days
//     final dateList = List.generate(
//       8,
//       (index) => DateTime.now().add(Duration(days: index)),
//     );

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 12),
//           SizedBox(
//             height: 70,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: dateList.length + 1,
//               itemBuilder: (context, index) {
//                 if (index == dateList.length) {
//                   return GestureDetector(
//                     onTap: _showDatePicker,
//                     child: Container(
//                       width: 60,
//                       margin: const EdgeInsets.only(left: 8),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(
//                           color: Colors.grey[300]!,
//                           width: 1.5,
//                         ),
//                       ),
//                       child: Icon(
//                         Icons.calendar_today_rounded,
//                         color: Colors.grey[700],
//                         size: 28,
//                       ),
//                     ),
//                   );
//                 }

//                 final date = dateList[index];
//                 final isToday =
//                     date.day == DateTime.now().day &&
//                     date.month == DateTime.now().month &&
//                     date.year == DateTime.now().year;
//                 final isSelected =
//                     date.day == selectedDate.day &&
//                     date.month == selectedDate.month &&
//                     date.year == selectedDate.year;

//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedDate = date;
//                     });
//                     // Fetch farmhouses for the selected date
//                     _fetchNearbyFarmhouses();
//                   },
//                   child: Container(
//                     width: 63,
//                     margin: const EdgeInsets.only(right: 10),
//                     decoration: BoxDecoration(
//                       color: isSelected ? Colors.black : Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(
//                         color: isSelected ? Colors.black : Colors.grey[300]!,
//                         width: 1.5,
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           _getDayName(date),
//                           style: TextStyle(
//                             color: isSelected ? Colors.white : Colors.grey[600],
//                             fontSize: 13,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           date.day.toString(),
//                           style: TextStyle(
//                             color: isSelected ? Colors.white : Colors.black,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         if (isToday)
//                           Text(
//                             'Today',
//                             style: TextStyle(
//                               color: isSelected
//                                   ? Colors.white
//                                   : Colors.grey[600],
//                               fontSize: 10,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 12),
//         ],
//       ),
//     );
//   }
// }






import 'dart:io';
import 'package:farmhouse_app/provider/Location/location_provider.dart';
import 'package:farmhouse_app/provider/Location/nearby_farmhouse_provider.dart';
import 'package:farmhouse_app/provider/auth/profile_provider.dart';
import 'package:farmhouse_app/provider/auth/register_provider.dart';
import 'package:farmhouse_app/provider/firebase/google_provider.dart';
import 'package:farmhouse_app/provider/wishlist/wishlist_provider.dart';
import 'package:farmhouse_app/theme/theme_provider.dart';
import 'package:farmhouse_app/views/details/house_detail_screen.dart';
import 'package:farmhouse_app/views/home/profile_screen.dart';
import 'package:farmhouse_app/views/location/location_screen.dart';
import 'package:farmhouse_app/views/models/farmhouse_model.dart';
import 'package:farmhouse_app/views/search/search_screen.dart';
import 'package:farmhouse_app/widgets/carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

class FarmhouseHomePage extends StatefulWidget {
  const FarmhouseHomePage({super.key});

  @override
  State<FarmhouseHomePage> createState() => _FarmhouseHomePageState();
}

class _FarmhouseHomePageState extends State<FarmhouseHomePage> {
  int currentPropertyIndex = 0;
  DateTime selectedDate = DateTime.now();
  final TextEditingController _searchController = TextEditingController();

  Map<int, int> currentImageIndexMap = {};

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    Provider.of<AuthProvider>(context, listen: false).loadUserFromPrefs();
    _setupLocationListener();

    // Load wishlist on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WishlistProvider>(context, listen: false).fetchWishlist();
    });

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
    print('✅ User id: ${user.id}');

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

    // Format date as YYYY-MM-DD
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    print('📅 Fetching farmhouses for date: $formattedDate');

    // Fetch farmhouses based on user's current location and selected date
    await farmhouseProvider.fetchNearbyFarmhousesByUserId(
      user.id,
      date: formattedDate,
      maxDistance: 10000, // 10km radius - you can make this configurable
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
      // Fetch farmhouses for the new date
      await _fetchNearbyFarmhouses();
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

  Future<void> _handleWishlistToggle(
    BuildContext context,
    String farmhouseId,
    String farmhouseName,
    bool isCurrentlyWishlisted,
  ) async {
    final wishlistProvider = Provider.of<WishlistProvider>(
      context,
      listen: false,
    );

    await wishlistProvider.toggleWishlist(farmhouseId);

    if (context.mounted) {
      // Check if there was an error
      if (wishlistProvider.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(wishlistProvider.errorMessage!),
            backgroundColor: Colors.red[700],
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        // Success message
        final nowWishlisted = wishlistProvider.isWishlisted(farmhouseId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              nowWishlisted
                  ? '$farmhouseName added to wishlist'
                  : '$farmhouseName removed from wishlist',
            ),
            duration: const Duration(seconds: 1),
            backgroundColor: nowWishlisted
                ? const Color(0xFF6366F1)
                : Colors.grey[700],
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        top: false,
        bottom: true,
        child: Stack(
          children: [
            /// 📜 SCROLLABLE CONTENT
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔥 TOP BANNER + OVERLAY
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        /// 🖼 API BANNER
                        SizedBox(height: 220, child: BannerSlider()),

                        /// 🌑 Gradient overlay
                        Container(
                          height: 220,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.4),
                                Colors.transparent,
                                Colors.black.withOpacity(0.3),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),

                        /// 📍 LOCATION + DAY/NIGHT VIEW TOGGLE
                        Positioned(
                          top: 40,
                          left: 16,
                          right: 16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// LOCATION
                              // Consumer<LocationProvider>(
                              //   builder: (context, locationProvider, child) {
                              //     final rawAddress =
                              //         locationProvider.address ?? '';
                              //     final bool noLocation = rawAddress
                              //         .trim()
                              //         .isEmpty;

                              //     final addressParts = rawAddress
                              //         .split(',')
                              //         .map((e) => e.trim())
                              //         .toList();

                              //     final primaryAddress =
                              //         !noLocation && addressParts.isNotEmpty
                              //         ? addressParts[0]
                              //         : 'Set Location';

                              //     return GestureDetector(
                              //       onTap: () async {
                              //         if (user != null) {
                              //           final result = await Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //               builder: (context) =>
                              //                   LocationScreen(
                              //                     userId: user.id.to  String(),
                              //                   ),
                              //             ),
                              //           );
                              //           if (result == true && mounted) {
                              //             await _fetchNearbyFarmhouses();
                              //           }
                              //         }
                              //       },
                              //       child: Row(
                              //         children: [
                              //           Icon(
                              //             Icons.location_on,
                              //             color: Colors.white,
                              //             size: 20,
                              //           ),
                              //           SizedBox(width: 4),
                              //           Text(
                              //             primaryAddress,
                              //             style: TextStyle(
                              //               color: Colors.white,
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.w600,
                              //             ),
                              //           ),
                              //           Icon(
                              //             Icons.keyboard_arrow_down,
                              //             color: Colors.white,
                              //             size: 20,
                              //           ),
                              //         ],
                              //       ),
                              //     );
                              //   },
                              // ),

                              /// LOCATION
                              Consumer<LocationProvider>(
                                builder: (context, locationProvider, child) {
                                  final rawAddress =
                                      locationProvider.address ?? '';
                                  final bool noLocation = rawAddress
                                      .trim()
                                      .isEmpty;

                                  final addressParts = rawAddress
                                      .split(',')
                                      .map((e) => e.trim())
                                      .toList();

                                  final primaryAddress =
                                      !noLocation && addressParts.isNotEmpty
                                      ? addressParts[0]
                                      : 'Set Location';

                                  return GestureDetector(
                                    onTap: () async {
                                      if (user != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LocationScreen(
                                                  userId: user.id.toString(),
                                                ),
                                          ),
                                        );
                                        if (result == true && mounted) {
                                          await _fetchNearbyFarmhouses();
                                        }
                                      }
                                    },
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                            0.6, // Limit to 60% of screen width
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(width: 4),
                                          Flexible(
                                            child: Text(
                                              primaryAddress,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),

                              /// DAY/NIGHT VIEW TOGGLE
                              GestureDetector(
                                onTap: () {
                                  themeProvider.toggleTheme(!isDarkMode);

                                  // Optional: Show a quick feedback
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            isDarkMode
                                                ? Icons.light_mode
                                                : Icons.dark_mode,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            isDarkMode
                                                ? 'Day View activated'
                                                : 'Night View activated',
                                          ),
                                        ],
                                      ),
                                      duration: Duration(milliseconds: 800),
                                      backgroundColor: isDarkMode
                                          ? Colors.amber[700]
                                          : const Color.fromARGB(
                                              255,
                                              143,
                                              152,
                                              255,
                                            ),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      margin: EdgeInsets.all(16),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        isDarkMode
                                            ? Icons.wb_sunny
                                            : Icons.nights_stay,
                                        size: 14,
                                        color: isDarkMode
                                            ? Colors.amber[700]
                                            : Colors.indigo[900],
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        isDarkMode ? "Day" : "Night",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// 🔍 FLOATING SEARCH BAR
                        Positioned(
                          bottom: -22,
                          left: 16,
                          right: 16,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: TextField(
                              readOnly: true,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SearchScreen(),
                                  ),
                                );
                              },
                              decoration: InputDecoration(
                                hintText: "Search by property number...",
                                hintStyle: TextStyle(
                                  color: isDarkMode
                                      ? Colors.grey[400]
                                      : Colors.grey[600],
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: isDarkMode
                                      ? Colors.grey[400]
                                      : Colors.grey[600],
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// space after floating search
                    const SizedBox(height: 40),

                    /// 🏡 PROPERTY LIST
                    _buildPropertyCardsList(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            /// 📅 FIXED DATE SELECTOR
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

  // Widget _buildPropertyCardsList() {
  //   final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

  //   return Consumer3<FarmhouseProvider, LocationProvider, WishlistProvider>(
  //     builder: (context, farmhouseProvider, locationProvider,
  //         wishlistProvider, child) {
  //       // Show location prompt if no location set
  //       if (locationProvider.address == null ||
  //           locationProvider.address!.trim().isEmpty) {
  //         return Center(
  //           child: Padding(
  //             padding: const EdgeInsets.all(32.0),
  //             child: Column(
  //               children: [
  //                 Icon(
  //                   Icons.location_off_outlined,
  //                   size: 64,
  //                   color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
  //                 ),
  //                 const SizedBox(height: 16),
  //                 Text(
  //                   'Set your location to find nearby farmhouses',
  //                   style: TextStyle(
  //                     color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
  //                     fontSize: 16,
  //                   ),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 const SizedBox(height: 16),
  //                 ElevatedButton.icon(
  //                   onPressed: () async {
  //                     final authProvider = Provider.of<AuthProvider>(
  //                       context,
  //                       listen: false,
  //                     );
  //                     final user = authProvider.user;
  //                     if (user != null) {
  //                       final result = await Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) =>
  //                               LocationScreen(userId: user.id.toString()),
  //                         ),
  //                       );
  //                       if (result == true) {
  //                         await _fetchNearbyFarmhouses();
  //                       }
  //                     }
  //                   },
  //                   icon: const Icon(Icons.location_on),
  //                   label: const Text('Set Location'),
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: const Color(0xFF6366F1),
  //                     foregroundColor: Colors.white,
  //                     padding: const EdgeInsets.symmetric(
  //                       horizontal: 24,
  //                       vertical: 12,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       }

  //       // Show loading indicator
  //       if (farmhouseProvider.isLoading) {
  //         return const Center(
  //           child: Padding(
  //             padding: EdgeInsets.all(32.0),
  //             child: CircularProgressIndicator(color: Color(0xFF6366F1)),
  //           ),
  //         );
  //       }

  //       // Show error message
  //       if (farmhouseProvider.hasError) {
  //         return Center(
  //           child: Padding(
  //             padding: const EdgeInsets.all(32.0),
  //             child: Column(
  //               children: [
  //                 Icon(
  //                   Icons.error_outline,
  //                   size: 48,
  //                   color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
  //                 ),
  //                 const SizedBox(height: 16),
  //                 Text(
  //                   farmhouseProvider.errorMessage ??
  //                       'Failed to load farmhouses',
  //                   style: TextStyle(
  //                     color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
  //                   ),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 const SizedBox(height: 16),
  //                 ElevatedButton(
  //                   onPressed: _fetchNearbyFarmhouses,
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: const Color(0xFF6366F1),
  //                   ),
  //                   child: const Text('Retry'),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       }

  //       // Show empty state
  //       if (farmhouseProvider.farmhouses.isEmpty) {
  //         return Center(
  //           child: Padding(
  //             padding: const EdgeInsets.all(32.0),
  //             child: Column(
  //               children: [
  //                 Icon(
  //                   Icons.home_outlined,
  //                   size: 64,
  //                   color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
  //                 ),
  //                 const SizedBox(height: 16),
  //                 Text(
  //                   'No farmhouses available',
  //                   style: TextStyle(
  //                     color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Text(
  //                   'for ${DateFormat('MMM dd, yyyy').format(selectedDate)}',
  //                   style: TextStyle(
  //                     color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //                 if (locationProvider.address != null)
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 4),
  //                     child: Text(
  //                       'Near ${locationProvider.address!.split(',').first}',
  //                       style: TextStyle(
  //                         color:
  //                             isDarkMode ? Colors.grey[500] : Colors.grey[500],
  //                         fontSize: 14,
  //                       ),
  //                     ),
  //                   ),
  //                 const SizedBox(height: 16),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     TextButton.icon(
  //                       onPressed: () {
  //                         setState(() {
  //                           selectedDate = DateTime.now();
  //                         });
  //                         _fetchNearbyFarmhouses();
  //                       },
  //                       icon: const Icon(Icons.today),
  //                       label: const Text('Try Today'),
  //                       style: TextButton.styleFrom(
  //                         foregroundColor: const Color(0xFF6366F1),
  //                       ),
  //                     ),
  //                     const SizedBox(width: 8),
  //                     TextButton.icon(
  //                       onPressed: () async {
  //                         final authProvider = Provider.of<AuthProvider>(
  //                           context,
  //                           listen: false,
  //                         );
  //                         final user = authProvider.user;
  //                         if (user != null) {
  //                           final result = await Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                               builder: (context) => LocationScreen(
  //                                   userId: user.id.toString()),
  //                             ),
  //                           );
  //                           if (result == true) {
  //                             await _fetchNearbyFarmhouses();
  //                           }
  //                         }
  //                       },
  //                       icon: const Icon(Icons.location_searching),
  //                       label: const Text('Change Location'),
  //                       style: TextButton.styleFrom(
  //                         foregroundColor: const Color(0xFF6366F1),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       }

  //       // Show farmhouse list with distance info
  //       final farmhouses = farmhouseProvider.farmhouses;
  //       final userLocation = farmhouseProvider.userLocation;

  //       return Column(
  //         children: [
  //           // Location and date info header
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
  //             child: Column(
  //               children: [
  //                 Row(
  //                   children: [
  //                     Icon(
  //                       Icons.calendar_today,
  //                       size: 14,
  //                       color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
  //                     ),
  //                     const SizedBox(width: 6),
  //                     Text(
  //                       DateFormat('EEEE, MMM dd, yyyy').format(selectedDate),
  //                       style: TextStyle(
  //                         color:
  //                             isDarkMode ? Colors.grey[300] : Colors.grey[700],
  //                         fontSize: 13,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 4),
  //                 if (userLocation != null)
  //                   Row(
  //                     children: [
  //                       Icon(
  //                         Icons.near_me,
  //                         size: 14,
  //                         color:
  //                             isDarkMode ? Colors.grey[400] : Colors.grey[600],
  //                       ),
  //                       const SizedBox(width: 6),
  //                       Text(
  //                         'Found ${farmhouses.length} farmhouse${farmhouses.length > 1 ? 's' : ''} nearby',
  //                         style: TextStyle(
  //                           color: isDarkMode
  //                               ? Colors.grey[400]
  //                               : Colors.grey[600],
  //                           fontSize: 12,
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //               ],
  //             ),
  //           ),

  //           // Farmhouse cards
  //           ...List.generate(farmhouses.length, (index) {
  //             final farmhouse = farmhouses[index];
  //             final images = farmhouse.images;
  //             final currentImageIndex = currentImageIndexMap[index] ?? 0;
  //             final isInWishlist = wishlistProvider.isWishlisted(farmhouse.id);

  //             return Padding(
  //               padding:
  //                   const EdgeInsets.only(left: 24, right: 24, bottom: 16),
  //               child: Container(
  //                 height: 420,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(32),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: isDarkMode
  //                           ? Colors.black.withOpacity(0.3)
  //                           : Colors.black.withOpacity(0.1),
  //                       blurRadius: 20,
  //                       offset: const Offset(0, 10),
  //                     ),
  //                   ],
  //                 ),
  //                 child: Stack(
  //                   children: [
  //                     // Carousel with Network Images
  //                     GestureDetector(
  //                       onTap: () {
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                             builder: (context) => HouseDetailScreen(
  //                               farmhouse: farmhouse,
  //                               id: farmhouse.id,
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                       child: ClipRRect(
  //                         borderRadius: BorderRadius.circular(32),
  //                         child: CarouselSlider.builder(
  //                           itemCount: images.length,
  //                           options: CarouselOptions(
  //                             height: 420,
  //                             viewportFraction: 1.0,
  //                             enableInfiniteScroll: false,
  //                             onPageChanged: (imgIndex, reason) {
  //                               setState(() {
  //                                 currentImageIndexMap[index] = imgIndex;
  //                               });
  //                             },
  //                           ),
  //                           itemBuilder: (context, imageIndex, realIndex) {
  //                             return Stack(
  //                               children: [
  //                                 Container(
  //                                   decoration: BoxDecoration(
  //                                     gradient: LinearGradient(
  //                                       begin: Alignment.topCenter,
  //                                       end: Alignment.bottomCenter,
  //                                       colors: [
  //                                         Colors.grey[300]!,
  //                                         Colors.grey[100]!,
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   child: Image.network(
  //                                     images[imageIndex],
  //                                     width: double.infinity,
  //                                     height: double.infinity,
  //                                     fit: BoxFit.cover,
  //                                     loadingBuilder:
  //                                         (context, child, loadingProgress) {
  //                                       if (loadingProgress == null)
  //                                         return child;
  //                                       return Center(
  //                                         child: CircularProgressIndicator(
  //                                           value: loadingProgress
  //                                                       .expectedTotalBytes !=
  //                                                   null
  //                                               ? loadingProgress
  //                                                       .cumulativeBytesLoaded /
  //                                                   loadingProgress
  //                                                       .expectedTotalBytes!
  //                                               : null,
  //                                         ),
  //                                       );
  //                                     },
  //                                     errorBuilder:
  //                                         (context, error, stackTrace) {
  //                                       return Container(
  //                                         color: Colors.grey[300],
  //                                         child: const Center(
  //                                           child: Icon(
  //                                             Icons.home,
  //                                             size: 80,
  //                                             color: Colors.grey,
  //                                           ),
  //                                         ),
  //                                       );
  //                                     },
  //                                   ),
  //                                 ),
  //                                 Container(
  //                                   decoration: BoxDecoration(
  //                                     gradient: LinearGradient(
  //                                       begin: Alignment.topCenter,
  //                                       end: Alignment.bottomCenter,
  //                                       colors: [
  //                                         Colors.transparent,
  //                                         Colors.black.withOpacity(0.3),
  //                                         Colors.black.withOpacity(0.7),
  //                                       ],
  //                                       stops: const [0.3, 0.6, 1.0],
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             );
  //                           },
  //                         ),
  //                       ),
  //                     ),

  //                     // Top actions (wishlist & share)
  //                     Positioned(
  //                       top: 16,
  //                       left: 16,
  //                       right: 16,
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           GestureDetector(
  //                             onTap: () {
  //                               _handleWishlistToggle(
  //                                 context,
  //                                 farmhouse.id,
  //                                 farmhouse.name,
  //                                 isInWishlist,
  //                               );
  //                             },
  //                             child: Container(
  //                               padding: const EdgeInsets.all(10),
  //                               decoration: BoxDecoration(
  //                                 color: Colors.black.withOpacity(0.3),
  //                                 shape: BoxShape.circle,
  //                               ),
  //                               child: Icon(
  //                                 isInWishlist
  //                                     ? Icons.favorite
  //                                     : Icons.favorite_border,
  //                                 color:
  //                                     isInWishlist ? Colors.red : Colors.white,
  //                                 size: 24,
  //                               ),
  //                             ),
  //                           ),
  //                           GestureDetector(
  //                             onTap: () {
  //                               shareFarmhouseWithMultipleImages(
  //                                 context,
  //                                 farmhouse,
  //                               );
  //                             },
  //                             child: Container(
  //                               padding: const EdgeInsets.all(10),
  //                               decoration: BoxDecoration(
  //                                 color: Colors.black.withOpacity(0.3),
  //                                 shape: BoxShape.circle,
  //                               ),
  //                               child: const Icon(
  //                                 Icons.send,
  //                                 color: Colors.white,
  //                                 size: 24,
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),

  //                     // Bottom info
  //                     Positioned(
  //                       bottom: 0,
  //                       left: 0,
  //                       right: 0,
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(20),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Expanded(
  //                                   child: Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Row(
  //                                         children: [
  //                                           Flexible(
  //                                             child: Text(
  //                                               farmhouse.name,
  //                                               style: const TextStyle(
  //                                                 color: Colors.white,
  //                                                 fontSize: 22,
  //                                                 fontWeight: FontWeight.bold,
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           const SizedBox(width: 8),
  //                                           Container(
  //                                             padding:
  //                                                 const EdgeInsets.symmetric(
  //                                               horizontal: 8,
  //                                               vertical: 4,
  //                                             ),
  //                                             decoration: BoxDecoration(
  //                                               color: Colors.white
  //                                                   .withOpacity(0.2),
  //                                               borderRadius:
  //                                                   BorderRadius.circular(6),
  //                                             ),
  //                                             child: Row(
  //                                               children: [
  //                                                 const Icon(
  //                                                   Icons.star,
  //                                                   color: Colors.amber,
  //                                                   size: 12,
  //                                                 ),
  //                                                 const SizedBox(width: 2),
  //                                                 Text(
  //                                                   farmhouse.rating.toString(),
  //                                                   style: const TextStyle(
  //                                                     color: Colors.white,
  //                                                     fontSize: 11,
  //                                                     fontWeight:
  //                                                         FontWeight.w600,
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       const SizedBox(height: 6),
  //                                       Text(
  //                                         farmhouse.address,
  //                                         style: TextStyle(
  //                                           color:
  //                                               Colors.white.withOpacity(0.9),
  //                                           fontSize: 13,
  //                                           fontWeight: FontWeight.w500,
  //                                         ),
  //                                       ),
  //                                       const SizedBox(height: 4),
  //                                       Text(
  //                                         farmhouse.description,
  //                                         style: TextStyle(
  //                                           color:
  //                                               Colors.white.withOpacity(0.7),
  //                                           fontSize: 12,
  //                                         ),
  //                                         maxLines: 1,
  //                                         overflow: TextOverflow.ellipsis,
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 const SizedBox(width: 12),
  //                                 Column(
  //                                   crossAxisAlignment: CrossAxisAlignment.end,
  //                                   children: [
  //                                     Text(
  //                                       '₹${farmhouse.pricePerDay.toInt()}',
  //                                       style: const TextStyle(
  //                                         color: Colors.white,
  //                                         fontSize: 20,
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                     Text(
  //                                       'per day',
  //                                       style: TextStyle(
  //                                         color: Colors.white.withOpacity(0.7),
  //                                         fontSize: 10,
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                             const SizedBox(height: 12),
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: List.generate(
  //                                 images.length,
  //                                 (dotIndex) => Container(
  //                                   margin: const EdgeInsets.symmetric(
  //                                     horizontal: 3,
  //                                   ),
  //                                   width: 6,
  //                                   height: 6,
  //                                   decoration: BoxDecoration(
  //                                     color: dotIndex == currentImageIndex
  //                                         ? Colors.white
  //                                         : Colors.white.withOpacity(0.4),
  //                                     shape: BoxShape.circle,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           }),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _buildSkeletonCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 480,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            children: [
              // Image skeleton
              Container(
                height: 480,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),

              // Bottom info skeleton
              Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 20, width: 150, color: Colors.white),
                    const SizedBox(height: 10),
                    Container(height: 14, width: 200, color: Colors.white),
                    const SizedBox(height: 10),
                    Container(height: 14, width: 100, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyCardsList() {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Consumer3<FarmhouseProvider, LocationProvider, WishlistProvider>(
      builder: (context, farmhouseProvider, locationProvider, wishlistProvider, child) {

          if (locationProvider.isLoading) {
        return _buildLocationLoadingAnimation();
      }
        // Show location prompt if no location set
        if (locationProvider.address == null ||
            locationProvider.address!.trim().isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  // Icon(
                  //   Icons.location_off_outlined,
                  //   size: 64,
                  //   color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                  // ),
                  // const SizedBox(height: 16),
                  // Text(
                  //   'Set your location to find nearby farmhouses',
                  //   style: TextStyle(
                  //     color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  //     fontSize: 16,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  const SizedBox(height: 16),
                  // ElevatedButton.icon(
                  //   onPressed: () async {
                  //     final authProvider = Provider.of<AuthProvider>(
                  //       context,
                  //       listen: false,
                  //     );
                  //     final user = authProvider.user;
                  //     if (user != null) {
                  //       final result = await Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) =>
                  //               LocationScreen(userId: user.id.toString()),
                  //         ),
                  //       );
                  //       if (result == true) {
                  //         await _fetchNearbyFarmhouses();
                  //       }
                  //     }
                  //   },
                  //   // icon: const Icon(Icons.location_on),
                  //   label: const Text(''),
                  //   // style: ElevatedButton.styleFrom(
                  //   //   backgroundColor: const Color.fromARGB(255, 244, 244, 245),
                  //   //   foregroundColor: Colors.white,
                  //   //   // padding: const EdgeInsets.symmetric(
                  //   //   //   horizontal: 24,
                  //   //   //   vertical: 12,
                  //   //   // ),
                  //   // ),
                  // ),
                ],
              ),
            ),
          );
        }

        // Show loading indicator
        if (farmhouseProvider.isLoading) {
          return Column(
            children: List.generate(
              3, // number of skeleton cards
              (index) => _buildSkeletonCard(),
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
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    farmhouseProvider.errorMessage ??
                        'Failed to load farmhouses',
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
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
                  Icon(
                    Icons.home_outlined,
                    size: 64,
                    color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No farmhouses available',
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'for ${DateFormat('MMM dd, yyyy').format(selectedDate)}',
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  if (locationProvider.address != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Near ${locationProvider.address!.split(',').first}',
                        style: TextStyle(
                          color: isDarkMode
                              ? Colors.grey[500]
                              : Colors.grey[500],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            selectedDate = DateTime.now();
                          });
                          _fetchNearbyFarmhouses();
                        },
                        icon: const Icon(Icons.today),
                        label: const Text('Try Today'),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF6366F1),
                        ),
                      ),
                      const SizedBox(width: 8),
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
                ],
              ),
            ),
          );
        }

        // Show farmhouse list
        final farmhouses = farmhouseProvider.farmhouses;

        return Column(
          children: [
            // Farmhouse cards
            ...List.generate(farmhouses.length, (index) {
              final farmhouse = farmhouses[index];
              final images = farmhouse.images;
              final currentImageIndex = currentImageIndexMap[index] ?? 0;
              final isInWishlist = wishlistProvider.isWishlisted(farmhouse.id);

              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                child: GestureDetector(
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
                  child: Container(
                    height: 480,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Image Carousel
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: CarouselSlider.builder(
                            itemCount: images.length,
                            options: CarouselOptions(
                              height: 480,
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
                                  // Image
                                  Image.network(
                                    images[imageIndex],
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        color: Colors.grey[300],
                                        child: Center(
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
                                            color: const Color(0xFF6366F1),
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
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
                                  // Dark gradient overlay
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.3),
                                          Colors.black.withOpacity(0.8),
                                        ],
                                        stops: const [0.4, 0.7, 1.0],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        // Top Right Actions (Wishlist & Share)
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Row(
                            children: [
                              // Wishlist Button
                              GestureDetector(
                                onTap: () {
                                  _handleWishlistToggle(
                                    context,
                                    farmhouse.id,
                                    farmhouse.name,
                                    isInWishlist,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.25),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black, // light black
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    isInWishlist
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isInWishlist
                                        ? Colors.red
                                        : Colors.white,
                                    size: 22,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Share Button
                              GestureDetector(
                                onTap: () {
                                  shareFarmhouseWithMultipleImages(
                                    context,
                                    farmhouse,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black, // light black
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    color: Colors.white.withOpacity(0.25),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Transform.rotate(
                                    angle: -0.5, // radians (negative = tilt up)
                                    child: Icon(Icons.send, color: Colors.blue),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Bottom Info Card
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Property Name & BHK
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${farmhouse.name}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.3,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Location & Distance
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white70,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      '${farmhouse.address.split(',').first}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              const SizedBox(height: 12),

                              // Image Indicators
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  images.length > 5 ? 5 : images.length,
                                  (dotIndex) => Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 3,
                                    ),
                                    width: currentImageIndex == dotIndex
                                        ? 8
                                        : 6,
                                    height: currentImageIndex == dotIndex
                                        ? 8
                                        : 6,
                                    decoration: BoxDecoration(
                                      color: currentImageIndex == dotIndex
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

                        // Price Tag (Top Right Corner of Info)
                        // Positioned(
                        //   bottom: 16,
                        //   right: 16,
                        //   child: Container(
                        //     padding: const EdgeInsets.symmetric(
                        //       horizontal: 12,
                        //       vertical: 8,
                        //     ),
                        //     decoration: BoxDecoration(
                        //       color: Colors.white.withOpacity(0.15),
                        //       borderRadius: BorderRadius.circular(12),
                        //       border: Border.all(
                        //         color: Colors.white.withOpacity(0.3),
                        //         width: 1,
                        //       ),
                        //     ),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.end,
                        //       mainAxisSize: MainAxisSize.min,
                        //       children: [
                        //         Text(
                        //           '₹ ${farmhouse.pricePerDay.toInt()}',
                        //           style: const TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 18,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
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
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    // Always start from today and show next 7 days
    final dateList = List.generate(
      8,
      (index) => DateTime.now().add(Duration(days: index)),
    );

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
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
                  return GestureDetector(
                    onTap: _showDatePicker,
                    child: Container(
                      width: 50,
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDarkMode
                              ? Colors.grey[700]!
                              : Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.calendar_today_outlined,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        size: 20,
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
                    // Fetch farmhouses for the selected date
                    _fetchNearbyFarmhouses();
                  },
                  child: Container(
                    width: 50,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? (isDarkMode ? Colors.white : Colors.black)
                            : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getDayName(
                            date,
                          ).substring(0, 3), // First 3 letters only
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.grey[400]
                                : Colors.grey[600],
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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


  Widget _buildLocationLoadingAnimation() {
  final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated location icon with pulse effect
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 1500),
            // repeat: true,
            builder: (context, value, child) {
              return Transform.scale(
                scale: 1.0 + (value * 0.2),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF6366F1).withOpacity(0.1),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6366F1).withOpacity(0.3 * value),
                        blurRadius: 30 * value,
                        spreadRadius: 10 * value,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.my_location,
                    size: 48,
                    color: const Color(0xFF6366F1),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          
          // Animated dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 600),
                // repeat: true,
                builder: (context, value, child) {
                  final delay = index * 0.2;
                  final animValue = (value + delay) % 1.0;
                  
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF6366F1).withOpacity(
                        0.3 + (0.7 * (1 - animValue)),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 24),
          
          // Text
          Text(
            'Detecting your location',
            style: TextStyle(
              color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Finding nearby farmhouses for you...',
            style: TextStyle(
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
}
