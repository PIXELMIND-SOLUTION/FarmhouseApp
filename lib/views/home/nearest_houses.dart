import 'package:farmhouse_app/views/payment/payment_screen.dart';
import 'package:farmhouse_app/widgets/like_widget.dart';
import 'package:flutter/material.dart';

class NearestHouses extends StatefulWidget {
   NearestHouses({super.key});

  @override
  State<NearestHouses> createState() => _NearestHousesState();
}

class _NearestHousesState extends State<NearestHouses> {

    final WishlistManager wishlistManager = WishlistManager();




//  void _toggleWishlist(FarmhouseData farmhouse) {
//   final farmhouseMap = {
//     'title': farmhouse.name,
//     'location': farmhouse.location,
//     'price': farmhouse.price,
//     'imageUrl': farmhouse.imageUrl,
//     'distance': farmhouse.distance,
//     'rating': farmhouse.rating,
//   }; 
  
//   setState(() {
//     wishlistManager.toggleWishlist(farmhouseMap);
//   });

//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       backgroundColor: wishlistManager.isInWishlist(farmhouse.name)
//           ? Colors.green
//           : Colors.orange,
//       content: Text(
//         wishlistManager.isInWishlist(farmhouse.name)
//             ? 'Added to wishlist'
//             : 'Removed from wishlist',
//       ),
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       duration: const Duration(seconds: 2),
//     ),
//   );
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D3142)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Nearest Farmhouses',
          style: TextStyle(
            color: Color(0xFF2D3142),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Color(0xFF2D3142)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search farmhouses...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF6C757D)),
                filled: true,
                fillColor: const Color(0xFFF8F9FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          
          // Filter Chips
          // Container(
          //   height: 50,
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: ListView(
          //     scrollDirection: Axis.horizontal,
          //     children: [
          //       _buildFilterChip('All', true),
          //       _buildFilterChip('< 5 km', false),
          //       _buildFilterChip('< 10 km', false),
          //       _buildFilterChip('Top Rated', false),
          //       _buildFilterChip('Budget', false),
          //     ],
          //   ),
          // ),
          
          // Farmhouse List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _farmhouses.length,
              itemBuilder: (context, index) {
                return _buildFarmhouseCard(_farmhouses[index],context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (value) {},
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFFFF5A5F),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF6C757D),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? const Color(0xFFFF5A5F) : const Color(0xFFE9ECEF),
          ),
        ),
      ),
    );
  }

  Widget _buildFarmhouseCard(FarmhouseData farmhouse,BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Favorite Button
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  farmhouse.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: const Color(0xFFE9ECEF),
                      child: const Icon(Icons.image, size: 50, color: Color(0xFF6C757D)),
                    );
                  },
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      farmhouse.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: farmhouse.isFavorite ? Colors.red : const Color(0xFF6C757D),
                    ),
                    onPressed: () {
                      // _toggleWishlist(farmhouse.name.t)
                    },
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5A5F),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${farmhouse.distance} km',
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
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        farmhouse.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Color(0xFFFFA726)),
                          const SizedBox(width: 4),
                          Text(
                            farmhouse.rating.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFF57C00),
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
                    const Icon(Icons.location_on, size: 16, color: Color(0xFF6C757D)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        farmhouse.location,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6C757D),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildAmenityIcon(Icons.king_bed, farmhouse.bedrooms),
                    const SizedBox(width: 16),
                    _buildAmenityIcon(Icons.bathtub, farmhouse.bathrooms),
                    const SizedBox(width: 16),
                    _buildAmenityIcon(Icons.square_foot, '${farmhouse.area} sqft'),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '₹${farmhouse.price}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFF5A5F),
                            ),
                          ),
                          const TextSpan(
                            text: '/night',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6C757D),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentScreen(image: farmhouse.imageUrl,price: farmhouse.price,name: farmhouse.name,)));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5A5F),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(fontWeight: FontWeight.w600),
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

  Widget _buildAmenityIcon(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF6C757D)),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF6C757D),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Sample Data
  final List<FarmhouseData> _farmhouses = [
    FarmhouseData(
      name: 'Green Valley Farmhouse',
      location: 'Shamirpet, Hyderabad',
      distance: 12.5,
      rating: 4.8,
      price: '8,500',
      bedrooms: '4',
      bathrooms: '3',
      area: '2500',
      imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
      isFavorite: true,
    ),
    FarmhouseData(
      name: 'Sunrise Retreat',
      location: 'Shankarpally, Hyderabad',
      distance: 18.3,
      rating: 4.6,
      price: '6,000',
      bedrooms: '3',
      bathrooms: '2',
      area: '2000',
      imageUrl: 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
      isFavorite: false,
    ),
    FarmhouseData(
      name: 'Meadow Haven',
      location: 'Chevella, Hyderabad',
      distance: 25.7,
      rating: 4.9,
      price: '12,000',
      bedrooms: '5',
      bathrooms: '4',
      area: '3500',
      imageUrl: 'https://images.unsplash.com/photo-1600566753376-12c8ab7fb75b?w=800',
      isFavorite: false,
    ),
    FarmhouseData(
      name: 'Tranquil Farms',
      location: 'Srisailam Highway, Hyderabad',
      distance: 8.2,
      rating: 4.7,
      price: '7,500',
      bedrooms: '3',
      bathrooms: '3',
      area: '2200',
      imageUrl: 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800',
      isFavorite: true,
    ),
  ];
}

class FarmhouseData {
  final String name;
  final String location;
  final double distance;
  final double rating;
  final String price;
  final String bedrooms;
  final String bathrooms;
  final String area;
  final String imageUrl;
  final bool isFavorite;

  FarmhouseData({
    required this.name,
    required this.location,
    required this.distance,
    required this.rating,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.imageUrl,
    required this.isFavorite,
  });
}