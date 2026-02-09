// import 'dart:io';
// import 'dart:convert';
// import 'package:farmhouse_app/provider/booking/booking_provider.dart';
// import 'package:farmhouse_app/views/models/farmhouse_model.dart';
// import 'package:farmhouse_app/views/payment/payment_screen.dart';
// import 'package:farmhouse_app/widgets/like_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';

// class HouseDetailScreen extends StatefulWidget {
//   final Farmhouse? farmhouse;
//   final String? id;
//   const HouseDetailScreen({super.key, this.farmhouse, this.id});

//   @override
//   State<HouseDetailScreen> createState() => _HouseDetailScreenState();
// }

// class _HouseDetailScreenState extends State<HouseDetailScreen> {
//   int selectedImageIndex = 0;
//   String selectedPricing = 'hour';
//   int? selectedDateIndex;
//   String? selectedTimeSlot;
//   DateTime selectedDate = DateTime.now();

//   List<dynamic> availableSlots = [];
//   bool loadingSlots = false;

//   bool isLoading = true;
//   Farmhouse? farmhouseData;
//   String? errorMessage;

//   late final WishlistManager wishlistManager = WishlistManager();
//   late final List<DateTime> availableDates = getNextSevenDays();

//   @override
//   void initState() {
//     super.initState();
//     wishlistManager.addListener(_onWishlistChanged);
//     _loadFarmhouseData();
//   }

//   @override
//   void dispose() {
//     wishlistManager.removeListener(_onWishlistChanged);
//     super.dispose();
//   }

//   void _onWishlistChanged() {
//     setState(() {});
//   }


  

//   Future<void> _handleBooking() async {
//     if (selectedDateIndex == null || selectedTimeSlot == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.red,
//           content: Text('Please select date and time slot'),
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//       return;
//     }

//     // Get the selected slot details
//     final selectedSlot = availableSlots.firstWhere(
//       (slot) => slot['label'] == selectedTimeSlot,
//     );

//     final slotId = selectedSlot['slotId']; // or slot['id']
// final farmhouseId = farmhouseData!.id;

//     final bookingProvider = Provider.of<BookingProvider>(
//       context,
//       listen: false,
//     );

//     final selectedDate = availableDates[selectedDateIndex!];
//     final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

//     final success = await bookingProvider.bookFarmhouse(
//       farmhouseId: farmhouseData!.id,
//       date: formattedDate,
//       label: selectedSlot['label'],
//       timing: selectedSlot['timing'],
//     );

//     if (success && mounted) {
//         final booking = bookingProvider.bookingResponse!;

//         print("llllllllllllllllllllllllllllllllllll$slotId");
//                 print("llllllllllllllllllllllllllllllllllll$farmhouseId");


//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => PaymentScreen(
//         images: farmhouseData!.images,
//         name: farmhouseData!.name,
//         address: farmhouseData!.address,
//         slotPrice: booking['priceBreakdown']['slotPrice'],
//         cleaningFee: booking['priceBreakdown']['cleaningFee'],
//         serviceFee: booking['priceBreakdown']['serviceFee'],
//         totalAmount: booking['priceBreakdown']['totalAmount'],
//               slotId: slotId,
//       farmhouseId: farmhouseId,
//       ),
//     ),
//   );
//     } 
//     else if (mounted) {
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.red,
//           content: Text(
//             bookingProvider.errorMessage ?? 'Booking failed. Please try again.',
//           ),
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//     }
//   }

//   Future<void> _loadFarmhouseData() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });

//     try {
//       if (widget.farmhouse != null) {
//         // Use provided farmhouse data
//         setState(() {
//           farmhouseData = widget.farmhouse;
//           isLoading = false;
//         });
//       } else if (widget.id != null) {
//         // Fetch from API
//         final response = await http.get(
//           Uri.parse('http://31.97.206.144:5124/api/get/${widget.id}'),
//         );

//         if (response.statusCode == 200) {
//           final data = json.decode(response.body);
//           if (data['success'] == true) {
//             setState(() {
//               farmhouseData = Farmhouse.fromJson(data['farmhouse']);
//               isLoading = false;
//             });
//           } else {
//             throw Exception('Failed to load farmhouse data');
//           }
//         } else {
//           throw Exception('Server error: ${response.statusCode}');
//         }
//       } else {
//         throw Exception('No farmhouse data or ID provided');
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Failed to load farmhouse: $e';
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> shareFarmhouse(BuildContext context, Farmhouse farmhouse) async {
//     try {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => const Center(
//           child: CircularProgressIndicator(color: Color(0xFF6366F1)),
//         ),
//       );

//       final String imageUrl = farmhouse.images.isNotEmpty
//           ? farmhouse.images[0]
//           : '';

//       File? imageFile;

//       if (imageUrl.isNotEmpty) {
//         try {
//           final response = await http.get(Uri.parse(imageUrl));

//           if (response.statusCode == 200) {
//             final tempDir = await getTemporaryDirectory();
//             final fileName = '${farmhouse.name.replaceAll(" ", "_")}.jpg';
//             imageFile = File('${tempDir.path}/$fileName');

//             await imageFile.writeAsBytes(response.bodyBytes);
//           }
//         } catch (e) {
//           print('Error downloading image: $e');
//         }
//       }

//       if (context.mounted) {
//         Navigator.of(context).pop();
//       }

//       final shareText =
//           '''
//   Check out this amazing farmhouse! 🏡

//   📍 ${farmhouse.name}
//   🌍 ${farmhouse.address}
//   ⭐ Rating: ${farmhouse.rating}/5.0
//   💰 ₹${farmhouse.pricePerDay.toInt()}/day | ₹${farmhouse.pricePerHour.toInt()}/hour

//   ✨ ${farmhouse.description}

//   🎯 Booking for: ${farmhouse.bookingFor}
//   🏠 Amenities: ${farmhouse.amenities.join(', ')}

//   Book now on Farmhouse App!
//   ''';

//       if (imageFile != null && await imageFile.exists()) {
//         await Share.shareXFiles(
//           [XFile(imageFile.path)],
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

//   Future<void> _fetchAvailableSlots(DateTime date) async {
//     setState(() {
//       loadingSlots = true;
//       selectedTimeSlot = null;
//     });

//     try {
//       final formattedDate = DateFormat('yyyy-MM-dd').format(date);
//       print('Fetching slots for date: $formattedDate'); // Debug log

//       final response = await http.get(
//         Uri.parse(
//           'http://31.97.206.144:5124/api/${farmhouseData!.id}/slots?date=$formattedDate',
//         ),
//         // Uri.parse(
//         //   'http://31.97.206.144:5124/api/69538c96f988a6c0c99df2af/slots?date=2026-01-04',
//         // ),
//       );
//       print('formatted dateeeeeeeeeeeeeee $formattedDate');
//       print('Response status code: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['success'] == true) {
//           setState(() {
//             availableSlots = data['slots'] ?? [];
//             loadingSlots = false;
//           });

//           // Show message if no slots available
//           if (availableSlots.isEmpty && mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(
//                   'No slots available for ${DateFormat('MMM d, yyyy').format(date)}',
//                 ),
//                 backgroundColor: Colors.orange,
//                 behavior: SnackBarBehavior.floating,
//                 duration: const Duration(seconds: 2),
//               ),
//             );
//           }
//         } else {
//           throw Exception('Failed to load slots');
//         }
//       } else {
//         throw Exception('Server error: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching slots: $e'); // Debug log
//       setState(() {
//         loadingSlots = false;
//         availableSlots = [];
//       });
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to load time slots: $e'),
//             backgroundColor: Colors.red,
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       }
//     }
//   }

