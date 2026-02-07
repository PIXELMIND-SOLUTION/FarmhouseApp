import 'package:farmhouse_app/views/details/house_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<FarmhouseModel> _allFarmhouses = [];
  List<FarmhouseModel> _filteredFarmhouses = [];
  bool _isLoading = false;
  bool _hasSearched = false;
  String? _errorMessage;

  // Filter variables
  RangeValues _priceRange = const RangeValues(0, 10000);
  double _minRating = 0.0;
  Set<String> _selectedAmenities = {};
  String _sortBy = 'none'; // none, price_low, price_high, rating

  final List<String> _allAmenities = ['pool', 'bbq', 'garden'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchFarmhouses(String query) async {
    // Don't search if query is empty
    if (query.trim().isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _hasSearched = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
          'http://31.97.206.144:5124/api/search?query=${Uri.encodeComponent(query)}',
        ),
      );


      print('Response status code for search api ${response.statusCode}');
            print('Response bodyyyyyyyyy code for search api ${response.body}');


      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _allFarmhouses = (data['farmhouses'] as List)
              .map((json) => FarmhouseModel.fromJson(json))
              .toList();
          _applyFilters();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load farmhouses';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    List<FarmhouseModel> filtered = List.from(_allFarmhouses);

    // Filter by price range
    filtered = filtered.where((farmhouse) {
      return farmhouse.pricePerDay >= _priceRange.start &&
          farmhouse.pricePerDay <= _priceRange.end;
    }).toList();

    // Filter by rating
    filtered = filtered.where((farmhouse) {
      return farmhouse.rating >= _minRating;
    }).toList();

    // Filter by amenities
    if (_selectedAmenities.isNotEmpty) {
      filtered = filtered.where((farmhouse) {
        return _selectedAmenities.every(
          (amenity) => farmhouse.amenities.contains(amenity),
        );
      }).toList();
    }

    // Sort
    if (_sortBy == 'price_low') {
      filtered.sort((a, b) => a.pricePerDay.compareTo(b.pricePerDay));
    } else if (_sortBy == 'price_high') {
      filtered.sort((a, b) => b.pricePerDay.compareTo(a.pricePerDay));
    } else if (_sortBy == 'rating') {
      filtered.sort((a, b) => b.rating.compareTo(a.rating));
    }

    setState(() {
      _filteredFarmhouses = filtered;
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            expand: false,
            builder: (context, scrollController) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filters',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setModalState(() {
                              _priceRange = const RangeValues(0, 10000);
                              _minRating = 0.0;
                              _selectedAmenities.clear();
                              _sortBy = 'none';
                            });
                            setState(() {
                              _applyFilters();
                            });
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 10),

                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        children: [
                          // Price Range Filter
                          const Text(
                            'Price Range (per day)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          RangeSlider(
                            values: _priceRange,
                            min: 0,
                            max: 10000,
                            divisions: 100,
                            labels: RangeLabels(
                              '₹${_priceRange.start.round()}',
                              '₹${_priceRange.end.round()}',
                            ),
                            onChanged: (values) {
                              setModalState(() {
                                _priceRange = values;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('₹${_priceRange.start.round()}'),
                                Text('₹${_priceRange.end.round()}'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Rating Filter
                          const Text(
                            'Minimum Rating',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Slider(
                            value: _minRating,
                            min: 0,
                            max: 5,
                            divisions: 10,
                            label: _minRating.toStringAsFixed(1),
                            onChanged: (value) {
                              setModalState(() {
                                _minRating = value;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('0.0'),
                                Text('${_minRating.toStringAsFixed(1)} ⭐'),
                                const Text('5.0'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Amenities Filter
                          const Text(
                            'Amenities',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: _allAmenities.map((amenity) {
                              final isSelected = _selectedAmenities.contains(
                                amenity,
                              );
                              return FilterChip(
                                label: Text(
                                  amenity.toUpperCase(),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                                selected: isSelected,
                                selectedColor: Colors.blue,
                                onSelected: (selected) {
                                  setModalState(() {
                                    if (selected) {
                                      _selectedAmenities.add(amenity);
                                    } else {
                                      _selectedAmenities.remove(amenity);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 30),

                          // Sort By
                          const Text(
                            'Sort By',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              RadioListTile(
                                title: const Text('None'),
                                value: 'none',
                                groupValue: _sortBy,
                                onChanged: (value) {
                                  setModalState(() {
                                    _sortBy = value!;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Price: Low to High'),
                                value: 'price_low',
                                groupValue: _sortBy,
                                onChanged: (value) {
                                  setModalState(() {
                                    _sortBy = value!;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Price: High to Low'),
                                value: 'price_high',
                                groupValue: _sortBy,
                                onChanged: (value) {
                                  setModalState(() {
                                    _sortBy = value!;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Rating: High to Low'),
                                value: 'rating',
                                groupValue: _sortBy,
                                onChanged: (value) {
                                  setModalState(() {
                                    _sortBy = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Apply Button
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _applyFilters();
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Apply Filters',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Farmhouses',style: TextStyle(fontWeight: FontWeight.bold),),
      leading: IconButton(onPressed: (){
        Navigator.of(context).pop();
      }, icon: Icon(Icons.arrow_back_ios)),
       elevation: 0),
      
      body: Column(
        children: [
          // Search Bar and Filter Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search farmhouses...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _hasSearched = false;
                                  _allFarmhouses = [];
                                  _filteredFarmhouses = [];
                                });
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    onSubmitted: _searchFarmhouses,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.white),
                    onPressed: _hasSearched ? _showFilterBottomSheet : null,
                  ),
                ),
              ],
            ),
          ),

          // Active Filters Display
          if (_hasSearched &&
              (_selectedAmenities.isNotEmpty ||
                  _minRating > 0 ||
                  _sortBy != 'none'))
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (_minRating > 0)
                    Chip(
                      label: Text('Rating ≥ ${_minRating.toStringAsFixed(1)}'),
                      onDeleted: () {
                        setState(() {
                          _minRating = 0.0;
                          _applyFilters();
                        });
                      },
                    ),
                  ..._selectedAmenities.map(
                    (amenity) => Chip(
                      label: Text(amenity),
                      onDeleted: () {
                        setState(() {
                          _selectedAmenities.remove(amenity);
                          _applyFilters();
                        });
                      },
                    ),
                  ),
                  if (_sortBy != 'none')
                    Chip(
                      label: Text('Sort: ${_getSortLabel()}'),
                      onDeleted: () {
                        setState(() {
                          _sortBy = 'none';
                          _applyFilters();
                        });
                      },
                    ),
                ],
              ),
            ),

          // Results Count
          if (_hasSearched && !_isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${_filteredFarmhouses.length} farmhouses found',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

          // Results List or Empty State
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(_errorMessage!),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () =>
                              _searchFarmhouses(_searchController.text),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : !_hasSearched
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 80, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'Search for farmhouses',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Enter a location or keyword to find farmhouses',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : _filteredFarmhouses.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No farmhouses found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your filters',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredFarmhouses.length,
                    itemBuilder: (context, index) {
                      final farmhouse = _filteredFarmhouses[index];
                      return FarmhouseCard(farmhouse: farmhouse);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _getSortLabel() {
    switch (_sortBy) {
      case 'price_low':
        return 'Price ↑';
      case 'price_high':
        return 'Price ↓';
      case 'rating':
        return 'Rating ↓';
      default:
        return '';
    }
  }
}

class FarmhouseCard extends StatelessWidget {
  final FarmhouseModel farmhouse;

  const FarmhouseCard({super.key, required this.farmhouse});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: farmhouse.images.isNotEmpty
                ? Image.network(
                    farmhouse.images[0],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 50),
                      );
                    },
                  )
                : Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.villa, size: 50),
                  ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        farmhouse.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          farmhouse.rating.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Address
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        farmhouse.address,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  farmhouse.description,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),

                // Amenities
                if (farmhouse.amenities.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: farmhouse.amenities.take(3).map((amenity) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          amenity.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 12),

                // Price and Booking
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹${farmhouse.pricePerDay}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          'per day',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),

                    // ElevatedButton(
                    //   onPressed: () {

                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseDetailScreen(id: farmhouse.id,)));
                    //     // Navigate to details or booking page
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 24,
                    //       vertical: 12,
                    //     ),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //   ),
                    //   child: const Text('Book Now'),
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
}

// Farmhouse Model
class FarmhouseModel {
  final String id;
  final String name;
  final List<String> images;
  final String address;
  final String description;
  final List<String> amenities;
  final int pricePerHour;
  final int pricePerDay;
  final double rating;
  final String feedbackSummary;

  FarmhouseModel({
    required this.id,
    required this.name,
    required this.images,
    required this.address,
    required this.description,
    required this.amenities,
    required this.pricePerHour,
    required this.pricePerDay,
    required this.rating,
    required this.feedbackSummary,
  });

  factory FarmhouseModel.fromJson(Map<String, dynamic> json) {
    return FarmhouseModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Unknown',
      images: List<String>.from(json['images'] ?? []),
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      amenities: List<String>.from(json['amenities'] ?? []),
      pricePerHour: json['pricePerHour'] ?? 0,
      pricePerDay: json['pricePerDay'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      feedbackSummary: json['feedbackSummary'] ?? '',
    );
  }
}
