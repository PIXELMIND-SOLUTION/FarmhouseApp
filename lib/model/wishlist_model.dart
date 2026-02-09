// wishlist_model.dart

import 'package:farmhouse_app/views/models/farmhouse_model.dart';

class FarmhouseModel {
  final String id;
  final String name;
  final List<String> images;
  final String address;
  final String description;
  final List<String> amenities;
  final String bookingFor;
  final double pricePerHour;
  final double pricePerDay;
  final double rating;
  final String? feedbackSummary;
  final double latitude;
  final double longitude;

  FarmhouseModel({
    required this.id,
    required this.name,
    required this.images,
    required this.address,
    required this.description,
    required this.amenities,
    required this.bookingFor,
    required this.pricePerHour,
    required this.pricePerDay,
    required this.rating,
    this.feedbackSummary,
    required this.latitude,
    required this.longitude,
  });

  // Add this method inside FarmhouseModel class
Farmhouse toFarmhouse() {
  return Farmhouse(
    id: id,
    name: name,
    images: images,
    address: address,
    description: description,
    amenities: amenities,
    bookingFor: bookingFor,
    pricePerHour: pricePerHour,
    pricePerDay: pricePerDay,
    timePrices: [], // Empty list if not available in wishlist
    rating: rating,
    feedbackSummary: feedbackSummary ?? '',
    location: Location(
      type: 'Point',
      coordinates: [longitude, latitude],
    ),
    wishlist: [],
    reviews: [],
    bookedSlots: [],
    createdAt: '',
  );
}

  factory FarmhouseModel.fromJson(Map<String, dynamic> json) {
    final location = json['location'] as Map<String, dynamic>;
    final coordinates = location['coordinates'] as List<dynamic>;

    return FarmhouseModel(
      id: json['_id'],
      name: json['name'],
      images: List<String>.from(json['images']),
      address: json['address'],
      description: json['description'],
      amenities: List<String>.from(json['amenities']),
      bookingFor: json['bookingFor'],
      pricePerHour: (json['pricePerHour'] as num).toDouble(),
      pricePerDay: (json['pricePerDay'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      feedbackSummary: json['feedbackSummary'],
      longitude: (coordinates[0] as num).toDouble(),
      latitude: (coordinates[1] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'images': images,
      'address': address,
      'description': description,
      'amenities': amenities,
      'bookingFor': bookingFor,
      'pricePerHour': pricePerHour,
      'pricePerDay': pricePerDay,
      'rating': rating,
      'feedbackSummary': feedbackSummary,
      'location': {
        'type': 'Point',
        'coordinates': [longitude, latitude],
      },
    };
  }
}

class WishlistResponseModel {
  final bool success;
  final int count;
  final List<FarmhouseModel> data;

  WishlistResponseModel({
    required this.success,
    required this.count,
    required this.data,
  });

  factory WishlistResponseModel.fromJson(Map<String, dynamic> json) {
    return WishlistResponseModel(
      success: json['success'],
      count: json['count'],
      data: (json['data'] as List<dynamic>)
          .map((item) => FarmhouseModel.fromJson(item))
          .toList(),
    );
  }
}

class WishlistToggleResponseModel {
  final bool success;
  final String message;

  WishlistToggleResponseModel({
    required this.success,
    required this.message,
  });

  factory WishlistToggleResponseModel.fromJson(Map<String, dynamic> json) {
    return WishlistToggleResponseModel(
      success: json['success'],
      message: json['message'],
    );
  }
}