//   // Future<void> _fetchAvailableSlots(DateTime date) async {
//   //   if (farmhouseData == null || farmhouseData!.id.isEmpty) {
//   //     print('Farmhouse data not ready yet');
//   //     return;
//   //   }

//   //   setState(() {
//   //     loadingSlots = true;
//   //     selectedTimeSlot = null;
//   //   });

//   //   final formattedDate = DateFormat('yyyy-MM-dd').format(date);

//   //   final url =
//   //       'http://31.97.206.144:5124/api/${farmhouseData!.id}/slots?date=$formattedDate';

//   //   print('Fetching slots URL: $url');

//   //   try {
//   //     final response = await http.get(Uri.parse(url));

//   //     print('Response status code for slots ${response.statusCode}');
//   //     print('Response boddyyyyyyy for slots ${response.body}');

//   //     if (response.statusCode == 200) {
//   //       final data = json.decode(response.body);

//   //       if (data['success'] == true) {
//   //         setState(() {
//   //           availableSlots = List.from(data['slots'] ?? []);
//   //           loadingSlots = false;
//   //         });
//   //       } else {
//   //         throw Exception('API returned success=false');
//   //       }
//   //     } else {
//   //       throw Exception('Server error ${response.statusCode}');
//   //     }
//   //   } catch (e) {
//   //     loadingSlots = false;
//   //     availableSlots = [];
//   //     setState(() {});
//   //     debugPrint('Slot fetch error: $e');
//   //   }
//   // }

//   List<DateTime> getNextSevenDays() {
//     final today = DateTime.now();
//     return List.generate(7, (index) => today.add(Duration(days: index)));
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

//   void _toggleWishlist() {
//     if (farmhouseData == null) return;

//     final houseData = {
//       'name': farmhouseData!.name,
//       'location': farmhouseData!.address,
//       'price': '₹${farmhouseData!.pricePerHour}',
//       'rating': farmhouseData!.rating,
//       'image': farmhouseData!.images.isNotEmpty ? farmhouseData!.images[0] : '',
//     };

//     final bool wasInWishlist = wishlistManager.isInWishlist(
//       houseData['name'].toString(),
//     );

//     wishlistManager.toggleWishlist(houseData);

//     if (wasInWishlist) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Row(
//             children: [
//               const Icon(Icons.favorite_border, color: Colors.white),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Text(
//                   '${houseData['name']} removed from wishlist',
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 2,
//                 ),
//               ),
//             ],
//           ),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Row(
//             children: [
//               const Icon(Icons.favorite, color: Colors.white),
//               const SizedBox(width: 8),
//               Text('${houseData['name']} added to wishlist'),
//             ],
//           ),
//           backgroundColor: Colors.green,
//           behavior: SnackBarBehavior.floating,
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('farmhouseeeeeeeeeeeeeeeeeee idddddddddddddddddd ${widget.id}');
//     if (isLoading) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         body: const Center(
//           child: CircularProgressIndicator(color: Color(0xFF6366F1)),
//         ),
//       );
//     }

//     if (errorMessage != null || farmhouseData == null) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.error_outline, size: 64, color: Colors.red),
//               const SizedBox(height: 16),
//               Text(
//                 errorMessage ?? 'Failed to load farmhouse',
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 16),
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _loadFarmhouseData,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF6366F1),
//                   foregroundColor: Colors.white,
//                 ),
//                 child: const Text('Retry'),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     final availableDates = getNextSevenDays();
//     final bool isInWishlist = wishlistManager.isInWishlist(farmhouseData!.name);

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
//                         icon: Icon(
//                           isInWishlist ? Icons.favorite : Icons.favorite_border,
//                           color: isInWishlist ? Colors.red : Colors.black,
//                         ),
//                         onPressed: _toggleWishlist,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: IconButton(
//                         icon: const Icon(Icons.share, color: Colors.black),
//                         onPressed: () {
//                           shareFarmhouse(context, farmhouseData!);
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       Image.network(
//                         farmhouseData!.images.isNotEmpty
//                             ? farmhouseData!.images[selectedImageIndex]
//                             : 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             color: Colors.grey[300],
//                             child: const Icon(Icons.home, size: 64),
//                           );
//                         },
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
//                             '${selectedImageIndex + 1}/${farmhouseData!.images.length}',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                       if (farmhouseData!.images.length > 1)
//                         Positioned(
//                           bottom: 20,
//                           left: 0,
//                           right: 0,
//                           child: SizedBox(
//                             height: 80,
//                             child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 20,
//                               ),
//                               itemCount: farmhouseData!.images.length,
//                               itemBuilder: (context, index) {
//                                 return GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       selectedImageIndex = index;
//                                     });
//                                   },
//                                   child: Container(
//                                     width: 80,
//                                     margin: const EdgeInsets.only(right: 10),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(12),
//                                       border: Border.all(
//                                         color: selectedImageIndex == index
//                                             ? Colors.white
//                                             : Colors.transparent,
//                                         width: 3,
//                                       ),
//                                     ),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: Image.network(
//                                         farmhouseData!.images[index],
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
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
//                           Expanded(
//                             child: Text(
//                               farmhouseData!.name,
//                               style: const TextStyle(
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           // Container(
//                           //   padding: const EdgeInsets.symmetric(
//                           //     horizontal: 12,
//                           //     vertical: 6,
//                           //   ),
//                           //   decoration: BoxDecoration(
//                           //     color: Colors.amber,
//                           //     borderRadius: BorderRadius.circular(20),
//                           //   ),
//                           //   child: Row(
//                           //     children: [
//                           //       const Icon(
//                           //         Icons.star,
//                           //         color: Colors.white,
//                           //         size: 18,
//                           //       ),
//                           //       const SizedBox(width: 4),
//                           //       Text(
//                           //         farmhouseData!.rating.toString(),
//                           //         style: const TextStyle(
//                           //           color: Colors.white,
//                           //           fontWeight: FontWeight.bold,
//                           //           fontSize: 16,
//                           //         ),
//                           //       ),
//                           //     ],
//                           //   ),
//                           // ),
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
//                           Expanded(
//                             child: Text(
//                               farmhouseData!.address,
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 24),

//                       // Pricing Toggle
//                       // Container(
//                       //   padding: const EdgeInsets.all(4),
//                       //   decoration: BoxDecoration(
//                       //     color: Colors.grey[100],
//                       //     borderRadius: BorderRadius.circular(12),
//                       //   ),
//                       //   child: Row(
//                       //     children: [
//                       //       Expanded(
//                       //         child: GestureDetector(
//                       //           onTap: () {
//                       //             setState(() {
//                       //               selectedPricing = 'hour';
//                       //             });
//                       //           },
//                       //           child: Container(
//                       //             padding: const EdgeInsets.symmetric(
//                       //               vertical: 12,
//                       //             ),
//                       //             decoration: BoxDecoration(
//                       //               color: selectedPricing == 'hour'
//                       //                   ? Colors.white
//                       //                   : Colors.transparent,
//                       //               borderRadius: BorderRadius.circular(10),
//                       //               boxShadow: selectedPricing == 'hour'
//                       //                   ? [
//                       //                       BoxShadow(
//                       //                         color: Colors.black.withOpacity(
//                       //                           0.1,
//                       //                         ),
//                       //                         blurRadius: 8,
//                       //                         offset: const Offset(0, 2),
//                       //                       ),
//                       //                     ]
//                       //                   : null,
//                       //             ),
//                       //             child: Column(
//                       //               children: [
//                       //                 Text(
//                       //                   '₹${farmhouseData!.pricePerHour.toInt()}',
//                       //                   style: TextStyle(
//                       //                     fontSize: 24,
//                       //                     fontWeight: FontWeight.bold,
//                       //                     color: selectedPricing == 'hour'
//                       //                         ? Colors.black
//                       //                         : Colors.grey,
//                       //                   ),
//                       //                 ),
//                       //                 Text(
//                       //                   'per hour',
//                       //                   style: TextStyle(
//                       //                     color: selectedPricing == 'hour'
//                       //                         ? Colors.grey[600]
//                       //                         : Colors.grey[400],
//                       //                   ),
//                       //                 ),
//                       //               ],
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //       // Expanded(
//                       //       //   child: GestureDetector(
//                       //       //     onTap: () {
//                       //       //       setState(() {
//                       //       //         selectedPricing = 'day';
//                       //       //       });
//                       //       //     },
//                       //       //     child: Container(
//                       //       //       padding: const EdgeInsets.symmetric(
//                       //       //         vertical: 12,
//                       //       //       ),
//                       //       //       decoration: BoxDecoration(
//                       //       //         color: selectedPricing == 'day'
//                       //       //             ? Colors.white
//                       //       //             : Colors.transparent,
//                       //       //         borderRadius: BorderRadius.circular(10),
//                       //       //         boxShadow: selectedPricing == 'day'
//                       //       //             ? [
//                       //       //                 BoxShadow(
//                       //       //                   color: Colors.black.withOpacity(
//                       //       //                     0.1,
//                       //       //                   ),
//                       //       //                   blurRadius: 8,
//                       //       //                   offset: const Offset(0, 2),
//                       //       //                 ),
//                       //       //               ]
//                       //       //             : null,
//                       //       //       ),
//                       //       //       child: Column(
//                       //       //         children: [
//                       //       //           Text(
//                       //       //             '₹${farmhouseData!.pricePerDay.toInt()}',
//                       //       //             style: TextStyle(
//                       //       //               fontSize: 24,
//                       //       //               fontWeight: FontWeight.bold,
//                       //       //               color: selectedPricing == 'day'
//                       //       //                   ? Colors.black
//                       //       //                   : Colors.grey,
//                       //       //             ),
//                       //       //           ),
//                       //       //           Text(
//                       //       //             'per day',
//                       //       //             style: TextStyle(
//                       //       //               color: selectedPricing == 'day'
//                       //       //                   ? Colors.grey[600]
//                       //       //                   : Colors.grey[400],
//                       //       //             ),
//                       //       //           ),
//                       //       //         ],
//                       //       //       ),
//                       //       //     ),
//                       //       //   ),
//                       //       // ),
//                       //     ],
//                       //   ),
//                       // ),
//                       // const SizedBox(height: 24),

//                       // Amenities
//                       if (farmhouseData!.amenities.isNotEmpty) ...[
//                         const Text(
//                           'Amenities',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Wrap(
//                           spacing: 8,
//                           runSpacing: 8,
//                           children: farmhouseData!.amenities.map((amenity) {
//                             return Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 8,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[100],
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Text(
//                                 amenity,
//                                 style: TextStyle(
//                                   color: Colors.grey[700],
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                         const SizedBox(height: 24),
//                       ],

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
//                         farmhouseData!.description,
//                         style: TextStyle(
//                           color: Colors.grey[700],
//                           fontSize: 15,
//                           height: 1.6,
//                         ),
//                       ),
//                       const SizedBox(height: 16),

//                       // Booking For
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.celebration,
//                             color: Colors.grey[600],
//                             size: 20,
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             'Perfect for: ${farmhouseData!.bookingFor}',
//                             style: TextStyle(
//                               color: Colors.grey[700],
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 32),

//                       // Available Dates Section
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Available Dates',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.calendar_month),
//                             onPressed: _showDatePicker,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),

//                       // Date Selector
//                       SizedBox(
//                         height: 80,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: availableDates.length,
//                           itemBuilder: (context, index) {
//                             final date = availableDates[index];
//                             final isSelected = selectedDateIndex == index;

//                             return GestureDetector(
//                               onTap: () {
//                                 print(
//                                   'selected dateeeeeeeeeeeeeeeeeeee $selectedDate',
//                                 );
//                                 setState(() {
//                                   selectedDateIndex = index;

//                                   // selectedDate=date;
//                                 });
//                                 _fetchAvailableSlots(date);
//                               },
//                               child: Container(
//                                 width: 70,
//                                 margin: const EdgeInsets.only(right: 12),
//                                 decoration: BoxDecoration(
//                                   color: isSelected
//                                       ? const Color(0xFF5B67F7)
//                                       : Colors.white,
//                                   borderRadius: BorderRadius.circular(16),
//                                   border: Border.all(
//                                     color: isSelected
//                                         ? const Color(0xFF5B67F7)
//                                         : Colors.grey[300]!,
//                                     width: 2,
//                                   ),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       DateFormat(
//                                         'EEE',
//                                       ).format(date).substring(0, 3),
//                                       style: TextStyle(
//                                         color: isSelected
//                                             ? Colors.white
//                                             : const Color(0xFF5B67F7),
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Text(
//                                       DateFormat('d').format(date),
//                                       style: TextStyle(
//                                         color: isSelected
//                                             ? Colors.white
//                                             : Colors.black,
//                                         fontSize: 24,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 32),

//                       // Choose Time Section
//                       // if (farmhouseData!.timePrices.isNotEmpty) ...[
//                       //   const Text(
//                       //     'Choose Time',
//                       //     style: TextStyle(
//                       //       fontSize: 20,
//                       //       fontWeight: FontWeight.bold,
//                       //     ),
//                       //   ),
//                       //   const SizedBox(height: 12),

//                       //   // GridView.builder(
//                       //   //   shrinkWrap: true,
//                       //   //   physics: const NeverScrollableScrollPhysics(),
//                       //   //   gridDelegate:
//                       //   //       const SliverGridDelegateWithFixedCrossAxisCount(
//                       //   //     crossAxisCount: 2,
//                       //   //     childAspectRatio: 1.60,
//                       //   //     crossAxisSpacing: 12,
//                       //   //     mainAxisSpacing: 12,
//                       //   //   ),
//                       //   //   itemCount: farmhouseData!.timePrices.length,
//                       //   //   itemBuilder: (context, index) {
//                       //   //     final slot = farmhouseData!.timePrices[index];
//                       //   //     final isSelected = selectedTimeSlot == slot.label;

//                       //   //     return GestureDetector(
//                       //   //       onTap: () {
//                       //   //         setState(() {
//                       //   //           selectedTimeSlot = slot.label;
//                       //   //         });
//                       //   //       },
//                       //   //       child: Container(
//                       //   //         padding: const EdgeInsets.all(12),
//                       //   //         decoration: BoxDecoration(
//                       //   //           color: Colors.white,
//                       //   //           borderRadius: BorderRadius.circular(16),
//                       //   //           border: Border.all(
//                       //   //             color: isSelected
//                       //   //                 ? const Color(0xFF5B67F7)
//                       //   //                 : Colors.grey[300]!,
//                       //   //             width: isSelected ? 2 : 1,
//                       //   //           ),
//                       //   //         ),
//                       //   //         child: Column(
//                       //   //           crossAxisAlignment: CrossAxisAlignment.start,
//                       //   //           children: [
//                       //   //             Row(
//                       //   //               mainAxisAlignment:
//                       //   //                   MainAxisAlignment.spaceBetween,
//                       //   //               children: [
//                       //   //                 Expanded(
//                       //   //                   child: Text(
//                       //   //                     slot.label,
//                       //   //                     overflow: TextOverflow.ellipsis,
//                       //   //                     style: TextStyle(
//                       //   //                       fontSize: 15,
//                       //   //                       fontWeight: FontWeight.bold,
//                       //   //                       color: isSelected
//                       //   //                           ? const Color(0xFF5B67F7)
//                       //   //                           : Colors.black,
//                       //   //                     ),
//                       //   //                   ),
//                       //   //                 ),
//                       //   //                 if (isSelected)
//                       //   //                   const Icon(
//                       //   //                     Icons.check_circle,
//                       //   //                     color: Color(0xFF5B67F7),
//                       //   //                     size: 18,
//                       //   //                   ),
//                       //   //               ],
//                       //   //             ),
//                       //   //             const SizedBox(height: 4),
//                       //   //             Text(
//                       //   //               slot.timing,
//                       //   //               overflow: TextOverflow.ellipsis,
//                       //   //               style: TextStyle(
//                       //   //                 fontSize: 12,
//                       //   //                 color: Colors.grey[600],
//                       //   //               ),
//                       //   //             ),
//                       //   //             const Spacer(),
//                       //   //             Text(
//                       //   //               '₹${slot.price.toInt()}',
//                       //   //               style: const TextStyle(
//                       //   //                 fontSize: 15,
//                       //   //                 fontWeight: FontWeight.bold,
//                       //   //                 color: Colors.black,
//                       //   //               ),
//                       //   //             ),
//                       //   //           ],
//                       //   //         ),
//                       //   //       ),
//                       //   //     );
//                       //   //   },
//                       //   // ),
//                       //   if (loadingSlots)
//                       //     const Center(
//                       //       child: Padding(
//                       //         padding: EdgeInsets.all(20.0),
//                       //         child: CircularProgressIndicator(
//                       //           color: Color(0xFF6366F1),
//                       //         ),
//                       //       ),
//                       //     )
//                       //   else if (availableSlots.isNotEmpty) ...[
//                       //     const Text(
//                       //       'Choose Time',
//                       //       style: TextStyle(
//                       //         fontSize: 20,
//                       //         fontWeight: FontWeight.bold,
//                       //       ),
//                       //     ),
//                       //     const SizedBox(height: 12),
//                       //     GridView.builder(
//                       //       shrinkWrap: true,
//                       //       physics: const NeverScrollableScrollPhysics(),
//                       //       gridDelegate:
//                       //           const SliverGridDelegateWithFixedCrossAxisCount(
//                       //             crossAxisCount: 2,
//                       //             childAspectRatio: 1.60,
//                       //             crossAxisSpacing: 12,
//                       //             mainAxisSpacing: 12,
//                       //           ),
//                       //       itemCount: availableSlots.length,
//                       //       itemBuilder: (context, index) {
//                       //         final slot = availableSlots[index];
//                       //         final isSelected =
//                       //             selectedTimeSlot == slot['label'];
//                       //         final isAvailable = slot['available'] ?? true;

//                       //         return GestureDetector(
//                       //           onTap: isAvailable
//                       //               ? () {
//                       //                   setState(() {
//                       //                     selectedTimeSlot = slot['label'];
//                       //                   });
//                       //                 }
//                       //               : null,
//                       //           child: Container(
//                       //             padding: const EdgeInsets.all(12),
//                       //             decoration: BoxDecoration(
//                       //               color: isAvailable
//                       //                   ? Colors.white
//                       //                   : Colors.grey[200],
//                       //               borderRadius: BorderRadius.circular(16),
//                       //               border: Border.all(
//                       //                 color: isSelected
//                       //                     ? const Color(0xFF5B67F7)
//                       //                     : isAvailable
//                       //                     ? Colors.grey[300]!
//                       //                     : Colors.grey[400]!,
//                       //                 width: isSelected ? 2 : 1,
//                       //               ),
//                       //             ),
//                       //             child: Column(
//                       //               crossAxisAlignment:
//                       //                   CrossAxisAlignment.start,
//                       //               children: [
//                       //                 Row(
//                       //                   mainAxisAlignment:
//                       //                       MainAxisAlignment.spaceBetween,
//                       //                   children: [
//                       //                     Expanded(
//                       //                       child: Text(
//                       //                         slot['label'],
//                       //                         overflow: TextOverflow.ellipsis,
//                       //                         style: TextStyle(
//                       //                           fontSize: 15,
//                       //                           fontWeight: FontWeight.bold,
//                       //                           color: isAvailable
//                       //                               ? (isSelected
//                       //                                     ? const Color(
//                       //                                         0xFF5B67F7,
//                       //                                       )
//                       //                                     : Colors.black)
//                       //                               : Colors.grey[600],
//                       //                         ),
//                       //                       ),
//                       //                     ),
//                       //                     if (isSelected)
//                       //                       const Icon(
//                       //                         Icons.check_circle,
//                       //                         color: Color(0xFF5B67F7),
//                       //                         size: 18,
//                       //                       ),
//                       //                     if (!isAvailable)
//                       //                       Icon(
//                       //                         Icons.block,
//                       //                         color: Colors.grey[600],
//                       //                         size: 18,
//                       //                       ),
//                       //                   ],
//                       //                 ),
//                       //                 const SizedBox(height: 4),
//                       //                 Text(
//                       //                   slot['timing'],
//                       //                   overflow: TextOverflow.ellipsis,
//                       //                   style: TextStyle(
//                       //                     fontSize: 12,
//                       //                     color: isAvailable
//                       //                         ? Colors.grey[600]
//                       //                         : Colors.grey[500],
//                       //                   ),
//                       //                 ),
//                       //                 const Spacer(),
//                       //                 Text(
//                       //                   isAvailable
//                       //                       ? '₹${slot['price'].toInt()}'
//                       //                       : 'Not Available',
//                       //                   style: TextStyle(
//                       //                     fontSize: 15,
//                       //                     fontWeight: FontWeight.bold,
//                       //                     color: isAvailable
//                       //                         ? Colors.black
//                       //                         : Colors.grey[600],
//                       //                   ),
//                       //                 ),
//                       //               ],
//                       //             ),
//                       //           ),
//                       //         );
//                       //       },
//                       //     ),
//                       //     const SizedBox(height: 32),
//                       //   ] else if (selectedDateIndex != null)
//                       //     const Center(
//                       //       child: Padding(
//                       //         padding: EdgeInsets.all(20.0),
//                       //         child: Text(
//                       //           'No time slots available for this date',
//                       //           style: TextStyle(
//                       //             color: Colors.grey,
//                       //             fontSize: 16,
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ),
//                       //   const SizedBox(height: 32),
//                       // ],
//                       const Text(
//                         'Choose Time',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 12),

//                       if (loadingSlots)
//                         const Center(
//                           child: Padding(
//                             padding: EdgeInsets.all(20.0),
//                             child: CircularProgressIndicator(
//                               color: Color(0xFF6366F1),
//                             ),
//                           ),
//                         )
//                       else if (availableSlots.isNotEmpty)
//                         GridView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 childAspectRatio: 1.6,
//                                 crossAxisSpacing: 12,
//                                 mainAxisSpacing: 12,
//                               ),
//                           itemCount: availableSlots.length,
//                           itemBuilder: (context, index) {
//                             final slot = availableSlots[index];
//                             final isSelected =
//                                 selectedTimeSlot == slot['label'];
//                             final isAvailable = slot['available'] == true;

//                             return GestureDetector(
//                               onTap: isAvailable
//                                   ? () {
//                                       setState(() {
//                                         selectedTimeSlot = slot['label'];
//                                       });
//                                     }
//                                   : null,
//                               child: Container(
//                                 padding: const EdgeInsets.all(12),
//                                 decoration: BoxDecoration(
//                                   color: isAvailable
//                                       ? Colors.white
//                                       : Colors.grey[200],
//                                   borderRadius: BorderRadius.circular(16),
//                                   border: Border.all(
//                                     color: isSelected
//                                         ? const Color(0xFF5B67F7)
//                                         : Colors.grey[300]!,
//                                     width: isSelected ? 2 : 1,
//                                   ),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       slot['label'],
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: isSelected
//                                             ? const Color(0xFF5B67F7)
//                                             : Colors.black,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 6),
//                                     Text(
//                                       slot['timing'],
//                                       style: TextStyle(color: Colors.grey[600]),
//                                     ),
//                                     const Spacer(),
//                                     Text(
//                                       '₹${slot['price']}',
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         )
//                       else if (selectedDateIndex != null)
//                         const Padding(
//                           padding: EdgeInsets.all(20),
//                           child: Text(
//                             'No time slots available for this date',
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         ),

//                       // Booking Summary
//                       // if (selectedDateIndex != null && selectedTimeSlot != null)
//                       //   Container(
//                       //     padding: const EdgeInsets.all(20),
//                       //     decoration: BoxDecoration(
//                       //       color: Colors.grey[50],
//                       //       borderRadius: BorderRadius.circular(16),
//                       //       border: Border.all(color: Colors.grey[200]!),
//                       //     ),
//                       //     child: Row(
//                       //       children: [
//                       //         Expanded(
//                       //           child: Column(
//                       //             crossAxisAlignment: CrossAxisAlignment.start,
//                       //             children: [
//                       //               Text(
//                       //                 'Check In :',
//                       //                 style: TextStyle(
//                       //                   color: Colors.grey[600],
//                       //                   fontSize: 14,
//                       //                 ),
//                       //               ),
//                       //               const SizedBox(height: 4),
//                       //               Text(
//                       //                 DateFormat('d MMM, hh:mma').format(
//                       //                   availableDates[selectedDateIndex!],
//                       //                 ),
//                       //                 style: const TextStyle(
//                       //                   fontSize: 16,
//                       //                   fontWeight: FontWeight.bold,
//                       //                 ),
//                       //               ),
//                       //             ],
//                       //           ),
//                       //         ),
//                       //         Container(
//                       //           padding: const EdgeInsets.symmetric(
//                       //             horizontal: 16,
//                       //             vertical: 8,
//                       //           ),
//                       //           decoration: BoxDecoration(
//                       //             color: Colors.white,
//                       //             borderRadius: BorderRadius.circular(12),
//                       //           ),
//                       //           child: Column(
//                       //             children: [
//                       //               Text(
//                       //                 'Duration',
//                       //                 style: TextStyle(
//                       //                   color: Colors.grey[600],
//                       //                   fontSize: 12,
//                       //                 ),
//                       //               ),
//                       //               const SizedBox(height: 4),
//                       //               Text(
//                       //                 selectedTimeSlot ?? 'N/A',
//                       //                 style: const TextStyle(
//                       //                   fontSize: 14,
//                       //                   fontWeight: FontWeight.bold,
//                       //                 ),
//                       //               ),
//                       //             ],
//                       //           ),
//                       //         ),
//                       //         const SizedBox(width: 12),
//                       //         Expanded(
//                       //           child: Column(
//                       //             crossAxisAlignment: CrossAxisAlignment.end,
//                       //             children: [
//                       //               Text(
//                       //                 'Check Out :',
//                       //                 style: TextStyle(
//                       //                   color: Colors.grey[600],
//                       //                   fontSize: 14,
//                       //                 ),
//                       //               ),
//                       //               const SizedBox(height: 4),
//                       //               Text(
//                       //                 DateFormat('d MMM, hh:mma').format(
//                       //                   availableDates[selectedDateIndex!].add(
//                       //                     const Duration(hours: 11),
//                       //                   ),
//                       //                 ),
//                       //                 style: const TextStyle(
//                       //                   fontSize: 16,
//                       //                   fontWeight: FontWeight.bold,
//                       //                 ),
//                       //               ),
//                       //             ],
//                       //           ),
//                       //         ),
//                       //       ],
//                       //     ),
//                       //   ),
//                       // const SizedBox(height: 32),

//                       // Reviews Section
//                       if (farmhouseData!.reviews.isNotEmpty) ...[
//                         const Text(
//                           'Reviews',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         ...farmhouseData!.reviews.map(
//                           (review) => _buildReviewCard(review),
//                         ),
//                       ],

//                       // Feedback Summary
//                       // if (farmhouseData!.feedbackSummary.isNotEmpty) ...[
//                       //   Container(
//                       //     margin: const EdgeInsets.only(top: 16),
//                       //     padding: const EdgeInsets.all(16),
//                       //     decoration: BoxDecoration(
//                       //       color: Colors.blue[50],
//                       //       borderRadius: BorderRadius.circular(12),
//                       //       border: Border.all(color: Colors.blue[100]!),
//                       //     ),
//                       //     child: Row(
//                       //       children: [
//                       //         Icon(Icons.info_outline, color: Colors.blue[700]),
//                       //         const SizedBox(width: 12),
//                       //         Expanded(
//                       //           child: Text(
//                       //             farmhouseData!.feedbackSummary,
//                       //             style: TextStyle(
//                       //               color: Colors.blue[900],
//                       //               fontSize: 14,
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ],
//                       //     ),
//                       //   ),
//                       // ],
//                       const SizedBox(height: 100),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           // Book Now Button (Fixed at bottom)
//           // Positioned(
//           //   left: 0,
//           //   right: 0,
//           //   bottom: 0,
//           //   child: Container(
//           //     padding: const EdgeInsets.all(20),
//           //     decoration: BoxDecoration(
//           //       color: Colors.white,
//           //       boxShadow: [
//           //         BoxShadow(
//           //           color: Colors.black.withOpacity(0.1),
//           //           blurRadius: 10,
//           //           offset: const Offset(0, -5),
//           //         ),
//           //       ],
//           //     ),
//           //     child: ElevatedButton(
//           //       onPressed: () {
//           //         if (selectedDateIndex == null || selectedTimeSlot == null) {
//           //           ScaffoldMessenger.of(context).showSnackBar(
//           //             const SnackBar(
//           //               backgroundColor: Colors.red,
//           //               content: Text('Please select date and time slot'),
//           //               behavior: SnackBarBehavior.floating,
//           //             ),
//           //           );
//           //           return;
//           //         }

//           //         Navigator.push(
//           //           context,
//           //           MaterialPageRoute(
//           //             builder: (context) => PaymentScreen(
//           //               image: farmhouseData!.images.isNotEmpty
//           //                   ? farmhouseData!.images[0]
//           //                   : '',
//           //               name: farmhouseData!.name,
//           //             ),
//           //           ),
//           //         );
//           //       },
//           //       style: ElevatedButton.styleFrom(
//           //         backgroundColor: Colors.black,
//           //         foregroundColor: Colors.white,
//           //         padding: const EdgeInsets.symmetric(vertical: 16),
//           //         shape: RoundedRectangleBorder(
//           //           borderRadius: BorderRadius.circular(12),
//           //         ),
//           //         elevation: 0,
//           //       ),
//           //       child: const Text(
//           //         'Book Now',
//           //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           //       ),
//           //     ),
//           //   ),
//           // ),
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
//               child: Consumer<BookingProvider>(
//                 builder: (context, bookingProvider, child) {
//                   return ElevatedButton(
//                     onPressed: bookingProvider.isLoading
//                         ? null
//                         : _handleBooking,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 0,
//                     ),
//                     child: bookingProvider.isLoading
//                         ? const SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2,
//                             ),
//                           )
//                         : const Text(
//                             'Book Now',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildReviewCard(review) {
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
//                   review.name.isNotEmpty
//                       ? review.name.substring(0, 1).toUpperCase()
//                       : 'U',
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
//                       review.name.isNotEmpty ? review.name : 'Anonymous',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     Text(
//                       review.date,
//                       style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 children: List.generate(
//                   5,
//                   (index) => Icon(
//                     index < review.rating ? Icons.star : Icons.star_border,
//                     color: Colors.amber,
//                     size: 18,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             review.comment,
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



















import 'dart:io';
import 'dart:convert';
import 'package:farmhouse_app/provider/booking/booking_provider.dart';
import 'package:farmhouse_app/views/models/farmhouse_model.dart';
import 'package:farmhouse_app/views/payment/payment_screen.dart';
import 'package:farmhouse_app/widgets/like_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HouseDetailScreen extends StatefulWidget {
  final Farmhouse? farmhouse;
  final String? id;
  const HouseDetailScreen({super.key, this.farmhouse, this.id});

  @override
  State<HouseDetailScreen> createState() => _HouseDetailScreenState();
}

class _HouseDetailScreenState extends State<HouseDetailScreen> {
  int selectedImageIndex = 0;
  String selectedPricing = 'hour';
  int? selectedDateIndex;
  String? selectedTimeSlot;
  DateTime selectedDate = DateTime.now();

  List<dynamic> availableSlots = [];
  bool loadingSlots = false;

  bool isLoading = true;
  Farmhouse? farmhouseData;
  String? errorMessage;

  late final WishlistManager wishlistManager = WishlistManager();
  late final List<DateTime> availableDates = getNextSevenDays();

  @override
  void initState() {
    super.initState();
    wishlistManager.addListener(_onWishlistChanged);
    _loadFarmhouseData();
  }

  @override
  void dispose() {
    wishlistManager.removeListener(_onWishlistChanged);
    super.dispose();
  }

  void _onWishlistChanged() {
    setState(() {});
  }

  Future<void> _handleBooking() async {
    if (selectedDateIndex == null || selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFFDC2626),
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Please select date and time slot',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    final selectedSlot = availableSlots.firstWhere(
      (slot) => slot['label'] == selectedTimeSlot,
    );

        final slotId = selectedSlot['slotId']; // or slot['id']
final farmhouseId = farmhouseData!.id;

    final bookingProvider = Provider.of<BookingProvider>(
      context,
      listen: false,
    );

    final selectedDate = availableDates[selectedDateIndex!];
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    final success = await bookingProvider.bookFarmhouse(
      farmhouseId: farmhouseData!.id,
      date: formattedDate,
      label: selectedSlot['label'],
      timing: selectedSlot['timing'],
    );

    if (success && mounted) {
      final booking = bookingProvider.bookingResponse!;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            images: farmhouseData!.images,
            name: farmhouseData!.name,
            address: farmhouseData!.address,
            slotPrice: booking['priceBreakdown']['slotPrice'],
            cleaningFee: booking['priceBreakdown']['cleaningFee'],
            serviceFee: booking['priceBreakdown']['serviceFee'],
            totalAmount: booking['priceBreakdown']['totalAmount'],
                          slotId: slotId,
      farmhouseId: farmhouseId,
          ),
        ),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFFDC2626),
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  bookingProvider.errorMessage ?? 'Booking failed. Please try again.',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  Future<void> _loadFarmhouseData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      if (widget.farmhouse != null) {
        setState(() {
          farmhouseData = widget.farmhouse;
          isLoading = false;
        });
      } else if (widget.id != null) {
        final response = await http.get(
          Uri.parse('http://31.97.206.144:5124/api/get/${widget.id}'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['success'] == true) {
            setState(() {
              farmhouseData = Farmhouse.fromJson(data['farmhouse']);
              isLoading = false;
            });
          } else {
            throw Exception('Failed to load farmhouse data');
          }
        } else {
          throw Exception('Server error: ${response.statusCode}');
        }
      } else {
        throw Exception('No farmhouse data or ID provided');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load farmhouse: $e';
        isLoading = false;
      });
    }
  }

  Future<void> shareFarmhouse(BuildContext context, Farmhouse farmhouse) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(color: Color(0xFF6366F1)),
        ),
      );

      final String imageUrl = farmhouse.images.isNotEmpty
          ? farmhouse.images[0]
          : '';

      File? imageFile;

      if (imageUrl.isNotEmpty) {
        try {
          final response = await http.get(Uri.parse(imageUrl));

          if (response.statusCode == 200) {
            final tempDir = await getTemporaryDirectory();
            final fileName = '${farmhouse.name.replaceAll(" ", "_")}.jpg';
            imageFile = File('${tempDir.path}/$fileName');

            await imageFile.writeAsBytes(response.bodyBytes);
          }
        } catch (e) {
          print('Error downloading image: $e');
        }
      }

      if (context.mounted) {
        Navigator.of(context).pop();
      }

      final shareText = '''
Check out this amazing farmhouse! 🏡

📍 ${farmhouse.name}
🌍 ${farmhouse.address}
⭐ Rating: ${farmhouse.rating}/5.0
💰 ₹${farmhouse.pricePerDay.toInt()}/day | ₹${farmhouse.pricePerHour.toInt()}/hour

✨ ${farmhouse.description}

🎯 Booking for: ${farmhouse.bookingFor}
🏠 Amenities: ${farmhouse.amenities.join(', ')}

Book now on Farmhouse App!
''';

      if (imageFile != null && await imageFile.exists()) {
        await Share.shareXFiles(
          [XFile(imageFile.path)],
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

  Future<void> _fetchAvailableSlots(DateTime date) async {
    setState(() {
      loadingSlots = true;
      selectedTimeSlot = null;
    });

    try {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      print('Fetching slots for date: $formattedDate');

      final response = await http.get(
        Uri.parse(
          'http://31.97.206.144:5124/api/${farmhouseData!.id}/slots?date=$formattedDate',
        ),
      );
      print('formatted date: $formattedDate');
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          setState(() {
            availableSlots = data['slots'] ?? [];
            loadingSlots = false;
          });

          if (availableSlots.isEmpty && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'No slots available for ${DateFormat('MMM d, yyyy').format(date)}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                backgroundColor: const Color(0xFFF59E0B),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.all(16),
              ),
            );
          }
        } else {
          throw Exception('Failed to load slots');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching slots: $e');
      setState(() {
        loadingSlots = false;
        availableSlots = [];
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Failed to load time slots: $e',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFDC2626),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    }
  }

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

  void _toggleWishlist() {
    if (farmhouseData == null) return;

    final houseData = {
      'name': farmhouseData!.name,
      'location': farmhouseData!.address,
      'price': '₹${farmhouseData!.pricePerHour}',
      'rating': farmhouseData!.rating,
      'image': farmhouseData!.images.isNotEmpty ? farmhouseData!.images[0] : '',
    };

    final bool wasInWishlist = wishlistManager.isInWishlist(
      houseData['name'].toString(),
    );

    wishlistManager.toggleWishlist(houseData);

    if (wasInWishlist) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.favorite_border, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${houseData['name']} removed from wishlist',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.favorite, color: Colors.white),
              const SizedBox(width: 12),
              Text(
                '${houseData['name']} added to wishlist',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('farmhouse id: ${widget.id}');
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF6366F1),
            strokeWidth: 3,
          ),
        ),
      );
    }

    if (errorMessage != null || farmhouseData == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Color(0xFFDC2626),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  errorMessage ?? 'Failed to load farmhouse',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF374151),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _loadFarmhouseData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Retry',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final availableDates = getNextSevenDays();
    final bool isInWishlist = wishlistManager.isInWishlist(farmhouseData!.name);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Enhanced Image Gallery Header
              SliverAppBar(
                expandedHeight: 420,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                actions: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       shape: BoxShape.circle,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black.withOpacity(0.1),
                  //           blurRadius: 8,
                  //           offset: const Offset(0, 2),
                  //         ),
                  //       ],
                  //     ),
                  //     child: IconButton(
                  //       icon: Icon(
                  //         isInWishlist ? Icons.favorite : Icons.favorite_border,
                  //         color: isInWishlist ? const Color(0xFFDC2626) : Colors.black,
                  //       ),
                  //       onPressed: _toggleWishlist,
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.share_outlined, color: Colors.black),
                        onPressed: () {
                          shareFarmhouse(context, farmhouseData!);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: 'farmhouse_${farmhouseData!.id}',
                        child: Image.network(
                          farmhouseData!.images.isNotEmpty
                              ? farmhouseData!.images[selectedImageIndex]
                              : 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFFE5E7EB),
                              child: const Icon(
                                Icons.home_outlined,
                                size: 80,
                                color: Color(0xFF9CA3AF),
                              ),
                            );
                          },
                        ),
                      ),
                      // Gradient overlay
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Image counter
                      Positioned(
                        bottom: 100,
                        right: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.image_outlined,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${selectedImageIndex + 1}/${farmhouseData!.images.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Image thumbnails
                      if (farmhouseData!.images.length > 1)
                        Positioned(
                          bottom: 20,
                          left: 0,
                          right: 0,
                          child: SizedBox(
                            height: 70,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: farmhouseData!.images.length,
                              itemBuilder: (context, index) {
                                final isSelected = selectedImageIndex == index;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedImageIndex = index;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: isSelected ? 80 : 70,
                                    margin: const EdgeInsets.only(right: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.4),
                                        width: isSelected ? 3 : 2,
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: Colors.white.withOpacity(0.3),
                                                blurRadius: 8,
                                                spreadRadius: 1,
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        farmhouseData!.images[index],
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
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Location
                        Text(
                          farmhouseData!.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.location_on,
                                size: 18,
                                color: Color(0xFF6366F1),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                farmhouseData!.address,
                                style: const TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Divider
                        Container(
                          height: 1,
                          color: const Color(0xFFE5E7EB),
                        ),
                        const SizedBox(height: 24),

                        // Amenities Section
                        if (farmhouseData!.amenities.isNotEmpty) ...[
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEEF2FF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.stars_rounded,
                                  size: 20,
                                  color: Color(0xFF6366F1),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Amenities',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF111827),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: farmhouseData!.amenities.map((amenity) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9FAFB),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFE5E7EB),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      size: 16,
                                      color: Color(0xFF10B981),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      amenity,
                                      style: const TextStyle(
                                        color: Color(0xFF374151),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Description Section
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF2FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.description_outlined,
                                size: 20,
                                color: Color(0xFF6366F1),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          farmhouseData!.description,
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 15,
                            height: 1.7,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Perfect For Badge
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFFDE047),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.celebration_rounded,
                                color: Color(0xFFCA8A04),
                                size: 22,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF92400E),
                                    ),
                                    children: [
                                      const TextSpan(text: 'Perfect for '),
                                      TextSpan(
                                        text: farmhouseData!.bookingFor,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Divider
                        Container(
                          height: 1,
                          color: const Color(0xFFE5E7EB),
                        ),
                        const SizedBox(height: 32),

                        // Available Dates Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEEF2FF),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.calendar_today_rounded,
                                    size: 20,
                                    color: Color(0xFF6366F1),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Available Dates',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF111827),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.calendar_month_rounded,
                                  color: Color(0xFF6366F1),
                                ),
                                onPressed: _showDatePicker,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Date Selector
                        SizedBox(
                          height: 90,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: availableDates.length,
                            itemBuilder: (context, index) {
                              final date = availableDates[index];
                              final isSelected = selectedDateIndex == index;
                              final isToday = index == 0;

                              return GestureDetector(
                                onTap: () {
                                  print('selected date: $selectedDate');
                                  setState(() {
                                    selectedDateIndex = index;
                                  });
                                  _fetchAvailableSlots(date);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 75,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    gradient: isSelected
                                        ? const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xFF6366F1),
                                              Color(0xFF8B5CF6),
                                            ],
                                          )
                                        : null,
                                    color: isSelected ? null : Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF6366F1)
                                          : const Color(0xFFE5E7EB),
                                      width: isSelected ? 2 : 1.5,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: const Color(0xFF6366F1).withOpacity(0.3),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            DateFormat('EEE').format(date).substring(0, 3),
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                  : const Color(0xFF6B7280),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            DateFormat('d').format(date),
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                  : const Color(0xFF111827),
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            DateFormat('MMM').format(date),
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white.withOpacity(0.9)
                                                  : const Color(0xFF9CA3AF),
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (isToday)
                                        Positioned(
                                          top: 6,
                                          right: 6,
                                          child: Container(
                                            width: 6,
                                            height: 6,
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? Colors.white
                                                  : const Color(0xFF10B981),
                                              shape: BoxShape.circle,
                                            ),
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

                        // Divider
                        Container(
                          height: 1,
                          color: const Color(0xFFE5E7EB),
                        ),
                        const SizedBox(height: 32),

                        // Time Slots Section
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF2FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.access_time_rounded,
                                size: 20,
                                color: Color(0xFF6366F1),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Choose Time Slot',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        if (loadingSlots)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                children: [
                                  const CircularProgressIndicator(
                                    color: Color(0xFF6366F1),
                                    strokeWidth: 3,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Loading available slots...',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else if (availableSlots.isNotEmpty)
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.5,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: availableSlots.length,
                            itemBuilder: (context, index) {
                              final slot = availableSlots[index];
                              final isSelected = selectedTimeSlot == slot['label'];
                              final isAvailable = slot['available'] == true;

                              return GestureDetector(
                                onTap: isAvailable
                                    ? () {
                                        setState(() {
                                          selectedTimeSlot = slot['label'];
                                        });
                                      }
                                    : null,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    gradient: isSelected
                                        ? const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xFF6366F1),
                                              Color(0xFF8B5CF6),
                                            ],
                                          )
                                        : null,
                                    color: isSelected
                                        ? null
                                        : (isAvailable
                                            ? Colors.white
                                            : const Color(0xFFF9FAFB)),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF6366F1)
                                          : (isAvailable
                                              ? const Color(0xFFE5E7EB)
                                              : const Color(0xFFD1D5DB)),
                                      width: isSelected ? 2 : 1.5,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: const Color(0xFF6366F1).withOpacity(0.25),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              slot['label'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: isSelected
                                                    ? Colors.white
                                                    : (isAvailable
                                                        ? const Color(0xFF111827)
                                                        : const Color(0xFF9CA3AF)),
                                              ),
                                            ),
                                          ),
                                          if (isSelected)
                                            Container(
                                              padding: const EdgeInsets.all(3),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.check,
                                                color: Color(0xFF6366F1),
                                                size: 14,
                                              ),
                                            )
                                          else if (!isAvailable)
                                            const Icon(
                                              Icons.block_rounded,
                                              color: Color(0xFF9CA3AF),
                                              size: 18,
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.schedule_rounded,
                                            size: 14,
                                            color: isSelected
                                                ? Colors.white.withOpacity(0.9)
                                                : const Color(0xFF9CA3AF),
                                          ),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              slot['timing'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: isSelected
                                                    ? Colors.white.withOpacity(0.9)
                                                    : const Color(0xFF6B7280),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.white.withOpacity(0.2)
                                              : (isAvailable
                                                  ? const Color(0xFFF3F4F6)
                                                  : const Color(0xFFE5E7EB)),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          isAvailable
                                              ? '₹${slot['price']}'
                                              : 'Not Available',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? Colors.white
                                                : (isAvailable
                                                    ? const Color(0xFF111827)
                                                    : const Color(0xFF9CA3AF)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        else if (selectedDateIndex != null)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3F4F6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.event_busy_rounded,
                                      size: 48,
                                      color: Color(0xFF9CA3AF),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'No time slots available',
                                    style: TextStyle(
                                      color: Color(0xFF6B7280),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Please select a different date',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEEF2FF),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.calendar_today_rounded,
                                      size: 48,
                                      color: Color(0xFF6366F1),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Select a date to view slots',
                                    style: TextStyle(
                                      color: Color(0xFF6B7280),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        const SizedBox(height: 32),

                        // Reviews Section
                        if (farmhouseData!.reviews.isNotEmpty) ...[
                          Container(
                            height: 1,
                            color: const Color(0xFFE5E7EB),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEEF2FF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.rate_review_rounded,
                                  size: 20,
                                  color: Color(0xFF6366F1),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Guest Reviews',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF111827),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ...farmhouseData!.reviews.map(
                            (review) => _buildReviewCard(review),
                          ),
                        ],

                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Enhanced Book Now Button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Consumer<BookingProvider>(
                  builder: (context, bookingProvider, child) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF111827),
                            Color(0xFF1F2937),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: bookingProvider.isLoading ? null : _handleBooking,
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: bookingProvider.isLoading
                                ? const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Processing...',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.calendar_month_rounded,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Book Now',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF6366F1),
                      Color(0xFF8B5CF6),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    review.name.isNotEmpty
                        ? review.name.substring(0, 1).toUpperCase()
                        : 'U',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name.isNotEmpty ? review.name : 'Anonymous',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review.date,
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFF59E0B),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      review.rating.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF92400E),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            review.comment,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 15,
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}